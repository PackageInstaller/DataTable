using System;
using System.Runtime.CompilerServices;

namespace UnityEngine.Rendering;

public class VolumeComponentMenuForRenderPipeline : VolumeComponentMenu
{
	[CompilerGenerated]
	private readonly Type[] pipelineTypes__BackingField;

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
		pipelineTypes__BackingField = pipelineTypes;
	}
}
