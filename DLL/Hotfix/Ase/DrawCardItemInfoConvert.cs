namespace Ase;

public static class DrawCardItemInfoConvert
{
	public static DrawCardItemInfo Convert(int id, int type, bool isNew = false)
	{
		DrawCardItemInfo result = new DrawCardItemInfo
		{
			Type = type,
			Id = id
		};
		switch (type)
		{
		case 4:
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(id);
			if (dataRow != null)
			{
				result.Name = dataRow.Name;
				result.PrefabPath = dataRow.Original + "_0";
				result.IsNew = isNew;
				result.Rarity = dataRow.Rarity;
				result.TypeIcon = $"Hero_Seat_{dataRow.RawSeat}";
			}
			break;
		}
		case 5:
		{
			WeaponData weaponData = WeaponData.CreateWeaponData(id);
			if (weaponData != null)
			{
				result.Name = weaponData.Name;
				result.PrefabPath = "WeaponPrefabs/" + weaponData.Icon;
				result.IsNew = isNew;
				result.Rarity = weaponData.Rarity;
				result.TypeIcon = $"WeaponIcon_{(int)weaponData.WeaponEnum}";
			}
			break;
		}
		}
		return result;
	}
}
