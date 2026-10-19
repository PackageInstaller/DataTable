using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskMissionGroupCellV3 : MonoBehaviour, ITaskPoolItemV3
{
	[SerializeField]
	private TaskMissionGroupTemplateV3 _template;

	[SerializeField]
	private Transform _missionRoot;

	[SerializeField]
	private PublicToggle _toggle;

	[SerializeField]
	private GameObject _progressRoot;

	[SerializeField]
	private List<GameObject> _missionCountMarkers = new List<GameObject>();

	[SerializeField]
	private List<GameObject> _missionFinishedMarkers = new List<GameObject>();

	public TaskCategoryV3 Category { get; private set; }

	public Transform MissionRoot => _missionRoot;

	public TaskAnimationTargetV3 AnimationTarget => new TaskAnimationTargetV3(_template.AnimationTarget.CanvasGroup, PlayNormalShow);

	public void Bind(TaskMissionGroupViewDataV3 data, ToggleGroup toggleGroup)
	{
		Category = data.Category;
		_template.Bind(data.Category, data.TitleId, data.ChapterSubtitleId);
		_toggle.group = toggleGroup;
		_toggle.SetIsOnWithoutNotifyAndRefreshVisual(value: false);
		_toggle.onValueChanged.AddListener(OnToggleValueChanged);
		_progressRoot.SetActive(value: false);
		for (int i = 0; i < _missionCountMarkers.Count; i++)
		{
			_missionCountMarkers[i].SetActive(i < data.Missions.Count);
		}
		for (int j = 0; j < _missionFinishedMarkers.Count; j++)
		{
			_missionFinishedMarkers[j].SetActive(value: false);
		}
	}

	public void SetSelected(bool selected, bool playAnimation)
	{
		_template.SetSelected(selected, playAnimation);
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
		_toggle.SetIsOnWithoutNotifyAndRefreshVisual(value: false);
		_toggle.group = null;
		_progressRoot.SetActive(value: false);
		for (int i = 0; i < _missionCountMarkers.Count; i++)
		{
			_missionCountMarkers[i].SetActive(value: false);
		}
		for (int j = 0; j < _missionFinishedMarkers.Count; j++)
		{
			_missionFinishedMarkers[j].SetActive(value: false);
		}
		_template.Unbind();
		Category = TaskCategoryV3.All;
	}

	private void OnToggleValueChanged(bool selected)
	{
		SetSelected(selected, playAnimation: true);
	}
}
