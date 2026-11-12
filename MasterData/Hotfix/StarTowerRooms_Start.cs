public class StarTowerRooms_Start : StarTowerRoom
{
	public override void EntryRoom()
	{
		base.EntryRoom();
		FRRData.ports.ActiveTeleporter(isOpen: false);
	}
}
