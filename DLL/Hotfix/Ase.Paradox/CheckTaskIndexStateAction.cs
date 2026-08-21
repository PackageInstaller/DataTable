using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查任务状态索引值", 0)]
[Category("✫ DragonLost/Task")]
[Description("检查任务对应索引的状态值")]
public class CheckTaskIndexStateAction : ConditionTaskBase
{
	[Name("任务ID", 0)]
	[Description("任务ID")]
	public int TaskId;

	[Name("状态索引", 0)]
	[Description("状态索引")]
	public int TaskIndex;

	[Name("状态", 0)]
	[Description("状态")]
	public string TaskState;

	protected override bool OnCheck()
	{
		base.OnCheck();
		return Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().CheckTaskIndexState(TaskId, TaskIndex, TaskState);
	}
}
