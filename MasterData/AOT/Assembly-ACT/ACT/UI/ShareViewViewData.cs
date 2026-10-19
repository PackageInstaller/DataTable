using System.Collections.Generic;
using ACT.Utility;

namespace ACT.UI;

public class ShareViewViewData : UIViewData
{
	public class LootItemData
	{
		public int Id;

		public int Num;
	}

	public ShareScreenshotResult Screenshot;

	public List<LootItemData> LootItems;
}
