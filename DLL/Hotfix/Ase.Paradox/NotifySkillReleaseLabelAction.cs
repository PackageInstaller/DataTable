using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("技能自定义的通知", 0)]
[Category("✫ DragonLost/Skill")]
[Description("发送技能自定义的通知。")]
public class NotifySkillReleaseLabelAction : ActionTaskBase
{
	[Name("技能标签", 0)]
	[Description("要通知的技能标签。")]
	public BBParameter<string> skillLabel;

	protected override void OnExecute()
	{
		base.OnExecute();
		EndAction();
	}
}
