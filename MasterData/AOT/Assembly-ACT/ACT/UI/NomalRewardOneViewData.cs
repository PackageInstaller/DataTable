using System;
using System.Collections.Generic;
using ACT.Game.Data;

namespace ACT.UI;

public class NomalRewardOneViewData : UIViewData
{
	public IList<UniversalItem> itemList;

	public Action onClose;
}
