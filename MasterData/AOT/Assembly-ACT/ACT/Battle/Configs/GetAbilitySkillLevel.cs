namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取技能等级", "Function", new string[] { "get", "ability", "skill", "level" })]
public class GetAbilitySkillLevel : ConfigFunction<float>
{
	protected override float Evaluate(ActionMemory memory)
	{
		if (memory.ability == null)
		{
			return 0f;
		}
		return (int)memory.ability.skillLevelInfo.level;
	}
}
