using System;
using UnityEngine;
using UnityEngine.Playables;

namespace Packages.P08Main.Scripts.T0World.Timeline;

[Serializable]
public class DirectControlAnimatorControllerBehaviour : PlayableBehaviour
{
	public int layer;

	public string state;

	public float crossFade;

	public bool crossFadeInFixedTime;

	public bool noNeedEvaluateImmediate;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		Animator animator = info.output.GetUserData() as Animator;
		if (!(null == animator) && Application.isPlaying)
		{
			double time = playable.GetTime();
			PlayAction(animator, (float)time);
		}
	}

	private void PlayAction(Animator animator, float startTime)
	{
		if (crossFadeInFixedTime)
		{
			animator.CrossFadeInFixedTime(state, crossFade, layer, startTime);
		}
		else
		{
			animator.CrossFade(state, crossFade, layer, startTime);
		}
		if (!noNeedEvaluateImmediate)
		{
			animator.Update(0f);
		}
	}
}
