using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

[Tooltip("灯塔解锁区域")]
public class LightHouseUnlockArea : InteractAction
{
	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		return UniTask.CompletedTask;
	}
}
