using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineTriggerNode : PlayableAsset
{
	public float range = 1f;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineTriggerNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineTriggerNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().range = range;
		return scriptPlayable;
	}
}
