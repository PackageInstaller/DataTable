using System;
using ACT.Battle.Configs;
using ACT.Game;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class DelayFireInteractEvent : InteractAction
{
	public float delayTime;

	[SerializeField]
	public VarName eventName;

	protected override AbilityAuth auth => AbilityAuth.Server;

	protected override async UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		await UniTask.Delay(TimeSpan.FromSeconds(delayTime));
		G.service.TriggerCustomInteractEvent(stateObjectBase.entity.GetCompStateObject().StateWorldAssetData.stateWorldAssetUid, eventName, null);
	}
}
