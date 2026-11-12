public class StarTowerRoom_Welfare : StarTowerRoom
{
	public override void EntryRoom()
	{
		base.EntryRoom();
		FRRData.ports.ActiveTeleporter(isOpen: true);
		LevelStateCallback(HotfixEnum.levelState.Success, (int)(long)levelTime);
	}
}
