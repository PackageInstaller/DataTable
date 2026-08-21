using UnityEngine;

namespace Ase;

public class EquipCastingItemData : KnapsackItemViewModel
{
	private CastingDataBase castingDataBase;

	private bool isLocked;

	private int rarity;

	private EquipmentDataBase equipmentDataBase;

	private Color textColor;

	public CastingDataBase CastingDataBase => castingDataBase;

	public EquipmentDataBase EquipmentDataBase => equipmentDataBase;

	public Color TextColor
	{
		get
		{
			return textColor;
		}
		private set
		{
			Set(ref textColor, value, "TextColor");
		}
	}

	public bool IsLocked
	{
		get
		{
			return isLocked;
		}
		private set
		{
			Set(ref isLocked, value, "IsLocked");
		}
	}

	public EquipCastingItemData()
	{
	}

	public EquipCastingItemData(OptionBase parent, PropDataBase data, CastingDataBase castingDataBase)
		: base(parent, data)
	{
		base.parent = parent;
		this.castingDataBase = castingDataBase;
		equipmentDataBase = (EquipmentDataBase)base.PropDataBase;
		SetIsLock(isLock: false);
	}

	public void CastingItemOnClick()
	{
		parent.ItemOnClick(this);
		base.IsSelected = true;
	}

	public void SetIsLock(bool isLock)
	{
		IsLocked = isLock;
		ColorUtility.TryParseHtmlString("#FFFFFF", out var color);
		if (IsLocked)
		{
			color.a = 0.5f;
		}
		else
		{
			color.a = 1f;
		}
		TextColor = color;
	}
}
