using System;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class DelayAction : InteractAction
{
	public float seconds;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		return UniTask.Delay(TimeSpan.FromSeconds(seconds));
	}
}
