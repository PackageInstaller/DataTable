using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ActivityAchievementViewModel : ActivityViewModelBase
{
	private int activityTypeId;

	private string countTxt;

	private string rewardCountTxt;

	private string nameTxt;

	private string descTxt;

	private bool redPoint;

	private IActivityAchievementService service;

	private TabItemData curTabItemData;

	private ActivityAchievementItemData curItemData;

	private List<TabItemData> subTabItemDataList = new List<TabItemData>();

	private List<ActivityAchievementItemData> itemList = new List<ActivityAchievementItemData>();

	private List<ActivityAchievementItemData> tabShowList = new List<ActivityAchievementItemData>();

	private List<ActivityAchievementDescData> descList = new List<ActivityAchievementDescData>();

	private SimpleCommand openRewardCmd;

	private InteractionRequest subTabChangedRst = new InteractionRequest();

	private InteractionRequest dataListChangeRst = new InteractionRequest();

	private InteractionRequest descChangedRst = new InteractionRequest();

	private InteractionRequest titleDescChangedRst = new InteractionRequest();

	public string CountTxt
	{
		get
		{
			return countTxt;
		}
		set
		{
			Set(ref countTxt, value, "CountTxt");
		}
	}

	public string RewardCountTxt
	{
		get
		{
			return rewardCountTxt;
		}
		set
		{
			Set(ref rewardCountTxt, value, "RewardCountTxt");
		}
	}

	public string NameTxt
	{
		get
		{
			return nameTxt;
		}
		set
		{
			Set(ref nameTxt, value, "NameTxt");
		}
	}

	public string DescTxt
	{
		get
		{
			return descTxt;
		}
		set
		{
			Set(ref descTxt, value, "DescTxt");
		}
	}

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

	public int ActivityType => activityTypeId;

	public ActivityAchievementItemData CurItemData => curItemData;

	public List<TabItemData> SubTabItemDataList => subTabItemDataList;

	public List<ActivityAchievementItemData> ItemList => itemList;

	public List<ActivityAchievementItemData> TabShowList => tabShowList;

	public List<ActivityAchievementDescData> DescList => descList;

	public SimpleCommand OpenRewardCmd => openRewardCmd;

	public InteractionRequest SubTabChangedRst => subTabChangedRst;

	public InteractionRequest DataListChangeRst => dataListChangeRst;

	public InteractionRequest DescChangedRst => descChangedRst;

	public InteractionRequest TitleDescChangedRst => titleDescChangedRst;

	public ActivityAchievementViewModel()
	{
	}

	public ActivityAchievementViewModel(OptionBase parent, int activityType, List<ActivityAchievementData> dataList)
	{
		base.parent = parent;
		activityTypeId = activityType;
		service = Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>();
		openRewardCmd = new SimpleCommand(OpenReward);
		InitData(dataList);
		RedPoint = service.ByActivityTypeGetRedPoint(activityTypeId);
		RefreshTabShowItemData();
		RefreshCurItemDescData();
	}

	private void InitData(List<ActivityAchievementData> dataList)
	{
		if (dataList == null || dataList.Count <= 0)
		{
			Debug.Log($"该活动{activityTypeId}成就出错");
			return;
		}
		subTabItemDataList.Clear();
		itemList.Clear();
		subTabItemDataList.Add(new TabItemData(this, 0)
		{
			TextNormal = "全部",
			TextSelected = "全部"
		});
		int num = 0;
		for (int i = 0; i < dataList.Count; i++)
		{
			ActivityAchievementItemData activityAchievementItemData = new ActivityAchievementItemData(this, dataList[i]);
			if (activityAchievementItemData.Config.state == ActivityAchievementState.Collected)
			{
				num++;
			}
			itemList.Add(activityAchievementItemData);
			bool flag = false;
			foreach (TabItemData subTabItemData in subTabItemDataList)
			{
				if (subTabItemData.TabIndex == dataList[i].type)
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				subTabItemDataList.Add(new TabItemData(this, dataList[i].type)
				{
					TextNormal = dataList[i].typeName,
					TextSelected = dataList[i].typeName
				});
			}
		}
		CountTxt = num + "/" + itemList.Count;
		List<ActivityAchievementTaskData> list = service.ByActivityTypeGetTaskDataList(activityTypeId);
		int num2 = 0;
		foreach (ActivityAchievementTaskData item in list)
		{
			if (item.isClaimed)
			{
				num2++;
			}
			else if (item.isCompleted)
			{
				num2++;
			}
		}
		RewardCountTxt = "收集奖励：" + num2 + "/" + list.Count;
		curTabItemData = subTabItemDataList[0];
		curTabItemData.IsSelected = true;
	}

	public void RefreshTabShowItemData()
	{
		tabShowList.Clear();
		if (curTabItemData.TabIndex == 0)
		{
			tabShowList.AddRange(itemList);
		}
		else
		{
			foreach (ActivityAchievementItemData item in itemList)
			{
				if (item.Config.type == curTabItemData.TabIndex)
				{
					tabShowList.Add(item);
				}
			}
		}
		curItemData = tabShowList[0];
		curItemData.IsSelected = true;
		dataListChangeRst.Raise();
	}

	public void RefreshCurItemDescData()
	{
		for (int i = 0; i < curItemData.Config.levelDesc.Count; i++)
		{
			string lv = (i + 1).ToString();
			string desc = curItemData.Config.levelDesc[i];
			if (i < descList.Count)
			{
				descList[i].Refresh(this, lv, desc, curItemData.Config);
				continue;
			}
			ActivityAchievementDescData item = new ActivityAchievementDescData(this, lv, desc, curItemData.Config);
			descList.Add(item);
		}
		for (int num = descList.Count - 1; num >= curItemData.Config.levelDesc.Count; num--)
		{
			descList[num] = null;
			descList.RemoveAt(num);
		}
		descChangedRst.Raise();
		titleDescChangedRst.Raise();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemData tabSelected)
		{
			SetTabSelected(tabSelected);
		}
		else if (obj is ActivityAchievementItemData itemSelected)
		{
			SetItemSelected(itemSelected);
		}
		else if (obj is ViewBackArg viewBackArg && viewBackArg.Obj is ActivityAchievementRewardViewModel)
		{
			RedPoint = service.ByActivityTypeGetRedPoint(activityTypeId);
		}
	}

	private void SetTabSelected(TabItemData tabItemData)
	{
		if (tabItemData != null && tabItemData.TabIndex != curTabItemData.TabIndex)
		{
			curTabItemData.IsSelected = false;
			curTabItemData = tabItemData;
			curTabItemData.IsSelected = true;
			subTabChangedRst.Raise();
			RefreshTabShowItemData();
			RefreshCurItemDescData();
		}
	}

	private void SetItemSelected(ActivityAchievementItemData itemData)
	{
		if (itemData != null && itemData.Id != curItemData.Id)
		{
			curItemData.IsSelected = false;
			curItemData = itemData;
			curItemData.IsSelected = true;
			RefreshCurItemDescData();
		}
	}

	private void OpenReward()
	{
		List<ActivityAchievementTaskData> taskList = service.ByActivityTypeGetTaskDataList(activityTypeId);
		ActivityAchievementRewardViewModel userData = new ActivityAchievementRewardViewModel(this, taskList);
		openWindowRequest.Raise(new OpenViewArg(typeof(ActivityAchievementRewardView), userData));
	}
}
