using System;
using System.Collections.Generic;
using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public class CapsuleOcclusionPass : ScriptableRenderPass
{
	[Serializable]
	public class CapsuleData
	{
		public Vector4 data;

		public Vector4 directHeight;
	}

	private static class shaderID
	{
		public static int targetResolutionID = Shader.PropertyToID("_CapsuleTargetResolution");

		public static int MainCapsuleDataID = Shader.PropertyToID("_MainCapsuleData");

		public static int MainCapsuleDirID = Shader.PropertyToID("_MainCapsuleDir");

		public static int SubCapsuleDataID = Shader.PropertyToID("_SubCapsuleData");

		public static int SubCapsuleDirID = Shader.PropertyToID("_SubCapsuleDir");

		public static int RTID = Shader.PropertyToID("_CapsuleOcclusionRT");

		public static int TexID = Shader.PropertyToID("_CapsuleOcclusionTex");

		public static int LightDataID = Shader.PropertyToID("_LightData");

		public static int IntensityDataID = Shader.PropertyToID("_IntensityData");

		public static int TileCountsID = Shader.PropertyToID("_CapsuleTileCounts");

		public static int TileIndicesID = Shader.PropertyToID("_CapsuleTileIndices");

		public static int TileDataID = Shader.PropertyToID("_CapsuleTileData");
	}

	private ComputeShader m_capsuleOcclusionCS;

	private static List<CapsuleData> _MainCapsuleList;

	private static List<CapsuleData> _SubCapsuleList;

	private Vector4[] MainCapsuleData;

	private Vector4[] MainCapsuleDir;

	private Vector4[] SubCapsuleData;

	private Vector4[] SubCapsuleDir;

	private const int kTileSize = 16;

	private const int kMaxCapsulesPerTile = 256;

	private const int kTileKernelGroupSize = 64;

	private ComputeBuffer m_CapsuleTileCounts;

	private ComputeBuffer m_CapsuleTileIndices;

	private int m_TileCountX;

	private int m_TileCountY;

	private int m_TileBufferCount;

	private int m_TileIndexBufferCount;

	private int m_ClearTileKernel;

	private int m_BuildTileKernel;

	private int m_CalculateOcclusionKernel;

	private bool m_enable;

	private float m_downSampleScale;

	private static Vector3 m_MainCharPosition;

	private CapsuleAOFeature.Settings m_Settings;

	internal static bool HasAnyValidCapsules()
	{
		if (!ContainsValidCapsule(_MainCapsuleList))
		{
			return ContainsValidCapsule(_SubCapsuleList);
		}
		return true;
	}

	private static bool ContainsValidCapsule(List<CapsuleData> capsules)
	{
		for (int i = 0; i < capsules.Count; i++)
		{
			if (capsules[i] != null)
			{
				return true;
			}
		}
		return false;
	}

	public static void addToMainList(CapsuleData data)
	{
		if (data != null)
		{
			_MainCapsuleList.Add(data);
		}
	}

	public static void removeFromMainList(CapsuleData data)
	{
		_MainCapsuleList.Remove(data);
	}

	public static bool ContainInMainList(CapsuleData data)
	{
		return _MainCapsuleList.Contains(data);
	}

	public static void addToSubList(CapsuleData data)
	{
		if (data != null)
		{
			_SubCapsuleList.Add(data);
		}
	}

	public static void removeFromSubList(CapsuleData data)
	{
		_SubCapsuleList.Remove(data);
	}

	public static void setMainCharPos(Vector3 pos)
	{
		m_MainCharPosition = pos;
	}

	static CapsuleOcclusionPass()
	{
		_MainCapsuleList = new List<CapsuleData>();
		_SubCapsuleList = new List<CapsuleData>();
	}

	public CapsuleOcclusionPass(ComputeShader capsuleOcclusionCS, CapsuleAOFeature.Settings settings)
	{
		profilingSampler = new ProfilingSampler("CapsuleOcclusionPass");
		m_Settings = settings;
		m_capsuleOcclusionCS = capsuleOcclusionCS;
		renderPassEvent = RenderPassEvent.CapsuleOcclusionPass;
		MainCapsuleData = new Vector4[128];
		MainCapsuleDir = new Vector4[128];
		SubCapsuleData = new Vector4[128];
		SubCapsuleDir = new Vector4[128];
		m_ClearTileKernel = m_capsuleOcclusionCS.FindKernel("ClearCapsuleTileCounts");
		m_BuildTileKernel = m_capsuleOcclusionCS.FindKernel("BuildCapsuleTileList");
		m_CalculateOcclusionKernel = m_capsuleOcclusionCS.FindKernel("CalculateOcclusion");
		targetCount = 0u;
	}

	public void Release()
	{
		if (m_CapsuleTileCounts != null)
		{
			m_CapsuleTileCounts.Release();
			m_CapsuleTileCounts = null;
		}
		if (m_CapsuleTileIndices != null)
		{
			m_CapsuleTileIndices.Release();
			m_CapsuleTileIndices = null;
		}
		m_TileBufferCount = 0;
		m_TileIndexBufferCount = 0;
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		cmd.ReleaseTemporaryRT(shaderID.RTID);
	}

	private bool checkCharLightLayer(int layerMask)
	{
		if ((layerMask & 2) > 0 || (layerMask & 0x10) > 0 || (layerMask & 0x20) > 0)
		{
			return (layerMask & 1) > 0;
		}
		return false;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			m_downSampleScale = m_Settings.DownSample;
			float num = 0f;
			Vector3 zero = Vector3.zero;
			PreparedLightFrameData preparedLights = renderingData.lightData.preparedLights;
			PreparedVisibleLight[] array = preparedLights?.visibleLights;
			int num2 = preparedLights?.visibleLightCount ?? 0;
			for (int i = 0; i < num2; i++)
			{
				ref PreparedVisibleLight reference = ref array[i];
				if (checkCharLightLayer(reference.layerMask) || reference.lightType == LightType.Directional)
				{
					float num3 = 1f;
					Vector3 vector;
					if (reference.lightType == LightType.Directional)
					{
						vector = new Vector3(0f - reference.position.x, 0f - reference.position.y, 0f - reference.position.z);
						num3 = 1f;
					}
					else
					{
						Vector3 vector2 = m_MainCharPosition - new Vector3(reference.position.x, reference.position.y, reference.position.z);
						vector = vector2.normalized;
						num3 = MathF.Min(2f, 1f / vector2.sqrMagnitude);
						num3 = 0f;
					}
					Vector3 lhs = new Vector3(reference.color.x, reference.color.y, reference.color.z);
					num3 *= Vector3.Dot(lhs, new Vector3(0.3f, 0.6f, 0.1f));
					zero += num3 * vector;
					num += num3;
				}
			}
			zero /= Mathf.Max(0.001f, num);
			int num4 = CopyValidCapsules(_MainCapsuleList, MainCapsuleData, MainCapsuleDir);
			int num5 = CopyValidCapsules(_SubCapsuleList, SubCapsuleData, SubCapsuleDir);
			cmd.SetGlobalVectorArray(shaderID.MainCapsuleDataID, MainCapsuleData);
			cmd.SetGlobalVectorArray(shaderID.MainCapsuleDirID, MainCapsuleDir);
			cmd.SetGlobalVectorArray(shaderID.SubCapsuleDataID, SubCapsuleData);
			cmd.SetGlobalVectorArray(shaderID.SubCapsuleDirID, SubCapsuleDir);
			RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
			int width = cameraTargetDescriptor.width;
			int height = cameraTargetDescriptor.height;
			width = (int)((float)width / m_downSampleScale);
			height = (int)((float)height / m_downSampleScale);
			EnsureTileBuffers(width, height);
			cmd.GetTemporaryRT(shaderID.RTID, width, height, 0, FilterMode.Bilinear, GraphicsFormat.R8G8_UNorm, 1, enableRandomWrite: true);
			cmd.SetComputeVectorParam(m_capsuleOcclusionCS, shaderID.targetResolutionID, new Vector4(width, height, num4, num5));
			cmd.SetComputeVectorParam(m_capsuleOcclusionCS, shaderID.TileDataID, new Vector4(m_TileCountX, m_TileCountY, 16f, 256f));
			zero = zero.normalized;
			cmd.SetComputeVectorParam(m_capsuleOcclusionCS, shaderID.LightDataID, new Vector4(0f - zero.x, 0f - zero.y, 0f - zero.z, m_Settings.LightAngle * (MathF.PI / 180f)));
			cmd.SetComputeVectorParam(m_capsuleOcclusionCS, shaderID.IntensityDataID, new Vector4(m_Settings.AOIntensity, m_Settings.DirOcclusionIntensity, 0f, 0f));
			cmd.SetComputeBufferParam(m_capsuleOcclusionCS, m_ClearTileKernel, shaderID.TileCountsID, m_CapsuleTileCounts);
			cmd.DispatchCompute(m_capsuleOcclusionCS, m_ClearTileKernel, Mathf.CeilToInt((float)m_TileBufferCount / 64f), 1, 1);
			int num6 = num4 + num5;
			if (num6 > 0)
			{
				cmd.SetComputeBufferParam(m_capsuleOcclusionCS, m_BuildTileKernel, shaderID.TileCountsID, m_CapsuleTileCounts);
				cmd.SetComputeBufferParam(m_capsuleOcclusionCS, m_BuildTileKernel, shaderID.TileIndicesID, m_CapsuleTileIndices);
				cmd.DispatchCompute(m_capsuleOcclusionCS, m_BuildTileKernel, Mathf.CeilToInt((float)num6 / 64f), 1, 1);
			}
			cmd.SetComputeBufferParam(m_capsuleOcclusionCS, m_CalculateOcclusionKernel, shaderID.TileCountsID, m_CapsuleTileCounts);
			cmd.SetComputeBufferParam(m_capsuleOcclusionCS, m_CalculateOcclusionKernel, shaderID.TileIndicesID, m_CapsuleTileIndices);
			cmd.SetComputeTextureParam(m_capsuleOcclusionCS, m_CalculateOcclusionKernel, shaderID.RTID, shaderID.RTID);
			cmd.DispatchCompute(m_capsuleOcclusionCS, m_CalculateOcclusionKernel, Mathf.CeilToInt((float)width / 8f), Mathf.CeilToInt((float)height / 8f), 1);
			cmd.SetGlobalTexture(shaderID.TexID, shaderID.RTID);
		}
	}

	private static int CopyValidCapsules(List<CapsuleData> source, Vector4[] capsuleData, Vector4[] capsuleDir)
	{
		int num = 0;
		for (int i = 0; i < source.Count; i++)
		{
			if (num >= capsuleData.Length)
			{
				break;
			}
			CapsuleData capsuleData2 = source[i];
			if (capsuleData2 != null)
			{
				capsuleData[num] = capsuleData2.data;
				capsuleDir[num] = capsuleData2.directHeight;
				num++;
			}
		}
		return num;
	}

	private void EnsureTileBuffers(int width, int height)
	{
		m_TileCountX = Mathf.CeilToInt((float)width / 16f);
		m_TileCountY = Mathf.CeilToInt((float)height / 16f);
		int num = Mathf.Max(1, m_TileCountX * m_TileCountY);
		int num2 = num * 256;
		if (m_CapsuleTileCounts == null || m_TileBufferCount != num || m_TileIndexBufferCount != num2)
		{
			Release();
			m_CapsuleTileCounts = new ComputeBuffer(num, 4);
			m_CapsuleTileIndices = new ComputeBuffer(num2, 4);
			m_TileBufferCount = num;
			m_TileIndexBufferCount = num2;
		}
	}
}
