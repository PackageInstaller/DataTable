#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Reflection;
using Ase.ECS;
using GameFramework;
using UnityEngine;

public class SkillTimelineLauncher : MonoBehaviour
{
	public SkillTimelineAsset graph;

	private SkillTimelineAsset _runTimeGraph;

	private Action _onSkillStopAction;

	private List<List<TaskClip>> _behaviours;

	private int _currentFrameID;

	private SkillTimelineAsset _skillTimeAssets;

	private float _interval;

	private BaseEntity _executeEntity;

	private PlayableStateEnum _stateEnum;

	private bool _isPause;

	public SkillTimelineAsset RunTimeGraph => _runTimeGraph;

	private SkillTimelineAsset RunTimeSkillTimeAssets => _skillTimeAssets;

	public PlayableStateEnum State => _stateEnum;

	public int CurrentFrame => _currentFrameID;

	public void InitAssets(Action onTimeLineStopAction = null)
	{
		_runTimeGraph = InitAsset(graph, onTimeLineStopAction);
	}

	public PlayableStateEnum UpdateTick(float deltaTime)
	{
		return Tick(deltaTime);
	}

	public PlayableStateEnum ExecuteState()
	{
		return State;
	}

	public void Release()
	{
		Clear();
	}

	public void BindEntity(BaseEntity context)
	{
		_executeEntity = context;
	}

	public void BindStopAction(Action onTimeLineStopAction)
	{
		_onSkillStopAction = onTimeLineStopAction;
	}

	public SkillTimelineAsset InitAsset(SkillTimelineAsset skillTimelineAsset, Action onTimeLineStopAction = null)
	{
		_isPause = false;
		_stateEnum = PlayableStateEnum.Init;
		_currentFrameID = 0;
		_skillTimeAssets = SkillTimeLineAssetsFactory.Current.GetInstance(skillTimelineAsset);
		if (_skillTimeAssets.FPS == 0)
		{
			Log.Error("技能执行错误：技能" + skillTimelineAsset.name + "的FPS为0");
			return null;
		}
		_interval = 0.033f;
		_behaviours = new List<List<TaskClip>>();
		for (int i = 0; i < _skillTimeAssets.Tracks.Count; i++)
		{
			StandardTrack standardTrack = _skillTimeAssets.Tracks[i];
			_behaviours.Add(new List<TaskClip>());
			for (int j = 0; j < standardTrack.taskClips.Count; j++)
			{
				InitClipVariable(standardTrack.taskClips[j], _skillTimeAssets);
				TaskClip item = standardTrack.taskClips[j];
				_behaviours[i].Add(item);
			}
		}
		BindStopAction(onTimeLineStopAction);
		return _skillTimeAssets;
	}

	private void InitClipVariable(TaskClip taskClip, SkillTimelineAsset skillTimelineAsset)
	{
		FieldInfo[] fields = taskClip.GetType().GetFields();
		foreach (FieldInfo obj in fields)
		{
			Type fieldType = obj.FieldType;
			object value = obj.GetValue(taskClip);
			if (fieldType.BaseType == typeof(BaseClipVariable))
			{
				((BaseClipVariable)value).SetBlackBoard(skillTimelineAsset.blackBoardVariable);
			}
		}
	}

	private void OnTimelineExit(BaseEntity context)
	{
		if (_skillTimeAssets == null)
		{
			_stateEnum = PlayableStateEnum.Error;
			return;
		}
		for (int i = 0; i < _skillTimeAssets.Tracks.Count; i++)
		{
			StandardTrack standardTrack = _skillTimeAssets.Tracks[i];
			for (int j = 0; j < standardTrack.taskClips.Count; j++)
			{
				_ = standardTrack.taskClips[j];
				TaskClip taskClip = _behaviours[i][j];
				if (taskClip == null)
				{
					break;
				}
				taskClip.OnTimelineEnd(context, _skillTimeAssets.FPS, _currentFrameID);
			}
		}
		_onSkillStopAction?.Invoke();
	}

	public PlayableStateEnum Tick(float delta)
	{
		if (_behaviours == null)
		{
			return PlayableStateEnum.Error;
		}
		if (_interval == 0f)
		{
			return PlayableStateEnum.Error;
		}
		if (_stateEnum == PlayableStateEnum.Exit)
		{
			return PlayableStateEnum.Error;
		}
		if (_isPause)
		{
			return PlayableStateEnum.Pause;
		}
		_stateEnum = PlayableStateEnum.Running;
		_currentFrameID++;
		TickPrivate(delta);
		return _stateEnum;
	}

	public PlayableStateEnum Tick(int currentFrameId)
	{
		if (_behaviours == null)
		{
			return PlayableStateEnum.Error;
		}
		if (_isPause)
		{
			return PlayableStateEnum.Pause;
		}
		_stateEnum = PlayableStateEnum.Running;
		_currentFrameID = currentFrameId;
		TickPrivate(0.033f);
		return _stateEnum;
	}

	private void TickPrivate(float delta)
	{
		if (_currentFrameID > _skillTimeAssets.Duration)
		{
			_stateEnum = PlayableStateEnum.Exit;
			OnTimelineExit(_executeEntity);
			return;
		}
		for (int i = 0; i < _skillTimeAssets.Tracks.Count; i++)
		{
			StandardTrack standardTrack = _skillTimeAssets.Tracks[i];
			for (int j = 0; j < standardTrack.taskClips.Count; j++)
			{
				TaskClip taskClip = standardTrack.taskClips[j];
				TaskClip taskClip2 = _behaviours[i][j];
				if (taskClip2 == null)
				{
					break;
				}
				if (_currentFrameID >= taskClip.taskStartID && _currentFrameID < taskClip.taskStartID + taskClip.taskDuration)
				{
					if (taskClip2.State == PlayableStateEnum.Exit)
					{
						taskClip2.OnRunTimeEnter(_executeEntity, 60, _currentFrameID);
					}
					taskClip2.RunTimeTick(_currentFrameID - taskClip.taskStartID, 60, delta, _executeEntity);
				}
				else if ((_currentFrameID < taskClip.taskStartID || _currentFrameID >= taskClip.taskStartID + taskClip.taskDuration) && taskClip2.State == PlayableStateEnum.Running)
				{
					taskClip2.OnRunTimeExit(_executeEntity, 60, _currentFrameID);
				}
			}
		}
	}

	public void ForceExecuteStop()
	{
		_currentFrameID = _skillTimeAssets.Duration + 1;
	}

	public void RefreshInitState()
	{
		_currentFrameID = 0;
		_stateEnum = PlayableStateEnum.Init;
		_interval = 0.033f;
	}

	public void Pause(bool isPause)
	{
		_isPause = isPause;
	}

	public void Clear()
	{
		SkillTimeLineAssetsFactory.Current.RecycleTree(_skillTimeAssets);
		_stateEnum = PlayableStateEnum.Exit;
		_behaviours.Clear();
		_currentFrameID = 0;
		_interval = 0f;
		_executeEntity = null;
		_onSkillStopAction = null;
		_isPause = false;
	}
}
