using System;
using UnityEngine.Experimental.Rendering;
using XPostProcessing;

namespace UnityEngine.Rendering.Universal;

public class AtmosphereBuild : ScriptableRenderPass
{
	private readonly VolumeComponentCache m_VolumeComponents;

	private int kernel;

	private int kernel2;

	private int kernel3;

	private int kernel4;

	private int kernel5;

	private int kernel6;

	private Texture2D PreIntegralLUT;

	private Texture2D PreIntegralMultiScatterLUT;

	private Texture2D PrecomputedSceneScatterDepthLUT;

	private readonly GraphicsFormat sceneScatterDepthFormat;

	private ComputeShader atmCS;

	private RenderTexture AtmosphereScatterLUT;

	private RenderTexture SkyLUT;

	private RenderTexture MultiScatterLUT;

	private RenderTexture MultiScatterG2LUT;

	private RenderTexture MultiScatterTransLUT;

	private RenderTexture SceneScatterLUT;

	private RenderTexture SceneScatterLUT2;

	private RenderTexture SceneScatterDepthLUT;

	private RenderTexture SceneScatterDepthLUT2;

	private RenderTexture SceneScatterApproximationLUT;

	public static Vector3 AtmosphereSunDir;

	private static int MultiScatterLUTTransTag = Shader.PropertyToID("_MultiScatterTransLUT");

	private static int MultiScatterLUTG2Tag = Shader.PropertyToID("_MultiScatterG2LUT");

	private static int MultiScatterLUTTag = Shader.PropertyToID("_MultiScatterLUT");

	private static int MultiScatterLUTTexTag = Shader.PropertyToID("_MultiScatterLUTTex");

	private static int SkySphereLUTTag = Shader.PropertyToID("_SkySphereLUT");

	private static int AtmosphereLUTTag = Shader.PropertyToID("_AtmosphereLUT");

	private static int AtmosphereSunDirTag = Shader.PropertyToID("_AtmosphereSunDir");

	private static int SunColorTag = Shader.PropertyToID("_sunColor");

	private static int MoonColorTag = Shader.PropertyToID("_moonColor");

	private static int AtmIntensityDataTag = Shader.PropertyToID("_AtmIntensityData");

	private static int AtmMieFactorTag = Shader.PropertyToID("_AtmMieFactor");

	private static int AtmosphereSkyRotationTag = Shader.PropertyToID("_AtmosphereSkyRotation");

	private static int FrameTag = Shader.PropertyToID("_Frame");

	private static int TargetResolutionTag = Shader.PropertyToID("_TargetResolution");

	private static int AtmosphereLUTComputeTag = Shader.PropertyToID("_atmosphereLUT");

	private static int TemporalRefreshTag = Shader.PropertyToID("_temporalRefresh");

	private static int MultiScatterDataTag = Shader.PropertyToID("_MultiScatterData");

	private static int SkyLUTComputeTag = Shader.PropertyToID("_skyLUT");

	private static int ScatterXYZSizeTag = Shader.PropertyToID("_ScatterXYZSize");

	private static int SceneScatterLUTTag = Shader.PropertyToID("_SceneScatterLUT");

	private static int AirScatterColorTag = Shader.PropertyToID("_AirScatterColor");

	private static int SceneScatterDataTag = Shader.PropertyToID("_sceneScatterData");

	private static int SceneScatterData2Tag = Shader.PropertyToID("_sceneScatterData2");

	private static int SceneScatterLUTSampleTag = Shader.PropertyToID("_SceneScatterLUTSample");

	private static int SceneScatterTag = Shader.PropertyToID("_SceneScatter");

	private static int SceneScatterDepthWriteTag = Shader.PropertyToID("_SceneScatterDepthWrite");

	private static int SceneScatterDepthHistoryTag = Shader.PropertyToID("_SceneScatterDepthHistory");

	private static int SceneScatterDepthTag = Shader.PropertyToID("_SceneScatterDepth");

	private static int SceneScatterTexelSizeTag = Shader.PropertyToID("_SceneScatterTexelSize");

	private static int SceneScatterHistoryValidTag = Shader.PropertyToID("_SceneScatterHistoryValid");

	private static int SceneScatterModeTag = Shader.PropertyToID("_SceneScatterMode");

	private static int SceneScatterApproximationLUTTag = Shader.PropertyToID("_SceneScatterApproximationLUT");

	private static int SceneScatterApproximationLUTWriteTag = Shader.PropertyToID("_SceneScatterApproximationLUTWrite");

	private static int SceneScatterDepthLutDataTag = Shader.PropertyToID("_SceneScatterDepthLutData");

	private Vector2 sceneScatterResolution;

	private const int SceneScatterDepthLutWidth = 64;

	private const int SceneScatterDepthLutHeight = 32;

	private const float SceneScatterHistoryDepthThreshold = 0.05f;

	private int sceneScatterFrame;

	private bool sceneScatterHistoryValid;

	private int lastSceneScatterCameraId;

	private int lastSceneScatterUnityFrame = -1;

	private Vector3 lastSceneScatterCameraPosition;

	private Quaternion lastSceneScatterCameraRotation;

	private float lastSceneScatterFieldOfView;

	private float lastSceneScatterOrthographicSize;

	private float lastSceneScatterAspect;

	private float lastSceneScatterNearClip;

	private float lastSceneScatterFarClip;

	private bool lastSceneScatterOrthographic;

	private bool hasSceneScatterState;

	private Vector4 lastSceneScatterData;

	private Vector4 lastSceneScatterData2;

	private Vector4 lastSceneScatterAtmosphereIntensityData;

	private Color lastSceneScatterAirColor;

	private Vector3 lastSceneScatterSunDirection;

	private Color lastSceneScatterSunColor;

	private Color lastSceneScatterMoonColor;

	private bool hasSceneScatterApproximationState;

	private Vector4 lastSceneScatterApproximationData;

	private Vector4 lastSceneScatterApproximationData2;

	private Vector4 lastSceneScatterApproximationAtmosphereIntensityData;

	private Color lastSceneScatterApproximationAirColor;

	private Vector3 lastSceneScatterApproximationSunDirection;

	private Color lastSceneScatterApproximationSunColor;

	private Color lastSceneScatterApproximationMoonColor;

	private int Frame;

	private const int AtmosphereLutConvergeFrameCount = 64;

	private const int SkyLutConvergeFrameCount = 4;

	private const float SkySunDirectionFollowSpeedDegrees = 30f;

	private const int MultiScatterConvergeFrameCount = 600;

	private const bool StopLutUpdatesAfterConvergence = true;

	private bool hasAtmosphereLutState;

	private bool lastGenerateAtmosphereLUT;

	private Vector4 lastAtmosphereLutIntensityData;

	private int atmosphereLutFramesSinceChange;

	private bool hasSkyLutState;

	private bool lastSkyGenerateAtmosphereLUT;

	private Vector3 lastAtmosphereSunDir;

	private Color lastSunColor;

	private Color lastMoonColor;

	private Vector4 lastSkyIntensityData;

	private Vector4 lastSkyMieFactorData;

	private int skyLutFramesSinceChange;

	private int skyLutFramesSinceMipGeneration;

	private bool hasSkyLutSunDirection;

	private Vector3 skyLutSunDirection;

	private bool hasMultiScatterState;

	private bool lastMultiGenerateAtmosphereLUT;

	private Vector4 lastMultiIntensityData;

	private int multiScatterFramesSinceChange;

	private const int SkySphereLutSizeH = 256;

	private RenderTexture[] scatterRTList;

	private RenderTexture[] scatterDepthRTList;

	internal bool hasAllocatedResources
	{
		get
		{
			if (!(AtmosphereScatterLUT != null) && !(SkyLUT != null) && !(MultiScatterLUT != null) && (!(SceneScatterLUT != null) || !SceneScatterLUT.IsCreated()))
			{
				return SceneScatterApproximationLUT != null;
			}
			return true;
		}
	}

	internal AtmosphereBuild(ComputeShader AtmosphereCS, Texture2D PreIntegralTexture, Texture2D PreIntegralMultiScatterTexture, Texture2D PrecomputedSceneScatterDepthTexture, VolumeComponentCache volumeComponents)
	{
		m_VolumeComponents = volumeComponents;
		profilingSampler = new ProfilingSampler("AtmosphereBuild");
		renderPassEvent = RenderPassEvent.AtmospherePass;
		atmCS = AtmosphereCS;
		targetCount = 0u;
		PreIntegralLUT = PreIntegralTexture;
		PreIntegralMultiScatterLUT = PreIntegralMultiScatterTexture;
		PrecomputedSceneScatterDepthLUT = PrecomputedSceneScatterDepthTexture;
		sceneScatterDepthFormat = GraphicsFormat.R16_SFloat;
		SceneScatterLUT = CreateTextureShell("_SceneScatterLUT", FilterMode.Bilinear);
		SceneScatterLUT2 = CreateTextureShell("_SceneScatterLUT2", FilterMode.Bilinear);
		SceneScatterDepthLUT = CreateTextureShell("_SceneScatterDepth", FilterMode.Point);
		SceneScatterDepthLUT2 = CreateTextureShell("_SceneScatterDepth2", FilterMode.Point);
		scatterRTList = new RenderTexture[2] { SceneScatterLUT, SceneScatterLUT2 };
		scatterDepthRTList = new RenderTexture[2] { SceneScatterDepthLUT, SceneScatterDepthLUT2 };
		kernel = atmCS.FindKernel("PreIntegralAtmosphere");
		kernel2 = atmCS.FindKernel("SkyLutCalculate");
		kernel3 = atmCS.FindKernel("SceneScatterLutCalculateOptimized");
		kernel4 = atmCS.FindKernel("SceneScatterLutTAAOptimized");
		kernel5 = atmCS.FindKernel("MultiScatter");
		kernel6 = atmCS.FindKernel("SceneScatterDepthLutCalculate");
	}

	public void CreateAtmosphereLUT()
	{
		AtmosphereScatterLUT = new RenderTexture(256, 128, GraphicsFormat.R16G16B16A16_SFloat, GraphicsFormat.None, 0);
		AtmosphereScatterLUT.name = "_AtmosphereLUT";
		AtmosphereScatterLUT.hideFlags = HideFlags.HideAndDontSave;
		AtmosphereScatterLUT.wrapMode = TextureWrapMode.Clamp;
		AtmosphereScatterLUT.enableRandomWrite = true;
		AtmosphereScatterLUT.Create();
	}

	private void CreateLUTSkySphere()
	{
		SkyLUT = new RenderTexture(256, 256, GraphicsFormat.R16G16B16A16_SFloat, GraphicsFormat.None, 0);
		SkyLUT.name = "_SkySphereLUT";
		SkyLUT.hideFlags = HideFlags.HideAndDontSave;
		SkyLUT.wrapModeU = TextureWrapMode.Repeat;
		SkyLUT.wrapModeV = TextureWrapMode.Clamp;
		SkyLUT.enableRandomWrite = true;
		SkyLUT.autoGenerateMips = false;
		SkyLUT.useMipMap = true;
		SkyLUT.Create();
	}

	private void CreatLUTSceneScatter(Vector3 sceneScatterLUTResolution)
	{
		int width = (int)sceneScatterLUTResolution.x;
		int height = (int)sceneScatterLUTResolution.y;
		RenderTextureDescriptor renderTextureDescriptor = new RenderTextureDescriptor(width, height, RenderTextureFormat.RGB111110Float, 0);
		renderTextureDescriptor.dimension = TextureDimension.Tex2D;
		renderTextureDescriptor.depthStencilFormat = GraphicsFormat.None;
		renderTextureDescriptor.enableRandomWrite = true;
		renderTextureDescriptor.volumeDepth = 1;
		renderTextureDescriptor.useMipMap = false;
		renderTextureDescriptor.autoGenerateMips = false;
		RenderTextureDescriptor descriptor = renderTextureDescriptor;
		CreateTextureStorage(SceneScatterLUT, descriptor, "_SceneScatterLUT", FilterMode.Bilinear);
		CreateTextureStorage(SceneScatterLUT2, descriptor, "_SceneScatterLUT2", FilterMode.Bilinear);
		renderTextureDescriptor = new RenderTextureDescriptor(width, height);
		renderTextureDescriptor.graphicsFormat = sceneScatterDepthFormat;
		renderTextureDescriptor.depthStencilFormat = GraphicsFormat.None;
		renderTextureDescriptor.enableRandomWrite = true;
		renderTextureDescriptor.useMipMap = false;
		renderTextureDescriptor.autoGenerateMips = false;
		RenderTextureDescriptor descriptor2 = renderTextureDescriptor;
		CreateTextureStorage(SceneScatterDepthLUT, descriptor2, "_SceneScatterDepth", FilterMode.Point);
		CreateTextureStorage(SceneScatterDepthLUT2, descriptor2, "_SceneScatterDepth2", FilterMode.Point);
		scatterRTList[0] = SceneScatterLUT;
		scatterRTList[1] = SceneScatterLUT2;
		scatterDepthRTList[0] = SceneScatterDepthLUT;
		scatterDepthRTList[1] = SceneScatterDepthLUT2;
		sceneScatterHistoryValid = false;
	}

	private static RenderTexture CreateTextureShell(string name, FilterMode filterMode)
	{
		return new RenderTexture(1, 1, 0)
		{
			hideFlags = HideFlags.HideAndDontSave,
			name = name,
			filterMode = filterMode,
			wrapMode = TextureWrapMode.Clamp
		};
	}

	private static void CreateTextureStorage(RenderTexture texture, RenderTextureDescriptor descriptor, string name, FilterMode filterMode)
	{
		texture.descriptor = descriptor;
		texture.name = name;
		texture.filterMode = filterMode;
		texture.wrapMode = TextureWrapMode.Clamp;
		texture.Create();
	}

	private void CreateSceneScatterApproximationLUT()
	{
		SceneScatterApproximationLUT = new RenderTexture(64, 32, GraphicsFormat.R16G16B16A16_SFloat, GraphicsFormat.None);
		SceneScatterApproximationLUT.name = "_SceneScatterApproximationLUT";
		SceneScatterApproximationLUT.hideFlags = HideFlags.HideAndDontSave;
		SceneScatterApproximationLUT.enableRandomWrite = true;
		SceneScatterApproximationLUT.useMipMap = false;
		SceneScatterApproximationLUT.filterMode = FilterMode.Bilinear;
		SceneScatterApproximationLUT.wrapMode = TextureWrapMode.Clamp;
		SceneScatterApproximationLUT.Create();
		hasSceneScatterApproximationState = false;
	}

	private void ReleaseAtmosphereLUT()
	{
		if (AtmosphereScatterLUT != null)
		{
			if (AtmosphereScatterLUT.IsCreated())
			{
				AtmosphereScatterLUT.Release();
			}
			CoreUtils.Destroy(AtmosphereScatterLUT);
			AtmosphereScatterLUT = null;
		}
		hasAtmosphereLutState = false;
		atmosphereLutFramesSinceChange = 0;
	}

	private void ReleaseLUTSkySphere()
	{
		if (SkyLUT != null)
		{
			if (SkyLUT.IsCreated())
			{
				SkyLUT.Release();
			}
			CoreUtils.Destroy(SkyLUT);
			SkyLUT = null;
		}
		ReleaseMultiScatterLUT();
		hasSkyLutState = false;
		skyLutFramesSinceChange = 0;
		skyLutFramesSinceMipGeneration = 0;
		hasSkyLutSunDirection = false;
		Frame = 0;
	}

	private void ReleaseMultiScatterLUT()
	{
		if (MultiScatterLUT != null)
		{
			if (MultiScatterLUT.IsCreated())
			{
				MultiScatterLUT.Release();
			}
			CoreUtils.Destroy(MultiScatterLUT);
			MultiScatterLUT = null;
		}
		if (MultiScatterG2LUT != null)
		{
			if (MultiScatterG2LUT.IsCreated())
			{
				MultiScatterG2LUT.Release();
			}
			CoreUtils.Destroy(MultiScatterG2LUT);
			MultiScatterG2LUT = null;
		}
		if (MultiScatterTransLUT != null)
		{
			if (MultiScatterTransLUT.IsCreated())
			{
				MultiScatterTransLUT.Release();
			}
			CoreUtils.Destroy(MultiScatterTransLUT);
			MultiScatterTransLUT = null;
		}
		hasMultiScatterState = false;
		multiScatterFramesSinceChange = 0;
	}

	private void ReleaseLUTSceneScatter(bool destroyTextures = false)
	{
		if (SceneScatterLUT != null)
		{
			if (SceneScatterLUT.IsCreated())
			{
				SceneScatterLUT.Release();
			}
			if (destroyTextures)
			{
				CoreUtils.Destroy(SceneScatterLUT);
				SceneScatterLUT = null;
			}
		}
		if (SceneScatterLUT2 != null)
		{
			if (SceneScatterLUT2.IsCreated())
			{
				SceneScatterLUT2.Release();
			}
			if (destroyTextures)
			{
				CoreUtils.Destroy(SceneScatterLUT2);
				SceneScatterLUT2 = null;
			}
		}
		if (SceneScatterDepthLUT != null)
		{
			if (SceneScatterDepthLUT.IsCreated())
			{
				SceneScatterDepthLUT.Release();
			}
			if (destroyTextures)
			{
				CoreUtils.Destroy(SceneScatterDepthLUT);
				SceneScatterDepthLUT = null;
			}
		}
		if (SceneScatterDepthLUT2 != null)
		{
			if (SceneScatterDepthLUT2.IsCreated())
			{
				SceneScatterDepthLUT2.Release();
			}
			if (destroyTextures)
			{
				CoreUtils.Destroy(SceneScatterDepthLUT2);
				SceneScatterDepthLUT2 = null;
			}
		}
		if (destroyTextures)
		{
			scatterRTList = null;
			scatterDepthRTList = null;
		}
		sceneScatterHistoryValid = false;
		hasSceneScatterState = false;
		sceneScatterFrame = 0;
	}

	private void ReleaseSceneScatterApproximationLUT()
	{
		if (SceneScatterApproximationLUT != null)
		{
			if (SceneScatterApproximationLUT.IsCreated())
			{
				SceneScatterApproximationLUT.Release();
			}
			CoreUtils.Destroy(SceneScatterApproximationLUT);
			SceneScatterApproximationLUT = null;
		}
		hasSceneScatterApproximationState = false;
	}

	private void swapList(ref RenderTexture[] list)
	{
		RenderTexture[] obj = list;
		RenderTexture[] array = list;
		RenderTexture renderTexture = list[1];
		RenderTexture renderTexture2 = list[0];
		obj[0] = renderTexture;
		array[1] = renderTexture2;
	}

	public void Dispose()
	{
		ReleaseAtmosphereLUT();
		ReleaseLUTSkySphere();
		ReleaseLUTSceneScatter(destroyTextures: true);
		ReleaseSceneScatterApproximationLUT();
	}

	internal void ReleasePersistentRenderResources()
	{
		ReleaseAtmosphereLUT();
		ReleaseLUTSkySphere();
		ReleaseLUTSceneScatter();
		ReleaseSceneScatterApproximationLUT();
	}

	private bool CheckAtmosphereLutStateChanged(bool generateAtmosphereLUT, Vector4 intensityData)
	{
		if (!hasAtmosphereLutState || lastGenerateAtmosphereLUT != generateAtmosphereLUT || lastAtmosphereLutIntensityData != intensityData)
		{
			hasAtmosphereLutState = true;
			lastGenerateAtmosphereLUT = generateAtmosphereLUT;
			lastAtmosphereLutIntensityData = intensityData;
			return true;
		}
		return false;
	}

	private bool CheckSkyLutStateChanged(bool generateAtmosphereLUT, Vector3 atmosphereSunDir, Color sunColor, Color moonColor, Vector4 intensityData, Vector4 mieFactorData)
	{
		if (!hasSkyLutState || lastSkyGenerateAtmosphereLUT != generateAtmosphereLUT || lastAtmosphereSunDir != atmosphereSunDir || lastSunColor != sunColor || lastMoonColor != moonColor || lastSkyIntensityData != intensityData || lastSkyMieFactorData != mieFactorData)
		{
			hasSkyLutState = true;
			lastSkyGenerateAtmosphereLUT = generateAtmosphereLUT;
			lastAtmosphereSunDir = atmosphereSunDir;
			lastSunColor = sunColor;
			lastMoonColor = moonColor;
			lastSkyIntensityData = intensityData;
			lastSkyMieFactorData = mieFactorData;
			return true;
		}
		return false;
	}

	private bool CheckMultiScatterStateChanged(bool generateAtmosphereLUT, Vector4 intensityData)
	{
		if (!hasMultiScatterState || lastMultiGenerateAtmosphereLUT != generateAtmosphereLUT || lastMultiIntensityData != intensityData)
		{
			hasMultiScatterState = true;
			lastMultiGenerateAtmosphereLUT = generateAtmosphereLUT;
			lastMultiIntensityData = intensityData;
			return true;
		}
		return false;
	}

	private bool CheckSceneScatterStateChanged(Vector4 sceneScatterData, Vector4 sceneScatterData2, Vector4 atmosphereIntensityData, Color airColor, Vector3 sunDirection, Color sunColor, Color moonColor)
	{
		if (!hasSceneScatterState || lastSceneScatterData != sceneScatterData || lastSceneScatterData2 != sceneScatterData2 || lastSceneScatterAtmosphereIntensityData != atmosphereIntensityData || lastSceneScatterAirColor != airColor || lastSceneScatterSunDirection != sunDirection || lastSceneScatterSunColor != sunColor || lastSceneScatterMoonColor != moonColor)
		{
			hasSceneScatterState = true;
			lastSceneScatterData = sceneScatterData;
			lastSceneScatterData2 = sceneScatterData2;
			lastSceneScatterAtmosphereIntensityData = atmosphereIntensityData;
			lastSceneScatterAirColor = airColor;
			lastSceneScatterSunDirection = sunDirection;
			lastSceneScatterSunColor = sunColor;
			lastSceneScatterMoonColor = moonColor;
			return true;
		}
		return false;
	}

	private bool CheckSceneScatterApproximationStateChanged(Vector4 sceneScatterData, Vector4 sceneScatterData2, Vector4 atmosphereIntensityData, Color airColor, Vector3 sunDirection, Color sunColor, Color moonColor)
	{
		if (!hasSceneScatterApproximationState || lastSceneScatterApproximationData != sceneScatterData || lastSceneScatterApproximationData2 != sceneScatterData2 || lastSceneScatterApproximationAtmosphereIntensityData != atmosphereIntensityData || lastSceneScatterApproximationAirColor != airColor || lastSceneScatterApproximationSunDirection != sunDirection || lastSceneScatterApproximationSunColor != sunColor || lastSceneScatterApproximationMoonColor != moonColor)
		{
			hasSceneScatterApproximationState = true;
			lastSceneScatterApproximationData = sceneScatterData;
			lastSceneScatterApproximationData2 = sceneScatterData2;
			lastSceneScatterApproximationAtmosphereIntensityData = atmosphereIntensityData;
			lastSceneScatterApproximationAirColor = airColor;
			lastSceneScatterApproximationSunDirection = sunDirection;
			lastSceneScatterApproximationSunColor = sunColor;
			lastSceneScatterApproximationMoonColor = moonColor;
			return true;
		}
		return false;
	}

	private bool IsSceneScatterCameraCut(Camera camera, float maxScatterDistance)
	{
		int instanceID = camera.GetInstanceID();
		if (!sceneScatterHistoryValid || lastSceneScatterCameraId != instanceID)
		{
			return true;
		}
		if (Application.isPlaying && lastSceneScatterUnityFrame >= 0 && Time.frameCount > lastSceneScatterUnityFrame + 1)
		{
			return true;
		}
		float num = Mathf.Max(10f, maxScatterDistance * 0.25f);
		if ((camera.transform.position - lastSceneScatterCameraPosition).sqrMagnitude > num * num || Quaternion.Angle(camera.transform.rotation, lastSceneScatterCameraRotation) > 30f)
		{
			return true;
		}
		if (camera.orthographic == lastSceneScatterOrthographic && !(Mathf.Abs(camera.fieldOfView - lastSceneScatterFieldOfView) > 0.1f) && !(Mathf.Abs(camera.orthographicSize - lastSceneScatterOrthographicSize) > 0.01f) && !(Mathf.Abs(camera.aspect - lastSceneScatterAspect) > 0.001f) && !(Mathf.Abs(camera.nearClipPlane - lastSceneScatterNearClip) > 0.001f))
		{
			return Mathf.Abs(camera.farClipPlane - lastSceneScatterFarClip) > 0.1f;
		}
		return true;
	}

	private void StoreSceneScatterCameraState(Camera camera)
	{
		lastSceneScatterCameraId = camera.GetInstanceID();
		lastSceneScatterUnityFrame = Time.frameCount;
		lastSceneScatterCameraPosition = camera.transform.position;
		lastSceneScatterCameraRotation = camera.transform.rotation;
		lastSceneScatterFieldOfView = camera.fieldOfView;
		lastSceneScatterOrthographicSize = camera.orthographicSize;
		lastSceneScatterAspect = camera.aspect;
		lastSceneScatterNearClip = camera.nearClipPlane;
		lastSceneScatterFarClip = camera.farClipPlane;
		lastSceneScatterOrthographic = camera.orthographic;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		Atmosphere atmosphere = m_VolumeComponents.Atmosphere;
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			bool flag = !Application.isPlaying;
			float value = atmosphere.SkyVerticalRotation.value;
			float f = value * (MathF.PI / 180f);
			cmd.SetGlobalVector(AtmosphereSkyRotationTag, new Vector4(Mathf.Sin(f), Mathf.Cos(f), (Mathf.Abs(value) > 0.0001f) ? 1f : 0f, 0f));
			bool flag2 = atmosphere.IsActive();
			if (atmosphere.RefreshActive.value)
			{
				if (SkyLUT == null)
				{
					CreateLUTSkySphere();
					cmd.SetGlobalTexture(SkySphereLUTTag, SkyLUT);
					hasSkyLutState = false;
					hasMultiScatterState = false;
					skyLutFramesSinceChange = 0;
					skyLutFramesSinceMipGeneration = 0;
					hasSkyLutSunDirection = false;
					multiScatterFramesSinceChange = 0;
					Frame = 0;
					cmd.SetRenderTarget(SkyLUT);
					cmd.ClearRenderTarget(clearDepth: false, clearColor: true, Color.black);
					cmd.GenerateMips(SkyLUT);
				}
			}
			else if (SkyLUT != null)
			{
				ReleaseLUTSkySphere();
			}
			bool value2 = atmosphere.RefreshAtmosphereLUT.value;
			if (value2)
			{
				if (AtmosphereScatterLUT == null)
				{
					CreateAtmosphereLUT();
					cmd.SetGlobalTexture(AtmosphereLUTTag, AtmosphereScatterLUT);
					hasAtmosphereLutState = false;
					atmosphereLutFramesSinceChange = 0;
				}
			}
			else
			{
				if (AtmosphereScatterLUT != null)
				{
					ReleaseAtmosphereLUT();
				}
				cmd.SetGlobalTexture(AtmosphereLUTTag, PreIntegralLUT);
			}
			_ = atmosphere.SceneScatter.value;
			bool flag3 = atmosphere.SceneScatterDepthLutSource.value == SceneScatterDepthLutSource.Precomputed;
			bool flag4 = (PrecomputedSceneScatterDepthLUT != null) & flag3;
			bool flag5 = false;
			cmd.SetGlobalFloat(SceneScatterModeTag, flag5 ? 2f : 0f);
			if (SceneScatterLUT.IsCreated())
			{
				ReleaseLUTSceneScatter();
			}
			if (!flag5 && SceneScatterApproximationLUT != null)
			{
				ReleaseSceneScatterApproximationLUT();
			}
			if (!flag2)
			{
				return;
			}
			float value3 = atmosphere.MieIntensity.value;
			float value4 = atmosphere.RayleighIntensity.value;
			float value5 = atmosphere.OzoneIntensity.value;
			float value6 = atmosphere.MultiScatterIntensity.value;
			float value7 = atmosphere.MieFactor.value;
			float value8 = atmosphere.MieHeight.value;
			Color value9 = atmosphere.SunColor.value;
			value9.a = atmosphere.AddLitIntensity.value;
			Color value10 = atmosphere.MoonColor.value;
			float value11 = atmosphere.TimeOfDay.value;
			bool value12 = atmosphere.LockToMainLight.value;
			LightData lightData = renderingData.lightData;
			AtmosphereSunDir = new Vector3(0f, 0f, 1f);
			if (lightData.mainLightIndex >= 0 && lightData.visibleLights.Length > 0)
			{
				Vector3 vector = -lightData.visibleLights[lightData.mainLightIndex].light.transform.forward;
				if (!value12)
				{
					Vector3 normalized = Vector3.Cross(vector, new Vector3(0f, 1f, 0f)).normalized;
					value11 = value11 / 24f * MathF.PI * 2f;
					AtmosphereSunDir = Quaternion.AngleAxis(57.29578f * value11, normalized) * new Vector3(0f, -1f, 0f);
				}
				else
				{
					AtmosphereSunDir = vector;
				}
			}
			Vector3 sunDirection = ((lightData.mainLightIndex >= 0 && lightData.visibleLights.Length > 0) ? (-lightData.visibleLights[lightData.mainLightIndex].light.transform.forward) : AtmosphereSunDir);
			cmd.SetGlobalVector(AtmosphereSunDirTag, AtmosphereSunDir);
			cmd.SetGlobalVector(SunColorTag, value9);
			cmd.SetGlobalVector(MoonColorTag, value10);
			Vector4 vector2 = new Vector4(atmosphere.SceneScatterIteration.value, atmosphere.SceneScatterDensity.value, atmosphere.SceneScatterLength.value, atmosphere.SceneMieScatterFactor.value);
			Vector4 vector3 = new Vector4(atmosphere.SceneScatterIntensity.value, atmosphere.SceneScatterCameraHeight.value, 0.05f, 0f);
			cmd.SetGlobalVector(SceneScatterDataTag, vector2);
			cmd.SetGlobalVector(SceneScatterData2Tag, vector3);
			cmd.SetGlobalVector(AirScatterColorTag, atmosphere.AirScatterColor.value);
			cmd.SetGlobalVector(SceneScatterDepthLutDataTag, new Vector4(atmosphere.SceneScatterLength.value, 1f / Mathf.Max(atmosphere.SceneScatterLength.value, 0.0001f), 64f, 32f));
			Vector4 vector4 = new Vector4(value3, value4, value5, value8);
			cmd.SetGlobalVector(AtmIntensityDataTag, vector4);
			bool flag6 = atmosphere.RefreshActive.value && value6 > 0.0001f && PreIntegralMultiScatterLUT != null;
			float y = (flag6 ? value6 : 0f);
			Vector4 vector5 = new Vector4(value7, y, 0f, 0f);
			cmd.SetGlobalVector(AtmMieFactorTag, vector5);
			cmd.SetGlobalTexture(MultiScatterLUTTexTag, flag6 ? PreIntegralMultiScatterLUT : Texture2D.blackTexture);
			bool flag7 = CheckAtmosphereLutStateChanged(value2, vector4);
			if (flag7)
			{
				atmosphereLutFramesSinceChange = 0;
			}
			bool flag8 = value2 && (flag || atmosphereLutFramesSinceChange < 64);
			bool flag9 = false;
			if (flag8)
			{
				cmd.SetComputeIntParam(atmCS, FrameTag, Frame);
				cmd.SetComputeVectorParam(atmCS, TargetResolutionTag, new Vector4(AtmosphereScatterLUT.width, AtmosphereScatterLUT.height, 0f, 0f));
				cmd.SetComputeTextureParam(atmCS, kernel, AtmosphereLUTComputeTag, AtmosphereScatterLUT);
				cmd.SetComputeIntParam(atmCS, TemporalRefreshTag, 1);
				cmd.DispatchCompute(atmCS, kernel, Mathf.CeilToInt((float)AtmosphereScatterLUT.width / 8f / 8f), Mathf.CeilToInt((float)AtmosphereScatterLUT.height / 8f / 8f), 1);
				atmosphereLutFramesSinceChange++;
				flag9 = true;
			}
			if (atmosphere.RefreshActive.value)
			{
				if (!hasSkyLutSunDirection)
				{
					skyLutSunDirection = AtmosphereSunDir;
					hasSkyLutSunDirection = true;
				}
				else
				{
					float num = (Application.isPlaying ? Mathf.Min(Time.unscaledDeltaTime, 1f / 15f) : (1f / 60f));
					skyLutSunDirection = Vector3.RotateTowards(skyLutSunDirection, AtmosphereSunDir, MathF.PI / 6f * num, 0f).normalized;
				}
				if (CheckSkyLutStateChanged(value2, skyLutSunDirection, value9, value10, vector4, vector5))
				{
					skyLutFramesSinceChange = 0;
				}
				bool flag10 = false;
				if ((flag || skyLutFramesSinceChange < 4) | flag8 | flag10)
				{
					cmd.SetComputeIntParam(atmCS, FrameTag, Frame);
					cmd.SetComputeVectorParam(atmCS, AtmosphereSunDirTag, skyLutSunDirection);
					cmd.SetComputeVectorParam(atmCS, TargetResolutionTag, new Vector4(SkyLUT.width, SkyLUT.height, 0f, 0f));
					cmd.SetComputeTextureParam(atmCS, kernel2, SkyLUTComputeTag, SkyLUT);
					cmd.DispatchCompute(atmCS, kernel2, Mathf.CeilToInt((float)SkyLUT.width / 8f / 2f), Mathf.CeilToInt((float)SkyLUT.height / 8f / 2f), 1);
					skyLutFramesSinceChange++;
					skyLutFramesSinceMipGeneration++;
					bool flag11 = !flag8 && !flag10 && skyLutFramesSinceChange == 4;
					if ((skyLutFramesSinceMipGeneration >= 4) | flag11)
					{
						cmd.GenerateMips(SkyLUT);
						skyLutFramesSinceMipGeneration = 0;
					}
					flag9 = true;
				}
			}
			if (flag9)
			{
				Frame++;
			}
			if (!flag5)
			{
				return;
			}
			if (flag4)
			{
				if (SceneScatterApproximationLUT != null)
				{
					ReleaseSceneScatterApproximationLUT();
				}
				cmd.SetGlobalTexture(SceneScatterApproximationLUTTag, PrecomputedSceneScatterDepthLUT);
				return;
			}
			if (SceneScatterApproximationLUT == null)
			{
				CreateSceneScatterApproximationLUT();
			}
			bool flag12 = CheckSceneScatterApproximationStateChanged(vector2, vector3, vector4, atmosphere.AirScatterColor.value, sunDirection, value9, value10);
			if (flag | flag12 | flag7 | flag8)
			{
				cmd.SetComputeTextureParam(atmCS, kernel6, SceneScatterApproximationLUTWriteTag, SceneScatterApproximationLUT);
				cmd.DispatchCompute(atmCS, kernel6, Mathf.CeilToInt(8f), Mathf.CeilToInt(4f), 1);
			}
			cmd.SetGlobalTexture(SceneScatterApproximationLUTTag, SceneScatterApproximationLUT);
		}
	}
}
