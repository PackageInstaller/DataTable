using System;
using ACT.UI;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class BlackScreenBehaviour : PlayableBehaviour
{
	public bool autoHideBlackScreenOnEnd = true;

	public float MaxDelayTime;

	public bool isEndBS;

	private FrameworkBlackScreen blackScreenView;

	private bool _isPlaying;

	public override void OnGraphStart(Playable playable)
	{
		if (Application.isPlaying)
		{
			blackScreenView = Singleton<NewUIManager>.instance.BlackScreen;
			blackScreenView.Init();
			_isPlaying = false;
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying)
		{
			_isPlaying = true;
			if ((bool)blackScreenView)
			{
				blackScreenView.SetBlackScreen(info.effectiveWeight);
			}
		}
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		if (Application.isPlaying && (bool)blackScreenView)
		{
			blackScreenView.SetBlackScreen(info.effectiveWeight);
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (!Application.isPlaying || !_isPlaying)
		{
			return;
		}
		_isPlaying = false;
		if (!blackScreenView)
		{
			return;
		}
		if (isEndBS && autoHideBlackScreenOnEnd)
		{
			if (MaxDelayTime > 0f)
			{
				blackScreenView.SetBlackScreen(info.effectiveWeight, MaxDelayTime);
			}
			else
			{
				blackScreenView.SetBlackScreen(info.effectiveWeight);
			}
		}
		else
		{
			blackScreenView.SetBlackScreen(info.effectiveWeight);
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		blackScreenView = null;
	}
}
