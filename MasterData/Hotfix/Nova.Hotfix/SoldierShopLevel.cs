using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierShopLevel : IMessage<SoldierShopLevel>, IMessage, IEquatable<SoldierShopLevel>, IDeepCloneable<SoldierShopLevel>
{
	private static readonly MessageParser<SoldierShopLevel> _parser = new MessageParser<SoldierShopLevel>(() => new SoldierShopLevel());

	private UnknownFieldSet _unknownFields;

	public const int LevelFieldNumber = 1;

	private int level_;

	public const int ExpFieldNumber = 2;

	private int exp_;

	public const int CountFieldNumber = 3;

	private int count_;

	public const int Rarity1FieldNumber = 4;

	private int rarity1_;

	public const int Rarity2FieldNumber = 5;

	private int rarity2_;

	public const int Rarity3FieldNumber = 6;

	private int rarity3_;

	public const int Rarity4FieldNumber = 7;

	private int rarity4_;

	public const int Rarity5FieldNumber = 8;

	private int rarity5_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierShopLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(792);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Exp
	{
		get
		{
			return exp_;
		}
		set
		{
			exp_ = value;
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
	public int Rarity1
	{
		get
		{
			return rarity1_;
		}
		set
		{
			rarity1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rarity2
	{
		get
		{
			return rarity2_;
		}
		set
		{
			rarity2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rarity3
	{
		get
		{
			return rarity3_;
		}
		set
		{
			rarity3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rarity4
	{
		get
		{
			return rarity4_;
		}
		set
		{
			rarity4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rarity5
	{
		get
		{
			return rarity5_;
		}
		set
		{
			rarity5_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierShopLevel()
	{
	}

	[DebuggerNonUserCode]
	public SoldierShopLevel(SoldierShopLevel other)
		: this()
	{
		level_ = other.level_;
		exp_ = other.exp_;
		count_ = other.count_;
		rarity1_ = other.rarity1_;
		rarity2_ = other.rarity2_;
		rarity3_ = other.rarity3_;
		rarity4_ = other.rarity4_;
		rarity5_ = other.rarity5_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierShopLevel Clone()
	{
		return new SoldierShopLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierShopLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierShopLevel other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Exp != other.Exp)
		{
			return false;
		}
		if (Count != other.Count)
		{
			return false;
		}
		if (Rarity1 != other.Rarity1)
		{
			return false;
		}
		if (Rarity2 != other.Rarity2)
		{
			return false;
		}
		if (Rarity3 != other.Rarity3)
		{
			return false;
		}
		if (Rarity4 != other.Rarity4)
		{
			return false;
		}
		if (Rarity5 != other.Rarity5)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (Count != 0)
		{
			num ^= Count.GetHashCode();
		}
		if (Rarity1 != 0)
		{
			num ^= Rarity1.GetHashCode();
		}
		if (Rarity2 != 0)
		{
			num ^= Rarity2.GetHashCode();
		}
		if (Rarity3 != 0)
		{
			num ^= Rarity3.GetHashCode();
		}
		if (Rarity4 != 0)
		{
			num ^= Rarity4.GetHashCode();
		}
		if (Rarity5 != 0)
		{
			num ^= Rarity5.GetHashCode();
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
		if (Level != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Level);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Exp);
		}
		if (Count != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Count);
		}
		if (Rarity1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Rarity1);
		}
		if (Rarity2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Rarity2);
		}
		if (Rarity3 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Rarity3);
		}
		if (Rarity4 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Rarity4);
		}
		if (Rarity5 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Rarity5);
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
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (Count != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Count);
		}
		if (Rarity1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity1);
		}
		if (Rarity2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity2);
		}
		if (Rarity3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity3);
		}
		if (Rarity4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity4);
		}
		if (Rarity5 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity5);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierShopLevel other)
	{
		if (other != null)
		{
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Exp != 0)
			{
				Exp = other.Exp;
			}
			if (other.Count != 0)
			{
				Count = other.Count;
			}
			if (other.Rarity1 != 0)
			{
				Rarity1 = other.Rarity1;
			}
			if (other.Rarity2 != 0)
			{
				Rarity2 = other.Rarity2;
			}
			if (other.Rarity3 != 0)
			{
				Rarity3 = other.Rarity3;
			}
			if (other.Rarity4 != 0)
			{
				Rarity4 = other.Rarity4;
			}
			if (other.Rarity5 != 0)
			{
				Rarity5 = other.Rarity5;
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
				Level = input.ReadInt32();
				break;
			case 16u:
				Exp = input.ReadInt32();
				break;
			case 24u:
				Count = input.ReadInt32();
				break;
			case 32u:
				Rarity1 = input.ReadInt32();
				break;
			case 40u:
				Rarity2 = input.ReadInt32();
				break;
			case 48u:
				Rarity3 = input.ReadInt32();
				break;
			case 56u:
				Rarity4 = input.ReadInt32();
				break;
			case 64u:
				Rarity5 = input.ReadInt32();
				break;
			}
		}
	}
}
