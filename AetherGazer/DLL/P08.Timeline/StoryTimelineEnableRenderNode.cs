using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineEnableRenderNode : PlayableAsset
{
	public string path = "";

	public bool enable;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineEnableRenderNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineEnableRenderNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().enable = enable;
		return scriptPlayable;
	}
}
