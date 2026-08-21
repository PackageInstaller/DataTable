#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class ActivityHeroTryViewModel : ActivityViewModelBase
{
	private ActivityHeroTryItemViewModel hero;

	private List<ActivityHeroTryItemViewModel> heroList;

	private ActivityTaskItemData rewardItemViewModel;

	private string heroTitle;

	private string heroDesc;

	private List<PropDataBase> rewardsDisplay;

	private SimpleCommand<string> optCmd;

	private InteractionRequest<string> optRequest;

	public ICommand OptCmd => optCmd;

	public string HeroTitle
	{
		get
		{
			return heroTitle;
		}
		private set
		{
			Set(ref heroTitle, value, "HeroTitle");
		}
	}

	public string HeroDesc
	{
		get
		{
			return heroDesc;
		}
		private set
		{
			Set(ref heroDesc, value, "HeroDesc");
		}
	}

	public ActivityHeroTryItemViewModel Hero
	{
		get
		{
			return hero;
		}
		private set
		{
			Set(ref hero, value, "Hero");
		}
	}

	public List<ActivityHeroTryItemViewModel> HeroList => heroList;

	public IInteractionRequest OptRequest => optRequest;

	public ActivityTaskItemData RewardItemViewModel => rewardItemViewModel;

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ActivityHeroTryItemViewModel heroTryItemVm)
		{
			SelectHeroItem(heroTryItemVm);
		}
		else if (obj is BattleReadyViewModel battleReadyViewModel)
		{
			if (battleReadyViewModel.ReadyType == BattleReadyType.Ready)
			{
				parent.ItemOnClick(battleReadyViewModel);
			}
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("Accept") && optionArg.Obj is ActivityTaskItemData { TaskState: ActivityTaskStateEnum.Accept } activityTaskItemData)
			{
				GetReward(activityTaskItemData);
				activityTaskItemData.ResetCmd();
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			if (knapsackItemViewModel.PropDataBase is ArmourData { EquipmentEnum: EquipmentEnum.SuitBox } armourData)
			{
				SuitBoxPreviewUtil.FillPreviewEntriesIfEmpty(armourData);
				RockPopupViewModel userData = new RockPopupViewModel(this, armourData);
				parent?.ItemOnClick(new OpenViewArg(typeof(RockPopupSampleWindow), userData));
			}
			else
			{
				parent?.ItemOnClick(knapsackItemViewModel);
			}
		}
		else
		{
			parent?.ItemOnClick(obj);
		}
	}

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		base.SetServiceTaskData(taskDataList);
		optCmd = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		DRActivityTry[] dataRows = GameEntry.DataTable.GetDataRows((DRActivityTry p) => p.ActivityTypeId == base.DrActivityType.Id);
		heroList = new List<ActivityHeroTryItemViewModel>();
		if (dataRows != null && dataRows.Length != 0)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				heroList.Add(new ActivityHeroTryItemViewModel(this, dataRows[num]));
			}
		}
		for (int num2 = 0; num2 < heroList.Count; num2++)
		{
			heroList[num2].RewardItem = new ActivityTaskItemData(this, heroList[num2].taskId);
			heroList[num2].RewardItem.SetPropItem(heroList[num2].rewardId);
			ActivityTaskData taskData = GetTaskData(heroList[num2].id);
			if (taskData != null)
			{
				heroList[num2].RewardItem.TaskState = ((taskData.RewardState == 1) ? ActivityTaskStateEnum.Finished : ((taskData.CompleteState != 1) ? ActivityTaskStateEnum.Normal : ActivityTaskStateEnum.Accept));
				heroList[num2].RewardItem.SetItemState(heroList[num2].RewardItem.TaskState);
				heroList[num2].SetRed(heroList[num2].RewardItem.TaskState == ActivityTaskStateEnum.Accept);
			}
		}
		if (heroList.Count > 0)
		{
			SelectHeroItem(heroList[0]);
		}
		else
		{
			rewardItemViewModel = new ActivityTaskItemData(this, 0);
		}
	}

	private void SetHero(ActivityHeroTryItemViewModel item)
	{
		Hero = item;
		HeroTitle = item.heroTitle;
		HeroDesc = item.profile;
	}

	private async void OnOpt(string optName)
	{
		optCmd.Enabled = false;
		try
		{
			if ("OpenPreview".Equals(optName))
			{
				HeroCultivatePreviewViewModel userData = new HeroCultivatePreviewViewModel(parent, hero.Hero.Id, hero.Hero.SkinConfigId);
				parent.ItemOnClick(new OpenViewArg(typeof(HeroCultivatePreviewWindow), userData, delegate
				{
					optCmd.Enabled = true;
				}));
			}
			else if ("OpenDrawcard".Equals(optName))
			{
				Loading loading = await Loading.Show();
				try
				{
					string jumpWindow = Hero.JumpWindow;
					JumpWindowParams jumpWindowParams = new JumpWindowParams(jumpWindow, new List<int> { Hero.JumpConfig });
					bool flag = !string.IsNullOrEmpty(jumpWindow) && (string.Equals(jumpWindow, "OperatingActivityWindow", StringComparison.Ordinal) || string.Equals(jumpWindow, "OpActWindow", StringComparison.Ordinal));
					if (flag && parent != null && !parent.CheckOpen(this, jumpWindowParams))
					{
						optCmd.Enabled = true;
						return;
					}
					UIJumpHelper uIJumpHelper = new UIJumpHelper();
					OptionBase optionBase = (flag ? (parent ?? this) : this);
					OpenViewArg openViewArg = await uIJumpHelper.CreateViewJumpData(jumpWindowParams, optionBase, "ActivityHeroTry", delegate
					{
						optCmd.Enabled = true;
					});
					if (openViewArg != null)
					{
						parent?.ItemOnClick(openViewArg);
					}
					else
					{
						optCmd.Enabled = true;
					}
				}
				finally
				{
					loading.Dispose();
				}
			}
			else if ("OpenTry".Equals(optName))
			{
				CopyData copyData = hero.GetCopyData();
				BattleReadyViewModel userData2 = new BattleReadyViewModel(this, BattleReadyData.CreateByHeroTry(BattleReadyTarget.ActivityHeroTry, copyData.Id, copyData.TeamSeatId));
				parent.ItemOnClick(new OpenViewArg(typeof(BattleReadyWindow), userData2, delegate
				{
					optCmd.Enabled = true;
				}));
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " /" + ex.StackTrace);
			optCmd.Enabled = true;
		}
	}

	private void SelectHeroItem(ActivityHeroTryItemViewModel heroTryItemVm)
	{
		if (heroTryItemVm != null && hero != heroTryItemVm)
		{
			hero?.SetSelect(isSelect: false);
			SetHero(heroTryItemVm);
			hero.SetSelect(isSelect: true);
			SelectRewardItem(hero);
			optRequest.Raise("RefreshHero");
		}
	}

	private void SelectRewardItem(ActivityHeroTryItemViewModel heroTryItem)
	{
		rewardItemViewModel = heroTryItem.RewardItem;
	}

	public override ActivityTaskData OnTaskRateNotify(ActivityTaskRateNotify rateNotify)
	{
		ActivityTaskData activityTaskData = base.OnTaskRateNotify(rateNotify);
		if (activityTaskData != null)
		{
			for (int i = 0; i < heroList.Count; i++)
			{
				if (heroList[i].id == activityTaskData.Id)
				{
					ActivityTaskStateEnum activityTaskStateEnum = ((activityTaskData.RewardState == 1) ? ActivityTaskStateEnum.Finished : ((activityTaskData.CompleteState != 1) ? ActivityTaskStateEnum.Normal : ActivityTaskStateEnum.Accept));
					if ((activityTaskStateEnum != ActivityTaskStateEnum.Normal || (heroList[i].RewardItem.TaskState != ActivityTaskStateEnum.Accept && heroList[i].RewardItem.TaskState != ActivityTaskStateEnum.Finished)) && (activityTaskStateEnum != ActivityTaskStateEnum.Accept || heroList[i].RewardItem.TaskState != ActivityTaskStateEnum.Finished))
					{
						heroList[i].RewardItem.TaskState = activityTaskStateEnum;
					}
					heroList[i].RewardItem.SetItemState(heroList[i].RewardItem.TaskState);
					if (heroList[i].RewardItem.TaskState == ActivityTaskStateEnum.Accept)
					{
						heroList[i].SetRed(isRed: true);
					}
					break;
				}
			}
		}
		return activityTaskData;
	}

	private async void GetReward(ActivityTaskItemData taskItemData)
	{
		Loading loading = await Loading.Show();
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskReward(base.ActivityTypeId, hero.id);
		loading?.Dispose();
		if (activityReward.Result)
		{
			if (!activityReward.RewardEmpty())
			{
				PropGetViewModel obj = new PropGetViewModel(parent, activityReward.Rewards);
				parent.ItemOnClick(obj);
			}
			taskItemData.TaskState = ActivityTaskStateEnum.Finished;
			taskItemData.SetItemState(taskItemData.TaskState);
			hero.SetRed(isRed: false);
			UpdateRed();
		}
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		bool red = false;
		for (int i = 0; i < heroList.Count; i++)
		{
			if (heroList[i].isRed)
			{
				red = true;
				break;
			}
		}
		base.Red = red;
		return base.UpdateRed(notifyParent);
	}
}
