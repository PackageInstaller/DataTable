namespace Ase;

public class DropData
{
	public int id;

	public int type;

	public string name;

	public long count;

	public string icon;

	public int quality;

	public DropData(int id, long count, int type)
	{
		this.id = id;
		this.count = count;
		this.type = type;
		switch (type)
		{
		case 2:
		{
			DREquipment dataRow2 = GameEntry.DataTable.GetDataRow<DREquipment>(id);
			if (dataRow2 != null)
			{
				name = dataRow2.Name;
				icon = dataRow2.Icon;
				quality = dataRow2.Rarity;
			}
			break;
		}
		case 5:
		{
			DRWeapon dataRow3 = GameEntry.DataTable.GetDataRow<DRWeapon>(id);
			if (dataRow3 != null)
			{
				name = dataRow3.Name;
				icon = dataRow3.Icon;
				quality = dataRow3.Rarity;
			}
			break;
		}
		default:
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(id);
			if (dataRow != null)
			{
				name = dataRow.Name;
				icon = dataRow.Icon;
				quality = dataRow.Quality;
			}
			break;
		}
		}
	}
}
