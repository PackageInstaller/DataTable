using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0.2f, 0.65f, 0.95f)]
[TrackClipType(typeof(AudioClip))]
public class AudioTrack : TrackAsset
{
	protected override void OnCreateClip(TimelineClip clip)
	{
		base.OnCreateClip(clip);
		clip.displayName = "Audio";
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		foreach (TimelineClip clip in GetClips())
		{
			if (clip.asset is AudioClip audioClip)
			{
				clip.displayName = GetClipDisplayName(audioClip);
			}
		}
		return ScriptPlayable<AudioMixerBehaviour>.Create(graph, inputCount);
	}

	private static string GetClipDisplayName(AudioClip audioClip)
	{
		if (!audioClip.audioEventReference.IsNull())
		{
			return audioClip.audioEventReference.ToString();
		}
		return "Audio (Empty)";
	}
}
