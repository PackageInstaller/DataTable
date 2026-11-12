using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SignIn : IMessage<SignIn>, IMessage, IEquatable<SignIn>, IDeepCloneable<SignIn>
{
	private static readonly MessageParser<SignIn> _parser = new MessageParser<SignIn>(() => new SignIn());

	private UnknownFieldSet _unknownFields;

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int GroupFieldNumber = 2;

	private int group_;

	public const int DayFieldNumber = 3;

	private int day_;

	public const int ItemIdFieldNumber = 4;

	private int itemId_;

	public const int ItemQtyFieldNumber = 5;

	private int itemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<SignIn> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(718);

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
	public int Group
	{
		get
		{
			return group_;
		}
		set
		{
			group_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Day
	{
		get
		{
			return day_;
		}
		set
		{
			day_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemId
	{
		get
		{
			return itemId_;
		}
		set
		{
			itemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemQty
	{
		get
		{
			return itemQty_;
		}
		set
		{
			itemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SignIn()
	{
	}

	[DebuggerNonUserCode]
	public SignIn(SignIn other)
		: this()
	{
		iD_ = other.iD_;
		group_ = other.group_;
		day_ = other.day_;
		itemId_ = other.itemId_;
		itemQty_ = other.itemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SignIn Clone()
	{
		return new SignIn(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SignIn);
	}

	[DebuggerNonUserCode]
	public bool Equals(SignIn other)
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
		if (Group != other.Group)
		{
			return false;
		}
		if (Day != other.Day)
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (ItemQty != other.ItemQty)
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
		if (Group != 0)
		{
			num ^= Group.GetHashCode();
		}
		if (Day != 0)
		{
			num ^= Day.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (ItemQty != 0)
		{
			num ^= ItemQty.GetHashCode();
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
		if (Group != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Group);
		}
		if (Day != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Day);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ItemId);
		}
		if (ItemQty != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ItemQty);
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
		if (Group != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Group);
		}
		if (Day != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Day);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (ItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SignIn other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Group != 0)
			{
				Group = other.Group;
			}
			if (other.Day != 0)
			{
				Day = other.Day;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.ItemQty != 0)
			{
				ItemQty = other.ItemQty;
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
				Group = input.ReadInt32();
				break;
			case 24u:
				Day = input.ReadInt32();
				break;
			case 32u:
				ItemId = input.ReadInt32();
				break;
			case 40u:
				ItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
