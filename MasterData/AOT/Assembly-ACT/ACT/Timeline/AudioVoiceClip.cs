using ACT.Sound;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class AudioVoiceClip : PlayableAsset
{
	[Tooltip("FMOD音频事件引用")]
	public AudioEventReference audioEventReference;

	[Tooltip("音量（1表示使用默认音量）")]
	[Range(0f, 1f)]
	public float volume = 1f;

	[Tooltip("停止时是否淡出")]
	public bool fadeOutOnStop = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		AudioVoiceBehaviour template = new AudioVoiceBehaviour
		{
			audioEventReference = audioEventReference,
			volume = volume,
			fadeOutOnStop = fadeOutOnStop
		};
		return ScriptPlayable<AudioVoiceBehaviour>.Create(graph, template);
	}
}
