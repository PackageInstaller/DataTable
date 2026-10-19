using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskDescription("根据index 选择该节点的 某个子节点，从左到右从0开始计数")]
public class DoIndexedSon : Composite
{
	public SharedInt index = 0;

	private TaskStatus executionStatus;

	public override int CurrentChildIndex()
	{
		return index.Value;
	}

	public override void OnStart()
	{
		base.OnStart();
		executionStatus = TaskStatus.Running;
	}

	public override bool CanExecute()
	{
		if (index.Value < children.Count)
		{
			return executionStatus == TaskStatus.Running;
		}
		return false;
	}

	public override void OnChildExecuted(TaskStatus childStatus)
	{
		executionStatus = childStatus;
	}

	public override void OnConditionalAbort(int childIndex)
	{
		executionStatus = TaskStatus.Inactive;
	}

	public override void OnEnd()
	{
		executionStatus = TaskStatus.Inactive;
	}
}
