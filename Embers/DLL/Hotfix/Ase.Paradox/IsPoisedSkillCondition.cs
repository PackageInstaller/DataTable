using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("判断技能是否是蓄力技能", 0)]
[Category("✫ DragonLost/Skill")]
[Description("检查给定的技能类型是否是蓄力技能。")]
public class IsPoisedSkillCondition : ConditionTaskBase
{
	[Name("技能类型", 0)]
	[Description("要检查的技能类型")]
	public BBParameter<HeroSkillTypeEnum> skillType;

	protected override bool OnCheck()
	{
		base.OnCheck();
		return false;
	}
}
