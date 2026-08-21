using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class BuffConfig : IMessage<BuffConfig>, IMessage, IEquatable<BuffConfig>, IDeepCloneable<BuffConfig>
{
	private static readonly MessageParser<BuffConfig> _parser = new MessageParser<BuffConfig>(() => new BuffConfig());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int TypeFieldNumber = 2;

	private BuffType type_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int StatusFieldNumber = 4;

	private BuffStatusType status_;

	public const int TargetFieldNumber = 5;

	private TargetCampType target_;

	public const int CountFieldNumber = 6;

	private int count_;

	public const int DuringFieldNumber = 7;

	private int during_;

	public const int TickFieldNumber = 8;

	private int tick_;

	public const int CompulsoryLiftFieldNumber = 9;

	private int compulsoryLift_;

	public const int TriggerRangeTypeFieldNumber = 10;

	private RangeType triggerRangeType_;

	public const int RangeFieldNumber = 11;

	private int range_;

	public const int DamageEffectTypeFieldNumber = 12;

	private EffectType damageEffectType_;

	public const int DamageEffectValueFieldNumber = 13;

	private int damageEffectValue_;

	public const int AddtiveEffectTypeFieldNumber = 14;

	private ItemDetailType addtiveEffectType_;

	public const int AddtiveEffectFactorFieldNumber = 15;

	private int addtiveEffectFactor_;

	public const int LimitAbilityFieldNumber = 16;

	private int limitAbility_;

	public const int ShieldValueFieldNumber = 17;

	private int shieldValue_;

	public const int LeechLifeTypeFieldNumber = 18;

	private ConversionType leechLifeType_;

	public const int LeechLifeParamFieldNumber = 19;

	private int leechLifeParam_;

	public const int TransformIDFieldNumber = 20;

	private int transformID_;

	public const int TransformAttackArrFieldNumber = 21;

	private static readonly FieldCodec<int> _repeated_transformAttackArr_codec = FieldCodec.ForInt32(170u);

	private readonly RepeatedField<int> transformAttackArr_ = new RepeatedField<int>();

	public const int TransformSkillArrFieldNumber = 22;

	private static readonly FieldCodec<int> _repeated_transformSkillArr_codec = FieldCodec.ForInt32(178u);

	private readonly RepeatedField<int> transformSkillArr_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<BuffConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[17];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BuffType Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
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
	public BuffStatusType Status
	{
		get
		{
			return status_;
		}
		set
		{
			status_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TargetCampType Target
	{
		get
		{
			return target_;
		}
		set
		{
			target_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Count
	{
		get
		{
			return count_;
		}
		set
		{
			count_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int During
	{
		get
		{
			return during_;
		}
		set
		{
			during_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tick
	{
		get
		{
			return tick_;
		}
		set
		{
			tick_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CompulsoryLift
	{
		get
		{
			return compulsoryLift_;
		}
		set
		{
			compulsoryLift_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RangeType TriggerRangeType
	{
		get
		{
			return triggerRangeType_;
		}
		set
		{
			triggerRangeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Range
	{
		get
		{
			return range_;
		}
		set
		{
			range_ = value;
		}
	}

	[DebuggerNonUserCode]
	public EffectType DamageEffectType
	{
		get
		{
			return damageEffectType_;
		}
		set
		{
			damageEffectType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DamageEffectValue
	{
		get
		{
			return damageEffectValue_;
		}
		set
		{
			damageEffectValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ItemDetailType AddtiveEffectType
	{
		get
		{
			return addtiveEffectType_;
		}
		set
		{
			addtiveEffectType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AddtiveEffectFactor
	{
		get
		{
			return addtiveEffectFactor_;
		}
		set
		{
			addtiveEffectFactor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LimitAbility
	{
		get
		{
			return limitAbility_;
		}
		set
		{
			limitAbility_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShieldValue
	{
		get
		{
			return shieldValue_;
		}
		set
		{
			shieldValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ConversionType LeechLifeType
	{
		get
		{
			return leechLifeType_;
		}
		set
		{
			leechLifeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LeechLifeParam
	{
		get
		{
			return leechLifeParam_;
		}
		set
		{
			leechLifeParam_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TransformID
	{
		get
		{
			return transformID_;
		}
		set
		{
			transformID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TransformAttackArr => transformAttackArr_;

	[DebuggerNonUserCode]
	public RepeatedField<int> TransformSkillArr => transformSkillArr_;

	[DebuggerNonUserCode]
	public BuffConfig()
	{
	}

	[DebuggerNonUserCode]
	public BuffConfig(BuffConfig other)
		: this()
	{
		iD_ = other.iD_;
		type_ = other.type_;
		name_ = other.name_;
		status_ = other.status_;
		target_ = other.target_;
		count_ = other.count_;
		during_ = other.during_;
		tick_ = other.tick_;
		compulsoryLift_ = other.compulsoryLift_;
		triggerRangeType_ = other.triggerRangeType_;
		range_ = other.range_;
		damageEffectType_ = other.damageEffectType_;
		damageEffectValue_ = other.damageEffectValue_;
		addtiveEffectType_ = other.addtiveEffectType_;
		addtiveEffectFactor_ = other.addtiveEffectFactor_;
		limitAbility_ = other.limitAbility_;
		shieldValue_ = other.shieldValue_;
		leechLifeType_ = other.leechLifeType_;
		leechLifeParam_ = other.leechLifeParam_;
		transformID_ = other.transformID_;
		transformAttackArr_ = other.transformAttackArr_.Clone();
		transformSkillArr_ = other.transformSkillArr_.Clone();
	}

	[DebuggerNonUserCode]
	public BuffConfig Clone()
	{
		return new BuffConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BuffConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(BuffConfig other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Status != other.Status)
		{
			return false;
		}
		if (Target != other.Target)
		{
			return false;
		}
		if (Count != other.Count)
		{
			return false;
		}
		if (During != other.During)
		{
			return false;
		}
		if (Tick != other.Tick)
		{
			return false;
		}
		if (CompulsoryLift != other.CompulsoryLift)
		{
			return false;
		}
		if (TriggerRangeType != other.TriggerRangeType)
		{
			return false;
		}
		if (Range != other.Range)
		{
			return false;
		}
		if (DamageEffectType != other.DamageEffectType)
		{
			return false;
		}
		if (DamageEffectValue != other.DamageEffectValue)
		{
			return false;
		}
		if (AddtiveEffectType != other.AddtiveEffectType)
		{
			return false;
		}
		if (AddtiveEffectFactor != other.AddtiveEffectFactor)
		{
			return false;
		}
		if (LimitAbility != other.LimitAbility)
		{
			return false;
		}
		if (ShieldValue != other.ShieldValue)
		{
			return false;
		}
		if (LeechLifeType != other.LeechLifeType)
		{
			return false;
		}
		if (LeechLifeParam != other.LeechLifeParam)
		{
			return false;
		}
		if (TransformID != other.TransformID)
		{
			return false;
		}
		if (!transformAttackArr_.Equals(other.transformAttackArr_))
		{
			return false;
		}
		if (!transformSkillArr_.Equals(other.transformSkillArr_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Type != BuffType.None)
		{
			num ^= Type.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Status != BuffStatusType.None)
		{
			num ^= Status.GetHashCode();
		}
		if (Target != TargetCampType.None)
		{
			num ^= Target.GetHashCode();
		}
		if (Count != 0)
		{
			num ^= Count.GetHashCode();
		}
		if (During != 0)
		{
			num ^= During.GetHashCode();
		}
		if (Tick != 0)
		{
			num ^= Tick.GetHashCode();
		}
		if (CompulsoryLift != 0)
		{
			num ^= CompulsoryLift.GetHashCode();
		}
		if (TriggerRangeType != RangeType.None)
		{
			num ^= TriggerRangeType.GetHashCode();
		}
		if (Range != 0)
		{
			num ^= Range.GetHashCode();
		}
		if (DamageEffectType != EffectType.None)
		{
			num ^= DamageEffectType.GetHashCode();
		}
		if (DamageEffectValue != 0)
		{
			num ^= DamageEffectValue.GetHashCode();
		}
		if (AddtiveEffectType != ItemDetailType.None)
		{
			num ^= AddtiveEffectType.GetHashCode();
		}
		if (AddtiveEffectFactor != 0)
		{
			num ^= AddtiveEffectFactor.GetHashCode();
		}
		if (LimitAbility != 0)
		{
			num ^= LimitAbility.GetHashCode();
		}
		if (ShieldValue != 0)
		{
			num ^= ShieldValue.GetHashCode();
		}
		if (LeechLifeType != ConversionType.None)
		{
			num ^= LeechLifeType.GetHashCode();
		}
		if (LeechLifeParam != 0)
		{
			num ^= LeechLifeParam.GetHashCode();
		}
		if (TransformID != 0)
		{
			num ^= TransformID.GetHashCode();
		}
		num ^= transformAttackArr_.GetHashCode();
		return num ^ transformSkillArr_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Type != BuffType.None)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)Type);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (Status != BuffStatusType.None)
		{
			output.WriteRawTag(32);
			output.WriteEnum((int)Status);
		}
		if (Target != TargetCampType.None)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)Target);
		}
		if (Count != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Count);
		}
		if (During != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(During);
		}
		if (Tick != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Tick);
		}
		if (CompulsoryLift != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CompulsoryLift);
		}
		if (TriggerRangeType != RangeType.None)
		{
			output.WriteRawTag(80);
			output.WriteEnum((int)TriggerRangeType);
		}
		if (Range != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Range);
		}
		if (DamageEffectType != EffectType.None)
		{
			output.WriteRawTag(96);
			output.WriteEnum((int)DamageEffectType);
		}
		if (DamageEffectValue != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(DamageEffectValue);
		}
		if (AddtiveEffectType != ItemDetailType.None)
		{
			output.WriteRawTag(112);
			output.WriteEnum((int)AddtiveEffectType);
		}
		if (AddtiveEffectFactor != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(AddtiveEffectFactor);
		}
		if (LimitAbility != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(LimitAbility);
		}
		if (ShieldValue != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ShieldValue);
		}
		if (LeechLifeType != ConversionType.None)
		{
			output.WriteRawTag(144, 1);
			output.WriteEnum((int)LeechLifeType);
		}
		if (LeechLifeParam != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(LeechLifeParam);
		}
		if (TransformID != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(TransformID);
		}
		transformAttackArr_.WriteTo(output, _repeated_transformAttackArr_codec);
		transformSkillArr_.WriteTo(output, _repeated_transformSkillArr_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Type != BuffType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Type);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Status != BuffStatusType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Status);
		}
		if (Target != TargetCampType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Target);
		}
		if (Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Count);
		}
		if (During != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(During);
		}
		if (Tick != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tick);
		}
		if (CompulsoryLift != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompulsoryLift);
		}
		if (TriggerRangeType != RangeType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)TriggerRangeType);
		}
		if (Range != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Range);
		}
		if (DamageEffectType != EffectType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)DamageEffectType);
		}
		if (DamageEffectValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DamageEffectValue);
		}
		if (AddtiveEffectType != ItemDetailType.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)AddtiveEffectType);
		}
		if (AddtiveEffectFactor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddtiveEffectFactor);
		}
		if (LimitAbility != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LimitAbility);
		}
		if (ShieldValue != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ShieldValue);
		}
		if (LeechLifeType != ConversionType.None)
		{
			num += 2 + CodedOutputStream.ComputeEnumSize((int)LeechLifeType);
		}
		if (LeechLifeParam != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LeechLifeParam);
		}
		if (TransformID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TransformID);
		}
		num += transformAttackArr_.CalculateSize(_repeated_transformAttackArr_codec);
		return num + transformSkillArr_.CalculateSize(_repeated_transformSkillArr_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BuffConfig other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Type != BuffType.None)
			{
				Type = other.Type;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Status != BuffStatusType.None)
			{
				Status = other.Status;
			}
			if (other.Target != TargetCampType.None)
			{
				Target = other.Target;
			}
			if (other.Count != 0)
			{
				Count = other.Count;
			}
			if (other.During != 0)
			{
				During = other.During;
			}
			if (other.Tick != 0)
			{
				Tick = other.Tick;
			}
			if (other.CompulsoryLift != 0)
			{
				CompulsoryLift = other.CompulsoryLift;
			}
			if (other.TriggerRangeType != RangeType.None)
			{
				TriggerRangeType = other.TriggerRangeType;
			}
			if (other.Range != 0)
			{
				Range = other.Range;
			}
			if (other.DamageEffectType != EffectType.None)
			{
				DamageEffectType = other.DamageEffectType;
			}
			if (other.DamageEffectValue != 0)
			{
				DamageEffectValue = other.DamageEffectValue;
			}
			if (other.AddtiveEffectType != ItemDetailType.None)
			{
				AddtiveEffectType = other.AddtiveEffectType;
			}
			if (other.AddtiveEffectFactor != 0)
			{
				AddtiveEffectFactor = other.AddtiveEffectFactor;
			}
			if (other.LimitAbility != 0)
			{
				LimitAbility = other.LimitAbility;
			}
			if (other.ShieldValue != 0)
			{
				ShieldValue = other.ShieldValue;
			}
			if (other.LeechLifeType != ConversionType.None)
			{
				LeechLifeType = other.LeechLifeType;
			}
			if (other.LeechLifeParam != 0)
			{
				LeechLifeParam = other.LeechLifeParam;
			}
			if (other.TransformID != 0)
			{
				TransformID = other.TransformID;
			}
			transformAttackArr_.Add(other.transformAttackArr_);
			transformSkillArr_.Add(other.transformSkillArr_);
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
				input.SkipLastField();
				break;
			case 8u:
				ID = input.ReadInt32();
				break;
			case 16u:
				type_ = (BuffType)input.ReadEnum();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 32u:
				status_ = (BuffStatusType)input.ReadEnum();
				break;
			case 40u:
				target_ = (TargetCampType)input.ReadEnum();
				break;
			case 48u:
				Count = input.ReadInt32();
				break;
			case 56u:
				During = input.ReadInt32();
				break;
			case 64u:
				Tick = input.ReadInt32();
				break;
			case 72u:
				CompulsoryLift = input.ReadInt32();
				break;
			case 80u:
				triggerRangeType_ = (RangeType)input.ReadEnum();
				break;
			case 88u:
				Range = input.ReadInt32();
				break;
			case 96u:
				damageEffectType_ = (EffectType)input.ReadEnum();
				break;
			case 104u:
				DamageEffectValue = input.ReadInt32();
				break;
			case 112u:
				addtiveEffectType_ = (ItemDetailType)input.ReadEnum();
				break;
			case 120u:
				AddtiveEffectFactor = input.ReadInt32();
				break;
			case 128u:
				LimitAbility = input.ReadInt32();
				break;
			case 136u:
				ShieldValue = input.ReadInt32();
				break;
			case 144u:
				leechLifeType_ = (ConversionType)input.ReadEnum();
				break;
			case 152u:
				LeechLifeParam = input.ReadInt32();
				break;
			case 160u:
				TransformID = input.ReadInt32();
				break;
			case 168u:
			case 170u:
				transformAttackArr_.AddEntriesFrom(input, _repeated_transformAttackArr_codec);
				break;
			case 176u:
			case 178u:
				transformSkillArr_.AddEntriesFrom(input, _repeated_transformSkillArr_codec);
				break;
			}
		}
	}
}
