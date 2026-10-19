using System.Threading;
using ACT.Battle;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class TriggerSendRobotBtreeEvent : TriggerActionBase
{
	public string eventName;

	public bool useArg;

	public bool setActiveRobot = true;

	public bool closeRobot;

	public Transform target;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		Entity robotEntity = MonoECS.instance.localPlayer.robotEntity;
		if (robotEntity.IsValid)
		{
			if (setActiveRobot)
			{
				MonoECS.instance.RobotActive(!closeRobot);
			}
			if (useArg)
			{
				robotEntity.GetBTree().SendEvent(eventName, (object)target.position);
			}
			else
			{
				robotEntity.GetBTree().SendEvent(eventName);
			}
		}
		return UniTask.CompletedTask;
	}
}
