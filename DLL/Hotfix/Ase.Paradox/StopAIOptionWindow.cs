using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("结束AI操作窗口", 0)]
[Category("✫ DragonLost/Skill")]
[Description("结束AI操作窗口，并指定操作编号。")]
public class StopAIOptionWindow : ActionTaskBase
{
	[Name("操作编号", 0)]
	[Description("要结束的操作编号。")]
	public BBParameter<int> optionId;

	protected override void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}
}
