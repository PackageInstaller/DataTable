using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("英雄释放技能", 0)]
[Category("✫ DragonLost/Skill")]
[Description("让英雄释放指定类型的技能。")]
public class ReleaseSkillAction : ActionTaskBase
{
	[Name("技能类型", 0)]
	[Description("要释放的技能类型。")]
	public BBParameter<HeroSkillTypeEnum> skillType;

	[Name("技能标签", 0)]
	[Description("要释放的技能标签。")]
	public BBParameter<string> skillLabel;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
