using System.Collections.Generic;

namespace Ase;

public class WeaponData : EquipmentDataBase
{
	private List<int> buffIdList;

	private List<List<float>> buffValue;

	private string effectName;

	private string effectDesc;

	private int weaponRefine;

	private WeaponEnum weaponEnum;

	private int star;

	private string originalIcon = "";

	public string OriginalIcon => originalIcon;

	public WeaponEnum WeaponEnum
	{
		get
		{
			return weaponEnum;
		}
		set
		{
			Set(ref weaponEnum, value, "WeaponEnum");
		}
	}

	public int Star
	{
		get
		{
			return star;
		}
		set
		{
			Set(ref star, value, "Star");
		}
	}

	public List<int> BuffIdList
	{
		get
		{
			return buffIdList;
		}
		set
		{
			Set(ref buffIdList, value, "BuffIdList");
		}
	}

	public List<List<float>> BuffValue
	{
		get
		{
			return buffValue;
		}
		set
		{
			Set(ref buffValue, value, "BuffValue");
		}
	}

	public string EffectName
	{
		get
		{
			return effectName;
		}
		set
		{
			Set(ref effectName, value, "EffectName");
		}
	}

	public string EffectDesc
	{
		get
		{
			return effectDesc;
		}
		set
		{
			Set(ref effectDesc, value, "EffectDesc");
		}
	}

	public int WeaponRefine
	{
		get
		{
			return weaponRefine;
		}
		set
		{
			Set(ref weaponRefine, value, "WeaponRefine");
		}
	}

	private WeaponData()
		: base(EquipmentEnum.Weapon)
	{
		buffIdList = new List<int>();
		buffValue = new List<List<float>>();
	}

	private WeaponData(DRWeapon drWeapon)
		: base(drWeapon)
	{
		buffIdList = new List<int>();
		buffValue = new List<List<float>>();
	}

	public static WeaponData CreateEmpty()
	{
		return new WeaponData();
	}

	public static WeaponData CreateWeaponData(EquipBase EquipBase)
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(EquipBase.EquipId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到武器:{EquipBase.EquipId}");
			return null;
		}
		WeaponData weaponData = new WeaponData(dataRow);
		weaponData.LoadDrWeaponData(dataRow);
		weaponData.LoadPbEquipBaseToWeapon(EquipBase);
		weaponData.isOwn = true;
		return weaponData;
	}

	public static WeaponData CreateWeaponData(int weaponId, List<AttributeBase> attributeBaseList, List<EntryBase> entryBaseList, int refine)
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(weaponId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到武器:{weaponId}");
			return null;
		}
		WeaponData weaponData = new WeaponData(dataRow);
		weaponData.LoadDrWeaponData(dataRow);
		weaponData.PbEquipAttributeConvert(attributeBaseList);
		weaponData.PbEquipEntryConvert(entryBaseList);
		weaponData.WeaponRefine = refine;
		weaponData.SetRefine(refine);
		weaponData.isOwn = false;
		return weaponData;
	}

	public static WeaponData CreateWeaponData(int weaponId)
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(weaponId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到武器:{weaponId}");
			return null;
		}
		WeaponData weaponData = new WeaponData(dataRow);
		weaponData.SetOriginLevel(weaponData);
		weaponData.LoadDrWeaponData(dataRow);
		weaponData.isOwn = false;
		return weaponData;
	}

	public void SetOriginLevel(WeaponData weaponData)
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(weaponData.Id);
		weaponData.EquipAttributeList.Clear();
		weaponData.EntryDataList.Clear();
		for (int i = 0; i < dataRow.Attribute.Count; i++)
		{
			DRAffix dataRow2 = GameEntry.DataTable.GetDataTable<DRAffix>().GetDataRow(dataRow.Attribute[i]);
			if (dataRow2 != null)
			{
				weaponData.EquipAttributeList.Add(new EquipAttribute(dataRow2, (float)dataRow.AttributeBase[i] / 10000f));
			}
		}
		for (int j = 0; j < dataRow.EntryId.Count; j++)
		{
			EntryData entryData = new EntryData(dataRow.EntryId[j], dataRow.EntryLevMin[j]);
			if (entryData.DrEntry != null)
			{
				weaponData.EntryDataList.Add(entryData);
			}
		}
		weaponData.Level = 1;
		weaponData.MaxLevel = 20;
		weaponData.star = 0;
		weaponData.SetRefine(1);
	}

	public void SetMaxLevel(WeaponData weaponData)
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(weaponData.Id);
		weaponData.EquipAttributeList.Clear();
		weaponData.EntryDataList.Clear();
		for (int i = 0; i < dataRow.Attribute.Count; i++)
		{
			DRAffix dataRow2 = GameEntry.DataTable.GetDataTable<DRAffix>().GetDataRow(dataRow.Attribute[i]);
			float attributeMax = GetAttributeMax(dataRow.AttributeBase[i], dataRow.AttributeGrow[i], dataRow.AddAttack[i], 80);
			if (dataRow2 != null)
			{
				weaponData.EquipAttributeList.Add(new EquipAttribute(dataRow2, attributeMax / 10000f));
			}
		}
		for (int j = 0; j < dataRow.EntryId.Count; j++)
		{
			EntryData entryData = new EntryData(dataRow.EntryId[j], dataRow.EntryLevMin[j]);
			if (entryData.DrEntry != null)
			{
				weaponData.EntryDataList.Add(entryData);
			}
		}
		weaponData.Level = 80;
		weaponData.MaxLevel = 80;
		weaponData.star = 5;
		weaponData.SetRefine(5);
	}

	public void SetLevel(WeaponData weaponData, int level, int star, int refine)
	{
		DRWeapon dataRow = GameEntry.DataTable.GetDataTable<DRWeapon>().GetDataRow(weaponData.Id);
		weaponData.EquipAttributeList.Clear();
		weaponData.EntryDataList.Clear();
		for (int i = 0; i < dataRow.Attribute.Count; i++)
		{
			DRAffix dataRow2 = GameEntry.DataTable.GetDataTable<DRAffix>().GetDataRow(dataRow.Attribute[i]);
			float attributeByLevelStar = GetAttributeByLevelStar(dataRow.AttributeBase[i], dataRow.AttributeGrow[i], dataRow.AddAttack[i], level, star);
			if (dataRow2 != null)
			{
				weaponData.EquipAttributeList.Add(new EquipAttribute(dataRow2, attributeByLevelStar / 10000f));
			}
		}
		for (int j = 0; j < dataRow.EntryId.Count; j++)
		{
			EntryData entryData = new EntryData(dataRow.EntryId[j], dataRow.EntryLevMin[j]);
			if (entryData.DrEntry != null)
			{
				weaponData.EntryDataList.Add(entryData);
			}
		}
		weaponData.Level = level;
		weaponData.MaxLevel = 80;
		weaponData.star = ((star >= 0) ? star : 0);
		weaponData.SetRefine(refine);
	}

	private float GetAttributeMax(int baseValue, List<int> growList, List<int> attackList, int levelMax)
	{
		float num = 0f;
		int num2 = levelMax;
		num += (float)(baseValue + 19 * growList[0]);
		num2 -= 20;
		for (int i = 1; i < growList.Count; i++)
		{
			if (num2 <= 0)
			{
				break;
			}
			num2 -= 20;
			num += (float)(20 * growList[i]);
		}
		for (int j = 0; j < attackList.Count; j++)
		{
			num += (float)attackList[j];
		}
		return num;
	}

	private float GetAttributeByLevelStar(int baseValue, List<int> growList, List<int> attackList, int levelConfig, int starConfig)
	{
		float num = 0f;
		int num2 = levelConfig;
		if (levelConfig >= 20)
		{
			num += (float)(baseValue + 19 * growList[0]);
			num2 -= 20;
		}
		else
		{
			num += (float)(baseValue + (levelConfig - 1) * growList[0]);
			num2 -= 20;
		}
		if (num2 > 0)
		{
			num += (float)(num2 * growList[0]);
		}
		for (int i = 0; i < starConfig; i++)
		{
			num += (float)attackList[i];
		}
		return num;
	}

	private void LoadDrWeaponData(DRWeapon drWeapon)
	{
		WeaponEnum = drWeapon.WeaponEnum;
		base.Id = drWeapon.Id;
		base.Icon = drWeapon.Icon;
		originalIcon = drWeapon.Icon;
		base.Name = drWeapon.Name;
		base.Rarity = drWeapon.Rarity;
		base.LvInit = drWeapon.LvInit;
		base.Level = drWeapon.LvInit;
		EffectName = drWeapon.WeaponEffectName;
		buffIdList = new List<int>();
		SetRefine(1);
	}

	public void SetWeaponIcon(int sizeType = 3)
	{
		string text = "";
		switch (sizeType)
		{
		case 1:
			text = "Small";
			break;
		case 2:
			text = "Middle";
			break;
		}
		base.Icon = originalIcon + text;
	}

	private void LoadPbEquipBaseToWeapon(EquipBase EquipBase)
	{
		PbEquipAttributeConvert(EquipBase.AttributeBaseList);
		PbEquipEntryConvert(EquipBase.EntryBaseList);
		base.Uid = EquipBase.Uuid;
		base.Exp = EquipBase.Exp;
		Star = EquipBase.Star;
		base.IsLock = EquipBase.Locked;
		base.Level = EquipBase.Level;
		WeaponRefine = EquipBase.Refine;
		SetRefine(WeaponRefine);
	}

	protected override void SetLevel()
	{
		base.MaxExp = GetWeaponNeedGold(base.Rarity, base.Level + 1);
		base.MaxLevel = 0;
		int i;
		for (i = 0; i <= Star; i++)
		{
			DRWeaponGrade[] dataRows = GameEntry.DataTable.GetDataTable<DRWeaponGrade>().GetDataRows((DRWeaponGrade p) => p.NeedStar == i && p.Quality == base.Rarity);
			base.MaxLevel += dataRows.Length;
		}
		UpdateProperty();
	}

	public void SetStarUp(EquipBase equipBase)
	{
		Star = equipBase.Star;
		base.Level = equipBase.Level;
		PbEquipAttributeConvert(equipBase.AttributeBaseList);
		PbEquipEntryConvert(equipBase.EntryBaseList);
		UpdateProperty();
	}

	public void SetRefine(int refine)
	{
		WeaponRefine = refine;
		DRWeapon dataRow = GameEntry.DataTable.GetDataRow<DRWeapon>(base.Id);
		if (dataRow.WeaponEffectId.Count == 0)
		{
			return;
		}
		buffIdList.Clear();
		for (int i = 0; i < dataRow.WeaponEffectId.Count; i++)
		{
			if (dataRow.WeaponEffectId[i].Count >= WeaponRefine)
			{
				buffIdList.Add(dataRow.WeaponEffectId[i][WeaponRefine - 1]);
			}
		}
		buffValue.Clear();
		foreach (List<float> item in dataRow.EffectValue)
		{
			buffValue.Add(item);
		}
		if (dataRow.EffectValue.Count != 0)
		{
			switch (dataRow.EffectValue.Count)
			{
			case 1:
				EffectDesc = string.Format(dataRow.WeaponEffectDesc, BuffValue[0][WeaponRefine - 1]);
				break;
			case 2:
				EffectDesc = string.Format(dataRow.WeaponEffectDesc, BuffValue[0][WeaponRefine - 1], BuffValue[1][WeaponRefine - 1]);
				break;
			case 3:
				EffectDesc = string.Format(dataRow.WeaponEffectDesc, BuffValue[0][WeaponRefine - 1], BuffValue[1][WeaponRefine - 1], BuffValue[2][WeaponRefine - 1]);
				break;
			case 4:
				EffectDesc = string.Format(dataRow.WeaponEffectDesc, BuffValue[0][WeaponRefine - 1], BuffValue[1][WeaponRefine - 1], BuffValue[2][WeaponRefine - 1], BuffValue[3][WeaponRefine - 1]);
				break;
			}
		}
	}

	public static int GetWeaponNeedGold(int rarity, int level)
	{
		return GameEntry.DataTable.GetDataTable<DRWeaponGrade>().GetDataRow((DRWeaponGrade p) => p.Quality == rarity && p.TargetLevel == level)?.NeedGold ?? 0;
	}

	public static int GetWeaponNeedExp(int rarity, int level)
	{
		return GameEntry.DataTable.GetDataTable<DRWeaponGrade>().GetDataRow((DRWeaponGrade p) => p.Quality == rarity && p.TargetLevel == level)?.NeedExp ?? 0;
	}

	public static int GetWeaponDevourExp(int rarity, int level)
	{
		return GameEntry.DataTable.GetDataTable<DRWeaponGrade>().GetDataRow((DRWeaponGrade p) => p.Quality == rarity && p.TargetLevel == level)?.DevourExp ?? 0;
	}

	public override int GetRarity()
	{
		return base.Rarity;
	}
}
