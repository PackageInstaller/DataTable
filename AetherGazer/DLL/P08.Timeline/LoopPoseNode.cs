using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
public class LoopPoseNode : PlayableAsset
{
	[NonSerialized]
	public TimelineClip clip;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<LoopPoseBehaviour> scriptPlayable = ScriptPlayable<LoopPoseBehaviour>.Create(graph);
		LoopPoseBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.startTime = clip.start;
		behaviour.endTime = clip.end;
		return scriptPlayable;
	}
}
