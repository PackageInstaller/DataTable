using System;
using UnityEngine;

[Serializable]
public abstract class MainStepBase : MonoBehaviour
{
	public MainStepConfig config;

	protected bool isActive;

	public string stepFinishKey = "";

	public CookingGameConst.ProgressData CurrentProgress => GetProgress();

	public MainStepConfig Config => config;

	public virtual void Init(MainStepConfig config)
	{
		isActive = true;
	}

	public abstract bool IsStepCompleted();

	public abstract CookingGameConst.ProgressData GetProgress();

	public virtual float GetPopStepTriggerProgress()
	{
		return 0f;
	}

	public virtual void OnStepStart()
	{
		isActive = true;
	}

	public virtual void OnStepEnd()
	{
		isActive = false;
	}

	public virtual void StepFinish()
	{
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.NextStep();
		}
	}
}
