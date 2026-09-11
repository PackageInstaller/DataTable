using System;
using UnityEngine;

[Serializable]
public abstract class PopStepBase : MonoBehaviour
{
	public PopStepConfig config;

	protected bool isActive;

	public float CurrentProgress => GetProgress();

	public PopStepConfig Config => config;

	public virtual void Start()
	{
		Init();
		OnStepStart();
	}

	public virtual void Init()
	{
		config.stepID = base.gameObject.name.Substring(0, base.gameObject.name.Length - "(Clone)".Length);
		ApplyConfig(config);
	}

	protected virtual void ApplyConfig(PopStepConfig config)
	{
		this.config = new PopStepConfig(config);
		this.config.obj = base.gameObject;
	}

	public abstract bool IsStepCompleted();

	public abstract float GetProgress();

	public virtual void OnStepStart()
	{
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.StartPopStep(config);
		}
		isActive = true;
	}

	public virtual void OnStepEnd()
	{
		if ((bool)CookingGameManager.Instance)
		{
			CookingGameManager.Instance.EndPopStep();
		}
		isActive = false;
		this.SetActive(bActive: false);
	}
}
