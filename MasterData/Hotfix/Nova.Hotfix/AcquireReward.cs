using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AcquireReward : IMessage<AcquireReward>, IMessage, IEquatable<AcquireReward>, IDeepCloneable<AcquireReward>
{
	private static readonly MessageParser<AcquireReward> _parser = new MessageParser<AcquireReward>(() => new AcquireReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ItemStypeFieldNumber = 2;

	private int itemStype_;

	public const int ItemRarityFieldNumber = 3;

	private int itemRarity_;

	public const int AcquireTimesFieldNumber = 4;

	private int acquireTimes_;

	public const int ItemIdFieldNumber = 5;

	private int itemId_;

	public const int ItemNumFieldNumber = 6;

	private int itemNum_;

	[DebuggerNonUserCode]
	public static MessageParser<AcquireReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(2);

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
	public int ItemStype
	{
		get
		{
			return itemStype_;
		}
		set
		{
			itemStype_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ItemRarity
	{
		get
		{
			return itemRarity_;
		}
		set
		{
			itemRarity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AcquireTimes
	{
		get
		{
			return acquireTimes_;
		}
		set
		{
			acquireTimes_ = value;
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
	public int ItemNum
	{
		get
		{
			return itemNum_;
		}
		set
		{
			itemNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AcquireReward()
	{
	}

	[DebuggerNonUserCode]
	public AcquireReward(AcquireReward other)
		: this()
	{
		id_ = other.id_;
		itemStype_ = other.itemStype_;
		itemRarity_ = other.itemRarity_;
		acquireTimes_ = other.acquireTimes_;
		itemId_ = other.itemId_;
		itemNum_ = other.itemNum_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AcquireReward Clone()
	{
		return new AcquireReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AcquireReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(AcquireReward other)
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
		if (ItemStype != other.ItemStype)
		{
			return false;
		}
		if (ItemRarity != other.ItemRarity)
		{
			return false;
		}
		if (AcquireTimes != other.AcquireTimes)
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (ItemNum != other.ItemNum)
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
		if (ItemStype != 0)
		{
			num ^= ItemStype.GetHashCode();
		}
		if (ItemRarity != 0)
		{
			num ^= ItemRarity.GetHashCode();
		}
		if (AcquireTimes != 0)
		{
			num ^= AcquireTimes.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (ItemNum != 0)
		{
			num ^= ItemNum.GetHashCode();
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
		if (ItemStype != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ItemStype);
		}
		if (ItemRarity != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ItemRarity);
		}
		if (AcquireTimes != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AcquireTimes);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ItemId);
		}
		if (ItemNum != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ItemNum);
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
		if (ItemStype != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemStype);
		}
		if (ItemRarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemRarity);
		}
		if (AcquireTimes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AcquireTimes);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (ItemNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemNum);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AcquireReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ItemStype != 0)
			{
				ItemStype = other.ItemStype;
			}
			if (other.ItemRarity != 0)
			{
				ItemRarity = other.ItemRarity;
			}
			if (other.AcquireTimes != 0)
			{
				AcquireTimes = other.AcquireTimes;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.ItemNum != 0)
			{
				ItemNum = other.ItemNum;
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
				ItemStype = input.ReadInt32();
				break;
			case 24u:
				ItemRarity = input.ReadInt32();
				break;
			case 32u:
				AcquireTimes = input.ReadInt32();
				break;
			case 40u:
				ItemId = input.ReadInt32();
				break;
			case 48u:
				ItemNum = input.ReadInt32();
				break;
			}
		}
	}
}
