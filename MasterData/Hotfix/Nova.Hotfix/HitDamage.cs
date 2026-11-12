using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class HitDamage : IMessage<HitDamage>, IMessage, IEquatable<HitDamage>, IDeepCloneable<HitDamage>
{
	private static readonly MessageParser<HitDamage> _parser = new MessageParser<HitDamage>(() => new HitDamage());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelTypeDataFieldNumber = 2;

	private int levelTypeData_;

	public const int LevelDataFieldNumber = 3;

	private int levelData_;

	public const int MainOrSupportFieldNumber = 4;

	private int mainOrSupport_;

	public const int HitdamageInfoFieldNumber = 5;

	private string hitdamageInfo_ = "";

	public const int DistanceTypeFieldNumber = 6;

	private int distanceType_;

	public const int SourceTypeFieldNumber = 7;

	private int sourceType_;

	public const int DamageTypeFieldNumber = 8;

	private int damageType_;

	public const int EffectTypeFieldNumber = 9;

	private int effectType_;

	public const int ElementTypeFieldNumber = 10;

	private int elementType_;

	public const int DamageTagFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_damageTag_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> damageTag_ = new RepeatedField<int>();

	public const int DamageBonusTypeFieldNumber = 12;

	private int damageBonusType_;

	public const int SkillPercentAmendFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_skillPercentAmend_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> skillPercentAmend_ = new RepeatedField<int>();

	public const int SkillAbsAmendFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_skillAbsAmend_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> skillAbsAmend_ = new RepeatedField<int>();

	public const int AdditionalSourceFieldNumber = 15;

	private int additionalSource_;

	public const int AdditionalTypeFieldNumber = 16;

	private int additionalType_;

	public const int AdditionalPercentFieldNumber = 17;

	private static readonly FieldCodec<int> _repeated_additionalPercent_codec = FieldCodec.ForInt32(138u);

	private readonly RepeatedField<int> additionalPercent_ = new RepeatedField<int>();

	public const int EnergyChargeFieldNumber = 18;

	private int energyCharge_;

	public const int TalentPercentAmendFieldNumber = 19;

	private static readonly FieldCodec<int> _repeated_talentPercentAmend_codec = FieldCodec.ForInt32(154u);

	private readonly RepeatedField<int> talentPercentAmend_ = new RepeatedField<int>();

	public const int TalentAbsAmendFieldNumber = 20;

	private static readonly FieldCodec<int> _repeated_talentAbsAmend_codec = FieldCodec.ForInt32(162u);

	private readonly RepeatedField<int> talentAbsAmend_ = new RepeatedField<int>();

	public const int IsDenseTypeFieldNumber = 21;

	private bool isDenseType_;

	public const int PerkIntensityFieldNumber = 22;

	private static readonly FieldCodec<int> _repeated_perkIntensity_codec = FieldCodec.ForInt32(178u);

	private readonly RepeatedField<int> perkIntensity_ = new RepeatedField<int>();

	public const int SkillIdFieldNumber = 23;

	private int skillId_;

	public const int SkillSlotTypeFieldNumber = 24;

	private int skillSlotType_;

	public const int PerkIdFieldNumber = 25;

	private int perkId_;

	public const int HitImmunityTimeFieldNumber = 26;

	private int hitImmunityTime_;

	public const int SingleDamageFieldNumber = 27;

	private bool singleDamage_;

	[DebuggerNonUserCode]
	public static MessageParser<HitDamage> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(422);

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
	public int LevelTypeData
	{
		get
		{
			return levelTypeData_;
		}
		set
		{
			levelTypeData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelData
	{
		get
		{
			return levelData_;
		}
		set
		{
			levelData_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MainOrSupport
	{
		get
		{
			return mainOrSupport_;
		}
		set
		{
			mainOrSupport_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string HitdamageInfo
	{
		get
		{
			return hitdamageInfo_;
		}
		set
		{
			hitdamageInfo_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DistanceType
	{
		get
		{
			return distanceType_;
		}
		set
		{
			distanceType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SourceType
	{
		get
		{
			return sourceType_;
		}
		set
		{
			sourceType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DamageType
	{
		get
		{
			return damageType_;
		}
		set
		{
			damageType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectType
	{
		get
		{
			return effectType_;
		}
		set
		{
			effectType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ElementType
	{
		get
		{
			return elementType_;
		}
		set
		{
			elementType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> DamageTag => damageTag_;

	[DebuggerNonUserCode]
	public int DamageBonusType
	{
		get
		{
			return damageBonusType_;
		}
		set
		{
			damageBonusType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SkillPercentAmend => skillPercentAmend_;

	[DebuggerNonUserCode]
	public RepeatedField<int> SkillAbsAmend => skillAbsAmend_;

	[DebuggerNonUserCode]
	public int AdditionalSource
	{
		get
		{
			return additionalSource_;
		}
		set
		{
			additionalSource_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AdditionalType
	{
		get
		{
			return additionalType_;
		}
		set
		{
			additionalType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AdditionalPercent => additionalPercent_;

	[DebuggerNonUserCode]
	public int EnergyCharge
	{
		get
		{
			return energyCharge_;
		}
		set
		{
			energyCharge_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TalentPercentAmend => talentPercentAmend_;

	[DebuggerNonUserCode]
	public RepeatedField<int> TalentAbsAmend => talentAbsAmend_;

	[DebuggerNonUserCode]
	public bool IsDenseType
	{
		get
		{
			return isDenseType_;
		}
		set
		{
			isDenseType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> PerkIntensity => perkIntensity_;

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
	public int SkillSlotType
	{
		get
		{
			return skillSlotType_;
		}
		set
		{
			skillSlotType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PerkId
	{
		get
		{
			return perkId_;
		}
		set
		{
			perkId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitImmunityTime
	{
		get
		{
			return hitImmunityTime_;
		}
		set
		{
			hitImmunityTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool SingleDamage
	{
		get
		{
			return singleDamage_;
		}
		set
		{
			singleDamage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public HitDamage()
	{
	}

	[DebuggerNonUserCode]
	public HitDamage(HitDamage other)
		: this()
	{
		id_ = other.id_;
		levelTypeData_ = other.levelTypeData_;
		levelData_ = other.levelData_;
		mainOrSupport_ = other.mainOrSupport_;
		hitdamageInfo_ = other.hitdamageInfo_;
		distanceType_ = other.distanceType_;
		sourceType_ = other.sourceType_;
		damageType_ = other.damageType_;
		effectType_ = other.effectType_;
		elementType_ = other.elementType_;
		damageTag_ = other.damageTag_.Clone();
		damageBonusType_ = other.damageBonusType_;
		skillPercentAmend_ = other.skillPercentAmend_.Clone();
		skillAbsAmend_ = other.skillAbsAmend_.Clone();
		additionalSource_ = other.additionalSource_;
		additionalType_ = other.additionalType_;
		additionalPercent_ = other.additionalPercent_.Clone();
		energyCharge_ = other.energyCharge_;
		talentPercentAmend_ = other.talentPercentAmend_.Clone();
		talentAbsAmend_ = other.talentAbsAmend_.Clone();
		isDenseType_ = other.isDenseType_;
		perkIntensity_ = other.perkIntensity_.Clone();
		skillId_ = other.skillId_;
		skillSlotType_ = other.skillSlotType_;
		perkId_ = other.perkId_;
		hitImmunityTime_ = other.hitImmunityTime_;
		singleDamage_ = other.singleDamage_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public HitDamage Clone()
	{
		return new HitDamage(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as HitDamage);
	}

	[DebuggerNonUserCode]
	public bool Equals(HitDamage other)
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
		if (LevelTypeData != other.LevelTypeData)
		{
			return false;
		}
		if (LevelData != other.LevelData)
		{
			return false;
		}
		if (MainOrSupport != other.MainOrSupport)
		{
			return false;
		}
		if (HitdamageInfo != other.HitdamageInfo)
		{
			return false;
		}
		if (DistanceType != other.DistanceType)
		{
			return false;
		}
		if (SourceType != other.SourceType)
		{
			return false;
		}
		if (DamageType != other.DamageType)
		{
			return false;
		}
		if (EffectType != other.EffectType)
		{
			return false;
		}
		if (ElementType != other.ElementType)
		{
			return false;
		}
		if (!damageTag_.Equals(other.damageTag_))
		{
			return false;
		}
		if (DamageBonusType != other.DamageBonusType)
		{
			return false;
		}
		if (!skillPercentAmend_.Equals(other.skillPercentAmend_))
		{
			return false;
		}
		if (!skillAbsAmend_.Equals(other.skillAbsAmend_))
		{
			return false;
		}
		if (AdditionalSource != other.AdditionalSource)
		{
			return false;
		}
		if (AdditionalType != other.AdditionalType)
		{
			return false;
		}
		if (!additionalPercent_.Equals(other.additionalPercent_))
		{
			return false;
		}
		if (EnergyCharge != other.EnergyCharge)
		{
			return false;
		}
		if (!talentPercentAmend_.Equals(other.talentPercentAmend_))
		{
			return false;
		}
		if (!talentAbsAmend_.Equals(other.talentAbsAmend_))
		{
			return false;
		}
		if (IsDenseType != other.IsDenseType)
		{
			return false;
		}
		if (!perkIntensity_.Equals(other.perkIntensity_))
		{
			return false;
		}
		if (SkillId != other.SkillId)
		{
			return false;
		}
		if (SkillSlotType != other.SkillSlotType)
		{
			return false;
		}
		if (PerkId != other.PerkId)
		{
			return false;
		}
		if (HitImmunityTime != other.HitImmunityTime)
		{
			return false;
		}
		if (SingleDamage != other.SingleDamage)
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
		if (LevelTypeData != 0)
		{
			num ^= LevelTypeData.GetHashCode();
		}
		if (LevelData != 0)
		{
			num ^= LevelData.GetHashCode();
		}
		if (MainOrSupport != 0)
		{
			num ^= MainOrSupport.GetHashCode();
		}
		if (HitdamageInfo.Length != 0)
		{
			num ^= HitdamageInfo.GetHashCode();
		}
		if (DistanceType != 0)
		{
			num ^= DistanceType.GetHashCode();
		}
		if (SourceType != 0)
		{
			num ^= SourceType.GetHashCode();
		}
		if (DamageType != 0)
		{
			num ^= DamageType.GetHashCode();
		}
		if (EffectType != 0)
		{
			num ^= EffectType.GetHashCode();
		}
		if (ElementType != 0)
		{
			num ^= ElementType.GetHashCode();
		}
		num ^= damageTag_.GetHashCode();
		if (DamageBonusType != 0)
		{
			num ^= DamageBonusType.GetHashCode();
		}
		num ^= skillPercentAmend_.GetHashCode();
		num ^= skillAbsAmend_.GetHashCode();
		if (AdditionalSource != 0)
		{
			num ^= AdditionalSource.GetHashCode();
		}
		if (AdditionalType != 0)
		{
			num ^= AdditionalType.GetHashCode();
		}
		num ^= additionalPercent_.GetHashCode();
		if (EnergyCharge != 0)
		{
			num ^= EnergyCharge.GetHashCode();
		}
		num ^= talentPercentAmend_.GetHashCode();
		num ^= talentAbsAmend_.GetHashCode();
		if (IsDenseType)
		{
			num ^= IsDenseType.GetHashCode();
		}
		num ^= perkIntensity_.GetHashCode();
		if (SkillId != 0)
		{
			num ^= SkillId.GetHashCode();
		}
		if (SkillSlotType != 0)
		{
			num ^= SkillSlotType.GetHashCode();
		}
		if (PerkId != 0)
		{
			num ^= PerkId.GetHashCode();
		}
		if (HitImmunityTime != 0)
		{
			num ^= HitImmunityTime.GetHashCode();
		}
		if (SingleDamage)
		{
			num ^= SingleDamage.GetHashCode();
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
		if (LevelTypeData != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LevelTypeData);
		}
		if (LevelData != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LevelData);
		}
		if (MainOrSupport != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MainOrSupport);
		}
		if (HitdamageInfo.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(HitdamageInfo);
		}
		if (DistanceType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(DistanceType);
		}
		if (SourceType != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SourceType);
		}
		if (DamageType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DamageType);
		}
		if (EffectType != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(EffectType);
		}
		if (ElementType != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ElementType);
		}
		damageTag_.WriteTo(output, _repeated_damageTag_codec);
		if (DamageBonusType != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(DamageBonusType);
		}
		skillPercentAmend_.WriteTo(output, _repeated_skillPercentAmend_codec);
		skillAbsAmend_.WriteTo(output, _repeated_skillAbsAmend_codec);
		if (AdditionalSource != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(AdditionalSource);
		}
		if (AdditionalType != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(AdditionalType);
		}
		additionalPercent_.WriteTo(output, _repeated_additionalPercent_codec);
		if (EnergyCharge != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(EnergyCharge);
		}
		talentPercentAmend_.WriteTo(output, _repeated_talentPercentAmend_codec);
		talentAbsAmend_.WriteTo(output, _repeated_talentAbsAmend_codec);
		if (IsDenseType)
		{
			output.WriteRawTag(168, 1);
			output.WriteBool(IsDenseType);
		}
		perkIntensity_.WriteTo(output, _repeated_perkIntensity_codec);
		if (SkillId != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(SkillId);
		}
		if (SkillSlotType != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(SkillSlotType);
		}
		if (PerkId != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(PerkId);
		}
		if (HitImmunityTime != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(HitImmunityTime);
		}
		if (SingleDamage)
		{
			output.WriteRawTag(216, 1);
			output.WriteBool(SingleDamage);
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
		if (LevelTypeData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelTypeData);
		}
		if (LevelData != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelData);
		}
		if (MainOrSupport != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainOrSupport);
		}
		if (HitdamageInfo.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(HitdamageInfo);
		}
		if (DistanceType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DistanceType);
		}
		if (SourceType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SourceType);
		}
		if (DamageType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DamageType);
		}
		if (EffectType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectType);
		}
		if (ElementType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ElementType);
		}
		num += damageTag_.CalculateSize(_repeated_damageTag_codec);
		if (DamageBonusType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DamageBonusType);
		}
		num += skillPercentAmend_.CalculateSize(_repeated_skillPercentAmend_codec);
		num += skillAbsAmend_.CalculateSize(_repeated_skillAbsAmend_codec);
		if (AdditionalSource != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdditionalSource);
		}
		if (AdditionalType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AdditionalType);
		}
		num += additionalPercent_.CalculateSize(_repeated_additionalPercent_codec);
		if (EnergyCharge != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EnergyCharge);
		}
		num += talentPercentAmend_.CalculateSize(_repeated_talentPercentAmend_codec);
		num += talentAbsAmend_.CalculateSize(_repeated_talentAbsAmend_codec);
		if (IsDenseType)
		{
			num += 3;
		}
		num += perkIntensity_.CalculateSize(_repeated_perkIntensity_codec);
		if (SkillId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillId);
		}
		if (SkillSlotType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillSlotType);
		}
		if (PerkId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PerkId);
		}
		if (HitImmunityTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitImmunityTime);
		}
		if (SingleDamage)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(HitDamage other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.LevelTypeData != 0)
			{
				LevelTypeData = other.LevelTypeData;
			}
			if (other.LevelData != 0)
			{
				LevelData = other.LevelData;
			}
			if (other.MainOrSupport != 0)
			{
				MainOrSupport = other.MainOrSupport;
			}
			if (other.HitdamageInfo.Length != 0)
			{
				HitdamageInfo = other.HitdamageInfo;
			}
			if (other.DistanceType != 0)
			{
				DistanceType = other.DistanceType;
			}
			if (other.SourceType != 0)
			{
				SourceType = other.SourceType;
			}
			if (other.DamageType != 0)
			{
				DamageType = other.DamageType;
			}
			if (other.EffectType != 0)
			{
				EffectType = other.EffectType;
			}
			if (other.ElementType != 0)
			{
				ElementType = other.ElementType;
			}
			damageTag_.Add(other.damageTag_);
			if (other.DamageBonusType != 0)
			{
				DamageBonusType = other.DamageBonusType;
			}
			skillPercentAmend_.Add(other.skillPercentAmend_);
			skillAbsAmend_.Add(other.skillAbsAmend_);
			if (other.AdditionalSource != 0)
			{
				AdditionalSource = other.AdditionalSource;
			}
			if (other.AdditionalType != 0)
			{
				AdditionalType = other.AdditionalType;
			}
			additionalPercent_.Add(other.additionalPercent_);
			if (other.EnergyCharge != 0)
			{
				EnergyCharge = other.EnergyCharge;
			}
			talentPercentAmend_.Add(other.talentPercentAmend_);
			talentAbsAmend_.Add(other.talentAbsAmend_);
			if (other.IsDenseType)
			{
				IsDenseType = other.IsDenseType;
			}
			perkIntensity_.Add(other.perkIntensity_);
			if (other.SkillId != 0)
			{
				SkillId = other.SkillId;
			}
			if (other.SkillSlotType != 0)
			{
				SkillSlotType = other.SkillSlotType;
			}
			if (other.PerkId != 0)
			{
				PerkId = other.PerkId;
			}
			if (other.HitImmunityTime != 0)
			{
				HitImmunityTime = other.HitImmunityTime;
			}
			if (other.SingleDamage)
			{
				SingleDamage = other.SingleDamage;
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
			case 16u:
				LevelTypeData = input.ReadInt32();
				break;
			case 24u:
				LevelData = input.ReadInt32();
				break;
			case 32u:
				MainOrSupport = input.ReadInt32();
				break;
			case 42u:
				HitdamageInfo = input.ReadString();
				break;
			case 48u:
				DistanceType = input.ReadInt32();
				break;
			case 56u:
				SourceType = input.ReadInt32();
				break;
			case 64u:
				DamageType = input.ReadInt32();
				break;
			case 72u:
				EffectType = input.ReadInt32();
				break;
			case 80u:
				ElementType = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				damageTag_.AddEntriesFrom(input, _repeated_damageTag_codec);
				break;
			case 96u:
				DamageBonusType = input.ReadInt32();
				break;
			case 104u:
			case 106u:
				skillPercentAmend_.AddEntriesFrom(input, _repeated_skillPercentAmend_codec);
				break;
			case 112u:
			case 114u:
				skillAbsAmend_.AddEntriesFrom(input, _repeated_skillAbsAmend_codec);
				break;
			case 120u:
				AdditionalSource = input.ReadInt32();
				break;
			case 128u:
				AdditionalType = input.ReadInt32();
				break;
			case 136u:
			case 138u:
				additionalPercent_.AddEntriesFrom(input, _repeated_additionalPercent_codec);
				break;
			case 144u:
				EnergyCharge = input.ReadInt32();
				break;
			case 152u:
			case 154u:
				talentPercentAmend_.AddEntriesFrom(input, _repeated_talentPercentAmend_codec);
				break;
			case 160u:
			case 162u:
				talentAbsAmend_.AddEntriesFrom(input, _repeated_talentAbsAmend_codec);
				break;
			case 168u:
				IsDenseType = input.ReadBool();
				break;
			case 176u:
			case 178u:
				perkIntensity_.AddEntriesFrom(input, _repeated_perkIntensity_codec);
				break;
			case 184u:
				SkillId = input.ReadInt32();
				break;
			case 192u:
				SkillSlotType = input.ReadInt32();
				break;
			case 200u:
				PerkId = input.ReadInt32();
				break;
			case 208u:
				HitImmunityTime = input.ReadInt32();
				break;
			case 216u:
				SingleDamage = input.ReadBool();
				break;
			}
		}
	}
}
