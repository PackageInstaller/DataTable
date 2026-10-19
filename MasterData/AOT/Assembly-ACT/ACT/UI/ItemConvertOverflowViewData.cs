using System;
using System.Collections.Generic;
using ACT.Config;

namespace ACT.UI;

public class ItemConvertOverflowViewData : UIViewData
{
	public List<ItemKv> Items;

	public Action ConfirmAction;
}
