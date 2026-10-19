using ACT.Event;
using ACT.Game.Data;

namespace ACT.Model;

public class SyncBattleMassage : BaseEventContent
{
	public int id;

	public int count;

	public SyncBattleDataType syncType;

	public AchievementSyncInfo syncInfo;
}
