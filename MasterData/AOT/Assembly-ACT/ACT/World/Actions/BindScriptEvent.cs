using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine.Events;

namespace ACT.World.Actions;

public class BindScriptEvent : InteractAction
{
	public UnityEvent<Entity> unityEvent;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		unityEvent?.Invoke(behave);
	}
}
