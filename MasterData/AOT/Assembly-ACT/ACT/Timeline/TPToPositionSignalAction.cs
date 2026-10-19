using ACT.Drama;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class TPToPositionSignalAction : ISignalAction
{
	public Vector3 Position;

	public bool NeedWaitTPComplete;

	[SerializeField]
	private int _chunkId;

	public static bool IsTimelineTP { get; private set; }

	public async UniTask Invoke(INotificationReceiver receiver)
	{
		IsTimelineTP = true;
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = Position,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		if (!NeedWaitTPComplete)
		{
			await TeleportUtility.TeleportWithNone(_chunkId, teleportParams);
		}
		else
		{
			ActionSignalReceiver actionSignalReceiver = receiver as ActionSignalReceiver;
			ConversationController cc = null;
			if (actionSignalReceiver != null)
			{
				cc = actionSignalReceiver.GetComponent<ConversationController>();
				if (cc != null)
				{
					cc.PlayableDirector.playableGraph.GetRootPlayable(0).SetSpeed(0.0);
				}
			}
			await TeleportUtility.TeleportWithNone(_chunkId, teleportParams);
			if (cc != null)
			{
				cc.PlayableDirector.playableGraph.GetRootPlayable(0).SetSpeed(1.0);
			}
		}
		IsTimelineTP = false;
	}
}
