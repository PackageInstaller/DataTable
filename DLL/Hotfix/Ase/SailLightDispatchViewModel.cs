using System;
using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class SailLightDispatchViewModel : OptionBase
{
	private SailEventItemData curEventData;

	private List<SailEventItemData> sailEventItemDataList;

	private SailEventDetailViewModel sailEventDetailViewModel;

	private SailStateViewModel sailStateViewModel;

	private InteractionRequest refreshEventListRequest;

	private PropGetViewModel propGetViewModel;

	private int useTimes;

	private int maxTimes;

	private int totalDispatchTimes;

	private long curTime;

	private List<int> heroIds;

	private bool isEmpty;

	private bool needAfterAnimationRefresh;

	private long accountUid;

	private string date;

	private string tag = "_HomeLand_Sail_";

	public List<SailEventItemData> SailEventItemDataList
	{
		get
		{
			return sailEventItemDataList;
		}
		set
		{
			Set(ref sailEventItemDataList, value, "SailEventItemDataList");
		}
	}

	public bool IsEmpty
	{
		get
		{
			return isEmpty;
		}
		private set
		{
			Set(ref isEmpty, value, "IsEmpty");
		}
	}

	public SailEventDetailViewModel SailEventDetailViewModel => sailEventDetailViewModel;

	public SailStateViewModel SailStateViewModel => sailStateViewModel;

	public InteractionRequest RefreshEventListRequest => refreshEventListRequest;

	public SailLightDispatchViewModel(OptionBase parent, SailInfo sailInfo, int buildingLevel)
	{
		base.parent = parent;
		sailEventItemDataList = new List<SailEventItemData>();
		refreshEventListRequest = new InteractionRequest();
		accountUid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		date = $"{DateTime.Today.Year}{DateTime.Today.Month}{DateTime.Today.Day}";
		LoadEventList(sailInfo, buildingLevel);
	}

	public void OpenGamePlayWindow()
	{
		string title = "规则说明";
		string content = GameEntry.DataTable.GetDataRow<DRBuildingInfo>(2)?.PlayDesc;
		GamePlayTipsViewModel userData = new GamePlayTipsViewModel(this, title, content);
		openWindowRequest.Raise(new OpenViewArg(typeof(GamePlayTipsWindow), userData));
	}

	private void LoadEventList(SailInfo sailInfo, int buildingLevel)
	{
		foreach (int @event in sailInfo.EventList)
		{
			DRSailEvent dataRow = GameEntry.DataTable.GetDataRow<DRSailEvent>(@event);
			if (dataRow != null)
			{
				SailEventItemData sailEventItemData = new SailEventItemData(this);
				sailEventItemData.LoadBaseInfo(dataRow);
				sailEventItemData.SetInfo(0L, new List<int>());
				sailEventItemData.IsNew = CheckSailEvent(@event);
				SailEventItemDataList.Add(sailEventItemData);
			}
		}
		foreach (SailEventInfo oldDispatchInfo in sailInfo.OldDispatchInfoList)
		{
			DRSailEvent dataRow2 = GameEntry.DataTable.GetDataRow<DRSailEvent>(oldDispatchInfo.EventId);
			if (dataRow2 != null)
			{
				SailEventItemData sailEventItemData2 = new SailEventItemData(this);
				sailEventItemData2.LoadBaseInfo(dataRow2);
				sailEventItemData2.SetInfo(oldDispatchInfo.StartTime, oldDispatchInfo.heroIds);
				sailEventItemData2.uid = oldDispatchInfo.Uid;
				sailEventItemData2.IsNew = false;
				SailEventItemDataList.Add(sailEventItemData2);
			}
		}
		totalDispatchTimes += sailInfo.OldDispatchInfoList.Count;
		for (int i = 0; i < sailInfo.TodayDispatchInfoList.Count; i++)
		{
			for (int j = 0; j < SailEventItemDataList.Count; j++)
			{
				if (sailInfo.TodayDispatchInfoList[i].EventId == SailEventItemDataList[j].EventId && SailEventItemDataList[j].Uid == 0L)
				{
					if (sailInfo.TodayDispatchInfoList[i].IsRewarded)
					{
						SailEventItemDataList.Remove(SailEventItemDataList[j]);
						break;
					}
					SailEventItemDataList[j].SetInfo(sailInfo.TodayDispatchInfoList[i].StartTime, sailInfo.TodayDispatchInfoList[i].heroIds);
					SailEventItemDataList[j].uid = sailInfo.TodayDispatchInfoList[i].Uid;
					SailEventItemDataList[j].IsNew = false;
					totalDispatchTimes++;
					break;
				}
			}
		}
		SailEventItemDataList.Sort(new SailEventSort());
		maxTimes = GameEntry.DataTable.GetDataRow<DRSailLightLevel>(buildingLevel).MaxSailCount;
		useTimes = maxTimes - sailInfo.TodayDispatchInfoList.Count;
		if (SailEventItemDataList.Count > 0)
		{
			sailEventDetailViewModel = new SailEventDetailViewModel(this, SailEventItemDataList[0]);
			sailEventDetailViewModel.SetLeftTimeText(useTimes, maxTimes);
			sailStateViewModel = new SailStateViewModel(this, SailEventItemDataList[0], sailInfo.SailingHeroList, buildingLevel);
			curEventData = SailEventItemDataList[0];
			curEventData.SetSelect(value: true);
			curEventData.IsNew = false;
		}
		IsEmpty = SailEventItemDataList.Count == 0;
	}

	private bool CheckSailEvent(int eventId)
	{
		return PlayerPrefs.GetInt($"{accountUid}_{date}{tag}{eventId}", 0) == 0;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is SailEventItemData sailEventItemData)
			{
				if (optionArg.OptionName.Equals("TimeFinish"))
				{
					if (sailEventItemData.EventId == curEventData?.EventId)
					{
						SailStateViewModel.Refresh(curEventData);
						SailEventDetailViewModel.State = 1;
					}
				}
				else if (optionArg.OptionName.Equals("TimeRefresh"))
				{
					if (sailEventItemData.EventId == curEventData?.EventId)
					{
						SailStateViewModel.LeftTimeText = sailEventItemData.LeftTimeText;
					}
				}
				else if (optionArg.OptionName.Equals("EventOnclick"))
				{
					if (needAfterAnimationRefresh)
					{
						curEventData.SetInfo(curTime, heroIds);
						SailStateViewModel.SetHeroSailState(heroIds, value: true);
						SailStateViewModel.StopAnimation();
					}
					needAfterAnimationRefresh = false;
					sailStateViewModel.AnimationFinish();
					EventOnclick(sailEventItemData);
				}
			}
			else if (optionArg.Obj is SailEventDetailViewModel sailEventDetailViewModel)
			{
				if (optionArg.OptionName.Equals("Start"))
				{
					if (totalDispatchTimes >= maxTimes * 2)
					{
						Toast.ShowInfo("远航灯已无库存,请先领取已完成的事件");
						sailEventDetailViewModel.SetStartCmdState2(value: true);
					}
					else
					{
						Send();
					}
				}
				else if (optionArg.OptionName.Equals("Finish"))
				{
					GetReward();
				}
				else if (optionArg.OptionName.Equals("AutoSelect"))
				{
					SailStateViewModel.AutoSelect();
				}
			}
			else if (optionArg.Obj is SailStateViewModel && "AnimationFinish".Equals(optionArg.OptionName))
			{
				AfterAnimation();
			}
		}
		else if (obj is SailSuccessViewModel sailSuccessViewModel)
		{
			if (propGetViewModel != null && propGetViewModel.PropGetList.Count > 0)
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel));
			}
			sailSuccessViewModel.Close();
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, allowSkipWindow: false);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}

	private void EventOnclick(SailEventItemData sailEventItemData)
	{
		if (sailEventItemData.IsNew)
		{
			PlayerPrefs.SetInt($"{accountUid}_{date}{tag}{sailEventItemData.EventId}", 1);
			sailEventItemData.IsNew = false;
		}
		if (!sailEventItemData.IsSelect)
		{
			curEventData?.SetSelect(value: false);
			curEventData = sailEventItemData;
			curEventData.SetSelect(value: true);
			sailEventDetailViewModel.Refresh(sailEventItemData);
			sailEventDetailViewModel.SetLeftTimeText(useTimes, maxTimes);
			sailStateViewModel.Refresh(sailEventItemData);
		}
	}

	private async void Send()
	{
		heroIds = new List<int>();
		curTime = 0L;
		for (int i = 0; i < SailStateViewModel.HeroItemList.Count; i++)
		{
			if (SailStateViewModel.HeroItemList[i].HeroId != 0)
			{
				heroIds.Add(SailStateViewModel.HeroItemList[i].HeroId);
			}
		}
		if (heroIds.Count == 0)
		{
			Toast.ShowInfo("请先选择烬天使");
			sailEventDetailViewModel.SetStartCmdState2(value: true);
			return;
		}
		long num = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().SendSailLightDispatch(heroIds, curEventData.EventId);
		if (num > 0)
		{
			curEventData.uid = num;
			DateTime dateTime = new DateTime(1970, 1, 1, 0, 0, 0, DateTimeKind.Utc);
			curTime = (long)(DateTime.UtcNow - dateTime).TotalSeconds;
			useTimes--;
			totalDispatchTimes++;
			SailStateViewModel.SetHeroSailState(heroIds, value: true);
			SailStateViewModel.PlayAnimation();
			sailEventDetailViewModel.PlayAudio();
			needAfterAnimationRefresh = true;
			sailEventDetailViewModel.SetLeftTimeText(useTimes, maxTimes);
		}
		else
		{
			sailEventDetailViewModel.SetStartCmdState2(value: true);
		}
	}

	private void AfterAnimation()
	{
		if (needAfterAnimationRefresh)
		{
			curEventData.SetInfo(curTime, heroIds);
			SailStateViewModel.Refresh(curEventData);
			SailEventDetailViewModel.Refresh(curEventData);
			SailEventDetailViewModel.SetLeftTimeText(useTimes, maxTimes);
			needAfterAnimationRefresh = false;
		}
	}

	private async void GetReward()
	{
		SailReward sailReward = await Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetSailLightReward(curEventData.uid);
		if (!sailReward.IsInit)
		{
			return;
		}
		propGetViewModel = sailReward.PropGetViewModel;
		SailSuccessViewModel userData = new SailSuccessViewModel(this, sailReward.GreatSuccess);
		openWindowRequest.Raise(new OpenViewArg(typeof(SailSuccessWindow), userData));
		SailStateViewModel.SetHeroSailState(curEventData.HeroIdList, value: false);
		for (int i = 0; i < SailEventItemDataList.Count; i++)
		{
			if (SailEventItemDataList[i].EventId == curEventData.EventId)
			{
				SailEventItemDataList.Remove(SailEventItemDataList[i]);
			}
		}
		SailEventItemDataList.Sort(new SailEventSort());
		if (SailEventItemDataList.Count > 0)
		{
			EventOnclick(SailEventItemDataList[0]);
		}
		else
		{
			IsEmpty = true;
		}
		refreshEventListRequest.Raise();
		totalDispatchTimes--;
	}
}
