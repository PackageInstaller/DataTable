using System;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering.Universal;

public class SSRFeature : ScriptableRendererFeature
{
	[Serializable]
	public class SSRSettings
	{
		public bool enableSSR;

		public bool SimpleWay;

		public bool AllEnable;

		[Range(0f, 10f)]
		public float Intensity = 1f;

		[Range(1f, 8f)]
		public int downSample = 4;

		[Range(1f, 8f)]
		public int rebuildDownSample = 1;

		[Range(1f, 2000f)]
		public int loopCount = 150;

		[Range(0.01f, 10f)]
		public float thickness = 0.1f;

		[Range(0.01f, 10f)]
		public float thicknessBack = 0.01f;

		public SSRSettings Clone()
		{
			return (SSRSettings)MemberwiseClone();
		}
	}

	[Serializable]
	public class SSGISettings
	{
		public bool enableSSGI;

		public GlobalRenderingControl.SSGISampleQuality sampleQuality;

		[Range(0f, 10f)]
		public float Intensity = 1f;

		[Range(1f, 8f)]
		public int downSample = 4;

		[Range(1f, 8f)]
		public int rebuildDownSample = 1;

		[Range(1f, 2000f)]
		public int loopCount = 150;

		[Range(0.01f, 10f)]
		public float thickness = 0.1f;

		[Range(0.01f, 10f)]
		public float thicknessBack = 0.01f;

		[Range(1f, 10f)]
		public int skipLoop = 4;

		public SSGISettings Clone()
		{
			return (SSGISettings)MemberwiseClone();
		}
	}

	private SSRPass m_ssrPass;

	private SSGIPass m_ssgiPass;

	private SSRHiZPass m_hizPass;

	[NonSerialized]
	private Material ssrMaterial;

	[NonSerialized]
	private Material ssgiMaterial;

	[SerializeField]
	public Shader ssrShader;

	[SerializeField]
	public Shader ssgiShader;

	[SerializeField]
	public ComputeShader ssrHiZComputeShader;

	[SerializeField]
	[FormerlySerializedAs("settings")]
	public SSRSettings ssrSettings = new SSRSettings();

	[SerializeField]
	public SSGISettings ssgiSettings = new SSGISettings();

	[NonSerialized]
	private SSRSettings m_RuntimeSSRSettings;

	[NonSerialized]
	private SSGISettings m_RuntimeSSGISettings;

	public SSRSettings runtimeSSRSettings
	{
		get
		{
			EnsureRuntimeSettings();
			return m_RuntimeSSRSettings;
		}
	}

	public SSGISettings runtimeSSGISettings
	{
		get
		{
			EnsureRuntimeSettings();
			return m_RuntimeSSGISettings;
		}
	}

	private void EnsureRuntimeSettings()
	{
		if (m_RuntimeSSRSettings == null || m_RuntimeSSGISettings == null)
		{
			m_RuntimeSSRSettings = ((ssrSettings != null) ? ssrSettings.Clone() : new SSRSettings());
			m_RuntimeSSGISettings = ((ssgiSettings != null) ? ssgiSettings.Clone() : new SSGISettings());
		}
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		SSRPass.DisableForDeferred(renderingData.cmd);
		UniversalRenderer universalRenderer = renderer as UniversalRenderer;
		if (CanCreatePCPasses() && universalRenderer != null && universalRenderer.renderPassScheduleMode == RenderPassScheduleMode.PC && universalRenderer.actualRenderingMode == RenderingMode.Deferred && renderingData.cameraData.isGameCamera && renderingData.cameraData.isBase)
		{
			bool flag = IsSSREnabled();
			bool flag2 = IsSSGIEnabled();
			SSRSettings settings = (flag ? GetActiveSSRSettings() : null);
			SSGISettings settings2 = (flag2 ? GetActiveSSGISettings() : null);
			bool flag3 = flag && m_hizPass != null;
			bool flag4 = flag2 && m_hizPass != null;
			if (flag3 | flag4)
			{
				m_hizPass.Setup();
				renderer.EnqueuePass(m_hizPass);
			}
			if (flag2)
			{
				m_ssgiPass.Setup(Enable: true, flag4 && !flag3);
				m_ssgiPass.SetData(settings2, flag4);
				renderer.EnqueuePass(m_ssgiPass);
			}
			else if (m_ssgiPass != null)
			{
				m_ssgiPass.Setup(Enable: false, ReleaseHiZ: false);
			}
			if (flag)
			{
				m_ssrPass.SetData(settings, flag3);
				m_ssrPass.Setup(Enable: true, flag3);
				renderer.EnqueuePass(m_ssrPass);
			}
			else if (m_ssrPass != null)
			{
				m_ssrPass.Setup(Enable: false, ReleaseHiZ: false);
			}
		}
	}

	public override void Create()
	{
		if (CanCreatePCPasses())
		{
			EnsureRuntimeSettings();
			if (ssrShader == null)
			{
				ssrShader = Shader.Find("Hidden/PostProcessing/SSR");
			}
			if (ssgiShader == null)
			{
				ssgiShader = Shader.Find("Hidden/PostProcessing/SSGI");
			}
			if (ssrShader != null && m_ssrPass == null)
			{
				ssrMaterial = CoreUtils.CreateEngineMaterial(ssrShader);
				m_ssrPass = new SSRPass(ssrMaterial);
			}
			if (m_hizPass == null && SSRHiZPass.TryGetSupportedFormat(ssrHiZComputeShader, out var format))
			{
				m_hizPass = new SSRHiZPass(ssrHiZComputeShader, format);
			}
			if (ssgiShader != null && m_ssgiPass == null)
			{
				ssgiMaterial = CoreUtils.CreateEngineMaterial(ssgiShader);
				m_ssgiPass = new SSGIPass(ssgiMaterial);
			}
		}
	}

	internal override void ReconcilePersistentRenderResources(CommandBuffer cmd, ref RenderingData renderingData)
	{
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		int num;
		if (renderer != null && renderer.renderPassScheduleMode == RenderPassScheduleMode.PC)
		{
			num = ((renderer.actualRenderingMode == RenderingMode.Deferred) ? 1 : 0);
			if (num != 0 && IsSSREnabled())
			{
				goto IL_0040;
			}
		}
		else
		{
			num = 0;
		}
		m_ssrPass?.ReleaseResources();
		goto IL_0040;
		IL_0040:
		if (num == 0 || !IsSSGIEnabled())
		{
			m_ssgiPass?.ReleaseResources();
		}
	}

	protected override void Dispose(bool disposing)
	{
		m_ssrPass?.ReleaseResources(destroyTextures: true);
		m_ssrPass = null;
		m_ssgiPass?.ReleaseResources(destroyTextures: true);
		m_ssgiPass = null;
		m_hizPass = null;
		CoreUtils.Destroy(ssrMaterial);
		ssrMaterial = null;
		CoreUtils.Destroy(ssgiMaterial);
		ssgiMaterial = null;
	}

	public override void EnableFeatureKeyWords(CommandBuffer cmd)
	{
		cmd.DisableKeyword(in ShaderKeywords.SSRKeyword);
	}

	public override void DisableFeatureKeyWords(CommandBuffer cmd)
	{
		cmd.DisableKeyword(in ShaderKeywords.SSRKeyword);
	}

	private static bool CanCreatePCPasses()
	{
		return false;
	}

	private bool IsSSREnabled()
	{
		if (isActive && m_ssrPass != null)
		{
			return runtimeSSRSettings.enableSSR;
		}
		return false;
	}

	private bool IsSSGIEnabled()
	{
		if (isActive && m_ssgiPass != null)
		{
			return runtimeSSGISettings.enableSSGI;
		}
		return false;
	}

	private SSRSettings GetActiveSSRSettings()
	{
		return runtimeSSRSettings;
	}

	private SSGISettings GetActiveSSGISettings()
	{
		return runtimeSSGISettings;
	}
}
