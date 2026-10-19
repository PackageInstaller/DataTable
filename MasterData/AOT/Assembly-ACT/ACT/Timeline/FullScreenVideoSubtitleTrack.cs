using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0.1f, 0.8f, 0.4f)]
[TrackClipType(typeof(FullScreenVideoSubtitleClip))]
public class FullScreenVideoSubtitleTrack : TrackAsset
{
	protected override void OnCreateClip(TimelineClip clip)
	{
		base.OnCreateClip(clip);
		clip.displayName = "Subtitle";
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		foreach (TimelineClip clip in GetClips())
		{
			FullScreenVideoSubtitleClip fullScreenVideoSubtitleClip = clip.asset as FullScreenVideoSubtitleClip;
			if (fullScreenVideoSubtitleClip != null)
			{
				fullScreenVideoSubtitleClip.behaviour.endTime = clip.end;
				clip.displayName = GetClipDisplayName(fullScreenVideoSubtitleClip);
			}
		}
		return ScriptPlayable<FullScreenVideoSubtitleMixerBehaviour>.Create(graph, inputCount);
	}

	private string GetClipDisplayName(FullScreenVideoSubtitleClip clip)
	{
		if (clip.contentId > 0)
		{
			return $"Subtitle [{clip.contentId}]";
		}
		return "Subtitle (Empty)";
	}
}
