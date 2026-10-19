using ACT.Config;
using UnityEngine;

namespace ACT.Model;

public class Guide
{
	private GuideConfig _guideConfig;

	private GuideData _guideData;

	private int _stepIndex;

	private bool _isFinsh;

	private GuideStepData _stepData;

	public bool IsFinsh => _isFinsh;

	public int GuideId => _guideData.Id;

	public Guide(GuideConfig guideConfig, GuideData guideData)
	{
		_guideConfig = guideConfig;
		_guideData = guideData;
	}

	public void StartGuide()
	{
		_stepIndex = 0;
		_stepData = _guideData.GetStepByIndex(_stepIndex);
		_stepData.OnStart();
	}

	public void Tick()
	{
		if (_stepData.CheckStepIsFinsh())
		{
			OnFinish();
			NexTStep();
		}
		else
		{
			_stepData.TickAllConditionalActions();
		}
	}

	public void OnFail()
	{
		if (_stepData != null)
		{
			_stepData.OnFinish();
		}
		_stepIndex = 0;
		_stepData = null;
	}

	public void OnFinish()
	{
		_stepData?.OnFinish();
	}

	public void NexTStep()
	{
		_stepIndex++;
		_stepData = _guideData.GetStepByIndex(_stepIndex);
		if (_stepData == null)
		{
			FinishGuide();
		}
		else
		{
			_stepData.OnStart();
		}
	}

	public void FinishGuide()
	{
		_isFinsh = true;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"id: {_guideData.Id}，完成软引导");
		}
		Model<GuideModel>.Interface.SendGuideComplete(_guideData.Id);
	}
}
