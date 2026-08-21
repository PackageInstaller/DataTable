using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MoneyData : OptionBase
{
	private Dictionary<MoneyEnum, Money> totalMoneys = new Dictionary<MoneyEnum, Money>();

	private long lastEnergyRecoveryTime;

	private Timer autoEnergyTimer;

	private List<RoleMoneyEnum> countMessageList = new List<RoleMoneyEnum> { RoleMoneyEnum.Energy };

	private long addDurationTime;

	public long LastEnergyRecoveryTime => lastEnergyRecoveryTime;

	public long AddDurationTime
	{
		get
		{
			return addDurationTime;
		}
		set
		{
			Set(ref addDurationTime, value, "AddDurationTime");
		}
	}

	public MoneyData()
	{
	}

	public MoneyData(OptionBase parent, UserBaseInfo userBaseInfo)
	{
		base.parent = parent;
		UpdateBaseInfo(userBaseInfo);
	}

	public void UpdateBaseInfo(UserBaseInfo userBaseInfo)
	{
		if (userBaseInfo != null)
		{
			lastEnergyRecoveryTime = userBaseInfo.LastEnergyRecoveryTime;
			SetMoney(MoneyEnum.Coin, (int)userBaseInfo.Gold);
			SetMoney(MoneyEnum.Diamond, (int)userBaseInfo.Diamond);
			SetMoney(MoneyEnum.Voucher, (int)userBaseInfo.Voucher);
			SetMoney(MoneyEnum.Energy, userBaseInfo.Energy);
		}
	}

	private Money InitMoney(MoneyEnum moneyEnum)
	{
		DRMoney dataRow = GameEntry.DataTable.GetDataRow((DRMoney p) => p.PropId == (int)moneyEnum);
		long maxCount = dataRow?.MaxCount ?? (-1);
		long countLimitation = dataRow?.CountLimitation ?? (-1);
		Money money = new Money((int)moneyEnum, 0L, maxCount, countLimitation);
		totalMoneys.Add(moneyEnum, money);
		return money;
	}

	public void AddMoney(MoneyEnum moneyEnum, long count)
	{
		if (!totalMoneys.TryGetValue(moneyEnum, out var value))
		{
			value = InitMoney(moneyEnum);
		}
		if (value == null)
		{
			return;
		}
		value.AddCount(count);
		if (Enum.IsDefined(typeof(RoleMoneyEnum), (int)moneyEnum))
		{
			RoleMoneyEnum roleMoneyEnum = (RoleMoneyEnum)moneyEnum;
			if (countMessageList.Contains(roleMoneyEnum))
			{
				Context.GetApplicationContext().GetService<IMessenger>().Publish(new MoneyMessage(this, roleMoneyEnum, value.Count));
			}
		}
	}

	public void SetMoney(MoneyEnum moneyEnum, long count)
	{
		if (!totalMoneys.TryGetValue(moneyEnum, out var value))
		{
			value = InitMoney(moneyEnum);
		}
		if (value == null)
		{
			return;
		}
		value.SetCount(count);
		if (Enum.IsDefined(typeof(RoleMoneyEnum), (int)moneyEnum))
		{
			RoleMoneyEnum roleMoneyEnum = (RoleMoneyEnum)moneyEnum;
			if (countMessageList.Contains(roleMoneyEnum))
			{
				Context.GetApplicationContext().GetService<IMessenger>().Publish(new MoneyMessage(this, roleMoneyEnum, value.Count));
			}
		}
	}

	public Money GetMoney(MoneyEnum moneyEnum)
	{
		if (totalMoneys.TryGetValue(moneyEnum, out var value))
		{
			return value;
		}
		return InitMoney(moneyEnum);
	}

	public bool CheckAddEnergy(int addEnergy)
	{
		Money money = GetMoney(MoneyEnum.Energy);
		if (money != null)
		{
			return money.Count + addEnergy < money.CountLimitation;
		}
		return false;
	}

	public int GetLeftEnergyAdd()
	{
		Money money = GetMoney(MoneyEnum.Energy);
		return (int)(money.CountLimitation - money.Count);
	}

	public void SetAutoAddEnergyLastTime(long time)
	{
		lastEnergyRecoveryTime = time;
	}

	public async void OpenAutoAddEnergy()
	{
		CloseAutoAddEnergy();
		int durationTime = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.TimeRecoveryPerEnergy, 7) * 60;
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().UpdateRealisticTimer();
		long num = (await Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetServiceTime() - lastEnergyRecoveryTime) % durationTime;
		if (num >= 0)
		{
			addDurationTime = ((durationTime - (int)num < 0) ? 1 : (durationTime - (int)num));
			autoEnergyTimer = Timer.Register(1f, Tick, null, isLooped: true, useRealTime: true);
		}
	}

	private void Tick()
	{
		if (addDurationTime > 0)
		{
			addDurationTime--;
		}
		else
		{
			TickFinish();
		}
	}

	private void TickFinish()
	{
		AutoAddEnergy();
		CloseAutoAddEnergy();
		if (Singleton<OuterSystem>.Instance != null)
		{
			addDurationTime = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.TimeRecoveryPerEnergy, 7) * 60;
			autoEnergyTimer = Timer.Register(1f, Tick, null, isLooped: true, useRealTime: true);
		}
	}

	private void AutoAddEnergy()
	{
		Money money = GetMoney(MoneyEnum.Energy);
		if (money != null && money.Count < money.MaxCount)
		{
			money.AddCount(1L);
			Context.GetApplicationContext().GetService<IMessenger>().Publish(new MoneyMessage(this, RoleMoneyEnum.Energy, money.Count));
		}
	}

	public void CloseAutoAddEnergy()
	{
		if (autoEnergyTimer != null)
		{
			autoEnergyTimer.Cancel();
			autoEnergyTimer = null;
		}
	}

	public override void Close()
	{
		CloseAutoAddEnergy();
		base.Close();
	}
}
