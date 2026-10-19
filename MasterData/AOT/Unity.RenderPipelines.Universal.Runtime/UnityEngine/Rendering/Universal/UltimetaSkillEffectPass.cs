using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal;

public class UltimetaSkillEffectPass : ScriptableRenderPass
{
	public static List<Material> materials = new List<Material>();

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
	}
}
