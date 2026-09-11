using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
[DisplayName("半屏镜像")]
public class StoryCameraMirrorNode : PlayableAsset
{
	public bool IsMotion;

	public Vector2 MotionCenter = Vector2.one * 0.5f;

	public float MotionRotation;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryCameraMirrorNodeBehaviour> scriptPlayable = ScriptPlayable<StoryCameraMirrorNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().IsMotion = IsMotion;
		scriptPlayable.GetBehaviour().MotionCenter = MotionCenter;
		scriptPlayable.GetBehaviour().MotionRotation = MotionRotation;
		return scriptPlayable;
	}
}
