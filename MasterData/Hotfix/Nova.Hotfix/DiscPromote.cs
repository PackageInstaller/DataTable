using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DiscPromote : IMessage<DiscPromote>, IMessage, IEquatable<DiscPromote>, IDeepCloneable<DiscPromote>
{
	private static readonly MessageParser<DiscPromote> _parser = new MessageParser<DiscPromote>(() => new DiscPromote());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ItemId1FieldNumber = 2;

	private int itemId1_;

	public const int Num1FieldNumber = 3;

	private int num1_;

	public const int ItemId2FieldNumber = 4;

	private int itemId2_;

	public const int Num2FieldNumber = 5;

	private int num2_;

	public const int ItemId3FieldNumber = 6;

	private int itemId3_;

	public const int Num3FieldNumber = 7;

	private int num3_;

	public const int ItemId4FieldNumber = 8;

	private int itemId4_;

	public const int Num4FieldNumber = 9;

	private int num4_;

	public const int ExpenseGoldFieldNumber = 10;

	private int expenseGold_;

	[DebuggerNonUserCode]
	public static MessageParser<DiscPromote> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(280);

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
	public int ItemId1
	{
		get
		{
			return itemId1_;
		}
		set
		{
			itemId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Num1
	{
		get
		{
			return num1_;
		}
		set
		{
			num1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemId2
	{
		get
		{
			return itemId2_;
		}
		set
		{
			itemId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Num2
	{
		get
		{
			return num2_;
		}
		set
		{
			num2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemId3
	{
		get
		{
			return itemId3_;
		}
		set
		{
			itemId3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Num3
	{
		get
		{
			return num3_;
		}
		set
		{
			num3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemId4
	{
		get
		{
			return itemId4_;
		}
		set
		{
			itemId4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Num4
	{
		get
		{
			return num4_;
		}
		set
		{
			num4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ExpenseGold
	{
		get
		{
			return expenseGold_;
		}
		set
		{
			expenseGold_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DiscPromote()
	{
	}

	[DebuggerNonUserCode]
	public DiscPromote(DiscPromote other)
		: this()
	{
		id_ = other.id_;
		itemId1_ = other.itemId1_;
		num1_ = other.num1_;
		itemId2_ = other.itemId2_;
		num2_ = other.num2_;
		itemId3_ = other.itemId3_;
		num3_ = other.num3_;
		itemId4_ = other.itemId4_;
		num4_ = other.num4_;
		expenseGold_ = other.expenseGold_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DiscPromote Clone()
	{
		return new DiscPromote(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DiscPromote);
	}

	[DebuggerNonUserCode]
	public bool Equals(DiscPromote other)
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
		if (ItemId1 != other.ItemId1)
		{
			return false;
		}
		if (Num1 != other.Num1)
		{
			return false;
		}
		if (ItemId2 != other.ItemId2)
		{
			return false;
		}
		if (Num2 != other.Num2)
		{
			return false;
		}
		if (ItemId3 != other.ItemId3)
		{
			return false;
		}
		if (Num3 != other.Num3)
		{
			return false;
		}
		if (ItemId4 != other.ItemId4)
		{
			return false;
		}
		if (Num4 != other.Num4)
		{
			return false;
		}
		if (ExpenseGold != other.ExpenseGold)
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
		if (ItemId1 != 0)
		{
			num ^= ItemId1.GetHashCode();
		}
		if (Num1 != 0)
		{
			num ^= Num1.GetHashCode();
		}
		if (ItemId2 != 0)
		{
			num ^= ItemId2.GetHashCode();
		}
		if (Num2 != 0)
		{
			num ^= Num2.GetHashCode();
		}
		if (ItemId3 != 0)
		{
			num ^= ItemId3.GetHashCode();
		}
		if (Num3 != 0)
		{
			num ^= Num3.GetHashCode();
		}
		if (ItemId4 != 0)
		{
			num ^= ItemId4.GetHashCode();
		}
		if (Num4 != 0)
		{
			num ^= Num4.GetHashCode();
		}
		if (ExpenseGold != 0)
		{
			num ^= ExpenseGold.GetHashCode();
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
		if (ItemId1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ItemId1);
		}
		if (Num1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Num1);
		}
		if (ItemId2 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ItemId2);
		}
		if (Num2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Num2);
		}
		if (ItemId3 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ItemId3);
		}
		if (Num3 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Num3);
		}
		if (ItemId4 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ItemId4);
		}
		if (Num4 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Num4);
		}
		if (ExpenseGold != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ExpenseGold);
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
		if (ItemId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId1);
		}
		if (Num1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Num1);
		}
		if (ItemId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId2);
		}
		if (Num2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Num2);
		}
		if (ItemId3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId3);
		}
		if (Num3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Num3);
		}
		if (ItemId4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId4);
		}
		if (Num4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Num4);
		}
		if (ExpenseGold != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExpenseGold);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DiscPromote other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ItemId1 != 0)
			{
				ItemId1 = other.ItemId1;
			}
			if (other.Num1 != 0)
			{
				Num1 = other.Num1;
			}
			if (other.ItemId2 != 0)
			{
				ItemId2 = other.ItemId2;
			}
			if (other.Num2 != 0)
			{
				Num2 = other.Num2;
			}
			if (other.ItemId3 != 0)
			{
				ItemId3 = other.ItemId3;
			}
			if (other.Num3 != 0)
			{
				Num3 = other.Num3;
			}
			if (other.ItemId4 != 0)
			{
				ItemId4 = other.ItemId4;
			}
			if (other.Num4 != 0)
			{
				Num4 = other.Num4;
			}
			if (other.ExpenseGold != 0)
			{
				ExpenseGold = other.ExpenseGold;
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
				ItemId1 = input.ReadInt32();
				break;
			case 24u:
				Num1 = input.ReadInt32();
				break;
			case 32u:
				ItemId2 = input.ReadInt32();
				break;
			case 40u:
				Num2 = input.ReadInt32();
				break;
			case 48u:
				ItemId3 = input.ReadInt32();
				break;
			case 56u:
				Num3 = input.ReadInt32();
				break;
			case 64u:
				ItemId4 = input.ReadInt32();
				break;
			case 72u:
				Num4 = input.ReadInt32();
				break;
			case 80u:
				ExpenseGold = input.ReadInt32();
				break;
			}
		}
	}
}
