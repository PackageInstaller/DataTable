using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Model;

namespace ACT.UI;

public class PopupMultiBoxViewData : UIViewData
{
	public GiftPackage selectedGiftPackage;

	public List<ItemKv> rewardItemData;

	public Action onConfirmAction;
}
