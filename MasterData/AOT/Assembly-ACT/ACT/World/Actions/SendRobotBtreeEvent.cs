using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class SendRobotBtreeEvent : InteractAction
{
	public string eventName;

	public bool useArg;

	public bool setActiveRobot = true;

	public bool closeRobot;

	public Transform target;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
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
