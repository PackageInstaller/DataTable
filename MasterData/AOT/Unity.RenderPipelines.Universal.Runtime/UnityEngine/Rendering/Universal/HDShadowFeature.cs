using System;

namespace UnityEngine.Rendering.Universal;

public class HDShadowFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public HDCharShadowPass.HDShadowQuality shadowQuality = HDCharShadowPass.HDShadowQuality.High;

		[Tooltip("Globally allows Face GBuffer shaders to receive HD character self shadow.")]
		public bool receiveFaceHDShadow;

		[HideInInspector]
		[Min(0f)]
		public float boundsPadding = 0.05f;

		[Min(0.01f)]
		[HideInInspector]
		public float depthPadding = 0.5f;

		[Min(0f)]
		public float depthBiasInTexels = 3f;

		[Min(0f)]
		public float normalBiasInTexels = 6f;

		[Tooltip("Unity-facing constant caster bias. Unity flips it for reversed-Z backends, where 8 appears as -8 in RenderDoc.")]
		[Min(0f)]
		public float casterDepthBias = 8f;

		[Min(0f)]
		public float casterSlopeBias;

		[Min(0.001f)]
		[HideInInspector]
		public float projectionSizeStep = 0.05f;

		[HideInInspector]
		public bool enableTexelSnapping = true;

		[HideInInspector]
		public bool stabilizeProjection = true;

		public Settings Clone()
		{
			return (Settings)MemberwiseClone();
		}
	}

	[SerializeField]
	public Settings settings = new Settings();

	[NonSerialized]
	private Settings m_RuntimeSettings;

	private static readonly int s_HDCharShadowFaceReceiveEnabled = Shader.PropertyToID("_HDCharShadowFaceReceiveEnabled");

	private HDCharShadowPass m_HDShadowPass;

	public Settings runtimeSettings
	{
		get
		{
			EnsureRuntimeSettings();
			return m_RuntimeSettings;
		}
	}

	private void EnsureRuntimeSettings()
	{
		if (m_RuntimeSettings == null)
		{
			m_RuntimeSettings = ((settings != null) ? settings.Clone() : new Settings());
		}
	}

	public override void Create()
	{
		EnsureRuntimeSettings();
		m_HDShadowPass = new HDCharShadowPass();
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		bool flag = renderingData.cameraData.camera.cameraType == CameraType.Game;
		renderingData.cmd.SetGlobalInteger(s_HDCharShadowFaceReceiveEnabled, (flag && runtimeSettings.receiveFaceHDShadow) ? 1 : 0);
		if (flag && m_HDShadowPass.Setup(renderingData.cmd, ref renderingData, runtimeSettings.shadowQuality, runtimeSettings.boundsPadding, runtimeSettings.depthBiasInTexels, runtimeSettings.normalBiasInTexels, runtimeSettings.casterDepthBias, runtimeSettings.casterSlopeBias, runtimeSettings.projectionSizeStep, runtimeSettings.enableTexelSnapping))
		{
			renderer.EnqueuePass(m_HDShadowPass);
		}
	}

	protected override void Dispose(bool disposing)
	{
		Shader.SetGlobalInteger(s_HDCharShadowFaceReceiveEnabled, 0);
	}
}
