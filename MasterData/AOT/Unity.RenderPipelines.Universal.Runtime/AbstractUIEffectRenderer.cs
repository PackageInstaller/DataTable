using System;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

[Serializable]
public abstract class AbstractUIEffectRenderer
{
	[NonSerialized]
	public string EffectName;

	public virtual bool Renderer(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, ref RenderingData renderingData, CommandBuffer cmd, float Intensity)
	{
		return false;
	}

	public virtual void Cleanup()
	{
	}
}
