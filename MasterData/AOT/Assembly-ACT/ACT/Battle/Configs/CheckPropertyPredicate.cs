using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断属性", "Predicate", new string[] { "check", "property", "predicate", "condition" })]
public class CheckPropertyPredicate : ConfigPredicate
{
	public CheckValue checkValue;

	public Condition condition;

	public ConfigFunction<float> targetValue = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	public bool percent;

	public ConfigFunction<float> targetValue1 = new ConstFloat
	{
		value = new DynamicFloat
		{
			source = ParamSource.Const,
			value = 0f
		}
	};

	public override bool Check(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			return false;
		}
		float num = 0f;
		switch (checkValue)
		{
		case CheckValue.CurrHP:
			num = ((!percent) ? ((float)component.hp) : ((float)component.hp * 100f / (float)component.maxHP));
			break;
		case CheckValue.Posture:
			if (!component.IsHavePosture)
			{
				return false;
			}
			num = ((!percent) ? ((float)component.posture) : ((float)component.posture * 100f / (float)component.maxPosture));
			break;
		case CheckValue.Tenacity:
			num = ((!percent) ? ((float)component.tenacityValue) : ((float)component.tenacityValue * 100f / (float)component.maxTenacity));
			break;
		case CheckValue.Attack:
			num = component.atk;
			break;
		case CheckValue.UltraEnergy:
			num = ((!percent) ? component.CurrentUltimateSkillValue : (component.CurUltraEnergyPercent * 100f));
			break;
		case CheckValue.normalEnergy:
			num = ((!percent) ? component.EnergyValue : component.CurNormalEnergyPercent);
			break;
		case CheckValue.assistValue:
			num = ((!percent) ? component.AssistValue : (component.AssistPercent * 100f));
			break;
		}
		int num2 = (int)(percent ? (targetValue1.Return(memory) * 100f) : targetValue.Return(memory));
		return condition switch
		{
			Condition.Greater => num > (float)num2, 
			Condition.Less => num < (float)num2, 
			Condition.Equal => (int)num == num2, 
			Condition.GreaterAndEqual => (int)num >= num2, 
			Condition.LessAndEqual => (int)num <= num2, 
			_ => false, 
		};
	}
}
