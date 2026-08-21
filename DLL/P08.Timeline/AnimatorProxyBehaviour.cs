using System;
using UnityEngine;
using UnityEngine.Playables;

public class AnimatorProxyBehaviour : PlayableBehaviour
{
	public DynamicTimelineController controller;

	public string animName;

	public float mDuration;

	public string heroId;

	public bool needRootmotion;

	[NonSerialized]
	private Animator anim;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		GameObject gameObject = controller.GetHero(heroId).gameObject;
		anim = gameObject.GetComponent<Animator>();
		anim.applyRootMotion = needRootmotion;
		anim.CrossFade(animName, 0.05f, 0, 0f, 0f);
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
	}

	public override void OnGraphStart(Playable playable)
	{
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		base.PrepareFrame(playable, info);
	}
}
