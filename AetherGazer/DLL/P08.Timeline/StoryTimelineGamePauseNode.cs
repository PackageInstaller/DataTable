using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineGamePauseNode : PlayableAsset
{
	public bool pause = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineGamePauseNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineGamePauseNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().pause = pause;
		return scriptPlayable;
	}
}
