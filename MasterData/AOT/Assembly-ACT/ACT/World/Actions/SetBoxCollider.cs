using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class SetBoxCollider : InteractAction
{
	[Tooltip("碰撞盒")]
	public BoxCollider box;

	[Tooltip("是否关闭")]
	public bool active;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		box.enabled = active;
		return UniTask.CompletedTask;
	}
}
