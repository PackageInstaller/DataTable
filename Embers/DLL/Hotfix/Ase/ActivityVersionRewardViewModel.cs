using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class ActivityVersionRewardViewModel : OptionBase
{
	private List<TabItemNormalData> tabItemNormalDatas;

	private List<VersionMoneyViewModel> moneys;

	private ActivityShopViewModel shopViewModel;

	private PropExchangeViewModel exchangeViewModel;

	private PropExchangeViewModel exchangeWeaponViewModel;

	private PropExchangeViewModel exchangePackViewModel;

	private ActivityPointsViewModel activityPointsViewModel;

	private InteractionRequest<int> changeViewRst = new InteractionRequest<int>();

	private int activityTypeId;

	public ActivityShopViewModel ShopViewModel => shopViewModel;

	public ActivityPointsViewModel ActivityPointsViewModel => activityPointsViewModel;

	public InteractionRequest<int> ChangeViewRst => changeViewRst;

	public ActivityVersionRewardViewModel(OptionBase parent, int activityTypeId, List<ActivityTaskData> taskDataList, List<VersionMoneyViewModel> moneys)
	{
		base.parent = parent;
		this.activityTypeId = activityTypeId;
		tabItemNormalDatas = new List<TabItemNormalData>
		{
			new TabItemNormalData(this, "", 1, isSelected: true, "活动任务"),
			new TabItemNormalData(this, "", 2, isSelected: false, "限时商店")
		};
		List<DRVersionMoney> list = GameEntry.DataTable.GetDataRows((DRVersionMoney p) => p.ActivityId == activityTypeId).ToList();
		shopViewModel = new ActivityShopViewModel(this, (list.Count > 0) ? list[0].Shop : 0)
		{
			CurTabIndex = OpActivityDefinition.GetActivityMainShopId()
		};
		DRActivityRank[] dataRows = GameEntry.DataTable.GetDataRows((DRActivityRank p) => p.ActivityTypeId == activityTypeId);
		int subActivityTypeId = ((dataRows.Length > 1) ? dataRows[1].Id : 0);
		activityPointsViewModel = new ActivityPointsViewModel(this, taskDataList, activityTypeId, subActivityTypeId);
		AddChild(shopViewModel);
		AddChild(activityPointsViewModel);
		this.moneys = moneys;
		UpdateTabRed();
		exchangeViewModel = new PropExchangeViewModel(this);
		AddChild(exchangeViewModel);
		exchangeWeaponViewModel = new PropExchangeViewModel(this);
		AddChild(exchangeWeaponViewModel);
		exchangePackViewModel = new PropExchangeViewModel(this);
		AddChild(exchangePackViewModel);
	}

	private void UpdateTabRed()
	{
		tabItemNormalDatas[0].RedPoint = activityPointsViewModel.CheckRedPoint();
		tabItemNormalDatas[1].RedPoint = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetShopRedByShopPosition(ShopGoodItemData.ShopPosition.ActivityShop);
	}

	public VersionMoneyViewModel GetProp(int propId)
	{
		for (int i = 0; i < moneys.Count; i++)
		{
			if (moneys[i].PropId == propId)
			{
				return moneys[i];
			}
		}
		return null;
	}

	public async UniTask RequestData()
	{
		await shopViewModel.RequestData();
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is TabItemNormalData normalData)
		{
			SettleClickTab(normalData);
		}
		else if (obj is ShopGoodItemData shopGoodItemData)
		{
			ShopDefinition.OnShopGoodItemClick(shopGoodItemData.ExcData, GetExchangeViewModel, this, "ActivityVersionReward");
		}
		else if (obj is OptionArg optionArg)
		{
			if ("OnConfirmExc".Equals(optionArg.OptionName))
			{
				await OnConfirmExc(optionArg);
			}
			else
			{
				if (!(optionArg.Obj is ActivityTaskItemData activityTaskItemData))
				{
					return;
				}
				string optionName = optionArg.OptionName;
				if (!(optionName == "Jump"))
				{
					if (optionName == "Accept")
					{
						SendTaskAccept(activityTaskItemData);
					}
				}
				else
				{
					JumpWindow(activityTaskItemData);
				}
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}

	private void SettleClickTab(TabItemNormalData normalData)
	{
		if (normalData.IsSelected)
		{
			return;
		}
		for (int i = 0; i < tabItemNormalDatas.Count; i++)
		{
			if (tabItemNormalDatas[i] != normalData)
			{
				tabItemNormalDatas[i].SetSelected(value: false);
			}
		}
		normalData.SetSelected(value: true);
		changeViewRst.Raise(normalData.ID);
		UpdateTabRed();
	}

	public TabItemNormalData GetTabById(int id)
	{
		for (int i = 0; i < tabItemNormalDatas.Count; i++)
		{
			if (id == tabItemNormalDatas[i].ID)
			{
				return tabItemNormalDatas[i];
			}
		}
		return null;
	}

	private PropExchangeViewModel GetExchangeViewModel(ShopExcData excData)
	{
		return excData.Prop.PropTypeEnum switch
		{
			PropTypeEnum.GiftPack => exchangePackViewModel, 
			PropTypeEnum.Weapon => exchangeWeaponViewModel, 
			_ => exchangeViewModel, 
		};
	}

	private async UniTask OnConfirmExc(OptionArg optionArg)
	{
		if (optionArg.Obj is PropExchangeViewModel propExchangeViewModel)
		{
			await ShopDefinition.OnExchangeConfirm(this, propExchangeViewModel, shopViewModel, null);
		}
	}

	private async void JumpWindow(ActivityTaskItemData activityTaskItemData)
	{
		if (ActivityVersionConfig.IsActivityVersionWindow(activityTaskItemData.JumpWindow))
		{
			activityPointsViewModel?.Close();
			parent?.ItemOnClick(new OptionArg(null, "OpenPanel2"));
			Close();
			activityTaskItemData.ResetCmd();
			return;
		}
		Loading loading = await Loading.Show();
		OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(new JumpWindowParams(activityTaskItemData.JumpWindow, activityTaskItemData.JumpFlagValueList), this, "ActivityVersionReward");
		if (openViewArg != null)
		{
			openWindowRequest.Raise(openViewArg, delegate
			{
				activityPointsViewModel.UpdateAllTask();
				tabItemNormalDatas[0].RedPoint = activityPointsViewModel.CheckRedPoint();
			});
		}
		loading.Dispose();
		activityTaskItemData.ResetCmd();
	}

	private async void SendTaskAccept(ActivityTaskItemData activityTaskItemData)
	{
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskReward(activityTypeId, 0, activityTaskItemData.TaskRankId);
		foreach (ActivityTaskItemData activityTaskItemData2 in activityPointsViewModel.ActivityTaskItemDataList)
		{
			if (activityTaskItemData2.TaskState == ActivityTaskStateEnum.Accept)
			{
				activityTaskItemData2.ResetCmd();
			}
		}
		await activityPointsViewModel.RefreshRewardSlider();
		if (!activityReward.Result)
		{
			if (activityReward.ErrorCode == 200159)
			{
				foreach (ActivityTaskItemData activityTaskItemData3 in activityPointsViewModel.ActivityTaskItemDataList)
				{
					if (activityTaskItemData3.TaskState == ActivityTaskStateEnum.Accept)
					{
						activityTaskItemData3.SetFinishState();
					}
				}
			}
			tabItemNormalDatas[0].RedPoint = activityPointsViewModel.CheckRedPoint();
			return;
		}
		foreach (ActivityTaskItemData activityTaskItemData4 in activityPointsViewModel.ActivityTaskItemDataList)
		{
			if (activityTaskItemData4.TaskState == ActivityTaskStateEnum.Accept)
			{
				activityTaskItemData4.SetFinishState();
			}
		}
		activityPointsViewModel.Sort();
		tabItemNormalDatas[0].RedPoint = activityPointsViewModel.CheckRedPoint();
		PropGetViewModel propGetViewModel = new PropGetViewModel(parent, activityReward.Rewards);
		propGetViewModel.MergeProp();
		openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel));
	}
}
