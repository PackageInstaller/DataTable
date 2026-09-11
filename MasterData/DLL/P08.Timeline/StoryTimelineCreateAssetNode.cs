using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCreateAssetNode : PlayableAsset
{
	public string path;

	public Vector3 position;

	public Vector3 forward;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineCreateAssetNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineCreateAssetNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().pos = position;
		scriptPlayable.GetBehaviour().fwd = forward;
		return scriptPlayable;
	}
}
