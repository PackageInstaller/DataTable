using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public class LoopClip : PlayableAsset, ILoopClip, ITimelineClipAsset
{
	private TimelineClip clip;

	public ClipCaps clipCaps => ClipCaps.None;

	public TimelineClip Clip
	{
		get
		{
			return clip;
		}
		set
		{
			clip = value;
		}
	}

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		LoopBehaviour loopBehaviour = new LoopBehaviour();
		loopBehaviour.startTime = clip.start;
		loopBehaviour.endTime = clip.end;
		return ScriptPlayable<LoopBehaviour>.Create(graph, loopBehaviour);
	}
}
