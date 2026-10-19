using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public class SSGIPass : ScriptableRenderPass
{
	private struct HistoryList
	{
		public RenderTexture history0;

		public RenderTexture history1;
	}

	private static class ShaderContants
	{
		public static readonly int ReflectTexID = Shader.PropertyToID("_SSGITex");

		public static readonly int ReflectDataTexID = Shader.PropertyToID("_SSGIDataTex");

		public static readonly int TargetResolutionID = Shader.PropertyToID("_TargetResolution");

		public static readonly int RebuildResolutionID = Shader.PropertyToID("_RebuildResolution");

		public static readonly int SSRDataID = Shader.PropertyToID("_SSGIData");

		public static readonly int CurrentID = Shader.PropertyToID("_SSGIcurrentTex");

		public static readonly int IntensityID = Shader.PropertyToID("_reflectIntensity");

		public static readonly int HiZDepthTextureID = Shader.PropertyToID("_SSRHiZDepthTexture");

		public static readonly int HistoryID = Shader.PropertyToID("_SSGI_History");
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

	private int skipLoop;

	private float intensity;

	private bool allEnable;

	private Material SSRMaterial;

	private RenderTexture historyTex;

	private RenderTexture historyTex2;

	private HistoryList historyList;

	private bool FirstFrame;

	private RenderTextureDescriptor rebuildTextureDescriptor;

	private static int rebuildTexDownSample = 1;

	private bool enable;

	private bool releaseHiZ;

	private bool traceWithHiZ;

	private GlobalKeyword fogKey;

	private GlobalKeyword sampleQualityKey;

	private GlobalKeyword traceHiZKey;

	private bool IsSimpleWay;

	private bool volumeSettingSimpleWay;

	private GlobalRenderingControl.SSGISampleQuality sampleQuality;

	internal void Setup(bool Enable, bool ReleaseHiZ = true)
	{
		enable = Enable;
		releaseHiZ = ReleaseHiZ;
	}

	public SSGIPass(Material mat)
	{
		profilingSampler = new ProfilingSampler("SSGIPass");
		renderPassEvent = RenderPassEvent.SSGIPass;
		targetCount = 0u;
		SSRMaterial = mat;
		historyTex = CreateTextureShell("_SSGIHistory");
		historyTex2 = CreateTextureShell("_SSGIHistory2");
		sampleQualityKey = GlobalKeyword.Create("_SSGI_SAMPLE_HIGH");
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
			historyTex.name = "_SSGIHistory";
			historyTex.Create();
			historyList.history0 = historyTex;
		}
		if (!historyTex2.IsCreated())
		{
			historyTex2.descriptor = desc;
			historyTex2.name = "_SSGIHistory2";
			historyTex2.Create();
			historyList.history1 = historyTex2;
		}
		if (!FirstFrame)
		{
			historyList.history0 = historyTex;
			historyList.history1 = historyTex2;
			FirstFrame = true;
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
		FirstFrame = false;
	}

	internal void ReleaseResources(bool destroyTextures = false)
	{
		releaseHistoryRT(destroyTextures);
	}

	public void SetData(SSRFeature.SSGISettings settings, bool traceWithHiZ)
	{
		sampleQuality = settings.sampleQuality;
		downSample = settings.downSample;
		loopCount = settings.loopCount;
		thickness = settings.thickness;
		thicknessBack = settings.thicknessBack;
		skipLoop = settings.skipLoop;
		intensity = settings.Intensity;
		allEnable = true;
		rebuildTexDownSample = settings.rebuildDownSample;
		this.traceWithHiZ = traceWithHiZ;
	}

	private static void StoreCameraDepth(CommandBuffer cmd, ScriptableRenderer renderer)
	{
		ScriptableRenderer.SetRenderTarget(cmd, renderer.cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
	}

	private static void BlitToCameraTarget(CommandBuffer cmd, ScriptableRenderer renderer, RenderTargetIdentifier src, RenderTargetIdentifier dst, Material material, int passIndex)
	{
		ScriptableRenderer.SetRenderTarget(cmd, dst, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
		ACTRenderingFunction.ACT_DrawFullScreenMesh(cmd, material, passIndex, src);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		cmd.BeginSample("SSGIPass");
		cmd.SetKeyword(in traceHiZKey, traceWithHiZ);
		if (sampleQuality == GlobalRenderingControl.SSGISampleQuality.High)
		{
			cmd.SetKeyword(in sampleQualityKey, value: true);
		}
		else
		{
			cmd.SetKeyword(in sampleQualityKey, value: false);
		}
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		RenderTargetIdentifier cameraColorTarget = renderer.cameraColorTarget;
		StoreCameraDepth(cmd, renderer);
		if (!checkDescriptor(cameraTargetDescriptor))
		{
			cameraTargetDescriptor.graphicsFormat = GraphicsFormat.R16G16B16A16_SFloat;
			cameraTargetDescriptor.depthBufferBits = 0;
			cameraTargetDescriptor.depthStencilFormat = GraphicsFormat.None;
			cameraTargetDescriptor.useMipMap = false;
			cameraTargetDescriptor.autoGenerateMips = false;
			rebuildTextureDescriptor = cameraTargetDescriptor;
			rebuildTextureDescriptor.width = Mathf.Max(1, rebuildTextureDescriptor.width / rebuildTexDownSample);
			rebuildTextureDescriptor.height = Mathf.Max(1, rebuildTextureDescriptor.height / rebuildTexDownSample);
			releaseHistoryRT();
		}
		if (!IsSimpleWay && !volumeSettingSimpleWay)
		{
			creatHistoryRT(rebuildTextureDescriptor);
		}
		Vector2 vector = new Vector2(cameraTargetDescriptor.width, cameraTargetDescriptor.height);
		int num = (int)vector.x / downSample;
		int num2 = (int)vector.y / downSample;
		cmd.GetTemporaryRT(desc: new RenderTextureDescriptor(num, num2, RenderTextureFormat.ARGBHalf, 0), nameID: ShaderContants.ReflectDataTexID, filter: FilterMode.Bilinear);
		rebuildTextureDescriptor.useMipMap = false;
		cmd.GetTemporaryRT(ShaderContants.CurrentID, rebuildTextureDescriptor, FilterMode.Trilinear);
		cmd.SetGlobalVector(ShaderContants.TargetResolutionID, new Vector4(num, num2, loopCount, thickness));
		cmd.SetGlobalVector(ShaderContants.SSRDataID, new Vector4(thicknessBack, vector.x, vector.y, skipLoop));
		cmd.SetGlobalVector(ShaderContants.IntensityID, new Vector4(intensity, allEnable ? 1 : 0, 0f, 0f));
		cmd.Blit(cameraColorTarget, ShaderContants.ReflectDataTexID, SSRMaterial, 0);
		cmd.SetGlobalTexture(ShaderContants.ReflectDataTexID, ShaderContants.ReflectDataTexID);
		cmd.SetGlobalVector(ShaderContants.RebuildResolutionID, new Vector4(rebuildTextureDescriptor.width, rebuildTextureDescriptor.height, 0f, 0f));
		cmd.Blit(cameraColorTarget, ShaderContants.CurrentID, SSRMaterial, 2);
		cmd.SetGlobalTexture(ShaderContants.HistoryID, historyList.history0);
		ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, ShaderContants.CurrentID, historyList.history1, SSRMaterial, 3);
		cmd.Blit(historyList.history1, historyList.history0, SSRMaterial, 4);
		cmd.Blit(historyList.history0, historyList.history1, SSRMaterial, 5);
		cmd.SetGlobalTexture(ShaderContants.ReflectTexID, historyList.history1);
		ChangeHistoryList();
		renderer.SwapColorBuffer();
		RenderTargetIdentifier cameraColorTarget2 = renderer.cameraColorTarget;
		BlitToCameraTarget(cmd, renderer, cameraColorTarget, cameraColorTarget2, SSRMaterial, 1);
		cmd.ReleaseTemporaryRT(ShaderContants.ReflectDataTexID);
		cmd.ReleaseTemporaryRT(ShaderContants.CurrentID);
		if (releaseHiZ)
		{
			cmd.ReleaseTemporaryRT(ShaderContants.HiZDepthTextureID);
		}
		cmd.EndSample("SSGIPass");
	}
}
