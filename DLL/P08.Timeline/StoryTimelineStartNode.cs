using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineStartNode : PlayableAsset
{
	public bool m_postComand = true;

	public override double duration => 0.5;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineStartNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineStartNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().m_postCommand = m_postComand;
		return scriptPlayable;
	}
}
