namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能Buff类型", "Predicate", new string[] { "check", "ability", "buff", "type", "state", "status", "tag", "predicate", "condition" })]
public class CheckAbilityBuffType : ConfigPredicate
{
	public string buffName;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		if (EngineConfigs.ability.TryGetValue(buffName, out var value))
		{
			result = value.buffType switch
			{
				BuffType.Buff => true, 
				BuffType.Debuff => true, 
				_ => false, 
			};
		}
		return result;
	}
}
