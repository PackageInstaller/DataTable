using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Core;
using Bamboo.AssetField;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TaskGroup : BaseUIComponent
{
	[Serializable]
	public class TaskTypeIconSettings
	{
		public TaskPanel.MissionTab type;

		public GameObject icon;
	}

	public BImage backGround;

	public LocalizeStringEvent TitleName;

	public GameObject mainTaskList;

	public GameObject taskList;

	public GameObject noTitleList;

	public TaskPanel taskPanel;

	public List<TaskTypeIconSettings> icons = new List<TaskTypeIconSettings>();

	private Dictionary<int, List<int>> NeedTitleMissions = new Dictionary<int, List<int>>();

	private List<int> UnNeedTitleMission = new List<int>();

	public async UniTask ReloadSecondPrefab(TaskPanel.TagInfo tagInfo)
	{
		TitleName.StringReference = tagInfo.leftTitleLocalize;
		taskPanel.Station.LoadImageAsync(108, 10 + TaskPanel.ConvertToMissionIconId(tagInfo.missionType), backGround).Forget();
		foreach (TaskTypeIconSettings icon in icons)
		{
			icon.icon.SetActive(value: false);
		}
		icons.FirstOrDefault((TaskTypeIconSettings i) => i.type == tagInfo.missionType)?.icon.gameObject.SetActive(value: true);
		NeedTitleMissions.Clear();
		UnNeedTitleMission.Clear();
		foreach (int missionId2 in tagInfo.missionIds)
		{
			int missionGroupId = taskPanel.MissionViewInfoMap[missionId2].MissionGroupId;
			if (missionGroupId <= 0 || !RuntimeConfigs.data.missionRGroups.ContainsKey(missionGroupId))
			{
				UnNeedTitleMission.Add(missionId2);
				continue;
			}
			if (!NeedTitleMissions.TryGetValue(missionGroupId, out var value))
			{
				value = (NeedTitleMissions[missionGroupId] = new List<int>());
			}
			value.Add(missionId2);
		}
		foreach (KeyValuePair<int, List<int>> kvp in NeedTitleMissions)
		{
			List<int> missionIds = kvp.Value;
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(taskPanel.H2_ReferenceAssetID, mainTaskList.transform);
			await handle;
			GameObject gameObject = handle.AsGameObject();
			MainTaskCell taskCell = gameObject.GetComponent<MainTaskCell>();
			tagInfo.H1.Add(taskCell);
			taskPanel.TagAll.H1.Add(taskCell);
			taskCell.toggle.group = taskPanel.taskToggleGroup;
			taskCell.taskPanel = taskPanel;
			taskCell.SetImage(tagInfo.missionType);
			taskCell.SetParameter(kvp.Key);
			taskCell.SetNormalStatus();
			await taskCell.LoadPrefabs(tagInfo, missionIds, tagInfo.missionType);
			for (int num = 0; num < missionIds.Count; num++)
			{
				if (num < taskCell.missionCount.Count)
				{
					taskCell.missionCount[num].SetActive(value: true);
					int key = missionIds[num];
					TaskPanel.MissionViewInfoAdapter missionViewInfoAdapter = taskPanel.MissionViewInfoMap[key];
					taskCell.missionFinishedCount[num].SetActive(missionViewInfoAdapter.IsFinished());
				}
			}
		}
		for (int j = 0; j < UnNeedTitleMission.Count; j++)
		{
			int missionId = UnNeedTitleMission[j];
			TaskPanel.MissionViewInfoAdapter missionViewInfo = taskPanel.MissionViewInfoMap[missionId];
			AssetLoadHandle handle = AssetStationManager.BattleStation.InstantiateAsync(taskPanel.H2_Reference_NoTitleAssetID, noTitleList.transform);
			await handle;
			GameObject gameObject2 = handle.AsGameObject();
			taskList.SetActive(value: true);
			TaskBtnCell component = gameObject2.GetComponent<TaskBtnCell>();
			component.taskPanel = taskPanel;
			component.btn.group = taskPanel.taskToggleGroup;
			component.SetAttribute(missionId, missionViewInfo.IsOld(), TaskPanel.MissionTab.WipeOutMission);
			component.SetNormalStatus();
			tagInfo.H2.Add(component);
			tagInfo.OnBtnLoaded(component);
			taskPanel.TagAll.H2.Add(component);
			taskPanel.TagAll.OnBtnLoaded(component);
		}
		taskPanel.RefreshRedDot();
	}
}
