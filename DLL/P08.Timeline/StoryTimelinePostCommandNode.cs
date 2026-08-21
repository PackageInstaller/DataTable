using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("推送剧情事件")]
public class StoryTimelinePostCommandNode : PlayableAsset
{
	public StoryType m_storyType;

	public bool m_isEnter = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelinePostCommandBehaviour> scriptPlayable = ScriptPlayable<StoryTimelinePostCommandBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().m_storyType = m_storyType;
		scriptPlayable.GetBehaviour().m_isEnter = m_isEnter;
		return scriptPlayable;
	}
}
