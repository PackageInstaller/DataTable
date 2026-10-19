using System;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取运行时属性值", "Function", new string[] { "runtime", "property", "value", "float", "int" })]
public class RuntimePropertyValue : ConfigFunction<float>
{
	public enum RunTimePropertyType
	{
		AttackRuntimeValue,
		PropertyRuntimeValue
	}

	public enum CurPropertyType
	{
		curHPPercent,
		curHPValue
	}

	public RunTimePropertyType runTimePropertyType;

	public DamageFormula.RuntimeValue runtimeValue;

	public string abilityName;

	public CurPropertyType curPropertyType;

	protected override float Evaluate(ActionMemory memory)
	{
		float result = 0f;
		switch (runTimePropertyType)
		{
		case RunTimePropertyType.AttackRuntimeValue:
		{
			Entity owner = memory.owner;
			Entity entity = memory.target.entity;
			CompAbility compAbility = owner.GetCompAbility();
			CompAbility compAbility2 = entity.GetCompAbility();
			Ability ab;
			Ability ab2;
			return runtimeValue switch
			{
				DamageFormula.RuntimeValue.AttackerHp => compAbility.hp, 
				DamageFormula.RuntimeValue.AttackeeHp => compAbility2.hp, 
				DamageFormula.RuntimeValue.AttackerPercentHp => (float)compAbility.hp / (float)compAbility.maxHP, 
				DamageFormula.RuntimeValue.AttackeePercentHp => (float)compAbility2.hp / (float)compAbility2.maxHP, 
				DamageFormula.RuntimeValue.AttackerAbilityStack => compAbility.TryGetAbility(abilityName, includeAdd: true, out ab) ? ab.stack : 0, 
				DamageFormula.RuntimeValue.AttackeeAbilityStack => compAbility2.TryGetAbility(abilityName, includeAdd: true, out ab2) ? ab2.stack : 0, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
		}
		case RunTimePropertyType.PropertyRuntimeValue:
			switch (curPropertyType)
			{
			case CurPropertyType.curHPPercent:
				result = memory.target.entity.GetCompAbility().HpPercent;
				break;
			case CurPropertyType.curHPValue:
				result = memory.target.entity.GetCompAbility().hp;
				break;
			}
			break;
		}
		return result;
	}
}
