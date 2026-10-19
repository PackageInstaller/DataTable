using ACT.Event;
using ACT.Sound;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class PlayCommonAudioSignalAction : ISignalAction
{
	public CommonAudioType audioType;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		PlayCommonAudioEvt evt = Singleton<EventManager>.instance.GetEvt<PlayCommonAudioEvt>();
		evt.AudioType = audioType;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.PlayCommonAudio, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		return UniTask.CompletedTask;
	}
}
