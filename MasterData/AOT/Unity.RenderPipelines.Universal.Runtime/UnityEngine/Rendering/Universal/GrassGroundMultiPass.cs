using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

[ExecuteAlways]
public class GrassGroundMultiPass : MonoBehaviour
{
	public class GrassGroundData
	{
		public Mesh mesh;

		public Material mat;

		public int time;

		public Matrix4x4 ObjectToWorldMatrix;

		public ComputeBuffer argsBuffer;

		public bool useLightMap;

		public Vector4 lightMapOffset;

		public Texture2D lightMap;
	}

	public static List<GrassGroundData> GrassGroundList = new List<GrassGroundData>();

	public Material mat;

	[Range(1f, 100f)]
	public int LayerCount;

	private ComputeBuffer m_buffer;

	private GrassGroundData m_thisGround;

	private bool m_isActive;

	private Transform m_trans;

	private MeshFilter m_meshFilter;

	private Mesh m_mesh;

	private MeshRenderer m_renderer;

	private static GlobalKeyword lightMapKeyWord;

	private static int lightOffsetTagID = Shader.PropertyToID("unity_LightmapST");

	private static int lightMapTagID = Shader.PropertyToID("unity_Lightmap");

	private static int instanceMatrixTagID = Shader.PropertyToID("_Instance_M_Matrix");

	private static int multiPassCountTagID = Shader.PropertyToID("_multiPassCount");

	private void OnEnable()
	{
		lightMapKeyWord = GlobalKeyword.Create("LIGHTMAP_ON");
		m_trans = transform;
		m_renderer = GetComponent<MeshRenderer>();
		m_meshFilter = GetComponent<MeshFilter>();
		m_thisGround = new GrassGroundData();
		m_thisGround.mat = mat;
		m_mesh = m_meshFilter.sharedMesh;
		m_thisGround.mesh = m_mesh;
		m_thisGround.ObjectToWorldMatrix = m_trans.localToWorldMatrix;
		m_thisGround.useLightMap = m_renderer.lightmapIndex >= 0;
		m_thisGround.lightMapOffset = m_renderer.lightmapScaleOffset;
		if (m_thisGround.useLightMap)
		{
			m_thisGround.lightMap = LightmapSettings.lightmaps[m_renderer.lightmapIndex].lightmapColor;
		}
		uint[] array = new uint[5]
		{
			m_mesh.GetIndexCount(0),
			(uint)Mathf.Max(1, LayerCount),
			m_mesh.GetIndexStart(0),
			m_mesh.GetBaseVertex(0),
			0u
		};
		m_buffer = new ComputeBuffer(5, array.Length * 4, ComputeBufferType.DrawIndirect);
		m_buffer.SetData(array);
		m_thisGround.argsBuffer = m_buffer;
	}

	private void OnValidate()
	{
		if (m_mesh != null && m_buffer != null && enabled)
		{
			uint[] data = new uint[5]
			{
				m_mesh.GetIndexCount(0),
				(uint)Mathf.Max(1, LayerCount),
				m_mesh.GetIndexStart(0),
				m_mesh.GetBaseVertex(0),
				0u
			};
			m_buffer.SetData(data);
		}
	}

	private void Update()
	{
		if (m_renderer.isVisible && m_renderer.enabled)
		{
			m_thisGround.ObjectToWorldMatrix = m_trans.localToWorldMatrix;
			m_thisGround.mat = mat;
			m_thisGround.time = LayerCount;
			if (!m_isActive)
			{
				GrassGroundList.Add(m_thisGround);
				m_isActive = true;
			}
		}
		else if (m_isActive)
		{
			GrassGroundList.Remove(m_thisGround);
			m_isActive = false;
		}
	}

	private void OnDisable()
	{
		if (m_isActive)
		{
			GrassGroundList.Remove(m_thisGround);
		}
		m_isActive = false;
		m_buffer.Release();
	}

	public static void DrawGrassMultiLayer(CommandBuffer cmd, int pass)
	{
		List<GrassGroundData> grassGroundList = GrassGroundList;
		int count = grassGroundList.Count;
		if (count == 0)
		{
			return;
		}
		for (int i = 0; i < count; i++)
		{
			GrassGroundData grassGroundData = grassGroundList[i];
			if ((bool)grassGroundData.mat)
			{
				if (grassGroundData.useLightMap)
				{
					cmd.SetKeyword(in lightMapKeyWord, value: true);
					cmd.SetGlobalVector(lightOffsetTagID, grassGroundData.lightMapOffset);
					cmd.SetGlobalTexture(lightMapTagID, grassGroundData.lightMap);
				}
				else
				{
					cmd.SetKeyword(in lightMapKeyWord, value: false);
				}
				cmd.SetGlobalMatrix(instanceMatrixTagID, grassGroundData.ObjectToWorldMatrix);
				cmd.SetGlobalInteger(multiPassCountTagID, grassGroundData.time);
				ComputeBuffer argsBuffer = grassGroundData.argsBuffer;
				cmd.DrawMeshInstancedIndirect(grassGroundData.mesh, 0, grassGroundData.mat, pass, argsBuffer, 0);
			}
		}
	}
}
