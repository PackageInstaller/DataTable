using System;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.NPC.Actions;

[Serializable]
[AsyncAction]
public class ActionTeleport : NpcInteractAction
{
	public Vector3 position;

	[SerializeField]
	private int _chunkId;

	public bool useBlackScreen;

	public float blackFadeDuration;

	public override int ActionId => NpcInteractActionIds.Teleport;

	protected override async UniTask DoAction()
	{
		int chunkId = _chunkId;
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = position,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		if (!useBlackScreen)
		{
			await TeleportUtility.TeleportWithNone(chunkId, teleportParams);
		}
		else
		{
			await TeleportUtility.TeleportWithPureBlackScreen(chunkId, teleportParams, blackFadeDuration);
		}
		await base.DoAction();
	}
}
