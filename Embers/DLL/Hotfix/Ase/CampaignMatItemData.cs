using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class CampaignMatItemData : OptionBase
{
	private string _icon = "";

	private PropDataBase _propDataBase;

	public string Icon
	{
		get
		{
			return _icon;
		}
		set
		{
			Set(ref _icon, value, "Icon");
		}
	}

	public PropDataBase PropDataBase
	{
		get
		{
			return _propDataBase;
		}
		set
		{
			Set(ref _propDataBase, value, "PropDataBase");
		}
	}

	public CampaignMatItemData()
	{
	}

	public CampaignMatItemData(OptionBase parent, PropDataBase propDataBase)
	{
		base.parent = parent;
		PropDataBase = propDataBase;
		Icon = propDataBase.Icon;
	}

	public void OnIconBtnClick(Vector3 iconWorldPos)
	{
		if (PropDataBase != null && !PropDataBase.Empty && Enum.IsDefined(typeof(RoleMoneyEnum), PropDataBase.Id))
		{
			parent?.ItemOnClick(new OptionArg(new KeyValuePair<RoleMoneyEnum, Vector3>((RoleMoneyEnum)PropDataBase.Id, iconWorldPos), "OnIconBtnClick"));
		}
	}
}
