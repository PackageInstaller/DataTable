using ACT.Sound;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Serialization;

namespace ACT.Timeline;

public class AudioClip : PlayableAsset
{
	[Tooltip("FMOD音频事件引用")]
	public AudioEventReference audioEventReference;

	[Tooltip("音量（1表示使用默认音量）")]
	[Range(0f, 1f)]
	public float volume = 1f;

	[Tooltip("停止时是否淡出")]
	public bool fadeOutOnStop = true;

	[Tooltip("忽略 Timeline 时间同步，音频保持自身播放进度")]
	[FormerlySerializedAs("keepPlayingOnTimelineLoop")]
	public bool ignoreTimelineTime;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		AudioBehaviour template = new AudioBehaviour
		{
			audioEventReference = audioEventReference,
			volume = volume,
			fadeOutOnStop = fadeOutOnStop,
			ignoreTimelineTime = ignoreTimelineTime
		};
		return ScriptPlayable<AudioBehaviour>.Create(graph, template);
	}
}
