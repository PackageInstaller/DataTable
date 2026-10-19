using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0f, 1f, 0f)]
[TrackClipType(typeof(BlackScreenTextClip))]
public class BlackScreenTextTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		foreach (TimelineClip clip in GetClips())
		{
			BlackScreenTextClip blackScreenTextClip = clip.asset as BlackScreenTextClip;
			if ((bool)blackScreenTextClip)
			{
				blackScreenTextClip.blackScreenTextBehaviour.contentId = blackScreenTextClip.contentId;
				blackScreenTextClip.blackScreenTextBehaviour.endTime = clip.end;
			}
		}
		return ScriptPlayable<BlackScreenMixerBehaviour>.Create(graph, inputCount);
	}
}
