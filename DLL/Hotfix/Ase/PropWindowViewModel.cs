using UnityEngine;

namespace Ase;

public class PropWindowViewModel : PropInfoViewModelBase
{
	private bool _showArmourRank;

	private Color _armourRankColor;

	private string _armourRankText;

	private string _armourTypeIcon = "";

	private bool showOutsideMask2 = true;

	public bool ShowOutsideMask2
	{
		get
		{
			return showOutsideMask2;
		}
		private set
		{
			Set(ref showOutsideMask2, value, "ShowOutsideMask2");
		}
	}

	public bool ShowArmourRank
	{
		get
		{
			return _showArmourRank;
		}
		set
		{
			Set(ref _showArmourRank, value, "ShowArmourRank");
		}
	}

	public Color ArmourRankColor
	{
		get
		{
			return _armourRankColor;
		}
		set
		{
			Set(ref _armourRankColor, value, "ArmourRankColor");
		}
	}

	public string ArmourRankText
	{
		get
		{
			return _armourRankText;
		}
		set
		{
			Set(ref _armourRankText, value, "ArmourRankText");
		}
	}

	public string ArmourTypeIcon
	{
		get
		{
			return _armourTypeIcon;
		}
		set
		{
			Set(ref _armourTypeIcon, value, "ArmourTypeIcon");
		}
	}

	public PropWindowViewModel()
	{
	}

	public PropWindowViewModel(OptionBase parent, bool allowSkipWindow)
	{
		Init(parent, showOutsideMask: true, showOwnCount: true, allowSkipWindow);
		ShowOutsideMask2 = showOutsideMask2;
	}

	public PropWindowViewModel(OptionBase parent, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true, bool showOutsideMask2 = false)
	{
		Init(parent, showOutsideMask, showOwnCount, allowSkipWindow);
		ShowOutsideMask2 = showOutsideMask2;
	}

	public override void RefreshData(PropDataBase data)
	{
		if (data == null)
		{
			return;
		}
		ArmourTypeIcon = "";
		if (data is PropData propData && propData.UseType.Contains(21))
		{
			DREquipmentPacks dataRow = GameEntry.DataTable.GetDataRow<DREquipmentPacks>(data.Id);
			if (dataRow == null || dataRow.Equipments.Count <= 0)
			{
				ShowArmourRank = false;
				return;
			}
			DREquipment dataRow2 = GameEntry.DataTable.GetDataRow<DREquipment>(dataRow.Equipments[0]);
			if (dataRow2 == null)
			{
				ShowArmourRank = false;
				return;
			}
			ShowArmourRank = true;
			ArmourRankColor = EquipSlotNew.RankBgColor(dataRow2.Rarity);
			ArmourRankText = $"R{dataRow2.RankMin}";
			ArmourTypeIcon = $"ArmourEnum_{dataRow2.Position}";
		}
		else
		{
			ShowArmourRank = false;
		}
		base.RefreshData(data);
	}
}
