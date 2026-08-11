using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class CastingDataBase : ViewModelBase
{
	private int castingId;

	private int targetId;

	private List<int> needMaterialId;

	private List<int> needMaterialNum;

	private int needGold;

	private int level;

	public int CastingId => castingId;

	public int TargetId => targetId;

	public List<int> NeedMaterialId => needMaterialId;

	public List<int> NeedMaterialNum => needMaterialNum;

	public int NeedGold => needGold;

	public CastingDataBase()
	{
	}

	public CastingDataBase(DRWeaponCasting drWeaponCasting)
	{
		castingId = drWeaponCasting.Id;
		targetId = drWeaponCasting.WeaponId;
		needMaterialId = drWeaponCasting.NeedMaterialId;
		needMaterialNum = drWeaponCasting.NeedMaterialNum;
		needGold = drWeaponCasting.NeedMoney;
	}

	public CastingDataBase(DREquipmentCasting drEquipmentCasting)
	{
		castingId = drEquipmentCasting.Id;
		targetId = drEquipmentCasting.EquipmentId;
		needMaterialId = drEquipmentCasting.NeedMaterialId;
		needMaterialNum = drEquipmentCasting.NeedMaterialNum;
		needGold = drEquipmentCasting.NeedMoney;
	}
}
