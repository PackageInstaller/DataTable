using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Unity.VisualScripting;
using UnityEngine;

namespace ACT.World.Actions;

public class TriggerCustomEvent : InteractAction
{
	public GameObject target;

	public string eventName;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		CustomEvent.Trigger(target, eventName, null);
		return UniTask.CompletedTask;
	}
}
