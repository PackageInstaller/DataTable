namespace UnityEngine.Rendering.Universal;

public struct CameraData
{
	private Matrix4x4 m_ViewMatrix;

	private Matrix4x4 m_ProjectionMatrix;

	private Matrix4x4 m_NoJitterPMatrix;

	public Camera camera;

	internal bool resetHistoryForCamera;

	public UniversalAdditionalCameraData urpCameraData;

	internal RenderTexture autoExposureHistoryLUT;

	internal RenderTexture autoExposureCurrentLUT;

	public CameraRenderType renderType;

	public RenderTexture targetTexture;

	public RenderTextureDescriptor cameraTargetDescriptor;

	internal Rect pixelRect;

	internal int pixelWidth;

	internal int pixelHeight;

	internal int outputWidth;

	internal int outputHeight;

	internal float aspectRatio;

	internal int renderWidth;

	internal int renderHeight;

	internal int temporalOutputWidth;

	internal int temporalOutputHeight;

	internal bool temporalUpscalerActive;

	public float renderScale;

	public bool clearDepth;

	public CameraType cameraType;

	public bool isHdrEnabled;

	public bool isBase;

	public bool nextIsGammaUI;

	public bool isGammaUI;

	public bool skip;

	public bool isReAspect;

	internal bool nativeRenderPassEnabled;

	public bool isCameraProjectionMatrixFlipped;

	public SortingCriteria defaultOpaqueSortFlags;

	public float maxShadowDistance;

	public bool postProcessEnabled;

	public LayerMask volumeLayerMask;

	public Transform volumeTrigger;

	public UniversalRenderer renderer;

	public bool lastCam;

	public Vector3 worldSpaceCameraPos;

	internal Matrix4x4 NoJitterPMatrix
	{
		get
		{
			return m_NoJitterPMatrix;
		}
		set
		{
			m_NoJitterPMatrix = value;
		}
	}

	public bool isSceneViewCamera => cameraType == CameraType.SceneView;

	public bool isPreviewCamera => cameraType == CameraType.Preview;

	internal bool isGameCamera => cameraType == CameraType.Game;

	internal void SetViewAndProjectionMatrix(Matrix4x4 viewMatrix, Matrix4x4 projectionMatrix)
	{
		m_ViewMatrix = viewMatrix;
		m_ProjectionMatrix = projectionMatrix;
		m_NoJitterPMatrix = projectionMatrix;
	}

	internal void SetProjectionMatrix(Matrix4x4 projectionMatrix)
	{
		m_ProjectionMatrix = projectionMatrix;
	}

	public Matrix4x4 GetViewMatrix(int viewIndex = 0)
	{
		return m_ViewMatrix;
	}

	public Matrix4x4 GetProjectionMatrix(int viewIndex = 0)
	{
		return m_ProjectionMatrix;
	}

	public Matrix4x4 GetGPUProjectionMatrix(int viewIndex = 0)
	{
		return GL.GetGPUProjectionMatrix(GetProjectionMatrix(viewIndex), isCameraProjectionMatrixFlipped);
	}

	public bool IsCameraProjectionMatrixFlipped()
	{
		ScriptableRenderer current = ScriptableRenderer.current;
		if (current != null)
		{
			bool flag = !(current.cameraColorTarget == BuiltinRenderTextureType.CameraTarget) || targetTexture != null;
			return SystemInfo.graphicsUVStartsAtTop & flag;
		}
		return true;
	}
}
