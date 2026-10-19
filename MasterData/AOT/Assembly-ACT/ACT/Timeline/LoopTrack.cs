using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0f, 1f, 0f)]
[TrackClipType(typeof(LoopClip))]
[TrackClipType(typeof(TasksLoopClip))]
public class LoopTrack : TrackAsset
{
	protected override Playable CreatePlayable(PlayableGraph graph, GameObject gameObject, TimelineClip clip)
	{
		if (clip.asset is ILoopClip loopClip)
		{
			loopClip.Clip = clip;
		}
		return base.CreatePlayable(graph, gameObject, clip);
	}
}
