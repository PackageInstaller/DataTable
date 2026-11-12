using UnityEngine;
using UnityEngine.Playables;

public sealed class EventForTriggerClip : PlayableAsset
{
	public string EVENT_NAME;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		ScriptPlayable<EventForTriggerBehaviour> scriptPlayable = ScriptPlayable<EventForTriggerBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().event_name = EVENT_NAME;
		return scriptPlayable;
	}
}
