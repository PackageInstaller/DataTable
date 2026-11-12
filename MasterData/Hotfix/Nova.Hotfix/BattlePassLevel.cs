using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BattlePassLevel : IMessage<BattlePassLevel>, IMessage, IEquatable<BattlePassLevel>, IDeepCloneable<BattlePassLevel>
{
	private static readonly MessageParser<BattlePassLevel> _parser = new MessageParser<BattlePassLevel>(() => new BattlePassLevel());

	private UnknownFieldSet _unknownFields;

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int ExpFieldNumber = 2;

	private int exp_;

	public const int TidFieldNumber = 3;

	private int tid_;

	public const int QtyFieldNumber = 4;

	private int qty_;

	[DebuggerNonUserCode]
	public static MessageParser<BattlePassLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(112);

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
	public int Tid
	{
		get
		{
			return tid_;
		}
		set
		{
			tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty
	{
		get
		{
			return qty_;
		}
		set
		{
			qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BattlePassLevel()
	{
	}

	[DebuggerNonUserCode]
	public BattlePassLevel(BattlePassLevel other)
		: this()
	{
		iD_ = other.iD_;
		exp_ = other.exp_;
		tid_ = other.tid_;
		qty_ = other.qty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BattlePassLevel Clone()
	{
		return new BattlePassLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BattlePassLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(BattlePassLevel other)
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
		if (Exp != other.Exp)
		{
			return false;
		}
		if (Tid != other.Tid)
		{
			return false;
		}
		if (Qty != other.Qty)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (Tid != 0)
		{
			num ^= Tid.GetHashCode();
		}
		if (Qty != 0)
		{
			num ^= Qty.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Exp);
		}
		if (Tid != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Tid);
		}
		if (Qty != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Qty);
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
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid);
		}
		if (Qty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BattlePassLevel other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Exp != 0)
			{
				Exp = other.Exp;
			}
			if (other.Tid != 0)
			{
				Tid = other.Tid;
			}
			if (other.Qty != 0)
			{
				Qty = other.Qty;
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
				ID = input.ReadInt32();
				break;
			case 16u:
				Exp = input.ReadInt32();
				break;
			case 24u:
				Tid = input.ReadInt32();
				break;
			case 32u:
				Qty = input.ReadInt32();
				break;
			}
		}
	}
}
