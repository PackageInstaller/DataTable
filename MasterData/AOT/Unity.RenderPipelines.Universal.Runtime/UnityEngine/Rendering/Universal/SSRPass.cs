using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public class SSRPass : ScriptableRenderPass
{
	private struct HistoryList
	{
		public RenderTexture history0;

		public RenderTexture history1;
	}

	private static class ShaderContants
	{
		public static readonly int ReflectTexID = Shader.PropertyToID("_SSRTex");

		public static readonly int SceneColorTexID = Shader.PropertyToID("_SSRSceneColorTex");

		public static readonly int ReflectDataTexID = Shader.PropertyToID("_SSRDataTex");

		public static readonly int TargetResolutionID = Shader.PropertyToID("_TargetResolution");

		public static readonly int RebuildResolutionID = Shader.PropertyToID("_RebuildResolution");

		public static readonly int SSRDataID = Shader.PropertyToID("_SSRData");

		public static readonly int CurrentID = Shader.PropertyToID("_currentTex");

		public static readonly int IntensityID = Shader.PropertyToID("_reflectIntensity");

		public static readonly int HiZDepthTextureID = Shader.PropertyToID("_SSRHiZDepthTexture");

		public static readonly int HistoryID = Shader.PropertyToID("_SSR_History");

		public static readonly int HistoryValidID = Shader.PropertyToID("_SSRHistoryValid");

		public static readonly int MaxRadianceID = Shader.PropertyToID("_SSRMaxRadiance");

		public static readonly int DeferredSSREnabledID = Shader.PropertyToID("_DeferredSSREnabled");
	}

	private enum SSRPassName
	{
		RayMartch,
		ApplySSR,
		RebuildReflect,
		SSRTAA,
		BlurH,
		BlurV,
		SimpleApply
	}

	private int downSample;

	private int loopCount;

	private float thickness;

	private float thicknessBack;

	private float intensity;

	private bool allEnable;

	private int rebuildDownSample;

	private Material SSRMaterial;

	private RenderTexture historyTex;

	private RenderTexture historyTex2;

	private HistoryList historyList;

	private bool historyValid;

	private int historyCameraId;

	private float historyFieldOfView;

	private float historyOrthographicSize;

	private bool historyOrthographic;

	private RenderTextureDescriptor rebuildTextureDescriptor;

	private int rebuildTexDownSample = 1;

	private bool enable;

	private bool releaseHiZ;

	private bool traceWithHiZ;

	private const float kMaxHitRadiance = 64f;

	private GlobalKeyword simpleWayKey;

	private GlobalKeyword traceHiZKey;

	private bool IsSimpleWay;

	private bool volumeSettingSimpleWay;

	private readonly RenderTargetIdentifier[] rebuildColorAttachments = new RenderTargetIdentifier[1];

	private readonly RenderTargetIdentifier[] temporalColorAttachments = new RenderTargetIdentifier[1];

	private readonly RenderBufferLoadAction[] rebuildColorLoadActions = new RenderBufferLoadAction[1] { RenderBufferLoadAction.DontCare };

	private readonly RenderBufferStoreAction[] rebuildColorStoreActions = new RenderBufferStoreAction[1];

	private RenderTargetBinding temporalRenderTargetBinding;

	private RenderTargetBinding rebuildRenderTargetBinding;

	private const int kMinSSRDataShortEdge = 256;

	internal void Setup(bool Enable, bool ReleaseHiZ = true)
	{
		enable = Enable;
		releaseHiZ = ReleaseHiZ;
		IsSimpleWay = volumeSettingSimpleWay;
		Shader.SetKeyword(in simpleWayKey, IsSimpleWay);
	}

	public SSRPass(Material mat)
	{
		profilingSampler = new ProfilingSampler("SSRPass");
		renderPassEvent = RenderPassEvent.SSRPass;
		targetCount = 0u;
		SSRMaterial = mat;
		historyTex = CreateTextureShell("_SSRHistory");
		historyTex2 = CreateTextureShell("_SSRHistory2");
		simpleWayKey = GlobalKeyword.Create("_IS_SIMPLE_SSR");
		traceHiZKey = GlobalKeyword.Create("_SSR_TRACE_HIZ");
	}

	private static RenderTexture CreateTextureShell(string name)
	{
		return new RenderTexture(1, 1, 0)
		{
			hideFlags = HideFlags.HideAndDontSave,
			name = name,
			filterMode = FilterMode.Bilinear,
			wrapMode = TextureWrapMode.Clamp
		};
	}

	private static Vector2Int CalculateSSRDataSize(int sourceWidth, int sourceHeight, int downSample)
	{
		sourceWidth = Mathf.Max(1, sourceWidth);
		sourceHeight = Mathf.Max(1, sourceHeight);
		int num = Mathf.Min(sourceWidth, sourceHeight);
		int num2 = Mathf.Min(256, num);
		float num3 = Mathf.Max(1f / (float)Mathf.Max(1, downSample), (float)num2 / (float)num);
		int x = Mathf.Min(sourceWidth, Mathf.CeilToInt((float)sourceWidth * num3));
		int y = Mathf.Min(sourceHeight, Mathf.CeilToInt((float)sourceHeight * num3));
		return new Vector2Int(x, y);
	}

	private bool checkDescriptor(RenderTextureDescriptor desc)
	{
		if (rebuildTextureDescriptor.width == Mathf.Max(1, desc.width / rebuildTexDownSample))
		{
			return rebuildTextureDescriptor.height == Mathf.Max(1, desc.height / rebuildTexDownSample);
		}
		return false;
	}

	private void creatHistoryRT(RenderTextureDescriptor desc)
	{
		if (!historyTex.IsCreated())
		{
			historyTex.descriptor = desc;
			historyTex.name = "_SSRHistory";
			historyTex.filterMode = FilterMode.Bilinear;
			historyTex.wrapMode = TextureWrapMode.Clamp;
			historyTex.Create();
			historyList.history0 = historyTex;
			historyValid = false;
		}
		if (!historyTex2.IsCreated())
		{
			historyTex2.descriptor = desc;
			historyTex2.name = "_SSRHistory2";
			historyTex2.filterMode = FilterMode.Bilinear;
			historyTex2.wrapMode = TextureWrapMode.Clamp;
			historyTex2.Create();
			historyList.history1 = historyTex2;
			historyValid = false;
		}
	}

	private void ChangeHistoryList()
	{
		ref RenderTexture history = ref historyList.history1;
		ref RenderTexture history2 = ref historyList.history0;
		RenderTexture history3 = historyList.history0;
		RenderTexture history4 = historyList.history1;
		history = history3;
		history2 = history4;
	}

	private void releaseHistoryRT(bool destroyTextures = false)
	{
		if (historyTex != null)
		{
			if (historyTex.IsCreated())
			{
				historyTex.Release();
			}
			if (destroyTextures)
			{
				CoreUtils.Destroy(historyTex);
				historyTex = null;
			}
		}
		if (historyTex2 != null)
		{
			if (historyTex2.IsCreated())
			{
				historyTex2.Release();
			}
			if (destroyTextures)
			{
				CoreUtils.Destroy(historyTex2);
				historyTex2 = null;
			}
		}
		historyList = default;
		historyValid = false;
	}

	internal void ReleaseResources(bool destroyTextures = false)
	{
		releaseHistoryRT(destroyTextures);
	}

	public void SetData(SSRFeature.SSRSettings settings, bool traceWithHiZ)
	{
		int num = Mathf.Max(1, settings.downSample);
		int num2 = Mathf.Max(1, settings.loopCount);
		int num3 = Mathf.Max(1, settings.rebuildDownSample);
		bool num4 = volumeSettingSimpleWay != settings.SimpleWay || downSample != num || loopCount != num2 || !Mathf.Approximately(thickness, settings.thickness) || !Mathf.Approximately(thicknessBack, settings.thicknessBack) || !Mathf.Approximately(intensity, settings.Intensity) || allEnable != settings.AllEnable || rebuildDownSample != num3 || this.traceWithHiZ != traceWithHiZ;
		volumeSettingSimpleWay = settings.SimpleWay;
		downSample = num;
		loopCount = num2;
		thickness = settings.thickness;
		thicknessBack = settings.thicknessBack;
		intensity = settings.Intensity;
		allEnable = settings.AllEnable;
		rebuildDownSample = num3;
		this.traceWithHiZ = traceWithHiZ;
		if (num4)
		{
			historyValid = false;
		}
	}

	internal static void DisableForDeferred(CommandBuffer cmd)
	{
		cmd.DisableKeyword(in ShaderKeywords.SSRKeyword);
		cmd.SetGlobalFloat(ShaderContants.DeferredSSREnabledID, 0f);
		cmd.SetGlobalTexture(ShaderContants.ReflectTexID, Texture2D.blackTexture);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		cmd.BeginSample("SSRPass");
		cmd.SetKeyword(in traceHiZKey, traceWithHiZ);
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		RenderTargetIdentifier cameraColorTarget = renderingData.cameraData.renderer.cameraColorTarget;
		Camera camera = renderingData.cameraData.camera;
		int instanceID = camera.GetInstanceID();
		if (historyCameraId != instanceID || historyOrthographic != camera.orthographic || (!camera.orthographic && !Mathf.Approximately(historyFieldOfView, camera.fieldOfView)) || (camera.orthographic && !Mathf.Approximately(historyOrthographicSize, camera.orthographicSize)))
		{
			historyValid = false;
			historyCameraId = instanceID;
			historyOrthographic = camera.orthographic;
			historyFieldOfView = camera.fieldOfView;
			historyOrthographicSize = camera.orthographicSize;
		}
		if (!checkDescriptor(cameraTargetDescriptor) || rebuildTexDownSample != rebuildDownSample)
		{
			cameraTargetDescriptor.graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat;
			cameraTargetDescriptor.depthBufferBits = 0;
			cameraTargetDescriptor.depthStencilFormat = GraphicsFormat.None;
			cameraTargetDescriptor.msaaSamples = 1;
			cameraTargetDescriptor.bindMS = false;
			cameraTargetDescriptor.memoryless = RenderTextureMemoryless.None;
			cameraTargetDescriptor.useMipMap = false;
			cameraTargetDescriptor.autoGenerateMips = false;
			rebuildTexDownSample = rebuildDownSample;
			rebuildTextureDescriptor = cameraTargetDescriptor;
			rebuildTextureDescriptor.width = Mathf.Max(1, rebuildTextureDescriptor.width / rebuildTexDownSample);
			rebuildTextureDescriptor.height = Mathf.Max(1, rebuildTextureDescriptor.height / rebuildTexDownSample);
			releaseHistoryRT();
		}
		creatHistoryRT(rebuildTextureDescriptor);
		Vector2 vector = new Vector2(cameraTargetDescriptor.width, cameraTargetDescriptor.height);
		Vector2Int vector2Int = CalculateSSRDataSize(cameraTargetDescriptor.width, cameraTargetDescriptor.height, downSample);
		int x = vector2Int.x;
		int y = vector2Int.y;
		cmd.GetTemporaryRT(desc: new RenderTextureDescriptor(x, y, RenderTextureFormat.ARGBHalf, 0), nameID: ShaderContants.ReflectDataTexID, filter: FilterMode.Bilinear);
		rebuildTextureDescriptor.useMipMap = false;
		cmd.GetTemporaryRT(ShaderContants.CurrentID, rebuildTextureDescriptor, FilterMode.Trilinear);
		cmd.SetGlobalVector(ShaderContants.TargetResolutionID, new Vector4(x, y, loopCount, thickness));
		cmd.SetGlobalVector(ShaderContants.SSRDataID, new Vector4(thicknessBack, vector.x, vector.y, 0f));
		cmd.SetGlobalVector(ShaderContants.IntensityID, new Vector4(intensity, allEnable ? 1 : 0, 0f, 0f));
		cmd.SetGlobalFloat(ShaderContants.MaxRadianceID, 64f);
		cmd.Blit(cameraColorTarget, ShaderContants.ReflectDataTexID, SSRMaterial, 0);
		cmd.SetGlobalTexture(ShaderContants.ReflectDataTexID, ShaderContants.ReflectDataTexID);
		cmd.SetGlobalVector(ShaderContants.RebuildResolutionID, new Vector4(rebuildTextureDescriptor.width, rebuildTextureDescriptor.height, 0f, 0f));
		rebuildColorAttachments[0] = ShaderContants.CurrentID;
		rebuildRenderTargetBinding.colorRenderTargets = rebuildColorAttachments;
		rebuildRenderTargetBinding.depthRenderTarget = BuiltinRenderTextureType.None;
		rebuildRenderTargetBinding.colorLoadActions = rebuildColorLoadActions;
		rebuildRenderTargetBinding.colorStoreActions = rebuildColorStoreActions;
		rebuildRenderTargetBinding.depthLoadAction = RenderBufferLoadAction.DontCare;
		rebuildRenderTargetBinding.depthStoreAction = RenderBufferStoreAction.DontCare;
		cmd.SetRenderTarget(rebuildRenderTargetBinding);
		ACTRenderingFunction.ACT_DrawFullScreenMesh(cmd, SSRMaterial, 2, cameraColorTarget, ShaderContants.SceneColorTexID);
		cmd.SetGlobalTexture(ShaderContants.HistoryID, historyList.history0);
		cmd.SetGlobalFloat(ShaderContants.HistoryValidID, historyValid ? 1f : 0f);
		temporalColorAttachments[0] = historyList.history1;
		temporalRenderTargetBinding.colorRenderTargets = temporalColorAttachments;
		temporalRenderTargetBinding.depthRenderTarget = BuiltinRenderTextureType.None;
		temporalRenderTargetBinding.colorLoadActions = rebuildColorLoadActions;
		temporalRenderTargetBinding.colorStoreActions = rebuildColorStoreActions;
		temporalRenderTargetBinding.depthLoadAction = RenderBufferLoadAction.DontCare;
		temporalRenderTargetBinding.depthStoreAction = RenderBufferStoreAction.DontCare;
		cmd.SetRenderTarget(temporalRenderTargetBinding);
		ACTRenderingFunction.ACT_DrawFullScreenMesh(cmd, SSRMaterial, 3, ShaderContants.CurrentID);
		cmd.SetGlobalTexture(ShaderContants.ReflectTexID, historyList.history1);
		cmd.SetGlobalFloat(ShaderContants.DeferredSSREnabledID, 1f);
		cmd.EnableKeyword(in ShaderKeywords.SSRKeyword);
		historyValid = true;
		ChangeHistoryList();
		cmd.ReleaseTemporaryRT(ShaderContants.ReflectDataTexID);
		cmd.ReleaseTemporaryRT(ShaderContants.CurrentID);
		if (releaseHiZ)
		{
			cmd.ReleaseTemporaryRT(ShaderContants.HiZDepthTextureID);
		}
		cmd.EndSample("SSRPass");
	}
}
