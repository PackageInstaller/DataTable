using System.Threading;
using ACT.Battle;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class TPAction : MissionAction
{
	public override bool OnlyInMissionWorld => true;

	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		await UniTask.WaitUntil(() => Singleton<GameState>.instance.PlayerAlive == PlayerLiveState.Normal, PlayerLoopTiming.Update, token);
		if (!token.IsCancellationRequested)
		{
			TPActionParam tPActionParam = Param as TPActionParam;
			int num = tPActionParam.chunkId;
			if (num == 0)
			{
				num = Singleton<GameManager>.instance.worldManager.ActiveChunkId;
			}
			TeleportParams teleportParams = new TeleportParams
			{
				targetPos = new Vector3(tPActionParam.positionX, tPActionParam.positionY, tPActionParam.positionZ)
			};
			switch (tPActionParam.tpType)
			{
			case TPTYPE.None:
				await TeleportUtility.TeleportWithNone(num, teleportParams);
				break;
			case TPTYPE.Loader:
				await TeleportUtility.TeleportWithLoader(num, teleportParams);
				break;
			case TPTYPE.PureBlackScreen:
				await TeleportUtility.TeleportWithPureBlackScreen(num, teleportParams);
				break;
			case TPTYPE.BlackScreenWithUI:
			{
				BlackScreenParams blackScreenParams = new BlackScreenParams
				{
					leastDuration = 0.5f,
					fadeInDuration = 0.5f,
					fadeOutDuration = 0.5f
				};
				await TeleportUtility.TeleportWithBlackScreen(num, teleportParams, blackScreenParams);
				break;
			}
			}
		}
	}
}
