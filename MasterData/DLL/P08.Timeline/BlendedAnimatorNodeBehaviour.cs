using UnityEngine;
using UnityEngine.Playables;

public class BlendedAnimatorNodeBehaviour : PlayableBehaviour
{
	public Animator animator;

	public float blendInSeconds = 0.4f;

	public int currentStateIndex;

	public string currentStateName;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		base.OnBehaviourPlay(playable, info);
		if (!(animator != null))
		{
			return;
		}
		RuntimeAnimatorController runtimeAnimatorController = animator.runtimeAnimatorController;
		if (!Application.isPlaying)
		{
			return;
		}
		string stateName = currentStateName;
		if (blendInSeconds <= 0f)
		{
			animator.Play(stateName, 0);
			return;
		}
		int num = 0;
		for (int i = 0; i < runtimeAnimatorController.animationClips.Length; i++)
		{
			if (runtimeAnimatorController.animationClips[i].name == currentStateName)
			{
				num = i;
				break;
			}
		}
		_ = runtimeAnimatorController.animationClips[num];
		animator.CrossFadeInFixedTime(stateName, blendInSeconds, 0, 0f);
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		base.OnBehaviourPause(playable, info);
	}

	public override void OnGraphStart(Playable playable)
	{
	}
}
