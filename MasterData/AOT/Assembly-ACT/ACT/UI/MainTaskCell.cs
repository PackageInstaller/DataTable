using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MainTaskCell : MonoBehaviour
{
	[Serializable]
	public class TaskCellTemplateSettings
	{
		public TaskPanel.MissionTab type;

		public TaskCellTemplate template;
	}

	[Header("背景组件")]
	public List<TaskCellTemplateSettings> templates;

	[Header("子任务")]
	public GameObject taskList;

	[NonSerialized]
	public TaskPanel taskPanel;

	public GameObject progress;

	public List<GameObject> missionFinishedCount = new List<GameObject>();

	public List<GameObject> missionCount = new List<GameObject>();

	public PublicToggle toggle;

	private int m_Mission;

	private bool isSelect;

	public GameObject SelectedStyle { get; private set; }

	public GameObject NormalStyle { get; private set; }

	public LocalizeStringEvent TitleText { get; private set; }

	public LocalizeStringEvent ChapterText { get; private set; }

	public BetterAnimation BetterAnimation { get; private set; }

	public CanvasGroup CanvasGroup { get; private set; }

	public void SetParameter(int missionGroupId)
	{
		m_Mission = missionGroupId;
		if (!RuntimeConfigs.data.missionRGroups.TryGetValue(missionGroupId, out var value) && LuminApplication.LogEnabled)
		{
			Debug.LogError($"任务组Id{missionGroupId}找不到");
		}
		MainmissionData mainmissionData = RuntimeConfigs.data.mainmissionDatas[value.chapterID];
		TitleText.StringReference.TableEntryReference = value.description;
		ChapterText.StringReference.TableEntryReference = mainmissionData.subTitle;
		progress.SetActive(value: false);
		toggle.onValueChanged.AddListener((bool isOn) =>
		{
			if (isOn && !isSelect)
			{
				SetSelected();
			}
			else if (!isOn && isSelect)
			{
				SetNormal();
			}
		});
	}

	public void SetImage(TaskPanel.MissionTab missionType)
	{
		TaskCellTemplate taskCellTemplate = templates.FirstOrDefault((TaskCellTemplateSettings t) => t.type == missionType)?.template ?? templates.First().template;
		taskCellTemplate.gameObject.SetActive(value: true);
		SelectedStyle = taskCellTemplate.selected;
		NormalStyle = taskCellTemplate.normal;
		TitleText = taskCellTemplate.titleText;
		ChapterText = taskCellTemplate.chapterText;
		BetterAnimation = taskCellTemplate.betterAnimation;
		CanvasGroup = taskCellTemplate.canvasGroup;
	}

	public async UniTask LoadPrefabs(TaskPanel.TagInfo tagInfo, List<int> missionIds, TaskPanel.MissionTab missionType)
	{
		taskPanel.TagAll.AnimationCells.Add((true, m_Mission, BetterAnimation, CanvasGroup));
		tagInfo.AnimationCells.Add((true, m_Mission, BetterAnimation, CanvasGroup));
		for (int i = 0; i < missionIds.Count; i++)
		{
			int missionId = missionIds[i];
			TaskPanel.MissionViewInfoAdapter missionViewInfo = taskPanel.MissionViewInfoMap[missionId];
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(taskPanel.H3_ReferenceAssetID, taskList.transform);
			await handle;
			TaskBtnCell component = handle.AsGameObject().GetComponent<TaskBtnCell>();
			component.taskPanel = taskPanel;
			component.btn.group = taskPanel.taskToggleGroup;
			component.parentCell = this;
			component.SetAttribute(missionId, missionViewInfo.IsOld(), missionType);
			component.SetNormalStatus();
			tagInfo.H2.Add(component);
			tagInfo.OnBtnLoaded(component);
			taskPanel.TagAll.H2.Add(component);
			taskPanel.TagAll.OnBtnLoaded(component);
			taskPanel.TagAll.AnimationCells.Add((false, missionId, component.BetterAnimation, component.CanvasGroup));
			tagInfo.AnimationCells.Add((false, missionId, component.BetterAnimation, component.CanvasGroup));
		}
	}

	public void ClickBtn()
	{
	}

	public void SetNormal()
	{
		isSelect = false;
		SelectedStyle.SetActive(value: false);
		NormalStyle.SetActive(value: true);
		BetterAnimation.GetSequence("NormalShow").Play();
	}

	public void SetNormalStatus()
	{
		isSelect = false;
		SelectedStyle.SetActive(value: false);
		NormalStyle.SetActive(value: true);
		BetterAnimation.GetSequence("NormalShow").Play();
	}

	public void SetSelected()
	{
		isSelect = true;
		SelectedStyle.SetActive(value: true);
		NormalStyle.SetActive(value: false);
		BetterAnimation.GetSequence("SelectedShow").Play();
	}
}
