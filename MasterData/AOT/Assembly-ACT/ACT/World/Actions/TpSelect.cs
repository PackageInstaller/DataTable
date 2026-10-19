using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.Actions;

public class TpSelect : InteractAction
{
	public Vector3 tpPos;

	[SerializeField]
	private int _chunkId;

	protected override AbilityAuth auth => AbilityAuth.ClientOwner;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = tpPos,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		TeleportUtility.TeleportWithLoader(_chunkId, teleportParams).Forget();
		return UniTask.CompletedTask;
	}
}
