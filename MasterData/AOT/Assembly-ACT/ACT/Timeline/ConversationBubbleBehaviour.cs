using System;
using ACT.Core;
using ACT.Drama;
using ACT.Sound.Management;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class ConversationBubbleBehaviour : PlayableBehaviour
{
	public long contentId;

	public ConversationBubbleTrackBehaviour track;

	private bool played;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (!played && RuntimeConfigs.data.dialogueStoryDatas.TryGetValue(contentId, out var value))
		{
			int speakerId = 0;
			if (RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(value.speakerId, out var value2))
			{
				speakerId = value2.nameLocal;
			}
			int num = (int)(contentId % 100);
			if (!played)
			{
				played = true;
				Singleton<ConversationManager>.instance.RecordHistory_Normal(0, contentId, speakerId, value.content, num, isPlayer: false);
			}
			if (track != null)
			{
				track.bubble.Show(value.content).Forget();
				Singleton<DramaVoiceManager>.instance.PlayVoiceEventAsync($"event:/Vo/CN/Dialogue/{contentId}", null, null, num).Forget();
			}
		}
	}
}
