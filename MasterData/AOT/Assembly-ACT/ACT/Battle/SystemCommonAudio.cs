using ACT.Event;
using ACT.Sound;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class SystemCommonAudio : ECSSystem
{
	public override Filter MajorFilter { get; }

	private void OnPlayCommonAudio(BaseEventContent content)
	{
		if (!(content is PlayCommonAudioEvt { AudioType: not CommonAudioType.None } playCommonAudioEvt))
		{
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		CompSound compSound = mainEntity.GetCompSound();
		if (compSound == null)
		{
			return;
		}
		if (!playCommonAudioEvt.NotifyAudioPlayOver)
		{
			compSound.PlayVoice((int)playCommonAudioEvt.AudioType);
			return;
		}
		uint audioInstanceId = 0u;
		audioInstanceId = compSound.PlayVoice((int)playCommonAudioEvt.AudioType, new AudioPlayOptions
		{
			onCompleteCallback = () =>
			{
				if (compSound.IsCurrentVoice(audioInstanceId))
				{
					AudioPlayOverEvt evt = Singleton<EventManager>.instance.GetEvt<AudioPlayOverEvt>();
					evt.AudioInstanceId = audioInstanceId;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.AudioPlayOver, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				}
			}
		});
	}

	protected override void OnCreate()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PlayCommonAudio, OnPlayCommonAudio);
	}
}
