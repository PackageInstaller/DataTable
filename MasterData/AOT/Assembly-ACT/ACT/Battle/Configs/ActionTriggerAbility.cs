using ACT.MultiPlayer;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("触发技能", "Action", new string[] { "trigger", "ability", "skill", "cd" })]
public class ActionTriggerAbility : ConfigAction
{
	public TriggerType type;

	public bool casterIsTargetSelf;

	public string name;

	public int skillId;

	public int stack = 1;

	public ConfigFunction<float> configFunction = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 1f
		}
	};

	public AddAbilityDurationData addAbilityDurationData;

	protected override AbilityAuth defaultAuth => type switch
	{
		TriggerType.Trigger => AbilityAuth.Owner, 
		TriggerType.Add => AbilityAuth.Both, 
		TriggerType.AddWithSkillId => AbilityAuth.Both, 
		TriggerType.Remove => AbilityAuth.Both, 
		TriggerType.RemoveStack => AbilityAuth.Both, 
		TriggerType.SetStack => AbilityAuth.Both, 
		_ => AbilityAuth.Owner, 
	};

	public override void Do(ActionMemory memory)
	{
		int rogueTrigger = memory.ability?.rogueTrigger ?? (-1);
		if (!memory.target.entity.TryGetCompAbility(out CompAbility _))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{memory.owner} 的 {memory.ability}，由于目标 {memory.target.entity} 不是人物已跳过执行ActionTriggerAbility");
			}
			return;
		}
		AbilitySource abilitySource = AbilitySource.None;
		switch (addAbilityDurationData.abilitysourceType)
		{
		case AddAbilityDurationData.AbilitySourceType.defaultType:
			abilitySource = memory.ability?.source ?? AbilitySource.None;
			break;
		case AddAbilityDurationData.AbilitySourceType.forceNewType:
			abilitySource = AbilitySource.None;
			break;
		}
		int num = ((configFunction != null) ? ((int)configFunction.Return(memory)) : stack);
		switch (type)
		{
		case TriggerType.SystemAdd:
			memory.target.entity.GetCompAbility().AddAbility(memory.caster, name, AbilitySource.System | abilitySource, memory.ability?.skillLevelInfo ?? default(MPSkill), stack, rogueTrigger);
			break;
		case TriggerType.Trigger:
			Singleton<GameManager>.instance.ecsManager.systemAbility.TriggerAbility(memory.caster, memory.target.entity, this);
			break;
		case TriggerType.Add:
		{
			Entity caster = (casterIsTargetSelf ? memory.target.entity : memory.caster);
			AbilitySource abilitySource2 = addAbilityDurationData.type switch
			{
				AddAbilityDurationData.AddAbilityDurationType.AddWithRoleBuild => AbilitySource.UpgradeSkill | abilitySource, 
				AddAbilityDurationData.AddAbilityDurationType.SystemAdd => AbilitySource.System | abilitySource, 
				AddAbilityDurationData.AddAbilityDurationType.AddWithNewSkillID => AbilitySource.Ability | abilitySource, 
				AddAbilityDurationData.AddAbilityDurationType.None => AbilitySource.Ability | abilitySource, 
				_ => AbilitySource.Ability | abilitySource, 
			};
			if (addAbilityDurationData.type == AddAbilityDurationData.AddAbilityDurationType.AddWithRoleBuild || addAbilityDurationData.type == AddAbilityDurationData.AddAbilityDurationType.AddWithNewSkillID)
			{
				abilitySource2 &= AbilitySource.UpgradeSkill;
			}
			MPSkill skillLevelInfo = ((memory.ability != null) ? memory.ability.skillLevelInfo : default(MPSkill));
			if (addAbilityDurationData.type == AddAbilityDurationData.AddAbilityDurationType.AddWithNewSkillID || addAbilityDurationData.skillId != 0)
			{
				Entity entity = (memory.caster.TryGetCompProduct(out CompProduct component2) ? component2.caster : memory.caster);
				if (entity.IsCharacter())
				{
					skillLevelInfo = ((!entity.GetCompAbility().dummyAbilities.TryGetValue(addAbilityDurationData.skillId, out var value)) ? new MPSkill
					{
						id = addAbilityDurationData.skillId,
						level = 1
					} : value.skillLevelInfo);
				}
				else if (entity.IsMonster())
				{
					skillLevelInfo = new MPSkill
					{
						id = addAbilityDurationData.skillId,
						level = 1
					};
				}
			}
			AddAbilityDurationData.AbilityStackType abilityStackType = addAbilityDurationData.abilityStackType;
			if (abilityStackType != AddAbilityDurationData.AbilityStackType.add && abilityStackType == AddAbilityDurationData.AbilityStackType.set && memory.target.entity.GetCompAbility().TryGetAbility(name, includeAdd: false, out var ab2))
			{
				if (ab2.stack > num)
				{
					ab2.RemoveStack(ab2.stack - num);
					break;
				}
				num = ((ab2.stack < num) ? (num - ab2.stack) : 0);
			}
			memory.target.entity.GetCompAbility().AddAbility(caster, name, abilitySource2, skillLevelInfo, num, rogueTrigger);
			break;
		}
		case TriggerType.AddWithSkillId:
			memory.target.entity.GetCompAbility().AddAbilityByBinding(memory.caster, skillId, name, AbilitySource.UpgradeSkill, rogueTrigger);
			break;
		case TriggerType.Remove:
			memory.target.entity.GetCompAbility().RemoveAbility(name);
			break;
		case TriggerType.RemoveStack:
			memory.target.entity.GetCompAbility().RemoveAbilityStack(name, num);
			break;
		case TriggerType.SetStack:
		{
			if (memory.target.entity.GetCompAbility().TryGetAbility(name, includeAdd: false, out var ab))
			{
				if (ab.stack > num)
				{
					ab.RemoveStack(ab.stack - num);
				}
				else if (ab.stack < num)
				{
					num -= ab.stack;
					memory.target.entity.GetCompAbility().AddAbility(memory.target.entity, name, AbilitySource.Ability | abilitySource, (memory.ability != null) ? memory.ability.skillLevelInfo : default(MPSkill), num, rogueTrigger);
				}
			}
			else
			{
				memory.target.entity.GetCompAbility().AddAbility(memory.target.entity, name, AbilitySource.Ability | abilitySource, (memory.ability != null) ? memory.ability.skillLevelInfo : default(MPSkill), num, rogueTrigger);
			}
			break;
		}
		}
	}
}
