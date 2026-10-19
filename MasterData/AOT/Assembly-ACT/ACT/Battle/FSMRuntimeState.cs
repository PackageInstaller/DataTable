using ACT.Battle.Configs;
using ACT.MultiPlayer;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

namespace ACT.Battle;

public class FSMRuntimeState
{
	public bool hasRecoveredEnergyThisMotion;

	public bool dodgeCounterUseCounted;

	public State state;

	public ConfigMotion actualMotion;

	public AnimationClip runtimeClip;

	public Playable playable;

	public AnimationScriptPlayable scriptPlayable;

	public bool loop;

	public float length;

	public float transitionDuration;

	public float logicTransitionTime;

	public float toLogicWeight;

	public float fromLogicWeight;

	public float toLogicTime;

	public float fromLogicTime;

	public float toLogicPercent;

	public float fromLogicPercent;

	public int logicLoopTimes;

	public float perfTime;

	public float perfWeight;

	public bool externalWeightDriven;

	public int externalStateHash;

	public PeriodMode periodMode;

	public FaceDir startFaceDir;

	public float compensationForwardCurveRate = 1f;

	public float compensationRightCurveRate = 1f;

	public float compensationUpCurveRate = 1f;

	public float frameCompensationRate = 1f;

	public float frameCompensationRateY = 1f;

	public bool timeElapsedZero;

	public bool continueTimeElapsedZero;

	public float speed { get; set; }

	public bool DoByPercentPeriod(float start, float end, bool mustDo, bool canDoPeriod)
	{
		end = Mathf.Max(Mathf.Max(start, end), 0f);
		if (mustDo)
		{
			return fromLogicPercent <= start;
		}
		bool flag = Mathf.Approximately(start, end);
		switch (periodMode)
		{
		case PeriodMode.Normal:
			if (flag && timeElapsedZero)
			{
				return false;
			}
			if (logicLoopTimes == 0)
			{
				if (start < toLogicPercent)
				{
					return fromLogicPercent <= end;
				}
				return false;
			}
			if (logicLoopTimes == 1)
			{
				return start < toLogicPercent || fromLogicPercent <= end;
			}
			return true;
		case PeriodMode.DoPauseFrame:
		{
			bool flag2 = fromLogicPercent <= end && fromLogicPercent >= start;
			if (continueTimeElapsedZero & flag2)
			{
				return canDoPeriod;
			}
			return flag2;
		}
		case PeriodMode.AfterDoPauseFrame:
			if (logicLoopTimes == 0)
			{
				if (start < toLogicPercent)
				{
					return fromLogicPercent < end;
				}
				return false;
			}
			if (logicLoopTimes == 1)
			{
				return start < toLogicPercent || fromLogicPercent < end;
			}
			return true;
		default:
			return true;
		}
	}

	public void Reset()
	{
		state = null;
		actualMotion = null;
		runtimeClip = null;
		if (playable.IsValid())
		{
			playable.Destroy();
		}
		playable = Playable.Null;
		if (scriptPlayable.IsValid())
		{
			scriptPlayable.Destroy();
		}
		scriptPlayable = AnimationScriptPlayable.Null;
		logicTransitionTime = 0f;
		toLogicWeight = (fromLogicWeight = 0f);
		toLogicTime = (fromLogicTime = 0f);
		toLogicPercent = (fromLogicPercent = 0f);
		perfTime = (perfWeight = 0f);
		externalWeightDriven = false;
		externalStateHash = 0;
		compensationForwardCurveRate = 1f;
		compensationRightCurveRate = 1f;
		compensationUpCurveRate = 1f;
		startFaceDir = FaceDir.None;
		speed = 0f;
		logicLoopTimes = 0;
		length = 0f;
		loop = false;
		transitionDuration = 0f;
		frameCompensationRate = 1f;
		frameCompensationRateY = 1f;
		timeElapsedZero = false;
		periodMode = PeriodMode.Normal;
		dodgeCounterUseCounted = false;
	}

	public override string ToString()
	{
		return $"stateName {state.value.name} stateMachineName {state.parentStateMachine.value.name}";
	}
}
