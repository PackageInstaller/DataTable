using System;

namespace ACT.UI;

public class EquipLevelUpViewData : UIViewData
{
	public Action closeAction;

	public int TargetEquipUid { get; set; }

	public int GemIndex { get; set; }
}
