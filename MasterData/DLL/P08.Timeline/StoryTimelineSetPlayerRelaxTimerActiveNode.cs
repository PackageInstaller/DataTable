using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("角色休闲动作计时开关")]
public class StoryTimelineSetPlayerRelaxTimerActiveNode : PlayableAsset
{
	public bool switchTag = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineSetPlayerRelaxTimerActiveNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineSetPlayerRelaxTimerActiveNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().switchTag = switchTag;
		return scriptPlayable;
	}
}
