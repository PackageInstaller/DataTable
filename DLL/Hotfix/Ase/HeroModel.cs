#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq;
using Ase.ECS;
using GameFramework;
using Sirenix.Utilities;
using UnityEngine;

namespace Ase;

public class HeroModel : NumericalBase
{
	private bool empty;

	private int id;

	private string name;

	private string fgImage;

	private string original;

	private string originalConfig;

	private int rarity;

	private int rawDestinyLevel = 1;

	private string painterName;

	private string cvNames;

	private WeaponEnum weapon;

	private string weaponName;

	private HeroAttributeEnum attribute;

	private HeroLocationEnum location;

	private List<int> label;

	private string faction;

	private int area;

	private string factionIcon;

	private string birthday;

	private string story;

	private string affiliation;

	private string title;

	private int skillCount;

	private List<int> favorGift = new List<int>();

	private List<int> exTrust = new List<int>();

	private int minStarLevel;

	private int maxStarLevel;

	private int totalMaxLevel;

	private int level;

	private bool isSkin;

	private int skinConfigId;

	private string skinConfigName;

	private string skinSuffix;

	private int curMaxLevel;

	private int starLevel;

	private long exp;

	private int feelingLevel = 1;

	private long feelingExp;

	private long feelingExpToNextLevel;

	private string feelingDesc = "";

	private int destinyLevel = 1;

	private List<int> destinyData;

	private WeaponData heldWeapon;

	private Dictionary<int, ArmourData> armours;

	private Dictionary<int, HCTalentData> talentDatas;

	public int SeatId;

	public Dictionary<int, int> UseSkillCameraSkinId;

	public float BaseAttack;

	public List<float> GrowAttack;

	public List<float> BreakAddAttack;

	public float BaseHP;

	public List<float> GrowHP;

	public List<float> BreakAddHP;

	public float BaseDefense;

	public List<float> GrowDefense;

	public List<float> BreakAddDefense;

	public float BaseEnergy;

	public float BaseEnergyRecovery;

	private List<EntryData> talentEntryDataList = new List<EntryData>();

	private List<EntryData> destinyEntryDataList = new List<EntryData>();

	private NumericalProperty talentProperty;

	private NumericalProperty _destinyProperty;

	private NumericalProperty _extraProperty;

	private List<EntryData> _extraEntryDataList = new List<EntryData>();

	private NumericalProperty _totalProperty;

	private Dictionary<int, DRHeroStar> drHeroStars;

	private List<HeroSkillData> skillDatas = new List<HeroSkillData>();

	private Dictionary<int, HCTSkillData> hctSkillDatas = new Dictionary<int, HCTSkillData>();

	private bool _initialized;

	private Dictionary<int, BPData> bpDatas;

	private Dictionary<OuterBuffEnum, List<int>> outerBuffs = new Dictionary<OuterBuffEnum, List<int>>();

	public Dictionary<int, HCTSkillData> HCTSkillDatas => hctSkillDatas;

	public Dictionary<int, HCTalentData> TalentDatas => talentDatas;

	public Dictionary<int, BPData> BpDatas => bpDatas;

	public bool Empty { get; set; }

	public int Id
	{
		get
		{
			return id;
		}
		private set
		{
			Set(ref id, value, "Id");
			InitConstantConfigData();
			GetConfigData(value);
		}
	}

	public string Name
	{
		get
		{
			return name;
		}
		private set
		{
			Set(ref name, value, "Name");
		}
	}

	public string FgImage
	{
		get
		{
			return fgImage;
		}
		private set
		{
			Set(ref fgImage, value, "FgImage");
		}
	}

	public string Original
	{
		get
		{
			return original;
		}
		private set
		{
			Set(ref original, value, "Original");
		}
	}

	public string OriginalConfig => originalConfig;

	public string PainterName
	{
		get
		{
			return painterName;
		}
		private set
		{
			Set(ref painterName, value, "PainterName");
		}
	}

	public string CvNames
	{
		get
		{
			return cvNames;
		}
		set
		{
			Set(ref cvNames, value, "CvNames");
		}
	}

	public int Rarity
	{
		get
		{
			return rarity;
		}
		private set
		{
			Set(ref rarity, value, "Rarity");
		}
	}

	public int RawDestinyLevel
	{
		get
		{
			return rawDestinyLevel;
		}
		private set
		{
			Set(ref rawDestinyLevel, value, "RawDestinyLevel");
		}
	}

	public WeaponEnum Weapon
	{
		get
		{
			return weapon;
		}
		set
		{
			Set(ref weapon, value, "Weapon");
		}
	}

	public string WeaponName
	{
		get
		{
			return weaponName;
		}
		set
		{
			Set(ref weaponName, value, "WeaponName");
		}
	}

	public HeroAttributeEnum Attribute
	{
		get
		{
			return attribute;
		}
		private set
		{
			Set(ref attribute, value, "Attribute");
		}
	}

	public HeroLocationEnum Location
	{
		get
		{
			return location;
		}
		private set
		{
			Set(ref location, value, "Location");
		}
	}

	public List<int> Label
	{
		get
		{
			return label;
		}
		private set
		{
			Set(ref label, value, "Label");
		}
	}

	public string Faction
	{
		get
		{
			return faction;
		}
		private set
		{
			Set(ref faction, value, "Faction");
		}
	}

	public int Area
	{
		get
		{
			return area;
		}
		private set
		{
			Set(ref area, value, "Area");
		}
	}

	public string FactionIcon
	{
		get
		{
			return factionIcon;
		}
		private set
		{
			Set(ref factionIcon, value, "FactionIcon");
		}
	}

	public string Birthday
	{
		get
		{
			return birthday;
		}
		private set
		{
			Set(ref birthday, value, "Birthday");
		}
	}

	public string Story
	{
		get
		{
			return story;
		}
		private set
		{
			Set(ref story, value, "Story");
		}
	}

	public string Affiliation
	{
		get
		{
			return affiliation;
		}
		private set
		{
			Set(ref affiliation, value, "Affiliation");
		}
	}

	public string Title
	{
		get
		{
			return title;
		}
		private set
		{
			Set(ref title, value, "Title");
		}
	}

	public int SkillCount
	{
		get
		{
			return skillCount;
		}
		set
		{
			skillCount = value;
		}
	}

	public List<int> FavorGift
	{
		get
		{
			return favorGift;
		}
		set
		{
			Set(ref favorGift, value, "FavorGift");
		}
	}

	public List<int> ExTrust
	{
		get
		{
			return exTrust;
		}
		set
		{
			Set(ref exTrust, value, "ExTrust");
		}
	}

	public int MinStarLevel
	{
		get
		{
			return minStarLevel;
		}
		set
		{
			Set(ref minStarLevel, value, "MinStarLevel");
		}
	}

	public int MaxStarLevel
	{
		get
		{
			return maxStarLevel;
		}
		set
		{
			Set(ref maxStarLevel, value, "MaxStarLevel");
		}
	}

	public int TotalMaxLevel
	{
		get
		{
			return totalMaxLevel;
		}
		set
		{
			Set(ref totalMaxLevel, value, "TotalMaxLevel");
		}
	}

	public int Level
	{
		get
		{
			return level;
		}
		set
		{
			Set(ref level, value, "Level");
			if (_initialized)
			{
				UpdateProperty();
			}
		}
	}

	public int StarLevel
	{
		get
		{
			return starLevel;
		}
		set
		{
			Set(ref starLevel, value, "StarLevel");
			CurMaxLevel = (DrHeroStars.ContainsKey(value + 1) ? DrHeroStars[value + 1].NeedLv : TotalMaxLevel);
			if (_initialized)
			{
				UpdateProperty();
			}
		}
	}

	public int DestinyLevel
	{
		get
		{
			return destinyLevel;
		}
		private set
		{
			Set(ref destinyLevel, value, "DestinyLevel");
		}
	}

	public List<int> DestinyData
	{
		get
		{
			return destinyData;
		}
		private set
		{
			Set(ref destinyData, value, "DestinyData");
		}
	}

	public long Exp
	{
		get
		{
			return exp;
		}
		set
		{
			Set(ref exp, value, "Exp");
		}
	}

	public int FeelingLevel
	{
		get
		{
			return feelingLevel;
		}
		private set
		{
			Set(ref feelingLevel, value, "FeelingLevel");
			FeelingDesc = GameEntry.DataTable.GetDataRow<DRTrust>(value)?.Name ?? "";
			FeelingExpToNextLevel = GameEntry.DataTable.GetDataRow<DRTrust>(value + 1)?.TrustValue ?? 0;
		}
	}

	public long FeelingExp
	{
		get
		{
			return feelingExp;
		}
		private set
		{
			Set(ref feelingExp, value, "FeelingExp");
		}
	}

	public long FeelingExpToNextLevel
	{
		get
		{
			return feelingExpToNextLevel;
		}
		private set
		{
			Set(ref feelingExpToNextLevel, value, "FeelingExpToNextLevel");
		}
	}

	public string FeelingDesc
	{
		get
		{
			return feelingDesc;
		}
		private set
		{
			Set(ref feelingDesc, value, "FeelingDesc");
		}
	}

	public WeaponData HeldWeapon
	{
		get
		{
			return heldWeapon;
		}
		private set
		{
			Set(ref heldWeapon, value, "HeldWeapon");
		}
	}

	public Dictionary<int, ArmourData> Armours
	{
		get
		{
			if (armours == null)
			{
				armours = new Dictionary<int, ArmourData>();
			}
			return armours;
		}
		private set
		{
			Set(ref armours, value, "Armours");
		}
	}

	public Dictionary<int, DRHeroStar> DrHeroStars
	{
		get
		{
			if (drHeroStars == null)
			{
				DRHeroStar[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroStar p) => p.HeroId == Id);
				if (dataRows != null)
				{
					drHeroStars = dataRows.ToDictionary((DRHeroStar p) => p.TargetStar);
				}
				else
				{
					drHeroStars = new Dictionary<int, DRHeroStar>();
				}
			}
			return drHeroStars;
		}
		private set
		{
			drHeroStars = value;
		}
	}

	public NumericalProperty TalentProperty
	{
		get
		{
			return talentProperty ?? (talentProperty = new NumericalProperty(this));
		}
		private set
		{
			talentProperty = value;
		}
	}

	public NumericalProperty DestinyProperty
	{
		get
		{
			return _destinyProperty ?? (_destinyProperty = new NumericalProperty(this));
		}
		private set
		{
			_destinyProperty = value;
		}
	}

	public NumericalProperty ExtraProperty
	{
		get
		{
			return _extraProperty ?? (_extraProperty = new NumericalProperty(this));
		}
		private set
		{
			_extraProperty = value;
		}
	}

	public NumericalProperty TotalProperty
	{
		get
		{
			if (_totalProperty == null)
			{
				_totalProperty = new NumericalProperty(this);
			}
			return _totalProperty;
		}
		private set
		{
			_totalProperty = value;
		}
	}

	public List<EntryData> TalentEntryDataList => talentEntryDataList;

	public List<EntryData> DestinyEntryDataList => destinyEntryDataList;

	public List<EntryData> ExtraEntryDataList => _extraEntryDataList;

	public List<HeroSkillData> SkillDatas => skillDatas;

	public int CurMaxLevel
	{
		get
		{
			return curMaxLevel;
		}
		set
		{
			Set(ref curMaxLevel, value, "CurMaxLevel");
		}
	}

	public string SkinSuffix
	{
		get
		{
			return skinSuffix;
		}
		private set
		{
			Set(ref skinSuffix, value, "SkinSuffix");
		}
	}

	public bool IsSkin => isSkin;

	public int SkinConfigId => skinConfigId;

	public HeroModel()
	{
		Empty = true;
		_initialized = true;
	}

	public HeroModel(int id, int skinConfigId = 0, int star = 0, int level = 1, long exp = 0L, int feelingLevel = 1, long feelingExp = 0L, Dictionary<int, int> useSkillCameraSkinId = null, WeaponData heldWeapon = null, Dictionary<int, ArmourData> armours = null, Dictionary<int, HCTalentData> talentDatas = null, List<int> seatLevel = null)
	{
		Empty = false;
		Id = id;
		StarLevel = star;
		Level = level;
		Exp = exp;
		HeldWeapon = heldWeapon;
		Armours = armours;
		UseSkillCameraSkinId = useSkillCameraSkinId;
		SetSkin(skinConfigId);
		SetFeelingData(feelingLevel, feelingExp);
		GetTalentDatas(talentDatas);
		UpdateDestinyData(seatLevel);
		InitProperty();
		_initialized = true;
	}

	public HeroModel(int id, int skinConfigId, int level, Dictionary<int, HCTalentData> talentData, List<int> seatLevel, Dictionary<int, BPData> carringBPs)
	{
		Empty = false;
		Id = id;
		StarLevel = 0;
		Level = level;
		Exp = 0L;
		SetSkin(skinConfigId);
		GetTalentDatas(talentData);
		UpdateDestinyData(seatLevel);
		InitProperty();
		_initialized = true;
		AddBPData(carringBPs);
	}

	public HeroModel(int id, int skinConfigId, int starLevel, int level, List<int> seatLevel)
	{
		Id = id;
		StarLevel = starLevel;
		Level = level;
		SetSkin(skinConfigId);
		UpdateDestinyData(seatLevel);
	}

	public HeroModel(int id, int skinConfigId, int starLevel, int level, List<int> seatLevel, PbEquipBase Weapon, List<PbRoleTalent> Talents)
	{
		Id = id;
		StarLevel = starLevel;
		Level = level;
		SetSkin(skinConfigId);
		UpdateDestinyData(seatLevel);
		HeldWeapon = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateWeapon(Weapon);
		talentDatas = new Dictionary<int, HCTalentData>();
		for (int i = 0; i < Talents.Count; i++)
		{
			talentDatas.Add(Talents[i].SkillId, HCTalentData.Create(Talents[i].SkillId, Talents[i].SkillLevel, Talents[i].MaxOrderId));
		}
		UpdateHctSkillDatas();
	}

	public HeroModel(PbNormalRoleInfo hero)
	{
		Id = hero.RoleId;
		StarLevel = hero.Star;
		Level = hero.Level;
		SetSkin(hero.SkinID);
		UpdateDestinyData(hero.SeatLevel);
		HeldWeapon = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateWeapon(hero.Weapon);
		talentDatas = new Dictionary<int, HCTalentData>();
		for (int i = 0; i < hero.Talents.Count; i++)
		{
			talentDatas.Add(hero.Talents[i].SkillId, HCTalentData.Create(hero.Talents[i].SkillId, hero.Talents[i].SkillLevel, hero.Talents[i].MaxOrderId));
		}
		GetTalentDatas(talentDatas);
		SetFeelingData(hero.TrustLevel, hero.Feeling);
		armours = new Dictionary<int, ArmourData>();
		List<PbEquipBase> list = hero.Armours.ToList();
		for (int j = 0; j < list.Count; j++)
		{
			PbEquipBase pbEquipBase = list[j];
			DREquipment dataRow = GameEntry.DataTable.GetDataRow<DREquipment>(pbEquipBase.EquipId);
			if (dataRow != null && dataRow.ArmourEnum != ArmourEnum.Rock)
			{
				armours.Add((int)dataRow.ArmourEnum, Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateArmour(pbEquipBase));
			}
		}
		if (hero.Suitbox != null)
		{
			ArmourData armourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateArmour(hero.Suitbox);
			if (armourData != null)
			{
				armours.Add((int)armourData.ArmourEnum, armourData);
			}
		}
		InitProperty();
		_initialized = true;
	}

	public static HeroModel CreateEmpty()
	{
		return new HeroModel
		{
			affiliation = "",
			SkinSuffix = "",
			name = ""
		};
	}

	public static HeroModel CreateMulti(int id, int skinConfigId, int star = 0, int level = 1, long exp = 0L, Dictionary<int, int> useSkillSkinIds = null, WeaponData heldWeapon = null, Dictionary<int, ArmourData> armours = null, Dictionary<int, HCTalentData> talentDatas = null, List<int> destinyData = null)
	{
		HeroModel heroModel = new HeroModel();
		heroModel.Empty = false;
		heroModel.Id = id;
		heroModel.StarLevel = star;
		heroModel.Level = level;
		heroModel.Exp = exp;
		heroModel.HeldWeapon = heldWeapon;
		heroModel.Armours = armours;
		heroModel.UseSkillCameraSkinId = useSkillSkinIds;
		heroModel.SetSkin(skinConfigId);
		heroModel.GetTalentDatas(talentDatas);
		heroModel.UpdateDestinyData(destinyData);
		heroModel.UpdateTotalProperty();
		heroModel.InitProperty();
		return heroModel;
	}

	public static HeroModel CreatePreview(int id, WeaponData heldWeapon, int skinId)
	{
		HeroModel heroModel = new HeroModel();
		heroModel.Empty = false;
		heroModel.Id = id;
		heroModel.StarLevel = 0;
		heroModel.Level = 1;
		heroModel.Exp = 0L;
		if (heldWeapon == null)
		{
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(id);
			if (dataRow == null)
			{
				return new HeroModel();
			}
			heroModel.HeldWeapon = WeaponData.CreateWeaponData(dataRow.InitialWeapon);
		}
		else
		{
			heroModel.HeldWeapon = heldWeapon;
		}
		heroModel.Armours = null;
		heroModel.GetTalentDatas(null);
		heroModel.UpdateDestinyData(heroModel.rawDestinyLevel, new List<int> { 0 });
		heroModel.UpdateTotalProperty();
		heroModel.InitProperty();
		heroModel.SetSkin(skinId);
		return heroModel;
	}

	public static HeroModel CreateByConfig(int id)
	{
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(id);
		if (dataRow == null)
		{
			return new HeroModel();
		}
		int star = 0;
		int num = 1;
		long num2 = 0L;
		WeaponData weaponData = WeaponData.CreateWeaponData(dataRow.InitialWeapon);
		HeroModel heroModel = new HeroModel(id, dataRow.InitialHeroSkin, star, num, num2, 1, 0L, null, weaponData);
		heroModel.SetSkin(dataRow.InitialHeroSkin);
		return heroModel;
	}

	public static HeroModel CreateByPbData(PbNormalRoleInfo pbData)
	{
		HeroModel result = new HeroModel();
		try
		{
			if (pbData == null)
			{
				return result;
			}
			PbEquipBase pbEquipBase = pbData.Weapon;
			if (pbEquipBase == null)
			{
				Log.Error($"{pbData.RoleId}烬天使未佩戴武魂,请检查！");
				return result;
			}
			IEquipmentService service = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>();
			WeaponData weaponById = service.GetWeaponById(pbEquipBase.Uuid);
			if (weaponById == null)
			{
				Log.Error($"{pbData.RoleId}烬天使未佩戴武魂,请检查！");
				return result;
			}
			Dictionary<long, int> heroHeldEquip = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroHeldEquip();
			if (pbData.RoleId != 0 && !heroHeldEquip.ContainsKey(pbEquipBase.Uuid))
			{
				heroHeldEquip.Add(pbEquipBase.Uuid, pbData.RoleId);
			}
			Dictionary<int, ArmourData> dictionary = new Dictionary<int, ArmourData>();
			List<PbEquipBase> list = pbData.Armours.ToList();
			for (int i = 0; i < list.Count; i++)
			{
				PbEquipBase pbEquipBase2 = list[i];
				DREquipment dataRow = GameEntry.DataTable.GetDataRow<DREquipment>(pbEquipBase2.EquipId);
				if (dataRow != null && dataRow.ArmourEnum != ArmourEnum.Rock)
				{
					ArmourData value = service.GetArmourById(pbEquipBase2.Uuid) ?? service.CreateArmour(pbEquipBase2);
					dictionary.Add((int)dataRow.ArmourEnum, value);
					if (pbData.RoleId != 0 && !heroHeldEquip.ContainsKey(pbEquipBase2.Uuid))
					{
						heroHeldEquip.Add(pbEquipBase2.Uuid, pbData.RoleId);
					}
				}
			}
			PbEquipBase suitbox = pbData.Suitbox;
			if (suitbox != null && GameEntry.DataTable.GetDataRow<DRSuitbox>(suitbox.EquipId) != null)
			{
				ArmourData value2 = service.GetArmourById(suitbox.Uuid) ?? service.CreateArmour(suitbox);
				dictionary.Add(5, value2);
				if (pbData.RoleId != 0 && !heroHeldEquip.ContainsKey(suitbox.Uuid))
				{
					heroHeldEquip.Add(suitbox.Uuid, pbData.RoleId);
				}
			}
			Dictionary<int, HCTalentData> dictionary2 = new Dictionary<int, HCTalentData>();
			for (int j = 0; j < pbData.Talents.Count; j++)
			{
				dictionary2.Add(pbData.Talents[j].SkillId, HCTalentData.Create(pbData.Talents[j].SkillId, pbData.Talents[j].SkillLevel, pbData.Talents[j].MaxOrderId));
			}
			Dictionary<int, int> dictionary3 = new Dictionary<int, int>();
			for (int k = 0; k < pbData.SkillSkinIds.Count; k++)
			{
				dictionary3.Add(pbData.SkillSkinIds[k].Id, pbData.SkillSkinIds[k].Value);
			}
			result = new HeroModel(pbData.RoleId, pbData.SkinID, pbData.Star, pbData.Level, pbData.Exp, pbData.TrustLevel, pbData.Feeling, dictionary3, weaponById, dictionary, dictionary2, pbData.SeatLevel);
		}
		catch (Exception)
		{
		}
		return result;
	}

	public static HeroModel CreateByPreset(DRPresetHeroData presetHeroData, WeaponData heldWeapon)
	{
		HeroModel heroModel = new HeroModel();
		heroModel.Empty = false;
		heroModel.Id = presetHeroData.HeroId;
		heroModel.StarLevel = presetHeroData.HeroStarLv;
		heroModel.Level = presetHeroData.HeroLv;
		heroModel.Exp = 0L;
		heroModel.HeldWeapon = heldWeapon;
		heroModel.Armours = null;
		if (presetHeroData.Attribute != null && presetHeroData.AttributeNum != null && presetHeroData.Attribute.Count == presetHeroData.AttributeNum.Count)
		{
			heroModel.UpdateExtraProperty(presetHeroData.Attribute, presetHeroData.AttributeNum);
		}
		if (presetHeroData.Entry != null && presetHeroData.EntryLev != null && presetHeroData.Entry.Count == presetHeroData.EntryLev.Count)
		{
			heroModel.UpdateExtraEntryData(presetHeroData.Entry, presetHeroData.EntryLev);
		}
		heroModel.SetSkin(presetHeroData.HeroSkin);
		heroModel.GetTalentDatas(presetHeroData.TalentBigLv, presetHeroData.TalentSmallLv);
		heroModel.UpdateDestinyData(presetHeroData.HerosoulLv, new List<int> { 0 });
		heroModel.UpdateTotalProperty();
		heroModel.InitProperty();
		return heroModel;
	}

	public static HeroModel CreateCopy(HeroModel oriHero, WeaponData weaponData, Dictionary<int, ArmourData> armourDatas)
	{
		HeroModel heroModel = new HeroModel();
		heroModel.Id = oriHero.id;
		heroModel.Level = oriHero.Level;
		heroModel.curMaxLevel = oriHero.curMaxLevel;
		heroModel.StarLevel = oriHero.StarLevel;
		heroModel.Exp = oriHero.Exp;
		heroModel.feelingLevel = oriHero.feelingLevel;
		heroModel.feelingExp = oriHero.feelingExp;
		heroModel.feelingExpToNextLevel = oriHero.feelingExpToNextLevel;
		heroModel.feelingDesc = oriHero.feelingDesc;
		heroModel.SetSkin(oriHero.skinConfigId);
		Dictionary<int, HCTalentData> dictionary = new Dictionary<int, HCTalentData>();
		foreach (KeyValuePair<int, HCTalentData> talentData in oriHero.talentDatas)
		{
			dictionary.Add(talentData.Key, HCTalentData.Create(talentData.Value.SkillId, talentData.Value.BigLevel, talentData.Value.SmallOrder));
		}
		heroModel.GetTalentDatas(dictionary);
		List<int> list = new List<int>();
		for (int i = 0; i < oriHero.destinyData.Count; i++)
		{
			list.Add(oriHero.destinyData[i]);
		}
		heroModel.UpdateDestinyData(oriHero.destinyLevel, list);
		heroModel.heldWeapon = weaponData;
		heroModel.armours = armourDatas;
		heroModel.InitProperty();
		heroModel._initialized = true;
		heroModel.Empty = false;
		return heroModel;
	}

	private void InitConstantConfigData()
	{
		DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(17);
		DRConstantConfig dataRow2 = GameEntry.DataTable.GetDataRow<DRConstantConfig>(19);
		DRConstantConfig dataRow3 = GameEntry.DataTable.GetDataRow<DRConstantConfig>(2);
		if (dataRow3 != null)
		{
			TotalMaxLevel = (int)dataRow3.Value;
		}
		if (dataRow2 != null)
		{
			MinStarLevel = (int)dataRow2.Value;
		}
		if (dataRow != null)
		{
			MaxStarLevel = (int)dataRow.Value;
		}
	}

	private void InitProperty()
	{
		numericalProperty.Clear();
		numericalProperty.AddProperty("Hp", this.GetHp());
		numericalProperty.AddProperty("Defence", this.GetDefense());
		numericalProperty.AddProperty("Attack", this.GetAttack());
		numericalProperty.AddProperty("Energy", this.GetBaseEnergy());
		numericalProperty.AddProperty("Crit", this.GetBaseCrit());
		numericalProperty.AddProperty("CritRadio", this.GetCritRadio());
		numericalProperty.AddProperty("EnergyRecoverySpeed", this.GetBaseEnergyRecovery());
		UpdateTotalProperty();
	}

	private void GetConfigData(int id)
	{
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(id);
		DRHeroFile dataRow2 = GameEntry.DataTable.GetDataRow<DRHeroFile>(id);
		if (dataRow != null)
		{
			Name = dataRow.Name;
			FgImage = dataRow.Fgimage;
			originalConfig = dataRow.Original;
			PainterName = dataRow.Painter;
			CvNames = dataRow2?.CV;
			Rarity = dataRow.Rarity;
			RawDestinyLevel = dataRow.RawSeat;
			Weapon = dataRow.WeaponEnum;
			WeaponName = UiConvert.Equip.WeaponEnum2Name[dataRow.WeaponEnum];
			Attribute = dataRow.HeroAttributeEnum;
			Location = dataRow.HeroLocationEnum;
			Label = dataRow.Label;
			Faction = dataRow.Faction;
			Area = dataRow.Area;
			FactionIcon = dataRow.FactionIcon;
			Birthday = dataRow2?.Birthday;
			Story = dataRow2?.Profile;
			Affiliation = dataRow2?.Affiliation;
			Title = dataRow.Title;
			SkillCount = dataRow.SkillCount;
			FavorGift = dataRow.FavorGift;
			ExTrust = dataRow.ExTrust;
			BaseAttack = dataRow.BaseAttack;
			GrowAttack = dataRow.GrowAttack;
			BreakAddAttack = dataRow.AddAttack;
			BaseHP = dataRow.BaseHP;
			GrowHP = dataRow.GrowHP;
			BreakAddHP = dataRow.AddHp;
			BaseDefense = dataRow.BaseDefense;
			GrowDefense = dataRow.GrowDefense;
			BreakAddDefense = dataRow.AddDefense;
			BaseEnergy = dataRow.BaseEnergy;
			BaseEnergyRecovery = dataRow.BaseEnergyRecovery;
		}
	}

	public void Replace(HeroModel newHero)
	{
		try
		{
			Level = newHero.Level;
			curMaxLevel = newHero.curMaxLevel;
			StarLevel = newHero.StarLevel;
			Exp = newHero.Exp;
			FeelingLevel = newHero.feelingLevel;
			FeelingExp = newHero.feelingExp;
			FeelingExpToNextLevel = newHero.feelingExpToNextLevel;
			FeelingDesc = newHero.feelingDesc;
			List<int> list = new List<int>();
			for (int i = 0; i < newHero.destinyData.Count; i++)
			{
				list.Add(newHero.destinyData[i]);
			}
			UpdateDestinyData(newHero.destinyLevel, list);
			foreach (KeyValuePair<int, HCTalentData> talentData in newHero.talentDatas)
			{
				talentDatas[talentData.Key].Replace(talentData.Value);
			}
			GetTalentDatas(talentDatas);
			HeldWeapon = newHero.heldWeapon;
			armours.Clear();
			foreach (KeyValuePair<int, ArmourData> armour in newHero.armours)
			{
				armours.Add(armour.Key, armour.Value);
			}
			UpdateTotalProperty();
		}
		catch (Exception)
		{
		}
	}

	public void RefreshBattleProperty()
	{
	}

	public void UpdateProperty()
	{
		numericalProperty.Numericals["Hp"] = this.GetHp();
		numericalProperty.Numericals["Defence"] = this.GetDefense();
		numericalProperty.Numericals["Attack"] = this.GetAttack();
		numericalProperty.Numericals["Energy"] = this.GetBaseEnergy();
		numericalProperty.Numericals["Crit"] = this.GetBaseCrit();
		numericalProperty.Numericals["CritRadio"] = this.GetCritRadio();
		numericalProperty.Numericals["EnergyRecoverySpeed"] = this.GetBaseEnergyRecovery();
		UpdateTotalProperty();
	}

	public void UpdateDestinyData(List<int> seatLevel)
	{
		HeroModelExtension.AnalysisDestinyData(seatLevel, out var num, out var list);
		DestinyLevel = num;
		DestinyData = list;
		UpdateDestinyProperty();
		UpdateHctSkillDatas();
	}

	public void UpdateDestinyData(int level, List<int> destinyData)
	{
		DestinyLevel = level;
		DestinyData = destinyData;
		UpdateDestinyProperty();
		UpdateHctSkillDatas();
	}

	private void UpdateDestinyProperty()
	{
		DestinyProperty.Clear();
		if (DestinyLevel > 1)
		{
			for (int i = RawDestinyLevel + 1; i <= DestinyLevel; i++)
			{
				int targetSeat = i;
				DRHeroSeat dataRow = GameEntry.DataTable.GetDataRow((DRHeroSeat p) => p.HeroId == Id && p.TargetSeat == targetSeat);
				if (dataRow != null)
				{
					for (int num = 0; num < dataRow.Prop1.Count; num++)
					{
						DestinyProperty.AddProperty(GetAffixKeyById(dataRow.Prop1[num]), (dataRow.PropValue1.Count > num) ? dataRow.PropValue1[num] : 0f);
					}
					for (int num2 = 0; num2 < dataRow.Prop2.Count; num2++)
					{
						DestinyProperty.AddProperty(GetAffixKeyById(dataRow.Prop2[num2]), (dataRow.PropValue2.Count > num2) ? dataRow.PropValue2[num2] : 0f);
					}
					for (int num3 = 0; num3 < dataRow.Prop3.Count; num3++)
					{
						DestinyProperty.AddProperty(GetAffixKeyById(dataRow.Prop3[num3]), (dataRow.PropValue3.Count > num3) ? dataRow.PropValue3[num3] : 0f);
					}
					for (int num4 = 0; num4 < dataRow.Prop4.Count; num4++)
					{
						DestinyProperty.AddProperty(GetAffixKeyById(dataRow.Prop4[num4]), (dataRow.PropValue4.Count > num4) ? dataRow.PropValue4[num4] : 0f);
					}
					for (int num5 = 0; num5 < dataRow.UpProp.Count; num5++)
					{
						DestinyProperty.AddProperty(GetAffixKeyById(dataRow.UpProp[num5]), (dataRow.UpPropValue.Count > num5) ? dataRow.UpPropValue[num5] : 0f);
					}
				}
			}
		}
		DRHeroSeat dataRow2 = GameEntry.DataTable.GetDataRow((DRHeroSeat p) => p.HeroId == Id && p.TargetSeat == DestinyLevel + 1);
		if (dataRow2 != null)
		{
			int num6 = 0;
			for (int num7 = 0; num7 < DestinyData.Count && DestinyData[num7] == 1; num7++)
			{
				num6++;
			}
			if (num6 > 0)
			{
				for (int num8 = 0; num8 < dataRow2.Prop1.Count; num8++)
				{
					DestinyProperty.AddProperty(GetAffixKeyById(dataRow2.Prop1[num8]), (dataRow2.PropValue1.Count > num8) ? dataRow2.PropValue1[num8] : 0f);
				}
			}
			if (num6 > 1)
			{
				for (int num9 = 0; num9 < dataRow2.Prop1.Count; num9++)
				{
					DestinyProperty.AddProperty(GetAffixKeyById(dataRow2.Prop2[num9]), (dataRow2.PropValue2.Count > num9) ? dataRow2.PropValue2[num9] : 0f);
				}
			}
			if (num6 > 2)
			{
				for (int num10 = 0; num10 < dataRow2.Prop1.Count; num10++)
				{
					DestinyProperty.AddProperty(GetAffixKeyById(dataRow2.Prop3[num10]), (dataRow2.PropValue3.Count > num10) ? dataRow2.PropValue3[num10] : 0f);
				}
			}
			if (num6 > 3)
			{
				for (int num11 = 0; num11 < dataRow2.Prop1.Count; num11++)
				{
					DestinyProperty.AddProperty(GetAffixKeyById(dataRow2.Prop4[num11]), (dataRow2.PropValue4.Count > num11) ? dataRow2.PropValue4[num11] : 0f);
				}
			}
		}
		if (_initialized)
		{
			UpdateProperty();
		}
	}

	private string GetAffixKeyById(int affixId)
	{
		DRAffix dataRow = GameEntry.DataTable.GetDataRow<DRAffix>(affixId);
		if (dataRow == null)
		{
			Toast.ShowError($"Affix表找不到配置,Id:【{affixId}】");
			Log.Error($"Affix表找不到配置,Id:【{affixId}】");
			return string.Empty;
		}
		return dataRow.AffixKey;
	}

	public void UpdateTotalProperty()
	{
		TotalProperty.Clear();
		TotalProperty = this.GetHeroTotalProperty();
	}

	public void SetEquipment(EquipmentDataBase newEquipModel, EquipmentEnum equipType, ArmourEnum armourEnum)
	{
		if (equipType == EquipmentEnum.Weapon)
		{
			HeldWeapon = (WeaponData)newEquipModel;
		}
		else
		{
			Armours[(int)armourEnum] = (ArmourData)newEquipModel;
		}
		UpdateTotalProperty();
	}

	public void SetFeelingData(int feelingLev, long feelingEx)
	{
		FeelingLevel = feelingLev;
		FeelingExp = feelingEx;
	}

	public Color GetColorByRarity(int rarity)
	{
		Color color = Color.white;
		switch (rarity)
		{
		case 2:
			ColorUtility.TryParseHtmlString("#9bc8ff", out color);
			break;
		case 3:
			ColorUtility.TryParseHtmlString("#c29bff", out color);
			break;
		case 4:
			ColorUtility.TryParseHtmlString("#fece77", out color);
			break;
		}
		return color;
	}

	public bool SetSkin(int skinConfigId)
	{
		DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow<DRHeroInfo>(id);
		if (skinConfigId <= 0)
		{
			skinConfigId = dataRow.InitialHeroSkin;
		}
		if (this.skinConfigId == skinConfigId)
		{
			return false;
		}
		DRUIHeroSkin dataRow2 = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(skinConfigId);
		if (dataRow2 == null)
		{
			skinConfigId = dataRow.InitialHeroSkin;
			this.skinConfigId = skinConfigId;
			isSkin = false;
			SkinSuffix = "";
			skinConfigName = "";
		}
		else
		{
			this.skinConfigId = skinConfigId;
			isSkin = dataRow.InitialHeroSkin != skinConfigId;
			SkinSuffix = dataRow2.Suffix;
			skinConfigName = dataRow2.SkinName;
		}
		Original = originalConfig + skinSuffix;
		RefreshHctSkillIconSkins();
		return true;
	}

	private void RefreshHctSkillIconSkins()
	{
		if (hctSkillDatas == null || hctSkillDatas.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, HCTSkillData> hctSkillData in hctSkillDatas)
		{
			HCTSkillData value = hctSkillData.Value;
			if (value != null)
			{
				if (IsPassiveSkillType(value.SkillTypeEnum))
				{
					value.RefreshIconSkin(skinConfigId, skinSuffix, id);
				}
				else
				{
					value.RefreshIconSkin(skinConfigId, skinSuffix);
				}
			}
		}
	}

	private static bool IsPassiveSkillType(HeroSkillTypeEnum skillTypeEnum)
	{
		if (skillTypeEnum == HeroSkillTypeEnum.Interaction1 || (uint)(skillTypeEnum - 12) <= 2u)
		{
			return true;
		}
		return false;
	}

	private void UpdateTalentProperty()
	{
		TalentProperty.Clear();
		talentEntryDataList.Clear();
		if (talentDatas == null)
		{
			return;
		}
		foreach (KeyValuePair<int, HCTalentData> talent in talentDatas)
		{
			if (talent.Value.SmallOrder == 0)
			{
				continue;
			}
			DRHeroTalentSmall[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentSmall p) => p.SkillId == talent.Key && p.Order <= talent.Value.SmallOrder);
			if (dataRows != null)
			{
				for (int num = 0; num < dataRows.Length; num++)
				{
					for (int num2 = 0; num2 < dataRows[num].AttributeId.Count; num2++)
					{
						talentProperty.AddProperty(GetAffixKeyById(dataRows[num].AttributeId[num2]), dataRows[num].AttributeNum[num2]);
					}
				}
			}
			else
			{
				Log.Error($"英雄【{id}】火种表配置异常，找不到技能Id【{talent.Value.SkillId}】和火种Order【{talent.Value.SmallOrder}】！");
			}
		}
		if (_initialized)
		{
			UpdateTotalProperty();
		}
	}

	private void GetTalentDatas(Dictionary<int, HCTalentData> talentDatas)
	{
		if (talentDatas == null)
		{
			this.talentDatas = new Dictionary<int, HCTalentData>();
			DRHeroTalentBig[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentBig p) => p.HeroId == id && p.Level == 1);
			if (dataRows != null && dataRows.Length != 0)
			{
				for (int num = 0; num < dataRows.Length; num++)
				{
					this.talentDatas.Add(dataRows[num].SkillId, HCTalentData.Create(dataRows[num].SkillId, dataRows[num].Level, 0));
				}
			}
			else
			{
				Log.Error($"英雄【{id}】燃点表配置异常，无法获取初始燃点信息！");
			}
			talentDatas = this.talentDatas;
		}
		else
		{
			this.talentDatas = talentDatas;
		}
		UpdateHctSkillDatas();
		UpdateTalentProperty();
	}

	private void GetTalentDatas(int level, List<int> smallList)
	{
		Dictionary<int, HCTalentData> dictionary = new Dictionary<int, HCTalentData>();
		DRHeroTalentBig[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentBig p) => p.HeroId == id && p.Level == 1);
		if (dataRows != null && dataRows.Length != 0)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				dictionary.Add(dataRows[num].SkillId, HCTalentData.Create(dataRows[num].SkillId, level, (smallList.Count > num) ? smallList[num] : 0));
			}
		}
		else
		{
			Log.Error($"英雄【{id}】燃点表配置异常，无法获取初始燃点信息！");
		}
		GetTalentDatas(dictionary);
	}

	public void SetHeroTalentMax()
	{
		int maxBigLevel = 12;
		talentDatas = new Dictionary<int, HCTalentData>();
		DRHeroTalentBig[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTalentBig p) => p.HeroId == id && p.Level == maxBigLevel);
		if (dataRows != null && dataRows.Length != 0)
		{
			for (int num = 0; num < dataRows.Length; num++)
			{
				talentDatas.Add(dataRows[num].SkillId, HCTalentData.Create(dataRows[num].SkillId, dataRows[num].Level, 999));
			}
		}
		else
		{
			Log.Error($"英雄【{id}】燃点表配置异常，无法获取初始燃点信息！");
		}
		GetTalentDatas(talentDatas);
	}

	public void SetHeroTalentInit()
	{
		talentDatas = null;
		GetTalentDatas(null);
	}

	private void UpdateHctSkillDatas()
	{
		hctSkillDatas.Clear();
		if (talentDatas == null)
		{
			return;
		}
		foreach (HCTalentData talentData in talentDatas.Values)
		{
			DRHeroTalentBig dataRow = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == talentData.SkillId && p.Level == talentData.BigLevel);
			if (dataRow == null)
			{
				Log.Error($"英雄【{id}】燃点HeroTalentBig表，找不到对应的SkillId：【{talentData.SkillId}】，Level：【{talentData.BigLevel}】！");
				continue;
			}
			DRHeroTalentSmall[] smalls = GameEntry.DataTable.GetDataRows((DRHeroTalentSmall p) => p.SkillId == talentData.SkillId && p.Order <= talentData.SmallOrder);
			DRHeroSKillConfig dataRow2 = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig p) => p.Id == talentData.SkillId);
			if (dataRow2 == null)
			{
				Log.Error($"英雄【{id}】燃点表SkillId：【{talentData.SkillId}】，找不到对应的技能HeroSKillConfig！");
				continue;
			}
			List<int> deriveSkillIds = new List<int>();
			List<int> list = new List<int>();
			if (dataRow2.DefaultDeriveSkillId.Count > 0)
			{
				for (int num = 0; num < dataRow2.DefaultDeriveSkillId.Count; num++)
				{
					deriveSkillIds.Add(dataRow2.DefaultDeriveSkillId[num]);
					if (dataRow2.HideDeriveDesc.Count > num && dataRow2.HideDeriveDesc[num])
					{
						list.Add(dataRow2.DefaultDeriveSkillId[num]);
					}
				}
			}
			for (int i = 0; i < smalls.Length; i++)
			{
				if (smalls[i].TinderType != 1)
				{
					continue;
				}
				int bv;
				for (bv = 0; bv < smalls[i].BattleValue.Count; bv++)
				{
					DRCultivateSkillEffect dataRow3 = GameEntry.DataTable.GetDataRow((DRCultivateSkillEffect p) => p.Id == smalls[i].BattleValue[bv]);
					if (dataRow3 == null)
					{
						Log.Error($"天赋火种数据配置异常，Id【{smalls[i].Id}】,CultivateSkillEffect找不到对应的配置Id【{smalls[i].BattleValue}】");
						continue;
					}
					if (dataRow3.DeriveSkillIdAdd.Count > 0)
					{
						for (int num2 = 0; num2 < dataRow3.DeriveSkillIdAdd.Count; num2++)
						{
							deriveSkillIds.Add(dataRow3.DeriveSkillIdAdd[num2]);
						}
					}
					if (dataRow3.DeriveSkillIdDec.Count <= 0)
					{
						continue;
					}
					for (int num3 = 0; num3 < dataRow3.DeriveSkillIdDec.Count; num3++)
					{
						for (int num4 = deriveSkillIds.Count - 1; num4 >= 0; num4--)
						{
							if (deriveSkillIds[num4] == dataRow3.DeriveSkillIdDec[num3])
							{
								deriveSkillIds.RemoveAt(num4);
							}
						}
					}
				}
			}
			HCTSkillData hCTSkillData = HCTSkillData.CreateOrigin(dataRow2, dataRow, smalls);
			hCTSkillData.RefreshIconSkin(skinConfigId, skinSuffix);
			hctSkillDatas.Add(dataRow2.Id, hCTSkillData);
			hCTSkillData.HideDeriveSkillId(list);
			int i2;
			for (i2 = 0; i2 < deriveSkillIds.Count; i2++)
			{
				if (hctSkillDatas.ContainsKey(deriveSkillIds[i2]))
				{
					hCTSkillData.AddDeriveSkill(hctSkillDatas[deriveSkillIds[i2]]);
					continue;
				}
				DRHeroSKillConfig dataRow4 = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig p) => p.Id == deriveSkillIds[i2]);
				if (dataRow4 == null)
				{
					Log.Error($"HeroSKillConfig 找不到Id【{deriveSkillIds[i2]}】的数据，技能派生配置！");
					continue;
				}
				HCTSkillData hCTSkillData2 = HCTSkillData.CreateDerive(dataRow4, dataRow, hCTSkillData);
				hCTSkillData2.RefreshIconSkin(skinConfigId, skinSuffix);
				hctSkillDatas.Add(dataRow4.Id, hCTSkillData2);
				hCTSkillData.AddDeriveSkill(hCTSkillData2);
				hCTSkillData2.RefreshLevelEffect(hCTSkillData);
			}
			for (int i3 = 0; i3 < smalls.Length; i3++)
			{
				if (smalls[i3].TinderType == 1)
				{
					int bv2;
					for (bv2 = 0; bv2 < smalls[i3].BattleValue.Count; bv2++)
					{
						DRCultivateSkillEffect dataRow5 = GameEntry.DataTable.GetDataRow((DRCultivateSkillEffect p) => p.Id == smalls[i3].BattleValue[bv2]);
						if (dataRow5 == null)
						{
							Log.Error($"天赋火种数据配置异常，Id【{smalls[i3].Id}】,CultivateSkillEffect找不到对应的配置Id【{smalls[i3].BattleValue}】");
						}
						else
						{
							if (dataRow5.InfluenceSkillId.Count <= 0)
							{
								continue;
							}
							for (int num5 = 0; num5 < dataRow5.InfluenceSkillId.Count; num5++)
							{
								int key = dataRow5.InfluenceSkillId[num5];
								if (hctSkillDatas.ContainsKey(key))
								{
									hctSkillDatas[key].UpdateCultureEffect(dataRow5);
								}
							}
						}
					}
				}
				else if (smalls[i3].TinderType == 3)
				{
					hctSkillDatas[dataRow2.Id].AddBuffId(smalls[i3].BattleBuffId);
				}
			}
			List<int> skillEffectIds = new List<int>();
			GameEntry.DataTable.GetDataRows((DRHeroSeat p) => p.HeroId == Id && p.TargetSeat <= DestinyLevel)?.ForEach(delegate(DRHeroSeat p)
			{
				skillEffectIds.AddRange(p.UpBattleValue);
			});
			for (int num6 = 0; num6 < skillEffectIds.Count; num6++)
			{
				int skillEffectId = skillEffectIds[num6];
				DRCultivateSkillEffect dataRow6 = GameEntry.DataTable.GetDataRow((DRCultivateSkillEffect p) => p.Id == skillEffectId);
				if (dataRow6 == null)
				{
					Log.Error($"CultivateSkillEffect找不到对应的配置Id【{skillEffectId}】");
				}
				else
				{
					if (dataRow6.InfluenceSkillId.Count <= 0)
					{
						continue;
					}
					for (int num7 = 0; num7 < dataRow6.InfluenceSkillId.Count; num7++)
					{
						int key2 = dataRow6.InfluenceSkillId[num7];
						if (hctSkillDatas != null && hctSkillDatas.ContainsKey(key2))
						{
							hctSkillDatas[key2].UpdateCultureEffect(dataRow6);
						}
					}
				}
			}
		}
	}

	public HCTSkillData GetNextSkillData(HCTSkillData curSkillData)
	{
		DRHeroTalentBig dataRow = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == curSkillData.SkillId && p.Level == curSkillData.Level + 1);
		DRHeroSKillConfig dataRow2 = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig p) => p.Id == curSkillData.SkillId);
		if (dataRow == null)
		{
			return curSkillData;
		}
		int skillId = curSkillData.SkillId;
		HCTSkillData hCTSkillData = HCTSkillData.CreateOrigin(dataRow2, dataRow, null);
		hCTSkillData.RefreshIconSkin(skinConfigId, skinSuffix);
		List<HCTSkillData> list = new List<HCTSkillData>();
		if (hctSkillDatas.ContainsKey(skillId))
		{
			List<HCTSkillData> deriveSkills = hctSkillDatas[skillId].DeriveSkills;
			if (deriveSkills != null)
			{
				int i;
				for (i = 0; i < deriveSkills.Count; i++)
				{
					if (!curSkillData.HideDeriveSkillDesc.Contains(deriveSkills[i].SkillId))
					{
						HCTSkillData hCTSkillData2 = HCTSkillData.CreateDerive(GameEntry.DataTable.GetDataRow((DRHeroSKillConfig p) => p.Id == deriveSkills[i].SkillId), dataRow, hCTSkillData);
						hCTSkillData2.RefreshIconSkin(skinConfigId, skinSuffix);
						list.Add(hCTSkillData2);
					}
				}
			}
		}
		hCTSkillData.SetDeriveSkill(list);
		return hCTSkillData;
	}

	public void SetTalentPointLight(int skillId, int order, HCSPointType pointType)
	{
		if (talentDatas.ContainsKey(skillId))
		{
			talentDatas[skillId].UpdateData(order, pointType);
		}
		if (hctSkillDatas.ContainsKey(skillId))
		{
			if (pointType == HCSPointType.Big)
			{
				hctSkillDatas[skillId].RefreshLevelEffect(order);
				List<HCTSkillData> deriveSkills = hctSkillDatas[skillId].DeriveSkills;
				if (deriveSkills != null)
				{
					for (int i = 0; i < deriveSkills.Count; i++)
					{
						deriveSkills[i].RefreshLevelEffect(hctSkillDatas[skillId]);
					}
				}
			}
			else
			{
				DRHeroTalentSmall talentSmall = GameEntry.DataTable.GetDataRow((DRHeroTalentSmall p) => p.SkillId == skillId && p.Order == order);
				if (talentSmall.TinderType == 1)
				{
					int bv;
					for (bv = 0; bv < talentSmall.BattleValue.Count; bv++)
					{
						DRCultivateSkillEffect dataRow = GameEntry.DataTable.GetDataRow((DRCultivateSkillEffect p) => p.Id == talentSmall.BattleValue[bv]);
						if (dataRow.DeriveSkillIdDec.Count > 0)
						{
							for (int num = 0; num < dataRow.DeriveSkillIdDec.Count; num++)
							{
								int num2 = dataRow.DeriveSkillIdDec[num];
								if (hctSkillDatas.ContainsKey(num2))
								{
									hctSkillDatas[skillId].DecDeriveSkill(num2);
								}
							}
						}
						DRHeroTalentBig dataRow2 = GameEntry.DataTable.GetDataRow((DRHeroTalentBig p) => p.SkillId == skillId && p.Level == hctSkillDatas[skillId].Level);
						if (dataRow.DeriveSkillIdAdd.Count > 0)
						{
							for (int num3 = 0; num3 < dataRow.DeriveSkillIdAdd.Count; num3++)
							{
								int deriveSkillId = dataRow.DeriveSkillIdAdd[num3];
								if (hctSkillDatas.ContainsKey(deriveSkillId))
								{
									hctSkillDatas[skillId].AddDeriveSkill(hctSkillDatas[deriveSkillId]);
									continue;
								}
								DRHeroSKillConfig dataRow3 = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig p) => p.Id == deriveSkillId);
								HCTSkillData hCTSkillData = HCTSkillData.CreateDerive(dataRow3, dataRow2, hctSkillDatas[skillId]);
								hCTSkillData.RefreshIconSkin(skinConfigId, skinSuffix);
								hCTSkillData.RefreshLevelEffect(hctSkillDatas[skillId]);
								if (dataRow3 == null)
								{
									Log.Error($"HeroSKillConfig 找不到Id【{deriveSkillId}】的数据，CultivateSkillEffect 技能派生配置！");
									continue;
								}
								hctSkillDatas.Add(dataRow3.Id, hCTSkillData);
								hctSkillDatas[skillId].AddDeriveSkill(hCTSkillData);
							}
						}
						else
						{
							if (dataRow.InfluenceSkillId.Count <= 0)
							{
								continue;
							}
							for (int num4 = 0; num4 < dataRow.InfluenceSkillId.Count; num4++)
							{
								if (hctSkillDatas.ContainsKey(dataRow.InfluenceSkillId[num4]))
								{
									hctSkillDatas[dataRow.InfluenceSkillId[num4]].UpdateCultureEffect(dataRow);
								}
								else
								{
									Log.Error($"技能养成列表中找不到Id为{dataRow.InfluenceSkillId[num4]}的技能");
								}
							}
						}
					}
				}
				else if (talentSmall.TinderType == 3)
				{
					hctSkillDatas[skillId].AddBuffId(talentSmall.BattleBuffId);
				}
			}
		}
		UpdateTalentProperty();
	}

	public HCTalentData GetTalentDataBySkillId(int curSelectSkillId)
	{
		if (talentDatas.ContainsKey(curSelectSkillId))
		{
			return talentDatas[curSelectSkillId];
		}
		return null;
	}

	private void UpdateExtraProperty(List<int> affixIds, List<float> affixValues)
	{
		ExtraProperty.Clear();
		if (affixIds != null)
		{
			for (int i = 0; i < affixIds.Count; i++)
			{
				float value = ((affixValues.Count > i) ? affixValues[i] : 0f);
				ExtraProperty.AddProperty(GetAffixKeyById(affixIds[i]), value);
			}
			if (_initialized)
			{
				UpdateProperty();
			}
		}
	}

	private void UpdateExtraEntryData(List<int> entryIds, List<int> entryLevels)
	{
		ExtraEntryDataList.Clear();
		if (entryIds != null)
		{
			for (int i = 0; i < entryIds.Count; i++)
			{
				int num = ((entryLevels.Count > i) ? entryLevels[i] : 0);
				EntryData item = new EntryData(entryIds[i], num);
				ExtraEntryDataList.Add(item);
			}
			if (_initialized)
			{
				UpdateProperty();
			}
		}
	}

	public void AddBPData(Dictionary<int, BPData> bpDatas)
	{
		this.bpDatas = bpDatas;
		SetBpDataMax();
	}

	public void ClearBPData()
	{
		bpDatas = null;
	}

	public void SetBpDataMax()
	{
		if (bpDatas == null || bpDatas.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, BPData> bpData in bpDatas)
		{
			bpData.Value?.SetCarryPropNumberToMax();
		}
	}

	public bool HasEmptyBPData()
	{
		if (bpDatas != null && (!bpDatas.ContainsKey(1) || bpDatas[1] != null))
		{
			if (bpDatas.ContainsKey(2))
			{
				return bpDatas[2] == null;
			}
			return false;
		}
		return true;
	}

	public int AddBPDataImmediately(BPData newBpData)
	{
		newBpData.SetCarryPropNumberToMax();
		if (bpDatas == null)
		{
			bpDatas = new Dictionary<int, BPData>();
			bpDatas.Add(1, newBpData);
			return 1;
		}
		if (bpDatas.ContainsKey(1))
		{
			if (bpDatas[1] == null)
			{
				bpDatas[1] = newBpData;
				return 1;
			}
			if (bpDatas.ContainsKey(2))
			{
				if (bpDatas[2] == null)
				{
					bpDatas[2] = newBpData;
					return 2;
				}
				return 0;
			}
			bpDatas.Add(2, newBpData);
			return 2;
		}
		bpDatas.Add(1, newBpData);
		return 1;
	}

	public void CheckAddGuildBaseBuff()
	{
		int environId = 0;
		if (Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData() != null)
		{
			environId = GuildDefinition.GetGuildBaseBuffId();
		}
		AddOuterBuff(OuterBuffEnum.GuildBuff, environId);
	}

	public void AddGuildBaseBuff()
	{
		int guildBaseBuffId = GuildDefinition.GetGuildBaseBuffId();
		AddOuterBuff(OuterBuffEnum.GuildBuff, guildBaseBuffId);
	}

	public void AddGuildTeammateBuff()
	{
		int guildTeammateBuffId = GuildDefinition.GetGuildTeammateBuffId();
		AddOuterBuff(OuterBuffEnum.GuildBuff, guildTeammateBuffId);
	}

	public void ResetOuterBuff()
	{
		outerBuffs.Clear();
	}

	public int GetOuterBuff(OuterBuffEnum outerBuffType)
	{
		if (!outerBuffs.ContainsKey(outerBuffType))
		{
			return 0;
		}
		if (outerBuffs[outerBuffType] != null && outerBuffs[outerBuffType].Count > 0)
		{
			return outerBuffs[outerBuffType][0];
		}
		return 0;
	}

	public void AddOuterBuff(OuterBuffEnum outerBuffType, int environId)
	{
		if (environId != 0)
		{
			if (!outerBuffs.ContainsKey(outerBuffType))
			{
				outerBuffs.Add(outerBuffType, new List<int>());
			}
			outerBuffs[outerBuffType].Clear();
			outerBuffs[outerBuffType].Add(environId);
		}
	}

	public List<int> GetAllOuterBuffList(EnvironmentModifierType environmentType)
	{
		List<int> list = new List<int>();
		if (outerBuffs == null)
		{
			return list;
		}
		foreach (KeyValuePair<OuterBuffEnum, List<int>> outerBuff in outerBuffs)
		{
			if (outerBuff.Value == null)
			{
				continue;
			}
			for (int i = 0; i < outerBuff.Value.Count; i++)
			{
				int environId = outerBuff.Value[i];
				int num = ((environmentType == EnvironmentModifierType.Buff) ? EnvironmentModifierHelper.GetBuffId(environId) : EnvironmentModifierHelper.GetParadoxId(environId));
				if (num != 0)
				{
					list.Add(num);
				}
			}
		}
		return list;
	}

	public void SetUseSkillSkin(int SkillId, int skinId)
	{
		if (UseSkillCameraSkinId.ContainsKey(SkillId))
		{
			UseSkillCameraSkinId[SkillId] = skinId;
		}
		else
		{
			UseSkillCameraSkinId.Add(SkillId, skinId);
		}
	}

	public PeripheryHeroData GetPeripheryHeroData(long uid = 0L, int seatId = 1, string playerName = "")
	{
		PeripheryHeroData peripheryHeroData = PeripheryHeroData.CreateEmpty();
		if (uid == 0L)
		{
			uid = (Singleton<ServiceSystem>.Instance?.GetService<IRoleService>()?.Uid).GetValueOrDefault();
		}
		peripheryHeroData.Uid = uid;
		peripheryHeroData.Id = id;
		peripheryHeroData.IsSkin = isSkin;
		peripheryHeroData.SkinConfigId = skinConfigId;
		peripheryHeroData.SkinSuffix = skinSuffix;
		peripheryHeroData.Name = (string.IsNullOrEmpty(playerName) ? name : playerName);
		peripheryHeroData.Level = level;
		peripheryHeroData.Weapon = weapon;
		peripheryHeroData.DestinyLevel = destinyLevel;
		peripheryHeroData.HeroAttributeEnum = attribute;
		peripheryHeroData.UseSkillCameraSkinId = UseSkillCameraSkinId;
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		int num = 0;
		if (service != null && service.GetRoleData() != null && service.GetRoleData().PlayerInfo != null)
		{
			num = service.GetRoleData().PlayerInfo.Level;
		}
		DRConstantConfig dataRow = GameEntry.DataTable.GetDataRow<DRConstantConfig>(Constant.ConstantConfig.AutoFightUnLockLevel);
		peripheryHeroData.UnLockAutoFight = (float)num >= dataRow.Value;
		if (_totalProperty != null)
		{
			foreach (KeyValuePair<string, float> numerical in _totalProperty.Numericals)
			{
				peripheryHeroData.PropertyDic.Add(numerical.Key, _totalProperty.GetBattleProperty(numerical.Key));
			}
		}
		peripheryHeroData.Rarity = rarity;
		peripheryHeroData.SeatId = seatId;
		peripheryHeroData.PropsData = GetBattleProps();
		if (hctSkillDatas != null)
		{
			foreach (KeyValuePair<int, HCTSkillData> hctSkillData in hctSkillDatas)
			{
				peripheryHeroData.SkillEffectDic.Add(hctSkillData.Key, hctSkillData.Value.CultivateSkillEffect);
				peripheryHeroData.SkillLevelDic.Add(hctSkillData.Key, hctSkillData.Value.CultivateSkillLevel);
				peripheryHeroData.SkillBigLevel.Add(hctSkillData.Key, hctSkillData.Value.Level);
			}
		}
		if (talentDatas != null)
		{
			foreach (HCTalentData value in talentDatas.Values)
			{
				if (value.SmallOrderList != null)
				{
					peripheryHeroData.SmallOrderList.AddRange(value.SmallOrderList);
				}
			}
		}
		peripheryHeroData.BuffList = this.GetAllEntrys();
		peripheryHeroData.BTList = this.GetAllBTId();
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		(List<int>, List<int>) battleSetEmojiSetting = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().GetBattleSetEmojiSetting();
		list = battleSetEmojiSetting.Item1;
		list2 = battleSetEmojiSetting.Item2;
		for (int i = 0; i < 8; i++)
		{
			if (i < list.Count)
			{
				peripheryHeroData.RoundEmojis.Add(list[i]);
			}
			else
			{
				peripheryHeroData.RoundEmojis.Add(0);
			}
		}
		peripheryHeroData.FightEventEmojisDic[BattleObserverEventEnum.BattleStart] = 0;
		peripheryHeroData.FightEventEmojisDic[BattleObserverEventEnum.MonsterFuzzy] = 0;
		peripheryHeroData.FightEventEmojisDic[BattleObserverEventEnum.EntityDead] = 0;
		List<BattleObserverEventEnum> list3 = peripheryHeroData.FightEventEmojisDic.Keys.ToList();
		for (int j = 0; j < list3.Count; j++)
		{
			if (j < list2.Count)
			{
				peripheryHeroData.FightEventEmojisDic[list3[j]] = list2[j];
			}
		}
		int indicatorSetting = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().GetIndicatorSetting();
		peripheryHeroData.Indicator = indicatorSetting;
		peripheryHeroData.SetHeroModel(this);
		return peripheryHeroData;
	}

	private Dictionary<int, BattleProps> GetBattleProps()
	{
		Dictionary<int, BattleProps> dictionary = new Dictionary<int, BattleProps>();
		if (bpDatas != null && bpDatas.Count > 0)
		{
			foreach (KeyValuePair<int, BPData> bpData in bpDatas)
			{
				if (bpData.Value != null)
				{
					BattleProps value = BattleProps.Create(bpData.Value);
					dictionary.Add(bpData.Key, value);
				}
			}
		}
		return dictionary;
	}
}
