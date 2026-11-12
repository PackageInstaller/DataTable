public class StarTowerRoom_OwnerlessWealth_Treasure : StarTowerRoom
{
	public override void EntryRoom()
	{
		base.EntryRoom();
		FRRData.ports.ActiveTeleporter(isOpen: true);
		LevelStateCallback(HotfixEnum.levelState.Success, (int)(long)levelTime);
	}
}
