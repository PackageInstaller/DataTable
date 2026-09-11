using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace T0World;

[Serializable]
public class T0WrestlingGame : MonoBehaviour
{
	public Slider uiSlider_;

	private int maxValue_ = 100;

	public int minValue_ = 10;

	public float currentValue_;

	public int initValue_ = 40;

	public float refreshTime_ = 0.2f;

	private float currentRefreshTime_;

	public List<WrestlingReduceData> downSpeedList_ = new List<WrestlingReduceData>();

	public int upSpeed1_ = 10;

	public int upSpeed2_ = 20;

	public float pressingTimingTime_ = 1f;

	private float pressingTime_;

	public int displayRandomRange_ = 5;

	public float pressingStateTransitionTime_ = 0.9f;

	[HideInInspector]
	public UnityEvent<bool> OnPressStateChangeCallback;

	[HideInInspector]
	public UnityEvent OnFinishCallback;

	private bool isPressing_;

	private float lastPressStateChangeTime_ = -1f;

	private bool targetPressState_;

	public bool IsPressing
	{
		get
		{
			return isPressing_;
		}
		set
		{
			isPressing_ = value;
		}
	}

	private void Awake()
	{
	}

	public void InitData()
	{
		isPressing_ = false;
		targetPressState_ = false;
		currentValue_ = initValue_;
		currentRefreshTime_ = 0f;
		lastPressStateChangeTime_ = -1f;
		uiSlider_.maxValue = maxValue_;
	}

	public void UpdatePressState(bool isPressing)
	{
		targetPressState_ = isPressing;
		TryApplyPressState();
	}

	private void TryApplyPressState()
	{
		if (IsPressing != targetPressState_ && !(Time.time - lastPressStateChangeTime_ < pressingStateTransitionTime_))
		{
			lastPressStateChangeTime_ = Time.time;
			IsPressing = targetPressState_;
			if (OnPressStateChangeCallback != null)
			{
				OnPressStateChangeCallback.Invoke(IsPressing);
			}
		}
	}

	private void Update()
	{
		TryApplyPressState();
		UpdatePressingState();
		currentRefreshTime_ += Time.deltaTime;
		if (currentRefreshTime_ >= refreshTime_)
		{
			currentRefreshTime_ = 0f;
			UpdateUI();
		}
	}

	private void UpdatePressingState()
	{
		if (IsPressing)
		{
			pressingTime_ += Time.deltaTime;
			if (pressingTime_ >= pressingTimingTime_)
			{
				currentValue_ += Time.deltaTime * (float)upSpeed2_;
			}
			else
			{
				currentValue_ += Time.deltaTime * (float)upSpeed1_;
			}
		}
		else
		{
			pressingTime_ = 0f;
			foreach (WrestlingReduceData item in downSpeedList_)
			{
				if (currentValue_ <= (float)item.maxRange)
				{
					currentValue_ -= Time.deltaTime * (float)item.speed;
					break;
				}
			}
		}
		currentValue_ = Mathf.Clamp(currentValue_, minValue_, maxValue_);
	}

	private void UpdateUI()
	{
		if (currentValue_ >= 100f)
		{
			if (OnFinishCallback != null)
			{
				OnFinishCallback.Invoke();
			}
		}
		else if (IsPressing && currentValue_ < 100f)
		{
			uiSlider_.value = currentValue_ + (float)UnityEngine.Random.Range(-displayRandomRange_, displayRandomRange_);
		}
		else
		{
			uiSlider_.value = currentValue_;
		}
	}
}
