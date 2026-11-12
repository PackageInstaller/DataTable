using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BattlePassReward : IMessage<BattlePassReward>, IMessage, IEquatable<BattlePassReward>, IDeepCloneable<BattlePassReward>
{
	private static readonly MessageParser<BattlePassReward> _parser = new MessageParser<BattlePassReward>(() => new BattlePassReward());

	private UnknownFieldSet _unknownFields;

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int LevelFieldNumber = 2;

	private int level_;

	public const int Tid1FieldNumber = 3;

	private int tid1_;

	public const int Qty1FieldNumber = 4;

	private int qty1_;

	public const int Tid2FieldNumber = 5;

	private int tid2_;

	public const int Qty2FieldNumber = 6;

	private int qty2_;

	public const int Tid3FieldNumber = 7;

	private int tid3_;

	public const int Qty3FieldNumber = 8;

	private int qty3_;

	public const int FocusFieldNumber = 9;

	private bool focus_;

	[DebuggerNonUserCode]
	public static MessageParser<BattlePassReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(116);

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
	public int Tid1
	{
		get
		{
			return tid1_;
		}
		set
		{
			tid1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty1
	{
		get
		{
			return qty1_;
		}
		set
		{
			qty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tid2
	{
		get
		{
			return tid2_;
		}
		set
		{
			tid2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty2
	{
		get
		{
			return qty2_;
		}
		set
		{
			qty2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tid3
	{
		get
		{
			return tid3_;
		}
		set
		{
			tid3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Qty3
	{
		get
		{
			return qty3_;
		}
		set
		{
			qty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Focus
	{
		get
		{
			return focus_;
		}
		set
		{
			focus_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BattlePassReward()
	{
	}

	[DebuggerNonUserCode]
	public BattlePassReward(BattlePassReward other)
		: this()
	{
		iD_ = other.iD_;
		level_ = other.level_;
		tid1_ = other.tid1_;
		qty1_ = other.qty1_;
		tid2_ = other.tid2_;
		qty2_ = other.qty2_;
		tid3_ = other.tid3_;
		qty3_ = other.qty3_;
		focus_ = other.focus_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BattlePassReward Clone()
	{
		return new BattlePassReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BattlePassReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(BattlePassReward other)
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
		if (Level != other.Level)
		{
			return false;
		}
		if (Tid1 != other.Tid1)
		{
			return false;
		}
		if (Qty1 != other.Qty1)
		{
			return false;
		}
		if (Tid2 != other.Tid2)
		{
			return false;
		}
		if (Qty2 != other.Qty2)
		{
			return false;
		}
		if (Tid3 != other.Tid3)
		{
			return false;
		}
		if (Qty3 != other.Qty3)
		{
			return false;
		}
		if (Focus != other.Focus)
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
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Tid1 != 0)
		{
			num ^= Tid1.GetHashCode();
		}
		if (Qty1 != 0)
		{
			num ^= Qty1.GetHashCode();
		}
		if (Tid2 != 0)
		{
			num ^= Tid2.GetHashCode();
		}
		if (Qty2 != 0)
		{
			num ^= Qty2.GetHashCode();
		}
		if (Tid3 != 0)
		{
			num ^= Tid3.GetHashCode();
		}
		if (Qty3 != 0)
		{
			num ^= Qty3.GetHashCode();
		}
		if (Focus)
		{
			num ^= Focus.GetHashCode();
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
		if (Level != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Level);
		}
		if (Tid1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Tid1);
		}
		if (Qty1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Qty1);
		}
		if (Tid2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Tid2);
		}
		if (Qty2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Qty2);
		}
		if (Tid3 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Tid3);
		}
		if (Qty3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Qty3);
		}
		if (Focus)
		{
			output.WriteRawTag(72);
			output.WriteBool(Focus);
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
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Tid1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid1);
		}
		if (Qty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty1);
		}
		if (Tid2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid2);
		}
		if (Qty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty2);
		}
		if (Tid3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tid3);
		}
		if (Qty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Qty3);
		}
		if (Focus)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BattlePassReward other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Tid1 != 0)
			{
				Tid1 = other.Tid1;
			}
			if (other.Qty1 != 0)
			{
				Qty1 = other.Qty1;
			}
			if (other.Tid2 != 0)
			{
				Tid2 = other.Tid2;
			}
			if (other.Qty2 != 0)
			{
				Qty2 = other.Qty2;
			}
			if (other.Tid3 != 0)
			{
				Tid3 = other.Tid3;
			}
			if (other.Qty3 != 0)
			{
				Qty3 = other.Qty3;
			}
			if (other.Focus)
			{
				Focus = other.Focus;
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
				Level = input.ReadInt32();
				break;
			case 24u:
				Tid1 = input.ReadInt32();
				break;
			case 32u:
				Qty1 = input.ReadInt32();
				break;
			case 40u:
				Tid2 = input.ReadInt32();
				break;
			case 48u:
				Qty2 = input.ReadInt32();
				break;
			case 56u:
				Tid3 = input.ReadInt32();
				break;
			case 64u:
				Qty3 = input.ReadInt32();
				break;
			case 72u:
				Focus = input.ReadBool();
				break;
			}
		}
	}
}
