using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public class GeometryEffect : MonoBehaviour
{
	private struct lineMeshData
	{
		public Vector3 position;
	}

	private struct baseMeshData
	{
		public Vector3 position;
	}

	private struct linePointIndex
	{
		public int frontIndex;

		public int lastIndex;
	}

	public ComputeShader cs;

	[Range(0f, 0.1f)]
	public float LineWidth;

	public Mesh usedMesh;

	public Mesh pointMesh;

	public Material pointMaterial;

	public float pointSize = 1f;

	private MeshFilter meshFilter;

	public Vector3 NoiseScale = new Vector3(1f, 1f, 1f);

	public Vector3 NoiseOffset = new Vector3(0f, 0f, 0f);

	public Vector3 NoiseIntensity = new Vector3(0.1f, 0.1f, 0.1f);

	private Mesh baseMesh;

	private Mesh lineMesh;

	private Vector4[] baseVertices;

	private Vector3[] vertices;

	private Vector2[] uv;

	private int[] triangles;

	private linePointIndex[] lineList;

	private ComputeBuffer baseMeshOriginal;

	private ComputeBuffer baseMeshBuffer;

	private ComputeBuffer lineMeshBuffer;

	private ComputeBuffer lineBuffer;

	private ComputeBuffer argsBuffers;

	private uint[] args = new uint[5];

	private AsyncGPUReadbackRequest asyncGPUReadbackRequest;

	private AsyncGPUReadbackRequest asyncGPUReadbackRequestVertexAni;

	private int kernelIndexBuildLine;

	private int kernelIndexVertexAni;

	private bool DataReceived;

	private void OnEnable()
	{
		meshFilter = GetComponent<MeshFilter>();
		if (!meshFilter)
		{
			meshFilter = gameObject.AddComponent<MeshFilter>();
		}
		if ((bool)usedMesh)
		{
			baseMesh = new Mesh();
			baseMesh.vertices = usedMesh.vertices;
			baseMesh.triangles = usedMesh.triangles;
		}
		lineMesh = new Mesh();
		baseVertices = new Vector4[baseMesh.vertices.Length];
		vertices = new Vector3[baseMesh.triangles.Length * 4];
		uv = new Vector2[baseMesh.triangles.Length * 4];
		triangles = new int[baseMesh.triangles.Length * 2 * 3];
		lineList = new linePointIndex[baseMesh.triangles.Length];
		for (int i = 0; i < baseMesh.triangles.Length; i++)
		{
			triangles[i * 6] = i * 4;
			triangles[i * 6 + 1] = i * 4 + 1;
			triangles[i * 6 + 2] = i * 4 + 2;
			triangles[i * 6 + 3] = i * 4;
			triangles[i * 6 + 4] = i * 4 + 2;
			triangles[i * 6 + 5] = i * 4 + 3;
			uv[i * 4] = new Vector2(0f, 0f);
			uv[i * 4 + 1] = new Vector2(0f, 1f);
			uv[i * 4 + 2] = new Vector2(1f, 1f);
			uv[i * 4 + 3] = new Vector2(1f, 0f);
		}
		for (int j = 0; j < baseMesh.triangles.Length / 3; j++)
		{
			lineList[j * 3].frontIndex = baseMesh.triangles[j * 3];
			lineList[j * 3].lastIndex = baseMesh.triangles[j * 3 + 1];
			lineList[j * 3 + 1].frontIndex = baseMesh.triangles[j * 3 + 1];
			lineList[j * 3 + 1].lastIndex = baseMesh.triangles[j * 3 + 2];
			lineList[j * 3 + 2].frontIndex = baseMesh.triangles[j * 3 + 2];
			lineList[j * 3 + 2].lastIndex = baseMesh.triangles[j * 3];
		}
		for (int k = 0; k < baseMesh.vertices.Length; k++)
		{
			baseVertices[k] = baseMesh.vertices[k];
		}
		lineMesh.vertices = vertices;
		lineMesh.uv = uv;
		lineMesh.triangles = triangles;
		baseMeshOriginal = new ComputeBuffer(baseMesh.vertices.Length, 16);
		baseMeshBuffer = new ComputeBuffer(baseMesh.vertices.Length, 16);
		lineMeshBuffer = new ComputeBuffer(lineMesh.vertices.Length, 12);
		lineBuffer = new ComputeBuffer(baseMesh.triangles.Length, 8);
		argsBuffers = new ComputeBuffer(1, args.Length * 4, ComputeBufferType.DrawIndirect);
		args[0] = pointMesh.GetIndexCount(0);
		args[1] = (uint)baseMesh.vertexCount;
		args[2] = pointMesh.GetIndexStart(0);
		args[3] = pointMesh.GetBaseVertex(0);
		argsBuffers.SetData(args);
		baseMeshBuffer.SetData(baseVertices);
		lineBuffer.SetData(lineList);
		baseMeshOriginal.SetData(baseVertices);
		kernelIndexBuildLine = cs.FindKernel("MeshCreat");
		kernelIndexVertexAni = cs.FindKernel("VertexAni");
		cs.SetBuffer(kernelIndexBuildLine, "_lineMeshData", lineMeshBuffer);
		cs.SetBuffer(kernelIndexBuildLine, "_baseMeshData", baseMeshBuffer);
		cs.SetBuffer(kernelIndexBuildLine, "_linePointIndex", lineBuffer);
		cs.SetMatrix("_M_Matrix", transform.localToWorldMatrix);
		cs.SetBuffer(kernelIndexVertexAni, "_baseMeshData", baseMeshBuffer);
		cs.SetBuffer(kernelIndexVertexAni, "_baseMeshOriginal", baseMeshOriginal);
		pointMaterial.SetBuffer("_positionBuffer", baseMeshBuffer);
	}

	private void Update()
	{
		if (!DataReceived)
		{
			Vector3 position = Camera.main.transform.position;
			Vector4 val = transform.worldToLocalMatrix * new Vector4(position.x, position.y, position.z, 1f);
			cs.SetFloat("_time", Time.time);
			cs.SetVector("_noiseScale", NoiseScale);
			cs.SetVector("_noiseOffset", NoiseOffset);
			cs.SetVector("_noiseIntensity", NoiseIntensity);
			cs.Dispatch(kernelIndexVertexAni, baseVertices.Length, 1, 1);
			cs.SetVector("_cameraPos", val);
			cs.SetFloat("_width", LineWidth);
			cs.Dispatch(kernelIndexBuildLine, lineList.Length, 1, 1);
			asyncGPUReadbackRequest = AsyncGPUReadback.Request(lineMeshBuffer);
			asyncGPUReadbackRequestVertexAni = AsyncGPUReadback.Request(baseMeshBuffer);
			DataReceived = true;
		}
		if (asyncGPUReadbackRequest.done && asyncGPUReadbackRequestVertexAni.done)
		{
			DataReceived = false;
			if (!asyncGPUReadbackRequest.hasError)
			{
				asyncGPUReadbackRequest.GetData<Vector3>().CopyTo(vertices);
			}
			if (!asyncGPUReadbackRequestVertexAni.hasError)
			{
				asyncGPUReadbackRequestVertexAni.GetData<Vector4>().CopyTo(baseVertices);
			}
			lineMesh.vertices = vertices;
			lineMesh.RecalculateBounds();
			meshFilter.mesh = lineMesh;
		}
		pointMaterial.SetFloat("_pointSize", pointSize);
		pointMaterial.SetMatrix("_O2W_I_Matrix", transform.worldToLocalMatrix);
		pointMaterial.SetMatrix("_O2W_Matrix", transform.localToWorldMatrix);
		Graphics.DrawMeshInstancedIndirect(pointMesh, 0, pointMaterial, new Bounds(transform.position, new Vector3(1f, 1f, 1f)), argsBuffers);
	}

	private void OnDisable()
	{
		baseMeshOriginal.Release();
		baseMeshBuffer.Release();
		lineMeshBuffer.Release();
		lineBuffer.Release();
		argsBuffers.Release();
	}
}
