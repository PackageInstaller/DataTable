#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class KillRewardViewModel : OptionBase
{
	public KillRewardType KillRewardType;

	private List<KnapsackItemViewModel> _rewardList;

	private OptionBase popupvm;

	private string monsterIcon;

	private bool closeKillReward;

	public List<KnapsackItemViewModel> RewardList => _rewardList;

	public bool CloseKillReward => closeKillReward;

	public string MonsterIcon
	{
		get
		{
			return monsterIcon;
		}
		set
		{
			Set(ref monsterIcon, value, "MonsterIcon");
		}
	}

	public KillRewardViewModel(KillRewardType killRewardType, List<int> rewardId, List<int> rewardType, List<int> rewardCount, List<long> uids, string headIcon)
	{
		MonsterIcon = headIcon;
		_rewardList = new List<KnapsackItemViewModel>();
		KillRewardType = killRewardType;
		SetReward(rewardId, rewardType, rewardCount, uids);
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, allowSkipWindow: true, "Tip");
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
				popupvm = openViewArg.UserData as OptionBase;
			}
		}
		else if (obj is KillRewardViewModel)
		{
			closeKillReward = true;
			Close();
		}
	}

	public void SetReward(List<int> ids, List<int> types, List<int> counts, List<long> uids)
	{
		try
		{
			for (int i = 0; i < types.Count; i++)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(types[i], ids[i], counts[i]);
				if (propDataBase == null)
				{
					Toast.ShowError($"任务表，奖励配置，Id为【{ids[i]}】,类型为{types[i]}的道具不存在，请检查！");
					continue;
				}
				if (propDataBase is PropData propData)
				{
					propData.SourceName.Clear();
				}
				if (types[i] == 2)
				{
					propDataBase = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetArmourById(uids[i]);
				}
				else if (types[i] == 5)
				{
					propDataBase = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetWeaponById(uids[i]);
				}
				_rewardList.Add(new KnapsackItemViewModel(this, propDataBase));
			}
		}
		catch (Exception)
		{
			Log.Error("击杀奖励配置异常");
		}
	}

	public override void Dispose()
	{
		base.Dispose();
		if (popupvm != null)
		{
			popupvm.Close();
			popupvm.Dispose();
		}
	}
}
