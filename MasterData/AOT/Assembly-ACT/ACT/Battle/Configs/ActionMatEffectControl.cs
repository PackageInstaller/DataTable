using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行材质特效控制", "Action", new string[] { "mat", "effect", "control", "fx", "particle" })]
public class ActionMatEffectControl : ConfigAction
{
	public bool show;

	public override void Do(ActionMemory memory)
	{
		float value = (show ? 1f : 0f);
		Renderer[] renderers = memory.target.entity.GetMono().renderers;
		foreach (Renderer renderer in renderers)
		{
			if (renderer == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError($"{memory.target.entity} 在 MonoEntity 组件中的 Renderers list中有元素为空，对应策划检查下配置");
				}
			}
			else
			{
				renderer.material.SetFloat(BattleConsts.SHAER_EFFECT_DODGEEFFECT, value);
			}
		}
	}
}
