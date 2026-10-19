using ACT.Drama;
using Cysharp.Threading.Tasks;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class JudgeTPCompleteSignalAction : ISignalAction
{
	public async UniTask Invoke(INotificationReceiver receiver)
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
		await UniTask.WaitUntil(() => !TPToPositionSignalAction.IsTimelineTP);
		cc.PlayableDirector.playableGraph.GetRootPlayable(0).SetSpeed(1.0);
	}
}
