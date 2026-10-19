namespace ACT.Battle.Configs;

[AbilityTypeMetadata("技能数量修正效果", "Mixin", new string[] { "skill", "count", "modifier" })]
public class ConfigMixinSkillCountModifier : ConfigMixin
{
	public string skillName = "dodgeCD";

	public int addCount;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSkillCountModifier(this, ab, index);
	}
}
