#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class GuildActivityExpeditionViewModel : OptionBase
{
	private string bossName;

	private InteractionRequest<string> optRequest;

	private SimpleCommand<string> optCommand;

	private List<GuildActivityCopyItemViewModel> listItems;

	private GuildActivityItemViewModel itemViewModel;

	private CopyItemDetail1ViewModel detailViewModel;

	private GuildActivityCopyItemViewModel curSelectViewModel;

	private List<KnapsackItemViewModel> showRewardItemDataList;

	private bool isReward;

	public GuildActivityItemViewModel ItemViewModel
	{
		get
		{
			return itemViewModel;
		}
		private set
		{
			Set(ref itemViewModel, value, "ItemViewModel");
		}
	}

	public CopyItemDetail1ViewModel DetailViewModel
	{
		get
		{
			return detailViewModel;
		}
		private set
		{
			Set(ref detailViewModel, value, "DetailViewModel");
		}
	}

	public bool IsReward
	{
		get
		{
			return isReward;
		}
		private set
		{
			Set(ref isReward, value, "IsReward");
		}
	}

	public GuildActivityCopyItemViewModel SelectItemViewModel
	{
		get
		{
			return curSelectViewModel;
		}
		private set
		{
			Set(ref curSelectViewModel, value, "SelectItemViewModel");
		}
	}

	public string BossName
	{
		get
		{
			return bossName;
		}
		private set
		{
			Set(ref bossName, value, "BossName");
		}
	}

	public List<KnapsackItemViewModel> ShowRewardItemDataList => showRewardItemDataList;

	public List<GuildActivityCopyItemViewModel> ListItems => listItems;

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public GuildActivityExpeditionViewModel()
	{
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is GuildActivityCopyItemViewModel copyItemVm)
		{
			SelectCopyItem(copyItemVm);
		}
		else
		{
			if (!(obj is KnapsackItemViewModel knapsackItemViewModel))
			{
				return;
			}
			if (knapsackItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Equipment)
			{
				ArmourPopupViewModel userData = new ArmourPopupViewModel(this, (ArmourData)knapsackItemViewModel.PropDataBase);
				openWindowRequest.Raise(new OpenViewArg(typeof(ArmourPopupSampleView), userData));
				return;
			}
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}

	public GuildActivityExpeditionViewModel(OptionBase parent, GuildActivityItemViewModel itemViewModel, CopyData selCopyData = null)
	{
		base.parent = parent;
		optRequest = new InteractionRequest<string>();
		optCommand = new SimpleCommand<string>(OnOpt);
		this.itemViewModel = itemViewModel;
		detailViewModel = new CopyItemDetail1ViewModel(this);
		listItems = new List<GuildActivityCopyItemViewModel>();
		listItems.Add(new GuildActivityCopyItemViewModel(this, GuildCopyData.CreateForShow(isFinal: false)));
		for (int i = 0; i < itemViewModel.Data.GuildCopyDatas.Count; i++)
		{
			if (itemViewModel.Data.GuildCopyDatas[i].CopyShowTypeEnum == GAECopyShowTypeEnum.Final)
			{
				listItems.Add(new GuildActivityCopyItemViewModel(this, GuildCopyData.CreateForShow(isFinal: true)));
			}
			GuildActivityCopyItemViewModel guildActivityCopyItemViewModel = new GuildActivityCopyItemViewModel(this, itemViewModel.Data.GuildCopyDatas[i]);
			listItems.Add(guildActivityCopyItemViewModel);
			if (selCopyData == null)
			{
				if (itemViewModel.Data.CurCopyId == itemViewModel.Data.GuildCopyDatas[i].CopyData.Id)
				{
					SelectCopyItem(guildActivityCopyItemViewModel);
				}
			}
			else if (selCopyData.Id == itemViewModel.Data.GuildCopyDatas[i].CopyData.Id)
			{
				SelectCopyItem(guildActivityCopyItemViewModel);
			}
		}
		this.itemViewModel.Data.AddLockStateChange(OnFinish);
	}

	private async void OnOpt(string optName)
	{
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		if ("OnReward".Equals(optName))
		{
			if (curSelectViewModel != null)
			{
				if (!isReward && curSelectViewModel.Data.IsPass)
				{
					await OnReward();
				}
				else
				{
					SetReward();
					optRequest.Raise("ShowRewardPop");
				}
				optCommand.Enabled = true;
			}
		}
		else if ("OnRankAll".Equals(optName))
		{
			OnRankAll();
		}
		else if ("OnRankScore".Equals(optName))
		{
			OnRankScore();
		}
		else if ("OnMulti".Equals(optName))
		{
			OnMulti();
		}
	}

	private async void OnRankScore()
	{
		try
		{
			List<PbUnionMemberRankInfo> list = await Singleton<ServiceSystem>.Instance.GetService<IRankService>().RequestGuildMemberRankData();
			if (list != null)
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(GuildRankPopupWindow), new GuildRankPopupViewModel(this, "公会内最高伤害排行", list)), delegate
				{
					optCommand.Enabled = true;
				});
			}
			else
			{
				optCommand.Enabled = true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("打开排行榜失败！" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private async UniTask OnRankAll()
	{
		try
		{
			int guildCopyRankTypeId = RankDefinition.GetGuildCopyRankTypeId();
			RankViewModel userData = new RankViewModel(this, guildCopyRankTypeId);
			openWindowRequest.Raise(new OpenViewArg(typeof(RankWindow), userData), delegate
			{
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开排行榜失败！" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private void SetReward()
	{
		if (showRewardItemDataList == null)
		{
			showRewardItemDataList = PropHelper.GetPropList(this, curSelectViewModel.Data.RewardIds, curSelectViewModel.Data.RewardTypes, curSelectViewModel.Data.RewardAmounts);
		}
		SetRewardState();
	}

	private void SetRewardState()
	{
		IsReward = curSelectViewModel.Data.IsReward;
		if (showRewardItemDataList != null)
		{
			for (int i = 0; i < showRewardItemDataList.Count; i++)
			{
				showRewardItemDataList[i].IsSelected = curSelectViewModel.Data.IsReward;
			}
		}
	}

	private async UniTask OnReward()
	{
		try
		{
			RewardThings rewardThings = await Singleton<ServiceSystem>.Instance.GetService<IGuildService>().RequestGuildActivityExpeditionReward(curSelectViewModel.Data.CopyData.Id);
			if (rewardThings != null)
			{
				SetRewardState();
				PropGetViewModel userData = new PropGetViewModel(this, rewardThings);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData), delegate
				{
				});
			}
		}
		catch (Exception)
		{
		}
	}

	private void SelectCopyItem(GuildActivityCopyItemViewModel copyItemVm)
	{
		if (copyItemVm == null)
		{
			return;
		}
		if (copyItemVm.Data.IsLock)
		{
			Toast.ShowInfo("讨伐上个Boss后解锁");
		}
		else if (curSelectViewModel != copyItemVm)
		{
			if (curSelectViewModel != null)
			{
				curSelectViewModel.SetSelect(isSelect: false);
			}
			detailViewModel.RefreshData(copyItemVm.Data.CopyData, 0);
			SelectItemViewModel = copyItemVm;
			curSelectViewModel.SetBossNameAndLv();
			BossName = curSelectViewModel.BossNameAndLv;
			curSelectViewModel.SetSelect(isSelect: true);
			IsReward = curSelectViewModel.Data.IsReward;
			showRewardItemDataList = null;
		}
	}

	private async void OnMulti()
	{
		_ = 1;
		try
		{
			optCommand.Enabled = false;
			if (ItemViewModel.Data.IsEntireTimeLock || ItemViewModel.Data.IsEveryTimeLock)
			{
				Toast.ShowInfo("不在开放时间内！");
				optCommand.Enabled = true;
				return;
			}
			Loading loading = await Loading.Show();
			ProtocolRequestResult num = await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().CreateMultiRoom(curSelectViewModel.Data.CopyData);
			loading.Dispose();
			if (num == ProtocolRequestResult.Exception)
			{
				Toast.ShowInfo("打开多人房间失败!");
			}
			optCommand.Enabled = true;
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败！请重试！");
			Log.Error("打开组队界面失败!" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private void OnFinish()
	{
		SettleFinish();
	}

	public async UniTaskVoid SettleFinish()
	{
		if (isCloseView)
		{
			return;
		}
		Loading loading = await Loading.Show();
		try
		{
			await UniTask.WaitForSeconds(1);
			MultiRoomViewModel multiRoomViewModel = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetMultiRoomViewModel();
			if (multiRoomViewModel != null && itemViewModel.Data.IsEveryTimeLock && !itemViewModel.Data.IsEntireTimeLock)
			{
				multiRoomViewModel.ForceLeaveRoom();
				Toast.ShowInfo("不在开放时间内！");
			}
			if (itemViewModel.Data.IsEntireTimeLock)
			{
				multiRoomViewModel?.ForceLeaveRoom();
				Close();
				Toast.ShowInfo("活动已结束！");
			}
		}
		catch (Exception ex)
		{
			Log.Error("关闭界面发生异常" + ex.Message + " / " + ex.StackTrace);
		}
		finally
		{
			loading.DisposeAll();
		}
	}

	public override void Close()
	{
		itemViewModel.Data.RemoveLockStateChange();
		base.Close();
	}
}
