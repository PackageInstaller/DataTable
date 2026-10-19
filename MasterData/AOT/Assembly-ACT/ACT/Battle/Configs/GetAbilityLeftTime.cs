using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取技能剩余时间", "Function", new string[] { "get", "ability", "left", "time" })]
public class GetAbilityLeftTime : ConfigFunction<float>
{
	public string name;

	protected override float Evaluate(ActionMemory memory)
	{
		if (!memory.target.entity.TryGetCompAbility(out CompAbility component))
		{
			return 0f;
		}
		if (!component.HasAbility(name) || component.GetAbilityByName(name).config.durationType == DurationType.Infinite)
		{
			return 0f;
		}
		return component.GetAbilityByName(name).Duration.GetVal(0);
	}
}
