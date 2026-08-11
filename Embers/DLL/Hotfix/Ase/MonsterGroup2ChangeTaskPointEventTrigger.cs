using UnityEngine;

namespace Ase;

[Trigger("怪物组2修改任务目标指引事件触发器")]
public class MonsterGroup2ChangeTaskPointEventTrigger : MonsterGroupEventTrigger
{
	public int taskId;

	public int index;

	public Vector2 taskPoint;

	public bool changeActiveState;

	public bool active;

	public override string TriggerName => "怪物组-修改任务目标指引";

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
