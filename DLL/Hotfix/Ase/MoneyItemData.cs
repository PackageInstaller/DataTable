using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class MoneyItemData : ItemOptionBase
{
	private Money _money;

	private KnapsackPropData _propData;

	private bool _moneyEmpty;

	private bool _propDataEmpty;

	private string icon = "";

	private bool showMaxCount;

	private bool iconBtnEnable;

	private bool getBtnEnable;

	public MoneyUIConfig MoneyUiConfig;

	public Money Money
	{
		get
		{
			return _money;
		}
		set
		{
			Set(ref _money, value, "Money");
		}
	}

	public KnapsackPropData PropData
	{
		get
		{
			return _propData;
		}
		set
		{
			Set(ref _propData, value, "PropData");
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

	public bool ShowMaxCount
	{
		get
		{
			return showMaxCount;
		}
		set
		{
			Set(ref showMaxCount, value, "ShowMaxCount");
		}
	}

	public bool IconBtnEnable
	{
		get
		{
			return iconBtnEnable;
		}
		set
		{
			Set(ref iconBtnEnable, value, "IconBtnEnable");
		}
	}

	public bool GetBtnEnable
	{
		get
		{
			return getBtnEnable;
		}
		set
		{
			Set(ref getBtnEnable, value, "GetBtnEnable");
		}
	}

	public bool MoneyEmpty
	{
		get
		{
			return _moneyEmpty;
		}
		set
		{
			Set(ref _moneyEmpty, value, "MoneyEmpty");
		}
	}

	public bool PropDataEmpty
	{
		get
		{
			return _propDataEmpty;
		}
		set
		{
			Set(ref _propDataEmpty, value, "PropDataEmpty");
		}
	}

	public MoneyItemData()
	{
	}

	public MoneyItemData(OptionBase parent, Money money)
	{
		base.parent = parent;
		Money = money;
		Init(money.MoneyId);
		MoneyEmpty = false;
		PropDataEmpty = true;
	}

	public MoneyItemData(OptionBase parent, KnapsackPropData propData)
	{
		base.parent = parent;
		PropData = propData;
		Init(propData.Id);
		MoneyEmpty = true;
		PropDataEmpty = false;
	}

	private void Init(int id)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(id);
		Icon = ((dataRow == null) ? "" : dataRow.Icon);
		DRMoney dataRow2 = GameEntry.DataTable.GetDataRow((DRMoney p) => p.PropId == id);
		if (dataRow2 != null)
		{
			ShowMaxCount = dataRow2.DisplayMaxCount;
			IconBtnEnable = dataRow2.IconBtnEnable;
			GetBtnEnable = dataRow2.GetBtnEnable;
		}
	}

	public void ResetUiConfig(MoneyUIConfig uiConfig)
	{
		if (uiConfig != null)
		{
			MoneyUiConfig = uiConfig;
			GetBtnEnable = uiConfig.ShowGetBtn;
		}
	}

	public void OnIconBtnClick(Vector3 iconWorldPos)
	{
		if (Money != null && Enum.IsDefined(typeof(RoleMoneyEnum), Money.MoneyId))
		{
			parent?.ItemOnClick(new OptionArg(new KeyValuePair<RoleMoneyEnum, Vector3>((RoleMoneyEnum)Money.MoneyId, iconWorldPos), "OnIconBtnClick"));
		}
		else if (PropData != null && Enum.IsDefined(typeof(RoleMoneyEnum), PropData.Id))
		{
			parent?.ItemOnClick(new OptionArg(new KeyValuePair<RoleMoneyEnum, Vector3>((RoleMoneyEnum)PropData.Id, iconWorldPos), "OnIconBtnClick"));
		}
	}

	public void OnGetBtnClick()
	{
		if (MoneyUiConfig != null)
		{
			parent?.ItemOnClick(new OptionArg(MoneyUiConfig, "OnCustomGetBtnClick"));
		}
		else if (Money != null && Enum.IsDefined(typeof(RoleMoneyEnum), Money.MoneyId))
		{
			parent?.ItemOnClick(new OptionArg((RoleMoneyEnum)Money.MoneyId, "OnGetBtnClick"));
		}
		else if (PropData != null && Enum.IsDefined(typeof(RoleMoneyEnum), PropData.Id))
		{
			parent?.ItemOnClick(new OptionArg((RoleMoneyEnum)PropData.Id, "OnGetBtnClick"));
		}
	}
}
