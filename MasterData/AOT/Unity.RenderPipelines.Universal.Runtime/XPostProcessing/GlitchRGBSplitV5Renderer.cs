using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

public sealed class GlitchRGBSplitV5Renderer : VolumeRenderer<GlitchRGBSplitV5>
{
	private static class ShaderIDs
	{
		internal static readonly int NoiseTex = Shader.PropertyToID("_NoiseTex");

		internal static readonly int Params = Shader.PropertyToID("_Params");
	}

	private const string PROFILER_TAG = "GlitchRGBSplitV5";

	private Texture2D m_NoiseTex;

	public override bool Init()
	{
		bool flag = base.Init();
		if (flag)
		{
			m_NoiseTex = Resources.Load("X-Noise256") as Texture2D;
		}
		return flag;
	}

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target)
	{
		if (!(m_BlitMaterial == null))
		{
			cmd.BeginSample("GlitchRGBSplitV5");
			m_BlitMaterial.SetVector(ShaderIDs.Params, new Vector2(m_Settings.Amplitude.value, m_Settings.Speed.value));
			if (m_NoiseTex != null)
			{
				m_BlitMaterial.SetTexture(ShaderIDs.NoiseTex, m_NoiseTex);
			}
			cmd.Blit(source, target, m_BlitMaterial);
			cmd.EndSample("GlitchRGBSplitV5");
		}
	}
}
