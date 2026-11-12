using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TravelerDuelTarget : IMessage<TravelerDuelTarget>, IMessage, IEquatable<TravelerDuelTarget>, IDeepCloneable<TravelerDuelTarget>
{
	private static readonly MessageParser<TravelerDuelTarget> _parser = new MessageParser<TravelerDuelTarget>(() => new TravelerDuelTarget());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int DayNumFieldNumber = 3;

	private int dayNum_;

	public const int ItemId1FieldNumber = 4;

	private int itemId1_;

	public const int ItemQty1FieldNumber = 5;

	private int itemQty1_;

	public const int ItemId2FieldNumber = 6;

	private int itemId2_;

	public const int ItemQty2FieldNumber = 7;

	private int itemQty2_;

	public const int ItemId3FieldNumber = 8;

	private int itemId3_;

	public const int ItemQty3FieldNumber = 9;

	private int itemQty3_;

	public const int RivalNameFieldNumber = 10;

	private string rivalName_ = "";

	public const int RivalIconFieldNumber = 11;

	private string rivalIcon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<TravelerDuelTarget> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1024);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DayNum
	{
		get
		{
			return dayNum_;
		}
		set
		{
			dayNum_ = value;
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
	public int ItemQty1
	{
		get
		{
			return itemQty1_;
		}
		set
		{
			itemQty1_ = value;
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
	public int ItemQty2
	{
		get
		{
			return itemQty2_;
		}
		set
		{
			itemQty2_ = value;
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
	public int ItemQty3
	{
		get
		{
			return itemQty3_;
		}
		set
		{
			itemQty3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RivalName
	{
		get
		{
			return rivalName_;
		}
		set
		{
			rivalName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string RivalIcon
	{
		get
		{
			return rivalIcon_;
		}
		set
		{
			rivalIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public TravelerDuelTarget()
	{
	}

	[DebuggerNonUserCode]
	public TravelerDuelTarget(TravelerDuelTarget other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		dayNum_ = other.dayNum_;
		itemId1_ = other.itemId1_;
		itemQty1_ = other.itemQty1_;
		itemId2_ = other.itemId2_;
		itemQty2_ = other.itemQty2_;
		itemId3_ = other.itemId3_;
		itemQty3_ = other.itemQty3_;
		rivalName_ = other.rivalName_;
		rivalIcon_ = other.rivalIcon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TravelerDuelTarget Clone()
	{
		return new TravelerDuelTarget(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TravelerDuelTarget);
	}

	[DebuggerNonUserCode]
	public bool Equals(TravelerDuelTarget other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (DayNum != other.DayNum)
		{
			return false;
		}
		if (ItemId1 != other.ItemId1)
		{
			return false;
		}
		if (ItemQty1 != other.ItemQty1)
		{
			return false;
		}
		if (ItemId2 != other.ItemId2)
		{
			return false;
		}
		if (ItemQty2 != other.ItemQty2)
		{
			return false;
		}
		if (ItemId3 != other.ItemId3)
		{
			return false;
		}
		if (ItemQty3 != other.ItemQty3)
		{
			return false;
		}
		if (RivalName != other.RivalName)
		{
			return false;
		}
		if (RivalIcon != other.RivalIcon)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (DayNum != 0)
		{
			num ^= DayNum.GetHashCode();
		}
		if (ItemId1 != 0)
		{
			num ^= ItemId1.GetHashCode();
		}
		if (ItemQty1 != 0)
		{
			num ^= ItemQty1.GetHashCode();
		}
		if (ItemId2 != 0)
		{
			num ^= ItemId2.GetHashCode();
		}
		if (ItemQty2 != 0)
		{
			num ^= ItemQty2.GetHashCode();
		}
		if (ItemId3 != 0)
		{
			num ^= ItemId3.GetHashCode();
		}
		if (ItemQty3 != 0)
		{
			num ^= ItemQty3.GetHashCode();
		}
		if (RivalName.Length != 0)
		{
			num ^= RivalName.GetHashCode();
		}
		if (RivalIcon.Length != 0)
		{
			num ^= RivalIcon.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (DayNum != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DayNum);
		}
		if (ItemId1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ItemId1);
		}
		if (ItemQty1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ItemQty1);
		}
		if (ItemId2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ItemId2);
		}
		if (ItemQty2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ItemQty2);
		}
		if (ItemId3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ItemId3);
		}
		if (ItemQty3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ItemQty3);
		}
		if (RivalName.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(RivalName);
		}
		if (RivalIcon.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(RivalIcon);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (DayNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DayNum);
		}
		if (ItemId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId1);
		}
		if (ItemQty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQty1);
		}
		if (ItemId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId2);
		}
		if (ItemQty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQty2);
		}
		if (ItemId3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId3);
		}
		if (ItemQty3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQty3);
		}
		if (RivalName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RivalName);
		}
		if (RivalIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RivalIcon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TravelerDuelTarget other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.DayNum != 0)
			{
				DayNum = other.DayNum;
			}
			if (other.ItemId1 != 0)
			{
				ItemId1 = other.ItemId1;
			}
			if (other.ItemQty1 != 0)
			{
				ItemQty1 = other.ItemQty1;
			}
			if (other.ItemId2 != 0)
			{
				ItemId2 = other.ItemId2;
			}
			if (other.ItemQty2 != 0)
			{
				ItemQty2 = other.ItemQty2;
			}
			if (other.ItemId3 != 0)
			{
				ItemId3 = other.ItemId3;
			}
			if (other.ItemQty3 != 0)
			{
				ItemQty3 = other.ItemQty3;
			}
			if (other.RivalName.Length != 0)
			{
				RivalName = other.RivalName;
			}
			if (other.RivalIcon.Length != 0)
			{
				RivalIcon = other.RivalIcon;
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
				GroupId = input.ReadInt32();
				break;
			case 24u:
				DayNum = input.ReadInt32();
				break;
			case 32u:
				ItemId1 = input.ReadInt32();
				break;
			case 40u:
				ItemQty1 = input.ReadInt32();
				break;
			case 48u:
				ItemId2 = input.ReadInt32();
				break;
			case 56u:
				ItemQty2 = input.ReadInt32();
				break;
			case 64u:
				ItemId3 = input.ReadInt32();
				break;
			case 72u:
				ItemQty3 = input.ReadInt32();
				break;
			case 82u:
				RivalName = input.ReadString();
				break;
			case 90u:
				RivalIcon = input.ReadString();
				break;
			}
		}
	}
}
