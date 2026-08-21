using UnityEngine;

namespace Ase;

[Trigger("修改任务目标指引区域触发器")]
public class ChangeTaskPointTrigger : BaseTrigger
{
	public int taskId;

	public int index;

	public Vector2 taskPoint;

	public bool changeActiveState;

	public bool active;

	public override string TriggerName => "修改任务目标指引区域触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (changeActiveState)
		{
			sceneSystem.GetSystem<TaskSystem>().UpdateTaskPosition(taskId, index, active);
		}
		else
		{
			sceneSystem.GetSystem<TaskSystem>().UpdateTaskPosition(taskId, index, taskPoint);
		}
	}
}
