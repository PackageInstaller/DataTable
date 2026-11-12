using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MallMonthlyCard : IMessage<MallMonthlyCard>, IMessage, IEquatable<MallMonthlyCard>, IDeepCloneable<MallMonthlyCard>
{
	private static readonly MessageParser<MallMonthlyCard> _parser = new MessageParser<MallMonthlyCard>(() => new MallMonthlyCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int StatisticalGroupFieldNumber = 3;

	private string statisticalGroup_ = "";

	public const int MonthlyCardIdFieldNumber = 4;

	private int monthlyCardId_;

	public const int PriceFieldNumber = 5;

	private int price_;

	public const int ShowPriceFieldNumber = 6;

	private string showPrice_ = "";

	public const int BaseItemIdFieldNumber = 7;

	private int baseItemId_;

	public const int BaseItemQtyFieldNumber = 8;

	private int baseItemQty_;

	public const int MaxDaysFieldNumber = 9;

	private int maxDays_;

	public const int DescFieldNumber = 10;

	private string desc_ = "";

	public const int IconFieldNumber = 11;

	private string icon_ = "";

	public const int Name2FieldNumber = 12;

	private string name2_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MallMonthlyCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(518);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string StatisticalGroup
	{
		get
		{
			return statisticalGroup_;
		}
		set
		{
			statisticalGroup_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int MonthlyCardId
	{
		get
		{
			return monthlyCardId_;
		}
		set
		{
			monthlyCardId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Price
	{
		get
		{
			return price_;
		}
		set
		{
			price_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ShowPrice
	{
		get
		{
			return showPrice_;
		}
		set
		{
			showPrice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int BaseItemId
	{
		get
		{
			return baseItemId_;
		}
		set
		{
			baseItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BaseItemQty
	{
		get
		{
			return baseItemQty_;
		}
		set
		{
			baseItemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxDays
	{
		get
		{
			return maxDays_;
		}
		set
		{
			maxDays_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Name2
	{
		get
		{
			return name2_;
		}
		set
		{
			name2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MallMonthlyCard()
	{
	}

	[DebuggerNonUserCode]
	public MallMonthlyCard(MallMonthlyCard other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		statisticalGroup_ = other.statisticalGroup_;
		monthlyCardId_ = other.monthlyCardId_;
		price_ = other.price_;
		showPrice_ = other.showPrice_;
		baseItemId_ = other.baseItemId_;
		baseItemQty_ = other.baseItemQty_;
		maxDays_ = other.maxDays_;
		desc_ = other.desc_;
		icon_ = other.icon_;
		name2_ = other.name2_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MallMonthlyCard Clone()
	{
		return new MallMonthlyCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MallMonthlyCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(MallMonthlyCard other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (StatisticalGroup != other.StatisticalGroup)
		{
			return false;
		}
		if (MonthlyCardId != other.MonthlyCardId)
		{
			return false;
		}
		if (Price != other.Price)
		{
			return false;
		}
		if (ShowPrice != other.ShowPrice)
		{
			return false;
		}
		if (BaseItemId != other.BaseItemId)
		{
			return false;
		}
		if (BaseItemQty != other.BaseItemQty)
		{
			return false;
		}
		if (MaxDays != other.MaxDays)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Name2 != other.Name2)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id.Length != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (StatisticalGroup.Length != 0)
		{
			num ^= StatisticalGroup.GetHashCode();
		}
		if (MonthlyCardId != 0)
		{
			num ^= MonthlyCardId.GetHashCode();
		}
		if (Price != 0)
		{
			num ^= Price.GetHashCode();
		}
		if (ShowPrice.Length != 0)
		{
			num ^= ShowPrice.GetHashCode();
		}
		if (BaseItemId != 0)
		{
			num ^= BaseItemId.GetHashCode();
		}
		if (BaseItemQty != 0)
		{
			num ^= BaseItemQty.GetHashCode();
		}
		if (MaxDays != 0)
		{
			num ^= MaxDays.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Name2.Length != 0)
		{
			num ^= Name2.GetHashCode();
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
		if (Id.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Id);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (StatisticalGroup.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(StatisticalGroup);
		}
		if (MonthlyCardId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MonthlyCardId);
		}
		if (Price != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Price);
		}
		if (ShowPrice.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ShowPrice);
		}
		if (BaseItemId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(BaseItemId);
		}
		if (BaseItemQty != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(BaseItemQty);
		}
		if (MaxDays != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(MaxDays);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Icon);
		}
		if (Name2.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Name2);
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
		if (Id.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Id);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (StatisticalGroup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StatisticalGroup);
		}
		if (MonthlyCardId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonthlyCardId);
		}
		if (Price != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Price);
		}
		if (ShowPrice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ShowPrice);
		}
		if (BaseItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseItemId);
		}
		if (BaseItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseItemQty);
		}
		if (MaxDays != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxDays);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Name2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name2);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MallMonthlyCard other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.StatisticalGroup.Length != 0)
			{
				StatisticalGroup = other.StatisticalGroup;
			}
			if (other.MonthlyCardId != 0)
			{
				MonthlyCardId = other.MonthlyCardId;
			}
			if (other.Price != 0)
			{
				Price = other.Price;
			}
			if (other.ShowPrice.Length != 0)
			{
				ShowPrice = other.ShowPrice;
			}
			if (other.BaseItemId != 0)
			{
				BaseItemId = other.BaseItemId;
			}
			if (other.BaseItemQty != 0)
			{
				BaseItemQty = other.BaseItemQty;
			}
			if (other.MaxDays != 0)
			{
				MaxDays = other.MaxDays;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Name2.Length != 0)
			{
				Name2 = other.Name2;
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
			case 10u:
				Id = input.ReadString();
				break;
			case 18u:
				Name = input.ReadString();
				break;
			case 26u:
				StatisticalGroup = input.ReadString();
				break;
			case 32u:
				MonthlyCardId = input.ReadInt32();
				break;
			case 40u:
				Price = input.ReadInt32();
				break;
			case 50u:
				ShowPrice = input.ReadString();
				break;
			case 56u:
				BaseItemId = input.ReadInt32();
				break;
			case 64u:
				BaseItemQty = input.ReadInt32();
				break;
			case 72u:
				MaxDays = input.ReadInt32();
				break;
			case 82u:
				Desc = input.ReadString();
				break;
			case 90u:
				Icon = input.ReadString();
				break;
			case 98u:
				Name2 = input.ReadString();
				break;
			}
		}
	}
}
