using System;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
public class TransformProxyBehaviour : PlayableBehaviour
{
	public DynamicTimelineController controller;

	public string transTag;

	public string heroId;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		GameObject gameObject = controller.GetHero(heroId).gameObject;
		gameObject.transform.position = controller.GetTransform(transTag).position;
		gameObject.transform.forward = controller.GetTransform(transTag).forward;
		gameObject.transform.localScale = controller.GetTransform(transTag).lossyScale;
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
	}

	public override void OnGraphStart(Playable playable)
	{
	}
}
