using System;

namespace Ase;

public static class MoneyDefinition
{
	public static long GetMoneyCount(int id)
	{
		if (Enum.IsDefined(typeof(RoleMoneyEnum), id))
		{
			return GetMoneyCount((RoleMoneyEnum)id);
		}
		return 0L;
	}

	public static long GetMoneyCount(RoleMoneyEnum roleMoneyEnum)
	{
		if (Enum.IsDefined(typeof(MoneyEnum), (int)roleMoneyEnum))
		{
			return (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetMoneyData()?.GetMoney((MoneyEnum)roleMoneyEnum))?.Count ?? 0;
		}
		return (Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.GetProp((int)roleMoneyEnum)?.Amount).GetValueOrDefault();
	}

	public static void AddMoney(int id, long count)
	{
		if (Enum.IsDefined(typeof(RoleMoneyEnum), id))
		{
			AddMoney((RoleMoneyEnum)id, count);
		}
	}

	public static void AddMoney(RoleMoneyEnum roleMoneyEnum, long count)
	{
		if (Enum.IsDefined(typeof(MoneyEnum), (int)roleMoneyEnum))
		{
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetMoneyData()?.AddMoney((MoneyEnum)roleMoneyEnum, count);
		}
		else
		{
			Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.AddProp((int)roleMoneyEnum, (int)count);
		}
	}

	public static void SetMoney(RoleMoneyEnum roleMoneyEnum, long count)
	{
		if (Enum.IsDefined(typeof(MoneyEnum), (int)roleMoneyEnum))
		{
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetMoneyData()?.SetMoney((MoneyEnum)roleMoneyEnum, count);
		}
		else
		{
			Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.GetProp((int)roleMoneyEnum)?.SetCount((int)count);
		}
	}
}
