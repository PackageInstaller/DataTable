using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("缓动跟随(SlowFollow)")]
public class SlowFollowNode : PlayableAsset
{
	public ETargetType targetType = ETargetType.Transform;

	public ExposedReference<Transform> target;

	public ExposedReference<Transform> follower;

	public float angleThreshold = 999f;

	public float distanceThreshold = 999f;

	[Tooltip("x为归一化的距离")]
	public AnimationCurve speedCurve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 1f));

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<SlowFollowBehaviour> scriptPlayable = ScriptPlayable<SlowFollowBehaviour>.Create(graph);
		SlowFollowBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.targetType = targetType;
		behaviour.target = target;
		behaviour.follower = follower;
		behaviour.angleThreshold = angleThreshold;
		behaviour.distanceThreshold = distanceThreshold;
		behaviour.speedCurve = speedCurve;
		return scriptPlayable;
	}
}
