using UnityEngine;
using UnityEngine.Playables;

public class FaceExpressionNode : PlayableAsset
{
	public string emotion;

	public float blendTime;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<FaceExpressionNodePlayable> scriptPlayable = ScriptPlayable<FaceExpressionNodePlayable>.Create(graph);
		scriptPlayable.GetBehaviour().emotion = emotion;
		scriptPlayable.GetBehaviour().blendTime = blendTime;
		return scriptPlayable;
	}
}
