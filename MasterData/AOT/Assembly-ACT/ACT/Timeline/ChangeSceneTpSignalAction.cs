using ACT.Drama;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class ChangeSceneTpSignalAction : ISignalAction
{
	[SerializeField]
	private Vector3 _targetPos;

	[SerializeField]
	private bool _needWaitTPComplete;

	[SerializeField]
	private int _chunkId;

	[SerializeField]
	private int _worldId;

	public static bool IsTimelineTP { get; private set; }

	public async UniTask Invoke(INotificationReceiver receiver)
	{
		IsTimelineTP = true;
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = _targetPos,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		if (!_needWaitTPComplete)
		{
			await TeleportUtility.SceneChangeTpWithLoader(_chunkId, _worldId, teleportParams);
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
			await TeleportUtility.SceneChangeTpWithLoader(_chunkId, _worldId, teleportParams);
			if (cc != null)
			{
				cc.PlayableDirector.playableGraph.GetRootPlayable(0).SetSpeed(1.0);
			}
		}
		IsTimelineTP = false;
	}
}
