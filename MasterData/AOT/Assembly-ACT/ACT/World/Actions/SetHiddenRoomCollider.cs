using ACT.Battle.Configs;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class SetHiddenRoomCollider : InteractAction
{
	[Tooltip("碰撞盒")]
	public BoxCollider box;

	public InteractObject interactObject;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (stateObjectBase.entity.GetCompStateObject().StateWorldAssetData is HiddenRoomData hiddenRoomData && box != null)
		{
			box.size = hiddenRoomData.colliderSize;
			box.center = hiddenRoomData.colliderCenter;
		}
		return UniTask.CompletedTask;
	}
}
