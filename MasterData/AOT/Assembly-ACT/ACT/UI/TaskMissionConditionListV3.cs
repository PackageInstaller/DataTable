using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.MissionSystem;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class TaskMissionConditionListV3 : MonoBehaviour
{
	[SerializeField]
	private Transform _contentRoot;

	[SerializeField]
	private TaskMissionConditionRowV3 _template;

	private readonly List<TaskMissionConditionRowV3> _activeRows = new List<TaskMissionConditionRowV3>();

	private readonly Stack<TaskMissionConditionRowV3> _cachedRows = new Stack<TaskMissionConditionRowV3>();

	private int _missionId;

	private bool _eventsBound;

	public event Action LayoutChanged;

	private void Awake()
	{
		_template.gameObject.SetActive(value: false);
		BindEvents();
	}

	private void OnDestroy()
	{
		UnbindEvents();
		ClearRows();
	}

	public void BindMission(int missionId)
	{
		BindEvents();
		_missionId = missionId;
		Refresh();
	}

	public void Refresh()
	{
		ClearRows();
		if (_missionId <= 0)
		{
			LayoutChanged?.Invoke();
			return;
		}
		foreach (ConditionDescription missionDescription in Singleton<MissionManager>.instance.GetMissionDescriptions(_missionId))
		{
			if (missionDescription.HaveContent && (missionDescription.DescriptionContentId > 0 || missionDescription.DescriptionContent != null))
			{
				TaskMissionConditionRowV3 row = GetRow();
				_activeRows.Add(row);
				row.Bind(missionDescription);
			}
		}
		LayoutChanged?.Invoke();
	}

	public void Clear()
	{
		_missionId = 0;
		ClearRows();
		LayoutChanged?.Invoke();
	}

	public void Unbind()
	{
		Clear();
		UnbindEvents();
	}

	private void BindEvents()
	{
		if (!_eventsBound)
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_ConditionUpdate, OnMissionConditionUpdate);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_StageUpdate, OnMissionStageUpdate);
			_eventsBound = true;
		}
	}

	private void UnbindEvents()
	{
		if (_eventsBound)
		{
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_ConditionUpdate, OnMissionConditionUpdate);
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_StageUpdate, OnMissionStageUpdate);
			_eventsBound = false;
		}
	}

	private void OnMissionConditionUpdate(BaseEventContent content)
	{
		if (content is MissionNConditionUpdateEvt missionNConditionUpdateEvt && missionNConditionUpdateEvt.missionId == _missionId)
		{
			Refresh();
		}
	}

	private void OnMissionStageUpdate(BaseEventContent content)
	{
		if (content is MissionNStageUpdateEvt missionNStageUpdateEvt && missionNStageUpdateEvt.missionId == _missionId)
		{
			Refresh();
		}
	}

	private TaskMissionConditionRowV3 GetRow()
	{
		TaskMissionConditionRowV3 taskMissionConditionRowV;
		if (_cachedRows.Count > 0)
		{
			taskMissionConditionRowV = _cachedRows.Pop();
			taskMissionConditionRowV.transform.SetParent(_contentRoot, worldPositionStays: false);
		}
		else
		{
			taskMissionConditionRowV = UnityEngine.Object.Instantiate(_template, _contentRoot);
		}
		taskMissionConditionRowV.transform.SetAsLastSibling();
		taskMissionConditionRowV.gameObject.SetActive(value: true);
		return taskMissionConditionRowV;
	}

	private void ClearRows()
	{
		for (int i = 0; i < _activeRows.Count; i++)
		{
			TaskMissionConditionRowV3 taskMissionConditionRowV = _activeRows[i];
			taskMissionConditionRowV.Unbind();
			taskMissionConditionRowV.gameObject.SetActive(value: false);
			taskMissionConditionRowV.transform.SetParent(transform, worldPositionStays: false);
			_cachedRows.Push(taskMissionConditionRowV);
		}
		_activeRows.Clear();
	}
}
