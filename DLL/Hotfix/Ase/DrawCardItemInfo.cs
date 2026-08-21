using System.Collections.Generic;

namespace Ase;

public struct DrawCardItemInfo
{
	public bool IsChoose;

	public List<int> ChooseIds;

	public List<int> ChooseTypes;

	public string Name;

	public int Type;

	public int Id;

	public string PrefabPath;

	public string ConvertImgPath;

	public bool IsNew;

	public int Rarity;

	public string TypeIcon;

	public int ConfigId;

	public int ConfigIndex;

	public int LotteryIndex;

	public List<DrawCardRealResult> DrawCardRealResults;

	public List<DrawCardProduct> DrawCardProducts;

	public int poolId;

	public void SetConvertImg()
	{
		if (!IsNew && Type != 5)
		{
			ConvertImgPath = $"prop970{Id}";
		}
		else
		{
			ConvertImgPath = "empty";
		}
	}

	public void SetLoadObj()
	{
		if (Type == 4)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(Id);
			if (dataRow != null)
			{
				PrefabPath = dataRow.Original + "_0";
			}
		}
		else if (Type == 5)
		{
			WeaponData weaponData = WeaponData.CreateWeaponData(Id);
			if (weaponData != null)
			{
				PrefabPath = "WeaponPrefabs/" + weaponData.Icon;
			}
		}
	}
}
