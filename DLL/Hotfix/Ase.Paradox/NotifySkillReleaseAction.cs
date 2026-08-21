using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("技能释放完成的通知", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通知系统技能释放已经完成。")]
public class NotifySkillReleaseAction : ActionTaskBase
{
	[Name("技能类型", 0)]
	[Description("要通知释放完成的技能类型。")]
	public BBParameter<HeroSkillTypeEnum> skillType;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
