using System;
using UnityEngine;

public class AnimatiorAudioTrigger : StateMachineBehaviour
{
	public float delayTime;

	public string mCueSheet;

	public string mCueName;

	[NonSerialized]
	public bool mute;

	private int timer;

	public override void OnStateEnter(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (mute)
		{
			return;
		}
		if (delayTime > 0f)
		{
			timer = FuncTimerManager.inst.CreateFuncTimer(delegate
			{
				AudioManager.Instance.Play("effect", mCueSheet, mCueName, useStream: false);
			}, delayTime, 1);
		}
		else
		{
			AudioManager.Instance.Play("effect", mCueSheet, mCueName, useStream: false);
			timer = 0;
		}
	}

	public override void OnStateExit(Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
		if (timer != 0)
		{
			FuncTimerManager.inst.RemoveFuncTimer(timer);
		}
	}
}
