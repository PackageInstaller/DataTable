using System.Collections.Generic;

namespace Ase;

public class ArmourData : EquipmentDataBase
{
	private ArmourEnum armourEnum;

	private int rank;

	private int typeId;

	private int additionalEntryNum;

	private List<EntryData> additionalEntryList;

	private List<EntryData> backUpEntryPool;

	private int backUpEntryCount;

	private int addEntryStoreId;

	public int AdditionalEntryNum => additionalEntryNum;

	public int BackUpEntryCount => backUpEntryCount;

	public int AddEntryStoreId => addEntryStoreId;

	public List<EntryData> AdditionalEntryList
	{
		get
		{
			return additionalEntryList;
		}
		set
		{
			Set(ref additionalEntryList, value, "AdditionalEntryList");
		}
	}

	public List<EntryData> BackUpEntryPool
	{
		get
		{
			return backUpEntryPool;
		}
		set
		{
			Set(ref backUpEntryPool, value, "BackUpEntryPool");
		}
	}

	public ArmourEnum ArmourEnum
	{
		get
		{
			return armourEnum;
		}
		set
		{
			Set(ref armourEnum, value, "ArmourEnum");
		}
	}

	public int Rank
	{
		get
		{
			return rank;
		}
		set
		{
			Set(ref rank, value, "Rank");
			SetLevel();
		}
	}

	public int TypeId
	{
		get
		{
			return typeId;
		}
		set
		{
			typeId = value;
		}
	}

	private ArmourData()
		: base(EquipmentEnum.Armour)
	{
		Init();
	}

	private ArmourData(DREquipment drEquipment)
		: base(drEquipment)
	{
		Init();
	}

	private ArmourData(DRSuitbox drSuitbox)
		: base(drSuitbox)
	{
		Init();
	}

	private void Init()
	{
		additionalEntryList = new List<EntryData>();
		backUpEntryPool = new List<EntryData>();
	}

	public static ArmourData CreateArmourData(EquipBase equipBase)
	{
		DREquipment dataRow = GameEntry.DataTable.GetDataTable<DREquipment>().GetDataRow(equipBase.EquipId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到明饰:{equipBase.EquipId}");
			return null;
		}
		ArmourData armourData = new ArmourData(dataRow);
		armourData.LoadDrArmourData(dataRow);
		armourData.LoadPbEquipBaseToArmour(equipBase);
		armourData.SetRegularEntry(dataRow);
		armourData.isOwn = true;
		return armourData;
	}

	public static ArmourData CreateArmourData(int equipId, List<AttributeBase> attributeBaseList, List<EntryBase> entryBaseList)
	{
		DREquipment dataRow = GameEntry.DataTable.GetDataTable<DREquipment>().GetDataRow(equipId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到明饰:{equipId}");
			return null;
		}
		ArmourData armourData = new ArmourData(dataRow);
		armourData.LoadDrArmourData(dataRow);
		armourData.PbEquipAttributeConvert(attributeBaseList);
		armourData.SetAdditionalEntryList(entryBaseList);
		armourData.SetRegularEntry(dataRow);
		armourData.isOwn = false;
		return armourData;
	}

	public static ArmourData CreateSuitBox(EquipBase equipBase)
	{
		DRSuitbox dataRow = GameEntry.DataTable.GetDataRow<DRSuitbox>(equipBase.EquipId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到护石:{equipBase.EquipId}");
			return null;
		}
		ArmourData armourData = new ArmourData(dataRow);
		armourData.LoadDrSuitBoxData(dataRow, haveMainEntry: true);
		if (!armourData.LoadPbEquipBaseToArmour(equipBase))
		{
			return null;
		}
		armourData.isOwn = true;
		return armourData;
	}

	public static ArmourData CreateSuitBox(int equipId, List<AttributeBase> attributeBaseList, List<EntryBase> entryBaseList)
	{
		DRSuitbox dataRow = GameEntry.DataTable.GetDataRow<DRSuitbox>(equipId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到护石:{equipId}");
			return null;
		}
		ArmourData armourData = new ArmourData(dataRow);
		armourData.LoadDrSuitBoxData(dataRow, haveMainEntry: true);
		if (attributeBaseList.Count > 0)
		{
			EntryData entryData = new EntryData(attributeBaseList[0].Id, (int)attributeBaseList[0].Value);
			if (entryData.IsRealData)
			{
				armourData.EntryDataList.Add(entryData);
			}
		}
		armourData.SetAdditionalEntryList(entryBaseList);
		armourData.isOwn = false;
		if (armourData.EntryDataList.Count != 0)
		{
			return armourData;
		}
		return null;
	}

	public static ArmourData CreateArmourData(int equipId)
	{
		DREquipment dataRow = GameEntry.DataTable.GetDataTable<DREquipment>().GetDataRow(equipId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到明饰:{equipId}");
			return null;
		}
		ArmourData armourData = new ArmourData(dataRow);
		armourData.LoadDrArmourData(dataRow);
		armourData.isOwn = false;
		armourData.SetRegularEntry(dataRow);
		return armourData;
	}

	public static ArmourData CreateSuitBox(int equipId)
	{
		DRSuitbox dataRow = GameEntry.DataTable.GetDataTable<DRSuitbox>().GetDataRow(equipId);
		if (dataRow == null)
		{
			Toast.ShowError($"未找到护石:{equipId}");
			return null;
		}
		ArmourData armourData = new ArmourData(dataRow);
		armourData.LoadDrSuitBoxData(dataRow, haveMainEntry: false);
		armourData.isOwn = false;
		return armourData;
	}

	public static ArmourData CreateEmpty()
	{
		return new ArmourData();
	}

	private void LoadDrArmourData(DREquipment drEquipment)
	{
		ArmourEnum = drEquipment.ArmourEnum;
		base.Id = drEquipment.Id;
		base.Icon = drEquipment.Icon;
		base.Name = drEquipment.Name;
		base.Rarity = drEquipment.Rarity;
		base.LvInit = drEquipment.LvInit;
		base.Level = drEquipment.LvInit;
		TypeId = drEquipment.TypeId;
		Rank = drEquipment.RankMin;
		base.MaxLevel = drEquipment.LvMax;
		additionalEntryNum = drEquipment.EntryNum;
		base.Description = drEquipment.Desc.Replace("\\n", "\n");
		base.PropTypeEnum = PropTypeEnum.Equipment;
		backUpEntryCount = drEquipment.PreEntryNum;
		addEntryStoreId = drEquipment.ExEntryStore;
	}

	private void LoadDrSuitBoxData(DRSuitbox drSuitbox, bool haveMainEntry)
	{
		ArmourEnum = ArmourEnum.Rock;
		base.Id = drSuitbox.Id;
		base.Icon = (haveMainEntry ? drSuitbox.Icon : drSuitbox.PreIcon);
		base.Name = drSuitbox.Name;
		base.Rarity = drSuitbox.Rarity;
		base.LvInit = 0;
		base.Level = 0;
		Rank = drSuitbox.Rank;
		base.Description = drSuitbox.Desc.Replace("\\n", "\n");
		base.PropTypeEnum = PropTypeEnum.SuitBox;
	}

	private void SetAdditionalEntryList(List<EntryBase> entryBaseList)
	{
		for (int i = 0; i < entryBaseList.Count; i++)
		{
			EntryData entryData = new EntryData(entryBaseList[i].Id, entryBaseList[i].Level);
			if (entryData.IsRealData)
			{
				AdditionalEntryList.Add(entryData);
			}
		}
	}

	public void SetAdditionalEntryList(List<EntryData> entryDataList)
	{
		AdditionalEntryList = entryDataList;
	}

	public void SetBackUpEntryList(List<EntryBase> backUpEntryList)
	{
		BackUpEntryPool.Clear();
		foreach (EntryBase backUpEntry in backUpEntryList)
		{
			EntryData item = new EntryData(backUpEntry.Id, backUpEntry.Level);
			BackUpEntryPool.Add(item);
		}
	}

	private void SetRegularEntry(DREquipment drEquipment)
	{
		if (drEquipment.Regular == null || drEquipment.RegularLv == null)
		{
			return;
		}
		if (drEquipment.Regular.Count != drEquipment.RegularLv.Count)
		{
			Toast.ShowError($"明饰Id:{base.Id}的固定词条ID等级配置异常!");
			return;
		}
		for (int i = 0; i < drEquipment.Regular.Count; i++)
		{
			EntryData entryData = new EntryData(drEquipment.Regular[i], drEquipment.RegularLv[i]);
			entryData.IsFixed = true;
			if (entryData.IsRealData)
			{
				base.EntryDataList.Add(entryData);
			}
		}
	}

	private bool LoadPbEquipBaseToArmour(EquipBase equipBase)
	{
		if (equipBase.Type == 2)
		{
			PbEquipAttributeConvert(equipBase.AttributeBaseList);
		}
		if (equipBase.Type == 2)
		{
			SetBackUpEntryList(equipBase.BackUpEntryList);
		}
		if (equipBase.Type == 16 && equipBase.AttributeBaseList.Count > 0)
		{
			EntryData entryData = new EntryData(equipBase.AttributeBaseList[0].Id, (int)equipBase.AttributeBaseList[0].Value);
			if (!entryData.IsRealData)
			{
				return false;
			}
			base.EntryDataList.Add(entryData);
		}
		SetAdditionalEntryList(equipBase.EntryBaseList);
		base.Uid = equipBase.Uuid;
		base.Exp = equipBase.Exp;
		if (equipBase.Type == 2)
		{
			Rank = equipBase.Rank;
		}
		base.IsLock = equipBase.Locked;
		base.Level = equipBase.Level;
		return true;
	}

	protected override void SetLevel()
	{
		if (Rank != 0)
		{
			base.MaxExp = GetArmourExp(base.Rarity, base.Level + 1, Rank);
			UpdateProperty();
		}
	}

	public EquipAttribute GetMainAttribute()
	{
		if (base.EquipAttributeList.Count > 0)
		{
			return base.EquipAttributeList[0];
		}
		return null;
	}

	public List<EquipAttribute> GetSubAttribute()
	{
		List<EquipAttribute> list = new List<EquipAttribute>();
		if (base.EquipAttributeList.Count > 1)
		{
			for (int i = 1; i < base.EquipAttributeList.Count; i++)
			{
				list.Add(base.EquipAttributeList[i]);
			}
		}
		return list;
	}

	public List<EntryData> GetAllEntry()
	{
		List<EntryData> list = new List<EntryData>();
		list.AddRange(base.EntryDataList);
		list.AddRange(AdditionalEntryList);
		return list;
	}

	public static int GetArmourExp(int rarity, int targetLevel, int rank)
	{
		return GameEntry.DataTable.GetDataTable<DREquipGrade>().GetDataRow((DREquipGrade p) => p.Quality == rarity && p.TargetLevel == targetLevel && p.Rank == rank)?.NeedExp ?? 0;
	}

	public static int GetArmourProvideExp(int rarity, int level, int rank)
	{
		return GameEntry.DataTable.GetDataTable<DREquipGrade>().GetDataRow((DREquipGrade p) => p.Quality == rarity && p.TargetLevel == level && p.Rank == rank)?.DevourExp ?? 0;
	}

	public static int GetArmourProvideGold(int rarity, int level, int rank)
	{
		return GameEntry.DataTable.GetDataTable<DREquipGrade>().GetDataRow((DREquipGrade p) => p.Quality == rarity && p.TargetLevel == level && p.Rank == rank)?.DevourGold ?? 0;
	}

	public static int GetArmourNeedGold(int rarity, int level, int rank)
	{
		return GameEntry.DataTable.GetDataTable<DREquipGrade>().GetDataRow((DREquipGrade p) => p.Quality == rarity && p.TargetLevel == level && p.Rank == rank)?.NeedGold ?? 0;
	}

	public override bool CanDecompose()
	{
		if (base.EquipmentEnum == EquipmentEnum.SuitBox)
		{
			long unselectSuitBox = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().GetUnselectSuitBox();
			if (base.Uid != unselectSuitBox)
			{
				return base.CanDecompose();
			}
			return false;
		}
		return base.CanDecompose();
	}

	public override int GetRarity()
	{
		return base.Rarity;
	}
}
