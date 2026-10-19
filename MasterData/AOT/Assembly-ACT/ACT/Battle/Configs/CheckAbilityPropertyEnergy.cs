using ACT.Core;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能属性能量", "Predicate", new string[] { "check", "ability", "property", "energy", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityPropertyEnergy : ConfigPredicate
{
	public AbilityPropertyType propertyType;

	public Condition calculateType;

	public float present;

	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			return false;
		}
		float num = propertyType switch
		{
			AbilityPropertyType.HP => component.hp / component.maxHP, 
			AbilityPropertyType.Shield => component.shieldPercent, 
			AbilityPropertyType.assist => component.AssistPercent, 
			AbilityPropertyType.Ultimate => component.CurUltraEnergyPercent, 
			AbilityPropertyType.skill => component.CurNormalEnergyPercent, 
			AbilityPropertyType.specialEnergy => component.CurSpecialEnergyPercent, 
			_ => 0f, 
		};
		return calculateType switch
		{
			Condition.Greater => num > present, 
			Condition.Less => num < present, 
			Condition.Equal => Mathf.Approximately(num, present), 
			Condition.GreaterAndEqual => num >= present, 
			Condition.LessAndEqual => num <= present, 
			_ => false, 
		};
	}
}
