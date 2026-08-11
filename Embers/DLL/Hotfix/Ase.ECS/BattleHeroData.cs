#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class BattleHeroData : EntityViewModel, IBattleHeroData
{
	private int _configId;

	private bool _cantRevived;

	private DRHero _drHero;

	private PeripheryHeroData _heroModel;

	private bool _isDead;

	private bool _isSelf;

	private int _memberId;

	private string name;

	private float rebornTime;

	private bool showRecuseIcon;

	private float revivedTime;

	private WeaponEnum _weaponEnum;

	private HeroAttributeEnum _attribute;

	private HeroIndepentType _heroIndepentType;

	private WeaponMechanismBase _weaponMechanism;

	private BattleProps _bpData;

	private BattleProps _deputyBpData;

	private int waitRecuseHeroId1;

	private int waitRecuseHeroId2;

	private bool recoverEnergyEnabled = true;

	public List<InteractiveStateChecker> interactiveStateCheckers = new List<InteractiveStateChecker>(6);

	private Dictionary<int, BattleEmoteModel> _battleEmoteModels = new Dictionary<int, BattleEmoteModel>();

	public Dictionary<int, BattleEmoteModel> _allBattleEmoteModels = new Dictionary<int, BattleEmoteModel>();

	public Dictionary<BattleObserverEventEnum, BattleEmoteModel> _battleEmoteEventModels = new Dictionary<BattleObserverEventEnum, BattleEmoteModel>();

	private Dictionary<string, List<HeroInDependentData>> heroInDependentDatas;

	private int indicatorRingId;

	private EntityBoneComponent _entityBoneComp;

	private ParryComponent _entityParryComp;

	private CoolingComponent _entityCoolingComp;

	private Camera _battleCamera;

	private PropertyData engeryProperty;

	private float tempEngeryRecover;

	private float tempEngeryCur;

	private bool showEnergyEffect;

	private bool showEnergyAddEffect;

	private bool skill4RleScucess;

	private int maxInteractiveCount = 4;

	private Dictionary<HeroSkillTypeEnum, List<HeroSkillData>> _commandBindSkillGroupDic;

	private Dictionary<HeroSkillTypeEnum, int> _commandBindSkillGroupOrigin;

	private ObservableDictionary<HeroSkillTypeEnum, HeroSkillData> _command2SkillDataDic;

	private ObservableDictionary<int, HeroSkillData> _heroSKillData;

	private List<HeroSkillData> _heroSKillDataValueList;

	private Dictionary<HeroSkillTypeEnum, CommandCacheData> _commandCacheTime;

	public int ConfigId => _configId;

	public PeripheryHeroData HeroModel => _heroModel;

	public Dictionary<int, BattleEmoteModel> BattleEmoteModels => _battleEmoteModels;

	public Dictionary<string, List<HeroInDependentData>> HeroInDependentDatas => heroInDependentDatas;

	public int IndicatorRingId => indicatorRingId;

	public string Name
	{
		get
		{
			return name;
		}
		set
		{
			Set(ref name, value, "Name");
		}
	}

	public bool IsDead
	{
		get
		{
			return _isDead;
		}
		private set
		{
			Set(ref _isDead, value, "IsDead");
		}
	}

	public bool IsSelf
	{
		get
		{
			return _isSelf;
		}
		set
		{
			Set(ref _isSelf, value, "IsSelf");
		}
	}

	public bool CantRevived
	{
		get
		{
			return _cantRevived;
		}
		private set
		{
			Set(ref _cantRevived, value, "CantRevived");
		}
	}

	public WeaponEnum WeaponEnum
	{
		get
		{
			return _weaponEnum;
		}
		private set
		{
			Set(ref _weaponEnum, value, "WeaponEnum");
		}
	}

	public HeroIndepentType HeroIndepentType
	{
		get
		{
			return _heroIndepentType;
		}
		set
		{
			Set(ref _heroIndepentType, value, "HeroIndepentType");
		}
	}

	public HeroAttributeEnum Attribute
	{
		get
		{
			return _attribute;
		}
		private set
		{
			Set(ref _attribute, value, "Attribute");
		}
	}

	public float RevivedTime
	{
		get
		{
			return revivedTime;
		}
		private set
		{
			Set(ref revivedTime, value, "RevivedTime");
		}
	}

	public int MemberId
	{
		get
		{
			return _memberId;
		}
		set
		{
			_memberId = value;
		}
	}

	public int WaitRecuseHeroId1
	{
		get
		{
			return waitRecuseHeroId1;
		}
		set
		{
			Set(ref waitRecuseHeroId1, value, "WaitRecuseHeroId1");
		}
	}

	public int WaitRecuseHeroId2
	{
		get
		{
			return waitRecuseHeroId2;
		}
		set
		{
			Set(ref waitRecuseHeroId2, value, "WaitRecuseHeroId2");
		}
	}

	public bool RecoverEnergyEnabled
	{
		get
		{
			return recoverEnergyEnabled;
		}
		set
		{
			recoverEnergyEnabled = value;
		}
	}

	public bool ShowRecuseIcon
	{
		get
		{
			return showRecuseIcon;
		}
		set
		{
			Set(ref showRecuseIcon, value, "ShowRecuseIcon");
		}
	}

	public WeaponMechanismBase WeaponMechanismBase => _weaponMechanism;

	public WeaponMechanismViewModel WeaponMechanismData => _weaponMechanism.WeaponMechanismData;

	public BattleProps BpData => _bpData;

	public BattleProps DeputyBpData => _deputyBpData;

	public float RebornTime
	{
		get
		{
			return rebornTime;
		}
		private set
		{
			Set(ref rebornTime, value, "RebornTime");
		}
	}

	public bool ShowEnergyEffect
	{
		get
		{
			return showEnergyEffect;
		}
		set
		{
			Set(ref showEnergyEffect, value, "ShowEnergyEffect");
		}
	}

	public bool ShowEnergyAddEffect
	{
		get
		{
			return showEnergyAddEffect;
		}
		set
		{
			Set(ref showEnergyAddEffect, value, "ShowEnergyAddEffect");
		}
	}

	public bool Skill4RleScucess
	{
		get
		{
			return skill4RleScucess;
		}
		set
		{
			Set(ref skill4RleScucess, value, "Skill4RleScucess");
		}
	}

	public int SkillCount => _heroSKillData?.Count ?? 0;

	public ObservableDictionary<HeroSkillTypeEnum, HeroSkillData> CommandType2HeroData => _command2SkillDataDic;

	public ObservableDictionary<int, HeroSkillData> HeroSKillData => _heroSKillData;

	public Dictionary<HeroSkillTypeEnum, CommandCacheData> CommandCacheDataDic => _commandCacheTime;

	public Dictionary<HeroSkillTypeEnum, List<HeroSkillData>> CommandBindSkillGroup => _commandBindSkillGroupDic;

	private BattleHeroData()
	{
	}

	public new static BattleHeroData Empty()
	{
		BattleHeroData obj = new BattleHeroData
		{
			level = 1,
			WeaponEnum = WeaponEnum.None
		};
		obj._weaponMechanism = WeaponMechanismBase.Create(obj.propertyList);
		obj._command2SkillDataDic = new ObservableDictionary<HeroSkillTypeEnum, HeroSkillData>();
		obj._command2SkillDataDic[HeroSkillTypeEnum.Attack] = HeroSkillData.CreateEmpty();
		obj._command2SkillDataDic[HeroSkillTypeEnum.Skill1] = HeroSkillData.CreateEmpty();
		obj._command2SkillDataDic[HeroSkillTypeEnum.Skill2] = HeroSkillData.CreateEmpty();
		obj._command2SkillDataDic[HeroSkillTypeEnum.Skill3] = HeroSkillData.CreateEmpty();
		obj._command2SkillDataDic[HeroSkillTypeEnum.Skill4] = HeroSkillData.CreateEmpty();
		obj._command2SkillDataDic[HeroSkillTypeEnum.PropSkill] = HeroSkillData.CreateEmpty();
		obj._command2SkillDataDic[HeroSkillTypeEnum.DeputyPropSkill] = HeroSkillData.CreateEmpty();
		obj.HeroIndepentType = HeroIndepentType.None;
		return obj;
	}

	public static BattleHeroData Create(BaseEntity baseEntity, DRHero hero, PeripheryHeroData heroModel)
	{
		BattleHeroData battleHeroData = new BattleHeroData();
		battleHeroData._configId = hero.Id;
		battleHeroData._drHero = hero;
		battleHeroData.entity = baseEntity;
		battleHeroData.level = heroModel.Level;
		battleHeroData._heroModel = heroModel;
		battleHeroData.name = heroModel.Name;
		battleHeroData.WeaponEnum = heroModel.Weapon;
		battleHeroData.Attribute = heroModel.HeroAttributeEnum;
		battleHeroData._weaponMechanism = WeaponMechanismBase.Create(battleHeroData.WeaponEnum, baseEntity, hero, battleHeroData.propertyList);
		battleHeroData.HeroIndepentType = (HeroIndepentType)hero.IndependentResType;
		battleHeroData.indicatorRingId = heroModel.Indicator;
		if (heroModel.PropsData != null)
		{
			BattleProps bpData = null;
			BattleProps deputyBpData = null;
			if (heroModel.PropsData.ContainsKey(1))
			{
				bpData = heroModel.PropsData[1];
			}
			if (heroModel.PropsData.ContainsKey(2))
			{
				deputyBpData = heroModel.PropsData[2];
			}
			battleHeroData.InitPropData(bpData, deputyBpData);
		}
		battleHeroData.InitSkill();
		battleHeroData._entityBoneComp = baseEntity.GetComponent<EntityBoneComponent>();
		battleHeroData._entityParryComp = baseEntity.GetComponent<ParryComponent>();
		battleHeroData._entityCoolingComp = baseEntity.GetComponent<CoolingComponent>();
		battleHeroData._battleCamera = baseEntity.GetSystem<CameraSystem>().BattleCamera;
		battleHeroData.InitEmoteData(heroModel);
		return battleHeroData;
	}

	private void InitEmoteData(PeripheryHeroData heroModel)
	{
		foreach (BattleObserverEventEnum key in heroModel.FightEventEmojisDic.Keys)
		{
			int configId = heroModel.FightEventEmojisDic[key];
			BattleEmoteModel battleEmoteModel = CreateEmoteData(configId);
			_battleEmoteEventModels.Add(key, battleEmoteModel);
			if (!battleEmoteModel.IsNull)
			{
				_allBattleEmoteModels.TryAdd(battleEmoteModel.EmoteConfigId, battleEmoteModel);
			}
		}
		for (int i = 0; i < heroModel.RoundEmojis.Count; i++)
		{
			int configId2 = heroModel.RoundEmojis[i];
			BattleEmoteModel battleEmoteModel2 = CreateEmoteData(configId2);
			_battleEmoteModels.Add(i, battleEmoteModel2);
			if (!battleEmoteModel2.IsNull)
			{
				_allBattleEmoteModels.TryAdd(battleEmoteModel2.EmoteConfigId, battleEmoteModel2);
			}
		}
	}

	private BattleEmoteModel CreateEmoteData(int configId)
	{
		return new BattleEmoteModel(GameEntry.DataTable.GetDataRow<DRBattleEmote>(configId));
	}

	public BattleEmoteModel GetEmoteModelByConfigId(int configId)
	{
		_allBattleEmoteModels.TryGetValue(configId, out var value);
		return value;
	}

	public BattleEmoteModel GetEmoteModelByBattleEvent(BattleObserverEventEnum observerEventEnum)
	{
		_battleEmoteEventModels.TryGetValue(observerEventEnum, out var value);
		return value;
	}

	public void CreateHeroIndenpentData(HeroEntity entity)
	{
		heroInDependentDatas = new Dictionary<string, List<HeroInDependentData>>(2);
		if (_drHero == null)
		{
			return;
		}
		string independentResData = _drHero.IndependentResData;
		if (string.IsNullOrEmpty(independentResData))
		{
			return;
		}
		string[][] array = JsonConvert.DeserializeObject<string[][]>(independentResData);
		foreach (string[] array2 in array)
		{
			List<HeroInDependentData> value;
			if (array2[0].Equals("1"))
			{
				heroInDependentDatas.TryGetValue("1", out value);
				if (value == null)
				{
					value = new List<HeroInDependentData>();
					heroInDependentDatas.Add("1", value);
				}
				value.Add(BuffResLayer.Create(entity, int.Parse(array2[1])));
			}
			else if (array2[0].Equals("2"))
			{
				heroInDependentDatas.TryGetValue("2", out value);
				if (value == null)
				{
					value = new List<HeroInDependentData>();
					heroInDependentDatas.Add("2", value);
				}
				value.Add(SkillResChargeCount.Create(entity, int.Parse(array2[1])));
			}
			else if (array2[0].Equals("3"))
			{
				heroInDependentDatas.TryGetValue("3", out value);
				if (value == null)
				{
					value = new List<HeroInDependentData>();
					heroInDependentDatas.Add("3", value);
				}
				value.Add(SkillResLayer.Create(entity, int.Parse(array2[1])));
			}
		}
	}

	protected override void OnStart()
	{
		_weaponMechanism?.OnStart();
		foreach (PropertyData value in propertyList.Values)
		{
			_ = value;
		}
	}

	protected override void InitEmptyProperty()
	{
		InitHeroProperty();
	}

	public void RefreshHeroData()
	{
		entity.RebornResetAllProperty();
		MergeProperty();
		entity.SetProperty("NearDeathSchedule", 1f);
		InitPropData(null, null);
	}

	private void InitPropData(BattleProps bpData, BattleProps deputyBpData)
	{
		_bpData = bpData;
		_deputyBpData = deputyBpData;
	}

	public void AddPropData(BattleProps bpData, int index)
	{
		switch (index)
		{
		case 1:
			_bpData = bpData;
			InitAPropSkill(bpData, HeroSkillTypeEnum.PropSkill);
			break;
		case 2:
			_deputyBpData = bpData;
			InitAPropSkill(bpData, HeroSkillTypeEnum.DeputyPropSkill);
			break;
		}
	}

	private void InitHeroProperty()
	{
		propertyList.Add("Level", PropertyData.Create(_heroModel.Level));
		propertyList.Add("EnergyRecoverySpeed", PropertyData.Create(_drHero.EnergyRecovery));
		propertyList.Add("OutCombatExtraEnergyRecover", PropertyData.Create(entity.GetWorld().BattleConfig.OutCombatExtraEnergyRecover));
		propertyList.Add("OutCombatEnergyRecoveryRatio", PropertyData.Create(1f));
		propertyList.Add("RotateSpeed", PropertyData.Create(_drHero.TurnAroundSpeed));
		propertyList.Add("DefensePowerLevel", PropertyData.Create(0f, -100f, 50000f));
		propertyList.Add("DefensePowerLevelExtra", PropertyData.Create(0f, -100f, 50000f));
		propertyList.Add("Shield", PropertyData.Create(0f));
		propertyList.Add("Speed", PropertyData.Create(_drHero.Speed));
		propertyList.Add("RescueTime", PropertyData.Create(entity.GetWorld().BattleConfig.PlayerRescueTime, 0f, entity.GetWorld().BattleConfig.PlayerRescueTime));
		propertyList.Add("HeroChargedEnergy", PropertyData.Create(0f, 0f, 0f));
		propertyList.Add("HeroChargedEnergyScale", PropertyData.Create(0f, -1f, 50000f));
		propertyList.Add("HeroChargedEnergyReduceTime", PropertyData.Create(0f));
		propertyList.Add("HammerChargeTime", PropertyData.Create(0f));
		propertyList.Add("ChargedEnergyMax", PropertyData.Create(0f));
		propertyList.Add("EachChargedEnergy", PropertyData.Create(0f, rebornIsCanRefresh: false));
		propertyList.Add("ChargedEnergyMaxTime", PropertyData.Create(0f, 0f, 0f));
		propertyList.Add("EatApple", PropertyData.Create(0f));
		propertyList.Add("DodgeDistanceScale", PropertyData.Create(1f, -1f, 50000f));
		propertyList.Add("NormalAttackEnergyAmend", PropertyData.Create(0f));
		propertyList.Add("WeaknessEnergyAmend", PropertyData.Create(0f));
		propertyList.Add("NormalTenacityAmend", PropertyData.Create(_drHero.NormalTenacityAmend));
		propertyList.Add("HeroAnger", PropertyData.Create(0f, 0f, _drHero.HeroAngerMax));
		propertyList.Add("HeroAngerRatio", PropertyData.Create(_drHero.HeroAngerRatio, 0f, 50000f));
		propertyList.Add("HeroAngerReduceTimeRatio", PropertyData.Create(1f, 0f, 50000f));
		propertyList.Add("HeroAngerReduceSpeedRatio", PropertyData.Create(1f, 0f, 50000f));
		propertyList.Add("HeroAngerSwitch", PropertyData.Create(1f, 0f, 1f));
		propertyList.Add("HeroHeat", PropertyData.Create(0f, 0f, entity.GetWorld().BattleConfig.HeroHeatMax));
		propertyList.Add("HeroHeatAdditionRatio", PropertyData.Create(1f, 0f, 50000f));
		propertyList.Add("HeroHeatReduceRatio", PropertyData.Create(1f, 0f, 50000f));
		propertyList.Add("HeroHeatThreshold", PropertyData.Create(0f, 0f, 50000f));
		propertyList.Add("FullHeat", PropertyData.Create(0f, 0f, 1f));
		propertyList.Add("OverHeat", PropertyData.Create(0f, 0f, 1f));
		propertyList.Add("OverHeatable", PropertyData.Create(0f, 0f, 1f));
		propertyList.Add("HeroEnergy", PropertyData.Create(0f, 0f, _drHero.HeroEnergyMax));
		propertyList.Add("XpEnergy", PropertyData.Create(0f, 0f, _drHero.XpEnergyMax, rebornIsCanRefresh: false));
		propertyList.Add("XpEnergyRatio", PropertyData.Create(1f, 0f, 50000f, rebornIsCanRefresh: false));
		propertyList.Add("KeennessLayer", PropertyData.Create(0f, 0f, 300f));
		propertyList.Add("KeennerssLayerRatio", PropertyData.Create(1f, -1f, 50000f));
		propertyList.Add("KeennessLayerUnLockLayer", PropertyData.Create(0f, 0f, 100f));
		propertyList.Add("KeennessAmpliValue", PropertyData.Create(0f, -1000f, 50000f));
		propertyList.Add("AwakenBaseValue", PropertyData.Create(0f, 0f, 50000f));
		propertyList.Add("AwakenBaseRatio", PropertyData.Create(1f, 0f, 50000f));
		propertyList.Add("AwakenExtraRatio", PropertyData.Create(0f, -1f, 50000f));
		propertyList.Add("AwakenStateSwitch", PropertyData.Create(0f, 0f, 1f));
		propertyList.Add("AwakenCumulativeValue", PropertyData.Create(0f, 0f, 50000f));
		propertyList.Add("AwakenAutoReduceValueAddition", PropertyData.Create(1f, -50000f, 50000f));
		propertyList.Add("DestinyLevel", PropertyData.Create(_heroModel.DestinyLevel));
		propertyList.Add("BulletNumber", PropertyData.Create(_drHero.BulletNumberMax, 0f, _drHero.BulletNumberMax));
		propertyList.Add("HeroCourage", PropertyData.Create(0f, 0f, 0f));
		propertyList.Add("HeroCourageRatio", PropertyData.Create(1f, 0f, 50000f));
		propertyList.Add("EachHeroCourage", PropertyData.Create(0f, 0f, 50000f));
		propertyList.Add("EachHeroCourageNum", PropertyData.Create(0f, 0f, 50000f));
		propertyList.Add("HeroMight", PropertyData.Create(0f, 0f, 1f));
		propertyList.Add("HeroMightSwitch", PropertyData.Create(1f, 0f, 1f));
		propertyList.Add("EachHeroCourageNoMightHide", PropertyData.Create(0f, 0f, 1f));
		propertyList.Add("Attack", PropertyData.Create(0f, 50000f));
		propertyList.Add("AttackRadio", PropertyData.Create(1f, 50000f));
		propertyList.Add("FixAttack", PropertyData.Create(0f, 50000f));
		propertyList.Add("Hp", PropertyData.Create(0f, 50000f));
		propertyList.Add("HpRadio", PropertyData.Create(1f, 50000f));
		propertyList.Add("FixHp", PropertyData.Create(0f, 50000f));
		propertyList.Add("Energy", PropertyData.Create(0f, -2.1474836E+09f, 0f, minValueLimit: true));
		propertyList.Add("Defence", PropertyData.Create(0f, 50000f));
		propertyList.Add("DefenceRadio", PropertyData.Create(1f, 50000f));
		propertyList.Add("FixDefence", PropertyData.Create(0f, 50000f));
		propertyList.Add("Crit", PropertyData.Create(0f, 50000f));
		propertyList.Add("CritRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("BUFFEnergyRecoverySpeed", PropertyData.Create(0f, 50000f));
		propertyList.Add("EnergyRecoveryRatio", PropertyData.Create(1f, 50000f));
		propertyList.Add("ExtraEnergyRecover", PropertyData.Create(0f, -50000f, 50000f));
		propertyList.Add("BUFFWeaponStrength", PropertyData.Create(0f, 50000f));
		propertyList.Add("CharacterGlobalWeaponBuffDamageScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("CharacterGlobalSkillBuffDamageScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("CharacterGlobalWeaponBuffTenacityScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("CharacterGlobalSkillBuffTenacityScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("CharacterGlobalWeaponBuffCureScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("CharacterGlobalSkillBuffCureScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("EquipGlobalBuffDamageScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("WeaponSpecialDamageScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("EquipSpecialBuffTenacityScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("EquipGlobalBuffTenacityScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("WeaponSpecialTenacityScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("EquipSpecialBuffCureScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("EquipGlobalBuffCureScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("WeaponSpecialCureScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("CureExtraScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("CharacterSpecialBuffShieldScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("CharacterGlobalBuffShieldScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("EquipSpecialBuffShieldScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("EquipGlobalBuffShieldScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("WeaponSpecialShieldScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("ShieldAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("IncreaseDamageAmend", PropertyData.Create(0f, 50000f));
		propertyList.Add("ReduceDamageAmend", PropertyData.Create(0f, 50000f));
		propertyList.Add("TenacityIncrease", PropertyData.Create(0f, 50000f));
		propertyList.Add("TenacityMitigate", PropertyData.Create(0f, -10f, 50000f));
		propertyList.Add("HBDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("BDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("NBDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("HBTenacityAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("BTenacityAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("NBTenacityAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("HBCritAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("HighWeaknessDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("HighWeaknessTenacityAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("HighWeaknessCritAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("KnockDownDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("KnockDownTenacityAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("KnockDownCritAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("ODDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("ODTenacityAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("ODCritAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("MonsterAngerExtraIncreaseScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("MonsterAngerExtraSubScale", PropertyData.Create(0f, 50000f));
		propertyList.Add("ReduceDamageProbability", PropertyData.Create(0f, 0f, 50000f));
		propertyList.Add("ProbabilityReduceDamageAmend", PropertyData.Create(0f, 50000f));
		propertyList.Add("DamageConvertVirtualHpScale", PropertyData.Create(_drHero.DamageConvertVirtualHpScale, 0f, 50000f));
		propertyList.Add("VirtualHpReduceTime", PropertyData.Create(_drHero.VirtualHpReduceTime, 0f, 50000f));
		propertyList.Add("VirtualHpReduceSpeed", PropertyData.Create(_drHero.VirtualHpReduceSpeed, 0f, 50000f));
		propertyList.Add("VirtualHp", PropertyData.Create(0f, 0f, 50000f));
		propertyList.Add("ParryReduceEnergySpeed", PropertyData.Create(_drHero.ParryReduceEnergySpeed));
		propertyList.Add("DefenseConsume", PropertyData.Create(_drHero.DefenseConsume));
		propertyList.Add("ChargeSpeed", PropertyData.Create(_drHero.ChargeSpeed));
		propertyList.Add("InvincibleFrame", PropertyData.Create(_drHero.InvincibleFrame));
		propertyList.Add("HighWeaknessTimerExtendRatio2", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("HighWeaknessTimerExtendRatio3", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("HighWeaknessTimerExtendRatio4", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("HighWeaknessTimerExtend2Addition", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("HighWeaknessTimerExtend3Addition", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("HighWeaknessTimerExtend4Addition", PropertyData.Create(0f, 0f, 1000f));
		propertyList.Add("AttractionMultiplier", PropertyData.Create(1f));
		propertyList.Add("AttractionPower", PropertyData.Create(1f));
		propertyList.Add("AttractionResistance", PropertyData.Create(0f));
		propertyList.Add("SwordDamageAdditon", PropertyData.Create(0f, 50000f));
		propertyList.Add("SwordDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("GlovesDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("BowDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("GunDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("HammerDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("LanceDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("SwordFrameAdditon", PropertyData.Create(0f, 50000f));
		propertyList.Add("SwordFrameAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("GlovesFrameAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("BowFrameAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("GunFrameAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("HammerFrameAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("LanceFrameAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("SkillDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("FireDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("WindDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("WaterDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("LightDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("DarkDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("IceDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("ThunderDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("RockDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("DragonDamageRadio", PropertyData.Create(0f, 50000f));
		propertyList.Add("WeaponFrame", PropertyData.Create(0f, 50000f));
		propertyList.Add("IgnoreDefence", PropertyData.Create(0f, 1f));
		propertyList.Add("BreakDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("LightResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("DarkResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("WaterResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("FireResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("WindResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("IceResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("ThunderResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("RockResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("DragonResistance", PropertyData.Create(0f, 50000f));
		propertyList.Add("TeamDamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByIce", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByThunder", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByRock", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendByDragon", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToIce", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToThunder", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToRock", PropertyData.Create(0f, 50000f));
		propertyList.Add("AmendToDragon", PropertyData.Create(0f, 50000f));
		propertyList.Add("DamageAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("DamageRatioAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("TenacityAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("CureAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("AiDamageRatio", PropertyData.Create(0f, 50000f));
		propertyList.Add("AiTenacityRatio", PropertyData.Create(0f, 50000f));
		propertyList.Add("PassAddition", PropertyData.Create(0f, 50000f));
		propertyList.Add("EnvReduceDamage", PropertyData.Create(0f, 50000f));
		propertyList.Add("RebornProgress", PropertyData.Create(entity.GetWorld().BattleConfig.RebornNeedProgress, 50000f, rebornIsCanRefresh: false));
		propertyList.Add("RebornNeedProgress", PropertyData.Create(entity.GetWorld().BattleConfig.RebornNeedProgress, 50000f, rebornIsCanRefresh: false));
		propertyList.Add("RebornSelfIncrease", PropertyData.Create(entity.GetWorld().BattleConfig.RebornSelfIncrease, 50000f, rebornIsCanRefresh: false));
		propertyList.Add("RebornOnlySelfIncrease", PropertyData.Create(entity.GetWorld().BattleConfig.RebornOnlySelfIncrease, 50000f, rebornIsCanRefresh: false));
		propertyList.Add("RescueIncrease", PropertyData.Create(entity.GetWorld().BattleConfig.RescueIncrease, 50000f, rebornIsCanRefresh: false));
		propertyList.Add("RebornEneryRemaind", PropertyData.Create(entity.GetWorld().BattleConfig.RebornEneryProgress, 50000f, rebornIsCanRefresh: false));
		propertyList.Add("RebornEneryProgress", PropertyData.Create(entity.GetWorld().BattleConfig.RebornEneryProgress, 50000f, rebornIsCanRefresh: false));
		propertyList.Add("RebornEnergyReduce", PropertyData.Create(entity.GetWorld().BattleConfig.RebornEnergyReduce, 50000f, rebornIsCanRefresh: false));
		MergeProperty();
		propertyList.Add("NearDeathSchedule", PropertyData.Create(GetPropertyData("Hp").MaxValue * 2f, 0f, GetPropertyData("Hp").MaxValue * 2f));
		SetPropertyRefreshState();
		foreach (string key in propertyList.Keys)
		{
			_ = key;
		}
	}

	protected override void RegisterPropertyChangedAction()
	{
		PropertyInformCenter = new PropertyInformCenter();
		PropertyInformCenter.Init(entity);
		foreach (KeyValuePair<string, PropertyData> property in propertyList)
		{
			string key = property.Key;
			property.Value.SetPropertyName(key);
			if (!PropertyBind.PropertyRelevant.TryGetValue(key, out var value))
			{
				continue;
			}
			PropertyObservable propertyObservable = PropertyObservable.CreateObservable(key);
			if (propertyObservable == null)
			{
				Log.Error("配置的属性" + key + "缺少公式...");
				continue;
			}
			propertyObservable.Init(entity);
			PropertyInformCenter.RegisterObservable(key, propertyObservable);
			propertyList[key].SetPropertyInformCenter(PropertyInformCenter);
			foreach (string item in value)
			{
				PropertyInformCenter.RegisterPropertyRelation(item, key);
				propertyList.TryGetValue(item, out var value2);
				value2?.SetPropertyInformCenter(PropertyInformCenter);
			}
			propertyObservable.OnRefresh();
		}
	}

	private void MergeProperty()
	{
		foreach (string key in _heroModel.PropertyDic.Keys)
		{
			float battleProperty = _heroModel.GetBattleProperty(key);
			if (HasProperty(key))
			{
				MergeProperty(key, battleProperty, isIgnoreMax: true, isResetInitData: true);
			}
			else
			{
				propertyList.Add(key, PropertyData.Create(battleProperty, 0f, battleProperty));
			}
		}
		PropertyData propertyData = GetPropertyData("Hp");
		propertyData.ResetInit(_heroModel.GetBattleProperty("Hp"));
		propertyData.ResetMax(_heroModel.GetBattleProperty("Hp"), isExecuteValueChanged: false);
		propertyData.ResetValue(toMax: true, isExecuteValueChanged: false);
	}

	protected override void CalcPropertyLight()
	{
		string elementAdditionPropertyKey = BattleFormulaUtility.GetElementAdditionPropertyKey(Attribute);
		float battleProperty = _heroModel.GetBattleProperty("Attack");
		float battleProperty2 = _heroModel.GetBattleProperty("Crit");
		float battleProperty3 = _heroModel.GetBattleProperty("CritRadio");
		float battleProperty4 = _heroModel.GetBattleProperty(elementAdditionPropertyKey);
		float battleProperty5 = _heroModel.GetBattleProperty("Hp");
		float battleProperty6 = _heroModel.GetBattleProperty("Defence");
		float num = _heroModel.Level;
		float num2 = GameEntry.DataTable.GetDataRow<DRConstantConfig>(103)?.Value ?? 0f;
		float num3 = GameEntry.DataTable.GetDataRow<DRConstantConfig>(104)?.Value ?? 0f;
		float value = battleProperty * (1f + battleProperty2 * battleProperty3) * (1f + battleProperty4);
		float value2 = battleProperty5 / (1f - battleProperty6 / (battleProperty6 + num * num2 + num3));
		propertyLightDic.Add("Attack", value);
		propertyLightDic.Add("Hp", value2);
	}

	private void SetPropertyRefreshState()
	{
		GetPropertyData("XpEnergy").SetPropertyRefreshState(rebornIsCanRefresh: false);
		GetPropertyData("Energy").SetPropertyRefreshState(rebornIsCanRefresh: false);
	}

	public void OnFixedUpdate(float deltaTime, float timeScaleDeltaTime)
	{
		UpdateSkillData(deltaTime, timeScaleDeltaTime);
		UpdateCommandCache(0.033f);
		_weaponMechanism.FixedUpdate(deltaTime, timeScaleDeltaTime);
		if (entity == null || !entity.IsSurvival || !recoverEnergyEnabled || _entityParryComp.OpenParry || _entityCoolingComp.IsOverDraft)
		{
			return;
		}
		engeryProperty = GetPropertyData("Energy");
		if (engeryProperty != null)
		{
			tempEngeryRecover = BattleFormulaUtility.HeroEnergyRecoverySpeed(entity);
			tempEngeryCur = engeryProperty.CurValue;
			engeryProperty.Addition(tempEngeryRecover, isIgnoreMax: false);
			float num = engeryProperty.CurValue - tempEngeryCur;
			if (num > 0f)
			{
				entity.GetSystem<BattleSystem>()?.OnEnergyChangeStat(entity.Id, EnergyRecoverEnum.Normal, num);
			}
		}
		foreach (List<HeroInDependentData> value in heroInDependentDatas.Values)
		{
			for (int i = 0; i < value.Count; i++)
			{
				value[i].CalculateFillAmount();
			}
		}
	}

	public bool CheckHeroTalentStarLevel(int layer, int star)
	{
		return false;
	}

	public bool CheckKindlingIsActive(int id)
	{
		foreach (int smallOrder in _heroModel.SmallOrderList)
		{
			if (smallOrder == id)
			{
				return true;
			}
		}
		return false;
	}

	public bool ThanDestinyLevel(int level)
	{
		if (_heroModel == null)
		{
			return false;
		}
		return _heroModel.DestinyLevel >= level;
	}

	public bool CompareDestinyLevel(int level, CompareMethodType compare)
	{
		if (_heroModel == null)
		{
			return false;
		}
		return ConditionExtensions.CompareValueMethod(compare, _heroModel.DestinyLevel, level);
	}

	public void SetRevivedTime(float time, float rebornTime)
	{
		RevivedTime = time;
		RebornTime = rebornTime;
	}

	public void EntityCantRevived()
	{
		CantRevived = true;
	}

	public void EntityExitDead()
	{
		IsDead = false;
	}

	public void EntityEnterDead()
	{
		IsDead = true;
	}

	public void SetSelf()
	{
		int actorId = entity.GetWorld().ActorId;
		IsSelf = actorId == entity.Id;
	}

	protected override void Dispose(bool disposing)
	{
		base.Dispose(disposing);
		_heroModel = null;
		_weaponMechanism.OnDispose();
		_entityBoneComp = null;
		_entityParryComp = null;
		_entityCoolingComp = null;
		_battleCamera = null;
		_battleEmoteEventModels.Clear();
		_allBattleEmoteModels.Clear();
		_battleEmoteModels.Clear();
		ClearSkillData();
	}

	public Vector3 GetHeroPos()
	{
		if (entity != null)
		{
			return _battleCamera.WorldToScreenPoint(_entityBoneComp.GetBonePosition("top"));
		}
		return Vector3.zero;
	}

	public void AddInteractiveStateChecker(InteractiveStateChecker checker)
	{
		if (interactiveStateCheckers.Count < maxInteractiveCount && !interactiveStateCheckers.Contains(checker))
		{
			interactiveStateCheckers.Add(checker);
			if (base.Entity.GetComponent<StateComponent>().IsNormalState())
			{
				ResetIconShow(isFinishInter: false);
			}
		}
	}

	public void RemoveInteractiveStateChecker(InteractiveStateChecker checker, bool isFinishInter)
	{
		if (interactiveStateCheckers.Contains(checker))
		{
			interactiveStateCheckers.Remove(checker);
			ResetIconShow(isFinishInter);
		}
	}

	public bool CheckCanInteractiving()
	{
		return interactiveStateCheckers.Count < maxInteractiveCount;
	}

	public int GetinteractiveStateCheckerCount()
	{
		return interactiveStateCheckers.Count;
	}

	public InteractiveStateChecker GetinteractiveStateCheckerByIndex(int index)
	{
		return interactiveStateCheckers[index];
	}

	public bool ContanisInteractiveChecker(InteractiveStateChecker interactiveStateChecker)
	{
		return interactiveStateCheckers.Contains(interactiveStateChecker);
	}

	private void ResetIconShow(bool isFinishInter)
	{
		if (!entity.IsActorEntity)
		{
			return;
		}
		for (int i = 0; i < maxInteractiveCount; i++)
		{
			if (interactiveStateCheckers.Count > i)
			{
				entity.GetSystem<TouchSystem>().ShowInteraction(i, isShow: true, interactiveStateCheckers[i].GetIcon(), interactiveStateCheckers[i].GetName(), interactiveStateCheckers[i].GetInteractiveTime(), i == 3, isFinishInter);
			}
			else
			{
				entity.GetSystem<TouchSystem>().ShowInteraction(i, isShow: false, "empty", string.Empty, 0f, i == 3, isFinishInter);
			}
		}
	}

	public void ReleaseSkillEnergyUnenough()
	{
		showEnergyEffect = false;
		ShowEnergyEffect = true;
	}

	public void HeroEntityAddEnergy()
	{
		ShowEnergyAddEffect = false;
		ShowEnergyAddEffect = true;
	}

	public void AIReleaseSkill4()
	{
		skill4RleScucess = false;
		Skill4RleScucess = true;
	}

	public void SetBpDataMax()
	{
		_heroModel.SetBpDataMax();
	}

	public int AddBPDataImmediately(BattleProps battleProps)
	{
		return _heroModel.AddBPDataImmediately(battleProps);
	}

	private void CreateCommand(HeroSkillTypeEnum heroSkillTypeEnum)
	{
		CommandCacheData commandCacheData = ReferencePool.Acquire<CommandCacheData>();
		commandCacheData.InitData(1f, heroSkillTypeEnum);
		_commandCacheTime.ContainsKey(heroSkillTypeEnum);
		_commandCacheTime.Add(heroSkillTypeEnum, commandCacheData);
	}

	public void RefreshSkillData(BPData bpData, int index)
	{
	}

	private void InitSkill()
	{
		_command2SkillDataDic = new ObservableDictionary<HeroSkillTypeEnum, HeroSkillData>();
		_heroSKillData = new ObservableDictionary<int, HeroSkillData>();
		_heroSKillDataValueList = new List<HeroSkillData>();
		_commandCacheTime = new Dictionary<HeroSkillTypeEnum, CommandCacheData>();
		_commandBindSkillGroupDic = new Dictionary<HeroSkillTypeEnum, List<HeroSkillData>>();
		_commandBindSkillGroupOrigin = new Dictionary<HeroSkillTypeEnum, int>();
		InitSkillData();
		InitSkillCoolingData();
		SkillCultivate();
	}

	public void InitSkillData()
	{
		DRHeroSKillConfig[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroSKillConfig data) => data.HeroId == base.Entity.EntityId);
		if (dataRows.Length == 0)
		{
			return;
		}
		DRHeroSKillInfo dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillInfo data) => data.HeroId == base.Entity.EntityId && data.HeroSkillTypeEnum == HeroSkillTypeEnum.Skill4);
		string skinSuffix = "";
		if (_heroModel.IsSkin)
		{
			DRHeroSkin dataRow2 = GameEntry.DataTable.GetDataRow<DRHeroSkin>(_heroModel.SkinConfigId);
			if (dataRow2 != null && dataRow2.ChangeSkillIcon)
			{
				skinSuffix = _heroModel.SkinSuffix;
			}
		}
		for (int num = 0; num < dataRows.Length; num++)
		{
			HeroSkillData heroSkillData = HeroSkillData.Create(dataRows[num], base.Entity, skinSuffix, dataRow.Id == dataRows[num].Id);
			_heroSKillData.Add(heroSkillData.Id, heroSkillData);
			_heroSKillDataValueList.Add(heroSkillData);
		}
		InitSpSkillData(HeroSkillTypeEnum.Interaction1);
		InitSpSkillData(HeroSkillTypeEnum.Interaction2);
		InitSpSkillData(HeroSkillTypeEnum.Interaction3);
		InitSpSkillData(HeroSkillTypeEnum.Interaction4);
		InitSpSkillData(HeroSkillTypeEnum.Rescue1);
		InitSpSkillData(HeroSkillTypeEnum.Rescue2);
		InitPropSkill(this);
		InitSkillBindCommand();
	}

	private void InitSpSkillData(HeroSkillTypeEnum skillTypeEnum)
	{
		DRHeroSKillInfo sKillInfo = GameEntry.DataTable.GetDataRow((DRHeroSKillInfo data) => data.HeroSkillTypeEnum == skillTypeEnum);
		if (sKillInfo == null)
		{
			return;
		}
		DRHeroSKillConfig dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig data) => data.Id == sKillInfo.SkillId);
		if (dataRow != null)
		{
			HeroSkillData heroSkillData = HeroSkillData.Create(dataRow, base.Entity, "", xpSkill: false);
			if (!_heroSKillData.ContainsKey(heroSkillData.Id))
			{
				_heroSKillData.Add(heroSkillData.Id, heroSkillData);
				_heroSKillDataValueList.Add(heroSkillData);
			}
			_command2SkillDataDic.Add(skillTypeEnum, heroSkillData);
			CreateCommand(skillTypeEnum);
		}
	}

	private void InitPropSkill(BattleHeroData battleHeroData)
	{
		if (battleHeroData != null)
		{
			InitAPropSkill(battleHeroData.BpData, HeroSkillTypeEnum.PropSkill);
			InitAPropSkill(battleHeroData.DeputyBpData, HeroSkillTypeEnum.DeputyPropSkill);
		}
	}

	private void InitAPropSkill(BattleProps bpData, HeroSkillTypeEnum heroSkillTypeEnum)
	{
		DRHeroSKillConfig dataRow = GameEntry.DataTable.GetDataRow((DRHeroSKillConfig data) => data.Id == bpData?.SkillId);
		if (dataRow != null)
		{
			HeroSkillData heroSkillData = HeroSkillData.Create(dataRow, entity, "", xpSkill: false);
			heroSkillData.RegisterPropSkillData(bpData);
			if (!_heroSKillData.ContainsKey(heroSkillData.Id))
			{
				_heroSKillData.Add(heroSkillData.Id, heroSkillData);
				_heroSKillDataValueList.Add(heroSkillData);
				_command2SkillDataDic.Add(heroSkillTypeEnum, heroSkillData);
				CreateCommand(heroSkillTypeEnum);
			}
		}
	}

	private void InitSkillBindCommand()
	{
		DRHeroSKillInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroSKillInfo data) => data.HeroId == entity.EntityId);
		for (int num = 0; num < dataRows.Length; num++)
		{
			BindInitSkill(dataRows[num]);
			BingOriginSkill(dataRows[num]);
			BindAllSkill(dataRows[num]);
		}
	}

	private void BindInitSkill(DRHeroSKillInfo sKillInfo)
	{
		_heroSKillData.TryGetValue(sKillInfo.SkillId, out var value);
		if (value != null)
		{
			_command2SkillDataDic.Add(sKillInfo.HeroSkillTypeEnum, value);
			CommandCacheData commandCacheData = ReferencePool.Acquire<CommandCacheData>();
			commandCacheData.InitData(sKillInfo.CommandCacheTime, sKillInfo.HeroSkillTypeEnum);
			_commandCacheTime.Add(sKillInfo.HeroSkillTypeEnum, commandCacheData);
		}
	}

	private void BingOriginSkill(DRHeroSKillInfo sKillInfo)
	{
		if (!_commandBindSkillGroupOrigin.ContainsKey(sKillInfo.HeroSkillTypeEnum))
		{
			_commandBindSkillGroupOrigin.Add(sKillInfo.HeroSkillTypeEnum, sKillInfo.SkillId);
		}
	}

	public int GetOriginSkillId(HeroSkillTypeEnum skillTypeEnum)
	{
		if (_commandBindSkillGroupOrigin.TryGetValue(skillTypeEnum, out var value))
		{
			return value;
		}
		return 0;
	}

	private void BindAllSkill(DRHeroSKillInfo sKillInfo)
	{
		List<HeroSkillData> list = CollectionPool<List<HeroSkillData>, HeroSkillData>.Get();
		for (int i = 0; i < sKillInfo.CommandBindSkillGroup.Count; i++)
		{
			_heroSKillData.TryGetValue(sKillInfo.CommandBindSkillGroup[i], out var value);
			if (value == null)
			{
				return;
			}
			list.Add(value);
		}
		_commandBindSkillGroupDic.Add(sKillInfo.HeroSkillTypeEnum, list);
	}

	private void InitSkillCoolingData()
	{
		base.Entity.GetComponent<CoolingComponent>().InitCoolingData(_heroSKillData);
	}

	private void UpdateSkillData(float deltaTime, float timeScaleDeltaTime)
	{
		foreach (HeroSkillData heroSKillDataValue in _heroSKillDataValueList)
		{
			heroSKillDataValue.FixedUpdate(timeScaleDeltaTime);
		}
	}

	private void UpdateCommandCache(float deltaTime)
	{
		foreach (CommandCacheData value in _commandCacheTime.Values)
		{
			value.FixedUpdate(deltaTime);
		}
	}

	public void SkillCultivateTest(DRCultivateSkillEffect cultivateSkillEffect, int skillId)
	{
		GetSkillData(skillId).CultivateSkillEffect(new List<DRCultivateSkillEffect> { cultivateSkillEffect });
	}

	private void SkillCultivate()
	{
		foreach (int key in _heroModel.SkillEffectDic.Keys)
		{
			HeroSkillData skillData = GetSkillData(key);
			List<DRCultivateSkillEffect> list = _heroModel.SkillEffectDic[key];
			if (list != null)
			{
				skillData?.CultivateSkillEffect(list);
			}
		}
		foreach (int key2 in _heroModel.SkillLevelDic.Keys)
		{
			HeroSkillData skillData2 = GetSkillData(key2);
			List<DRCultivateSkillLevel> list2 = _heroModel.SkillLevelDic[key2];
			if (list2 == null || skillData2 == null)
			{
				Log.Error($"初始化外围养成错误：技能{key2}数据为空...");
			}
			else
			{
				skillData2.CultivateSkillLevel(list2);
			}
		}
	}

	private HeroSkillData GetSkillData(int skillId)
	{
		_heroSKillData.TryGetValue(skillId, out var value);
		return value;
	}

	public void PauseDevice(bool isPause)
	{
		foreach (HeroSkillData heroSKillDataValue in _heroSKillDataValueList)
		{
			heroSKillDataValue.SetDeriveWindowExecuteState(isPause);
		}
	}

	private void ClearSkillData()
	{
		_command2SkillDataDic.Clear();
		_command2SkillDataDic = null;
		_heroSKillData.Clear();
		_heroSKillData = null;
		_heroSKillDataValueList.Clear();
		_heroSKillDataValueList = null;
		foreach (CommandCacheData value in _commandCacheTime.Values)
		{
			value.Clear();
		}
		_commandCacheTime.Clear();
		_commandCacheTime = null;
		foreach (List<HeroSkillData> value2 in _commandBindSkillGroupDic.Values)
		{
			CollectionPool<List<HeroSkillData>, HeroSkillData>.Release(value2);
		}
		_commandBindSkillGroupDic.Clear();
		_commandBindSkillGroupDic = null;
	}

	public void SkillResouceInit()
	{
		if (_heroSKillData == null)
		{
			return;
		}
		foreach (HeroSkillData value in _heroSKillData.Values)
		{
			if (value != null && value.SkillCoolingData != null)
			{
				value.SkillCoolingData.InitResourceData();
			}
		}
	}
}
