using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0.9f, 0.5f, 0.1f)]
[TrackClipType(typeof(AudioVoiceClip))]
public class AudioVoiceTrack : TrackAsset
{
	protected override void OnCreateClip(TimelineClip clip)
	{
		base.OnCreateClip(clip);
		clip.displayName = "Voice";
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		foreach (TimelineClip clip in GetClips())
		{
			AudioVoiceClip audioVoiceClip = clip.asset as AudioVoiceClip;
			if (audioVoiceClip != null)
			{
				clip.displayName = GetClipDisplayName(audioVoiceClip);
			}
		}
		return ScriptPlayable<AudioVoiceMixerBehaviour>.Create(graph, inputCount);
	}

	private string GetClipDisplayName(AudioVoiceClip voiceClip)
	{
		if (!voiceClip.audioEventReference.IsNull())
		{
			return voiceClip.audioEventReference.ToString();
		}
		return "Voice (Empty)";
	}
}
