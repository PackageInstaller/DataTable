using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改Render层Mask", "Action", new string[] { "change", "render", "layer", "mask" })]
public class ActionChangeRenderLayerMask : ConfigAction
{
	public LightLayerEnum lightLayer;

	public bool enable;

	public override void Do(ActionMemory memory)
	{
		if (!memory.target.entity.IsValid || memory.target.entity.GetMono() == null)
		{
			return;
		}
		Renderer[] renderers = memory.target.entity.GetMono().renderers;
		foreach (Renderer renderer in renderers)
		{
			renderer.renderingLayerMask |= (uint)lightLayer;
			if (!enable)
			{
				renderer.renderingLayerMask ^= (uint)lightLayer;
			}
		}
	}
}
