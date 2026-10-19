using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("切换技能目标效果", "Mixin", new string[] { "switch", "skill", "find", "target", "retarget", "aim" })]
public class ConfigMixinSwitchSkillFindTarget : ConfigMixin
{
	[SerializeField]
	private WhereTargets _where;

	public WhereTargets Where => _where;

	public override BaseAbilityMixin CreateInst(Ability ab, byte index)
	{
		return new AbilityMixinSwitchSkillFindTarget(this, ab, index);
	}
}
