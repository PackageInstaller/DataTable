using ACT.Battle.Configs;
using ACT.MultiPlayer;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

[AbilityTypeMetadata("执行动态变量技能", "Action", new string[] { "dynamic", "var", "trigger", "ability", "skill", "cd" })]
public class ActionDynamicVarTriggerAbility : ConfigAction
{
	public enum TriggerType
	{
		AddStack,
		RemoveStack,
		SetStack,
		SystemAdd
	}

	public ConfigFunction<float> value;

	public string abilityName;

	public TriggerType type;

	public override void Do(ActionMemory memory)
	{
		int rogueTrigger = ((memory.ability != null) ? memory.ability.rogueTrigger : (-1));
		AbilitySource abilitySource = memory.ability?.source ?? AbilitySource.None;
		if (!(memory.evt is EvtDynamicValueChange))
		{
			return;
		}
		int num = Mathf.Abs((int)value.Return(memory));
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		switch (type)
		{
		case TriggerType.AddStack:
			if (num > 0)
			{
				compAbility.AddAbility(memory.caster, abilityName, AbilitySource.System | abilitySource, (memory.ability != null) ? memory.ability.skillLevelInfo : default(MPSkill), num, rogueTrigger);
			}
			break;
		case TriggerType.RemoveStack:
			if (num > 0)
			{
				compAbility.RemoveAbilityStack(abilityName, num);
			}
			break;
		case TriggerType.SetStack:
		{
			if (compAbility.TryGetAbility(abilityName, includeAdd: false, out var ab))
			{
				if (ab.stack > num)
				{
					ab.RemoveStack(ab.stack - num);
				}
				else
				{
					compAbility.AddAbility(memory.target.entity, abilityName, AbilitySource.Ability | abilitySource, (memory.ability != null) ? memory.ability.skillLevelInfo : default(MPSkill), num - ab.stack, rogueTrigger);
				}
			}
			else
			{
				compAbility.AddAbility(memory.target.entity, abilityName, AbilitySource.Ability | abilitySource, (memory.ability != null) ? memory.ability.skillLevelInfo : default(MPSkill), num, rogueTrigger);
			}
			break;
		}
		case TriggerType.SystemAdd:
			if (num > 0)
			{
				compAbility.AddAbility(memory.caster, abilityName, AbilitySource.System | abilitySource, (memory.ability != null) ? memory.ability.skillLevelInfo : default(MPSkill), num, rogueTrigger);
			}
			break;
		}
	}
}
