using UnityEngine;

namespace Ase;

[Trigger("交互物2修改任务目标指引触发器")]
public class MapItem2ChangeTaskPointEventTrigger : MapItemEventTrigger
{
	public int taskId;

	public int index;

	public Vector2 taskPoint;

	public bool changeActiveState;

	public bool active;

	public override string TriggerName => "交互物-修改任务目标指引触发器";

	protected override async void DoExecute()
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
