using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MallGem : IMessage<MallGem>, IMessage, IEquatable<MallGem>, IDeepCloneable<MallGem>
{
	private static readonly MessageParser<MallGem> _parser = new MessageParser<MallGem>(() => new MallGem());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int StatisticalGroupFieldNumber = 4;

	private string statisticalGroup_ = "";

	public const int OrderFieldNumber = 5;

	private int order_;

	public const int BaseItemIdFieldNumber = 6;

	private int baseItemId_;

	public const int BaseItemQtyFieldNumber = 7;

	private int baseItemQty_;

	public const int ExperiencedBonusItemIdFieldNumber = 8;

	private int experiencedBonusItemId_;

	public const int ExperiencedBonusItemQtyFieldNumber = 9;

	private int experiencedBonusItemQty_;

	public const int MaidenBonusItemIDFieldNumber = 10;

	private int maidenBonusItemID_;

	public const int MaidenBonusItemQtyFieldNumber = 11;

	private int maidenBonusItemQty_;

	public const int PriceFieldNumber = 12;

	private int price_;

	public const int ShowPriceFieldNumber = 13;

	private string showPrice_ = "";

	public const int IconFieldNumber = 14;

	private string icon_ = "";

	public const int IconBgFieldNumber = 15;

	private string iconBg_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MallGem> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(516);

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
	public int Order
	{
		get
		{
			return order_;
		}
		set
		{
			order_ = value;
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
	public int ExperiencedBonusItemId
	{
		get
		{
			return experiencedBonusItemId_;
		}
		set
		{
			experiencedBonusItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ExperiencedBonusItemQty
	{
		get
		{
			return experiencedBonusItemQty_;
		}
		set
		{
			experiencedBonusItemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaidenBonusItemID
	{
		get
		{
			return maidenBonusItemID_;
		}
		set
		{
			maidenBonusItemID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaidenBonusItemQty
	{
		get
		{
			return maidenBonusItemQty_;
		}
		set
		{
			maidenBonusItemQty_ = value;
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
	public MallGem()
	{
	}

	[DebuggerNonUserCode]
	public MallGem(MallGem other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		statisticalGroup_ = other.statisticalGroup_;
		order_ = other.order_;
		baseItemId_ = other.baseItemId_;
		baseItemQty_ = other.baseItemQty_;
		experiencedBonusItemId_ = other.experiencedBonusItemId_;
		experiencedBonusItemQty_ = other.experiencedBonusItemQty_;
		maidenBonusItemID_ = other.maidenBonusItemID_;
		maidenBonusItemQty_ = other.maidenBonusItemQty_;
		price_ = other.price_;
		showPrice_ = other.showPrice_;
		icon_ = other.icon_;
		iconBg_ = other.iconBg_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MallGem Clone()
	{
		return new MallGem(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MallGem);
	}

	[DebuggerNonUserCode]
	public bool Equals(MallGem other)
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
		if (Order != other.Order)
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
		if (ExperiencedBonusItemId != other.ExperiencedBonusItemId)
		{
			return false;
		}
		if (ExperiencedBonusItemQty != other.ExperiencedBonusItemQty)
		{
			return false;
		}
		if (MaidenBonusItemID != other.MaidenBonusItemID)
		{
			return false;
		}
		if (MaidenBonusItemQty != other.MaidenBonusItemQty)
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
		if (Order != 0)
		{
			num ^= Order.GetHashCode();
		}
		if (BaseItemId != 0)
		{
			num ^= BaseItemId.GetHashCode();
		}
		if (BaseItemQty != 0)
		{
			num ^= BaseItemQty.GetHashCode();
		}
		if (ExperiencedBonusItemId != 0)
		{
			num ^= ExperiencedBonusItemId.GetHashCode();
		}
		if (ExperiencedBonusItemQty != 0)
		{
			num ^= ExperiencedBonusItemQty.GetHashCode();
		}
		if (MaidenBonusItemID != 0)
		{
			num ^= MaidenBonusItemID.GetHashCode();
		}
		if (MaidenBonusItemQty != 0)
		{
			num ^= MaidenBonusItemQty.GetHashCode();
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
		if (Order != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Order);
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
		if (ExperiencedBonusItemId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ExperiencedBonusItemId);
		}
		if (ExperiencedBonusItemQty != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ExperiencedBonusItemQty);
		}
		if (MaidenBonusItemID != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(MaidenBonusItemID);
		}
		if (MaidenBonusItemQty != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(MaidenBonusItemQty);
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
		if (Order != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Order);
		}
		if (BaseItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseItemId);
		}
		if (BaseItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseItemQty);
		}
		if (ExperiencedBonusItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExperiencedBonusItemId);
		}
		if (ExperiencedBonusItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExperiencedBonusItemQty);
		}
		if (MaidenBonusItemID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaidenBonusItemID);
		}
		if (MaidenBonusItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaidenBonusItemQty);
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
	public void MergeFrom(MallGem other)
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
			if (other.Order != 0)
			{
				Order = other.Order;
			}
			if (other.BaseItemId != 0)
			{
				BaseItemId = other.BaseItemId;
			}
			if (other.BaseItemQty != 0)
			{
				BaseItemQty = other.BaseItemQty;
			}
			if (other.ExperiencedBonusItemId != 0)
			{
				ExperiencedBonusItemId = other.ExperiencedBonusItemId;
			}
			if (other.ExperiencedBonusItemQty != 0)
			{
				ExperiencedBonusItemQty = other.ExperiencedBonusItemQty;
			}
			if (other.MaidenBonusItemID != 0)
			{
				MaidenBonusItemID = other.MaidenBonusItemID;
			}
			if (other.MaidenBonusItemQty != 0)
			{
				MaidenBonusItemQty = other.MaidenBonusItemQty;
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
				Order = input.ReadInt32();
				break;
			case 48u:
				BaseItemId = input.ReadInt32();
				break;
			case 56u:
				BaseItemQty = input.ReadInt32();
				break;
			case 64u:
				ExperiencedBonusItemId = input.ReadInt32();
				break;
			case 72u:
				ExperiencedBonusItemQty = input.ReadInt32();
				break;
			case 80u:
				MaidenBonusItemID = input.ReadInt32();
				break;
			case 88u:
				MaidenBonusItemQty = input.ReadInt32();
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
