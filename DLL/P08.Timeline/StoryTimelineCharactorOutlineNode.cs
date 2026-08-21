using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCharactorOutlineNode : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<StoryTimelineCharactorOutlineNodePlayable>.Create(graph);
	}
}
