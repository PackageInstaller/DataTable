using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class ActorInfo : LogicComponent
{
	private AttributeList attributeList;

	private AdventureActor _actor;

	public Dictionary<int, FDP> attributeWithElementOrDamageTypeDict;

	public HotfixEnum.AssistOnStageType originAssistSkillOnStageType;

	public HotfixEnum.AssistOnStageType assistSkillOnStageType;

	public HotfixEnum.AssistOnStageOrientation originAssistSkillOnStageOrientation;

	public HotfixEnum.AssistOnStageOrientation assistSkillOnStageOrientation;

	public FP originAssistSkillAngle;

	public FP assistSkillAngle;

	public FP originAssistSkillRadius;

	public FP assistSkillRadius;

	public HotfixEnum.AssistOnStageType originAssistUltraOnStageType;

	public HotfixEnum.AssistOnStageType assistUltraOnStageType;

	public HotfixEnum.AssistOnStageOrientation originAssistUltraOnStageOrientation;

	public HotfixEnum.AssistOnStageOrientation assistUltraOnStageOrientation;

	public FP originAssistUltimateAngle;

	public FP assistUltimateAngle;

	public FP originAssistUltimateRadius;

	public FP assistUltimateRadius;

	public FP skillSemiAutoRng;

	public FP ultimateSemiAutoRng;

	[Space]
	public FP transSpdScale;

	[Space]
	public FP transSpd;

	[Space]
	public bool dodgeToRushAcceleration;

	protected HotfixEnum.actorMovType _moveType;

	protected FP _runSpeed;

	public bool fastSpeedMode;

	public FP fastRunSpeed;

	protected FP _walkSpeed;

	protected FP _walktoRunDuration;

	protected FP _moveAcceleration;

	protected FP _moveDeceleration;

	protected FP _moveRotationSpeed;

	protected FP _skillRotationSpeed;

	protected FP _attackSpeed;

	protected FP _shootDeviation;

	protected int _factionID;

	[Space]
	public FP runAnimationSpd;

	[Space]
	public FP spRunAnimationSpd;

	[Space]
	public FP walkAnimationSpd;

	[Space]
	public FP moveDirChangeSmoothTime;

	[Space]
	public List<FP> hurtFxRadialOffsets;

	[Space]
	public FP supCharge;

	[Space]
	public bool IsTriggerTrap;

	public FP skillCDMaxPercentAmend = 1;

	public FP skillCDMaxAmend;

	public FP dodgeCDMaxPercentAmend = 1;

	public FP dodgeCDMaxAmend;

	public FP ultraCDMaxPercentAmend = 1;

	public FP ultraCDMaxAmend;

	[HideInInspector]
	public FP ComboSpdMultiplier = 1;

	public FDP atk => GetAttributeValue(HotfixEnum.effectAttributeType.ATK);

	public FDP def => GetAttributeValue(HotfixEnum.effectAttributeType.DEF);

	public FDP originHitRate
	{
		get
		{
			return GetAttributeValue(HotfixEnum.effectAttributeType.HITRATE);
		}
		set
		{
			attributeList?.SetOriginFloatValue(HotfixEnum.effectAttributeType.HITRATE, value, FDP.One);
		}
	}

	public FDP hitRate => GetAttributeValue(HotfixEnum.effectAttributeType.HITRATE);

	public FDP evd => GetAttributeValue(HotfixEnum.effectAttributeType.EVD);

	public FDP critRate => GetAttributeValue(HotfixEnum.effectAttributeType.CRITRATE);

	public FDP opposeCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.CRITRESIST);

	public FDP critPower => GetAttributeValue(HotfixEnum.effectAttributeType.CRITPOWER_P);

	public FDP defPenetrate => GetAttributeValue(HotfixEnum.effectAttributeType.PENETRATE);

	public FDP defIgnore => GetAttributeValue(HotfixEnum.effectAttributeType.DEF_IGNORE);

	public FP originWeight => (FP)GetAttributeOriginValue(HotfixEnum.effectAttributeType.WEIGHT);

	public FP weight => (FP)GetAttributeValue(HotfixEnum.effectAttributeType.WEIGHT);

	public FDP suppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SUPPRESS);

	public FDP normalSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.NORMAL_SUPPRESS);

	public FDP skillSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SKILL_SUPPRESS);

	public FDP ultraSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.ULTRA_SUPPRESS);

	public FDP markSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.MARK_SUPPRESS);

	public FDP summonSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SUMMON_SUPPRESS);

	public FDP projectileSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.PROJECTILE_SUPPRESS);

	public FDP otherSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.OTHER_SUPPRESS);

	public FDP normalDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.NORMALDMG);

	public FDP skillDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SKILLDMG);

	public FDP ultraDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.ULTRADMG);

	public FDP otherDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.OTHERDMG);

	public FDP normalDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDNORMALDMG);

	public FDP skillDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDSKILLDMG);

	public FDP ultraDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDULTRADMG);

	public FDP otherDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDOTHERDMG);

	public FDP markDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.MARKDMG);

	public FDP markDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDMARKDMG);

	public FDP summonDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SUMMONDMG);

	public FDP summonDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDSUMMONDMG);

	public FDP projectileDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.PROJECTILEDMG);

	public FDP projectileDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDPROJECTILEDMG);

	public HotfixEnum.characterJobClass jobClass { get; set; } = HotfixEnum.characterJobClass.Vanguard;

	public HotfixEnum.characterAttackType attackType { get; set; } = HotfixEnum.characterAttackType.MELEE;

	public HotfixEnum.characterSearchTargetType searchType { get; set; } = HotfixEnum.characterSearchTargetType.MELEE;

	public string actorName { get; set; } = "UnDefine";

	public HotfixEnum.actorMovType originMoveType { get; set; }

	public HotfixEnum.actorMovType moveType
	{
		get
		{
			return _moveType;
		}
		set
		{
			_moveType = value;
		}
	}

	public HotfixEnum.FrozenTimeHighlightUnit assistWitchTimeTargetType { get; set; }

	public FP originRunSpeed { get; set; }

	public FP runSpeed
	{
		get
		{
			return (fastSpeedMode ? fastRunSpeed : _runSpeed) * (FP)moveSpeedRatio;
		}
		set
		{
			_runSpeed = value;
		}
	}

	public FP originWalkSpeed { get; set; }

	public FP walkSpeed
	{
		get
		{
			return _walkSpeed * (FP)moveSpeedRatio;
		}
		set
		{
			_walkSpeed = value;
		}
	}

	public FP walktoRunDuration
	{
		get
		{
			return _walktoRunDuration;
		}
		set
		{
			_walktoRunDuration = value;
		}
	}

	public FP moveAcceleration
	{
		get
		{
			return _moveAcceleration;
		}
		set
		{
			_moveAcceleration = value;
		}
	}

	public FP moveDeceleration
	{
		get
		{
			return _moveDeceleration;
		}
		set
		{
			_moveDeceleration = value;
		}
	}

	public FP moveRotationSpeed
	{
		get
		{
			return _moveRotationSpeed;
		}
		set
		{
			_moveRotationSpeed = value;
		}
	}

	public FP skillRotationSpeed
	{
		get
		{
			return _skillRotationSpeed;
		}
		set
		{
			_skillRotationSpeed = value;
		}
	}

	public FP originAttackSpeed { get; set; }

	public FP attackSpeed
	{
		get
		{
			return _attackSpeed;
		}
		set
		{
			_attackSpeed = value;
		}
	}

	public FP attackCooldownTime
	{
		get
		{
			if (_attackSpeed <= FP.Zero)
			{
				return AdventureModuleController.Config.Combat_MaxAttackCooldownTime;
			}
			return FP.One / _attackSpeed;
		}
	}

	public FP shootDeviation
	{
		get
		{
			return _shootDeviation;
		}
		set
		{
			_shootDeviation = value;
		}
	}

	public int originFactionID { get; set; }

	public int factionID
	{
		get
		{
			return _factionID;
		}
		set
		{
			_factionID = value;
		}
	}

	public FP normalAttackSpd => (FP)GetAttributeValue(HotfixEnum.effectAttributeType.ATKSPD_P);

	public FDP originMoveSpeedRatio
	{
		get
		{
			return attributeList?.GetOriginValue(HotfixEnum.effectAttributeType.MOVESPEED) ?? FDP.Zero;
		}
		set
		{
			attributeList?.SetOriginFloatValue(HotfixEnum.effectAttributeType.MOVESPEED, value, FDP.One);
		}
	}

	public FDP moveSpeedRatioAbsAmend
	{
		get
		{
			return attributeList?.GetAmendValue(HotfixEnum.effectAttributeType.MOVESPEED, HotfixEnum.parameterType.ABSOLUTE_VALUE) ?? FDP.Zero;
		}
		set
		{
			attributeList?.SetAmendValue(HotfixEnum.effectAttributeType.MOVESPEED, HotfixEnum.parameterType.ABSOLUTE_VALUE, value);
		}
	}

	public FDP moveSpeedRatio => GetAttributeValue(HotfixEnum.effectAttributeType.MOVESPEED);

	public FDP genDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.GENDMG);

	public FDP dmgPlus => GetAttributeValue(HotfixEnum.effectAttributeType.DMGPLUS);

	public FDP finalDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.FINALDMG);

	public FDP finalDmgPlus => GetAttributeValue(HotfixEnum.effectAttributeType.FINALDMGPLUS);

	public FDP genDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.GENDMGRCD);

	public FDP dmgPlusRcd => GetAttributeValue(HotfixEnum.effectAttributeType.DMGPLUSRCD);

	public FDP toughnessDamageRatio => GetAttributeValue(HotfixEnum.effectAttributeType.TOUGHNESS_DAMAGE_ADJUST);

	public FDP intensityRatio => GetAttributeValue(HotfixEnum.effectAttributeType.INTENSITY);

	public FDP toughnessBrokenDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.TOUGHNESS_BROKEN_DMG);

	public FDP addShieldStrengthenRatio => GetAttributeValue(HotfixEnum.effectAttributeType.ADD_SHIELD_STRENGTHEN);

	public FDP beAddShieldStrengthenRatio => GetAttributeValue(HotfixEnum.effectAttributeType.BE_ADD_SHIELD_STRENGTHEN);

	public FDP envAmendRatio => GetAttributeValue(HotfixEnum.effectAttributeType.ENV_AMEND);

	public void ChangeAttributeValueWithElementOrDamageType(int key, FDP value)
	{
		if (attributeWithElementOrDamageTypeDict == null)
		{
			attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();
		}
		if (!attributeWithElementOrDamageTypeDict.TryAdd(key, value))
		{
			attributeWithElementOrDamageTypeDict.get_Item(key) += value;
		}
		AdventureActorAttributeWithElementOrDamageTypeChangeEvent adventureActorAttributeWithElementOrDamageTypeChangeEvent = AdventureActorAttributeWithElementOrDamageTypeChangeEvent.Generate();
		adventureActorAttributeWithElementOrDamageTypeChangeEvent.sender = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorAttributeWithElementOrDamageTypeChangeEvent);
	}

	public void AssignAttributeValueWithElementOrDamageType(int key, FDP value, bool isAssign)
	{
		if (attributeWithElementOrDamageTypeDict == null)
		{
			attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();
		}
		if (isAssign)
		{
			attributeWithElementOrDamageTypeDict.set_Item(key, value);
		}
		else if (attributeWithElementOrDamageTypeDict.ContainsKey(key))
		{
			attributeWithElementOrDamageTypeDict.Remove(key);
		}
		AdventureActorAttributeWithElementOrDamageTypeChangeEvent adventureActorAttributeWithElementOrDamageTypeChangeEvent = AdventureActorAttributeWithElementOrDamageTypeChangeEvent.Generate();
		adventureActorAttributeWithElementOrDamageTypeChangeEvent.sender = _actor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorAttributeWithElementOrDamageTypeChangeEvent);
	}

	public FDP GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType type, HotfixEnum.elementType elementType, HotfixEnum.damageType damageType)
	{
		if (attributeWithElementOrDamageTypeDict == null)
		{
			attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();
		}
		bool isElementType = true;
		int elementOrDamageType = (int)elementType;
		if (damageType != HotfixEnum.damageType.NONE)
		{
			isElementType = false;
			elementOrDamageType = (int)damageType;
		}
		int key = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey((int)type, elementOrDamageType, isElementType, isBaseValue: false, isAssignValue: true);
		int key2 = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey((int)type, elementOrDamageType, isElementType, isBaseValue: true, isAssignValue: false);
		int key3 = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey((int)type, elementOrDamageType, isElementType, isBaseValue: false, isAssignValue: false);
		if (attributeWithElementOrDamageTypeDict.TryGetValue(key, out var value))
		{
			return value;
		}
		return (attributeWithElementOrDamageTypeDict.GetValueOrDefault(key2, FDP.Zero) + GetAttributeBaseValue()) * (FDP.One + GetAttributePercentAmendValue() + attributeWithElementOrDamageTypeDict.GetValueOrDefault(key3, FDP.Zero)) + GetAttributeAbsAmendValue();
		FDP GetAttributeAbsAmendValue()
		{
			if (attributeList == null)
			{
				return FDP.Zero;
			}
			return attributeList.GetAmendValue(type, HotfixEnum.parameterType.ABSOLUTE_VALUE);
		}
		FDP GetAttributeBaseValue()
		{
			if (attributeList == null)
			{
				return FDP.Zero;
			}
			return attributeList.GetBaseValue(type);
		}
		FDP GetAttributePercentAmendValue()
		{
			if (attributeList == null)
			{
				return FDP.Zero;
			}
			return attributeList.GetAmendValue(type, HotfixEnum.parameterType.PERCENTAGE);
		}
	}

	protected override void OnInit()
	{
		_actor = Entity as AdventureActor;
		if (_actor != null)
		{
			attributeList = _actor.attributeList;
			_actor.attributeList.ValueChangedEvent += OnValueChanged;
		}
	}

	public void Reset()
	{
		assistSkillOnStageType = originAssistSkillOnStageType;
		assistSkillOnStageOrientation = originAssistSkillOnStageOrientation;
		assistSkillAngle = originAssistSkillAngle;
		assistSkillRadius = originAssistSkillRadius;
		assistUltraOnStageType = originAssistUltraOnStageType;
		assistUltraOnStageOrientation = originAssistUltraOnStageOrientation;
		assistUltimateAngle = originAssistUltimateAngle;
		assistUltimateRadius = originAssistUltimateRadius;
	}

	protected override void OnShutdown()
	{
		if (_actor != null)
		{
			_actor.attributeList.ValueChangedEvent -= OnValueChanged;
		}
		attributeList = null;
		_actor = null;
		if (attributeWithElementOrDamageTypeDict != null)
		{
			attributeWithElementOrDamageTypeDict.Clear();
			attributeWithElementOrDamageTypeDict = null;
		}
	}

	private void OnValueChanged(HotfixEnum.effectAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP old, FDP diff)
	{
		switch (attributeType)
		{
		case HotfixEnum.effectAttributeType.MOVESPEED:
		{
			_actor.RefreshMoveSpeed();
			AdventureActorMoveSpeedChangedEvent adventureActorMoveSpeedChangedEvent = AdventureActorMoveSpeedChangedEvent.Generate();
			adventureActorMoveSpeedChangedEvent.actorId = _actor.Id;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorMoveSpeedChangedEvent);
			break;
		}
		case HotfixEnum.effectAttributeType.WEIGHT:
		{
			AdventureActorWeightChangedEvent adventureActorWeightChangedEvent = AdventureActorWeightChangedEvent.Generate();
			adventureActorWeightChangedEvent.actorId = _actor.Id;
			adventureActorWeightChangedEvent.originWeight = (int)(long)originWeight;
			adventureActorWeightChangedEvent.finalWeight = (int)(long)weight;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorWeightChangedEvent);
			break;
		}
		}
	}

	private FDP GetAttributeValue(HotfixEnum.effectAttributeType type)
	{
		if (attributeList == null || type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return FDP.Zero;
		}
		return attributeList.GetAttributeValue(type);
	}

	private FDP GetAttributeOriginValue(HotfixEnum.effectAttributeType type)
	{
		if (attributeList == null || type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return FDP.Zero;
		}
		return attributeList.GetOriginValue(type);
	}

	private void SetOriginIntValue(HotfixEnum.effectAttributeType type, int val, FDP ratio)
	{
		attributeList?.SetOriginIntValue(type, val, ratio);
	}

	private void SetOriginIntValueAdjust(HotfixEnum.effectAttributeType type, int val, FDP ratio, int adjustRatio, int adjustFix)
	{
		attributeList?.SetOriginIntValueAdjust(type, val, ratio, adjustRatio, adjustFix);
	}

	private void SetOriginIntFloatValue(HotfixEnum.effectAttributeType type, int val, FDP ratio)
	{
		attributeList?.SetOriginIntFloatValue(type, val, ratio);
	}

	public void SetOriginAttributeData(Attribute attributeConfig, FDP ratio)
	{
		SetOriginIntValue(HotfixEnum.effectAttributeType.ATK, attributeConfig.Atk, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DEF, attributeConfig.Def, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITRATE, attributeConfig.CritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITRESIST, attributeConfig.CritResistance, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITPOWER_P, attributeConfig.CritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.HITRATE, attributeConfig.HitRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.EVD, attributeConfig.Evd, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.PENETRATE, attributeConfig.DefPierce, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEF_IGNORE, attributeConfig.DefIgnore, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SUPPRESS, attributeConfig.Suppress, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.MARKDMG, attributeConfig.MARKDMG, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.RCDMARKDMG, attributeConfig.RCDMARKDMG, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.GENDMG, attributeConfig.GENDMG, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DMGPLUS, attributeConfig.DMGPLUS, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FINALDMG, attributeConfig.FINALDMG, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FINALDMGPLUS, attributeConfig.FINALDMGPLUS, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.WEERCD, attributeConfig.WEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FEERCD, attributeConfig.FEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SEERCD, attributeConfig.SEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.AEERCD, attributeConfig.AEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.LEERCD, attributeConfig.LEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEERCD, attributeConfig.DEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.GENDMGRCD, attributeConfig.GENDMGRCD, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DMGPLUSRCD, attributeConfig.DMGPLUSRCD, ratio);
	}

	public void SetOriginAttributeData(Monster attributeConfig, FDP ratio)
	{
		SetOriginIntValue(HotfixEnum.effectAttributeType.WEIGHT, attributeConfig.Weight, ratio);
	}

	public void SetOriginAttributeData(MonsterValueTemplete attributeConfig, MonsterValueTempleteAdjust templeteAdjustInfo, FDP ratio)
	{
		if (templeteAdjustInfo != null)
		{
			SetOriginIntValueAdjust(HotfixEnum.effectAttributeType.ATK, attributeConfig.Atk, ratio, templeteAdjustInfo.AtkRatio, templeteAdjustInfo.AtkFix);
		}
		else
		{
			SetOriginIntValue(HotfixEnum.effectAttributeType.ATK, attributeConfig.Atk, ratio);
		}
		SetOriginIntValue(HotfixEnum.effectAttributeType.DEF, attributeConfig.Def, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITRATE, attributeConfig.CritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITRESIST, attributeConfig.CritResistance, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITPOWER_P, attributeConfig.CritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.HITRATE, attributeConfig.HitRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.EVD, attributeConfig.Evd, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.PENETRATE, attributeConfig.DefPierce, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEF_IGNORE, attributeConfig.DefIgnore, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SUPPRESS, attributeConfig.Suppress, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.RCDMARKDMG, attributeConfig.RCDMARKDMG, ratio);
	}

	public void SetOriginAttributeData(Character attributeConfig, FDP ratio)
	{
		SetOriginIntValue(HotfixEnum.effectAttributeType.WEIGHT, attributeConfig.Weight, ratio);
	}

	public void SetOriginAttributeData(Lua2CSharpInfo_CharAttribute attributeConfig, FDP ratio)
	{
		SetOriginIntValue(HotfixEnum.effectAttributeType.ATK, attributeConfig.Atk, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DEF, attributeConfig.Def, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITRATE, attributeConfig.CritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITRESIST, attributeConfig.CritResistance, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.CRITPOWER_P, attributeConfig.CritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.HITRATE, attributeConfig.HitRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.EVD, attributeConfig.Evd, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.PENETRATE, attributeConfig.DefPierce, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEF_IGNORE, attributeConfig.DefIgnore, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SUPPRESS, attributeConfig.Suppress, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.NORMALDMG, attributeConfig.NormalDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SKILLDMG, attributeConfig.SkillDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.ULTRADMG, attributeConfig.UltraDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.OTHERDMG, attributeConfig.OtherDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.RCDNORMALDMG, attributeConfig.RcdNormalDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.RCDSKILLDMG, attributeConfig.RcdSkillDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.RCDULTRADMG, attributeConfig.RcdUltraDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.RCDOTHERDMG, attributeConfig.RcdOtherDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.MARKDMG, attributeConfig.MarkDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SUMMONDMG, attributeConfig.SummonDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.RCDSUMMONDMG, attributeConfig.RcdSummonDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.PROJECTILEDMG, attributeConfig.ProjectileDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.RCDPROJECTILEDMG, attributeConfig.RcdProjectileDmgRatio, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.GENDMG, attributeConfig.GENDMG, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DMGPLUS, attributeConfig.DMGPLUS, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FINALDMG, attributeConfig.FINALDMG, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FINALDMGPLUS, attributeConfig.FINALDMGPLUS, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.WEERCD, attributeConfig.WEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.FEERCD, attributeConfig.FEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SEERCD, attributeConfig.SEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.AEERCD, attributeConfig.AEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.LEERCD, attributeConfig.LEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.DEERCD, attributeConfig.DEERCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.GENDMGRCD, attributeConfig.GENDMGRCD, ratio);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DMGPLUSRCD, attributeConfig.DMGPLUSRCD, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.NORMALCRITRATE, attributeConfig.NormalCritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SKILLCRITRATE, attributeConfig.SkillCritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.ULTRACRITRATE, attributeConfig.UltraCritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.MARKCRITRATE, attributeConfig.MarkCritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SUMMONCRITRATE, attributeConfig.SummonCritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.PROJECTILECRITRATE, attributeConfig.ProjectileCritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.OTHERCRITRATE, attributeConfig.OtherCritRate, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.NORMALCRITPOWER, attributeConfig.NormalCritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SKILLCRITPOWER, attributeConfig.SkillCritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.ULTRACRITPOWER, attributeConfig.UltraCritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.MARKCRITPOWER, attributeConfig.MarkCritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.SUMMONCRITPOWER, attributeConfig.SummonCritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.PROJECTILECRITPOWER, attributeConfig.ProjectileCritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.OTHERCRITPOWER, attributeConfig.OtherCritPower, ratio);
		SetOriginIntFloatValue(HotfixEnum.effectAttributeType.TOUGHNESS_DAMAGE_ADJUST, attributeConfig.ToughnessDamageAdjust, ratio);
	}
}
