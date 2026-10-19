using UnityEngine.Experimental.Rendering;

namespace UnityEngine.Rendering.Universal;

public class ScreenShotPass : ScriptableRenderPass
{
	private static readonly int k_BlurTexture = Shader.PropertyToID("_BlurTexture");

	private readonly bool m_FinalOutputPass;

	private static bool s_BaseCameraShot;

	private static bool s_FinalOutputRequested;

	private static bool s_FinalOutputCompleted;

	private static RenderTexture s_BlurRT;

	private static RenderTexture s_FinalOutputRT;

	private static bool s_ReleaseBlurRequested;

	private static bool s_ReleaseFinalOutputRequested;

	public static bool IsBaseCameraCaptureRequested => s_BaseCameraShot;

	public static bool IsFinalOutputCaptureRequested => s_FinalOutputRequested;

	public static bool IsFinalOutputCaptureCompleted => s_FinalOutputCompleted;

	public static RenderTexture FinalOutputTexture => s_FinalOutputRT;

	public ScreenShotPass(bool finalOutputPass = false)
	{
		m_FinalOutputPass = finalOutputPass;
		profilingSampler = new ProfilingSampler("ScreenShotPass");
		renderPassEvent = (finalOutputPass ? RenderPassEvent.ScreenShotPass : RenderPassEvent.ScreenShotPass);
		targetCount = 0u;
	}

	public static void Shot()
	{
		s_BaseCameraShot = true;
	}

	public static void RequestFinalOutputCapture()
	{
		s_FinalOutputRequested = true;
		s_FinalOutputCompleted = false;
	}

	public static void Release()
	{
		s_ReleaseBlurRequested = true;
		s_BaseCameraShot = false;
	}

	public static void ReleaseFinalOutputCapture()
	{
		s_ReleaseFinalOutputRequested = true;
		s_FinalOutputRequested = false;
		s_FinalOutputCompleted = false;
	}

	internal static void DiscardPendingShot()
	{
		if (s_BaseCameraShot)
		{
			s_BaseCameraShot = false;
		}
	}

	internal static void ReconcilePersistentRenderResources()
	{
		if (s_ReleaseBlurRequested)
		{
			ReleaseRT(ref s_BlurRT);
			s_ReleaseBlurRequested = false;
		}
		if (s_ReleaseFinalOutputRequested)
		{
			ReleaseRT(ref s_FinalOutputRT);
			s_ReleaseFinalOutputRequested = false;
		}
	}

	internal static RenderTexture GetOrCreateFinalOutputTexture(int width, int height)
	{
		if (s_FinalOutputRT == null || s_FinalOutputRT.width != width || s_FinalOutputRT.height != height)
		{
			ReleaseRT(ref s_FinalOutputRT);
			RenderTextureDescriptor desc = new RenderTextureDescriptor(width, height, GraphicsFormat.R8G8B8A8_UNorm, GraphicsFormat.None);
			desc.depthBufferBits = 0;
			desc.msaaSamples = 1;
			desc.useMipMap = false;
			desc.autoGenerateMips = false;
			s_FinalOutputRT = new RenderTexture(desc)
			{
				hideFlags = HideFlags.HideAndDontSave,
				name = "ScreenShotPass_FinalOutput"
			};
			s_FinalOutputRT.Create();
		}
		return s_FinalOutputRT;
	}

	private static void ReleaseRT(ref RenderTexture rt)
	{
		if (!(rt == null))
		{
			if (rt.IsCreated())
			{
				rt.Release();
			}
			CoreUtils.Destroy(rt);
			rt = null;
		}
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (m_FinalOutputPass)
		{
			if (s_FinalOutputRequested)
			{
				ExecuteFinalOutputCapture(ref context, ref renderingData);
			}
		}
		else if (s_BaseCameraShot && renderingData.cameraData.isBase)
		{
			ExecuteBaseCameraCapture(ref context, ref renderingData);
		}
	}

	private void ExecuteFinalOutputCapture(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		RenderTargetIdentifier cameraColorTarget = renderingData.cameraData.renderer.cameraColorTarget;
		RenderTexture orCreateFinalOutputTexture = GetOrCreateFinalOutputTexture(renderingData.cameraData.pixelWidth, renderingData.cameraData.pixelHeight);
		cmd.Blit(cameraColorTarget, orCreateFinalOutputTexture);
		cmd.SetGlobalTexture(k_BlurTexture, orCreateFinalOutputTexture);
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		s_FinalOutputRequested = false;
		s_FinalOutputCompleted = true;
	}

	private void ExecuteBaseCameraCapture(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		int pixelWidth = renderingData.cameraData.pixelWidth;
		int pixelHeight = renderingData.cameraData.pixelHeight;
		if (s_BlurRT == null || s_BlurRT.width != pixelWidth || s_BlurRT.height != pixelHeight)
		{
			ReleaseRT(ref s_BlurRT);
			s_BlurRT = new RenderTexture(pixelWidth, pixelHeight, 0, RenderTextureFormat.RGB111110Float)
			{
				hideFlags = HideFlags.HideAndDontSave,
				name = "ScreenShotPass_Blur"
			};
			s_BlurRT.Create();
		}
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		RenderTargetIdentifier cameraColorTarget = renderer.cameraColorTarget;
		RenderTargetIdentifier cameraDepthTarget = renderer.cameraDepthTarget;
		cmd.Blit(cameraColorTarget, s_BlurRT);
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		cmd.SetRenderTarget(cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
		cmd.SetGlobalTexture(k_BlurTexture, s_BlurRT);
		s_BaseCameraShot = false;
	}
}
