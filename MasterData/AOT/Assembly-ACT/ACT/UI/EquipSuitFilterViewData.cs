using System;
using ACT.Game.Data;

namespace ACT.UI;

public class EquipSuitFilterViewData : UIViewData
{
	public Character Character { get; set; }

	public int EquipSlotIndex { get; set; }

	public Action CloseAction { get; set; }
}
