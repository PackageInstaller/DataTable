using System;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public class SubStickEffectController : MonoBehaviour
{
	public PlayableDirector mPlayableDirector;

	public TimelineAsset EnterTimelineAsset;

	public TimelineAsset KeepTimelineAsset;

	public TimelineAsset ExitTimelineAsset;

	public GameObject BindingGo;

	private Action mOnExitCallFunc;

	public EnSubJoystickStep Step;

	public void InitEvent(Action onExited = null)
	{
		if (mPlayableDirector != null)
		{
			mPlayableDirector.stopped += OnPlayableDirectorStoped;
		}
		if (onExited != null)
		{
			mOnExitCallFunc = onExited;
		}
	}

	public void OnPlayableDirectorStoped(PlayableDirector director)
	{
		switch (Step)
		{
		case EnSubJoystickStep.Enter:
			if (KeepTimelineAsset != null)
			{
				Step = EnSubJoystickStep.Keep;
				PlayTimelineAsset(director, KeepTimelineAsset, BindingGo, isLoop: true);
			}
			break;
		case EnSubJoystickStep.Exit:
			StopEffect();
			break;
		case EnSubJoystickStep.Keep:
			break;
		}
	}

	public void Enter()
	{
		if (!(mPlayableDirector == null))
		{
			Step = EnSubJoystickStep.Enter;
			PlayTimelineAsset(mPlayableDirector, EnterTimelineAsset, BindingGo);
		}
	}

	public void Exit()
	{
		if (!(mPlayableDirector == null))
		{
			Step = EnSubJoystickStep.Exit;
			PlayTimelineAsset(mPlayableDirector, ExitTimelineAsset, BindingGo);
		}
	}

	private void PlayTimelineAsset(PlayableDirector playableDirector, TimelineAsset timelineAsset, GameObject binding, bool isLoop = false)
	{
		playableDirector.playableAsset = timelineAsset;
		AnimationTrack animationTrack = timelineAsset.GetOutputTrack(0) as AnimationTrack;
		if (animationTrack != null)
		{
			playableDirector.SetGenericBinding(animationTrack, binding);
		}
		mPlayableDirector.extrapolationMode = (isLoop ? DirectorWrapMode.Loop : DirectorWrapMode.None);
		mPlayableDirector.Play();
	}

	private void OnDisable()
	{
		if (!(mPlayableDirector == null) && Step == EnSubJoystickStep.Exit)
		{
			StopEffect();
		}
	}

	private void StopEffect()
	{
		Step = EnSubJoystickStep.Stop;
		if (mOnExitCallFunc != null)
		{
			mOnExitCallFunc();
		}
	}
}
