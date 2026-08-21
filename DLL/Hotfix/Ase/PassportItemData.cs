using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class PassportItemData : OptionBase
{
	private int passportId;

	private string icon;

	private string bg;

	private string passportName;

	private bool isReceived;

	private int realPrice;

	private string passportPrice;

	private string passportTip;

	private SimpleCommand buyPassportCmd;

	private List<PassportRewardItemData> passportRewardItemDataList1;

	private List<PassportRewardItemData> passportRewardItemDataList2;

	private DRPassportShow passportShow;

	public int PassportId
	{
		get
		{
			return passportId;
		}
		set
		{
			Set(ref passportId, value, "PassportId");
		}
	}

	public string PassportName
	{
		get
		{
			return passportName;
		}
		set
		{
			Set(ref passportName, value, "PassportName");
		}
	}

	public string PassportPrice
	{
		get
		{
			return passportPrice;
		}
		set
		{
			Set(ref passportPrice, value, "PassportPrice");
		}
	}

	public string Icon
	{
		get
		{
			return icon;
		}
		set
		{
			Set(ref icon, value, "Icon");
		}
	}

	public string Bg
	{
		get
		{
			return bg;
		}
		set
		{
			Set(ref bg, value, "Bg");
		}
	}

	public string PassportTip
	{
		get
		{
			return passportTip;
		}
		set
		{
			Set(ref passportTip, value, "PassportTip");
		}
	}

	public List<PassportRewardItemData> PassportRewardItemDataList1
	{
		get
		{
			return passportRewardItemDataList1;
		}
		set
		{
			Set(ref passportRewardItemDataList1, value, "PassportRewardItemDataList1");
		}
	}

	public List<PassportRewardItemData> PassportRewardItemDataList2
	{
		get
		{
			return passportRewardItemDataList2;
		}
		set
		{
			Set(ref passportRewardItemDataList2, value, "PassportRewardItemDataList2");
		}
	}

	public SimpleCommand BuyPassportCmd => buyPassportCmd;

	public int RealPrice => realPrice;

	public PassportItemData(OptionBase parent, DRPassportShow drPassportShow, int passportGrade)
	{
		base.parent = parent;
		passportId = drPassportShow.Id;
		isReceived = passportGrade >= passportId;
		passportShow = drPassportShow;
		buyPassportCmd = new SimpleCommand(BuyOnClick);
		icon = drPassportShow.Icon;
		bg = drPassportShow.Bg;
		passportName = drPassportShow.PassportName;
		SetPrice(passportGrade);
		passportTip = drPassportShow.Tip;
		passportRewardItemDataList1 = LoadReward(drPassportShow.BuyRewardType, drPassportShow.BuyRewardID, drPassportShow.BuyRewardNum);
		passportRewardItemDataList2 = LoadReward(drPassportShow.UpgradeRewardType, drPassportShow.UpgradeRewardID, drPassportShow.UpgradeRewardNum);
		if (isReceived)
		{
			SetReceived();
		}
		if (passportGrade == 2 && passportId == 3)
		{
			SetPartReceived();
		}
	}

	public override void ItemOnClick(object obj)
	{
		parent?.ItemOnClick(obj);
	}

	private void BuyOnClick()
	{
		if (!isReceived)
		{
			parent?.ItemOnClick(this);
		}
	}

	public void SetReceived()
	{
		buyPassportCmd.Enabled = false;
		PassportPrice = "已购买";
		foreach (PassportRewardItemData item in passportRewardItemDataList1)
		{
			item.IsReceived = true;
		}
	}

	public void SetPartReceived()
	{
		foreach (PassportRewardItemData item in passportRewardItemDataList1)
		{
			if (item.ID == 0)
			{
				break;
			}
			item.IsReceived = true;
		}
	}

	public void SetPrice(int grade)
	{
		if (grade == passportId - 1 && !isReceived)
		{
			PassportPrice = passportShow.UpgradePriceUI;
			realPrice = passportShow.UpgradePrice;
		}
		else
		{
			PassportPrice = passportShow.PriceUI;
			realPrice = passportShow.Price;
		}
		if (grade == 1)
		{
			PassportPrice = passportShow.PriceUI;
			realPrice = passportShow.Price;
		}
	}

	private List<PassportRewardItemData> LoadReward(List<int> typeList, List<int> idList, List<int> countList)
	{
		List<PassportRewardItemData> list = new List<PassportRewardItemData>();
		if (typeList.Count != idList.Count || typeList.Count != countList.Count)
		{
			Toast.ShowError("执照数据配置错误!");
			return list;
		}
		for (int i = 0; i < typeList.Count; i++)
		{
			PassportRewardItemData passportRewardItemData = new PassportRewardItemData(this, isImportant: false, 0);
			passportRewardItemData.SetItem(idList[i], typeList[i], countList[i]);
			passportRewardItemData.IsLock = true;
			list.Add(passportRewardItemData);
		}
		return list;
	}
}
