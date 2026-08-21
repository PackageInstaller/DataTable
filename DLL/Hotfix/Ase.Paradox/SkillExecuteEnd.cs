using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("技能执行完成", 0)]
[Category("✫ DragonLost/Skill")]
[Description("通知系统技能执行已经完成。")]
public class SkillExecuteEnd : ActionTaskBase
{
	[Name("技能名称", 0)]
	[Description("完成执行的技能的标识符。")]
	public BBParameter<int> executeSkillId;

	protected override async void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}
}
