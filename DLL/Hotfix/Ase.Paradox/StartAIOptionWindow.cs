using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("启动AI操作窗口", 0)]
[Category("✫ DragonLost/Skill")]
[Description("启动AI操作窗口，并返回操作编号。")]
public class StartAIOptionWindow : ActionTaskBase
{
	[Name("操作编号", 0)]
	[Description("要返回的操作编号。")]
	public BBParameter<int> returnOptionId;

	protected override void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}
}
