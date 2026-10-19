using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public class DirectionalBlurRenderer : VolumeRenderer<DirectionalBlur>
{
	private static class ShaderIDs
	{
		internal static readonly int Params = Shader.PropertyToID("_Params");

		internal static readonly int BufferRT = Shader.PropertyToID("_BufferRT");
	}

	private const string PROFILER_TAG = "DirectionalBlur";

	public override void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp)
	{
		if (!(m_BlitMaterial == null))
		{
			cmd.BeginSample("DirectionalBlur");
			float value = m_Settings.RTDownScaling.value;
			bool flag = value > 1f;
			if (flag)
			{
				Vector2 size = ppp.GetSize();
				cmd.GetTemporaryRT(width: (int)(size.x / value), height: (int)(size.y / value), nameID: ShaderIDs.BufferRT, depthBuffer: 0, filter: FilterMode.Bilinear);
				cmd.Blit(source, ShaderIDs.BufferRT);
			}
			int value2 = m_Settings.Iteration.value;
			float value3 = m_Settings.Angle.value;
			float num = m_Settings.BlurRadius.value * 0.05f;
			float y = Mathf.Sin(value3) * num / (float)value2;
			float z = Mathf.Cos(value3) * num / (float)value2;
			m_BlitMaterial.SetVector(ShaderIDs.Params, new Vector3(value2, y, z));
			if (flag)
			{
				cmd.Blit(ShaderIDs.BufferRT, target, m_BlitMaterial, 0);
			}
			else
			{
				cmd.Blit(source, target, m_BlitMaterial, 0);
			}
			if (flag)
			{
				cmd.ReleaseTemporaryRT(ShaderIDs.BufferRT);
			}
			cmd.EndSample("DirectionalBlur");
		}
	}
}
