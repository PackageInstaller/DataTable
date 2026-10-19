using System;
using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.UI;

public class PopUpRewardOneRowData : UIViewData
{
	public Action callBack;

	public IList<UniversalItem> itemSource;
}
