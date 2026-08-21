using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCharCtrlNode : PlayableAsset
{
	public CharCtrlType charCtrlType;

	public Vector3 targetPosition;

	public bool stopWhenArrived;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineCharCtrlNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineCharCtrlNodeBehaviour>.Create(graph);
		StoryTimelineCharCtrlNodeBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.charCtrlType = charCtrlType;
		behaviour.targetPosition = targetPosition;
		behaviour.stopWhenArrived = stopWhenArrived;
		return scriptPlayable;
	}
}
