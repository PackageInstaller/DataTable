using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineUISkipNode : PlayableAsset
{
	[HideInInspector]
	public string path = "Widget/System/Story/StorySkip3UI";

	public int skipFrame;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineUISkipNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineUISkipNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().skipFrame = skipFrame;
		return scriptPlayable;
	}
}
