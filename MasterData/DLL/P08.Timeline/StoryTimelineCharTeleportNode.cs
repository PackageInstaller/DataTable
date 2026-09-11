using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("实体传送")]
public class StoryTimelineCharTeleportNode : PlayableAsset
{
	public int mTargetID;

	public Int3 mTargetPos;

	public int mForwardAngle;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineCharTeleportNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineCharTeleportNodeBehaviour>.Create(graph);
		StoryTimelineCharTeleportNodeBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.mTargetID = mTargetID;
		behaviour.mForwardAngle = mForwardAngle;
		behaviour.mTargetPos = mTargetPos;
		return scriptPlayable;
	}
}
