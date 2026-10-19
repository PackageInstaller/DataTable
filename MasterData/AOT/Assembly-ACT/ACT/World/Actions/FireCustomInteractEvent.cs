using ACT.Battle.Configs;
using ACT.Game;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class FireCustomInteractEvent : InteractAction
{
	[SerializeField]
	public VarName eventName;

	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		G.service.TriggerCustomInteractEvent(stateObjectBase.entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid, eventName, null);
		return UniTask.CompletedTask;
	}
}
