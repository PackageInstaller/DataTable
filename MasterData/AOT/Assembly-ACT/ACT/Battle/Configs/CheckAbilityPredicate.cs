using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断技能", "Predicate", new string[] { "check", "ability", "predicate", "condition", "skill", "cd" })]
public class CheckAbilityPredicate : ConfigPredicate
{
	public string name;

	public bool useTag;

	public bool useCustomTag;

	public BuffTag tag;

	public string customTag;

	public override bool Check(ActionMemory memory)
	{
		CompAbility compAbility = memory.target.entity.GetCompAbility();
		if (compAbility == null)
		{
			return false;
		}
		if (useCustomTag)
		{
			return compAbility.HasAbilityCustomTag(customTag);
		}
		if (!useTag)
		{
			return compAbility.HasAbility(name);
		}
		return compAbility.HasAbilityTag(tag);
	}
}
