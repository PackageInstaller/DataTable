using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT;

public class SceneLoadProgressHandle : ILoadProgressHandle
{
	private readonly List<Func<UniTask>> _steps = new List<Func<UniTask>>();

	private readonly List<float> _stepWeights = new List<float>();

	private int _executedIndex;

	private bool _isDone;

	private bool _couldDispose;

	private float _completedWeight;

	private float _currentStepSubProgress;

	private bool _isExecuting;

	private float _reportedProgress;

	private const float MaxProgressBeforeDone = 0.99f;

	private bool _disposeRequested;

	public int StepCount => _steps.Count;

	private float TotalWeight
	{
		get
		{
			float num = 0f;
			for (int i = 0; i < _stepWeights.Count; i++)
			{
				num += _stepWeights[i];
			}
			return num;
		}
	}

	public float Progress
	{
		get
		{
			float num;
			if (_steps.Count <= 0)
			{
				num = (_isDone ? 1f : 0f);
			}
			else
			{
				float totalWeight = TotalWeight;
				float num2 = ((_isExecuting && _executedIndex < _stepWeights.Count) ? _stepWeights[_executedIndex] : 0f);
				if (totalWeight <= 0f)
				{
					num = (_isDone ? 1f : 0f);
				}
				else
				{
					num = Mathf.Clamp01((_completedWeight + num2 * _currentStepSubProgress) / totalWeight);
				}
			}
			if (!_isDone)
			{
				num = Mathf.Min(num, 0.99f);
			}
			if (num < _reportedProgress)
			{
				num = _reportedProgress;
			}
			else
			{
				_reportedProgress = num;
			}
			return num;
		}
	}

	public bool IsDone => _isDone;

	public bool CouldDispose => _couldDispose;

	public void AddStep(Func<UniTask> step, float weight = 1f)
	{
		_steps.Add(step);
		_stepWeights.Add(Mathf.Max(weight, 0.0001f));
	}

	public void ReportSubProgress(float normalized)
	{
		if (_isExecuting)
		{
			normalized = Mathf.Clamp01(normalized);
			if (!(normalized <= _currentStepSubProgress))
			{
				_currentStepSubProgress = normalized;
			}
		}
	}

	public static void ReportCurrentSubProgress(float normalized)
	{
		if (Singleton<LoadManager>.instance.ActiveHandle is SceneLoadProgressHandle sceneLoadProgressHandle)
		{
			sceneLoadProgressHandle.ReportSubProgress(normalized);
		}
	}

	public async UniTask ExecuteAll(bool markDone = true)
	{
		_completedWeight = 0f;
		for (int i = 0; i < _executedIndex && i < _stepWeights.Count; i++)
		{
			_completedWeight += _stepWeights[i];
		}
		_isExecuting = true;
		try
		{
			while (_executedIndex < _steps.Count)
			{
				_currentStepSubProgress = 0f;
				await _steps[_executedIndex]();
				_completedWeight += _stepWeights[_executedIndex];
				_executedIndex++;
				_currentStepSubProgress = 0f;
			}
		}
		finally
		{
			_isExecuting = false;
			if (_disposeRequested)
			{
				_disposeRequested = false;
				ResetSteps();
			}
		}
		if (markDone)
		{
			_isDone = true;
		}
	}

	public void Dispose()
	{
		if (_isExecuting)
		{
			_disposeRequested = true;
		}
		else
		{
			ResetSteps();
		}
	}

	private void ResetSteps()
	{
		_steps.Clear();
		_stepWeights.Clear();
		_executedIndex = 0;
		_completedWeight = 0f;
		_currentStepSubProgress = 0f;
		_isDone = false;
	}

	public void MarkCouldDispose()
	{
		_couldDispose = true;
	}
}
