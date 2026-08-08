using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineHideCampAgentsNode : PlayableAsset
{
	public bool hideSelfAgent;

	public bool hideFriendAgent;

	public bool hideEnemyAgent;

	public bool showSelfAgent;

	public bool showFriendAgent;

	public bool showEnemyAgent;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineHideCampAgentsNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineHideCampAgentsNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().hideSelfAgent = hideSelfAgent;
		scriptPlayable.GetBehaviour().hideFriendAgent = hideFriendAgent;
		scriptPlayable.GetBehaviour().hideEnemyAgent = hideEnemyAgent;
		scriptPlayable.GetBehaviour().showSelfAgent = showSelfAgent;
		scriptPlayable.GetBehaviour().showFriendAgent = showFriendAgent;
		scriptPlayable.GetBehaviour().showEnemyAgent = showEnemyAgent;
		return scriptPlayable;
	}
}
