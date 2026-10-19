using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public abstract class TaskMissionCellBaseV3 : MonoBehaviour, ITaskPoolItemV3, ISubmitHandler, IEventSystemHandler
{
	[SerializeField]
	private TaskMissionButtonTemplateV3 _template;

	[SerializeField]
	private PublicToggle _toggle;

	[SerializeField]
	private RedDotItem _redDotItem;

	private TaskMissionViewDataV3 _data;

	private TaskMissionGroupCellV3 _parentGroup;

	private Action<int> _onSelected;

	private Action<int> _onActivated;

	public int MissionId => _data.MissionId;

	public TaskCategoryV3 Category => _data.Category;

	public GameObject SelectionTarget => _toggle.gameObject;

	public TaskAnimationTargetV3 AnimationTarget => new TaskAnimationTargetV3(_template.AnimationTarget.CanvasGroup, PlayNormalShow);

	public void Bind(TaskMissionViewDataV3 data, ToggleGroup toggleGroup, TaskMissionGroupCellV3 parentGroup, Action<int> onSelected, Action<int> onActivated)
	{
		_data = data;
		_parentGroup = parentGroup;
		_onSelected = onSelected;
		_onActivated = onActivated;
		_template.Bind(data.Category, data.NameId);
		_toggle.group = toggleGroup;
		_toggle.SetIsOnWithoutNotifyAndRefreshVisual(value: false);
		_toggle.onValueChanged.AddListener(OnToggleValueChanged);
		_toggle.onMouseClick.AddListener(OnMissionActivated);
		BindRedDot();
	}

	public void Select()
	{
		if (_toggle.isOn)
		{
			ApplySelectedState(selected: true, playAnimation: false);
			_onSelected?.Invoke(_data.MissionId);
		}
		else
		{
			_toggle.isOn = true;
		}
	}

	public void SetTracing(bool tracing)
	{
		_template.SetTracing(tracing);
	}

	public void SetBlocked(bool blocked)
	{
		_template.SetBlocked(blocked);
	}

	public void RefreshRedDot()
	{
		_redDotItem.UpdateDisplay();
	}

	public void StopAnimation()
	{
		_template.StopAnimation();
	}

	public bool PlayNormalShow()
	{
		return _template.PlayNormalShow();
	}

	public void Unbind()
	{
		_toggle.onValueChanged.RemoveListener(OnToggleValueChanged);
		_toggle.onMouseClick.RemoveListener(OnMissionActivated);
		_toggle.SetIsOnWithoutNotifyAndRefreshVisual(value: false);
		_toggle.group = null;
		UnbindRedDot();
		_template.Unbind();
		_data = null;
		_parentGroup = null;
		_onSelected = null;
		_onActivated = null;
	}

	public void OnSubmit(BaseEventData eventData)
	{
		OnMissionActivated();
		Select();
	}

	private void OnToggleValueChanged(bool selected)
	{
		ApplySelectedState(selected, playAnimation: true);
		if (selected)
		{
			_onSelected?.Invoke(_data.MissionId);
		}
	}

	private void ApplySelectedState(bool selected, bool playAnimation)
	{
		_template.SetSelected(selected, playAnimation);
		if ((bool)_parentGroup)
		{
			_parentGroup.SetSelected(selected, playAnimation);
		}
	}

	private void OnMissionActivated()
	{
		_onActivated?.Invoke(_data.MissionId);
	}

	private void BindRedDot()
	{
		UnbindRedDot();
		_redDotItem.redDotType = RedDotType.Dot;
		_redDotItem.fullPath = new List<string>(3)
		{
			RedDotPathDefine.Task,
			((int)_data.Category).ToString(),
			_data.MissionId.ToString()
		};
		_redDotItem.BindTrieNode();
		_redDotItem.UpdateDisplay();
	}

	private void UnbindRedDot()
	{
		RedDotTrieNode redDotTrieNode = _redDotItem.redDotTrieNode;
		if (redDotTrieNode != null)
		{
			redDotTrieNode.itemList?.Remove(_redDotItem);
			_redDotItem.redDotTrieNode = null;
		}
	}
}
