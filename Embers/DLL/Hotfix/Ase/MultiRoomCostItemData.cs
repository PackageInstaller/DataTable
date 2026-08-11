using System.Collections.Generic;

namespace Ase;

public class MultiRoomCostItemData : OptionBase
{
	private string rateDesc;

	private float costRate;

	private int dropRate;

	private int unlockType;

	private int unlockNum;

	private bool isSelected;

	private bool isUnlock;

	private string tips;

	private PropDataBase _propDataBase;

	public PropDataBase PropDataBase => _propDataBase;

	public string RateDesc
	{
		get
		{
			return rateDesc;
		}
		set
		{
			Set(ref rateDesc, value, "RateDesc");
		}
	}

	public float CostRate
	{
		get
		{
			return costRate;
		}
		set
		{
			Set(ref costRate, value, "CostRate");
		}
	}

	public int DropRate
	{
		get
		{
			return dropRate;
		}
		set
		{
			Set(ref dropRate, value, "DropRate");
		}
	}

	public int UnlockType
	{
		get
		{
			return unlockType;
		}
		set
		{
			Set(ref unlockType, value, "UnlockType");
		}
	}

	public int UnlockNum
	{
		get
		{
			return unlockNum;
		}
		set
		{
			Set(ref unlockNum, value, "UnlockNum");
		}
	}

	public bool IsSelected
	{
		get
		{
			return isSelected;
		}
		set
		{
			Set(ref isSelected, value, "IsSelected");
		}
	}

	public bool IsUnlock
	{
		get
		{
			return isUnlock;
		}
		set
		{
			Set(ref isUnlock, value, "IsUnlock");
		}
	}

	public MultiRoomCostItemData(OptionBase parent, PropDataBase propDataBase, string desc, float costRate, int dropRate, int unlockType, int unlockNum)
	{
		base.parent = parent;
		_propDataBase = propDataBase;
		RateDesc = desc;
		CostRate = costRate;
		DropRate = dropRate;
		UnlockType = unlockType;
		UnlockNum = unlockNum;
		IsUnlock = GetUnlockState(unlockType, unlockNum, out tips);
	}

	private bool GetUnlockState(int type, int value, out string tips)
	{
		switch (type)
		{
		case 0:
			tips = "";
			return true;
		case 1:
		{
			int valueOrDefault = (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Level).GetValueOrDefault();
			tips = $"传火等级未达到{value}级";
			return valueOrDefault >= value;
		}
		case 2:
		{
			int num2 = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetCurrentCopyOpen() ?? 0;
			List<DRTask> list = GameEntry.DataTable.GetDataRows((DRTask p) => p.CopyOpen == value).ToList();
			string text = ((list.Count > 0) ? list[0].TaskName : string.Empty);
			tips = "完成主线<" + text + ">解锁";
			return num2 > value;
		}
		case 3:
			switch (value)
			{
			case 1:
			{
				int num = Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.GetMonthlyCardLeftDay() ?? (-1);
				tips = "购买提灯养护卡解锁";
				return num >= 0;
			}
			case 2:
			{
				tips = "购买高级执照解锁";
				IPassportService service2 = Singleton<ServiceSystem>.Instance.GetService<IPassportService>();
				if (service2 == null)
				{
					return false;
				}
				return service2.GetPassportInfo()?.Grade >= 2;
			}
			case 3:
			{
				tips = "购买资深执照解锁";
				IPassportService service = Singleton<ServiceSystem>.Instance.GetService<IPassportService>();
				if (service == null)
				{
					return false;
				}
				return service.GetPassportInfo()?.Grade >= 3;
			}
			default:
				tips = "";
				return false;
			}
		default:
			tips = "";
			return false;
		}
	}

	public void OnClick()
	{
		if (IsUnlock)
		{
			parent?.ItemOnClick(this);
		}
		else
		{
			Toast.ShowInfo(tips);
		}
	}
}
