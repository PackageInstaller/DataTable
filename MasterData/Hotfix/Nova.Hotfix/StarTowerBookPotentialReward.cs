using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerBookPotentialReward : IMessage<StarTowerBookPotentialReward>, IMessage, IEquatable<StarTowerBookPotentialReward>, IDeepCloneable<StarTowerBookPotentialReward>
{
	private static readonly MessageParser<StarTowerBookPotentialReward> _parser = new MessageParser<StarTowerBookPotentialReward>(() => new StarTowerBookPotentialReward());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIdFieldNumber = 2;

	private int charId_;

	public const int SortFieldNumber = 3;

	private int sort_;

	public const int CondFieldNumber = 4;

	private int cond_;

	public const int ParamsFieldNumber = 5;

	private string params_ = "";

	public const int ItemIdFieldNumber = 6;

	private int itemId_;

	public const int ItemQtyFieldNumber = 7;

	private int itemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerBookPotentialReward> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(828);

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
	public int CharId
	{
		get
		{
			return charId_;
		}
		set
		{
			charId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Cond
	{
		get
		{
			return cond_;
		}
		set
		{
			cond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Params
	{
		get
		{
			return params_;
		}
		set
		{
			params_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public StarTowerBookPotentialReward()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerBookPotentialReward(StarTowerBookPotentialReward other)
		: this()
	{
		id_ = other.id_;
		charId_ = other.charId_;
		sort_ = other.sort_;
		cond_ = other.cond_;
		params_ = other.params_;
		itemId_ = other.itemId_;
		itemQty_ = other.itemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerBookPotentialReward Clone()
	{
		return new StarTowerBookPotentialReward(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerBookPotentialReward);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerBookPotentialReward other)
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
		if (CharId != other.CharId)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (Cond != other.Cond)
		{
			return false;
		}
		if (Params != other.Params)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (CharId != 0)
		{
			num ^= CharId.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (Cond != 0)
		{
			num ^= Cond.GetHashCode();
		}
		if (Params.Length != 0)
		{
			num ^= Params.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (CharId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharId);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Sort);
		}
		if (Cond != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Cond);
		}
		if (Params.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Params);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ItemId);
		}
		if (ItemQty != 0)
		{
			output.WriteRawTag(56);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (CharId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharId);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (Cond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond);
		}
		if (Params.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Params);
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
	public void MergeFrom(StarTowerBookPotentialReward other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CharId != 0)
			{
				CharId = other.CharId;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.Cond != 0)
			{
				Cond = other.Cond;
			}
			if (other.Params.Length != 0)
			{
				Params = other.Params;
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
				Id = input.ReadInt32();
				break;
			case 16u:
				CharId = input.ReadInt32();
				break;
			case 24u:
				Sort = input.ReadInt32();
				break;
			case 32u:
				Cond = input.ReadInt32();
				break;
			case 42u:
				Params = input.ReadString();
				break;
			case 48u:
				ItemId = input.ReadInt32();
				break;
			case 56u:
				ItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
