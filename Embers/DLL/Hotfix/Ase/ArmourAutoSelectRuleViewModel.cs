using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class ArmourAutoSelectRuleViewModel : OptionBase
{
	private List<TabItemNormalData> tabItemNormalDataList;

	private TabItemNormalData upLimitBtn;

	private int onOff;

	private int rarity;

	public TabItemNormalData UpLimitBtn => upLimitBtn;

	public List<TabItemNormalData> TabItemNormalDataList => tabItemNormalDataList;

	public ArmourAutoSelectRuleViewModel(OptionBase parent, int rarity, int onOff)
	{
		base.parent = parent;
		this.rarity = rarity;
		this.onOff = onOff;
		upLimitBtn = new TabItemNormalData(this, string.Empty, 0, onOff == 1);
		tabItemNormalDataList = new List<TabItemNormalData>();
		tabItemNormalDataList.Add(new TabItemNormalData(this, string.Empty, 1, rarity == 1));
		tabItemNormalDataList.Add(new TabItemNormalData(this, string.Empty, 2, rarity == 2));
		tabItemNormalDataList.Add(new TabItemNormalData(this, string.Empty, 3, rarity == 3));
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is TabItemNormalData tabItemNormalData && (tabItemNormalData.ID == 0 || !tabItemNormalData.IsSelected))
		{
			ButtonOnClick(tabItemNormalData);
		}
	}

	private void ButtonOnClick(TabItemNormalData data)
	{
		if (data.ID == 0)
		{
			data.IsSelected = !data.IsSelected;
			onOff = (data.IsSelected ? 1 : 0);
			return;
		}
		rarity = data.ID;
		foreach (TabItemNormalData tabItemNormalData in tabItemNormalDataList)
		{
			tabItemNormalData.IsSelected = tabItemNormalData.ID == data.ID;
		}
	}

	public void ConfirmOnClick()
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetPlayerData()
			.Uid;
		PlayerPrefs.SetInt($"_{uid}_armourUpgrade_upLimit", onOff);
		PlayerPrefs.SetInt($"_{uid}_armourUpgrade_rarity", rarity);
		parent?.ItemOnClick(this);
		Close();
	}
}
