using System;
using UnityEngine;

namespace ACT.Battle.Configs;

public class MixinTimer
{
	public MixinTimeLimitType mixinTimeLimitType;

	public float customDuration;

	[NonSerialized]
	public float endTime;

	[NonSerialized]
	public float startTime;

	private Ability ability;

	public void TimerStart(Ability ab)
	{
		ability = ab;
		TimerStart();
	}

	public void TimerStart()
	{
		switch (mixinTimeLimitType)
		{
		case MixinTimeLimitType.byAbilityTimeLeft:
			if (ability != null)
			{
				float num = ability.config.fDuration.GetFloat(ability);
				endTime = Time.time + (num - ability.time);
				startTime = Time.time;
			}
			break;
		case MixinTimeLimitType.byCustomTime:
			endTime = Time.time + customDuration;
			startTime = Time.time;
			break;
		}
	}

	public bool TimerIsFinishByFixedUpdate()
	{
		return Time.time >= endTime;
	}

	public MixinTimer()
	{
		mixinTimeLimitType = MixinTimeLimitType.byAbilityTimeLeft;
		customDuration = 1f;
	}
}
