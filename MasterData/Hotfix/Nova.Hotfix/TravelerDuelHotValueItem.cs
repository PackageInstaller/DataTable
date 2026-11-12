using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TravelerDuelHotValueItem : IMessage<TravelerDuelHotValueItem>, IMessage, IEquatable<TravelerDuelHotValueItem>, IDeepCloneable<TravelerDuelHotValueItem>
{
	private static readonly MessageParser<TravelerDuelHotValueItem> _parser = new MessageParser<TravelerDuelHotValueItem>(() => new TravelerDuelHotValueItem());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int HotValueItemTypeFieldNumber = 2;

	private int hotValueItemType_;

	public const int AddExpFieldNumber = 3;

	private int addExp_;

	public const int AddHotValueFieldNumber = 4;

	private int addHotValue_;

	public const int CumulativeValueFieldNumber = 5;

	private int cumulativeValue_;

	[DebuggerNonUserCode]
	public static MessageParser<TravelerDuelHotValueItem> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1018);

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
	public int HotValueItemType
	{
		get
		{
			return hotValueItemType_;
		}
		set
		{
			hotValueItemType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AddExp
	{
		get
		{
			return addExp_;
		}
		set
		{
			addExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AddHotValue
	{
		get
		{
			return addHotValue_;
		}
		set
		{
			addHotValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CumulativeValue
	{
		get
		{
			return cumulativeValue_;
		}
		set
		{
			cumulativeValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TravelerDuelHotValueItem()
	{
	}

	[DebuggerNonUserCode]
	public TravelerDuelHotValueItem(TravelerDuelHotValueItem other)
		: this()
	{
		id_ = other.id_;
		hotValueItemType_ = other.hotValueItemType_;
		addExp_ = other.addExp_;
		addHotValue_ = other.addHotValue_;
		cumulativeValue_ = other.cumulativeValue_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TravelerDuelHotValueItem Clone()
	{
		return new TravelerDuelHotValueItem(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TravelerDuelHotValueItem);
	}

	[DebuggerNonUserCode]
	public bool Equals(TravelerDuelHotValueItem other)
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
		if (HotValueItemType != other.HotValueItemType)
		{
			return false;
		}
		if (AddExp != other.AddExp)
		{
			return false;
		}
		if (AddHotValue != other.AddHotValue)
		{
			return false;
		}
		if (CumulativeValue != other.CumulativeValue)
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
		if (HotValueItemType != 0)
		{
			num ^= HotValueItemType.GetHashCode();
		}
		if (AddExp != 0)
		{
			num ^= AddExp.GetHashCode();
		}
		if (AddHotValue != 0)
		{
			num ^= AddHotValue.GetHashCode();
		}
		if (CumulativeValue != 0)
		{
			num ^= CumulativeValue.GetHashCode();
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
		if (HotValueItemType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(HotValueItemType);
		}
		if (AddExp != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(AddExp);
		}
		if (AddHotValue != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AddHotValue);
		}
		if (CumulativeValue != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CumulativeValue);
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
		if (HotValueItemType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HotValueItemType);
		}
		if (AddExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddExp);
		}
		if (AddHotValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddHotValue);
		}
		if (CumulativeValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CumulativeValue);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TravelerDuelHotValueItem other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.HotValueItemType != 0)
			{
				HotValueItemType = other.HotValueItemType;
			}
			if (other.AddExp != 0)
			{
				AddExp = other.AddExp;
			}
			if (other.AddHotValue != 0)
			{
				AddHotValue = other.AddHotValue;
			}
			if (other.CumulativeValue != 0)
			{
				CumulativeValue = other.CumulativeValue;
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
				HotValueItemType = input.ReadInt32();
				break;
			case 24u:
				AddExp = input.ReadInt32();
				break;
			case 32u:
				AddHotValue = input.ReadInt32();
				break;
			case 40u:
				CumulativeValue = input.ReadInt32();
				break;
			}
		}
	}
}
