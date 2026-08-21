using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineHideAgentsNode : PlayableAsset
{
	public bool hideAgent;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineHideAgentsNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineHideAgentsNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().hideAgent = hideAgent;
		return scriptPlayable;
	}
}
