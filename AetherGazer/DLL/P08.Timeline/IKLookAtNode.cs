using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("注视(IKLookAt)")]
public class IKLookAtNode : PlayableAsset
{
	public LookAtComponent.EBoneType boneType = LookAtComponent.EBoneType.Head;

	public ETargetType targetType = ETargetType.Transform;

	public ExposedReference<Transform> target;

	public AnimationCurve curve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 1f));

	public bool disableOnFinished = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<IKLookAtBehaviour> scriptPlayable = ScriptPlayable<IKLookAtBehaviour>.Create(graph);
		IKLookAtBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.boneType = boneType;
		behaviour.targetType = targetType;
		behaviour.target = target;
		behaviour.curve = curve;
		behaviour.disableOnFinished = disableOnFinished;
		return scriptPlayable;
	}
}
