using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;
using UnityEngine.Rendering.Universal.Internal;

namespace XPostProcessing;

public abstract class AbstractVolumeRenderer
{
	public virtual bool IsBeforeTAA => false;

	public abstract bool IsActive();

	public abstract bool Init();

	public virtual bool Render(ref ScriptableRenderContext context, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		Render(cmd, source, target, ppp);
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
		return true;
	}

	public virtual void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target)
	{
	}

	public virtual void Render(CommandBuffer cmd, RenderTargetIdentifier source, RenderTargetIdentifier target, PostProcessPass ppp)
	{
		Render(cmd, source, target);
	}

	public virtual void Cleanup()
	{
	}

	public abstract bool PlatformCompatible();

	internal virtual void SetVolumeComponentCache(VolumeComponentCache volumeComponents)
	{
	}
}
