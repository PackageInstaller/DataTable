using UnityEngine;
using UnityEngine.Playables;

public class AnimatorProxyNode : PlayableAsset
{
	public DynamicTimelineController controller;

	public string animName;

	private float mDuration;

	public string heroId;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<AnimatorProxyBehaviour> scriptPlayable = ScriptPlayable<AnimatorProxyBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().animName = animName;
		scriptPlayable.GetBehaviour().mDuration = mDuration;
		scriptPlayable.GetBehaviour().heroId = heroId;
		scriptPlayable.GetBehaviour().controller = controller;
		return scriptPlayable;
	}
}
