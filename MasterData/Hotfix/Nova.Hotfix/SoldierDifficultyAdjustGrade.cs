using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierDifficultyAdjustGrade : IMessage<SoldierDifficultyAdjustGrade>, IMessage, IEquatable<SoldierDifficultyAdjustGrade>, IDeepCloneable<SoldierDifficultyAdjustGrade>
{
	private static readonly MessageParser<SoldierDifficultyAdjustGrade> _parser = new MessageParser<SoldierDifficultyAdjustGrade>(() => new SoldierDifficultyAdjustGrade());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AtkRatio1FieldNumber = 2;

	private int atkRatio1_;

	public const int AtkRatio2FieldNumber = 3;

	private int atkRatio2_;

	public const int AtkRatio3FieldNumber = 4;

	private int atkRatio3_;

	public const int HpRatio1FieldNumber = 5;

	private int hpRatio1_;

	public const int HpRatio2FieldNumber = 6;

	private int hpRatio2_;

	public const int HpRatio3FieldNumber = 7;

	private int hpRatio3_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierDifficultyAdjustGrade> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(754);

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
	public int AtkRatio1
	{
		get
		{
			return atkRatio1_;
		}
		set
		{
			atkRatio1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AtkRatio2
	{
		get
		{
			return atkRatio2_;
		}
		set
		{
			atkRatio2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AtkRatio3
	{
		get
		{
			return atkRatio3_;
		}
		set
		{
			atkRatio3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HpRatio1
	{
		get
		{
			return hpRatio1_;
		}
		set
		{
			hpRatio1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HpRatio2
	{
		get
		{
			return hpRatio2_;
		}
		set
		{
			hpRatio2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HpRatio3
	{
		get
		{
			return hpRatio3_;
		}
		set
		{
			hpRatio3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierDifficultyAdjustGrade()
	{
	}

	[DebuggerNonUserCode]
	public SoldierDifficultyAdjustGrade(SoldierDifficultyAdjustGrade other)
		: this()
	{
		id_ = other.id_;
		atkRatio1_ = other.atkRatio1_;
		atkRatio2_ = other.atkRatio2_;
		atkRatio3_ = other.atkRatio3_;
		hpRatio1_ = other.hpRatio1_;
		hpRatio2_ = other.hpRatio2_;
		hpRatio3_ = other.hpRatio3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierDifficultyAdjustGrade Clone()
	{
		return new SoldierDifficultyAdjustGrade(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierDifficultyAdjustGrade);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierDifficultyAdjustGrade other)
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
		if (AtkRatio1 != other.AtkRatio1)
		{
			return false;
		}
		if (AtkRatio2 != other.AtkRatio2)
		{
			return false;
		}
		if (AtkRatio3 != other.AtkRatio3)
		{
			return false;
		}
		if (HpRatio1 != other.HpRatio1)
		{
			return false;
		}
		if (HpRatio2 != other.HpRatio2)
		{
			return false;
		}
		if (HpRatio3 != other.HpRatio3)
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
		if (AtkRatio1 != 0)
		{
			num ^= AtkRatio1.GetHashCode();
		}
		if (AtkRatio2 != 0)
		{
			num ^= AtkRatio2.GetHashCode();
		}
		if (AtkRatio3 != 0)
		{
			num ^= AtkRatio3.GetHashCode();
		}
		if (HpRatio1 != 0)
		{
			num ^= HpRatio1.GetHashCode();
		}
		if (HpRatio2 != 0)
		{
			num ^= HpRatio2.GetHashCode();
		}
		if (HpRatio3 != 0)
		{
			num ^= HpRatio3.GetHashCode();
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
		if (AtkRatio1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AtkRatio1);
		}
		if (AtkRatio2 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AtkRatio2);
		}
		if (AtkRatio3 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AtkRatio3);
		}
		if (HpRatio1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(HpRatio1);
		}
		if (HpRatio2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(HpRatio2);
		}
		if (HpRatio3 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(HpRatio3);
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
		if (AtkRatio1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AtkRatio1);
		}
		if (AtkRatio2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AtkRatio2);
		}
		if (AtkRatio3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AtkRatio3);
		}
		if (HpRatio1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HpRatio1);
		}
		if (HpRatio2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HpRatio2);
		}
		if (HpRatio3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HpRatio3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierDifficultyAdjustGrade other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.AtkRatio1 != 0)
			{
				AtkRatio1 = other.AtkRatio1;
			}
			if (other.AtkRatio2 != 0)
			{
				AtkRatio2 = other.AtkRatio2;
			}
			if (other.AtkRatio3 != 0)
			{
				AtkRatio3 = other.AtkRatio3;
			}
			if (other.HpRatio1 != 0)
			{
				HpRatio1 = other.HpRatio1;
			}
			if (other.HpRatio2 != 0)
			{
				HpRatio2 = other.HpRatio2;
			}
			if (other.HpRatio3 != 0)
			{
				HpRatio3 = other.HpRatio3;
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
				AtkRatio1 = input.ReadInt32();
				break;
			case 24u:
				AtkRatio2 = input.ReadInt32();
				break;
			case 32u:
				AtkRatio3 = input.ReadInt32();
				break;
			case 40u:
				HpRatio1 = input.ReadInt32();
				break;
			case 48u:
				HpRatio2 = input.ReadInt32();
				break;
			case 56u:
				HpRatio3 = input.ReadInt32();
				break;
			}
		}
	}
}
