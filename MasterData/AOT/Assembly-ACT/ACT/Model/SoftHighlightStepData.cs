using System;
using ACT.Config;
using Bamboo.Chronos;
using UnityEngine;

namespace ACT.Model;

public class SoftHighlightStepData : GuideStepData
{
	private FindHighlightObjAction _findAction;

	private int _deleteTime;

	private Delayer _DeleteDelayer;

	public FindHighlightObjAction FindAction => _findAction;

	public int DeleteTime => _deleteTime;

	public SoftHighlightStepData(SoftHighlightStepConfig config, int index)
		: base(config, index)
	{
		if (config.findAction != null)
		{
			_findAction = (FindHighlightObjAction)Activator.CreateInstance(config.findAction?.GetType(), config.findAction);
		}
		_deleteTime = config.DeleteTime;
		_successCondition = new SoftHighlightSC();
	}

	public override void OnStart()
	{
		isFinsh = false;
		actionsTriggered = new bool[_conditionalActions.Count];
		for (int i = 0; i < _conditionalActions.Count; i++)
		{
			actionsTriggered[i++] = false;
		}
		foreach (GuideStepFinishConditionConfig finshConditionsinsh in _finshConditionsinshs)
		{
			RuntimeStepCondition runtimeStepCondition = finshConditionsinsh.CreateRuntimeStepFinishCondition();
			runtimeStepCondition.Init();
			_runtimeStepConditions.Add(runtimeStepCondition);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"步骤id: {Id}，开始软引导");
		}
		if (_deleteTime > 0)
		{
			AddDeleteTime();
		}
	}

	private void AddDeleteTime()
	{
		_DeleteDelayer = UpdateTimer.Default.DelayMs(DeleteTime * 1000, () =>
		{
			OnFinish();
		});
	}

	public override void OnFinish()
	{
		isFinsh = true;
		if (_uninitActions.Count > 0)
		{
			for (int i = 0; i < _uninitActions.Count; i++)
			{
				_uninitActions[i].UnInit();
			}
		}
		for (int j = 0; j < _runtimeStepConditions.Count; j++)
		{
			_runtimeStepConditions[j].UnInit();
		}
		_uninitActions.Clear();
		_runtimeStepConditions.Clear();
		if (_DeleteDelayer.IsValid())
		{
			_DeleteDelayer.Cancel();
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"id: {Id}，结束引导步骤");
		}
	}
}
