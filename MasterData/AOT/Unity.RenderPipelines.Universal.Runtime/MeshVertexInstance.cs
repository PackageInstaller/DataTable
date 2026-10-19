using UnityEngine;

[ExecuteAlways]
public class MeshVertexInstance : MonoBehaviour
{
	private struct VertexPosition
	{
		private Vector3 position;
	}

	private static readonly int VertexPositionBufferID = Shader.PropertyToID("_vertexPositionBuffer");

	private static readonly int BaseTransformID = Shader.PropertyToID("_BaseTransform");

	private static readonly int PointSizeID = Shader.PropertyToID("_PointSize");

	public Mesh InstanceMesh;

	public Material InstanceMaterial;

	[Range(0f, 1f)]
	public float Size = 0.1f;

	private Mesh TargetMesh;

	private ComputeBuffer DrawBuffer;

	private ComputeBuffer ArgsBuffer;

	private MaterialPropertyBlock m_PropertyBlock;

	private readonly Vector3[] m_LocalBoundsCorners = new Vector3[8];

	private uint[] argsData;

	private Bounds GetWorldBounds(Mesh mesh)
	{
		Bounds bounds = mesh.bounds;
		Vector3[] localBoundsCorners = GetLocalBoundsCorners(bounds);
		return CalculateWorldBounds(localBoundsCorners);
	}

	private Vector3[] GetLocalBoundsCorners(Bounds bounds)
	{
		Vector3 center = bounds.center;
		Vector3 extents = bounds.extents;
		Vector3[] localBoundsCorners = m_LocalBoundsCorners;
		localBoundsCorners[0] = center + new Vector3(0f - extents.x, 0f - extents.y, 0f - extents.z);
		localBoundsCorners[1] = center + new Vector3(extents.x, 0f - extents.y, 0f - extents.z);
		localBoundsCorners[2] = center + new Vector3(0f - extents.x, extents.y, 0f - extents.z);
		localBoundsCorners[3] = center + new Vector3(extents.x, extents.y, 0f - extents.z);
		localBoundsCorners[4] = center + new Vector3(0f - extents.x, 0f - extents.y, extents.z);
		localBoundsCorners[5] = center + new Vector3(extents.x, 0f - extents.y, extents.z);
		localBoundsCorners[6] = center + new Vector3(0f - extents.x, extents.y, extents.z);
		localBoundsCorners[7] = center + new Vector3(extents.x, extents.y, extents.z);
		return localBoundsCorners;
	}

	private Bounds CalculateWorldBounds(Vector3[] localCorners)
	{
		if (localCorners == null || localCorners.Length == 0)
		{
			return default;
		}
		Vector3 vector2;
		Vector3 vector = (vector2 = transform.TransformPoint(localCorners[0]));
		foreach (Vector3 position in localCorners)
		{
			Vector3 rhs = transform.TransformPoint(position);
			vector2 = Vector3.Min(vector2, rhs);
			vector = Vector3.Max(vector, rhs);
		}
		Bounds result = default;
		result.SetMinMax(vector2, vector);
		return result;
	}

	private void OnEnable()
	{
		if (m_PropertyBlock == null)
		{
			m_PropertyBlock = new MaterialPropertyBlock();
		}
		if (InstanceMesh != null && InstanceMaterial != null)
		{
			TargetMesh = GetComponent<MeshFilter>().sharedMesh;
			if (TargetMesh != null)
			{
				DrawBuffer = new ComputeBuffer(TargetMesh.vertexCount, 12);
				argsData = new uint[5];
				argsData[0] = InstanceMesh.GetIndexCount(0);
				argsData[1] = (uint)TargetMesh.vertexCount;
				argsData[2] = InstanceMesh.GetIndexStart(0);
				argsData[3] = InstanceMesh.GetBaseVertex(0);
				argsData[4] = 0u;
				ArgsBuffer = new ComputeBuffer(1, argsData.Length * 4, ComputeBufferType.DrawIndirect);
				ArgsBuffer.SetData(argsData);
				DrawBuffer.SetData(TargetMesh.vertices);
			}
		}
	}

	private void Update()
	{
		if (TargetMesh != null)
		{
			MaterialPropertyBlock propertyBlock = m_PropertyBlock;
			propertyBlock.Clear();
			propertyBlock.SetBuffer(VertexPositionBufferID, DrawBuffer);
			propertyBlock.SetMatrix(BaseTransformID, transform.localToWorldMatrix);
			propertyBlock.SetFloat(PointSizeID, Size);
			Bounds bounds = default;
			bounds = GetWorldBounds(InstanceMesh);
			Graphics.DrawMeshInstancedIndirect(InstanceMesh, 0, InstanceMaterial, bounds, ArgsBuffer, 0, propertyBlock);
		}
	}

	private void OnDisable()
	{
		if (DrawBuffer != null)
		{
			DrawBuffer.Release();
		}
		if (ArgsBuffer != null)
		{
			ArgsBuffer.Release();
		}
	}
}
