using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace ACT.Drama;

public class LeftModelScene : MonoBehaviour
{
	private enum HorizontalAnchor
	{
		Left,
		Right
	}

	private struct MaskLayout
	{
		public Transform transform;

		public Vector3 originalScale;

		public Vector3 originalSize;
	}

	private struct ModelLayout
	{
		public Transform transform;

		public Vector3 authoredLocalPosition;

		public Vector3 originalScale;

		public float cameraSpaceZ;

		public Vector2 screenAnchor;

		public float referencePlaneHeight;

		public bool valid;
	}

	private const float MaskOverscan = 1.02f;

	private const float MaxMaskHeightRatio = 3f;

	public Animator animator;

	[Header("模型挂点")]
	public GameObject modelRoot;

	[Tooltip("模型布局基准视野：与 ScreenLeftCharacterPass 的固定 FOV 保持一致。小于等于 0 时使用 35 度。")]
	public float referenceFieldOfView = 35f;

	[Header("背景遮罩")]
	public MeshRenderer leftBgMask;

	[Range(0f, 1f)]
	[Tooltip("左侧遮罩宽度比例：以画面宽度为 1，0 表示不显示，1 表示铺满整个画面宽度。")]
	public float leftFillRatio = 0.2f;

	[Range(0f, 3f)]
	[Tooltip("左侧遮罩高度比例：以画面高度为 1，0 表示不显示，1 表示满屏高，最大 3。遮罩底边固定在画面底部，比例变小时从顶部往下缩。")]
	public float leftHeightRatio = 1f;

	public MeshRenderer rightBgMask;

	[Range(0f, 1f)]
	[Tooltip("右侧遮罩宽度比例：以画面宽度为 1，0 表示不显示，1 表示铺满整个画面宽度。")]
	public float rightFillRatio = 0.4f;

	[Range(0f, 3f)]
	[Tooltip("右侧遮罩高度比例：以画面高度为 1，0 表示不显示，1 表示满屏高，最大 3。遮罩底边固定在画面底部，比例变小时从顶部往下缩。")]
	public float rightHeightRatio = 1f;

	private Camera m_MainCamera;

	private MaskLayout m_LeftMaskLayout;

	private MaskLayout m_RightMaskLayout;

	private ModelLayout m_ModelLayout;

	private bool m_ModelReferenceCaptured;

	private float m_LastFieldOfView = float.NaN;

	private float m_LastAspect = float.NaN;

	private float m_LastOrthographicSize = float.NaN;

	private float m_LastLeftMaskZ = float.NaN;

	private float m_LastRightMaskZ = float.NaN;

	private float m_LastLeftFillRatio = float.NaN;

	private float m_LastRightFillRatio = float.NaN;

	private float m_LastLeftHeightRatio = float.NaN;

	private float m_LastRightHeightRatio = float.NaN;

	private int m_LastScreenWidth;

	private int m_LastScreenHeight;

	private int m_LastPixelWidth;

	private int m_LastPixelHeight;

	private Rect m_LastCameraRect;

	private Rect m_LastCameraPixelRect;

	private Vector3 m_LastCameraPosition;

	private Quaternion m_LastCameraRotation;

	private bool m_LastOrthographic;

	private void Awake()
	{
		m_MainCamera = GetComponentInParent<Camera>();
		m_LeftMaskLayout = CreateMaskLayout(leftBgMask);
		m_RightMaskLayout = CreateMaskLayout(rightBgMask);
		m_ModelLayout = CreateModelLayout(modelRoot);
	}

	private void OnEnable()
	{
		if (!m_MainCamera)
		{
			m_MainCamera = GetComponentInParent<Camera>();
		}
		RenderPipelineManager.beginCameraRendering += OnBeginCameraRendering;
		RefreshLayouts(force: true);
	}

	private void OnDisable()
	{
		RenderPipelineManager.beginCameraRendering -= OnBeginCameraRendering;
	}

	private void OnBeginCameraRendering(ScriptableRenderContext context, Camera camera)
	{
		if (camera == m_MainCamera)
		{
			RefreshLayouts(force: false);
		}
	}

	public void FadeShowBg()
	{
		animator.SetBool("Bg", value: true);
	}

	public void FadeHideBg()
	{
		animator.SetBool("Bg", value: true);
	}

	public void FadeShowRoleBg()
	{
		animator.SetBool("RoleBg", value: true);
	}

	public void FadeHideRoleBg()
	{
		animator.SetBool("RoleBg", value: false);
	}

	private static MaskLayout CreateMaskLayout(MeshRenderer maskRenderer)
	{
		if (!maskRenderer)
		{
			return default;
		}
		Transform transform = maskRenderer.transform;
		Vector3 localScale = transform.localScale;
		Vector3 originalSize = new Vector3(Mathf.Abs(localScale.x), Mathf.Abs(localScale.y), Mathf.Abs(localScale.z));
		MeshFilter component = maskRenderer.GetComponent<MeshFilter>();
		if ((bool)component && (bool)component.sharedMesh)
		{
			Vector3 size = component.sharedMesh.bounds.size;
			originalSize = new Vector3(Mathf.Abs(size.x * localScale.x), Mathf.Abs(size.y * localScale.y), Mathf.Abs(size.z * localScale.z));
		}
		return new MaskLayout
		{
			transform = transform,
			originalScale = localScale * 1.01f,
			originalSize = originalSize
		};
	}

	private static ModelLayout CreateModelLayout(GameObject root)
	{
		if (!root)
		{
			return default;
		}
		Transform transform = root.transform;
		Vector3 localPosition = transform.localPosition;
		return new ModelLayout
		{
			transform = transform,
			authoredLocalPosition = localPosition,
			originalScale = transform.localScale,
			cameraSpaceZ = localPosition.z,
			valid = true
		};
	}

	private void RefreshLayouts(bool force)
	{
		if (!m_MainCamera)
		{
			m_MainCamera = GetComponentInParent<Camera>();
		}
		if ((bool)m_MainCamera)
		{
			bool flag = false;
			if (!m_ModelReferenceCaptured)
			{
				CaptureModelReference();
				flag = true;
			}
			float cameraSpaceZ = GetCameraSpaceZ(m_LeftMaskLayout.transform);
			float cameraSpaceZ2 = GetCameraSpaceZ(m_RightMaskLayout.transform);
			if (force || flag || !Mathf.Approximately(m_LastFieldOfView, m_MainCamera.fieldOfView) || !Mathf.Approximately(m_LastAspect, m_MainCamera.aspect) || !Mathf.Approximately(m_LastOrthographicSize, m_MainCamera.orthographicSize) || m_LastOrthographic != m_MainCamera.orthographic || m_LastScreenWidth != Screen.width || m_LastScreenHeight != Screen.height || m_LastPixelWidth != m_MainCamera.pixelWidth || m_LastPixelHeight != m_MainCamera.pixelHeight || !IsRectApproximately(m_LastCameraRect, m_MainCamera.rect) || !IsRectApproximately(m_LastCameraPixelRect, m_MainCamera.pixelRect) || !(m_LastCameraPosition == m_MainCamera.transform.position) || !(m_LastCameraRotation == m_MainCamera.transform.rotation) || !Mathf.Approximately(m_LastLeftMaskZ, cameraSpaceZ) || !Mathf.Approximately(m_LastRightMaskZ, cameraSpaceZ2) || !Mathf.Approximately(m_LastLeftFillRatio, leftFillRatio) || !Mathf.Approximately(m_LastRightFillRatio, rightFillRatio) || !Mathf.Approximately(m_LastLeftHeightRatio, leftHeightRatio) || !Mathf.Approximately(m_LastRightHeightRatio, rightHeightRatio))
			{
				FillScreenRegion(m_LeftMaskLayout, cameraSpaceZ, leftFillRatio, leftHeightRatio, HorizontalAnchor.Left);
				FillScreenRegion(m_RightMaskLayout, cameraSpaceZ2, rightFillRatio, rightHeightRatio, HorizontalAnchor.Right);
				FillModelRegion();
				m_LastFieldOfView = m_MainCamera.fieldOfView;
				m_LastAspect = m_MainCamera.aspect;
				m_LastOrthographicSize = m_MainCamera.orthographicSize;
				m_LastOrthographic = m_MainCamera.orthographic;
				m_LastScreenWidth = Screen.width;
				m_LastScreenHeight = Screen.height;
				m_LastPixelWidth = m_MainCamera.pixelWidth;
				m_LastPixelHeight = m_MainCamera.pixelHeight;
				m_LastCameraRect = m_MainCamera.rect;
				m_LastCameraPixelRect = m_MainCamera.pixelRect;
				m_LastCameraPosition = m_MainCamera.transform.position;
				m_LastCameraRotation = m_MainCamera.transform.rotation;
				m_LastLeftMaskZ = cameraSpaceZ;
				m_LastRightMaskZ = cameraSpaceZ2;
				m_LastLeftFillRatio = leftFillRatio;
				m_LastRightFillRatio = rightFillRatio;
				m_LastLeftHeightRatio = leftHeightRatio;
				m_LastRightHeightRatio = rightHeightRatio;
			}
		}
	}

	private float GetCameraSpaceZ(Transform maskTransform)
	{
		if (!maskTransform)
		{
			return 0f;
		}
		return m_MainCamera.transform.InverseTransformPoint(maskTransform.position).z;
	}

	private void FillScreenRegion(MaskLayout maskLayout, float cameraSpaceZ, float widthRatio, float heightRatio, HorizontalAnchor anchor)
	{
		if ((bool)maskLayout.transform && !(maskLayout.originalSize.x <= Mathf.Epsilon) && !(maskLayout.originalSize.y <= Mathf.Epsilon))
		{
			CalculateScreenCoverageSize(cameraSpaceZ, out var width, out var height, out var centerOffset);
			float num = Mathf.Clamp01(widthRatio);
			float num2 = Mathf.Clamp(heightRatio, 0f, 3f);
			float num3 = width * num;
			float num4 = height * num2;
			Vector3 originalScale = maskLayout.originalScale;
			originalScale.x *= num3 * 1.02f / maskLayout.originalSize.x;
			originalScale.y *= num4 * 1.02f / maskLayout.originalSize.y;
			originalScale.z = maskLayout.originalScale.z;
			maskLayout.transform.localScale = originalScale;
			float x = ((anchor == HorizontalAnchor.Left) ? (centerOffset.x + (num3 - width) * 0.5f) : (centerOffset.x + (width - num3) * 0.5f));
			float y = centerOffset.y - height * 0.5f + num4 * 0.5f;
			Vector3 position = m_MainCamera.transform.TransformPoint(new Vector3(x, y, cameraSpaceZ));
			maskLayout.transform.position = position;
		}
	}

	private void CaptureModelReference()
	{
		m_ModelReferenceCaptured = true;
		if (m_ModelLayout.valid && (bool)m_MainCamera)
		{
			float modelLayoutFieldOfView = GetModelLayoutFieldOfView();
			CalculateCameraPlaneSize(m_ModelLayout.cameraSpaceZ, modelLayoutFieldOfView, m_MainCamera.aspect, out var width, out var height, out var center);
			if (width <= Mathf.Epsilon || height <= Mathf.Epsilon)
			{
				m_ModelLayout.valid = false;
				return;
			}
			m_ModelLayout.screenAnchor = new Vector2((m_ModelLayout.authoredLocalPosition.x - center.x) / (width * 0.5f), (m_ModelLayout.authoredLocalPosition.y - center.y) / (height * 0.5f));
			m_ModelLayout.referencePlaneHeight = height;
		}
	}

	private void FillModelRegion()
	{
		if (m_ModelLayout.valid && (bool)m_ModelLayout.transform && (bool)m_MainCamera)
		{
			Camera mainCamera = m_MainCamera;
			CalculateCameraPlaneSize(m_ModelLayout.cameraSpaceZ, GetModelLayoutFieldOfView(), mainCamera.aspect, out var width, out var height, out var center);
			if (!(height <= Mathf.Epsilon) && !(m_ModelLayout.referencePlaneHeight <= Mathf.Epsilon))
			{
				float num = height / m_ModelLayout.referencePlaneHeight;
				m_ModelLayout.transform.localPosition = new Vector3(center.x + m_ModelLayout.screenAnchor.x * width * 0.5f, center.y + m_ModelLayout.screenAnchor.y * height * 0.5f, m_ModelLayout.cameraSpaceZ);
				m_ModelLayout.transform.localScale = m_ModelLayout.originalScale * num;
			}
		}
	}

	private float GetModelLayoutFieldOfView()
	{
		return referenceFieldOfView;
	}

	private void CalculateCameraPlaneSize(float cameraSpaceZ, float fieldOfView, float aspect, out float width, out float height, out Vector2 center)
	{
		Camera mainCamera = m_MainCamera;
		float num = Mathf.Abs(cameraSpaceZ);
		float num2 = (((bool)mainCamera && mainCamera.orthographic) ? mainCamera.orthographicSize : (num * Mathf.Tan(Mathf.Clamp(fieldOfView, 0.01f, 179f) * 0.5f * (MathF.PI / 180f))));
		float num3 = num2 * Mathf.Max(aspect, 0.01f);
		width = num3 * 2f;
		height = num2 * 2f;
		Rect rect = (mainCamera ? mainCamera.rect : new Rect(0f, 0f, 1f, 1f));
		center = new Vector2((rect.center.x - 0.5f) * width, (rect.center.y - 0.5f) * height);
	}

	private void CalculateScreenCoverageSize(float cameraSpaceZ, out float width, out float height, out Vector2 centerOffset)
	{
		float z = Mathf.Abs(cameraSpaceZ);
		Vector3 vector = m_MainCamera.transform.InverseTransformPoint(m_MainCamera.ScreenToWorldPoint(new Vector3(0f, 0f, z)));
		Vector3 vector2 = m_MainCamera.transform.InverseTransformPoint(m_MainCamera.ScreenToWorldPoint(new Vector3(Screen.width, Screen.height, z)));
		width = Mathf.Abs(vector2.x - vector.x);
		height = Mathf.Abs(vector2.y - vector.y);
		centerOffset = new Vector2((vector.x + vector2.x) * 0.5f, (vector.y + vector2.y) * 0.5f);
	}

	private static bool IsRectApproximately(Rect a, Rect b)
	{
		if (Mathf.Approximately(a.x, b.x) && Mathf.Approximately(a.y, b.y) && Mathf.Approximately(a.width, b.width))
		{
			return Mathf.Approximately(a.height, b.height);
		}
		return false;
	}
}
