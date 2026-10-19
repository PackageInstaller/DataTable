using UnityEngine;

namespace ACT;

public class LoginLoadProgressHandle : ILoadProgressHandle
{
	public const float LoginPhaseWeight = 0.35f;

	private const int TotalSteps = 3;

	private const float WaitStepCeiling = 0.9f;

	private const float WaitStepRampSeconds = 5f;

	private int _currentStep;

	private float _currentStepProgress;

	private bool _waitingServerData;

	private float _waitStartTime;

	public float Progress
	{
		get
		{
			float num = _currentStepProgress;
			if (_waitingServerData)
			{
				float num2 = Time.realtimeSinceStartup - _waitStartTime;
				num = Mathf.Max(num, 0.9f * (1f - Mathf.Exp((0f - num2) / 5f)));
			}
			return 0.35f * Mathf.Clamp01(((float)_currentStep + num) / 3f);
		}
	}

	public bool IsDone => _currentStep >= 3;

	public bool CouldDispose => false;

	public void Dispose()
	{
	}

	public void CompleteLoginServerStep()
	{
		if (_currentStep == 0)
		{
			AdvanceStep();
		}
	}

	public void BeginWaitGameServerData()
	{
		if (_currentStep == 1)
		{
			_waitingServerData = true;
			_waitStartTime = Time.realtimeSinceStartup;
		}
	}

	public void CompleteWaitGameServerData()
	{
		if (_currentStep == 1)
		{
			_currentStepProgress = 1f;
			AdvanceStep();
		}
	}

	public void CompleteSyncUserInfoStep()
	{
		if (_currentStep == 2)
		{
			AdvanceStep();
		}
	}

	private void AdvanceStep()
	{
		_waitingServerData = false;
		_currentStepProgress = 0f;
		_currentStep++;
	}
}
