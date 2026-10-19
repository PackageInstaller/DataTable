using System;
using System.Collections;
using ACT.Battle.Configs;
using ACT.World.Behave;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class DelayTriggerEvent : InteractAction
{
	public InteractObjectBehaveEvents interactEvents;

	public string eventName;

	public float delayTime;

	protected override AbilityAuth auth
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		return UniTask.CompletedTask;
	}

	private IEnumerator WaitAndDo()
	{
		yield return new WaitForSeconds(delayTime);
		interactEvents.SendMessage("Do", eventName);
	}
}
