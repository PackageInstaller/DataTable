using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineMapTriggerNode : PlayableAsset
{
	public int targetTriggerID;

	public bool enable;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineMapTriggerNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineMapTriggerNodeBehaviour>.Create(graph);
		StoryTimelineMapTriggerNodeBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.targetTriggerID = targetTriggerID;
		behaviour.enable = enable;
		return scriptPlayable;
	}
}
