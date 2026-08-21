using System.Collections.Generic;

namespace Ase;

public class GameHeroInfoViewModel : OptionBase
{
	private HeroModel heroModel;

	private List<GameHeroInfoItemData> heroTagList;

	private List<GameHeroInfoItemData> heroDetailList;

	private List<GameHeroInfoItemData> heroTreasureList;

	private GameHeroInfoItemData heroTreasureItemData;

	private List<TabItemNormalData> heroTreasurePointList;

	private int showTreasureIndex;

	private RollingViewModel heroTreasureRollingViewModel;

	private List<GameHeroInfoItemData> heroStoryList;

	private List<HeroSkinItemData> heroSkinList;

	private List<GameStoryGuideItemData> heroCGList;

	private HeroVoiceViewModel heroVoiceViewModel;

	private List<TabItemNormalData> tagList;

	private TabItemNormalData curTag;

	private Dictionary<string, bool> heroRedPointDic;

	private string key;

	private GameNoteHeroTab _selectedTag;

	public GameNoteHeroTab SelectedTag
	{
		get
		{
			return _selectedTag;
		}
		set
		{
			Set(ref _selectedTag, value, "SelectedTag");
		}
	}

	public HeroModel HeroModel => heroModel;

	public List<GameHeroInfoItemData> HeroTagList => heroTagList;

	public List<GameHeroInfoItemData> HeroDetailList => heroDetailList;

	public List<GameHeroInfoItemData> HeroTreasureList => heroTreasureList;

	public List<GameHeroInfoItemData> HeroStoryList => heroStoryList;

	public List<HeroSkinItemData> HeroSkinList => heroSkinList;

	public List<GameStoryGuideItemData> HeroCgList => heroCGList;

	public HeroVoiceViewModel HeroVoiceViewModel => heroVoiceViewModel;

	public List<TabItemNormalData> TagList => tagList;

	public GameHeroInfoItemData HeroTreasureItemData
	{
		get
		{
			return heroTreasureItemData;
		}
		private set
		{
			Set(ref heroTreasureItemData, value, "HeroTreasureItemData");
		}
	}

	public List<TabItemNormalData> HeroTreasurePointList => heroTreasurePointList;

	public GameHeroInfoViewModel(OptionBase parent, int heroId, int tagIndex = 0)
	{
		base.parent = parent;
		heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroId, emptyCreateNew: true, saveNew: false);
		Dictionary<int, Dictionary<string, bool>> heroRedPoint = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetHeroRedPoint();
		heroRedPointDic = new Dictionary<string, bool>();
		if (heroRedPoint.TryGetValue(heroModel.Id, out var value))
		{
			heroRedPointDic = value;
		}
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
			.Uid;
		key = $"{uid}_{heroId}";
		tagList = new List<TabItemNormalData>();
		for (int i = 0; i < 6; i++)
		{
			tagList.Add(new TabItemNormalData(this, "", i));
		}
		heroVoiceViewModel = new HeroVoiceViewModel(this, heroModel);
		tagList[3].RedPoint = heroVoiceViewModel.CheckRed();
		LoadHeroTag();
		LoadHeroDetail();
		LoadHeroStory();
		LoadHeroSkin();
		LoadHeroCG();
		if (tagList.Count > tagIndex)
		{
			SwitchTag(TagList[tagIndex]);
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData tag)
		{
			SwitchTag(tag);
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is GameStoryGuideItemData itemData)
			{
				OpenCGWindow(itemData);
			}
		}
		else if (obj is HeroVoiceViewModel heroVoiceViewModel)
		{
			tagList[3].RedPoint = heroVoiceViewModel.CheckRed();
		}
		else if (obj is HeroSkinItemData heroSkinItemData)
		{
			OpenHeroSkin(heroSkinItemData);
		}
	}

	private void SwitchTag(TabItemNormalData tag)
	{
		if (curTag != null && curTag.ID == tag.ID)
		{
			return;
		}
		if (tag.RedPoint && tag.ID != 3)
		{
			tag.RedPoint = false;
			CloseHeroRedPoint(tag.ID);
		}
		else
		{
			TabItemNormalData tabItemNormalData = curTag;
			if (tabItemNormalData != null && tabItemNormalData.ID == 3)
			{
				heroVoiceViewModel.ClearRedPoint();
				tagList[3].RedPoint = false;
			}
		}
		curTag?.SetSelected(value: false);
		curTag = tag;
		curTag.SetSelected(value: true);
		SelectedTag = (GameNoteHeroTab)tag.ID;
	}

	private void CloseHeroRedPoint(int tagId)
	{
		switch (tagId)
		{
		case 0:
		{
			foreach (GameHeroInfoItemData heroTag in heroTagList)
			{
				if (heroTag.RedPoint)
				{
					heroTag.RedPoint = false;
					CloseHeroRedPoint(0, heroTag.ID);
				}
			}
			break;
		}
		case 1:
			foreach (GameHeroInfoItemData heroDetail in heroDetailList)
			{
				if (heroDetail.RedPoint)
				{
					heroDetail.RedPoint = false;
					CloseHeroRedPoint(1, heroDetail.ID);
				}
			}
			{
				foreach (GameHeroInfoItemData heroTreasure in heroTreasureList)
				{
					if (heroTreasure.RedPoint)
					{
						heroTreasure.RedPoint = false;
						CloseHeroRedPoint(6, heroTreasure.ID);
					}
				}
				break;
			}
		case 2:
		{
			foreach (GameHeroInfoItemData heroStory in heroStoryList)
			{
				if (heroStory.RedPoint)
				{
					heroStory.RedPoint = false;
					CloseHeroRedPoint(2, heroStory.ID);
				}
			}
			break;
		}
		case 5:
		{
			foreach (GameStoryGuideItemData heroCG in heroCGList)
			{
				if (heroCG.IsNew)
				{
					heroCG.SetIsNew(value: false);
					CloseHeroRedPoint(5, heroCG.ID);
				}
			}
			break;
		}
		case 3:
		case 4:
			break;
		}
	}

	private void CloseHeroRedPoint(int tagId, int id)
	{
		Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().SaveHeroRedPoint(heroModel.Id, tagId, id);
	}

	private void LoadHeroTag()
	{
		heroTagList = new List<GameHeroInfoItemData>();
		DRHeroTag[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTag p) => p.HeroId == heroModel.Id);
		foreach (DRHeroTag dRHeroTag in dataRows)
		{
			GameHeroInfoItemData gameHeroInfoItemData = new GameHeroInfoItemData(this, dRHeroTag.Id);
			gameHeroInfoItemData.SetText(dRHeroTag.Desc);
			heroTagList.Add(gameHeroInfoItemData);
			if (dRHeroTag.OpenType == 2 && dRHeroTag.OpenNum > heroModel.FeelingLevel)
			{
				string newLockText = "信任度达到" + GameEntry.DataTable.GetDataRow<DRTrust>(dRHeroTag.OpenNum)?.Name + "解锁";
				gameHeroInfoItemData.SetLock(isLock: true, newLockText);
				gameHeroInfoItemData.RedPoint = false;
				continue;
			}
			string text = $"{key}_{0}_{dRHeroTag.Id}";
			heroRedPointDic.TryGetValue(text, out var value);
			gameHeroInfoItemData.RedPoint = value;
			if (value)
			{
				tagList[0].RedPoint = true;
			}
		}
	}

	private void LoadHeroDetail()
	{
		heroDetailList = new List<GameHeroInfoItemData>();
		DRHeroDetails[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroDetails p) => p.HeroId == heroModel.Id);
		foreach (DRHeroDetails dRHeroDetails in dataRows)
		{
			GameHeroInfoItemData gameHeroInfoItemData = new GameHeroInfoItemData(this, dRHeroDetails.Id);
			if (dRHeroDetails.OpenType == 2 && dRHeroDetails.OpenNum > heroModel.FeelingLevel)
			{
				string newLockText = "信任度达到" + GameEntry.DataTable.GetDataRow<DRTrust>(dRHeroDetails.OpenNum)?.Name + "解锁";
				gameHeroInfoItemData.SetLock(isLock: true, newLockText);
				gameHeroInfoItemData.RedPoint = false;
			}
			else
			{
				gameHeroInfoItemData.SetText("", dRHeroDetails.Desc);
				string text = $"{key}_{1}_{dRHeroDetails.Id}";
				heroRedPointDic.TryGetValue(text, out var value);
				gameHeroInfoItemData.RedPoint = value;
				if (value)
				{
					tagList[1].RedPoint = true;
				}
			}
			heroDetailList.Add(gameHeroInfoItemData);
		}
		heroTreasureList = new List<GameHeroInfoItemData>();
		heroTreasurePointList = new List<TabItemNormalData>();
		DRHeroTreasure[] dataRows2 = GameEntry.DataTable.GetDataRows((DRHeroTreasure p) => p.HeroId == heroModel.Id);
		foreach (DRHeroTreasure dRHeroTreasure in dataRows2)
		{
			GameHeroInfoItemData gameHeroInfoItemData2 = new GameHeroInfoItemData(this, dRHeroTreasure.Id);
			if (dRHeroTreasure.OpenType == 2 && dRHeroTreasure.OpenNum > heroModel.FeelingLevel)
			{
				string newLockText2 = "信任度达到" + GameEntry.DataTable.GetDataRow<DRTrust>(dRHeroTreasure.OpenNum)?.Name + "解锁";
				gameHeroInfoItemData2.SetLock(isLock: true, newLockText2);
				gameHeroInfoItemData2.RedPoint = false;
			}
			else
			{
				gameHeroInfoItemData2.SetIconPath(dRHeroTreasure.Icon);
				gameHeroInfoItemData2.SetText(dRHeroTreasure.Name, dRHeroTreasure.Desc);
				string text2 = $"{key}_{6}_{dRHeroTreasure.Id}";
				heroRedPointDic.TryGetValue(text2, out var value2);
				gameHeroInfoItemData2.RedPoint = value2;
				if (value2)
				{
					tagList[1].RedPoint = true;
				}
			}
			heroTreasureList.Add(gameHeroInfoItemData2);
			heroTreasurePointList.Add(new TabItemNormalData(this, "empty"));
		}
		showTreasureIndex = 0;
		HeroTreasureItemData = new GameHeroInfoItemData(null);
		SetHeroTreasureItemData();
		heroTreasurePointList[showTreasureIndex].SetSelected(value: true);
	}

	private void SetHeroTreasureItemData()
	{
		HeroTreasureItemData.SetIconPath(heroTreasureList[showTreasureIndex].Icon);
		HeroTreasureItemData.SetText(heroTreasureList[showTreasureIndex].Title, heroTreasureList[showTreasureIndex].Desc);
		HeroTreasureItemData.SetLock(heroTreasureList[showTreasureIndex].IsLock, heroTreasureList[showTreasureIndex].LockText);
	}

	public void TreasureLeft()
	{
		heroTreasurePointList[showTreasureIndex].SetSelected(value: false);
		showTreasureIndex = ((showTreasureIndex == 0) ? (heroTreasureList.Count - 1) : (showTreasureIndex - 1));
		SetHeroTreasureItemData();
		heroTreasurePointList[showTreasureIndex].SetSelected(value: true);
	}

	public void TreasureRight()
	{
		heroTreasurePointList[showTreasureIndex].SetSelected(value: false);
		showTreasureIndex = ((showTreasureIndex != heroTreasureList.Count - 1) ? (showTreasureIndex + 1) : 0);
		SetHeroTreasureItemData();
		heroTreasurePointList[showTreasureIndex].SetSelected(value: true);
	}

	private void LoadHeroStory()
	{
		heroStoryList = new List<GameHeroInfoItemData>();
		DRHeroStory[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroStory p) => p.HeroId == heroModel.Id);
		for (int num = 0; num < dataRows.Length; num++)
		{
			if (HeroModelExtension.GetStoryOpenState(dataRows[num]))
			{
				GameHeroInfoItemData gameHeroInfoItemData = new GameHeroInfoItemData(this, dataRows[num].Id);
				gameHeroInfoItemData.SetText($"P A R T{num + 1}", dataRows[num].Desc);
				string text = $"{key}_{2}_{dataRows[num].Id}";
				heroRedPointDic.TryGetValue(text, out var value);
				gameHeroInfoItemData.RedPoint = value;
				if (value)
				{
					tagList[2].RedPoint = true;
				}
				heroStoryList.Add(gameHeroInfoItemData);
				continue;
			}
			GameHeroInfoItemData gameHeroInfoItemData2 = new GameHeroInfoItemData(this, dataRows[num].Id);
			string newLockText = "";
			if (dataRows[num].OpenType == 1)
			{
				newLockText = GameEntry.DataTable.GetDataRow<DRTask>(dataRows[num].OpenNum)?.TaskName + "完成后解锁";
			}
			else if (dataRows[num].OpenType == 2)
			{
				newLockText = "信任度达到" + GameEntry.DataTable.GetDataRow<DRTrust>(dataRows[num].OpenNum)?.Name + "解锁";
			}
			gameHeroInfoItemData2.SetLock(isLock: true, newLockText);
			gameHeroInfoItemData2.RedPoint = false;
			heroStoryList.Add(gameHeroInfoItemData2);
		}
	}

	private void LoadHeroSkin()
	{
		List<int> heroSkins = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroSkins(heroModel.Id);
		heroSkinList = new List<HeroSkinItemData>();
		DRUIHeroSkin[] dataRows = GameEntry.DataTable.GetDataTable<DRUIHeroSkin>().GetDataRows((DRUIHeroSkin p) => p.HeroID == heroModel.Id);
		foreach (DRUIHeroSkin skin in dataRows)
		{
			HeroSkinItemData heroSkinItemData = new HeroSkinItemData(this, skin);
			heroSkinItemData.InActiveMask = !heroSkins.Exists((int p) => p.Equals(skin.Id));
			heroSkinList.Add(heroSkinItemData);
		}
		heroSkinList.Sort((HeroSkinItemData x, HeroSkinItemData y) => x.Sort.CompareTo(y.Sort));
	}

	private void OpenHeroSkin(HeroSkinItemData heroSkinItemData)
	{
		HeroSkinPreViewViewModel heroSkinPreViewViewModel = new HeroSkinPreViewViewModel(this, heroModel.Id, heroSkinItemData.ConfigId);
		heroSkinPreViewViewModel.SetWindowType(2);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroSkinPreViewWindow), heroSkinPreViewViewModel));
	}

	private void LoadHeroCG()
	{
		heroCGList = new List<GameStoryGuideItemData>();
		DRHeroCG[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroCG p) => p.HeroId == heroModel.Id);
		bool flag = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.CharacterIndex == 0;
		List<long> timelineList = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetTimelineList();
		List<long> branchTimelineList = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetBranchTimelineList();
		List<long> activityTimelineList = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetActivityTimelineList();
		DRHeroCG[] array = dataRows;
		foreach (DRHeroCG dRHeroCG in array)
		{
			DRCGNote drcgNote = GameEntry.DataTable.GetDataRow<DRCGNote>(dRHeroCG.CGId);
			DRTimeLineNote dataRow = GameEntry.DataTable.GetDataRow((DRTimeLineNote p) => p.TimeLineId == drcgNote.OpenNum);
			if (dataRow != null && !UiConvert.BitwiseConvert.Bitwise(timelineList, dataRow.Id - 1))
			{
				continue;
			}
			DRBranchTimeLineNote dataRow2 = GameEntry.DataTable.GetDataRow((DRBranchTimeLineNote p) => p.TimeLineId == drcgNote.OpenNum);
			if (dataRow2 != null && !UiConvert.BitwiseConvert.Bitwise(branchTimelineList, dataRow2.Id - 1))
			{
				continue;
			}
			DRVersionTimeLineNote dataRow3 = GameEntry.DataTable.GetDataRow((DRVersionTimeLineNote p) => p.TimeLineId == drcgNote.OpenNum);
			if (dataRow3 == null || UiConvert.BitwiseConvert.Bitwise(activityTimelineList, dataRow3.Id - 1))
			{
				string iconPath = (flag ? drcgNote.CGForMale : drcgNote.CGForFemale);
				GameStoryGuideItemData gameStoryGuideItemData = new GameStoryGuideItemData(this, iconPath, drcgNote.Id, 7, drcgNote.PrePath);
				gameStoryGuideItemData.SetExData(drcgNote.Chapter, drcgNote.Type, drcgNote.Name, drcgNote.Desc);
				string text = $"{key}_{5}_{drcgNote.Id}";
				bool flag2 = false;
				flag2 = ((!heroRedPointDic.ContainsKey(text)) ? Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().LoadHeroRedPoint(heroModel.Id, 5, drcgNote.Id) : heroRedPointDic[text]);
				gameStoryGuideItemData.SetIsNew(flag2);
				if (flag2)
				{
					tagList[5].RedPoint = true;
				}
				heroCGList.Add(gameStoryGuideItemData);
			}
		}
	}

	private void OpenCGWindow(GameStoryGuideItemData itemData)
	{
		int index = 1;
		for (int i = 0; i < HeroCgList.Count; i++)
		{
			if (HeroCgList[i].ID == itemData.ID)
			{
				index = i + 1;
				break;
			}
		}
		GameStoryCGViewModel userData = new GameStoryCGViewModel(this, index, HeroCgList, itemData);
		openWindowRequest.Raise(new OpenViewArg(typeof(GameStoryCGWindow), userData));
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}
}
