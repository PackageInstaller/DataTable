using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public class FilmBlackRenderer : VolumeRenderer<FilmBlack>
{
	private static readonly int FlimBlackDataID = Shader.PropertyToID("_FlimBlackData");

	public override bool Render(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		cmd.SetGlobalVector(FlimBlackDataID, new Vector4(m_Settings.Smoothness.value, m_Settings.Fade.value, m_Settings.width.value, m_Settings.intensity.value));
		cmd.EnableKeyword(in ShaderKeywords.FilmBlackKeyword);
		return false;
	}
}
