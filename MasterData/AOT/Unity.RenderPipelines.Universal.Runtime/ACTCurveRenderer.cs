using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[ExecuteAlways]
public class ACTCurveRenderer : MonoBehaviour
{
	[Serializable]
	public class EditableCurvePoint
	{
		public Vector3 localPosition;

		public Vector3 localNormal = Vector3.up;

		[Min(0f)]
		public float radius = 0.1f;

		[ColorUsage(true, true)]
		public Color color = Color.white;

		public EditableCurvePoint()
		{
		}

		public EditableCurvePoint(Vector3 position, float pointRadius)
		{
			localPosition = position;
			radius = pointRadius;
		}
	}

	[Serializable]
	public class CurveData
	{
		[Serializable]
		public struct CurvePoint
		{
			public Vector3 position;

			public Vector3 normal;

			public Vector3 direction;

			public Vector4 color;

			public float factor;

			public float radius;
		}

		public int pointCount;

		public int subDivide;

		public float alpha;

		public int meshResolution;

		public float FactorScale;

		public Bounds bounds;

		public CurvePoint[] points;
	}

	private const string CommandBufferName = "CurveUpdate";

	private const float MinFactorScale = 0.0001f;

	[HideInInspector]
	public Material material;

	public List<Material> materials = new List<Material>();

	[SerializeField]
	[HideInInspector]
	[Min(1f)]
	private int m_SubDivide = 4;

	[Min(2f)]
	[HideInInspector]
	[SerializeField]
	private int m_MeshResolution = 4;

	[SerializeField]
	[Min(1f)]
	[HideInInspector]
	private int m_RibbonDirectionSubdivide = 1;

	[SerializeField]
	[Range(0f, 1f)]
	private float m_Alpha = 1f;

	[SerializeField]
	[Min(0f)]
	private float m_DefaultRadius = 0.1f;

	[SerializeField]
	private bool m_DrawGizmos = true;

	[SerializeField]
	private bool m_ShowSceneHandles = true;

	[SerializeField]
	private Color m_GizmoColor = new Color(0.25f, 0.75f, 1f, 0.85f);

	[SerializeField]
	private List<EditableCurvePoint> m_Points = new List<EditableCurvePoint>();

	public bool DoNotRefresh;

	public bool billboardNormal;

	public Camera billboardCamera;

	[NonSerialized]
	public CurveData curveData;

	private readonly List<Material> m_LastMaterials = new List<Material>();

	private readonly List<Material> m_DrawMaterials = new List<Material>();

	private bool m_MaterialsDirty = true;

	private ComputeBuffer m_DataBuffer;

	private ComputeBuffer m_SubDivideDataBuffer;

	private GraphicsBuffer m_IndexBuffer;

	private ComputeBuffer m_MeshBuffer;

	private ComputeShader m_CurveShader;

	private MaterialPropertyBlock m_Block;

	private int m_KernelCurveCreate = -1;

	private int m_KernelMeshCreate = -1;

	private bool m_KernelsReady;

	private int m_VertexIndexCount;

	private int m_BufferPointCount = -1;

	private int m_BufferSubDivide = -1;

	private int m_BufferMeshResolution = -1;

	private int m_BufferRibbonDirectionSubdivide = -1;

	private bool m_HasUploadedData;

	private bool m_CurveDataDirty = true;

	private bool m_HasLastLocalToWorldMatrix;

	private Matrix4x4 m_LastLocalToWorldMatrix;

	private readonly CurveData m_RuntimeCurveData = new CurveData();

	private CurveData.CurvePoint[] m_RuntimePoints;

	private EditableCurvePoint[] m_SmoothTempPoints;

	private EditableCurvePoint[] m_SmoothCorrectionPoints;

	private EditableCurvePoint[] m_SmoothAnchorPoints;

	private bool m_HasSmoothAnchor;

	private int m_LastValidatedPointSignature;

	private bool m_HasValidatedPointSignature;

	private static readonly int GlobalCurveBufferTag = Shader.PropertyToID("_GlobalCurveBuffer");

	private static readonly int CurveDataTag = Shader.PropertyToID("_CurveData");

	private static readonly int CurveDataTag2 = Shader.PropertyToID("_CurveData2");

	private static readonly int CurveRibbonDirectionSubdivideTag = Shader.PropertyToID("_CurveRibbonDirectionSubdivide");

	private static readonly int UseActCurveTag = Shader.PropertyToID("_UseACTCurve");

	public int PointCount
	{
		get
		{
			if (m_Points == null)
			{
				return 0;
			}
			return m_Points.Count;
		}
	}

	public int SubDivide => m_SubDivide;

	public int MeshResolution => m_MeshResolution;

	public float Alpha => m_Alpha;

	public bool DrawGizmos => m_DrawGizmos;

	public bool ShowSceneHandles => m_ShowSceneHandles;

	public Color GizmoColor => m_GizmoColor;

	public int CurveMaterialCount => GetSourceMaterialSlotCount();

	public float RadiusWorldScale => GetRadiusScale();

	public void setDirt()
	{
		m_BufferPointCount = -1;
		m_BufferSubDivide = -1;
		m_BufferMeshResolution = -1;
		m_BufferRibbonDirectionSubdivide = -1;
		m_HasUploadedData = false;
		m_CurveDataDirty = true;
		m_MaterialsDirty = true;
		m_HasLastLocalToWorldMatrix = false;
	}

	public void SetMaterialsDirty()
	{
		m_MaterialsDirty = true;
	}

	public Material GetCurveMaterial(int index)
	{
		return GetSourceMaterial(index);
	}

	public Vector3 GetPointLocalPosition(int index)
	{
		EnsurePointList();
		return m_Points[index].localPosition;
	}

	public void SetPointLocalPosition(int index, Vector3 localPosition)
	{
		EnsurePointList();
		if (!(m_Points[index].localPosition == localPosition))
		{
			m_Points[index].localPosition = localPosition;
			MarkPointDataDirty();
		}
	}

	public Vector3 GetPointLocalNormal(int index)
	{
		EnsurePointList();
		Vector3 localNormal = m_Points[index].localNormal;
		if (!(localNormal.sqrMagnitude > 1E-06f))
		{
			return Vector3.up;
		}
		return localNormal.normalized;
	}

	public void SetPointLocalNormal(int index, Vector3 localNormal)
	{
		EnsurePointList();
		Vector3 vector = ((localNormal.sqrMagnitude > 1E-06f) ? localNormal.normalized : Vector3.up);
		if (!(m_Points[index].localNormal == vector))
		{
			m_Points[index].localNormal = vector;
			MarkPointDataDirty();
		}
	}

	public float GetPointRadius(int index)
	{
		EnsurePointList();
		return m_Points[index].radius;
	}

	public void SetPointRadius(int index, float radius)
	{
		EnsurePointList();
		radius = Mathf.Max(0f, radius);
		if (!Mathf.Approximately(m_Points[index].radius, radius))
		{
			m_Points[index].radius = radius;
			MarkPointDataDirty();
		}
	}

	public Vector3 GetPointWorldDirectionForEditor(int index)
	{
		EnsurePointList();
		Vector3 pointLocalDirection = GetPointLocalDirection(index);
		Vector3 vector = transform.TransformDirection(pointLocalDirection);
		if (!(vector.sqrMagnitude > 1E-06f))
		{
			return transform.right;
		}
		return vector.normalized;
	}

	public void AddPoint(Vector3 localPosition)
	{
		EnsurePointList();
		EditableCurvePoint editableCurvePoint = new EditableCurvePoint(localPosition, m_DefaultRadius);
		if (m_Points.Count > 0)
		{
			EditableCurvePoint editableCurvePoint2 = m_Points[m_Points.Count - 1];
			editableCurvePoint.localNormal = editableCurvePoint2.localNormal;
			editableCurvePoint.radius = editableCurvePoint2.radius;
			editableCurvePoint.color = editableCurvePoint2.color;
		}
		m_Points.Add(editableCurvePoint);
		MarkPointDataDirty();
	}

	public void AddPointAfter(int index)
	{
		EnsurePointList();
		if (m_Points.Count == 0 || index < 0 || index >= m_Points.Count)
		{
			AddPoint(Vector3.forward);
			return;
		}
		Vector3 localPosition = ((index + 1 < m_Points.Count) ? Vector3.Lerp(m_Points[index].localPosition, m_Points[index + 1].localPosition, 0.5f) : (m_Points[index].localPosition + GetPointLocalDirection(index)));
		InsertPoint(index + 1, localPosition, m_Points[index].localNormal, m_Points[index].radius, m_Points[index].color);
	}

	public void InsertPoint(int index, Vector3 localPosition, Vector3 localNormal, float radius, Color color)
	{
		EnsurePointList();
		index = Mathf.Clamp(index, 0, m_Points.Count);
		EditableCurvePoint item = new EditableCurvePoint(localPosition, Mathf.Max(0f, radius))
		{
			localNormal = ((localNormal.sqrMagnitude > 1E-06f) ? localNormal.normalized : Vector3.up),
			color = color
		};
		m_Points.Insert(index, item);
		MarkPointDataDirty();
	}

	public int InsertMidPoint(int firstIndex, int secondIndex)
	{
		EnsurePointList();
		if (firstIndex < 0 || firstIndex >= m_Points.Count || secondIndex < 0 || secondIndex >= m_Points.Count || firstIndex == secondIndex)
		{
			return -1;
		}
		int num = Mathf.Max(firstIndex, secondIndex);
		EditableCurvePoint editableCurvePoint = m_Points[firstIndex];
		EditableCurvePoint editableCurvePoint2 = m_Points[secondIndex];
		Vector3 localNormal = Vector3.Lerp(editableCurvePoint.localNormal, editableCurvePoint2.localNormal, 0.5f);
		if (localNormal.sqrMagnitude <= 1E-06f)
		{
			localNormal = editableCurvePoint.localNormal;
		}
		InsertPoint(num, Vector3.Lerp(editableCurvePoint.localPosition, editableCurvePoint2.localPosition, 0.5f), localNormal, Mathf.Lerp(editableCurvePoint.radius, editableCurvePoint2.radius, 0.5f), Color.Lerp(editableCurvePoint.color, editableCurvePoint2.color, 0.5f));
		return num;
	}

	public void RemovePointAt(int index)
	{
		EnsurePointList();
		if (index >= 0 && index < m_Points.Count)
		{
			m_Points.RemoveAt(index);
			MarkPointDataDirty();
		}
	}

	public void SmoothInnerPointsOnce()
	{
		SmoothInnerPointsAnchored(0.25f, 0.75f);
	}

	public void SmoothInnerPointsOnce(float lambda, float mu)
	{
		EnsurePointList();
		int count = m_Points.Count;
		if (count > 2)
		{
			EnsureSmoothBuffers(count);
			for (int i = 0; i < count; i++)
			{
				CopyPoint(m_Points[i], m_SmoothTempPoints[i]);
			}
			for (int j = 1; j < count - 1; j++)
			{
				ApplyLaplacianStep(m_SmoothTempPoints, m_Points, j, lambda);
			}
			for (int k = 0; k < count; k++)
			{
				CopyPoint(m_Points[k], m_SmoothTempPoints[k]);
			}
			for (int l = 1; l < count - 1; l++)
			{
				ApplyLaplacianStep(m_SmoothTempPoints, m_Points, l, mu);
			}
			m_CurveDataDirty = true;
			InvalidateSmoothAnchor();
			UpdatePointValidationSignature();
		}
	}

	public void SmoothInnerPointsAnchored(float smoothStrength = 0.35f, float anchorStrength = 0.45f)
	{
		EnsurePointList();
		int count = m_Points.Count;
		if (count > 2)
		{
			smoothStrength = Mathf.Clamp01(smoothStrength);
			anchorStrength = Mathf.Clamp01(anchorStrength);
			EnsureSmoothBuffers(count);
			EnsureSmoothAnchor(count);
			for (int i = 0; i < count; i++)
			{
				CopyPoint(m_Points[i], m_SmoothTempPoints[i]);
			}
			for (int j = 1; j < count - 1; j++)
			{
				EditableCurvePoint editableCurvePoint = m_SmoothTempPoints[j];
				EditableCurvePoint editableCurvePoint2 = m_SmoothTempPoints[j - 1];
				EditableCurvePoint editableCurvePoint3 = m_SmoothTempPoints[j + 1];
				EditableCurvePoint editableCurvePoint4 = m_SmoothAnchorPoints[j];
				Vector3 vector = 0.5f * (editableCurvePoint2.localPosition + editableCurvePoint3.localPosition);
				Vector3 a = editableCurvePoint.localPosition + smoothStrength * (vector - editableCurvePoint.localPosition);
				m_Points[j].localPosition = Vector3.Lerp(a, editableCurvePoint4.localPosition, anchorStrength);
				Vector3 vector2 = AverageNormal(editableCurvePoint2.localNormal, editableCurvePoint3.localNormal, editableCurvePoint.localNormal);
				Vector3 vector3 = NormalizeNormal(editableCurvePoint.localNormal + smoothStrength * (vector2 - editableCurvePoint.localNormal));
				m_Points[j].localNormal = NormalizeNormal(Vector3.Lerp(vector3, AlignHemisphere(vector3, editableCurvePoint4.localNormal), anchorStrength));
				float num = 0.5f * (editableCurvePoint2.radius + editableCurvePoint3.radius);
				float a2 = editableCurvePoint.radius + smoothStrength * (num - editableCurvePoint.radius);
				m_Points[j].radius = Mathf.Max(0f, Mathf.Lerp(a2, editableCurvePoint4.radius, anchorStrength));
				Color color = (editableCurvePoint2.color + editableCurvePoint3.color) * 0.5f;
				Color a3 = editableCurvePoint.color + (color - editableCurvePoint.color) * smoothStrength;
				m_Points[j].color = Color.Lerp(a3, editableCurvePoint4.color, anchorStrength);
			}
			m_CurveDataDirty = true;
			UpdatePointValidationSignature();
		}
	}

	public void SmoothInnerPointsHC(float alpha = 0.35f, float beta = 0.65f)
	{
		EnsurePointList();
		int count = m_Points.Count;
		if (count > 2)
		{
			EnsureSmoothBuffers(count);
			for (int i = 0; i < count; i++)
			{
				CopyPoint(m_Points[i], m_SmoothTempPoints[i]);
				ClearPoint(m_SmoothCorrectionPoints[i]);
			}
			for (int j = 1; j < count - 1; j++)
			{
				ApplyLaplacianStep(m_SmoothTempPoints, m_Points, j, alpha);
				m_SmoothCorrectionPoints[j].localPosition = m_Points[j].localPosition - m_SmoothTempPoints[j].localPosition;
				m_SmoothCorrectionPoints[j].localNormal = m_Points[j].localNormal - m_SmoothTempPoints[j].localNormal;
				m_SmoothCorrectionPoints[j].radius = m_Points[j].radius - m_SmoothTempPoints[j].radius;
				m_SmoothCorrectionPoints[j].color = m_Points[j].color - m_SmoothTempPoints[j].color;
			}
			for (int k = 1; k < count - 1; k++)
			{
				EditableCurvePoint editableCurvePoint = m_SmoothCorrectionPoints[k];
				EditableCurvePoint editableCurvePoint2 = m_SmoothCorrectionPoints[k - 1];
				EditableCurvePoint editableCurvePoint3 = m_SmoothCorrectionPoints[k + 1];
				float num = 1f - beta;
				m_Points[k].localPosition -= beta * editableCurvePoint.localPosition + num * 0.5f * (editableCurvePoint2.localPosition + editableCurvePoint3.localPosition);
				m_Points[k].localNormal = NormalizeNormal(m_Points[k].localNormal - (beta * editableCurvePoint.localNormal + num * 0.5f * (editableCurvePoint2.localNormal + editableCurvePoint3.localNormal)));
				m_Points[k].radius = Mathf.Max(0f, m_Points[k].radius - (beta * editableCurvePoint.radius + num * 0.5f * (editableCurvePoint2.radius + editableCurvePoint3.radius)));
				m_Points[k].color -= editableCurvePoint.color * beta + (editableCurvePoint2.color + editableCurvePoint3.color) * (num * 0.5f);
			}
			m_CurveDataDirty = true;
			InvalidateSmoothAnchor();
			UpdatePointValidationSignature();
		}
	}

	private void OnEnable()
	{
		if (m_Block == null)
		{
			m_Block = new MaterialPropertyBlock();
		}
		m_MaterialsDirty = true;
		m_CurveDataDirty = true;
	}

	private void OnDisable()
	{
		ReleaseBuffers();
		ReleaseDrawMaterials();
		m_CurveShader = null;
		m_KernelsReady = false;
		setDirt();
	}

	private void OnValidate()
	{
		m_SubDivide = Mathf.Max(1, m_SubDivide);
		m_MeshResolution = Mathf.Max(2, m_MeshResolution);
		m_RibbonDirectionSubdivide = Mathf.Max(1, m_RibbonDirectionSubdivide);
		m_DefaultRadius = Mathf.Max(0f, m_DefaultRadius);
		if (materials == null)
		{
			materials = new List<Material>();
		}
		if (material != null && materials.Count == 0)
		{
			materials.Add(material);
		}
		EnsurePointList();
		for (int i = 0; i < m_Points.Count; i++)
		{
			EditableCurvePoint editableCurvePoint = m_Points[i];
			editableCurvePoint.radius = Mathf.Max(0f, editableCurvePoint.radius);
			editableCurvePoint.localNormal = NormalizeNormal(editableCurvePoint.localNormal);
		}
		ValidateSmoothAnchorAfterSerializedChanges();
		setDirt();
	}

	private void Update()
	{
		CurveData activeCurveData = GetActiveCurveData();
		if (activeCurveData == null || activeCurveData.pointCount <= 1 || activeCurveData.points == null || !EnsureCurveShader() || !EnsureDrawMaterials())
		{
			return;
		}
		if (m_Block == null)
		{
			m_Block = new MaterialPropertyBlock();
		}
		bool flag = ((activeCurveData != curveData) ? ((!DoNotRefresh && (m_CurveDataDirty || TransformChanged())) || !m_HasUploadedData) : (!DoNotRefresh || !m_HasUploadedData));
		if (BuffersNeedRebuild(activeCurveData))
		{
			ReleaseBuffers();
			CreateBuffers(activeCurveData);
			flag = true;
		}
		if (flag)
		{
			RefreshBuffers(activeCurveData);
			m_CurveDataDirty = false;
			m_HasUploadedData = true;
			m_LastLocalToWorldMatrix = transform.localToWorldMatrix;
			m_HasLastLocalToWorldMatrix = true;
		}
		if (m_IndexBuffer == null || m_VertexIndexCount <= 0 || m_MeshBuffer == null)
		{
			return;
		}
		SetMaterialBuffer(m_Block);
		Bounds bounds = activeCurveData.bounds;
		for (int i = 0; i < m_DrawMaterials.Count; i++)
		{
			Material material = m_DrawMaterials[i];
			if (!(material == null))
			{
				Graphics.DrawProcedural(material, bounds, MeshTopology.Triangles, m_IndexBuffer, m_VertexIndexCount, 1, null, m_Block, ShadowCastingMode.TwoSided, receiveShadows: true, gameObject.layer);
			}
		}
	}

	private CurveData GetActiveCurveData()
	{
		if (curveData != null && curveData.points != null)
		{
			curveData.subDivide = Mathf.Max(1, curveData.subDivide);
			curveData.meshResolution = Mathf.Max(2, curveData.meshResolution);
			curveData.alpha = Mathf.Clamp01(curveData.alpha);
			return curveData;
		}
		if (billboardNormal)
		{
			UpdateBillboardPointNormals();
		}
		return BuildLocalCurveData();
	}

	private CurveData BuildLocalCurveData()
	{
		EnsurePointList();
		int count = m_Points.Count;
		if (count <= 1)
		{
			return null;
		}
		EnsureRuntimePointCapacity(count);
		Transform transform = base.transform;
		float radiusScale = GetRadiusScale();
		Bounds bounds = default;
		float num = 0f;
		Vector3 a = Vector3.zero;
		CurveData.CurvePoint curvePoint = default;
		for (int i = 0; i < count; i++)
		{
			EditableCurvePoint editableCurvePoint = m_Points[i];
			Vector3 pointLocalDirection = GetPointLocalDirection(i);
			Vector3 vector = transform.TransformPoint(editableCurvePoint.localPosition);
			Vector3 vector2 = transform.TransformDirection(pointLocalDirection);
			Vector3 normal = transform.TransformDirection(editableCurvePoint.localNormal);
			vector2 = ((vector2.sqrMagnitude > 1E-06f) ? vector2.normalized : transform.right);
			normal = ProjectNormalToDirectionPlane(normal, vector2, transform.up);
			if (i > 0)
			{
				num += Vector3.Distance(a, vector);
			}
			float num2 = Mathf.Max(0f, editableCurvePoint.radius * radiusScale);
			Vector3 size = Vector3.one * Mathf.Max(num2 * 2f, 0.001f);
			if (i == 0)
			{
				bounds = new Bounds(vector, size);
			}
			else
			{
				bounds.Encapsulate(new Bounds(vector, size));
			}
			curvePoint.position = vector;
			curvePoint.normal = normal;
			curvePoint.direction = vector2;
			curvePoint.color = editableCurvePoint.color;
			curvePoint.factor = num;
			curvePoint.radius = num2;
			m_RuntimePoints[i] = curvePoint;
			a = vector;
		}
		m_RuntimeCurveData.pointCount = count;
		m_RuntimeCurveData.subDivide = m_SubDivide;
		m_RuntimeCurveData.meshResolution = m_MeshResolution;
		m_RuntimeCurveData.alpha = m_Alpha;
		m_RuntimeCurveData.FactorScale = Mathf.Max(num, 0.0001f);
		m_RuntimeCurveData.bounds = bounds;
		m_RuntimeCurveData.points = m_RuntimePoints;
		return m_RuntimeCurveData;
	}

	private void RefreshBuffers(CurveData data)
	{
		CommandBuffer commandBuffer = CommandBufferPool.Get("CurveUpdate");
		SetBuffer(commandBuffer);
		SetConstant(commandBuffer, data);
		m_DataBuffer.SetData(data.points, 0, 0, data.pointCount);
		commandBuffer.DispatchCompute(m_CurveShader, m_KernelCurveCreate, Mathf.CeilToInt((float)(data.pointCount - 1) / 64f), 1, 1);
		int subdividedPointCount = GetSubdividedPointCount(data);
		commandBuffer.DispatchCompute(m_CurveShader, m_KernelMeshCreate, Mathf.CeilToInt((float)subdividedPointCount / 64f), 1, 1);
		Graphics.ExecuteCommandBuffer(commandBuffer);
		CommandBufferPool.Release(commandBuffer);
	}

	private bool EnsureCurveShader()
	{
		if (m_CurveShader == null)
		{
			UniversalRenderPipelineAsset asset = UniversalRenderPipeline.asset;
			UniversalRendererData universalRendererData = ((asset != null) ? (asset.scriptableRendererData as UniversalRendererData) : null);
			if (universalRendererData == null || universalRendererData.shaders.CurveRendererCS == null)
			{
				return false;
			}
			m_CurveShader = universalRendererData.shaders.CurveRendererCS;
			m_KernelsReady = false;
		}
		if (!m_KernelsReady)
		{
			m_KernelCurveCreate = m_CurveShader.FindKernel("CurveCreat");
			m_KernelMeshCreate = m_CurveShader.FindKernel("CurveMeshCreat");
			m_KernelsReady = m_KernelCurveCreate >= 0 && m_KernelMeshCreate >= 0;
		}
		return m_KernelsReady;
	}

	private void CreateBuffers(CurveData data)
	{
		int subdividedPointCount = GetSubdividedPointCount(data);
		int count;
		int num2;
		if (data.meshResolution == 2)
		{
			int num = Mathf.Max(1, m_RibbonDirectionSubdivide);
			count = subdividedPointCount * (num + 1);
			num2 = (subdividedPointCount - 1) * num * 2;
		}
		else
		{
			count = subdividedPointCount * (data.meshResolution + 1);
			num2 = (subdividedPointCount - 1) * data.meshResolution * 2;
		}
		m_DataBuffer = new ComputeBuffer(data.pointCount, 60);
		m_SubDivideDataBuffer = new ComputeBuffer(subdividedPointCount, 60);
		m_VertexIndexCount = num2 * 3;
		m_IndexBuffer = new GraphicsBuffer(GraphicsBuffer.Target.Structured, m_VertexIndexCount, 4);
		m_MeshBuffer = new ComputeBuffer(count, 72);
		m_BufferPointCount = data.pointCount;
		m_BufferSubDivide = data.subDivide;
		m_BufferMeshResolution = data.meshResolution;
		m_BufferRibbonDirectionSubdivide = m_RibbonDirectionSubdivide;
	}

	private bool BuffersNeedRebuild(CurveData data)
	{
		if (m_DataBuffer != null && m_SubDivideDataBuffer != null && m_IndexBuffer != null && m_MeshBuffer != null && m_BufferPointCount == data.pointCount && m_BufferSubDivide == data.subDivide && m_BufferMeshResolution == data.meshResolution)
		{
			return m_BufferRibbonDirectionSubdivide != m_RibbonDirectionSubdivide;
		}
		return true;
	}

	private void SetBuffer(CommandBuffer cmd)
	{
		cmd.SetComputeBufferParam(m_CurveShader, m_KernelCurveCreate, "_PointDataBuffer", m_DataBuffer);
		cmd.SetComputeBufferParam(m_CurveShader, m_KernelCurveCreate, "_SubDividePointDataBuffer", m_SubDivideDataBuffer);
		cmd.SetComputeBufferParam(m_CurveShader, m_KernelMeshCreate, "_SubDividePointDataBuffer", m_SubDivideDataBuffer);
		cmd.SetComputeBufferParam(m_CurveShader, m_KernelMeshCreate, "_TrianglesIndexBuffer", m_IndexBuffer);
		cmd.SetComputeBufferParam(m_CurveShader, m_KernelMeshCreate, "_VertexDataBuffer", m_MeshBuffer);
	}

	private void SetConstant(CommandBuffer cmd, CurveData data)
	{
		cmd.SetComputeVectorParam(m_CurveShader, CurveDataTag, new Vector4(data.pointCount, data.subDivide, data.meshResolution, data.alpha));
		cmd.SetComputeFloatParam(m_CurveShader, CurveDataTag2, Mathf.Max(data.FactorScale, 0.0001f));
		cmd.SetComputeIntParam(m_CurveShader, CurveRibbonDirectionSubdivideTag, Mathf.Max(1, m_RibbonDirectionSubdivide));
	}

	private void SetMaterialBuffer(MaterialPropertyBlock block)
	{
		block.SetBuffer(GlobalCurveBufferTag, m_MeshBuffer);
		block.SetInt(UseActCurveTag, 1);
	}

	private bool EnsureDrawMaterials()
	{
		if (!SourceMaterialReferencesMatch())
		{
			RebuildDrawMaterials();
		}
		else if (m_MaterialsDirty)
		{
			SyncDrawMaterialsFromSources();
			m_MaterialsDirty = false;
		}
		for (int i = 0; i < m_DrawMaterials.Count; i++)
		{
			if (m_DrawMaterials[i] != null)
			{
				return true;
			}
		}
		return false;
	}

	private bool SourceMaterialReferencesMatch()
	{
		int sourceMaterialSlotCount = GetSourceMaterialSlotCount();
		if (m_LastMaterials.Count != sourceMaterialSlotCount || m_DrawMaterials.Count != sourceMaterialSlotCount)
		{
			return false;
		}
		for (int i = 0; i < sourceMaterialSlotCount; i++)
		{
			Material sourceMaterial = GetSourceMaterial(i);
			if (m_LastMaterials[i] != sourceMaterial)
			{
				return false;
			}
			if (sourceMaterial != null && m_DrawMaterials[i] == null)
			{
				return false;
			}
			if (sourceMaterial != null && m_DrawMaterials[i] != null && m_DrawMaterials[i].shader != sourceMaterial.shader)
			{
				return false;
			}
		}
		return true;
	}

	private void RebuildDrawMaterials()
	{
		ReleaseDrawMaterials();
		int sourceMaterialSlotCount = GetSourceMaterialSlotCount();
		for (int i = 0; i < sourceMaterialSlotCount; i++)
		{
			Material sourceMaterial = GetSourceMaterial(i);
			m_LastMaterials.Add(sourceMaterial);
			if (sourceMaterial == null)
			{
				m_DrawMaterials.Add(null);
				continue;
			}
			Material material = new Material(sourceMaterial);
			material.hideFlags = HideFlags.DontSaveInEditor | HideFlags.DontSaveInBuild;
			m_DrawMaterials.Add(material);
		}
		m_MaterialsDirty = false;
	}

	private void SyncDrawMaterialsFromSources()
	{
		for (int i = 0; i < m_DrawMaterials.Count; i++)
		{
			Material sourceMaterial = GetSourceMaterial(i);
			Material material = m_DrawMaterials[i];
			if (!(sourceMaterial == null) && !(material == null))
			{
				material.CopyPropertiesFromMaterial(sourceMaterial);
			}
		}
	}

	private int GetSourceMaterialSlotCount()
	{
		if (materials != null && materials.Count > 0)
		{
			return materials.Count;
		}
		if (!(material != null))
		{
			return 0;
		}
		return 1;
	}

	private Material GetSourceMaterial(int index)
	{
		if (materials != null && materials.Count > 0)
		{
			if (index < 0 || index >= materials.Count)
			{
				return null;
			}
			return materials[index];
		}
		if (index != 0)
		{
			return null;
		}
		return material;
	}

	private int GetSubdividedPointCount(CurveData data)
	{
		return (data.pointCount - 1) * data.subDivide + 1;
	}

	private void ReleaseBuffers()
	{
		if (m_SubDivideDataBuffer != null)
		{
			m_SubDivideDataBuffer.Release();
			m_SubDivideDataBuffer = null;
		}
		if (m_DataBuffer != null)
		{
			m_DataBuffer.Release();
			m_DataBuffer = null;
		}
		if (m_IndexBuffer != null)
		{
			m_IndexBuffer.Release();
			m_IndexBuffer = null;
		}
		if (m_MeshBuffer != null)
		{
			m_MeshBuffer.Release();
			m_MeshBuffer = null;
		}
	}

	private void ReleaseDrawMaterials()
	{
		for (int i = 0; i < m_DrawMaterials.Count; i++)
		{
			Material material = m_DrawMaterials[i];
			if (material != null)
			{
				DestroyRuntimeObject(material);
			}
		}
		m_DrawMaterials.Clear();
		m_LastMaterials.Clear();
	}

	private static void DestroyRuntimeObject(UnityEngine.Object target)
	{
		if (!(target == null))
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(target);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(target);
			}
		}
	}

	private void EnsurePointList()
	{
		if (m_Points == null)
		{
			m_Points = new List<EditableCurvePoint>();
		}
	}

	private void EnsureRuntimePointCapacity(int count)
	{
		if (m_RuntimePoints == null || m_RuntimePoints.Length != count)
		{
			m_RuntimePoints = new CurveData.CurvePoint[count];
		}
	}

	private void EnsureSmoothBuffers(int count)
	{
		if (m_SmoothTempPoints == null || m_SmoothTempPoints.Length != count)
		{
			m_SmoothTempPoints = new EditableCurvePoint[count];
			m_SmoothCorrectionPoints = new EditableCurvePoint[count];
			for (int i = 0; i < count; i++)
			{
				m_SmoothTempPoints[i] = new EditableCurvePoint();
				m_SmoothCorrectionPoints[i] = new EditableCurvePoint();
			}
		}
	}

	private void EnsureSmoothAnchor(int count)
	{
		if (m_SmoothAnchorPoints == null || m_SmoothAnchorPoints.Length != count)
		{
			m_SmoothAnchorPoints = new EditableCurvePoint[count];
			for (int i = 0; i < count; i++)
			{
				m_SmoothAnchorPoints[i] = new EditableCurvePoint();
			}
			m_HasSmoothAnchor = false;
		}
		if (!m_HasSmoothAnchor)
		{
			for (int j = 0; j < count; j++)
			{
				CopyPoint(m_Points[j], m_SmoothAnchorPoints[j]);
			}
			m_HasSmoothAnchor = true;
		}
	}

	private void MarkPointDataDirty()
	{
		m_CurveDataDirty = true;
		InvalidateSmoothAnchor();
		UpdatePointValidationSignature();
	}

	private void InvalidateSmoothAnchor()
	{
		m_HasSmoothAnchor = false;
	}

	private void ValidateSmoothAnchorAfterSerializedChanges()
	{
		int num = CalculatePointSignature();
		if (m_HasValidatedPointSignature && num != m_LastValidatedPointSignature)
		{
			InvalidateSmoothAnchor();
		}
		m_LastValidatedPointSignature = num;
		m_HasValidatedPointSignature = true;
	}

	private void UpdatePointValidationSignature()
	{
		m_LastValidatedPointSignature = CalculatePointSignature();
		m_HasValidatedPointSignature = true;
	}

	private int CalculatePointSignature()
	{
		EnsurePointList();
		int num = 17;
		num = num * 31 + m_Points.Count;
		for (int i = 0; i < m_Points.Count; i++)
		{
			EditableCurvePoint editableCurvePoint = m_Points[i];
			num = num * 31 + editableCurvePoint.localPosition.GetHashCode();
			num = num * 31 + editableCurvePoint.localNormal.GetHashCode();
			num = num * 31 + editableCurvePoint.radius.GetHashCode();
			num = num * 31 + editableCurvePoint.color.GetHashCode();
		}
		return num;
	}

	private Vector3 GetPointLocalDirection(int index)
	{
		int count = m_Points.Count;
		if (count <= 1)
		{
			return Vector3.right;
		}
		Vector3 vector;
		if (index <= 0)
		{
			vector = m_Points[1].localPosition - m_Points[0].localPosition;
		}
		else
		{
			vector = ((index < count - 1) ? (m_Points[index + 1].localPosition - m_Points[index - 1].localPosition) : (m_Points[count - 1].localPosition - m_Points[count - 2].localPosition));
		}
		if (!(vector.sqrMagnitude > 1E-06f))
		{
			return Vector3.right;
		}
		return vector.normalized;
	}

	private void UpdateBillboardPointNormals()
	{
		EnsurePointList();
		if (billboardCamera == null)
		{
			return;
		}
		Transform transform = base.transform;
		for (int i = 0; i < m_Points.Count; i++)
		{
			Vector3 vector = transform.TransformPoint(m_Points[i].localPosition);
			Vector3 vector2 = transform.TransformDirection(GetPointLocalDirection(i));
			Vector3 vector3 = billboardCamera.transform.position - vector;
			vector2 = ((vector2.sqrMagnitude > 1E-06f) ? vector2.normalized : transform.right);
			Vector3 lhs = vector3 - Vector3.Dot(vector3, vector2) * vector2;
			if (!(lhs.sqrMagnitude <= 1E-06f))
			{
				lhs.Normalize();
				Vector3 direction = Vector3.Cross(lhs, vector2);
				Vector3 normal = transform.InverseTransformDirection(direction);
				normal = NormalizeNormal(normal);
				if (Vector3.Dot(m_Points[i].localNormal, normal) < 0.999f)
				{
					m_Points[i].localNormal = normal;
					m_CurveDataDirty = true;
					InvalidateSmoothAnchor();
				}
			}
		}
	}

	private bool TransformChanged()
	{
		Matrix4x4 localToWorldMatrix = transform.localToWorldMatrix;
		if (m_HasLastLocalToWorldMatrix)
		{
			return localToWorldMatrix != m_LastLocalToWorldMatrix;
		}
		return true;
	}

	private float GetRadiusScale()
	{
		Vector3 lossyScale = transform.lossyScale;
		return Mathf.Max(Mathf.Max(Mathf.Max(Mathf.Abs(lossyScale.x), Mathf.Abs(lossyScale.y)), Mathf.Abs(lossyScale.z)), 0.0001f);
	}

	private static Vector3 ProjectNormalToDirectionPlane(Vector3 normal, Vector3 direction, Vector3 fallback)
	{
		direction = ((direction.sqrMagnitude > 1E-06f) ? direction.normalized : Vector3.right);
		normal -= Vector3.Dot(normal, direction) * direction;
		if (normal.sqrMagnitude > 1E-06f)
		{
			return normal.normalized;
		}
		fallback -= Vector3.Dot(fallback, direction) * direction;
		if (fallback.sqrMagnitude > 1E-06f)
		{
			return fallback.normalized;
		}
		Vector3 vector = Vector3.Cross(direction, Vector3.up);
		if (!(vector.sqrMagnitude > 1E-06f))
		{
			return Vector3.forward;
		}
		return vector.normalized;
	}

	private static Vector3 NormalizeNormal(Vector3 normal)
	{
		if (!(normal.sqrMagnitude > 1E-06f))
		{
			return Vector3.up;
		}
		return normal.normalized;
	}

	private static Vector3 AlignHemisphere(Vector3 reference, Vector3 normal)
	{
		normal = NormalizeNormal(normal);
		if (!(Vector3.Dot(reference, normal) < 0f))
		{
			return normal;
		}
		return -normal;
	}

	private static Vector3 AverageNormal(Vector3 first, Vector3 second, Vector3 fallback)
	{
		fallback = NormalizeNormal(fallback);
		first = AlignHemisphere(fallback, first);
		second = AlignHemisphere(fallback, second);
		Vector3 vector = first + second;
		if (!(vector.sqrMagnitude > 1E-06f))
		{
			return fallback;
		}
		return vector.normalized;
	}

	private static void CopyPoint(EditableCurvePoint source, EditableCurvePoint target)
	{
		target.localPosition = source.localPosition;
		target.localNormal = source.localNormal;
		target.radius = source.radius;
		target.color = source.color;
	}

	private static void ClearPoint(EditableCurvePoint target)
	{
		target.localPosition = Vector3.zero;
		target.localNormal = Vector3.zero;
		target.radius = 0f;
		target.color = Color.clear;
	}

	private static void ApplyLaplacianStep(EditableCurvePoint[] source, List<EditableCurvePoint> target, int index, float strength)
	{
		EditableCurvePoint editableCurvePoint = source[index];
		EditableCurvePoint editableCurvePoint2 = source[index - 1];
		EditableCurvePoint editableCurvePoint3 = source[index + 1];
		EditableCurvePoint editableCurvePoint4 = target[index];
		editableCurvePoint4.localPosition = editableCurvePoint.localPosition + strength * (0.5f * (editableCurvePoint2.localPosition + editableCurvePoint3.localPosition) - editableCurvePoint.localPosition);
		editableCurvePoint4.localNormal = NormalizeNormal(editableCurvePoint.localNormal + strength * (0.5f * (editableCurvePoint2.localNormal + editableCurvePoint3.localNormal) - editableCurvePoint.localNormal));
		editableCurvePoint4.radius = Mathf.Max(0f, editableCurvePoint.radius + strength * (0.5f * (editableCurvePoint2.radius + editableCurvePoint3.radius) - editableCurvePoint.radius));
		editableCurvePoint4.color = editableCurvePoint.color + ((editableCurvePoint2.color + editableCurvePoint3.color) * 0.5f - editableCurvePoint.color) * strength;
	}
}
