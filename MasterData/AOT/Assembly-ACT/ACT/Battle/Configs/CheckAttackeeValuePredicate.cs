using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断Attackee值", "Predicate", new string[] { "check", "attackee", "value", "predicate", "condition" })]
public class CheckAttackeeValuePredicate : ConfigPredicate
{
	public bool redirectAttacker;

	public CheckValue checkValue;

	public Condition condition;

	public ConfigFunction<float> floatValue = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	public bool percent;

	public override bool Check(ActionMemory memory)
	{
		if (memory.evt is IGetAttackData)
		{
			float num = 0f;
			Entity entity = (memory.evt as IGetAttackData).GetAttackData().attackee;
			if (redirectAttacker)
			{
				entity = (memory.evt as IGetAttackData).GetAttackData().attacker;
			}
			CompAbility compAbility = entity.GetCompAbility();
			switch (checkValue)
			{
			case CheckValue.CurrHP:
				num = ((!percent) ? ((float)compAbility.hp) : ((float)compAbility.hp * 100f / (float)compAbility.maxHP));
				break;
			case CheckValue.Posture:
				if (!compAbility.IsHavePosture)
				{
					return false;
				}
				num = ((!percent) ? ((float)compAbility.posture) : ((float)compAbility.posture * 100f / (float)compAbility.maxPosture * 100f));
				break;
			case CheckValue.Tenacity:
				num = ((!percent) ? ((float)compAbility.tenacityValue) : ((float)compAbility.tenacityValue * 100f / (float)compAbility.maxTenacity * 100f));
				break;
			case CheckValue.Attack:
				num = compAbility.atk;
				break;
			case CheckValue.UltraEnergy:
				num = ((!percent) ? compAbility.CurrentUltimateSkillValue : compAbility.CurUltraEnergyPercent);
				break;
			case CheckValue.normalEnergy:
				num = ((!percent) ? compAbility.EnergyValue : compAbility.CurNormalEnergyPercent);
				break;
			case CheckValue.assistValue:
				num = ((!percent) ? compAbility.AssistValue : compAbility.AssistPercent);
				break;
			}
			ActionMemory memory2 = new ActionMemory(entity, entity, entity, memory.evt, memory.ability);
			float num2 = floatValue?.Return(memory2) ?? 0f;
			return condition switch
			{
				Condition.Greater => num > num2, 
				Condition.Less => num < num2, 
				Condition.Equal => Mathf.Approximately(num, num2), 
				Condition.GreaterAndEqual => num >= num2, 
				Condition.LessAndEqual => num <= num2, 
				_ => false, 
			};
		}
		return false;
	}
}
