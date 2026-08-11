using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("比较状态优先级", 0)]
[Category("✫ DragonLost/State")]
[Description("比较两个状态的优先级，确定是否要转换到下一个状态。")]
public class CompareStatePriority : ActionTaskBase
{
	[Name("当前状态", 0)]
	[Description("要比较的当前状态的ID。")]
	public BBParameter<int> curStateId;

	[Name("比较状态", 0)]
	[Description("要比较的另一个状态的ID。")]
	public BBParameter<int> nextStateId;

	protected override void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}
}
