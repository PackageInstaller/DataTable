using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0f, 1f, 0f)]
[TrackClipType(typeof(SubtitleClip))]
public class SubtitleTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		foreach (TimelineClip clip in GetClips())
		{
			SubtitleClip subtitleClip = clip.asset as SubtitleClip;
			if ((bool)subtitleClip)
			{
				subtitleClip.SubtitleBehaviour.Content = subtitleClip.content;
				subtitleClip.SubtitleBehaviour.endTime = clip.end;
			}
		}
		return ScriptPlayable<SubtitleMixerBehaviour>.Create(graph, inputCount);
	}
}
