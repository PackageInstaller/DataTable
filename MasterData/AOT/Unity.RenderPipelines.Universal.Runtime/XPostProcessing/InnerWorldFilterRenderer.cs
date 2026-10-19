using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

internal sealed class InnerWorldFilterRenderer : AbstractVolumeRenderer
{
	private static class ShaderIDs
	{
		internal static readonly int DistortionParams = Shader.PropertyToID("_InnerWorldDistortionParams");

		internal static readonly int LensParams = Shader.PropertyToID("_InnerWorldLensParams");

		internal static readonly int EdgeFeather = Shader.PropertyToID("_InnerWorldFilterEdgeFeather");

		internal static readonly int MaskCount = Shader.PropertyToID("_InnerWorldFilterMaskCount");

		internal static readonly int Masks = Shader.PropertyToID("_InnerWorldFilterMasks");
	}

	private const string ProfilerTag = "InnerWorldFilterDistortion";

	private const string ShaderName = "Hidden/PostProcessing/InnerWorld/FilterDistortion";

	private Material m_BlitMaterial;

	private VolumeComponentCache m_VolumeComponents;

	private InnerWorldFilter m_Settings;

	private readonly Vector4[] m_Masks = new Vector4[16];

	internal override void SetVolumeComponentCache(VolumeComponentCache volumeComponents)
	{
		m_VolumeComponents = volumeComponents;
		m_Settings = null;
	}

	public override bool Init()
	{
		Shader shader = Shader.Find("Hidden/PostProcessing/InnerWorld/FilterDistortion");
		if (shader == null)
		{
			return false;
		}
		m_BlitMaterial = CoreUtils.CreateEngineMaterial(shader);
		return m_BlitMaterial != null;
	}

	public override bool IsActive()
	{
		if (m_VolumeComponents != null)
		{
			m_VolumeComponents.EnsureCurrent();
			m_Settings = m_VolumeComponents.InnerWorldFilter;
		}
		else
		{
			m_Settings = VolumeManager.instance.stack.GetComponent<InnerWorldFilter>();
		}
		if (m_Settings != null && m_Settings.IsActive() && ((m_Settings.distortionIntensity.value > 0f && m_Settings.distortionStrength.value > 0f) || m_Settings.edgeLensIntensity.value > 0f))
		{
			return InnerWorldFilterMask.HasActiveMask();
		}
		return false;
	}

	public override bool Render(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp, ref RenderingData renderingData)
	{
		if (m_BlitMaterial == null || m_Settings == null)
		{
			return false;
		}
		int num = InnerWorldFilterMask.WriteActiveMasks(m_Masks);
		if (num <= 0)
		{
			return false;
		}
		CommandBuffer cmd = renderingData.cmd;
		cmd.BeginSample("InnerWorldFilterDistortion");
		m_BlitMaterial.SetVector(ShaderIDs.DistortionParams, new Vector4(m_Settings.distortionIntensity.value, m_Settings.distortionStrength.value, m_Settings.distortionFrequency.value, m_Settings.rippleSpeed.value));
		m_BlitMaterial.SetVector(ShaderIDs.LensParams, new Vector4(m_Settings.edgeLensIntensity.value, m_Settings.edgeLensWidth.value, m_Settings.invertMask.value ? 1f : 0f, 0f));
		m_BlitMaterial.SetFloat(ShaderIDs.EdgeFeather, m_Settings.edgeFeather.value);
		m_BlitMaterial.SetInteger(ShaderIDs.MaskCount, num);
		m_BlitMaterial.SetVectorArray(ShaderIDs.Masks, m_Masks);
		cmd.Blit(source, target, m_BlitMaterial, 0);
		cmd.EndSample("InnerWorldFilterDistortion");
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		return true;
	}

	public override void Cleanup()
	{
		if (m_BlitMaterial != null)
		{
			CoreUtils.Destroy(m_BlitMaterial);
			m_BlitMaterial = null;
		}
	}

	public override bool PlatformCompatible()
	{
		return true;
	}
}
