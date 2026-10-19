using System;
using System.Collections.Generic;

namespace ACT.UI;

public class EquipBuffViewData : UIViewData
{
	public List<EquipBuffItemData> buffInfos;

	public Action closeAction;

	public bool hideCurrentLevel;
}
