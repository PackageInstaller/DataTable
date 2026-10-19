using System;
using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class StopPlayerFsmBehaviour : PlayableBehaviour
{
	[NonSerialized]
	private TimeSpeedTimer _motionPauseTimer;

	[NonSerialized]
	private bool _isApplied;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying)
		{
			ApplyPause();
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (Application.isPlaying)
		{
			RemovePause();
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		RemovePause();
	}

	private void ApplyPause()
	{
		if (!_isApplied)
		{
			_ = MonoECS.instance?.mainEntity;
			CompTime compTime = MonoECS.instance?.mainEntity.GetCompTime();
			if (compTime != null)
			{
				_motionPauseTimer = GameManager.timeSystem.timerPool.Get();
				_motionPauseTimer.InitTimer(0f, -1f);
				_motionPauseTimer.Type = TimeType.Motion;
				compTime.AddSpeedTimer(TimeType.Motion, _motionPauseTimer);
				compTime.UpdateTimeScale(TimeType.Motion);
				_isApplied = true;
			}
		}
	}

	private void RemovePause()
	{
		if (_isApplied)
		{
			CompTime compTime = MonoECS.instance?.mainEntity.GetCompTime();
			if (compTime != null && _motionPauseTimer != null)
			{
				compTime.RemoveSpeedTimer(TimeType.Motion, _motionPauseTimer);
				compTime.UpdateTimeScale(TimeType.Motion);
			}
			_motionPauseTimer = null;
			_isApplied = false;
		}
	}
}
