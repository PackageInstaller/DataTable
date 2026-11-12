using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TowerDefenseMonster : IMessage<TowerDefenseMonster>, IMessage, IEquatable<TowerDefenseMonster>, IDeepCloneable<TowerDefenseMonster>
{
	private static readonly MessageParser<TowerDefenseMonster> _parser = new MessageParser<TowerDefenseMonster>(() => new TowerDefenseMonster());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ExpGiveFieldNumber = 2;

	private int expGive_;

	public const int HpReduceFieldNumber = 3;

	private int hpReduce_;

	public const int AmountReduceFieldNumber = 4;

	private int amountReduce_;

	public const int BriefFieldNumber = 5;

	private string brief_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TowerDefenseMonster> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(962);

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
	public int ExpGive
	{
		get
		{
			return expGive_;
		}
		set
		{
			expGive_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HpReduce
	{
		get
		{
			return hpReduce_;
		}
		set
		{
			hpReduce_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AmountReduce
	{
		get
		{
			return amountReduce_;
		}
		set
		{
			amountReduce_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Brief
	{
		get
		{
			return brief_;
		}
		set
		{
			brief_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TowerDefenseMonster()
	{
	}

	[DebuggerNonUserCode]
	public TowerDefenseMonster(TowerDefenseMonster other)
		: this()
	{
		id_ = other.id_;
		expGive_ = other.expGive_;
		hpReduce_ = other.hpReduce_;
		amountReduce_ = other.amountReduce_;
		brief_ = other.brief_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TowerDefenseMonster Clone()
	{
		return new TowerDefenseMonster(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TowerDefenseMonster);
	}

	[DebuggerNonUserCode]
	public bool Equals(TowerDefenseMonster other)
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
		if (ExpGive != other.ExpGive)
		{
			return false;
		}
		if (HpReduce != other.HpReduce)
		{
			return false;
		}
		if (AmountReduce != other.AmountReduce)
		{
			return false;
		}
		if (Brief != other.Brief)
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
		if (ExpGive != 0)
		{
			num ^= ExpGive.GetHashCode();
		}
		if (HpReduce != 0)
		{
			num ^= HpReduce.GetHashCode();
		}
		if (AmountReduce != 0)
		{
			num ^= AmountReduce.GetHashCode();
		}
		if (Brief.Length != 0)
		{
			num ^= Brief.GetHashCode();
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
		if (ExpGive != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ExpGive);
		}
		if (HpReduce != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(HpReduce);
		}
		if (AmountReduce != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AmountReduce);
		}
		if (Brief.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Brief);
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
		if (ExpGive != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExpGive);
		}
		if (HpReduce != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HpReduce);
		}
		if (AmountReduce != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AmountReduce);
		}
		if (Brief.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Brief);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TowerDefenseMonster other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ExpGive != 0)
			{
				ExpGive = other.ExpGive;
			}
			if (other.HpReduce != 0)
			{
				HpReduce = other.HpReduce;
			}
			if (other.AmountReduce != 0)
			{
				AmountReduce = other.AmountReduce;
			}
			if (other.Brief.Length != 0)
			{
				Brief = other.Brief;
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
				ExpGive = input.ReadInt32();
				break;
			case 24u:
				HpReduce = input.ReadInt32();
				break;
			case 32u:
				AmountReduce = input.ReadInt32();
				break;
			case 42u:
				Brief = input.ReadString();
				break;
			}
		}
	}
}
