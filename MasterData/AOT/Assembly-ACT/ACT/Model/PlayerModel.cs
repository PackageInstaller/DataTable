using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.UI;
using Fundamental;

namespace ACT.Model;

public class PlayerModel : Model<PlayerModel>
{
	private Dictionary<string, bool> m_commonTipsDic;

	private Dictionary<int, Dictionary<int, SystemGuideData>> typedDataDict;

	public Dictionary<string, bool> CommonTipsDic => m_commonTipsDic;

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PlayLevel_Change, EventRefreshRedDot);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, SystemOpenRefreshReddot);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Mission_Finish, SystemOpenRefreshReddot);
		m_commonTipsDic = new Dictionary<string, bool>();
		InitChapterData();
		RefreshChapterRewardRedDot();
		Model<WorldLevelModel>.CreateModel();
		RefreshWorldLevelTabRedDot();
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PlayLevel_Change, EventRefreshRedDot);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, SystemOpenRefreshReddot);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Mission_Finish, SystemOpenRefreshReddot);
		m_commonTipsDic.Clear();
	}

	public void InitChapterData()
	{
		typedDataDict = new Dictionary<int, Dictionary<int, SystemGuideData>>();
		foreach (KeyValuePair<int, SystemGuideData> systemGuideData in RuntimeConfigs.data.systemGuideDatas)
		{
			if (!typedDataDict.TryGetValue(systemGuideData.Value.chapter, out var value))
			{
				value = new Dictionary<int, SystemGuideData>();
				value.Add(systemGuideData.Value.id, systemGuideData.Value);
				typedDataDict[systemGuideData.Value.chapter] = value;
			}
			else
			{
				value[systemGuideData.Value.id] = systemGuideData.Value;
			}
		}
	}

	public List<SystemGuideData> GetDataListByType(int chapter)
	{
		if (typedDataDict.TryGetValue(chapter, out var value))
		{
			return value.Values.ToList();
		}
		return new List<SystemGuideData>();
	}

	public bool CheckHaveChapterReward()
	{
		int num = 0;
		for (int i = 1; i <= RuntimeConfigs.data.chapterIndexs.Values.Count; i++)
		{
			List<SystemGuideData> dataListByType = GetDataListByType(i);
			if (dataListByType.Find((SystemGuideData item) => item.type == 3) == null)
			{
				continue;
			}
			num = i;
			bool flag = false;
			foreach (SystemGuideData item in dataListByType)
			{
				if (!checkTypeUnlock(item) && i != 1)
				{
					num = i - 1;
					flag = true;
					break;
				}
			}
			if (flag)
			{
				break;
			}
		}
		if (num != 0 && !G.localPlayer.SystemGuideChapter.TryGetValue(num, out var _))
		{
			return true;
		}
		return false;
	}

	private bool checkTypeUnlock(SystemGuideData data)
	{
		if (data.type == 1)
		{
			if (data.condition.Length != 0)
			{
				MissionGroup data2 = CoreUtils.GetData(data.condition[0], RuntimeConfigs.data.missionGroups);
				if (data2 != null && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data2.id))
				{
					return false;
				}
			}
		}
		else if (data.type == 2)
		{
			if (data.condition.Length != 0)
			{
				MissionGroup data3 = CoreUtils.GetData(data.condition[0], RuntimeConfigs.data.missionGroups);
				if (data3 != null && !Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(data3.id))
				{
					return false;
				}
			}
			return true;
		}
		return true;
	}

	public bool CheckMapExploreReward(int areaId)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.MapUnLock))
		{
			return false;
		}
		foreach (MapArea value3 in RuntimeConfigs.data.mapAreas.Values)
		{
			if (value3.id == areaId)
			{
				continue;
			}
			if (G.localPlayer.redPoints.AreaExploreRedPoint.TryGetValue(value3.id, out var value) && value.Show)
			{
				return true;
			}
			if (value3.subMapArea.Length == 0)
			{
				continue;
			}
			int[] subMapArea = value3.subMapArea;
			foreach (int key in subMapArea)
			{
				if (G.localPlayer.redPoints.AreaExploreRedPoint.TryGetValue(key, out var value2) && value2.Show)
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool CheckMapExploreReward()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.MapUnLock))
		{
			return false;
		}
		foreach (MapArea value3 in RuntimeConfigs.data.mapAreas.Values)
		{
			if (value3.id == 0)
			{
				continue;
			}
			if (G.localPlayer.redPoints.AreaExploreRedPoint.TryGetValue(value3.id, out var value) && value.Show)
			{
				return true;
			}
			if (value3.subMapArea.Length == 0)
			{
				continue;
			}
			int[] subMapArea = value3.subMapArea;
			foreach (int key in subMapArea)
			{
				if (G.localPlayer.redPoints.AreaExploreRedPoint.TryGetValue(key, out var value2) && value2.Show)
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool CheckMapExploreRewardInOtherSubArea(int subAreaId)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.MapUnLock))
		{
			return false;
		}
		int areaBySubArea = MapUtility.GetAreaBySubArea(subAreaId);
		if (areaBySubArea != 0)
		{
			MapArea data = CoreUtils.GetData(areaBySubArea, RuntimeConfigs.data.mapAreas);
			if (data != null)
			{
				int[] subMapArea = data.subMapArea;
				foreach (int num in subMapArea)
				{
					if (num != subAreaId && G.localPlayer.redPoints.AreaExploreRedPoint.TryGetValue(num, out var value) && value.Show)
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	public bool CheckHaveLevelReward()
	{
		for (int i = 1; i <= SystemUnlockManager.playerLevel; i++)
		{
			PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[i];
			if (playerLevelData != null && playerLevelData.rewardId > 0 && !G.localPlayer.TakeRewardLevels.Contains(i))
			{
				return true;
			}
		}
		return false;
	}

	public void EventRefreshRedDot(BaseEventContent e)
	{
		RefreshChapterRewardRedDot();
		RefreshWorldLevelTabRedDot();
	}

	public void RefreshWorldLevelTabRedDot()
	{
		bool active = Model<WorldLevelModel>.Interface.IsShowRedDotInTab();
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.SystemGuide))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.WorldLevelTab, active: false);
		}
		else
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.WorldLevelTab, active);
		}
	}

	public void SystemOpenRefreshReddot(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { systemId: 1029 })
		{
			RefreshChapterRewardRedDot();
		}
	}

	public void RefreshChapterRewardRedDot()
	{
		bool chapterRewardRedDotStatus = CheckHaveChapterReward();
		SetChapterRewardRedDotStatus(chapterRewardRedDotStatus);
	}

	public void SetChapterRewardRedDotStatus(bool isShow)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.SystemGuide))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.SystemGuideChapterReward, active: false);
		}
		else
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.SystemGuideChapterReward, isShow);
		}
	}

	public void SetLevelRewardRedDotStatus(bool isShow)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.SystemGuide))
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.SystemGuideLevelReward, active: false);
		}
		else
		{
			Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.SystemGuideLevelReward, isShow);
		}
	}
}
