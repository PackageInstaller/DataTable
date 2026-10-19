namespace UnityEngine.Rendering.Universal;

public class GTAOPass : ScriptableRenderPass
{
	private static class ShaderConstants
	{
		public static readonly int GATO_RT_Temp = Shader.PropertyToID("_GATO_RT_Temp");

		public static readonly int GATO_RT_Temp2 = Shader.PropertyToID("_GATO_RT_Temp2");

		public static readonly int GTAO_DepthMip0 = Shader.PropertyToID("_GTAO_DepthMip0");

		public static readonly int GTAO_DepthMip1 = Shader.PropertyToID("_GTAO_DepthMip1");

		public static readonly int GTAO_DepthMip2 = Shader.PropertyToID("_GTAO_DepthMip2");

		public static readonly int GTAO_DepthMip3 = Shader.PropertyToID("_GTAO_DepthMip3");

		public static readonly int GTAO_DepthMip4 = Shader.PropertyToID("_GTAO_DepthMip4");

		public static readonly int GTAOParams = Shader.PropertyToID("_GTAOParams");

		public static readonly int GTAOControls = Shader.PropertyToID("_GTAOControls");

		public static readonly int GTAODenoise = Shader.PropertyToID("_GTAODenoise");

		public static readonly int GTAORTSize = Shader.PropertyToID("_GTAORTSize");

		public static readonly int AoTexture = Shader.PropertyToID("_AoTexture");

		public static readonly int CurrentFrame = Shader.PropertyToID("_CurrentFrame");
	}

	private enum PassName
	{
		PrefilterDepth,
		DownsampleDepth,
		MainAO,
		DenoiseHorizontal,
		DenoiseVertical
	}

	private Material m_Material;

	private GTAOFeature.Settings m_Settings;

	private readonly GlobalKeyword m_GTAOKeyword;

	private static RenderTextureFormat s_AoFormat;

	private static bool s_AoFormatInitialized;

	public GTAOPass()
	{
		profilingSampler = new ProfilingSampler("GTAOPass");
		m_GTAOKeyword = GlobalKeyword.Create("_GTAO_ON");
	}

	public bool Setup(GTAOFeature.Settings settings, Material material)
	{
		m_Settings = settings;
		m_Material = material;
		if (m_Settings == null)
		{
			return false;
		}
		renderPassEvent = m_Settings.renderPassEvent;
		if (m_Material != null && m_Settings.enableGTAO && m_Settings.downSample > 0 && m_Settings.sampleCount > 0 && m_Settings.sampleStepWidth > 0 && m_Settings.sliceCount > 0)
		{
			return m_Settings.aoIntensity > 0f;
		}
		return false;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (m_Material == null || m_Settings == null)
		{
			return;
		}
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			ResolveSettings(m_Settings, out var downSample, out var sampleCount, out var sliceCount, out var radiusPixels);
			float num = 1f / (float)downSample;
			RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
			float z = (float)(radiusPixels * cameraTargetDescriptor.height) / 1080f;
			m_Material.SetVector(ShaderConstants.GTAOParams, new Vector4(sampleCount, sliceCount, z, num));
			m_Material.SetVector(ShaderConstants.GTAOControls, new Vector4(m_Settings.aoIntensity, m_Settings.roIntensity, m_Settings.thickness, m_Settings.falloff));
			m_Material.SetVector(ShaderConstants.GTAODenoise, new Vector4(m_Settings.denoiseSharpness, m_Settings.denoiseRadius, m_Settings.power, m_Settings.aoAngle));
			m_Material.SetFloat(ShaderConstants.CurrentFrame, Time.frameCount);
			int num2 = Mathf.Max(1, Mathf.CeilToInt((float)cameraTargetDescriptor.width * num));
			int num3 = Mathf.Max(1, Mathf.CeilToInt((float)cameraTargetDescriptor.height * num));
			int num4 = Mathf.Max(1, num2 + 1 >> 1);
			int num5 = Mathf.Max(1, num3 + 1 >> 1);
			int num6 = Mathf.Max(1, num4 + 1 >> 1);
			int num7 = Mathf.Max(1, num5 + 1 >> 1);
			int num8 = Mathf.Max(1, num6 + 1 >> 1);
			int num9 = Mathf.Max(1, num7 + 1 >> 1);
			int width = Mathf.Max(1, num8 + 1 >> 1);
			int height = Mathf.Max(1, num9 + 1 >> 1);
			RenderTextureFormat depthFormat = GetDepthFormat();
			RenderTextureFormat aoFormat = GetAoFormat();
			m_Material.SetVector(ShaderConstants.GTAORTSize, new Vector4(num2, num3, 1f / (float)Mathf.Max(num2 - 1, 1), 1f / (float)Mathf.Max(num3 - 1, 1)));
			cmd.GetTemporaryRT(ShaderConstants.GATO_RT_Temp, num2, num3, 0, FilterMode.Bilinear, aoFormat);
			cmd.GetTemporaryRT(ShaderConstants.GATO_RT_Temp2, num2, num3, 0, FilterMode.Bilinear, aoFormat);
			cmd.GetTemporaryRT(ShaderConstants.GTAO_DepthMip0, num2, num3, 0, FilterMode.Bilinear, depthFormat);
			cmd.GetTemporaryRT(ShaderConstants.GTAO_DepthMip1, num4, num5, 0, FilterMode.Bilinear, depthFormat);
			cmd.GetTemporaryRT(ShaderConstants.GTAO_DepthMip2, num6, num7, 0, FilterMode.Bilinear, depthFormat);
			cmd.GetTemporaryRT(ShaderConstants.GTAO_DepthMip3, num8, num9, 0, FilterMode.Bilinear, depthFormat);
			cmd.GetTemporaryRT(ShaderConstants.GTAO_DepthMip4, width, height, 0, FilterMode.Bilinear, depthFormat);
			cmd.Blit(Texture2D.blackTexture, ShaderConstants.GTAO_DepthMip0, m_Material, 0);
			cmd.Blit(ShaderConstants.GTAO_DepthMip0, ShaderConstants.GTAO_DepthMip1, m_Material, 1);
			cmd.Blit(ShaderConstants.GTAO_DepthMip1, ShaderConstants.GTAO_DepthMip2, m_Material, 1);
			cmd.Blit(ShaderConstants.GTAO_DepthMip2, ShaderConstants.GTAO_DepthMip3, m_Material, 1);
			cmd.Blit(ShaderConstants.GTAO_DepthMip3, ShaderConstants.GTAO_DepthMip4, m_Material, 1);
			cmd.SetGlobalTexture(ShaderConstants.GTAO_DepthMip0, ShaderConstants.GTAO_DepthMip0);
			cmd.SetGlobalTexture(ShaderConstants.GTAO_DepthMip1, ShaderConstants.GTAO_DepthMip1);
			cmd.SetGlobalTexture(ShaderConstants.GTAO_DepthMip2, ShaderConstants.GTAO_DepthMip2);
			cmd.SetGlobalTexture(ShaderConstants.GTAO_DepthMip3, ShaderConstants.GTAO_DepthMip3);
			cmd.SetGlobalTexture(ShaderConstants.GTAO_DepthMip4, ShaderConstants.GTAO_DepthMip4);
			cmd.Blit(Texture2D.blackTexture, ShaderConstants.GATO_RT_Temp, m_Material, 2);
			cmd.Blit(ShaderConstants.GATO_RT_Temp, ShaderConstants.GATO_RT_Temp2, m_Material, 3);
			ACTRenderingFunction.ACT_BlitWithOutLoad(cmd, ShaderConstants.GATO_RT_Temp2, ShaderConstants.GATO_RT_Temp, m_Material, 4);
			cmd.SetGlobalTexture(ShaderConstants.AoTexture, ShaderConstants.GATO_RT_Temp);
			RestoreCameraTarget(cmd, ref renderingData);
			cmd.EnableKeyword(in m_GTAOKeyword);
		}
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		if (cmd != null)
		{
			cmd.ReleaseTemporaryRT(ShaderConstants.GATO_RT_Temp);
			cmd.ReleaseTemporaryRT(ShaderConstants.GATO_RT_Temp2);
			cmd.ReleaseTemporaryRT(ShaderConstants.GTAO_DepthMip0);
			cmd.ReleaseTemporaryRT(ShaderConstants.GTAO_DepthMip1);
			cmd.ReleaseTemporaryRT(ShaderConstants.GTAO_DepthMip2);
			cmd.ReleaseTemporaryRT(ShaderConstants.GTAO_DepthMip3);
			cmd.ReleaseTemporaryRT(ShaderConstants.GTAO_DepthMip4);
			cmd.DisableKeyword(in m_GTAOKeyword);
		}
	}

	private static void ResolveSettings(GTAOFeature.Settings settings, out int downSample, out int sampleCount, out int sliceCount, out int radiusPixels)
	{
		downSample = Mathf.Clamp(settings.downSample, 1, 6);
		sampleCount = Mathf.Clamp(settings.sampleCount, 4, 32);
		sliceCount = Mathf.Clamp(settings.sliceCount, 1, 8);
		radiusPixels = Mathf.Clamp(settings.sampleStepWidth, 1, 128);
		switch (settings.quality)
		{
		case GTAOFeature.Quality.Low:
			downSample = Mathf.Max(downSample, 2);
			sampleCount = Mathf.Min(sampleCount, 6);
			sliceCount = Mathf.Min(sliceCount, 2);
			break;
		case GTAOFeature.Quality.Medium:
			downSample = Mathf.Max(downSample, 2);
			sampleCount = Mathf.Min(sampleCount, 8);
			sliceCount = Mathf.Min(sliceCount, 3);
			break;
		case GTAOFeature.Quality.High:
			sampleCount = Mathf.Max(sampleCount, 12);
			sliceCount = Mathf.Max(sliceCount, 4);
			break;
		case GTAOFeature.Quality.Ultra:
			sampleCount = Mathf.Max(sampleCount, 16);
			sliceCount = Mathf.Max(sliceCount, 6);
			break;
		}
	}

	private static RenderTextureFormat GetDepthFormat()
	{
		return RenderTextureFormat.RFloat;
	}

	private static RenderTextureFormat GetAoFormat()
	{
		if (!s_AoFormatInitialized)
		{
			s_AoFormat = RenderTextureFormat.ARGB32;
			s_AoFormatInitialized = true;
		}
		return s_AoFormat;
	}

	private static void RestoreCameraTarget(CommandBuffer cmd, ref RenderingData renderingData)
	{
		cmd.SetRenderTarget(renderingData.cameraData.renderer.cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, renderingData.cameraData.renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store);
		cmd.SetViewport(renderingData.cameraData.pixelRect);
	}
}
