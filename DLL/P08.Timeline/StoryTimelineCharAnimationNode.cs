using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCharAnimationNode : PlayableAsset
{
	public CharAnimeType charAnimeType;

	public int triggerID;

	public string path;

	public string animationName = "stand";

	public float fixedTransitionDuration = 0.1f;

	public int layer;

	public bool useCustomPosition;

	public Vector3 customPosition;

	public Vector3 customRotation;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineCharAnimationNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineCharAnimationNodeBehaviour>.Create(graph);
		StoryTimelineCharAnimationNodeBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.charAnimeType = charAnimeType;
		behaviour.triggerID = triggerID;
		behaviour.animationName = animationName;
		behaviour.layer = layer;
		behaviour.fixedTransitionDuration = fixedTransitionDuration;
		behaviour.useCustomPosition = useCustomPosition;
		behaviour.customPosition = customPosition;
		behaviour.path = path;
		behaviour.customRotation = customRotation;
		return scriptPlayable;
	}
}
