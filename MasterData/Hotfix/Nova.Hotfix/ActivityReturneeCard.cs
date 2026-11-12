using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneeCard : IMessage<ActivityReturneeCard>, IMessage, IEquatable<ActivityReturneeCard>, IDeepCloneable<ActivityReturneeCard>
{
	private static readonly MessageParser<ActivityReturneeCard> _parser = new MessageParser<ActivityReturneeCard>(() => new ActivityReturneeCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int StatisticalGroupFieldNumber = 4;

	private string statisticalGroup_ = "";

	public const int ReturneeIdFieldNumber = 5;

	private int returneeId_;

	public const int BaseItemIdFieldNumber = 6;

	private int baseItemId_;

	public const int BaseItemQtyFieldNumber = 7;

	private int baseItemQty_;

	public const int DailyItemId1FieldNumber = 8;

	private int dailyItemId1_;

	public const int DailyItemQty1FieldNumber = 9;

	private int dailyItemQty1_;

	public const int DailyItemId2FieldNumber = 10;

	private int dailyItemId2_;

	public const int DailyItemQty2FieldNumber = 11;

	private int dailyItemQty2_;

	public const int PriceFieldNumber = 12;

	private int price_;

	public const int ShowPriceFieldNumber = 13;

	private string showPrice_ = "";

	public const int IconFieldNumber = 14;

	private string icon_ = "";

	public const int IconBgFieldNumber = 15;

	private string iconBg_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneeCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(34);

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
	public int ReturneeId
	{
		get
		{
			return returneeId_;
		}
		set
		{
			returneeId_ = value;
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
	public int DailyItemId1
	{
		get
		{
			return dailyItemId1_;
		}
		set
		{
			dailyItemId1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DailyItemQty1
	{
		get
		{
			return dailyItemQty1_;
		}
		set
		{
			dailyItemQty1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DailyItemId2
	{
		get
		{
			return dailyItemId2_;
		}
		set
		{
			dailyItemId2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DailyItemQty2
	{
		get
		{
			return dailyItemQty2_;
		}
		set
		{
			dailyItemQty2_ = value;
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
	public string IconBg
	{
		get
		{
			return iconBg_;
		}
		set
		{
			iconBg_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturneeCard()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneeCard(ActivityReturneeCard other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		statisticalGroup_ = other.statisticalGroup_;
		returneeId_ = other.returneeId_;
		baseItemId_ = other.baseItemId_;
		baseItemQty_ = other.baseItemQty_;
		dailyItemId1_ = other.dailyItemId1_;
		dailyItemQty1_ = other.dailyItemQty1_;
		dailyItemId2_ = other.dailyItemId2_;
		dailyItemQty2_ = other.dailyItemQty2_;
		price_ = other.price_;
		showPrice_ = other.showPrice_;
		icon_ = other.icon_;
		iconBg_ = other.iconBg_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneeCard Clone()
	{
		return new ActivityReturneeCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneeCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneeCard other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (StatisticalGroup != other.StatisticalGroup)
		{
			return false;
		}
		if (ReturneeId != other.ReturneeId)
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
		if (DailyItemId1 != other.DailyItemId1)
		{
			return false;
		}
		if (DailyItemQty1 != other.DailyItemQty1)
		{
			return false;
		}
		if (DailyItemId2 != other.DailyItemId2)
		{
			return false;
		}
		if (DailyItemQty2 != other.DailyItemQty2)
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
		if (Icon != other.Icon)
		{
			return false;
		}
		if (IconBg != other.IconBg)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (StatisticalGroup.Length != 0)
		{
			num ^= StatisticalGroup.GetHashCode();
		}
		if (ReturneeId != 0)
		{
			num ^= ReturneeId.GetHashCode();
		}
		if (BaseItemId != 0)
		{
			num ^= BaseItemId.GetHashCode();
		}
		if (BaseItemQty != 0)
		{
			num ^= BaseItemQty.GetHashCode();
		}
		if (DailyItemId1 != 0)
		{
			num ^= DailyItemId1.GetHashCode();
		}
		if (DailyItemQty1 != 0)
		{
			num ^= DailyItemQty1.GetHashCode();
		}
		if (DailyItemId2 != 0)
		{
			num ^= DailyItemId2.GetHashCode();
		}
		if (DailyItemQty2 != 0)
		{
			num ^= DailyItemQty2.GetHashCode();
		}
		if (Price != 0)
		{
			num ^= Price.GetHashCode();
		}
		if (ShowPrice.Length != 0)
		{
			num ^= ShowPrice.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (IconBg.Length != 0)
		{
			num ^= IconBg.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (StatisticalGroup.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(StatisticalGroup);
		}
		if (ReturneeId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ReturneeId);
		}
		if (BaseItemId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(BaseItemId);
		}
		if (BaseItemQty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(BaseItemQty);
		}
		if (DailyItemId1 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DailyItemId1);
		}
		if (DailyItemQty1 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(DailyItemQty1);
		}
		if (DailyItemId2 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(DailyItemId2);
		}
		if (DailyItemQty2 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(DailyItemQty2);
		}
		if (Price != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Price);
		}
		if (ShowPrice.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(ShowPrice);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Icon);
		}
		if (IconBg.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(IconBg);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (StatisticalGroup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StatisticalGroup);
		}
		if (ReturneeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReturneeId);
		}
		if (BaseItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseItemId);
		}
		if (BaseItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseItemQty);
		}
		if (DailyItemId1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DailyItemId1);
		}
		if (DailyItemQty1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DailyItemQty1);
		}
		if (DailyItemId2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DailyItemId2);
		}
		if (DailyItemQty2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DailyItemQty2);
		}
		if (Price != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Price);
		}
		if (ShowPrice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ShowPrice);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (IconBg.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconBg);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneeCard other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.StatisticalGroup.Length != 0)
			{
				StatisticalGroup = other.StatisticalGroup;
			}
			if (other.ReturneeId != 0)
			{
				ReturneeId = other.ReturneeId;
			}
			if (other.BaseItemId != 0)
			{
				BaseItemId = other.BaseItemId;
			}
			if (other.BaseItemQty != 0)
			{
				BaseItemQty = other.BaseItemQty;
			}
			if (other.DailyItemId1 != 0)
			{
				DailyItemId1 = other.DailyItemId1;
			}
			if (other.DailyItemQty1 != 0)
			{
				DailyItemQty1 = other.DailyItemQty1;
			}
			if (other.DailyItemId2 != 0)
			{
				DailyItemId2 = other.DailyItemId2;
			}
			if (other.DailyItemQty2 != 0)
			{
				DailyItemQty2 = other.DailyItemQty2;
			}
			if (other.Price != 0)
			{
				Price = other.Price;
			}
			if (other.ShowPrice.Length != 0)
			{
				ShowPrice = other.ShowPrice;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.IconBg.Length != 0)
			{
				IconBg = other.IconBg;
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
				Desc = input.ReadString();
				break;
			case 34u:
				StatisticalGroup = input.ReadString();
				break;
			case 40u:
				ReturneeId = input.ReadInt32();
				break;
			case 48u:
				BaseItemId = input.ReadInt32();
				break;
			case 56u:
				BaseItemQty = input.ReadInt32();
				break;
			case 64u:
				DailyItemId1 = input.ReadInt32();
				break;
			case 72u:
				DailyItemQty1 = input.ReadInt32();
				break;
			case 80u:
				DailyItemId2 = input.ReadInt32();
				break;
			case 88u:
				DailyItemQty2 = input.ReadInt32();
				break;
			case 96u:
				Price = input.ReadInt32();
				break;
			case 106u:
				ShowPrice = input.ReadString();
				break;
			case 114u:
				Icon = input.ReadString();
				break;
			case 122u:
				IconBg = input.ReadString();
				break;
			}
		}
	}
}
