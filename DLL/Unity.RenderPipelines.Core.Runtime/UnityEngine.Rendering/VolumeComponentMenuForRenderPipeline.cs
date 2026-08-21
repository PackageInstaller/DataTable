using System;

namespace UnityEngine.Rendering;

public class VolumeComponentMenuForRenderPipeline : VolumeComponentMenu
{
	public Type[] pipelineTypes { get; }

	public VolumeComponentMenuForRenderPipeline(string menu, params Type[] pipelineTypes)
		: base(menu)
	{
		if (pipelineTypes == null)
		{
			throw new Exception("Specify a list of supported pipeline");
		}
		foreach (Type type in pipelineTypes)
		{
			if (!typeof(RenderPipeline).IsAssignableFrom(type))
			{
				throw new Exception($"You can only specify types that inherit from {typeof(RenderPipeline)}, please check {type}");
			}
		}
		this.pipelineTypes = pipelineTypes;
	}
}
