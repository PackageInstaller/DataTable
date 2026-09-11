using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class public_skill : IMessage<public_skill>, IMessage, IEquatable<public_skill>, IDeepCloneable<public_skill>
{
	private static readonly MessageParser<public_skill> _parser = new MessageParser<public_skill>(() => new public_skill());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int CdFieldNumber = 2;

	private int cd_;

	public const int HitDamagePecFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_hitDamagePec_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> hitDamagePec_ = new RepeatedField<int>();

	public const int HitDamageGrpFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_hitDamageGrp_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> hitDamageGrp_ = new RepeatedField<int>();

	public const int SkillDamageTypeFieldNumber = 5;

	private int skillDamageType_;

	public const int RangeFieldNumber = 6;

	private int range_;

	public const int MaxUseCountFieldNumber = 7;

	private int maxUseCount_;

	public const int BalanceValueConsumeFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_balanceValueConsume_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> balanceValueConsume_ = new RepeatedField<int>();

	public const int EnergyChangeFieldNumber = 9;

	private int energyChange_;

	public const int HighDamageIndexFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_highDamageIndex_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> highDamageIndex_ = new RepeatedField<int>();

	public const int SkillSubTypeFieldNumber = 11;

	private int skillSubType_;

	public const int SkillIndexFieldNumber = 12;

	private int skillIndex_;

	public const int SkillTypeFieldNumber = 13;

	private int skillType_;

	public const int AbilityCategoryFieldNumber = 14;

	private int abilityCategory_;

	public const int BreakValueConsumeFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_breakValueConsume_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> breakValueConsume_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<public_skill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[90];

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
	public int Cd
	{
		get
		{
			return cd_;
		}
		set
		{
			cd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> HitDamagePec => hitDamagePec_;

	[DebuggerNonUserCode]
	public RepeatedField<int> HitDamageGrp => hitDamageGrp_;

	[DebuggerNonUserCode]
	public int SkillDamageType
	{
		get
		{
			return skillDamageType_;
		}
		set
		{
			skillDamageType_ = value;
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
	public int MaxUseCount
	{
		get
		{
			return maxUseCount_;
		}
		set
		{
			maxUseCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BalanceValueConsume => balanceValueConsume_;

	[DebuggerNonUserCode]
	public int EnergyChange
	{
		get
		{
			return energyChange_;
		}
		set
		{
			energyChange_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> HighDamageIndex => highDamageIndex_;

	[DebuggerNonUserCode]
	public int SkillSubType
	{
		get
		{
			return skillSubType_;
		}
		set
		{
			skillSubType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillIndex
	{
		get
		{
			return skillIndex_;
		}
		set
		{
			skillIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillType
	{
		get
		{
			return skillType_;
		}
		set
		{
			skillType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AbilityCategory
	{
		get
		{
			return abilityCategory_;
		}
		set
		{
			abilityCategory_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BreakValueConsume => breakValueConsume_;

	[DebuggerNonUserCode]
	public public_skill()
	{
	}

	[DebuggerNonUserCode]
	public public_skill(public_skill other)
		: this()
	{
		iD_ = other.iD_;
		cd_ = other.cd_;
		hitDamagePec_ = other.hitDamagePec_.Clone();
		hitDamageGrp_ = other.hitDamageGrp_.Clone();
		skillDamageType_ = other.skillDamageType_;
		range_ = other.range_;
		maxUseCount_ = other.maxUseCount_;
		balanceValueConsume_ = other.balanceValueConsume_.Clone();
		energyChange_ = other.energyChange_;
		highDamageIndex_ = other.highDamageIndex_.Clone();
		skillSubType_ = other.skillSubType_;
		skillIndex_ = other.skillIndex_;
		skillType_ = other.skillType_;
		abilityCategory_ = other.abilityCategory_;
		breakValueConsume_ = other.breakValueConsume_.Clone();
	}

	[DebuggerNonUserCode]
	public public_skill Clone()
	{
		return new public_skill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as public_skill);
	}

	[DebuggerNonUserCode]
	public bool Equals(public_skill other)
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
		if (Cd != other.Cd)
		{
			return false;
		}
		if (!hitDamagePec_.Equals(other.hitDamagePec_))
		{
			return false;
		}
		if (!hitDamageGrp_.Equals(other.hitDamageGrp_))
		{
			return false;
		}
		if (SkillDamageType != other.SkillDamageType)
		{
			return false;
		}
		if (Range != other.Range)
		{
			return false;
		}
		if (MaxUseCount != other.MaxUseCount)
		{
			return false;
		}
		if (!balanceValueConsume_.Equals(other.balanceValueConsume_))
		{
			return false;
		}
		if (EnergyChange != other.EnergyChange)
		{
			return false;
		}
		if (!highDamageIndex_.Equals(other.highDamageIndex_))
		{
			return false;
		}
		if (SkillSubType != other.SkillSubType)
		{
			return false;
		}
		if (SkillIndex != other.SkillIndex)
		{
			return false;
		}
		if (SkillType != other.SkillType)
		{
			return false;
		}
		if (AbilityCategory != other.AbilityCategory)
		{
			return false;
		}
		if (!breakValueConsume_.Equals(other.breakValueConsume_))
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
		if (Cd != 0)
		{
			num ^= Cd.GetHashCode();
		}
		num ^= hitDamagePec_.GetHashCode();
		num ^= hitDamageGrp_.GetHashCode();
		if (SkillDamageType != 0)
		{
			num ^= SkillDamageType.GetHashCode();
		}
		if (Range != 0)
		{
			num ^= Range.GetHashCode();
		}
		if (MaxUseCount != 0)
		{
			num ^= MaxUseCount.GetHashCode();
		}
		num ^= balanceValueConsume_.GetHashCode();
		if (EnergyChange != 0)
		{
			num ^= EnergyChange.GetHashCode();
		}
		num ^= highDamageIndex_.GetHashCode();
		if (SkillSubType != 0)
		{
			num ^= SkillSubType.GetHashCode();
		}
		if (SkillIndex != 0)
		{
			num ^= SkillIndex.GetHashCode();
		}
		if (SkillType != 0)
		{
			num ^= SkillType.GetHashCode();
		}
		if (AbilityCategory != 0)
		{
			num ^= AbilityCategory.GetHashCode();
		}
		return num ^ breakValueConsume_.GetHashCode();
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
		if (Cd != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Cd);
		}
		hitDamagePec_.WriteTo(output, _repeated_hitDamagePec_codec);
		hitDamageGrp_.WriteTo(output, _repeated_hitDamageGrp_codec);
		if (SkillDamageType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SkillDamageType);
		}
		if (Range != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Range);
		}
		if (MaxUseCount != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MaxUseCount);
		}
		balanceValueConsume_.WriteTo(output, _repeated_balanceValueConsume_codec);
		if (EnergyChange != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(EnergyChange);
		}
		highDamageIndex_.WriteTo(output, _repeated_highDamageIndex_codec);
		if (SkillSubType != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(SkillSubType);
		}
		if (SkillIndex != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(SkillIndex);
		}
		if (SkillType != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(SkillType);
		}
		if (AbilityCategory != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(AbilityCategory);
		}
		breakValueConsume_.WriteTo(output, _repeated_breakValueConsume_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Cd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cd);
		}
		num += hitDamagePec_.CalculateSize(_repeated_hitDamagePec_codec);
		num += hitDamageGrp_.CalculateSize(_repeated_hitDamageGrp_codec);
		if (SkillDamageType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillDamageType);
		}
		if (Range != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Range);
		}
		if (MaxUseCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxUseCount);
		}
		num += balanceValueConsume_.CalculateSize(_repeated_balanceValueConsume_codec);
		if (EnergyChange != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnergyChange);
		}
		num += highDamageIndex_.CalculateSize(_repeated_highDamageIndex_codec);
		if (SkillSubType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillSubType);
		}
		if (SkillIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillIndex);
		}
		if (SkillType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillType);
		}
		if (AbilityCategory != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AbilityCategory);
		}
		return num + breakValueConsume_.CalculateSize(_repeated_breakValueConsume_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(public_skill other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Cd != 0)
			{
				Cd = other.Cd;
			}
			hitDamagePec_.Add(other.hitDamagePec_);
			hitDamageGrp_.Add(other.hitDamageGrp_);
			if (other.SkillDamageType != 0)
			{
				SkillDamageType = other.SkillDamageType;
			}
			if (other.Range != 0)
			{
				Range = other.Range;
			}
			if (other.MaxUseCount != 0)
			{
				MaxUseCount = other.MaxUseCount;
			}
			balanceValueConsume_.Add(other.balanceValueConsume_);
			if (other.EnergyChange != 0)
			{
				EnergyChange = other.EnergyChange;
			}
			highDamageIndex_.Add(other.highDamageIndex_);
			if (other.SkillSubType != 0)
			{
				SkillSubType = other.SkillSubType;
			}
			if (other.SkillIndex != 0)
			{
				SkillIndex = other.SkillIndex;
			}
			if (other.SkillType != 0)
			{
				SkillType = other.SkillType;
			}
			if (other.AbilityCategory != 0)
			{
				AbilityCategory = other.AbilityCategory;
			}
			breakValueConsume_.Add(other.breakValueConsume_);
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
				Cd = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				hitDamagePec_.AddEntriesFrom(input, _repeated_hitDamagePec_codec);
				break;
			case 32u:
			case 34u:
				hitDamageGrp_.AddEntriesFrom(input, _repeated_hitDamageGrp_codec);
				break;
			case 40u:
				SkillDamageType = input.ReadInt32();
				break;
			case 48u:
				Range = input.ReadInt32();
				break;
			case 56u:
				MaxUseCount = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				balanceValueConsume_.AddEntriesFrom(input, _repeated_balanceValueConsume_codec);
				break;
			case 72u:
				EnergyChange = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				highDamageIndex_.AddEntriesFrom(input, _repeated_highDamageIndex_codec);
				break;
			case 88u:
				SkillSubType = input.ReadInt32();
				break;
			case 96u:
				SkillIndex = input.ReadInt32();
				break;
			case 104u:
				SkillType = input.ReadInt32();
				break;
			case 112u:
				AbilityCategory = input.ReadInt32();
				break;
			case 120u:
			case 122u:
				breakValueConsume_.AddEntriesFrom(input, _repeated_breakValueConsume_codec);
				break;
			}
		}
	}
}
