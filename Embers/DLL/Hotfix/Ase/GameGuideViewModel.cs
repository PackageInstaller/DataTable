#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class GameGuideViewModel : OptionBase
{
	private List<TabItemNormalData> tagDataList;

	private bool isOpenWindow;

	private List<GameStoryGuideItemData> timeLineDataList;

	private string key;

	private Dictionary<string, RedPointSave> mainTimeLineRedPointDic;

	private Dictionary<string, RedPointSave> branchTimeLineRedPointDic;

	private Dictionary<string, RedPointSave> versionLineRedPointDic;

	private Dictionary<string, RedPointSave> timeLineCGRedPointDic;

	private Dictionary<string, RedPointSave> propRedPointDic;

	private Dictionary<string, RedPointSave> mapRedPointDic;

	private Dictionary<string, RedPointSave> monsterRedPointDic;

	public Dictionary<int, Dictionary<string, bool>> heroRedPointDic;

	public List<TabItemNormalData> TagDataList => tagDataList;

	public GameGuideViewModel(OptionBase parent)
	{
		base.parent = parent;
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		key = $"{uid}_GameNoteRedPoint";
		timeLineDataList = new List<GameStoryGuideItemData>();
		LoadServiceData();
	}

	private void LoadRedPoint()
	{
		mainTimeLineRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(1);
		branchTimeLineRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(2);
		versionLineRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(3);
		timeLineCGRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(7);
		propRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(5);
		mapRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(6);
		heroRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetHeroRedPoint();
		monsterRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(4);
		LoadTag();
	}

	private void LoadTag()
	{
		tagDataList = new List<TabItemNormalData>();
		DRGameGuideView[] dataRows = GameEntry.DataTable.GetDataRows((DRGameGuideView p) => p.Type == 0);
		foreach (DRGameGuideView dRGameGuideView in dataRows)
		{
			TabItemNormalData tabItemNormalData = new TabItemNormalData(this, dRGameGuideView.Icon, dRGameGuideView.MarkId);
			tabItemNormalData.RedPoint = CheckTagRedPoint(tabItemNormalData.ID);
			tagDataList.Add(tabItemNormalData);
		}
	}

	private bool CheckTagRedPoint(int type)
	{
		Dictionary<string, RedPointSave> dictionary = new Dictionary<string, RedPointSave>();
		switch (type)
		{
		case 1:
			heroRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetHeroRedPoint();
			foreach (KeyValuePair<int, Dictionary<string, bool>> item in heroRedPointDic)
			{
				foreach (KeyValuePair<string, bool> item2 in item.Value)
				{
					if (item2.Value)
					{
						return true;
					}
				}
			}
			return false;
		case 2:
			mainTimeLineRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(1);
			branchTimeLineRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(2);
			versionLineRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(3);
			timeLineCGRedPointDic = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetRedPointService(7);
			foreach (KeyValuePair<string, RedPointSave> item3 in mainTimeLineRedPointDic)
			{
				RedPointSave value = item3.Value;
				if (value != null && value.isNew)
				{
					return true;
				}
			}
			foreach (KeyValuePair<string, RedPointSave> item4 in branchTimeLineRedPointDic)
			{
				RedPointSave value = item4.Value;
				if (value != null && value.isNew)
				{
					return true;
				}
			}
			foreach (KeyValuePair<string, RedPointSave> item5 in versionLineRedPointDic)
			{
				RedPointSave value = item5.Value;
				if (value != null && value.isNew)
				{
					return true;
				}
			}
			foreach (KeyValuePair<string, RedPointSave> item6 in timeLineCGRedPointDic)
			{
				RedPointSave value = item6.Value;
				if (value != null && value.isNew)
				{
					return true;
				}
			}
			break;
		case 3:
			dictionary = monsterRedPointDic;
			break;
		case 4:
			dictionary = propRedPointDic;
			break;
		case 5:
			dictionary = mapRedPointDic;
			break;
		}
		if (dictionary == null)
		{
			return false;
		}
		foreach (KeyValuePair<string, RedPointSave> item7 in dictionary)
		{
			RedPointSave value = item7.Value;
			if (value != null && value.isNew)
			{
				return true;
			}
		}
		return false;
	}

	private void RefreshTabRedPoint(int index, bool redPoint)
	{
		if (index + 1 <= tagDataList.Count)
		{
			tagDataList[index].RedPoint = redPoint;
		}
	}

	private void LoadServiceData()
	{
		LoadRedPoint();
		timeLineDataList.Clear();
		DRTimeLineNote[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRTimeLineNote>();
		DRBranchTimeLineNote[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRBranchTimeLineNote>();
		DRVersionTimeLineNote[] allDataRow3 = GameEntry.DataTable.GetAllDataRow<DRVersionTimeLineNote>();
		List<long> timelineList = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetTimelineList();
		List<long> branchTimelineList = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetBranchTimelineList();
		List<long> activityTimelineList = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetActivityTimelineList();
		bool flag = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.CharacterIndex == 0;
		DRTimeLineNote[] array = allDataRow;
		foreach (DRTimeLineNote dRTimeLineNote in array)
		{
			if (UiConvert.BitwiseConvert.Bitwise(timelineList, dRTimeLineNote.Id - 1))
			{
				string iconPath = (flag ? dRTimeLineNote.TimeIconForMale : dRTimeLineNote.TimeIconForFemale);
				GameStoryGuideItemData gameStoryGuideItemData = new GameStoryGuideItemData(null, iconPath, dRTimeLineNote.TimeLineId, 1, dRTimeLineNote.PrePath);
				gameStoryGuideItemData.SetExData(dRTimeLineNote.Chapter, dRTimeLineNote.Type);
				gameStoryGuideItemData.SetIndexId(dRTimeLineNote.Id);
				gameStoryGuideItemData.SetIsNew(GetIsNew(1, dRTimeLineNote.Id));
				timeLineDataList.Add(gameStoryGuideItemData);
			}
		}
		DRBranchTimeLineNote[] array2 = allDataRow2;
		foreach (DRBranchTimeLineNote dRBranchTimeLineNote in array2)
		{
			if (UiConvert.BitwiseConvert.Bitwise(branchTimelineList, dRBranchTimeLineNote.Id - 1))
			{
				string iconPath2 = (flag ? dRBranchTimeLineNote.TimeIconForMale : dRBranchTimeLineNote.TimeIconForFemale);
				GameStoryGuideItemData gameStoryGuideItemData2 = new GameStoryGuideItemData(null, iconPath2, dRBranchTimeLineNote.TimeLineId, 2, dRBranchTimeLineNote.PrePath);
				gameStoryGuideItemData2.SetExData(dRBranchTimeLineNote.Chapter, dRBranchTimeLineNote.Type);
				gameStoryGuideItemData2.SetIndexId(dRBranchTimeLineNote.Id);
				gameStoryGuideItemData2.SetIsNew(GetIsNew(2, dRBranchTimeLineNote.Id));
				timeLineDataList.Add(gameStoryGuideItemData2);
			}
		}
		DRVersionTimeLineNote[] array3 = allDataRow3;
		foreach (DRVersionTimeLineNote dRVersionTimeLineNote in array3)
		{
			if (UiConvert.BitwiseConvert.Bitwise(activityTimelineList, dRVersionTimeLineNote.Id - 1))
			{
				string iconPath3 = (flag ? dRVersionTimeLineNote.TimeIconForMale : dRVersionTimeLineNote.TimeIconForFemale);
				GameStoryGuideItemData gameStoryGuideItemData3 = new GameStoryGuideItemData(null, iconPath3, dRVersionTimeLineNote.TimeLineId, 3, dRVersionTimeLineNote.PrePath);
				gameStoryGuideItemData3.SetExData(dRVersionTimeLineNote.Chapter, dRVersionTimeLineNote.Type);
				gameStoryGuideItemData3.SetIndexId(dRVersionTimeLineNote.Id);
				gameStoryGuideItemData3.SetIsNew(GetIsNew(3, dRVersionTimeLineNote.Id));
				timeLineDataList.Add(gameStoryGuideItemData3);
			}
		}
	}

	private bool GetIsNew(int type, int id)
	{
		string text = $"{key}_{type}_{id}";
		switch (type)
		{
		case 1:
		{
			mainTimeLineRedPointDic.TryGetValue(text, out var value2);
			return value2?.isNew ?? true;
		}
		case 2:
		{
			branchTimeLineRedPointDic.TryGetValue(text, out var value6);
			return value6?.isNew ?? true;
		}
		case 3:
		{
			versionLineRedPointDic.TryGetValue(text, out var value3);
			return value3?.isNew ?? true;
		}
		case 5:
		{
			propRedPointDic.TryGetValue(text, out var value5);
			return value5?.isNew ?? true;
		}
		case 6:
		{
			mapRedPointDic.TryGetValue(text, out var value7);
			return value7?.isNew ?? true;
		}
		case 4:
		{
			monsterRedPointDic.TryGetValue(text, out var value4);
			return value4?.isNew ?? true;
		}
		case 7:
		{
			timeLineCGRedPointDic.TryGetValue(text, out var value);
			return value?.isNew ?? true;
		}
		default:
			return false;
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData tabItemNormalData)
		{
			OpenWindow(tabItemNormalData.ID);
		}
		else
		{
			if (!(obj is OptionArg optionArg))
			{
				return;
			}
			if (optionArg.Obj is GameMapGuideViewModel)
			{
				RefreshTabRedPoint(4, redPoint: false);
				return;
			}
			if (optionArg.Obj is GamePropGuideViewModel)
			{
				RefreshTabRedPoint(3, !optionArg.OptionName.Equals("false"));
				return;
			}
			if (optionArg.Obj is GameMonsterGuideViewModel)
			{
				RefreshTabRedPoint(2, redPoint: false);
				return;
			}
			if (optionArg.Obj is GameHeroGuideViewModel gameHeroGuideViewModel)
			{
				RefreshTabRedPoint(0, redPoint: false);
				{
					foreach (MapPointItemData pointItemData in gameHeroGuideViewModel.PointItemDataList)
					{
						if (pointItemData.RedPoint)
						{
							RefreshTabRedPoint(0, redPoint: true);
							break;
						}
					}
					return;
				}
			}
			if (!(optionArg.Obj is GameStoryGuideViewModel gameStoryGuideViewModel))
			{
				return;
			}
			bool redPoint = false;
			foreach (TabItemNormalData storyType in gameStoryGuideViewModel.StoryTypeList)
			{
				if (storyType.RedPoint)
				{
					redPoint = true;
				}
			}
			RefreshTabRedPoint(1, redPoint);
		}
	}

	private void OpenWindow(int index)
	{
		if (!isOpenWindow)
		{
			switch (index)
			{
			case 1:
				OpenGameHeroGuideWindow();
				break;
			case 2:
				OpenGameStoryGuideWindow();
				break;
			case 3:
				OpenGameMonsterGuideWindow();
				break;
			case 4:
				OpenGamePropGuideWindow();
				break;
			case 5:
				OpenGameMapGuideWindow();
				break;
			}
		}
	}

	private void OpenGameHeroGuideWindow()
	{
		isOpenWindow = true;
		try
		{
			GameHeroGuideViewModel userData = new GameHeroGuideViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(GameHeroGuideWindow), userData), delegate
			{
				isOpenWindow = false;
			});
		}
		catch (Exception)
		{
			isOpenWindow = false;
		}
	}

	private void OpenGameStoryGuideWindow()
	{
		isOpenWindow = true;
		List<GameStoryGuideItemData> list = new List<GameStoryGuideItemData>();
		DRCGNote[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRCGNote>();
		bool flag = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.CharacterIndex == 0;
		DRCGNote[] array = allDataRow;
		foreach (DRCGNote drCGNote in array)
		{
			if (timeLineDataList.FindAll((GameStoryGuideItemData n) => n.ID.Equals(drCGNote.OpenNum)).Count != 0)
			{
				string iconPath = (flag ? drCGNote.CGForMale : drCGNote.CGForFemale);
				GameStoryGuideItemData gameStoryGuideItemData = new GameStoryGuideItemData(null, iconPath, drCGNote.Id, 7, drCGNote.PrePath);
				gameStoryGuideItemData.SetExData(drCGNote.Chapter, drCGNote.Type, drCGNote.Name, drCGNote.Desc);
				gameStoryGuideItemData.SetIndexId(drCGNote.Id);
				gameStoryGuideItemData.SetIsNew(GetIsNew(7, drCGNote.Id));
				list.Add(gameStoryGuideItemData);
			}
		}
		List<TabItemNormalData> list2 = new List<TabItemNormalData>();
		DRGameGuideView[] dataRows = GameEntry.DataTable.GetDataRows((DRGameGuideView p) => p.Type == 1 && p.SubType == 1);
		foreach (DRGameGuideView dRGameGuideView in dataRows)
		{
			TabItemNormalData tabItemNormalData = new TabItemNormalData(dRGameGuideView.Name, dRGameGuideView.MarkId);
			tabItemNormalData.SetCanOnClick(value: true);
			tabItemNormalData.MarkName = "StoryType";
			list2.Add(tabItemNormalData);
		}
		try
		{
			GameStoryGuideViewModel userData = new GameStoryGuideViewModel(this, timeLineDataList, list, list2);
			openWindowRequest.Raise(new OpenViewArg(typeof(GameStoryGuideWindow), userData), delegate
			{
				isOpenWindow = false;
			});
		}
		catch (Exception ex)
		{
			isOpenWindow = false;
			Log.Error("打开图鉴剧情界面失败，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void OpenGameMonsterGuideWindow()
	{
		isOpenWindow = true;
		try
		{
			GameMonsterGuideViewModel userData = new GameMonsterGuideViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(GameMonsterGuideWindow), userData), delegate
			{
				isOpenWindow = false;
			});
		}
		catch (Exception ex)
		{
			isOpenWindow = false;
			Log.Error("打开图鉴怪物界面失败，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void OpenGamePropGuideWindow()
	{
		isOpenWindow = true;
		List<GamePropGuideItemData> list = new List<GamePropGuideItemData>();
		List<TabItemNormalData> list2 = new List<TabItemNormalData>();
		DRCollectionNote[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRCollectionNote>();
		List<long> collection = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetCollection();
		DRCollectionNote[] array = allDataRow;
		foreach (DRCollectionNote dRCollectionNote in array)
		{
			GamePropGuideItemData gamePropGuideItemData = new GamePropGuideItemData(null, dRCollectionNote.CollcetionId, dRCollectionNote.Type, dRCollectionNote.Sort);
			int checkId = dRCollectionNote.CollcetionId;
			gamePropGuideItemData.SetIsLock(collection == null || collection.Find((long n) => n.Equals(checkId)) == 0);
			gamePropGuideItemData.SetIsNew(GetIsNew(5, dRCollectionNote.CollcetionId));
			list.Add(gamePropGuideItemData);
		}
		DRGameGuideView[] dataRows = GameEntry.DataTable.GetDataRows((DRGameGuideView p) => p.Type == 2);
		for (int num = 0; num < dataRows.Length; num++)
		{
			TabItemNormalData tabItemNormalData = new TabItemNormalData(dataRows[num].Name, dataRows[num].MarkId);
			tabItemNormalData.Img = dataRows[num].Icon;
			tabItemNormalData.SetCanOnClick(value: true);
			list2.Add(tabItemNormalData);
		}
		try
		{
			GamePropGuideViewModel userData = new GamePropGuideViewModel(this, list, list2);
			openWindowRequest.Raise(new OpenViewArg(typeof(GamePropGuideWindow), userData), delegate
			{
				isOpenWindow = false;
			});
		}
		catch (Exception ex)
		{
			isOpenWindow = false;
			Log.Error("打开图鉴收集品界面，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void OpenGameMapGuideWindow()
	{
		isOpenWindow = true;
		try
		{
			GameMapGuideViewModel userData = new GameMapGuideViewModel(this, timeLineDataList);
			openWindowRequest.Raise(new OpenViewArg(typeof(GameMapGuideWindow), userData), delegate
			{
				isOpenWindow = false;
			});
		}
		catch (Exception ex)
		{
			isOpenWindow = false;
			Log.Error("打开图鉴地图界面，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}
}
