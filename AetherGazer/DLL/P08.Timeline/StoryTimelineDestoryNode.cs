using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineDestoryNode : PlayableAsset
{
	public bool m_postComand = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineDestoryNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineDestoryNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().m_postCommand = m_postComand;
		return scriptPlayable;
	}
}
