using System;

namespace UnityEngine.Rendering.Universal;

public class PlannerReflectionHotFixCode : MonoBehaviour
{
	[Serializable]
	public enum ResolutionMulltiplier
	{
		Full,
		Half,
		Third,
		Quarter
	}

	[Serializable]
	public class PlanarReflectionSettings
	{
		public ResolutionMulltiplier m_ResolutionMultiplier = ResolutionMulltiplier.Third;

		public float m_ClipPlaneOffset = 0.07f;

		public LayerMask m_ReflectLayers = -1;

		public bool m_Shadows;
	}

	private class PlanarReflectionSettingData
	{
		private readonly bool _fog;

		private readonly int _maxLod;

		private readonly float _lodBias;

		private bool _invertCulling;

		public PlanarReflectionSettingData()
		{
			_fog = RenderSettings.fog;
			_maxLod = QualitySettings.maximumLODLevel;
			_lodBias = QualitySettings.lodBias;
		}

		public void Set()
		{
			_invertCulling = GL.invertCulling;
			GL.invertCulling = !_invertCulling;
			RenderSettings.fog = false;
			QualitySettings.maximumLODLevel = 1;
			QualitySettings.lodBias = _lodBias * 0.5f;
		}

		public void Restore()
		{
			GL.invertCulling = _invertCulling;
			RenderSettings.fog = _fog;
			QualitySettings.maximumLODLevel = _maxLod;
			QualitySettings.lodBias = _lodBias;
		}
	}

	[SerializeField]
	public PlanarReflectionSettings m_settings = new PlanarReflectionSettings();

	public float m_planeOffset;

	[SerializeField]
	private bool _syncOnlyEnable;

	[SerializeField]
	private float _scaleFovFactor = 1f;

	private readonly int _planarReflectionTextureId = Shader.PropertyToID("_ReflectTex");

	private static Camera _reflectionCamera;

	private bool _isRefCamCreated;

	private bool _isRefRTCreated;

	private bool _isSyncedCamData;

	private RenderTexture _reflectionTexture;

	private Material _refMaterial;

	private PlanarReflectionSettingData _renderGlobalData;

	private void OnEnable()
	{
		_isSyncedCamData = false;
		_refMaterial = GetComponent<Renderer>().sharedMaterial;
		if (!_refMaterial.IsKeywordEnabled("_SCREENPOSITION_ON"))
		{
			_refMaterial.EnableKeyword("_SCREENPOSITION_ON");
		}
		RenderPipelineManager.beginCameraRendering += RunPlannarReflection;
	}

	private void OnDisable()
	{
		Cleanup();
	}

	private void OnDestroy()
	{
		Cleanup();
	}

	private void Cleanup()
	{
		if (_refMaterial.IsKeywordEnabled("_SCREENPOSITION_ON"))
		{
			_refMaterial.DisableKeyword("_SCREENPOSITION_ON");
		}
		RenderPipelineManager.beginCameraRendering -= RunPlannarReflection;
		if (_isRefCamCreated)
		{
			_reflectionCamera.targetTexture = null;
			SafeDestroy(_reflectionCamera.gameObject);
			_reflectionCamera = null;
			_renderGlobalData.Restore();
			_renderGlobalData = null;
			_isRefCamCreated = false;
		}
		if (_isRefRTCreated)
		{
			RenderTexture.ReleaseTemporary(_reflectionTexture);
			_reflectionTexture = null;
			_isRefRTCreated = false;
		}
	}

	private static void SafeDestroy(Object obj)
	{
		if (Application.isEditor)
		{
			Object.DestroyImmediate(obj);
		}
		else
		{
			Object.Destroy(obj);
		}
	}

	private void RunPlannarReflection(ScriptableRenderContext context, Camera pCamera)
	{
		if (Time.frameCount % 2 != 0 && !(pCamera != Camera.main) && pCamera.cameraType != CameraType.Reflection && pCamera.cameraType != CameraType.Preview)
		{
			if (!_isRefCamCreated)
			{
				_reflectionCamera = CreateReflectCamera();
				_renderGlobalData = new PlanarReflectionSettingData();
				CreatePlanarReflectionTexture(pCamera);
				_refMaterial.SetTexture(_planarReflectionTextureId, _reflectionTexture);
			}
			_renderGlobalData.Set();
			if (_syncOnlyEnable && !_isSyncedCamData)
			{
				_isSyncedCamData = true;
				UpdateReflectionCamera(pCamera);
			}
			else
			{
				UpdateReflectionCamera(pCamera);
			}
			UniversalRenderPipeline.RenderSingleCamera(context, _reflectionCamera);
			_renderGlobalData.Restore();
		}
	}

	private Vector2 ReflectionResolution(Camera cam, float scale)
	{
		float num = 0.5f;
		switch (m_settings.m_ResolutionMultiplier)
		{
		case ResolutionMulltiplier.Full:
			num = 1f;
			break;
		case ResolutionMulltiplier.Half:
			num = 0.5f;
			break;
		case ResolutionMulltiplier.Third:
			num = 0.25f;
			break;
		case ResolutionMulltiplier.Quarter:
			num = 0.125f;
			break;
		}
		float x = (float)cam.pixelWidth * scale * num;
		float y = (float)cam.pixelHeight * scale * num;
		return new Vector2(x, y);
	}

	private void CreatePlanarReflectionTexture(Camera cam)
	{
		if (!_isRefRTCreated)
		{
			Vector2 vector = ReflectionResolution(cam, UniversalRenderPipeline.asset.renderScale);
			_reflectionTexture = RenderTexture.GetTemporary((int)vector.x, (int)vector.y, 16, RenderTextureFormat.ARGB32, RenderTextureReadWrite.sRGB);
			_reflectionCamera.targetTexture = _reflectionTexture;
			_isRefRTCreated = true;
		}
	}

	private void UpdateCamera(Camera src, Camera dest)
	{
		if (!(dest == null))
		{
			dest.aspect = src.aspect;
			dest.cameraType = src.cameraType;
			dest.clearFlags = src.clearFlags;
			dest.fieldOfView = src.fieldOfView;
			dest.depth = src.depth;
			dest.farClipPlane = src.farClipPlane;
			dest.focalLength = src.focalLength;
			dest.useOcclusionCulling = src.useOcclusionCulling;
			dest.allowHDR = false;
			if (dest.gameObject.TryGetComponent<UniversalAdditionalCameraData>(out var component))
			{
				component.renderShadows = m_settings.m_Shadows;
			}
		}
	}

	private static Matrix4x4 CalculateReflectionMatrix(Vector4 plane)
	{
		Matrix4x4 identity = Matrix4x4.identity;
		identity.m00 = 1f - 2f * plane[0] * plane[0];
		identity.m01 = -2f * plane[0] * plane[1];
		identity.m02 = -2f * plane[0] * plane[2];
		identity.m03 = -2f * plane[3] * plane[0];
		identity.m10 = -2f * plane[1] * plane[0];
		identity.m11 = 1f - 2f * plane[1] * plane[1];
		identity.m12 = -2f * plane[1] * plane[2];
		identity.m13 = -2f * plane[3] * plane[1];
		identity.m20 = -2f * plane[2] * plane[0];
		identity.m21 = -2f * plane[2] * plane[1];
		identity.m22 = 1f - 2f * plane[2] * plane[2];
		identity.m23 = -2f * plane[3] * plane[2];
		identity.m30 = 0f;
		identity.m31 = 0f;
		identity.m32 = 0f;
		identity.m33 = 1f;
		return identity;
	}

	private Vector4 CameraSpacePlane(Camera cam, Vector3 pos, Vector3 normal, float sideSign)
	{
		Vector3 point = pos + normal * m_settings.m_ClipPlaneOffset;
		Matrix4x4 worldToCameraMatrix = cam.worldToCameraMatrix;
		Vector3 lhs = worldToCameraMatrix.MultiplyPoint(point);
		Vector3 rhs = worldToCameraMatrix.MultiplyVector(normal).normalized * sideSign;
		return new Vector4(rhs.x, rhs.y, rhs.z, 0f - Vector3.Dot(lhs, rhs));
	}

	private void UpdateReflectionCamera(Camera realCamera)
	{
		Vector3 vector = base.gameObject.transform.position + Vector3.up * m_planeOffset;
		Vector3 up = base.gameObject.transform.up;
		UpdateCamera(realCamera, _reflectionCamera);
		float w = 0f - Vector3.Dot(up, vector) - m_settings.m_ClipPlaneOffset;
		Matrix4x4 matrix4x = CalculateReflectionMatrix(new Vector4(up.x, up.y, up.z, w));
		Vector3 vector2 = realCamera.transform.position - new Vector3(0f, vector.y * 2f, 0f);
		Vector3 position = new Vector3(vector2.x, 0f - vector2.y, vector2.z);
		_reflectionCamera.transform.forward = Vector3.Scale(realCamera.transform.forward, new Vector3(1f, -1f, 1f));
		_reflectionCamera.worldToCameraMatrix = realCamera.worldToCameraMatrix * matrix4x;
		Vector4 clipPlane = CameraSpacePlane(_reflectionCamera, vector - Vector3.up * 0.1f, up, 1f);
		Matrix4x4 projectionMatrix = realCamera.CalculateObliqueMatrix(clipPlane);
		_reflectionCamera.projectionMatrix = projectionMatrix;
		_reflectionCamera.cullingMask = m_settings.m_ReflectLayers;
		_reflectionCamera.transform.position = position;
	}

	private Camera CreateReflectCamera()
	{
		GameObject gameObject = new GameObject(" Planar Reflection Camera");
		Camera camera = gameObject.AddComponent<Camera>();
		Component component = gameObject.AddComponent(typeof(UniversalAdditionalCameraData));
		Component obj = ((component is UniversalAdditionalCameraData) ? component : null);
		((UniversalAdditionalCameraData)obj).requiresColorOption = (CameraOverrideOption)0;
		((UniversalAdditionalCameraData)obj).requiresDepthOption = (CameraOverrideOption)0;
		((UniversalAdditionalCameraData)obj).renderShadows = false;
		((UniversalAdditionalCameraData)obj).antialiasing = (AntialiasingMode)0;
		((UniversalAdditionalCameraData)obj).cameraStack.Clear();
		Transform transform = base.transform;
		camera.transform.SetPositionAndRotation(transform.position, transform.rotation);
		camera.depth = -10f;
		camera.enabled = false;
		camera.allowMSAA = false;
		gameObject.hideFlags = HideFlags.HideAndDontSave;
		_isRefCamCreated = true;
		return camera;
	}
}
