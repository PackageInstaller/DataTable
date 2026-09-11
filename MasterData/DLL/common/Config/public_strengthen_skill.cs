using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class public_strengthen_skill : IMessage<public_strengthen_skill>, IMessage, IEquatable<public_strengthen_skill>, IDeepCloneable<public_strengthen_skill>
{
	private static readonly MessageParser<public_strengthen_skill> _parser = new MessageParser<public_strengthen_skill>(() => new public_strengthen_skill());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int HitDamagePecFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_hitDamagePec_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> hitDamagePec_ = new RepeatedField<int>();

	public const int HitDamageGrpFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_hitDamageGrp_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> hitDamageGrp_ = new RepeatedField<int>();

	public const int MaxUseCountFieldNumber = 4;

	private int maxUseCount_;

	public const int CdFieldNumber = 5;

	private int cd_;

	public const int EnergyChangeFieldNumber = 6;

	private int energyChange_;

	public const int ConditionFieldNumber = 7;

	private int condition_;

	[DebuggerNonUserCode]
	public static MessageParser<public_strengthen_skill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[91];

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
	public RepeatedField<int> HitDamagePec => hitDamagePec_;

	[DebuggerNonUserCode]
	public RepeatedField<int> HitDamageGrp => hitDamageGrp_;

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
	public int Condition
	{
		get
		{
			return condition_;
		}
		set
		{
			condition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public public_strengthen_skill()
	{
	}

	[DebuggerNonUserCode]
	public public_strengthen_skill(public_strengthen_skill other)
		: this()
	{
		iD_ = other.iD_;
		hitDamagePec_ = other.hitDamagePec_.Clone();
		hitDamageGrp_ = other.hitDamageGrp_.Clone();
		maxUseCount_ = other.maxUseCount_;
		cd_ = other.cd_;
		energyChange_ = other.energyChange_;
		condition_ = other.condition_;
	}

	[DebuggerNonUserCode]
	public public_strengthen_skill Clone()
	{
		return new public_strengthen_skill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as public_strengthen_skill);
	}

	[DebuggerNonUserCode]
	public bool Equals(public_strengthen_skill other)
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
		if (!hitDamagePec_.Equals(other.hitDamagePec_))
		{
			return false;
		}
		if (!hitDamageGrp_.Equals(other.hitDamageGrp_))
		{
			return false;
		}
		if (MaxUseCount != other.MaxUseCount)
		{
			return false;
		}
		if (Cd != other.Cd)
		{
			return false;
		}
		if (EnergyChange != other.EnergyChange)
		{
			return false;
		}
		if (Condition != other.Condition)
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
		num ^= hitDamagePec_.GetHashCode();
		num ^= hitDamageGrp_.GetHashCode();
		if (MaxUseCount != 0)
		{
			num ^= MaxUseCount.GetHashCode();
		}
		if (Cd != 0)
		{
			num ^= Cd.GetHashCode();
		}
		if (EnergyChange != 0)
		{
			num ^= EnergyChange.GetHashCode();
		}
		if (Condition != 0)
		{
			num ^= Condition.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		hitDamagePec_.WriteTo(output, _repeated_hitDamagePec_codec);
		hitDamageGrp_.WriteTo(output, _repeated_hitDamageGrp_codec);
		if (MaxUseCount != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MaxUseCount);
		}
		if (Cd != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Cd);
		}
		if (EnergyChange != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(EnergyChange);
		}
		if (Condition != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Condition);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		num += hitDamagePec_.CalculateSize(_repeated_hitDamagePec_codec);
		num += hitDamageGrp_.CalculateSize(_repeated_hitDamageGrp_codec);
		if (MaxUseCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxUseCount);
		}
		if (Cd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cd);
		}
		if (EnergyChange != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnergyChange);
		}
		if (Condition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Condition);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(public_strengthen_skill other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			hitDamagePec_.Add(other.hitDamagePec_);
			hitDamageGrp_.Add(other.hitDamageGrp_);
			if (other.MaxUseCount != 0)
			{
				MaxUseCount = other.MaxUseCount;
			}
			if (other.Cd != 0)
			{
				Cd = other.Cd;
			}
			if (other.EnergyChange != 0)
			{
				EnergyChange = other.EnergyChange;
			}
			if (other.Condition != 0)
			{
				Condition = other.Condition;
			}
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
			case 18u:
				hitDamagePec_.AddEntriesFrom(input, _repeated_hitDamagePec_codec);
				break;
			case 24u:
			case 26u:
				hitDamageGrp_.AddEntriesFrom(input, _repeated_hitDamageGrp_codec);
				break;
			case 32u:
				MaxUseCount = input.ReadInt32();
				break;
			case 40u:
				Cd = input.ReadInt32();
				break;
			case 48u:
				EnergyChange = input.ReadInt32();
				break;
			case 56u:
				Condition = input.ReadInt32();
				break;
			}
		}
	}
}
