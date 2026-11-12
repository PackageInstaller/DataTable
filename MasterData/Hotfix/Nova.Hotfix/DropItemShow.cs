using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DropItemShow : IMessage<DropItemShow>, IMessage, IEquatable<DropItemShow>, IDeepCloneable<DropItemShow>
{
	private static readonly MessageParser<DropItemShow> _parser = new MessageParser<DropItemShow>(() => new DropItemShow());

	private UnknownFieldSet _unknownFields;

	public const int DropIdFieldNumber = 1;

	private int dropId_;

	public const int ItemIdFieldNumber = 2;

	private int itemId_;

	public const int ItemQtyFieldNumber = 3;

	private int itemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<DropItemShow> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(318);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int DropId
	{
		get
		{
			return dropId_;
		}
		set
		{
			dropId_ = value;
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
	public DropItemShow()
	{
	}

	[DebuggerNonUserCode]
	public DropItemShow(DropItemShow other)
		: this()
	{
		dropId_ = other.dropId_;
		itemId_ = other.itemId_;
		itemQty_ = other.itemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DropItemShow Clone()
	{
		return new DropItemShow(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DropItemShow);
	}

	[DebuggerNonUserCode]
	public bool Equals(DropItemShow other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (DropId != other.DropId)
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
		if (DropId != 0)
		{
			num ^= DropId.GetHashCode();
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
		if (DropId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(DropId);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ItemId);
		}
		if (ItemQty != 0)
		{
			output.WriteRawTag(24);
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
		if (DropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DropId);
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
	public void MergeFrom(DropItemShow other)
	{
		if (other != null)
		{
			if (other.DropId != 0)
			{
				DropId = other.DropId;
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
				DropId = input.ReadInt32();
				break;
			case 16u:
				ItemId = input.ReadInt32();
				break;
			case 24u:
				ItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
