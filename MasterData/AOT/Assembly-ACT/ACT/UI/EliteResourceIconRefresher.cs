using Runtime.UI.CommonComponent;

namespace ACT.UI;

internal static class EliteResourceIconRefresher
{
	public static void Refresh(CommonCoinComponent resource, int itemId)
	{
		if (!(resource == null))
		{
			resource.dontShowDetail = false;
			resource.UseItemIcon = true;
			resource.InitData(itemId, isBagItem: true);
			resource.Init(0);
		}
	}
}
