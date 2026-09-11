using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;
using UnityEngine.Playables;

[Serializable]
[DisplayName("相机景深")]
public class StoryCameraDepthOfFieldNode : PlayableAsset
{
	public DepthOfFieldType mDepthOfFieldType;

	public float mDepthOfFieldNear = 5f;

	public float mDepthOfFieldFar = 10f;

	public AnimationCurve mDepthOfFieldScale = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 1f));

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryCameraDepthOfFieldNodeBehaviour> scriptPlayable = ScriptPlayable<StoryCameraDepthOfFieldNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().mDepthOfFieldType = mDepthOfFieldType;
		scriptPlayable.GetBehaviour().mDepthOfFieldNear = mDepthOfFieldNear;
		scriptPlayable.GetBehaviour().mDepthOfFieldFar = mDepthOfFieldFar;
		scriptPlayable.GetBehaviour().mDepthOfFieldScale = mDepthOfFieldScale;
		return scriptPlayable;
	}
}
