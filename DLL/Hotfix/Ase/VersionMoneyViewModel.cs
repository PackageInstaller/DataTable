using System;
using GameFramework.Runtime;

namespace Ase;

public class VersionMoneyViewModel : ViewModelBase
{
	private int propId;

	private int curCount;

	private int maxCount;

	private int aumCount;

	public int CurCount
	{
		get
		{
			return curCount;
		}
		private set
		{
			Set(ref curCount, value, "CurCount");
		}
	}

	public int MaxCount
	{
		get
		{
			return maxCount;
		}
		private set
		{
			Set(ref maxCount, value, "MaxCount");
		}
	}

	public int AumCount
	{
		get
		{
			return aumCount;
		}
		private set
		{
			Set(ref aumCount, value, "AumCount");
		}
	}

	public int PropId => propId;

	public VersionMoneyViewModel()
	{
	}

	public VersionMoneyViewModel(DRVersionMoney versionMoney)
	{
		try
		{
			propId = versionMoney.PropId;
			MaxCount = versionMoney.Limit;
			CurCount = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(propId)?.Amount ?? 0;
			AumCount = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetAcumCount(propId);
		}
		catch (Exception)
		{
		}
	}

	public void SetAcum(int amount)
	{
		AumCount = amount;
	}

	public void SetCount(int propDataAmount)
	{
		CurCount = propDataAmount;
	}
}
