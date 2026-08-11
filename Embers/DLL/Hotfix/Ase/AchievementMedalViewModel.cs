using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class AchievementMedalViewModel : OptionBase
{
	private TabItemNormalData curTag;

	private List<TabItemNormalData> tabDataList;

	private List<AchievementMedalItemData> showMedalItemDataList;

	private InteractionRequest refreshMedalItemRequest;

	private SimpleCommand openAllAchiRewardCmd;

	private SimpleCommand getAllRewardCmd;

	private bool showGetAllRewardBtn;

	private bool redPoint;

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public List<TabItemNormalData> TabDataList
	{
		get
		{
			return tabDataList;
		}
		set
		{
			Set(ref tabDataList, value, "TabDataList");
		}
	}

	public List<AchievementMedalItemData> ShowMedalItemDataList
	{
		get
		{
			return showMedalItemDataList;
		}
		set
		{
			Set(ref showMedalItemDataList, value, "ShowMedalItemDataList");
		}
	}

	public TabItemNormalData CurTag
	{
		get
		{
			return curTag;
		}
		set
		{
			Set(ref curTag, value, "CurTag");
		}
	}

	public bool ShowGetAllRewardBtn
	{
		get
		{
			return showGetAllRewardBtn;
		}
		set
		{
			Set(ref showGetAllRewardBtn, value, "ShowGetAllRewardBtn");
		}
	}

	public InteractionRequest RefreshMedalItemRequest => refreshMedalItemRequest;

	public SimpleCommand OpenAllAchiRewardCmd => openAllAchiRewardCmd;

	public SimpleCommand GetAllRewardCmd => getAllRewardCmd;

	public AchievementMedalViewModel(OptionBase parent, int type)
	{
		base.parent = parent;
		tabDataList = new List<TabItemNormalData>();
		showMedalItemDataList = new List<AchievementMedalItemData>();
		refreshMedalItemRequest = new InteractionRequest();
		openAllAchiRewardCmd = new SimpleCommand(OpenAllAchievementWindow);
		getAllRewardCmd = new SimpleCommand(SendGetAllReward);
		LoadAchievementTag(type);
		LoadAchievementMedal(type);
		RefreshGetAllRewardBtn();
		CheckRedPoint();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemNormalData tabItemNormalData)
		{
			SetCurTag(tabItemNormalData);
			LoadAchievementMedal(CurTag.ID);
			RefreshMedalItemRequest.Raise();
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is AchievementMedalItemData achievementMedalItemData)
			{
				if (optionArg.OptionName.Equals("OpenAchievementStageWindow"))
				{
					OpenAchievementStageWindow(achievementMedalItemData);
				}
				else if (optionArg.OptionName.Equals("GetReward"))
				{
					GetReward(achievementMedalItemData);
				}
			}
		}
		else if (obj is AchievementPropViewModel)
		{
			CheckRedPoint();
		}
	}

	private void RefreshGetAllRewardBtn()
	{
		ShowGetAllRewardBtn = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().CheckAchievementReward();
	}

	public async void SendGetAllReward()
	{
		getAllRewardCmd.Enabled = false;
		PropGetViewModel propGetViewModel = await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().SendAchievementReward(-1, 1);
		if (propGetViewModel != null)
		{
			propGetViewModel.MergeProp();
			foreach (TabItemNormalData tabData in TabDataList)
			{
				tabData.RedPoint = false;
			}
			foreach (AchievementMedalItemData showMedalItemData in ShowMedalItemDataList)
			{
				showMedalItemData.ResetMedal();
			}
			ShowGetAllRewardBtn = false;
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel), delegate
			{
				getAllRewardCmd.Enabled = true;
			});
		}
		parent?.ItemOnClick(this);
	}

	private async void OpenAllAchievementWindow()
	{
		openAllAchiRewardCmd.Enabled = false;
		if (await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupInfo())
		{
			AchievementPropViewModel userData = new AchievementPropViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(AchievementPropWindow), userData), delegate
			{
				openAllAchiRewardCmd.Enabled = true;
			});
		}
		else
		{
			openAllAchiRewardCmd.Enabled = true;
		}
	}

	private void LoadAchievementTag(int type)
	{
		DRAchievementType[] allDataRows = GameEntry.DataTable.GetDataTable<DRAchievementType>().GetAllDataRows();
		foreach (DRAchievementType dRAchievementType in allDataRows)
		{
			TabItemNormalData tabItemNormalData = new TabItemNormalData(this, string.Empty, dRAchievementType.Id, dRAchievementType.Id == type, dRAchievementType.Name);
			if (Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetFinishAchievementByType(dRAchievementType.Id)[1] > 0)
			{
				tabItemNormalData.RedPoint = true;
			}
			tabDataList.Add(tabItemNormalData);
			if (dRAchievementType.Id == type)
			{
				SetCurTag(tabItemNormalData);
			}
		}
	}

	private void SetCurTag(TabItemNormalData tagData)
	{
		if (CurTag != null)
		{
			if (CurTag.ID == tagData.ID)
			{
				return;
			}
			CurTag.IsSelected = false;
		}
		CurTag = tagData;
		CurTag.IsSelected = true;
	}

	private void LoadAchievementMedal(int type)
	{
		ShowMedalItemDataList.Clear();
		foreach (AchievementMedal allAchievementMedals in Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAllAchievementMedalsList())
		{
			if (allAchievementMedals.AchievementType == type && allAchievementMedals.MedalId > 0)
			{
				AchievementMedalItemData item = new AchievementMedalItemData(this, allAchievementMedals);
				ShowMedalItemDataList.Add(item);
			}
		}
	}

	private void OpenAchievementStageWindow(AchievementMedalItemData achievementMedalItemData)
	{
		int medalId = achievementMedalItemData.achievementMedal.MedalId;
		int medalNum = achievementMedalItemData.achievementMedal.MedalNum;
		int medalRank = achievementMedalItemData.achievementMedal.MedalRank;
		AchievementStagePropViewModel userData = new AchievementStagePropViewModel(this, medalId, medalNum, medalRank);
		openWindowRequest.Raise(new OpenViewArg(typeof(AchievementStagePropWindow), userData), delegate
		{
		});
	}

	private async void GetReward(AchievementMedalItemData achievementMedalItemData)
	{
		PropGetViewModel propGetViewModel = await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().SendAchievementReward(achievementMedalItemData.achievementMedal.MedalId, achievementMedalItemData.Curstar);
		if (propGetViewModel != null)
		{
			propGetViewModel.MergeProp();
			achievementMedalItemData.ResetMedal();
			int[] finishAchievementByType = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetFinishAchievementByType(curTag.ID);
			curTag.RedPoint = finishAchievementByType[1] > 0;
			parent?.ItemOnClick(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel), delegate
			{
			});
			RefreshGetAllRewardBtn();
		}
	}

	private async void CheckRedPoint()
	{
		RedPoint = false;
		if (!(await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupInfo()))
		{
			return;
		}
		Dictionary<int, int> achievementGroupStateDic = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementGroupStateDic();
		DRAchievementRewards[] allDataRows = GameEntry.DataTable.GetDataTable<DRAchievementRewards>().GetAllDataRows();
		foreach (DRAchievementRewards dRAchievementRewards in allDataRows)
		{
			int medalId = dRAchievementRewards.Id * -1;
			achievementGroupStateDic.TryGetValue(dRAchievementRewards.Id, out var value);
			if (Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetAchievementMedalById(medalId).MedalRank < 1 && value >= dRAchievementRewards.Num)
			{
				RedPoint = true;
				break;
			}
		}
	}

	public override void Close()
	{
		parent?.ItemOnClick(this);
		base.Close();
	}
}
