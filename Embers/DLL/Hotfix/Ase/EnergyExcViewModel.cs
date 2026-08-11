using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class EnergyExcViewModel : OptionBase
{
	private EnergyExcItemViewModel _energyExcItemViewModel;

	private int _costDiamond;

	private List<EnergyExcItemViewModel> _energyExcItemViewModels;

	private SimpleCommand _excConfirmCmd;

	private string autoAddEnergyText;

	private string autoAddAllEnergyText;

	private Timer autoAddEnergyTimer;

	private MoneyData moneyData;

	private long addDurationTime;

	private long addAllDurationTime;

	private int perEnergyCostTime;

	private bool showAddEnergy;

	public EnergyExcItemViewModel EnergyExcItemViewModel
	{
		get
		{
			return _energyExcItemViewModel;
		}
		private set
		{
			Set(ref _energyExcItemViewModel, value, "EnergyExcItemViewModel");
		}
	}

	public List<EnergyExcItemViewModel> EnergyExcItemViewModels
	{
		get
		{
			return _energyExcItemViewModels;
		}
		private set
		{
			Set(ref _energyExcItemViewModels, value, "EnergyExcItemViewModels");
		}
	}

	public int CostDiamond
	{
		get
		{
			return _costDiamond;
		}
		set
		{
			_costDiamond = value;
		}
	}

	public string AutoAddEnergyText
	{
		get
		{
			return autoAddEnergyText;
		}
		private set
		{
			Set(ref autoAddEnergyText, value, "AutoAddEnergyText");
		}
	}

	public string AutoAddAllEnergyText
	{
		get
		{
			return autoAddAllEnergyText;
		}
		private set
		{
			Set(ref autoAddAllEnergyText, value, "AutoAddAllEnergyText");
		}
	}

	public bool ShowAddEnergy
	{
		get
		{
			return showAddEnergy;
		}
		private set
		{
			Set(ref showAddEnergy, value, "ShowAddEnergy");
		}
	}

	public SimpleCommand ExcConfirmCmd => _excConfirmCmd;

	public override void ItemOnClick(object obj)
	{
		if (obj is EnergyExcItemViewModel energyExcItemViewModel)
		{
			if (EnergyExcItemViewModel.PropDataBase.Id != energyExcItemViewModel.PropDataBase.Id)
			{
				if (EnergyExcItemViewModel != null)
				{
					EnergyExcItemViewModel.IsSelected = false;
				}
				EnergyExcItemViewModel = energyExcItemViewModel;
				EnergyExcItemViewModel.IsSelected = true;
			}
		}
		else if (obj is PropUseViewModel)
		{
			SetAutoAddEnergyText();
			RefreshEnergyExcItem();
		}
	}

	public EnergyExcViewModel()
	{
		SetAutoAddEnergyText();
		_excConfirmCmd = new SimpleCommand(ExcSend);
		LoadItem();
		EnergyExcItemViewModel = _energyExcItemViewModels[0];
		_energyExcItemViewModels[0].IsSelected = true;
	}

	private void SetAutoAddEnergyText()
	{
		SetAddEnergyTime();
		CloseTimer();
		if (ShowAddEnergy)
		{
			autoAddEnergyTimer = Timer.Register(1f, SetAutoAddEnergy, null, isLooped: true, useRealTime: true);
		}
	}

	private async void SetAddEnergyTime()
	{
		moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		Money money = moneyData.GetMoney(MoneyEnum.Energy);
		ShowAddEnergy = money.Count < money.MaxCount;
		long num = money.MaxCount - money.Count - 1;
		if (ShowAddEnergy)
		{
			perEnergyCostTime = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.TimeRecoveryPerEnergy, 7) * 60;
			addDurationTime = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetMoneyData()?.AddDurationTime ?? (-1);
			if (addDurationTime >= 0)
			{
				addAllDurationTime = addDurationTime + num * perEnergyCostTime;
				AutoAddEnergyText = Utility.DateTime.GetLeftDateTimeWithLatest(addDurationTime, "mm\\:ss");
				AutoAddAllEnergyText = Utility.DateTime.GetLeftDateTimeOverHour(addAllDurationTime);
			}
		}
	}

	private void SetAutoAddEnergy()
	{
		if (!ShowAddEnergy)
		{
			CloseTimer();
			return;
		}
		if (addDurationTime > 0)
		{
			addDurationTime--;
			addAllDurationTime--;
		}
		else
		{
			addDurationTime = perEnergyCostTime;
			Money money = moneyData.GetMoney(MoneyEnum.Energy);
			ShowAddEnergy = money.Count < money.MaxCount;
			if (!ShowAddEnergy)
			{
				CloseTimer();
			}
		}
		AutoAddEnergyText = Utility.DateTime.GetLeftDateTimeWithLatest(addDurationTime, "mm\\:ss");
		AutoAddAllEnergyText = Utility.DateTime.GetLeftDateTimeOverHour(addAllDurationTime);
	}

	private void CloseTimer()
	{
		if (autoAddEnergyTimer != null)
		{
			autoAddEnergyTimer.Cancel();
			autoAddEnergyTimer = null;
		}
	}

	private void OpenEnergyExcView()
	{
		PropDataBase targetProp = PropDataBase.CreateByType(6, 9003);
		int eX = GameEntry.DataTable.GetDataRow<DRProp>(EnergyExcItemViewModel.PropDataBase.Id).EX1;
		PropUseViewModel userData = new PropUseViewModel(this, targetProp, EnergyExcItemViewModel.PropDataBase, eX);
		openWindowRequest.Raise(new OpenViewArg(typeof(PropUseView), userData));
	}

	private async void ExcSend()
	{
		int constantConfigInt = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.Diamond2EnergyEnergyCount, 40);
		if (EnergyExcItemViewModel.Type == 1)
		{
			if (InquireLeftTime() == 0)
			{
				Toast.ShowInfo("今日可燃魂购买次数已达上限");
				return;
			}
			if (EnergyExcItemViewModel.PropDataBase.Amount < CostDiamond)
			{
				Toast.ShowInfo("熔镀晶不足");
				return;
			}
			if (!Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
				.CheckAddEnergy(constantConfigInt))
			{
				Toast.ShowInfo("可燃魂已达上限！");
				return;
			}
		}
		else if (EnergyExcItemViewModel.Type == 2)
		{
			if (EnergyExcItemViewModel.PropDataBase.Amount < 1)
			{
				Toast.ShowInfo(EnergyExcItemViewModel.PropDataBase.Name + "数量不足");
			}
			else
			{
				OpenEnergyExcView();
			}
			return;
		}
		ExcConfirmCmd.Enabled = false;
		if (EnergyExcItemViewModel.Type == 1)
		{
			string message = $"是否消耗{CostDiamond}熔镀晶补充{constantConfigInt}点可燃魂";
			IAsyncResult<int> asyncResult = AlertDialog.Show("补充可燃魂", message, "同意", "拒绝");
			asyncResult.Callbackable().OnCallback(delegate
			{
				if (asyncResult.Result == -1)
				{
					SendRecoverUserVit();
				}
				else
				{
					ExcConfirmCmd.Enabled = true;
				}
			});
		}
		else
		{
			SendRecoverUserVit();
		}
	}

	private async void SendRecoverUserVit()
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().SendRecoverUserVit(EnergyExcItemViewModel.Type, EnergyExcItemViewModel.PropDataBase.Id);
		loading.Dispose();
		if (num)
		{
			Toast.ShowInfo("可燃魂兑换成功");
			long[] recoverVitCost = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRecoverVitCost();
			if (EnergyExcItemViewModel.Type == 1)
			{
				EnergyExcItemViewModel diamondExcItem = GetEnergyExcItem(9002);
				if (diamondExcItem != null)
				{
					diamondExcItem.PropDataBase.Amount += (int)recoverVitCost[1];
					await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().UpdateAccountLimit();
					string itemDesc = InquireDiamond2Energy(diamondExcItem.PropDataBase);
					diamondExcItem.ItemDesc = itemDesc;
				}
			}
			else
			{
				foreach (EnergyExcItemViewModel energyExcItemViewModel in _energyExcItemViewModels)
				{
					if (energyExcItemViewModel.PropDataBase.Id == recoverVitCost[0])
					{
						energyExcItemViewModel.PropDataBase.Amount += (int)recoverVitCost[1];
					}
				}
			}
		}
		SetAutoAddEnergyText();
		ExcConfirmCmd.Enabled = true;
	}

	private void LoadItem()
	{
		_energyExcItemViewModels = new List<EnergyExcItemViewModel>();
		long moneyCount = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond);
		PropDataBase propDataBase = PropDataBase.CreateByType(1, 9002, (int)moneyCount);
		string desc = InquireDiamond2Energy(propDataBase);
		EnergyExcItemViewModel item = new EnergyExcItemViewModel(this, propDataBase, desc, 1);
		int count = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(Constant.ConstantConfig.PropAddEnergy)?.Amount ?? 0;
		PropDataBase propDataBase2 = PropDataBase.CreateByType(1, Constant.ConstantConfig.PropAddEnergy, count);
		string desc2 = $"恢复<color=#ff9321>{propDataBase2.ExValue}</color>可燃魂";
		EnergyExcItemViewModel item2 = new EnergyExcItemViewModel(this, propDataBase2, desc2, 2);
		_energyExcItemViewModels.Add(item2);
		_energyExcItemViewModels.Add(item);
	}

	private void RefreshEnergyExcItem()
	{
		int amount = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(Constant.ConstantConfig.PropAddEnergy)?.Amount ?? 0;
		GetEnergyExcItem(Constant.ConstantConfig.PropAddEnergy)?.RefreshAmount(amount);
	}

	private EnergyExcItemViewModel GetEnergyExcItem(int id)
	{
		for (int i = 0; i < _energyExcItemViewModels.Count; i++)
		{
			if (_energyExcItemViewModels[i].PropDataBase.Id == id)
			{
				return _energyExcItemViewModels[i];
			}
		}
		return null;
	}

	private string InquireDiamond2Energy(PropDataBase propData1)
	{
		int constantConfigInt = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.Diamond2EnergyEnergyCount, 40);
		int num = InquireLeftTime();
		return $"消耗<color=#ff9321>{CostDiamond}</color>{propData1.Name}，补充<color=#ff9321>{constantConfigInt}</color>可燃魂，今日还可以兑换消耗<color=#ff9321>{num}</color>次\n单日兑换次数越多,所需{propData1.Name}越多。";
	}

	private int InquireLeftTime()
	{
		int diamondBugVitLimit = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetAccountLimitationData()
			.DiamondBugVitLimit;
		CostDiamond = 0;
		int constantConfigInt = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.Diamond2EnergyDailyCount, 5);
		int result = ((constantConfigInt > diamondBugVitLimit) ? (constantConfigInt - diamondBugVitLimit) : 0);
		int id = ((diamondBugVitLimit >= 5) ? 5 : (diamondBugVitLimit + 1));
		CostDiamond = GameEntry.DataTable.GetDataRow<DREnergyConfig>(id).Value;
		return result;
	}

	public override void Close()
	{
		CloseTimer();
		base.Close();
	}
}
