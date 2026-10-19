using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class BoardCastBettleEventSignal : ISignalAction
{
	[SerializeField]
	private string _eventName;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		GameManager.aiSystem?.BoardCastEvent(_eventName);
		return UniTask.CompletedTask;
	}
}
