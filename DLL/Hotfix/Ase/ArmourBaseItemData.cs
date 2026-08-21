using UnityEngine;

namespace Ase;

public class ArmourBaseItemData : OptionBase
{
	private bool isEmpty;

	private string icon;

	private string mainEntryIcon;

	private int rank;

	private string level;

	private Color rankColor;

	private int rarity;

	private bool isRock;

	public bool IsEmpty => isEmpty;

	public string Icon => icon;

	public int Rank => rank;

	public string Level => level;

	public Color RankColor => rankColor;

	public int Rarity => rarity;

	public bool IsRock => isRock;

	public string MainEntryIcon => mainEntryIcon;

	public ArmourBaseItemData(ArmourData armourData, bool isEmpty = false)
	{
		this.isEmpty = isEmpty;
		if (isEmpty)
		{
			armourData = ArmourData.CreateArmourData(93010101);
		}
		SetConfig(armourData);
	}

	private void SetConfig(ArmourData armourData)
	{
		icon = armourData.Icon;
		rank = armourData.Rank;
		rankColor = EquipSlotNew.RankBgColor(armourData.Rarity);
		level = ((armourData.ArmourEnum == ArmourEnum.Rock) ? "" : $"+{armourData.Level}");
		rarity = armourData.Rarity;
		isRock = armourData.ArmourEnum == ArmourEnum.Rock;
		mainEntryIcon = (isRock ? armourData.GetAllEntry()[0].IconPath : "empty");
	}
}
