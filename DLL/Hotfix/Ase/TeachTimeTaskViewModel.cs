using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class TeachTimeTaskViewModel : OptionBase
{
	private int timeTaskConfigTime;

	private string taskContent;

	private float failResetTime;

	private bool showSlider;

	private string showTimerText;

	private float silderFillAmount;

	private float timeTaskTimer;

	private float timeTaskFailTimer;

	private float timeTaskFinishTimer;

	private List<int> failAddBuff;

	private TimeTaskState timeTaskState;

	private Action comboFailAction;

	private Action timeTaskFinishAction;

	private Action uiShowAction;

	private InteractionRequest timeTaskChangeStateRequest = new InteractionRequest();

	public TimeTaskState TimeTaskState => timeTaskState;

	public List<int> FailAddBuff => failAddBuff;

	public bool ShowSlider
	{
		get
		{
			return showSlider;
		}
		private set
		{
			Set(ref showSlider, value, "ShowSlider");
		}
	}

	public string TaskContent
	{
		get
		{
			return taskContent;
		}
		private set
		{
			Set(ref taskContent, value, "TaskContent");
		}
	}

	public string ShowTimerText
	{
		get
		{
			return showTimerText;
		}
		private set
		{
			showTimerText = value;
		}
	}

	public float SliderFillAmount
	{
		get
		{
			return silderFillAmount;
		}
		private set
		{
			silderFillAmount = value;
		}
	}

	public InteractionRequest TimeTaskChangeStateRequest => timeTaskChangeStateRequest;

	public TeachTimeTaskViewModel(DRTimeTask timeTaskConfig, Action failAction, Action finishAction, Action showAction)
	{
		timeTaskConfigTime = timeTaskConfig.Timer;
		taskContent = timeTaskConfig.TaskText;
		failResetTime = timeTaskConfig.FailResetTime;
		showSlider = timeTaskConfigTime != -1;
		timeTaskState = TimeTaskState.Running;
		failAddBuff = timeTaskConfig.FailAddBuff;
		comboFailAction = failAction;
		timeTaskFinishAction = finishAction;
		uiShowAction = showAction;
	}

	public void ShowAction()
	{
		uiShowAction?.Invoke();
	}

	public void OnTimeElapse(float delateTime)
	{
		if (timeTaskState == TimeTaskState.Fail)
		{
			timeTaskFailTimer -= delateTime;
			if (timeTaskFailTimer <= 0f)
			{
				timeTaskState = TimeTaskState.Running;
				ResetTimeTask();
				timeTaskChangeStateRequest.Raise();
			}
		}
		if (timeTaskState == TimeTaskState.Success)
		{
			timeTaskFinishTimer += delateTime;
			if (timeTaskFinishTimer >= 1.2f)
			{
				timeTaskState = TimeTaskState.Close;
			}
		}
		if (showSlider && timeTaskState == TimeTaskState.Running)
		{
			timeTaskTimer += delateTime;
			ShowTimerText = $"{timeTaskConfigTime - (int)timeTaskTimer}秒";
			SliderFillAmount = timeTaskTimer / (float)timeTaskConfigTime;
			if (timeTaskTimer >= (float)timeTaskConfigTime)
			{
				timeTaskState = TimeTaskState.Success;
				timeTaskFinishTimer = 0f;
				timeTaskChangeStateRequest.Raise();
				timeTaskFinishAction?.Invoke();
			}
		}
	}

	public void FailTimeTask()
	{
		if (timeTaskState == TimeTaskState.Running)
		{
			comboFailAction?.Invoke();
			timeTaskState = TimeTaskState.Fail;
			timeTaskFailTimer = failResetTime;
			timeTaskTimer = 0f;
			SliderFillAmount = 0f;
			timeTaskChangeStateRequest.Raise();
			timeTaskFinishAction?.Invoke();
		}
	}

	public void SuccessTimeTask()
	{
		if (timeTaskState == TimeTaskState.Running)
		{
			timeTaskState = TimeTaskState.Success;
			SliderFillAmount = 1f;
			timeTaskChangeStateRequest.Raise();
			timeTaskFinishAction?.Invoke();
		}
	}

	private void ResetTimeTask()
	{
		SliderFillAmount = 0f;
		timeTaskChangeStateRequest.Raise();
	}
}
