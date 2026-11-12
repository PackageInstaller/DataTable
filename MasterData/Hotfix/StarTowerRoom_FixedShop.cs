public class StarTowerRoom_FixedShop : StarTowerRoom
{
	public override void EntryRoom()
	{
		base.EntryRoom();
		FRRData.ports.ActiveTeleporter(isOpen: false);
	}
}
