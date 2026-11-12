using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class EnergyBuy : IMessage<EnergyBuy>, IMessage, IEquatable<EnergyBuy>, IDeepCloneable<EnergyBuy>
{
	private static readonly MessageParser<EnergyBuy> _parser = new MessageParser<EnergyBuy>(() => new EnergyBuy());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CurrencyItemIdFieldNumber = 2;

	private int currencyItemId_;

	public const int CurrencyItemQtyFieldNumber = 3;

	private int currencyItemQty_;

	public const int EnergyValueFieldNumber = 4;

	private int energyValue_;

	public const int PriceGroupFieldNumber = 5;

	private int priceGroup_;

	public const int GroupNameFieldNumber = 6;

	private string groupName_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<EnergyBuy> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(334);

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
	public int CurrencyItemId
	{
		get
		{
			return currencyItemId_;
		}
		set
		{
			currencyItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CurrencyItemQty
	{
		get
		{
			return currencyItemQty_;
		}
		set
		{
			currencyItemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnergyValue
	{
		get
		{
			return energyValue_;
		}
		set
		{
			energyValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PriceGroup
	{
		get
		{
			return priceGroup_;
		}
		set
		{
			priceGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string GroupName
	{
		get
		{
			return groupName_;
		}
		set
		{
			groupName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public EnergyBuy()
	{
	}

	[DebuggerNonUserCode]
	public EnergyBuy(EnergyBuy other)
		: this()
	{
		id_ = other.id_;
		currencyItemId_ = other.currencyItemId_;
		currencyItemQty_ = other.currencyItemQty_;
		energyValue_ = other.energyValue_;
		priceGroup_ = other.priceGroup_;
		groupName_ = other.groupName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public EnergyBuy Clone()
	{
		return new EnergyBuy(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EnergyBuy);
	}

	[DebuggerNonUserCode]
	public bool Equals(EnergyBuy other)
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
		if (CurrencyItemId != other.CurrencyItemId)
		{
			return false;
		}
		if (CurrencyItemQty != other.CurrencyItemQty)
		{
			return false;
		}
		if (EnergyValue != other.EnergyValue)
		{
			return false;
		}
		if (PriceGroup != other.PriceGroup)
		{
			return false;
		}
		if (GroupName != other.GroupName)
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
		if (CurrencyItemId != 0)
		{
			num ^= CurrencyItemId.GetHashCode();
		}
		if (CurrencyItemQty != 0)
		{
			num ^= CurrencyItemQty.GetHashCode();
		}
		if (EnergyValue != 0)
		{
			num ^= EnergyValue.GetHashCode();
		}
		if (PriceGroup != 0)
		{
			num ^= PriceGroup.GetHashCode();
		}
		if (GroupName.Length != 0)
		{
			num ^= GroupName.GetHashCode();
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
		if (CurrencyItemId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CurrencyItemId);
		}
		if (CurrencyItemQty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CurrencyItemQty);
		}
		if (EnergyValue != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(EnergyValue);
		}
		if (PriceGroup != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PriceGroup);
		}
		if (GroupName.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(GroupName);
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
		if (CurrencyItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrencyItemId);
		}
		if (CurrencyItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrencyItemQty);
		}
		if (EnergyValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnergyValue);
		}
		if (PriceGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PriceGroup);
		}
		if (GroupName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GroupName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(EnergyBuy other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CurrencyItemId != 0)
			{
				CurrencyItemId = other.CurrencyItemId;
			}
			if (other.CurrencyItemQty != 0)
			{
				CurrencyItemQty = other.CurrencyItemQty;
			}
			if (other.EnergyValue != 0)
			{
				EnergyValue = other.EnergyValue;
			}
			if (other.PriceGroup != 0)
			{
				PriceGroup = other.PriceGroup;
			}
			if (other.GroupName.Length != 0)
			{
				GroupName = other.GroupName;
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
				CurrencyItemId = input.ReadInt32();
				break;
			case 24u:
				CurrencyItemQty = input.ReadInt32();
				break;
			case 32u:
				EnergyValue = input.ReadInt32();
				break;
			case 40u:
				PriceGroup = input.ReadInt32();
				break;
			case 50u:
				GroupName = input.ReadString();
				break;
			}
		}
	}
}
