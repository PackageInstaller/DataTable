namespace Ase;

public struct FarmData
{
	public int GridId;

	public bool IsInCrease;

	public int State;

	public long HarvestTime;

	public int SeedId;

	public long FruitCount;

	public string Icon;

	public int Rarity;

	public bool FriendIncrease;

	public bool FriendHarvest;

	public void Init()
	{
		long num = HarvestTime - Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		State = ((num > 0) ? 3 : 4);
		DRFarmSeed dataRow = GameEntry.DataTable.GetDataRow<DRFarmSeed>(SeedId);
		if (dataRow != null)
		{
			Icon = dataRow.Icon;
			Rarity = dataRow.Rarity;
		}
	}
}
