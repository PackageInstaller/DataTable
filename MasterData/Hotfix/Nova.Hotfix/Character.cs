using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Character : IMessage<Character>, IMessage, IEquatable<Character>, IDeepCloneable<Character>
{
	private static readonly MessageParser<Character> _parser = new MessageParser<Character>(() => new Character());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int VisibleFieldNumber = 3;

	private bool visible_;

	public const int AvailableFieldNumber = 4;

	private bool available_;

	public const int GradeFieldNumber = 5;

	private int grade_;

	public const int DefaultSkinIdFieldNumber = 6;

	private int defaultSkinId_;

	public const int AdvanceSkinIdFieldNumber = 7;

	private int advanceSkinId_;

	public const int AdvanceGroupFieldNumber = 8;

	private int advanceGroup_;

	public const int AdvanceSkinUnlockLevelFieldNumber = 9;

	private int advanceSkinUnlockLevel_;

	public const int ViewIdFieldNumber = 10;

	private int viewId_;

	public const int FactionFieldNumber = 11;

	private int faction_;

	public const int WeightFieldNumber = 12;

	private int weight_;

	public const int EETFieldNumber = 13;

	private int eET_;

	public const int ClassFieldNumber = 14;

	private int class_;

	public const int CharacterAttackTypeFieldNumber = 15;

	private int characterAttackType_;

	public const int SearchTargetTypeFieldNumber = 16;

	private int searchTargetType_;

	public const int AtkSpdFieldNumber = 17;

	private int atkSpd_;

	public const int MovTypeFieldNumber = 18;

	private int movType_;

	public const int WalkSpdFieldNumber = 19;

	private int walkSpd_;

	public const int RunSpdFieldNumber = 20;

	private int runSpd_;

	public const int SpRunSpdFieldNumber = 21;

	private int spRunSpd_;

	public const int TransSpdFieldNumber = 22;

	private int transSpd_;

	public const int WalkToRunDurationFieldNumber = 23;

	private int walkToRunDuration_;

	public const int DodgeToRunAccelerationOrNotFieldNumber = 24;

	private bool dodgeToRunAccelerationOrNot_;

	public const int MovAccFieldNumber = 25;

	private int movAcc_;

	public const int RotSpdFieldNumber = 26;

	private int rotSpd_;

	public const int RotAccFieldNumber = 27;

	private int rotAcc_;

	public const int VisionDegFieldNumber = 28;

	private int visionDeg_;

	public const int VisionRngFieldNumber = 29;

	private int visionRng_;

	public const int VisionAttackRngFieldNumber = 30;

	private int visionAttackRng_;

	public const int HearRngFieldNumber = 31;

	private int hearRng_;

	public const int HearAttackRngFieldNumber = 32;

	private int hearAttackRng_;

	public const int RaiseGunRngFieldNumber = 33;

	private int raiseGunRng_;

	public const int BulletTypeFieldNumber = 34;

	private int bulletType_;

	public const int AmmoFieldNumber = 35;

	private int ammo_;

	public const int AIIdFieldNumber = 36;

	private int aIId_;

	public const int NormalAtkIdFieldNumber = 37;

	private int normalAtkId_;

	public const int DodgeIdFieldNumber = 38;

	private int dodgeId_;

	public const int SkillIdFieldNumber = 39;

	private int skillId_;

	public const int SpecialSkillIdFieldNumber = 40;

	private int specialSkillId_;

	public const int UltimateIdFieldNumber = 41;

	private int ultimateId_;

	public const int AssistAIIdFieldNumber = 42;

	private int assistAIId_;

	public const int AssistNormalAtkIdFieldNumber = 43;

	private int assistNormalAtkId_;

	public const int AssistDodgeIdFieldNumber = 44;

	private int assistDodgeId_;

	public const int AssistSkillIdFieldNumber = 45;

	private int assistSkillId_;

	public const int AssistSpecialSkillIdFieldNumber = 46;

	private int assistSpecialSkillId_;

	public const int AssistUltimateIdFieldNumber = 47;

	private int assistUltimateId_;

	public const int TalentSkillIdFieldNumber = 48;

	private int talentSkillId_;

	public const int AssistSkillOnStageTypeFieldNumber = 49;

	private int assistSkillOnStageType_;

	public const int AssistSkillAngleFieldNumber = 50;

	private int assistSkillAngle_;

	public const int AssistSkillRadiusFieldNumber = 51;

	private int assistSkillRadius_;

	public const int AssistSkillOnStageOrientationFieldNumber = 52;

	private int assistSkillOnStageOrientation_;

	public const int AssistUltimateOnStageTypeFieldNumber = 53;

	private int assistUltimateOnStageType_;

	public const int AssistUltimateAngleFieldNumber = 54;

	private int assistUltimateAngle_;

	public const int AssistUltimateRadiusFieldNumber = 55;

	private int assistUltimateRadius_;

	public const int AssistUltimateOnStageOrientationFieldNumber = 56;

	private int assistUltimateOnStageOrientation_;

	public const int SkillSemiAutoRngFieldNumber = 57;

	private int skillSemiAutoRng_;

	public const int UltimateSemiAutoRngFieldNumber = 58;

	private int ultimateSemiAutoRng_;

	public const int SwitchCDFieldNumber = 59;

	private int switchCD_;

	public const int EnergyConvRatioFieldNumber = 60;

	private int energyConvRatio_;

	public const int EnergyEfficiencyFieldNumber = 61;

	private int energyEfficiency_;

	public const int FragmentsIdFieldNumber = 62;

	private int fragmentsId_;

	public const int TransformQtyFieldNumber = 63;

	private int transformQty_;

	public const int RecruitmentQtyFieldNumber = 64;

	private int recruitmentQty_;

	public const int AttributeIdFieldNumber = 65;

	private string attributeId_ = "";

	public const int PresentsTraitIdFieldNumber = 66;

	private int presentsTraitId_;

	public const int SkillsUpgradeGroupFieldNumber = 67;

	private static readonly FieldCodec<int> _repeated_skillsUpgradeGroup_codec = FieldCodec.ForInt32(538u);

	private readonly RepeatedField<int> skillsUpgradeGroup_ = new RepeatedField<int>();

	public const int FrozenTimeHighlightUnitFieldNumber = 68;

	private int frozenTimeHighlightUnit_;

	public const int GemSlotsFieldNumber = 69;

	private static readonly FieldCodec<int> _repeated_gemSlots_codec = FieldCodec.ForInt32(554u);

	private readonly RepeatedField<int> gemSlots_ = new RepeatedField<int>();

	public const int ChargingRateFieldNumber = 70;

	private int chargingRate_;

	public const int EnergyConsumeFieldNumber = 71;

	private int energyConsume_;

	[DebuggerNonUserCode]
	public static MessageParser<Character> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(150);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool Visible
	{
		get
		{
			return visible_;
		}
		set
		{
			visible_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Available
	{
		get
		{
			return available_;
		}
		set
		{
			available_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Grade
	{
		get
		{
			return grade_;
		}
		set
		{
			grade_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DefaultSkinId
	{
		get
		{
			return defaultSkinId_;
		}
		set
		{
			defaultSkinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AdvanceSkinId
	{
		get
		{
			return advanceSkinId_;
		}
		set
		{
			advanceSkinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AdvanceGroup
	{
		get
		{
			return advanceGroup_;
		}
		set
		{
			advanceGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AdvanceSkinUnlockLevel
	{
		get
		{
			return advanceSkinUnlockLevel_;
		}
		set
		{
			advanceSkinUnlockLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ViewId
	{
		get
		{
			return viewId_;
		}
		set
		{
			viewId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Faction
	{
		get
		{
			return faction_;
		}
		set
		{
			faction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EET
	{
		get
		{
			return eET_;
		}
		set
		{
			eET_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Class
	{
		get
		{
			return class_;
		}
		set
		{
			class_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharacterAttackType
	{
		get
		{
			return characterAttackType_;
		}
		set
		{
			characterAttackType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SearchTargetType
	{
		get
		{
			return searchTargetType_;
		}
		set
		{
			searchTargetType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AtkSpd
	{
		get
		{
			return atkSpd_;
		}
		set
		{
			atkSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MovType
	{
		get
		{
			return movType_;
		}
		set
		{
			movType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WalkSpd
	{
		get
		{
			return walkSpd_;
		}
		set
		{
			walkSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RunSpd
	{
		get
		{
			return runSpd_;
		}
		set
		{
			runSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpRunSpd
	{
		get
		{
			return spRunSpd_;
		}
		set
		{
			spRunSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TransSpd
	{
		get
		{
			return transSpd_;
		}
		set
		{
			transSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WalkToRunDuration
	{
		get
		{
			return walkToRunDuration_;
		}
		set
		{
			walkToRunDuration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool DodgeToRunAccelerationOrNot
	{
		get
		{
			return dodgeToRunAccelerationOrNot_;
		}
		set
		{
			dodgeToRunAccelerationOrNot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MovAcc
	{
		get
		{
			return movAcc_;
		}
		set
		{
			movAcc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RotSpd
	{
		get
		{
			return rotSpd_;
		}
		set
		{
			rotSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RotAcc
	{
		get
		{
			return rotAcc_;
		}
		set
		{
			rotAcc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VisionDeg
	{
		get
		{
			return visionDeg_;
		}
		set
		{
			visionDeg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VisionRng
	{
		get
		{
			return visionRng_;
		}
		set
		{
			visionRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VisionAttackRng
	{
		get
		{
			return visionAttackRng_;
		}
		set
		{
			visionAttackRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HearRng
	{
		get
		{
			return hearRng_;
		}
		set
		{
			hearRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HearAttackRng
	{
		get
		{
			return hearAttackRng_;
		}
		set
		{
			hearAttackRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RaiseGunRng
	{
		get
		{
			return raiseGunRng_;
		}
		set
		{
			raiseGunRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BulletType
	{
		get
		{
			return bulletType_;
		}
		set
		{
			bulletType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Ammo
	{
		get
		{
			return ammo_;
		}
		set
		{
			ammo_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AIId
	{
		get
		{
			return aIId_;
		}
		set
		{
			aIId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NormalAtkId
	{
		get
		{
			return normalAtkId_;
		}
		set
		{
			normalAtkId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DodgeId
	{
		get
		{
			return dodgeId_;
		}
		set
		{
			dodgeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillId
	{
		get
		{
			return skillId_;
		}
		set
		{
			skillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpecialSkillId
	{
		get
		{
			return specialSkillId_;
		}
		set
		{
			specialSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UltimateId
	{
		get
		{
			return ultimateId_;
		}
		set
		{
			ultimateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistAIId
	{
		get
		{
			return assistAIId_;
		}
		set
		{
			assistAIId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistNormalAtkId
	{
		get
		{
			return assistNormalAtkId_;
		}
		set
		{
			assistNormalAtkId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistDodgeId
	{
		get
		{
			return assistDodgeId_;
		}
		set
		{
			assistDodgeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillId
	{
		get
		{
			return assistSkillId_;
		}
		set
		{
			assistSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSpecialSkillId
	{
		get
		{
			return assistSpecialSkillId_;
		}
		set
		{
			assistSpecialSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistUltimateId
	{
		get
		{
			return assistUltimateId_;
		}
		set
		{
			assistUltimateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TalentSkillId
	{
		get
		{
			return talentSkillId_;
		}
		set
		{
			talentSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillOnStageType
	{
		get
		{
			return assistSkillOnStageType_;
		}
		set
		{
			assistSkillOnStageType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillAngle
	{
		get
		{
			return assistSkillAngle_;
		}
		set
		{
			assistSkillAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillRadius
	{
		get
		{
			return assistSkillRadius_;
		}
		set
		{
			assistSkillRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillOnStageOrientation
	{
		get
		{
			return assistSkillOnStageOrientation_;
		}
		set
		{
			assistSkillOnStageOrientation_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistUltimateOnStageType
	{
		get
		{
			return assistUltimateOnStageType_;
		}
		set
		{
			assistUltimateOnStageType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistUltimateAngle
	{
		get
		{
			return assistUltimateAngle_;
		}
		set
		{
			assistUltimateAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistUltimateRadius
	{
		get
		{
			return assistUltimateRadius_;
		}
		set
		{
			assistUltimateRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistUltimateOnStageOrientation
	{
		get
		{
			return assistUltimateOnStageOrientation_;
		}
		set
		{
			assistUltimateOnStageOrientation_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillSemiAutoRng
	{
		get
		{
			return skillSemiAutoRng_;
		}
		set
		{
			skillSemiAutoRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UltimateSemiAutoRng
	{
		get
		{
			return ultimateSemiAutoRng_;
		}
		set
		{
			ultimateSemiAutoRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SwitchCD
	{
		get
		{
			return switchCD_;
		}
		set
		{
			switchCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnergyConvRatio
	{
		get
		{
			return energyConvRatio_;
		}
		set
		{
			energyConvRatio_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnergyEfficiency
	{
		get
		{
			return energyEfficiency_;
		}
		set
		{
			energyEfficiency_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FragmentsId
	{
		get
		{
			return fragmentsId_;
		}
		set
		{
			fragmentsId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TransformQty
	{
		get
		{
			return transformQty_;
		}
		set
		{
			transformQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecruitmentQty
	{
		get
		{
			return recruitmentQty_;
		}
		set
		{
			recruitmentQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AttributeId
	{
		get
		{
			return attributeId_;
		}
		set
		{
			attributeId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PresentsTraitId
	{
		get
		{
			return presentsTraitId_;
		}
		set
		{
			presentsTraitId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SkillsUpgradeGroup => skillsUpgradeGroup_;

	[DebuggerNonUserCode]
	public int FrozenTimeHighlightUnit
	{
		get
		{
			return frozenTimeHighlightUnit_;
		}
		set
		{
			frozenTimeHighlightUnit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> GemSlots => gemSlots_;

	[DebuggerNonUserCode]
	public int ChargingRate
	{
		get
		{
			return chargingRate_;
		}
		set
		{
			chargingRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnergyConsume
	{
		get
		{
			return energyConsume_;
		}
		set
		{
			energyConsume_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Character()
	{
	}

	[DebuggerNonUserCode]
	public Character(Character other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		visible_ = other.visible_;
		available_ = other.available_;
		grade_ = other.grade_;
		defaultSkinId_ = other.defaultSkinId_;
		advanceSkinId_ = other.advanceSkinId_;
		advanceGroup_ = other.advanceGroup_;
		advanceSkinUnlockLevel_ = other.advanceSkinUnlockLevel_;
		viewId_ = other.viewId_;
		faction_ = other.faction_;
		weight_ = other.weight_;
		eET_ = other.eET_;
		class_ = other.class_;
		characterAttackType_ = other.characterAttackType_;
		searchTargetType_ = other.searchTargetType_;
		atkSpd_ = other.atkSpd_;
		movType_ = other.movType_;
		walkSpd_ = other.walkSpd_;
		runSpd_ = other.runSpd_;
		spRunSpd_ = other.spRunSpd_;
		transSpd_ = other.transSpd_;
		walkToRunDuration_ = other.walkToRunDuration_;
		dodgeToRunAccelerationOrNot_ = other.dodgeToRunAccelerationOrNot_;
		movAcc_ = other.movAcc_;
		rotSpd_ = other.rotSpd_;
		rotAcc_ = other.rotAcc_;
		visionDeg_ = other.visionDeg_;
		visionRng_ = other.visionRng_;
		visionAttackRng_ = other.visionAttackRng_;
		hearRng_ = other.hearRng_;
		hearAttackRng_ = other.hearAttackRng_;
		raiseGunRng_ = other.raiseGunRng_;
		bulletType_ = other.bulletType_;
		ammo_ = other.ammo_;
		aIId_ = other.aIId_;
		normalAtkId_ = other.normalAtkId_;
		dodgeId_ = other.dodgeId_;
		skillId_ = other.skillId_;
		specialSkillId_ = other.specialSkillId_;
		ultimateId_ = other.ultimateId_;
		assistAIId_ = other.assistAIId_;
		assistNormalAtkId_ = other.assistNormalAtkId_;
		assistDodgeId_ = other.assistDodgeId_;
		assistSkillId_ = other.assistSkillId_;
		assistSpecialSkillId_ = other.assistSpecialSkillId_;
		assistUltimateId_ = other.assistUltimateId_;
		talentSkillId_ = other.talentSkillId_;
		assistSkillOnStageType_ = other.assistSkillOnStageType_;
		assistSkillAngle_ = other.assistSkillAngle_;
		assistSkillRadius_ = other.assistSkillRadius_;
		assistSkillOnStageOrientation_ = other.assistSkillOnStageOrientation_;
		assistUltimateOnStageType_ = other.assistUltimateOnStageType_;
		assistUltimateAngle_ = other.assistUltimateAngle_;
		assistUltimateRadius_ = other.assistUltimateRadius_;
		assistUltimateOnStageOrientation_ = other.assistUltimateOnStageOrientation_;
		skillSemiAutoRng_ = other.skillSemiAutoRng_;
		ultimateSemiAutoRng_ = other.ultimateSemiAutoRng_;
		switchCD_ = other.switchCD_;
		energyConvRatio_ = other.energyConvRatio_;
		energyEfficiency_ = other.energyEfficiency_;
		fragmentsId_ = other.fragmentsId_;
		transformQty_ = other.transformQty_;
		recruitmentQty_ = other.recruitmentQty_;
		attributeId_ = other.attributeId_;
		presentsTraitId_ = other.presentsTraitId_;
		skillsUpgradeGroup_ = other.skillsUpgradeGroup_.Clone();
		frozenTimeHighlightUnit_ = other.frozenTimeHighlightUnit_;
		gemSlots_ = other.gemSlots_.Clone();
		chargingRate_ = other.chargingRate_;
		energyConsume_ = other.energyConsume_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Character Clone()
	{
		return new Character(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Character);
	}

	[DebuggerNonUserCode]
	public bool Equals(Character other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Visible != other.Visible)
		{
			return false;
		}
		if (Available != other.Available)
		{
			return false;
		}
		if (Grade != other.Grade)
		{
			return false;
		}
		if (DefaultSkinId != other.DefaultSkinId)
		{
			return false;
		}
		if (AdvanceSkinId != other.AdvanceSkinId)
		{
			return false;
		}
		if (AdvanceGroup != other.AdvanceGroup)
		{
			return false;
		}
		if (AdvanceSkinUnlockLevel != other.AdvanceSkinUnlockLevel)
		{
			return false;
		}
		if (ViewId != other.ViewId)
		{
			return false;
		}
		if (Faction != other.Faction)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (EET != other.EET)
		{
			return false;
		}
		if (Class != other.Class)
		{
			return false;
		}
		if (CharacterAttackType != other.CharacterAttackType)
		{
			return false;
		}
		if (SearchTargetType != other.SearchTargetType)
		{
			return false;
		}
		if (AtkSpd != other.AtkSpd)
		{
			return false;
		}
		if (MovType != other.MovType)
		{
			return false;
		}
		if (WalkSpd != other.WalkSpd)
		{
			return false;
		}
		if (RunSpd != other.RunSpd)
		{
			return false;
		}
		if (SpRunSpd != other.SpRunSpd)
		{
			return false;
		}
		if (TransSpd != other.TransSpd)
		{
			return false;
		}
		if (WalkToRunDuration != other.WalkToRunDuration)
		{
			return false;
		}
		if (DodgeToRunAccelerationOrNot != other.DodgeToRunAccelerationOrNot)
		{
			return false;
		}
		if (MovAcc != other.MovAcc)
		{
			return false;
		}
		if (RotSpd != other.RotSpd)
		{
			return false;
		}
		if (RotAcc != other.RotAcc)
		{
			return false;
		}
		if (VisionDeg != other.VisionDeg)
		{
			return false;
		}
		if (VisionRng != other.VisionRng)
		{
			return false;
		}
		if (VisionAttackRng != other.VisionAttackRng)
		{
			return false;
		}
		if (HearRng != other.HearRng)
		{
			return false;
		}
		if (HearAttackRng != other.HearAttackRng)
		{
			return false;
		}
		if (RaiseGunRng != other.RaiseGunRng)
		{
			return false;
		}
		if (BulletType != other.BulletType)
		{
			return false;
		}
		if (Ammo != other.Ammo)
		{
			return false;
		}
		if (AIId != other.AIId)
		{
			return false;
		}
		if (NormalAtkId != other.NormalAtkId)
		{
			return false;
		}
		if (DodgeId != other.DodgeId)
		{
			return false;
		}
		if (SkillId != other.SkillId)
		{
			return false;
		}
		if (SpecialSkillId != other.SpecialSkillId)
		{
			return false;
		}
		if (UltimateId != other.UltimateId)
		{
			return false;
		}
		if (AssistAIId != other.AssistAIId)
		{
			return false;
		}
		if (AssistNormalAtkId != other.AssistNormalAtkId)
		{
			return false;
		}
		if (AssistDodgeId != other.AssistDodgeId)
		{
			return false;
		}
		if (AssistSkillId != other.AssistSkillId)
		{
			return false;
		}
		if (AssistSpecialSkillId != other.AssistSpecialSkillId)
		{
			return false;
		}
		if (AssistUltimateId != other.AssistUltimateId)
		{
			return false;
		}
		if (TalentSkillId != other.TalentSkillId)
		{
			return false;
		}
		if (AssistSkillOnStageType != other.AssistSkillOnStageType)
		{
			return false;
		}
		if (AssistSkillAngle != other.AssistSkillAngle)
		{
			return false;
		}
		if (AssistSkillRadius != other.AssistSkillRadius)
		{
			return false;
		}
		if (AssistSkillOnStageOrientation != other.AssistSkillOnStageOrientation)
		{
			return false;
		}
		if (AssistUltimateOnStageType != other.AssistUltimateOnStageType)
		{
			return false;
		}
		if (AssistUltimateAngle != other.AssistUltimateAngle)
		{
			return false;
		}
		if (AssistUltimateRadius != other.AssistUltimateRadius)
		{
			return false;
		}
		if (AssistUltimateOnStageOrientation != other.AssistUltimateOnStageOrientation)
		{
			return false;
		}
		if (SkillSemiAutoRng != other.SkillSemiAutoRng)
		{
			return false;
		}
		if (UltimateSemiAutoRng != other.UltimateSemiAutoRng)
		{
			return false;
		}
		if (SwitchCD != other.SwitchCD)
		{
			return false;
		}
		if (EnergyConvRatio != other.EnergyConvRatio)
		{
			return false;
		}
		if (EnergyEfficiency != other.EnergyEfficiency)
		{
			return false;
		}
		if (FragmentsId != other.FragmentsId)
		{
			return false;
		}
		if (TransformQty != other.TransformQty)
		{
			return false;
		}
		if (RecruitmentQty != other.RecruitmentQty)
		{
			return false;
		}
		if (AttributeId != other.AttributeId)
		{
			return false;
		}
		if (PresentsTraitId != other.PresentsTraitId)
		{
			return false;
		}
		if (!skillsUpgradeGroup_.Equals(other.skillsUpgradeGroup_))
		{
			return false;
		}
		if (FrozenTimeHighlightUnit != other.FrozenTimeHighlightUnit)
		{
			return false;
		}
		if (!gemSlots_.Equals(other.gemSlots_))
		{
			return false;
		}
		if (ChargingRate != other.ChargingRate)
		{
			return false;
		}
		if (EnergyConsume != other.EnergyConsume)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Visible)
		{
			num ^= Visible.GetHashCode();
		}
		if (Available)
		{
			num ^= Available.GetHashCode();
		}
		if (Grade != 0)
		{
			num ^= Grade.GetHashCode();
		}
		if (DefaultSkinId != 0)
		{
			num ^= DefaultSkinId.GetHashCode();
		}
		if (AdvanceSkinId != 0)
		{
			num ^= AdvanceSkinId.GetHashCode();
		}
		if (AdvanceGroup != 0)
		{
			num ^= AdvanceGroup.GetHashCode();
		}
		if (AdvanceSkinUnlockLevel != 0)
		{
			num ^= AdvanceSkinUnlockLevel.GetHashCode();
		}
		if (ViewId != 0)
		{
			num ^= ViewId.GetHashCode();
		}
		if (Faction != 0)
		{
			num ^= Faction.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (EET != 0)
		{
			num ^= EET.GetHashCode();
		}
		if (Class != 0)
		{
			num ^= Class.GetHashCode();
		}
		if (CharacterAttackType != 0)
		{
			num ^= CharacterAttackType.GetHashCode();
		}
		if (SearchTargetType != 0)
		{
			num ^= SearchTargetType.GetHashCode();
		}
		if (AtkSpd != 0)
		{
			num ^= AtkSpd.GetHashCode();
		}
		if (MovType != 0)
		{
			num ^= MovType.GetHashCode();
		}
		if (WalkSpd != 0)
		{
			num ^= WalkSpd.GetHashCode();
		}
		if (RunSpd != 0)
		{
			num ^= RunSpd.GetHashCode();
		}
		if (SpRunSpd != 0)
		{
			num ^= SpRunSpd.GetHashCode();
		}
		if (TransSpd != 0)
		{
			num ^= TransSpd.GetHashCode();
		}
		if (WalkToRunDuration != 0)
		{
			num ^= WalkToRunDuration.GetHashCode();
		}
		if (DodgeToRunAccelerationOrNot)
		{
			num ^= DodgeToRunAccelerationOrNot.GetHashCode();
		}
		if (MovAcc != 0)
		{
			num ^= MovAcc.GetHashCode();
		}
		if (RotSpd != 0)
		{
			num ^= RotSpd.GetHashCode();
		}
		if (RotAcc != 0)
		{
			num ^= RotAcc.GetHashCode();
		}
		if (VisionDeg != 0)
		{
			num ^= VisionDeg.GetHashCode();
		}
		if (VisionRng != 0)
		{
			num ^= VisionRng.GetHashCode();
		}
		if (VisionAttackRng != 0)
		{
			num ^= VisionAttackRng.GetHashCode();
		}
		if (HearRng != 0)
		{
			num ^= HearRng.GetHashCode();
		}
		if (HearAttackRng != 0)
		{
			num ^= HearAttackRng.GetHashCode();
		}
		if (RaiseGunRng != 0)
		{
			num ^= RaiseGunRng.GetHashCode();
		}
		if (BulletType != 0)
		{
			num ^= BulletType.GetHashCode();
		}
		if (Ammo != 0)
		{
			num ^= Ammo.GetHashCode();
		}
		if (AIId != 0)
		{
			num ^= AIId.GetHashCode();
		}
		if (NormalAtkId != 0)
		{
			num ^= NormalAtkId.GetHashCode();
		}
		if (DodgeId != 0)
		{
			num ^= DodgeId.GetHashCode();
		}
		if (SkillId != 0)
		{
			num ^= SkillId.GetHashCode();
		}
		if (SpecialSkillId != 0)
		{
			num ^= SpecialSkillId.GetHashCode();
		}
		if (UltimateId != 0)
		{
			num ^= UltimateId.GetHashCode();
		}
		if (AssistAIId != 0)
		{
			num ^= AssistAIId.GetHashCode();
		}
		if (AssistNormalAtkId != 0)
		{
			num ^= AssistNormalAtkId.GetHashCode();
		}
		if (AssistDodgeId != 0)
		{
			num ^= AssistDodgeId.GetHashCode();
		}
		if (AssistSkillId != 0)
		{
			num ^= AssistSkillId.GetHashCode();
		}
		if (AssistSpecialSkillId != 0)
		{
			num ^= AssistSpecialSkillId.GetHashCode();
		}
		if (AssistUltimateId != 0)
		{
			num ^= AssistUltimateId.GetHashCode();
		}
		if (TalentSkillId != 0)
		{
			num ^= TalentSkillId.GetHashCode();
		}
		if (AssistSkillOnStageType != 0)
		{
			num ^= AssistSkillOnStageType.GetHashCode();
		}
		if (AssistSkillAngle != 0)
		{
			num ^= AssistSkillAngle.GetHashCode();
		}
		if (AssistSkillRadius != 0)
		{
			num ^= AssistSkillRadius.GetHashCode();
		}
		if (AssistSkillOnStageOrientation != 0)
		{
			num ^= AssistSkillOnStageOrientation.GetHashCode();
		}
		if (AssistUltimateOnStageType != 0)
		{
			num ^= AssistUltimateOnStageType.GetHashCode();
		}
		if (AssistUltimateAngle != 0)
		{
			num ^= AssistUltimateAngle.GetHashCode();
		}
		if (AssistUltimateRadius != 0)
		{
			num ^= AssistUltimateRadius.GetHashCode();
		}
		if (AssistUltimateOnStageOrientation != 0)
		{
			num ^= AssistUltimateOnStageOrientation.GetHashCode();
		}
		if (SkillSemiAutoRng != 0)
		{
			num ^= SkillSemiAutoRng.GetHashCode();
		}
		if (UltimateSemiAutoRng != 0)
		{
			num ^= UltimateSemiAutoRng.GetHashCode();
		}
		if (SwitchCD != 0)
		{
			num ^= SwitchCD.GetHashCode();
		}
		if (EnergyConvRatio != 0)
		{
			num ^= EnergyConvRatio.GetHashCode();
		}
		if (EnergyEfficiency != 0)
		{
			num ^= EnergyEfficiency.GetHashCode();
		}
		if (FragmentsId != 0)
		{
			num ^= FragmentsId.GetHashCode();
		}
		if (TransformQty != 0)
		{
			num ^= TransformQty.GetHashCode();
		}
		if (RecruitmentQty != 0)
		{
			num ^= RecruitmentQty.GetHashCode();
		}
		if (AttributeId.Length != 0)
		{
			num ^= AttributeId.GetHashCode();
		}
		if (PresentsTraitId != 0)
		{
			num ^= PresentsTraitId.GetHashCode();
		}
		num ^= skillsUpgradeGroup_.GetHashCode();
		if (FrozenTimeHighlightUnit != 0)
		{
			num ^= FrozenTimeHighlightUnit.GetHashCode();
		}
		num ^= gemSlots_.GetHashCode();
		if (ChargingRate != 0)
		{
			num ^= ChargingRate.GetHashCode();
		}
		if (EnergyConsume != 0)
		{
			num ^= EnergyConsume.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Visible)
		{
			output.WriteRawTag(24);
			output.WriteBool(Visible);
		}
		if (Available)
		{
			output.WriteRawTag(32);
			output.WriteBool(Available);
		}
		if (Grade != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Grade);
		}
		if (DefaultSkinId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(DefaultSkinId);
		}
		if (AdvanceSkinId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AdvanceSkinId);
		}
		if (AdvanceGroup != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AdvanceGroup);
		}
		if (AdvanceSkinUnlockLevel != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AdvanceSkinUnlockLevel);
		}
		if (ViewId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ViewId);
		}
		if (Faction != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Faction);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Weight);
		}
		if (EET != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(EET);
		}
		if (Class != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Class);
		}
		if (CharacterAttackType != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(CharacterAttackType);
		}
		if (SearchTargetType != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(SearchTargetType);
		}
		if (AtkSpd != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(AtkSpd);
		}
		if (MovType != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(MovType);
		}
		if (WalkSpd != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(WalkSpd);
		}
		if (RunSpd != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(RunSpd);
		}
		if (SpRunSpd != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(SpRunSpd);
		}
		if (TransSpd != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(TransSpd);
		}
		if (WalkToRunDuration != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(WalkToRunDuration);
		}
		if (DodgeToRunAccelerationOrNot)
		{
			output.WriteRawTag(192, 1);
			output.WriteBool(DodgeToRunAccelerationOrNot);
		}
		if (MovAcc != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(MovAcc);
		}
		if (RotSpd != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(RotSpd);
		}
		if (RotAcc != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(RotAcc);
		}
		if (VisionDeg != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(VisionDeg);
		}
		if (VisionRng != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(VisionRng);
		}
		if (VisionAttackRng != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(VisionAttackRng);
		}
		if (HearRng != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(HearRng);
		}
		if (HearAttackRng != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(HearAttackRng);
		}
		if (RaiseGunRng != 0)
		{
			output.WriteRawTag(136, 2);
			output.WriteInt32(RaiseGunRng);
		}
		if (BulletType != 0)
		{
			output.WriteRawTag(144, 2);
			output.WriteInt32(BulletType);
		}
		if (Ammo != 0)
		{
			output.WriteRawTag(152, 2);
			output.WriteInt32(Ammo);
		}
		if (AIId != 0)
		{
			output.WriteRawTag(160, 2);
			output.WriteInt32(AIId);
		}
		if (NormalAtkId != 0)
		{
			output.WriteRawTag(168, 2);
			output.WriteInt32(NormalAtkId);
		}
		if (DodgeId != 0)
		{
			output.WriteRawTag(176, 2);
			output.WriteInt32(DodgeId);
		}
		if (SkillId != 0)
		{
			output.WriteRawTag(184, 2);
			output.WriteInt32(SkillId);
		}
		if (SpecialSkillId != 0)
		{
			output.WriteRawTag(192, 2);
			output.WriteInt32(SpecialSkillId);
		}
		if (UltimateId != 0)
		{
			output.WriteRawTag(200, 2);
			output.WriteInt32(UltimateId);
		}
		if (AssistAIId != 0)
		{
			output.WriteRawTag(208, 2);
			output.WriteInt32(AssistAIId);
		}
		if (AssistNormalAtkId != 0)
		{
			output.WriteRawTag(216, 2);
			output.WriteInt32(AssistNormalAtkId);
		}
		if (AssistDodgeId != 0)
		{
			output.WriteRawTag(224, 2);
			output.WriteInt32(AssistDodgeId);
		}
		if (AssistSkillId != 0)
		{
			output.WriteRawTag(232, 2);
			output.WriteInt32(AssistSkillId);
		}
		if (AssistSpecialSkillId != 0)
		{
			output.WriteRawTag(240, 2);
			output.WriteInt32(AssistSpecialSkillId);
		}
		if (AssistUltimateId != 0)
		{
			output.WriteRawTag(248, 2);
			output.WriteInt32(AssistUltimateId);
		}
		if (TalentSkillId != 0)
		{
			output.WriteRawTag(128, 3);
			output.WriteInt32(TalentSkillId);
		}
		if (AssistSkillOnStageType != 0)
		{
			output.WriteRawTag(136, 3);
			output.WriteInt32(AssistSkillOnStageType);
		}
		if (AssistSkillAngle != 0)
		{
			output.WriteRawTag(144, 3);
			output.WriteInt32(AssistSkillAngle);
		}
		if (AssistSkillRadius != 0)
		{
			output.WriteRawTag(152, 3);
			output.WriteInt32(AssistSkillRadius);
		}
		if (AssistSkillOnStageOrientation != 0)
		{
			output.WriteRawTag(160, 3);
			output.WriteInt32(AssistSkillOnStageOrientation);
		}
		if (AssistUltimateOnStageType != 0)
		{
			output.WriteRawTag(168, 3);
			output.WriteInt32(AssistUltimateOnStageType);
		}
		if (AssistUltimateAngle != 0)
		{
			output.WriteRawTag(176, 3);
			output.WriteInt32(AssistUltimateAngle);
		}
		if (AssistUltimateRadius != 0)
		{
			output.WriteRawTag(184, 3);
			output.WriteInt32(AssistUltimateRadius);
		}
		if (AssistUltimateOnStageOrientation != 0)
		{
			output.WriteRawTag(192, 3);
			output.WriteInt32(AssistUltimateOnStageOrientation);
		}
		if (SkillSemiAutoRng != 0)
		{
			output.WriteRawTag(200, 3);
			output.WriteInt32(SkillSemiAutoRng);
		}
		if (UltimateSemiAutoRng != 0)
		{
			output.WriteRawTag(208, 3);
			output.WriteInt32(UltimateSemiAutoRng);
		}
		if (SwitchCD != 0)
		{
			output.WriteRawTag(216, 3);
			output.WriteInt32(SwitchCD);
		}
		if (EnergyConvRatio != 0)
		{
			output.WriteRawTag(224, 3);
			output.WriteInt32(EnergyConvRatio);
		}
		if (EnergyEfficiency != 0)
		{
			output.WriteRawTag(232, 3);
			output.WriteInt32(EnergyEfficiency);
		}
		if (FragmentsId != 0)
		{
			output.WriteRawTag(240, 3);
			output.WriteInt32(FragmentsId);
		}
		if (TransformQty != 0)
		{
			output.WriteRawTag(248, 3);
			output.WriteInt32(TransformQty);
		}
		if (RecruitmentQty != 0)
		{
			output.WriteRawTag(128, 4);
			output.WriteInt32(RecruitmentQty);
		}
		if (AttributeId.Length != 0)
		{
			output.WriteRawTag(138, 4);
			output.WriteString(AttributeId);
		}
		if (PresentsTraitId != 0)
		{
			output.WriteRawTag(144, 4);
			output.WriteInt32(PresentsTraitId);
		}
		skillsUpgradeGroup_.WriteTo(output, _repeated_skillsUpgradeGroup_codec);
		if (FrozenTimeHighlightUnit != 0)
		{
			output.WriteRawTag(160, 4);
			output.WriteInt32(FrozenTimeHighlightUnit);
		}
		gemSlots_.WriteTo(output, _repeated_gemSlots_codec);
		if (ChargingRate != 0)
		{
			output.WriteRawTag(176, 4);
			output.WriteInt32(ChargingRate);
		}
		if (EnergyConsume != 0)
		{
			output.WriteRawTag(184, 4);
			output.WriteInt32(EnergyConsume);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Visible)
		{
			num += 2;
		}
		if (Available)
		{
			num += 2;
		}
		if (Grade != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Grade);
		}
		if (DefaultSkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DefaultSkinId);
		}
		if (AdvanceSkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdvanceSkinId);
		}
		if (AdvanceGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdvanceGroup);
		}
		if (AdvanceSkinUnlockLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdvanceSkinUnlockLevel);
		}
		if (ViewId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ViewId);
		}
		if (Faction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Faction);
		}
		if (Weight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (EET != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EET);
		}
		if (Class != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Class);
		}
		if (CharacterAttackType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterAttackType);
		}
		if (SearchTargetType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SearchTargetType);
		}
		if (AtkSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AtkSpd);
		}
		if (MovType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MovType);
		}
		if (WalkSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WalkSpd);
		}
		if (RunSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RunSpd);
		}
		if (SpRunSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SpRunSpd);
		}
		if (TransSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TransSpd);
		}
		if (WalkToRunDuration != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WalkToRunDuration);
		}
		if (DodgeToRunAccelerationOrNot)
		{
			num += 3;
		}
		if (MovAcc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MovAcc);
		}
		if (RotSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotSpd);
		}
		if (RotAcc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotAcc);
		}
		if (VisionDeg != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(VisionDeg);
		}
		if (VisionRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(VisionRng);
		}
		if (VisionAttackRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(VisionAttackRng);
		}
		if (HearRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HearRng);
		}
		if (HearAttackRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HearAttackRng);
		}
		if (RaiseGunRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RaiseGunRng);
		}
		if (BulletType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BulletType);
		}
		if (Ammo != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Ammo);
		}
		if (AIId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AIId);
		}
		if (NormalAtkId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NormalAtkId);
		}
		if (DodgeId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DodgeId);
		}
		if (SkillId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillId);
		}
		if (SpecialSkillId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SpecialSkillId);
		}
		if (UltimateId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(UltimateId);
		}
		if (AssistAIId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistAIId);
		}
		if (AssistNormalAtkId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistNormalAtkId);
		}
		if (AssistDodgeId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistDodgeId);
		}
		if (AssistSkillId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillId);
		}
		if (AssistSpecialSkillId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSpecialSkillId);
		}
		if (AssistUltimateId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistUltimateId);
		}
		if (TalentSkillId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TalentSkillId);
		}
		if (AssistSkillOnStageType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillOnStageType);
		}
		if (AssistSkillAngle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillAngle);
		}
		if (AssistSkillRadius != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillRadius);
		}
		if (AssistSkillOnStageOrientation != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillOnStageOrientation);
		}
		if (AssistUltimateOnStageType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistUltimateOnStageType);
		}
		if (AssistUltimateAngle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistUltimateAngle);
		}
		if (AssistUltimateRadius != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistUltimateRadius);
		}
		if (AssistUltimateOnStageOrientation != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistUltimateOnStageOrientation);
		}
		if (SkillSemiAutoRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillSemiAutoRng);
		}
		if (UltimateSemiAutoRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(UltimateSemiAutoRng);
		}
		if (SwitchCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SwitchCD);
		}
		if (EnergyConvRatio != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EnergyConvRatio);
		}
		if (EnergyEfficiency != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EnergyEfficiency);
		}
		if (FragmentsId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FragmentsId);
		}
		if (TransformQty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TransformQty);
		}
		if (RecruitmentQty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RecruitmentQty);
		}
		if (AttributeId.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AttributeId);
		}
		if (PresentsTraitId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PresentsTraitId);
		}
		num += skillsUpgradeGroup_.CalculateSize(_repeated_skillsUpgradeGroup_codec);
		if (FrozenTimeHighlightUnit != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FrozenTimeHighlightUnit);
		}
		num += gemSlots_.CalculateSize(_repeated_gemSlots_codec);
		if (ChargingRate != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ChargingRate);
		}
		if (EnergyConsume != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EnergyConsume);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Character other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Visible)
			{
				Visible = other.Visible;
			}
			if (other.Available)
			{
				Available = other.Available;
			}
			if (other.Grade != 0)
			{
				Grade = other.Grade;
			}
			if (other.DefaultSkinId != 0)
			{
				DefaultSkinId = other.DefaultSkinId;
			}
			if (other.AdvanceSkinId != 0)
			{
				AdvanceSkinId = other.AdvanceSkinId;
			}
			if (other.AdvanceGroup != 0)
			{
				AdvanceGroup = other.AdvanceGroup;
			}
			if (other.AdvanceSkinUnlockLevel != 0)
			{
				AdvanceSkinUnlockLevel = other.AdvanceSkinUnlockLevel;
			}
			if (other.ViewId != 0)
			{
				ViewId = other.ViewId;
			}
			if (other.Faction != 0)
			{
				Faction = other.Faction;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.EET != 0)
			{
				EET = other.EET;
			}
			if (other.Class != 0)
			{
				Class = other.Class;
			}
			if (other.CharacterAttackType != 0)
			{
				CharacterAttackType = other.CharacterAttackType;
			}
			if (other.SearchTargetType != 0)
			{
				SearchTargetType = other.SearchTargetType;
			}
			if (other.AtkSpd != 0)
			{
				AtkSpd = other.AtkSpd;
			}
			if (other.MovType != 0)
			{
				MovType = other.MovType;
			}
			if (other.WalkSpd != 0)
			{
				WalkSpd = other.WalkSpd;
			}
			if (other.RunSpd != 0)
			{
				RunSpd = other.RunSpd;
			}
			if (other.SpRunSpd != 0)
			{
				SpRunSpd = other.SpRunSpd;
			}
			if (other.TransSpd != 0)
			{
				TransSpd = other.TransSpd;
			}
			if (other.WalkToRunDuration != 0)
			{
				WalkToRunDuration = other.WalkToRunDuration;
			}
			if (other.DodgeToRunAccelerationOrNot)
			{
				DodgeToRunAccelerationOrNot = other.DodgeToRunAccelerationOrNot;
			}
			if (other.MovAcc != 0)
			{
				MovAcc = other.MovAcc;
			}
			if (other.RotSpd != 0)
			{
				RotSpd = other.RotSpd;
			}
			if (other.RotAcc != 0)
			{
				RotAcc = other.RotAcc;
			}
			if (other.VisionDeg != 0)
			{
				VisionDeg = other.VisionDeg;
			}
			if (other.VisionRng != 0)
			{
				VisionRng = other.VisionRng;
			}
			if (other.VisionAttackRng != 0)
			{
				VisionAttackRng = other.VisionAttackRng;
			}
			if (other.HearRng != 0)
			{
				HearRng = other.HearRng;
			}
			if (other.HearAttackRng != 0)
			{
				HearAttackRng = other.HearAttackRng;
			}
			if (other.RaiseGunRng != 0)
			{
				RaiseGunRng = other.RaiseGunRng;
			}
			if (other.BulletType != 0)
			{
				BulletType = other.BulletType;
			}
			if (other.Ammo != 0)
			{
				Ammo = other.Ammo;
			}
			if (other.AIId != 0)
			{
				AIId = other.AIId;
			}
			if (other.NormalAtkId != 0)
			{
				NormalAtkId = other.NormalAtkId;
			}
			if (other.DodgeId != 0)
			{
				DodgeId = other.DodgeId;
			}
			if (other.SkillId != 0)
			{
				SkillId = other.SkillId;
			}
			if (other.SpecialSkillId != 0)
			{
				SpecialSkillId = other.SpecialSkillId;
			}
			if (other.UltimateId != 0)
			{
				UltimateId = other.UltimateId;
			}
			if (other.AssistAIId != 0)
			{
				AssistAIId = other.AssistAIId;
			}
			if (other.AssistNormalAtkId != 0)
			{
				AssistNormalAtkId = other.AssistNormalAtkId;
			}
			if (other.AssistDodgeId != 0)
			{
				AssistDodgeId = other.AssistDodgeId;
			}
			if (other.AssistSkillId != 0)
			{
				AssistSkillId = other.AssistSkillId;
			}
			if (other.AssistSpecialSkillId != 0)
			{
				AssistSpecialSkillId = other.AssistSpecialSkillId;
			}
			if (other.AssistUltimateId != 0)
			{
				AssistUltimateId = other.AssistUltimateId;
			}
			if (other.TalentSkillId != 0)
			{
				TalentSkillId = other.TalentSkillId;
			}
			if (other.AssistSkillOnStageType != 0)
			{
				AssistSkillOnStageType = other.AssistSkillOnStageType;
			}
			if (other.AssistSkillAngle != 0)
			{
				AssistSkillAngle = other.AssistSkillAngle;
			}
			if (other.AssistSkillRadius != 0)
			{
				AssistSkillRadius = other.AssistSkillRadius;
			}
			if (other.AssistSkillOnStageOrientation != 0)
			{
				AssistSkillOnStageOrientation = other.AssistSkillOnStageOrientation;
			}
			if (other.AssistUltimateOnStageType != 0)
			{
				AssistUltimateOnStageType = other.AssistUltimateOnStageType;
			}
			if (other.AssistUltimateAngle != 0)
			{
				AssistUltimateAngle = other.AssistUltimateAngle;
			}
			if (other.AssistUltimateRadius != 0)
			{
				AssistUltimateRadius = other.AssistUltimateRadius;
			}
			if (other.AssistUltimateOnStageOrientation != 0)
			{
				AssistUltimateOnStageOrientation = other.AssistUltimateOnStageOrientation;
			}
			if (other.SkillSemiAutoRng != 0)
			{
				SkillSemiAutoRng = other.SkillSemiAutoRng;
			}
			if (other.UltimateSemiAutoRng != 0)
			{
				UltimateSemiAutoRng = other.UltimateSemiAutoRng;
			}
			if (other.SwitchCD != 0)
			{
				SwitchCD = other.SwitchCD;
			}
			if (other.EnergyConvRatio != 0)
			{
				EnergyConvRatio = other.EnergyConvRatio;
			}
			if (other.EnergyEfficiency != 0)
			{
				EnergyEfficiency = other.EnergyEfficiency;
			}
			if (other.FragmentsId != 0)
			{
				FragmentsId = other.FragmentsId;
			}
			if (other.TransformQty != 0)
			{
				TransformQty = other.TransformQty;
			}
			if (other.RecruitmentQty != 0)
			{
				RecruitmentQty = other.RecruitmentQty;
			}
			if (other.AttributeId.Length != 0)
			{
				AttributeId = other.AttributeId;
			}
			if (other.PresentsTraitId != 0)
			{
				PresentsTraitId = other.PresentsTraitId;
			}
			skillsUpgradeGroup_.Add(other.skillsUpgradeGroup_);
			if (other.FrozenTimeHighlightUnit != 0)
			{
				FrozenTimeHighlightUnit = other.FrozenTimeHighlightUnit;
			}
			gemSlots_.Add(other.gemSlots_);
			if (other.ChargingRate != 0)
			{
				ChargingRate = other.ChargingRate;
			}
			if (other.EnergyConsume != 0)
			{
				EnergyConsume = other.EnergyConsume;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				Visible = input.ReadBool();
				break;
			case 32u:
				Available = input.ReadBool();
				break;
			case 40u:
				Grade = input.ReadInt32();
				break;
			case 48u:
				DefaultSkinId = input.ReadInt32();
				break;
			case 56u:
				AdvanceSkinId = input.ReadInt32();
				break;
			case 64u:
				AdvanceGroup = input.ReadInt32();
				break;
			case 72u:
				AdvanceSkinUnlockLevel = input.ReadInt32();
				break;
			case 80u:
				ViewId = input.ReadInt32();
				break;
			case 88u:
				Faction = input.ReadInt32();
				break;
			case 96u:
				Weight = input.ReadInt32();
				break;
			case 104u:
				EET = input.ReadInt32();
				break;
			case 112u:
				Class = input.ReadInt32();
				break;
			case 120u:
				CharacterAttackType = input.ReadInt32();
				break;
			case 128u:
				SearchTargetType = input.ReadInt32();
				break;
			case 136u:
				AtkSpd = input.ReadInt32();
				break;
			case 144u:
				MovType = input.ReadInt32();
				break;
			case 152u:
				WalkSpd = input.ReadInt32();
				break;
			case 160u:
				RunSpd = input.ReadInt32();
				break;
			case 168u:
				SpRunSpd = input.ReadInt32();
				break;
			case 176u:
				TransSpd = input.ReadInt32();
				break;
			case 184u:
				WalkToRunDuration = input.ReadInt32();
				break;
			case 192u:
				DodgeToRunAccelerationOrNot = input.ReadBool();
				break;
			case 200u:
				MovAcc = input.ReadInt32();
				break;
			case 208u:
				RotSpd = input.ReadInt32();
				break;
			case 216u:
				RotAcc = input.ReadInt32();
				break;
			case 224u:
				VisionDeg = input.ReadInt32();
				break;
			case 232u:
				VisionRng = input.ReadInt32();
				break;
			case 240u:
				VisionAttackRng = input.ReadInt32();
				break;
			case 248u:
				HearRng = input.ReadInt32();
				break;
			case 256u:
				HearAttackRng = input.ReadInt32();
				break;
			case 264u:
				RaiseGunRng = input.ReadInt32();
				break;
			case 272u:
				BulletType = input.ReadInt32();
				break;
			case 280u:
				Ammo = input.ReadInt32();
				break;
			case 288u:
				AIId = input.ReadInt32();
				break;
			case 296u:
				NormalAtkId = input.ReadInt32();
				break;
			case 304u:
				DodgeId = input.ReadInt32();
				break;
			case 312u:
				SkillId = input.ReadInt32();
				break;
			case 320u:
				SpecialSkillId = input.ReadInt32();
				break;
			case 328u:
				UltimateId = input.ReadInt32();
				break;
			case 336u:
				AssistAIId = input.ReadInt32();
				break;
			case 344u:
				AssistNormalAtkId = input.ReadInt32();
				break;
			case 352u:
				AssistDodgeId = input.ReadInt32();
				break;
			case 360u:
				AssistSkillId = input.ReadInt32();
				break;
			case 368u:
				AssistSpecialSkillId = input.ReadInt32();
				break;
			case 376u:
				AssistUltimateId = input.ReadInt32();
				break;
			case 384u:
				TalentSkillId = input.ReadInt32();
				break;
			case 392u:
				AssistSkillOnStageType = input.ReadInt32();
				break;
			case 400u:
				AssistSkillAngle = input.ReadInt32();
				break;
			case 408u:
				AssistSkillRadius = input.ReadInt32();
				break;
			case 416u:
				AssistSkillOnStageOrientation = input.ReadInt32();
				break;
			case 424u:
				AssistUltimateOnStageType = input.ReadInt32();
				break;
			case 432u:
				AssistUltimateAngle = input.ReadInt32();
				break;
			case 440u:
				AssistUltimateRadius = input.ReadInt32();
				break;
			case 448u:
				AssistUltimateOnStageOrientation = input.ReadInt32();
				break;
			case 456u:
				SkillSemiAutoRng = input.ReadInt32();
				break;
			case 464u:
				UltimateSemiAutoRng = input.ReadInt32();
				break;
			case 472u:
				SwitchCD = input.ReadInt32();
				break;
			case 480u:
				EnergyConvRatio = input.ReadInt32();
				break;
			case 488u:
				EnergyEfficiency = input.ReadInt32();
				break;
			case 496u:
				FragmentsId = input.ReadInt32();
				break;
			case 504u:
				TransformQty = input.ReadInt32();
				break;
			case 512u:
				RecruitmentQty = input.ReadInt32();
				break;
			case 522u:
				AttributeId = input.ReadString();
				break;
			case 528u:
				PresentsTraitId = input.ReadInt32();
				break;
			case 536u:
			case 538u:
				skillsUpgradeGroup_.AddEntriesFrom(input, _repeated_skillsUpgradeGroup_codec);
				break;
			case 544u:
				FrozenTimeHighlightUnit = input.ReadInt32();
				break;
			case 552u:
			case 554u:
				gemSlots_.AddEntriesFrom(input, _repeated_gemSlots_codec);
				break;
			case 560u:
				ChargingRate = input.ReadInt32();
				break;
			case 568u:
				EnergyConsume = input.ReadInt32();
				break;
			}
		}
	}
}
