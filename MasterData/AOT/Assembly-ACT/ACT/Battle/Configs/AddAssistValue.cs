using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("添加援护值", "Action", new string[] { "add", "assist", "value" })]
public class AddAssistValue : ConfigAction
{
	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		if (!memory.target.entity.IsCharacter())
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{memory.ability}在添加援护值的时候,target不是 角色");
			}
			Singleton<GameManager>.instance.ecsManager.systemAssist.ChangeAssistValueForCharacter(memory.caster, value.Return(memory), CompAbility.AssistChangeReason.Ability);
		}
		Singleton<GameManager>.instance.ecsManager.systemAssist.ChangeAssistValueForCharacter(memory.target.entity, value.Return(memory), CompAbility.AssistChangeReason.Ability);
	}
}
