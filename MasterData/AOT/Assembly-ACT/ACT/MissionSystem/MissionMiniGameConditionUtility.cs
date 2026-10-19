using ACT.UI;
using Fundamental;

namespace ACT.MissionSystem;

internal static class MissionMiniGameConditionUtility
{
	public static bool IsCurrentInBattleMain()
	{
		if (!Singleton<NewUIManager>.HasInstance())
		{
			return false;
		}
		IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
		if (topActiveUI != null && topActiveUI.UIType == UI_TYPE.UI_BATTLEMAIN)
		{
			return topActiveUI.State == UIState.Opened;
		}
		return false;
	}
}
