using System;
using System.Collections.Generic;
using System.Linq;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskBtnCell : MonoBehaviour, ISubmitHandler, IEventSystemHandler
{
	[Serializable]
	public class TaskButtonTemplateSettings
	{
		public TaskPanel.MissionTab type;

		public TaskButtonCellTemplate template;
	}

	[Header("背景组件")]
	public List<TaskButtonTemplateSettings> templates;

	[NonSerialized]
	public TaskPanel taskPanel;

	[NonSerialized]
	public MainTaskCell parentCell;

	[NonSerialized]
	public MainTaskCell taskCell;

	public int curMissionId;

	public PublicToggle btn;

	public GameObject icon;

	public GameObject target;

	public BImage backGround;

	public TextChanger textChanger;

	public RedDotItem redDotItem;

	private bool isMainMission;

	private bool m_IsSelect;

	public LocalizeStringEvent TitleName { get; private set; }

	public GameObject SelectedStyle { get; private set; }

	public GameObject NormalStyle { get; private set; }

	public BetterAnimation BetterAnimation { get; private set; }

	public CanvasGroup CanvasGroup { get; private set; }

	public bool isSelect
	{
		get
		{
			return m_IsSelect;
		}
		set
		{
			if (m_IsSelect != value)
			{
				SetSelectValue(value);
				btn.isOn = value;
				if (m_IsSelect)
				{
					SetSelected();
				}
				else
				{
					SetNormal();
				}
			}
		}
	}

	public void SetSelectWithoutNotify(bool isOn)
	{
		if (m_IsSelect != isOn)
		{
			SetSelectValue(isOn);
			btn.SetIsOnWithoutNotify(isOn);
		}
	}

	private void SetSelectValue(bool value)
	{
		m_IsSelect = value;
		if (m_IsSelect)
		{
			taskPanel.curSelectMission = this;
			taskPanel.UpdateRightPanel(curMissionId);
		}
	}

	public void SetAttribute(int missionId, bool isOld, TaskPanel.MissionTab missionType)
	{
		curMissionId = missionId;
		TaskPanel.MissionViewInfoAdapter missionViewInfoAdapter = taskPanel.MissionViewInfoMap[missionId];
		TaskButtonCellTemplate taskButtonCellTemplate = templates.FirstOrDefault((TaskButtonTemplateSettings t) => t.type == missionType)?.template ?? templates.First().template;
		SelectedStyle = taskButtonCellTemplate.selected;
		NormalStyle = taskButtonCellTemplate.normal;
		TitleName = taskButtonCellTemplate.titleName;
		BetterAnimation = taskButtonCellTemplate.betterAnimation;
		CanvasGroup = taskButtonCellTemplate.canvasGroup;
		taskButtonCellTemplate.gameObject.SetActive(value: true);
		UpdateTracingState();
		taskButtonCellTemplate.SetTitle(missionViewInfoAdapter.Name);
		icon.SetActive(!isOld);
		btn.onValueChanged.AddListener((bool isOn) =>
		{
			isSelect = isOn;
		});
	}

	public void UpdateTracingState()
	{
		TaskPanel.MissionViewInfoAdapter missionViewInfoAdapter = taskPanel.MissionViewInfoMap[curMissionId];
		if (missionViewInfoAdapter.IsTracing())
		{
			target.gameObject.SetActive(value: true);
			taskPanel.Station.LoadImageAsync(200, TaskPanel.ConvertToMissionIconId(missionViewInfoAdapter.MissionType), backGround).Forget();
		}
		else
		{
			target.gameObject.SetActive(value: false);
		}
	}

	public void ClickBtn()
	{
		icon.SetActive(value: false);
		isSelect = true;
		taskPanel?.SetRedpointState(curMissionId);
	}

	public void SetNormal()
	{
		SelectedStyle.gameObject.SetActive(value: false);
		NormalStyle.gameObject.SetActive(value: true);
		if (parentCell != null)
		{
			parentCell.SelectedStyle.SetActive(value: false);
			parentCell.NormalStyle.SetActive(value: true);
		}
		BetterAnimation.GetSequence("NormalShow").Play();
		if (parentCell != null)
		{
			parentCell.BetterAnimation.GetSequence("NormalShow").Play();
		}
	}

	public void SetNormalStatus()
	{
		if (isActiveAndEnabled)
		{
			m_IsSelect = false;
			btn.SetIsOnWithoutNotify(value: false);
			SelectedStyle.gameObject.SetActive(value: false);
			NormalStyle.gameObject.SetActive(value: true);
			if (parentCell != null)
			{
				parentCell.SelectedStyle.SetActive(value: false);
				parentCell.NormalStyle.SetActive(value: true);
			}
			textChanger?.SetColor(isSelect: false);
			BetterAnimation.GetSequence("NormalShow").Play();
		}
	}

	public void SetSelected()
	{
		if (isActiveAndEnabled)
		{
			SelectedStyle.gameObject.SetActive(value: true);
			NormalStyle.gameObject.SetActive(value: false);
			if (parentCell != null)
			{
				parentCell.SelectedStyle.SetActive(value: true);
				parentCell.NormalStyle.SetActive(value: false);
			}
			BetterAnimation.GetSequence("SelectedShow").Play();
			if (parentCell != null)
			{
				parentCell.BetterAnimation.GetSequence("SelectedShow").Play();
			}
		}
	}

	public void SelectToggle()
	{
		ClickBtn();
	}

	public void OnSubmit(BaseEventData eventData)
	{
		ClickBtn();
	}
}
