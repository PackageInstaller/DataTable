#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ActivityEquipViewModel : ActivityChallengeViewModel
{
	private List<HeroEquipItemViewModel> heroEquipItemViewModels;

	private string systemName = "Activity";

	private Sprite bgSprite;

	public List<HeroEquipItemViewModel> HeroEquipItemViewModels => heroEquipItemViewModels;

	public Sprite BgSprite => bgSprite;

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		_pbTaskDataList = taskDataList;
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddDailyUpdateAction(OnDailyUpdate);
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		detailViewModel = new CopyItemDetail1ViewModel(this);
		base.ActivityDesc = _drActivityType.Desc.Replace("\\n", "\n");
		rewardItemViewModels = PropHelper.GetActivityCopyDrop(this, _drActivityType.RewardId);
		CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		List<DRCopyKit> copyKit = GetCopyKit();
		if (copyKit != null || copyKit.Count == 0)
		{
			LoadValidCopy(copyKit, copyVM);
		}
		UpdateRed();
		isInit = true;
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		if (!isInit)
		{
			List<RedPointSave> list = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetRedPoint(systemName, forceLoading: true);
			if (list == null || list.Count == 0)
			{
				base.Red = true;
				list = new List<RedPointSave>();
				list.Add(new RedPointSave
				{
					keyId = _activityTypeId,
					isNew = true
				});
			}
			else
			{
				for (int i = 0; i < list.Count; i++)
				{
					if (list[i].keyId == _activityTypeId)
					{
						base.Red = list[i].isNew;
						return base.UpdateRed(notifyParent);
					}
				}
				list.Add(new RedPointSave
				{
					keyId = _activityTypeId,
					isNew = true
				});
			}
			Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SaveRedPoint(list, systemName);
		}
		Context.GetApplicationContext().GetService<IMessenger>().Publish(new OpActivityMessage(this, OpActivityMessageEnum.TaskStateChanged, _activityTypeId));
		return base.UpdateRed(notifyParent);
	}

	protected override void OnChallengeRed()
	{
	}

	private void CancelRed()
	{
		if (!_red)
		{
			return;
		}
		base.Red = false;
		List<RedPointSave> redPoint = Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetRedPoint(systemName, forceLoading: true);
		for (int i = 0; i < redPoint.Count; i++)
		{
			if (redPoint[i].keyId == _activityTypeId)
			{
				redPoint[i].isNew = false;
			}
		}
		Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().SaveRedPoint(redPoint, systemName);
		UpdateRed();
	}

	private void LoadValidCopy(List<DRCopyKit> copyKits, CopyViewModel copyViewModel)
	{
		copyViewModel.LoadActivityEquipCopys(copyKits, _activityTypeId);
		try
		{
			listItems = new List<CopyItemViewModel>();
			for (int i = 0; i < copyKits.Count; i++)
			{
				CopyData activityEquipCopyById = copyViewModel.GetActivityEquipCopyById(copyKits[i].Id);
				if (activityEquipCopyById == null)
				{
					Log.Error($"活动{_activityTypeId}，找不到Id为{copyKits[i].Id}的副本！");
					continue;
				}
				CopyItemViewModel copyItemViewModel = new CopyItemViewModel(this, activityEquipCopyById);
				copyItemViewModel.SetBossNameAndLv();
				listItems.Add(copyItemViewModel);
				for (int j = 0; j < _pbTaskDataList.Count; j++)
				{
					if (_pbTaskDataList[j].Id == copyKits[i].TaskId)
					{
						copyItemViewModel.AddTaskId(copyKits[i].TaskId);
						if (_pbTaskDataList[j].CompleteState == 1)
						{
							activityEquipCopyById.CopyAccess((int)_pbTaskDataList[j].CompleteValue);
						}
					}
				}
			}
			if (listItems != null && listItems.Count > 0)
			{
				SelectCopyItem(listItems[0]);
				SetDropAndHero();
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取有效副本发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	protected override void RefreshEnviroBuff()
	{
		if (curSelectViewModel.Data.EnviroEnvironIds != null && curSelectViewModel.Data.EnviroEnvironIds.Count != 0)
		{
			int num = curSelectViewModel.Data.EnviroEnvironIds[0];
			EnvironmentModifierDisplayInfo displayInfo = EnvironmentModifierHelper.GetDisplayInfo(num);
			if (displayInfo.EnvironId == 0)
			{
				Log.Error($"EnvironmentModifier表找不到配置Id【{num}】,活动Id:{_activityTypeId},副本ID:{curSelectViewModel.Data.Id}");
				return;
			}
			base.BuffName = displayInfo.Name;
			base.BuffDesc = displayInfo.Desc;
		}
	}

	private List<DRCopyKit> GetCopyKit()
	{
		List<DRCopyKit> list = new List<DRCopyKit>();
		DRCopyKit[] dataRows = GameEntry.DataTable.GetDataRows((DRCopyKit p) => p.ActTypeId == _activityTypeId);
		if (dataRows == null)
		{
			Log.Error("找不到休闲装备本CopyKit的配置！");
			return list;
		}
		int num = 0;
		for (int num2 = 0; num2 < dataRows.Length; num2++)
		{
			num = Math.Max(num, dataRows[num2].LvSort);
		}
		int num3 = 86400;
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		for (int num4 = 0; num4 < dataRows.Length; num4++)
		{
			DRTimeLimit dataRow = GameEntry.DataTable.GetDataRow<DRTimeLimit>(dataRows[num4].TimeLimit);
			if (dataRow != null)
			{
				long severRefreshTimeSpan = Utility.DateTime.GetSeverRefreshTimeSpan(dataRow.StartTime);
				long severRefreshTimeSpan2 = Utility.DateTime.GetSeverRefreshTimeSpan(dataRow.EndTime);
				if (curServerTime < severRefreshTimeSpan2 && curServerTime >= severRefreshTimeSpan && (curServerTime - severRefreshTimeSpan) / num3 % (num + 1) == dataRows[num4].LvSort)
				{
					list.Add(dataRows[num4]);
				}
			}
		}
		return list;
	}

	private async void OnOpt(string optName)
	{
		HideBuffBar();
		if (optCommand.Enabled)
		{
			optCommand.Enabled = false;
			if ("OnMulti".Equals(optName))
			{
				await OnMulti();
			}
			else if ("OpenCopyEquipMain".Equals(optName))
			{
				OpenCopyEquipMain();
			}
		}
	}

	private void OpenCopyEquipMain()
	{
		try
		{
			if (curSelectViewModel == null)
			{
				Toast.ShowInfo("暂无活动副本开放！");
				optCommand.Enabled = true;
				return;
			}
			if (openTag == 1)
			{
				optCommand.Enabled = true;
				return;
			}
			if (_lockState == OpActivityLockState.Locked)
			{
				if (_drActivityType.UnlockCondition == 1)
				{
					Toast.ShowInfo($"传火等级达到{_drActivityType.UnlockConditionValue}开启！");
				}
				else
				{
					Toast.ShowInfo("活动暂未开启！");
				}
				optCommand.Enabled = true;
				return;
			}
			CancelRed();
			SetOpenTag();
			parent.ItemOnClick(new OpenViewArg(typeof(ActivityEquipWindow), this, delegate
			{
				openTag = 0;
			}));
			optCommand.Enabled = true;
		}
		catch (Exception)
		{
			optCommand.Enabled = true;
		}
	}

	private void OnDailyUpdate()
	{
		DailyUpdate();
	}

	private void SetDropAndHero()
	{
		if (detailViewModel == null || detailViewModel.Data == null)
		{
			return;
		}
		DRCopyKit dataRow = GameEntry.DataTable.GetDataRow<DRCopyKit>(detailViewModel.Data.Id);
		detailViewModel.SetDropEquipCopy(dataRow);
		if (heroEquipItemViewModels == null)
		{
			heroEquipItemViewModels = new List<HeroEquipItemViewModel>();
		}
		else
		{
			heroEquipItemViewModels.Clear();
		}
		if (dataRow.AdvCharID != null && dataRow.AdvCharID.Count > 0)
		{
			for (int i = 0; i < dataRow.AdvCharID.Count; i++)
			{
				heroEquipItemViewModels.Add(new HeroEquipItemViewModel(dataRow.AdvCharID[i], i == 0));
			}
		}
	}

	protected override async UniTask DailyUpdate()
	{
		await UniTask.WaitUntil(() => isInit);
		int num = -1;
		if (curSelectViewModel != null && curSelectViewModel.Data != null)
		{
			num = curSelectViewModel.Data.Id;
		}
		CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		List<DRCopyKit> copyKit = GetCopyKit();
		if (copyKit != null && copyKit.Count > 0)
		{
			LoadValidCopy(copyKit, copyVM);
			optRequest.Raise("OnDayRefresh");
		}
		if (curSelectViewModel != null && curSelectViewModel.Data != null)
		{
			if (openTag == 1 && num != curSelectViewModel.Data.Id)
			{
				await SettleFinish();
			}
		}
		else
		{
			CloseWindow();
		}
	}

	public override async UniTask SettleFinish()
	{
		if (isCloseView || Singleton<ServiceSystem>.Instance == null || Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>() == null)
		{
			return;
		}
		try
		{
			await UniTask.WaitForSeconds(1);
			MultiRoomViewModel multiRoomViewModel = Singleton<ServiceSystem>.Instance?.GetService<IMultiRoomService>()?.GetMultiRoomViewModel();
			if (multiRoomViewModel != null && multiRoomViewModel.CopyData != null && !multiRoomViewModel.IsCloseView && multiRoomViewModel.CopyData.ActivityTypeId == _activityTypeId)
			{
				multiRoomViewModel.ForceLeaveRoom();
				Toast.ShowInfo("当前副本已结束！");
			}
			if (_leftActivityTime != -1 && _leftActivityTime <= 0)
			{
				if (multiRoomViewModel != null && multiRoomViewModel.CopyData != null && !multiRoomViewModel.IsCloseView && multiRoomViewModel.CopyData.ActivityTypeId == _activityTypeId)
				{
					multiRoomViewModel.ForceLeaveRoom();
				}
				Toast.ShowInfo("活动已结束！");
			}
		}
		catch (Exception ex)
		{
			Log.Error("关闭界面发生异常" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public void SetBgSprite(Sprite bgSprite)
	{
		this.bgSprite = bgSprite;
	}

	public void RemoveBgSprite()
	{
		bgSprite = null;
	}
}
