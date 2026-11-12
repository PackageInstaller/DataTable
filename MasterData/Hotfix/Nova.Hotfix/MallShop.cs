using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MallShop : IMessage<MallShop>, IMessage, IEquatable<MallShop>, IDeepCloneable<MallShop>
{
	private static readonly MessageParser<MallShop> _parser = new MessageParser<MallShop>(() => new MallShop());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int GroupIdFieldNumber = 4;

	private int groupId_;

	public const int SortFieldNumber = 5;

	private int sort_;

	public const int ExchangeItemIdFieldNumber = 6;

	private int exchangeItemId_;

	public const int ExchangeItemQtyFieldNumber = 7;

	private int exchangeItemQty_;

	public const int StockFieldNumber = 8;

	private int stock_;

	public const int RefreshTypeFieldNumber = 9;

	private int refreshType_;

	public const int ItemIdFieldNumber = 10;

	private int itemId_;

	public const int ItemQtyFieldNumber = 11;

	private int itemQty_;

	public const int ListCondTypeFieldNumber = 12;

	private int listCondType_;

	public const int ListCondParamsFieldNumber = 13;

	private string listCondParams_ = "";

	public const int OrderCondTypeFieldNumber = 14;

	private int orderCondType_;

	public const int OrderCondParamsFieldNumber = 15;

	private string orderCondParams_ = "";

	public const int ListTimeFieldNumber = 16;

	private string listTime_ = "";

	public const int DeListTimeFieldNumber = 17;

	private string deListTime_ = "";

	public const int DisplayModeFieldNumber = 18;

	private int displayMode_;

	[DebuggerNonUserCode]
	public static MessageParser<MallShop> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(526);

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
	public int ExchangeItemId
	{
		get
		{
			return exchangeItemId_;
		}
		set
		{
			exchangeItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ExchangeItemQty
	{
		get
		{
			return exchangeItemQty_;
		}
		set
		{
			exchangeItemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Stock
	{
		get
		{
			return stock_;
		}
		set
		{
			stock_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RefreshType
	{
		get
		{
			return refreshType_;
		}
		set
		{
			refreshType_ = value;
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
	public int ListCondType
	{
		get
		{
			return listCondType_;
		}
		set
		{
			listCondType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ListCondParams
	{
		get
		{
			return listCondParams_;
		}
		set
		{
			listCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int OrderCondType
	{
		get
		{
			return orderCondType_;
		}
		set
		{
			orderCondType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OrderCondParams
	{
		get
		{
			return orderCondParams_;
		}
		set
		{
			orderCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ListTime
	{
		get
		{
			return listTime_;
		}
		set
		{
			listTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DeListTime
	{
		get
		{
			return deListTime_;
		}
		set
		{
			deListTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DisplayMode
	{
		get
		{
			return displayMode_;
		}
		set
		{
			displayMode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MallShop()
	{
	}

	[DebuggerNonUserCode]
	public MallShop(MallShop other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		groupId_ = other.groupId_;
		sort_ = other.sort_;
		exchangeItemId_ = other.exchangeItemId_;
		exchangeItemQty_ = other.exchangeItemQty_;
		stock_ = other.stock_;
		refreshType_ = other.refreshType_;
		itemId_ = other.itemId_;
		itemQty_ = other.itemQty_;
		listCondType_ = other.listCondType_;
		listCondParams_ = other.listCondParams_;
		orderCondType_ = other.orderCondType_;
		orderCondParams_ = other.orderCondParams_;
		listTime_ = other.listTime_;
		deListTime_ = other.deListTime_;
		displayMode_ = other.displayMode_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MallShop Clone()
	{
		return new MallShop(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MallShop);
	}

	[DebuggerNonUserCode]
	public bool Equals(MallShop other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (ExchangeItemId != other.ExchangeItemId)
		{
			return false;
		}
		if (ExchangeItemQty != other.ExchangeItemQty)
		{
			return false;
		}
		if (Stock != other.Stock)
		{
			return false;
		}
		if (RefreshType != other.RefreshType)
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
		if (ListCondType != other.ListCondType)
		{
			return false;
		}
		if (ListCondParams != other.ListCondParams)
		{
			return false;
		}
		if (OrderCondType != other.OrderCondType)
		{
			return false;
		}
		if (OrderCondParams != other.OrderCondParams)
		{
			return false;
		}
		if (ListTime != other.ListTime)
		{
			return false;
		}
		if (DeListTime != other.DeListTime)
		{
			return false;
		}
		if (DisplayMode != other.DisplayMode)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (ExchangeItemId != 0)
		{
			num ^= ExchangeItemId.GetHashCode();
		}
		if (ExchangeItemQty != 0)
		{
			num ^= ExchangeItemQty.GetHashCode();
		}
		if (Stock != 0)
		{
			num ^= Stock.GetHashCode();
		}
		if (RefreshType != 0)
		{
			num ^= RefreshType.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (ItemQty != 0)
		{
			num ^= ItemQty.GetHashCode();
		}
		if (ListCondType != 0)
		{
			num ^= ListCondType.GetHashCode();
		}
		if (ListCondParams.Length != 0)
		{
			num ^= ListCondParams.GetHashCode();
		}
		if (OrderCondType != 0)
		{
			num ^= OrderCondType.GetHashCode();
		}
		if (OrderCondParams.Length != 0)
		{
			num ^= OrderCondParams.GetHashCode();
		}
		if (ListTime.Length != 0)
		{
			num ^= ListTime.GetHashCode();
		}
		if (DeListTime.Length != 0)
		{
			num ^= DeListTime.GetHashCode();
		}
		if (DisplayMode != 0)
		{
			num ^= DisplayMode.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(GroupId);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Sort);
		}
		if (ExchangeItemId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ExchangeItemId);
		}
		if (ExchangeItemQty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ExchangeItemQty);
		}
		if (Stock != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Stock);
		}
		if (RefreshType != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RefreshType);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ItemId);
		}
		if (ItemQty != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ItemQty);
		}
		if (ListCondType != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ListCondType);
		}
		if (ListCondParams.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(ListCondParams);
		}
		if (OrderCondType != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(OrderCondType);
		}
		if (OrderCondParams.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(OrderCondParams);
		}
		if (ListTime.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(ListTime);
		}
		if (DeListTime.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(DeListTime);
		}
		if (DisplayMode != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(DisplayMode);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (ExchangeItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExchangeItemId);
		}
		if (ExchangeItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExchangeItemQty);
		}
		if (Stock != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stock);
		}
		if (RefreshType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefreshType);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (ItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQty);
		}
		if (ListCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ListCondType);
		}
		if (ListCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ListCondParams);
		}
		if (OrderCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OrderCondType);
		}
		if (OrderCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OrderCondParams);
		}
		if (ListTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ListTime);
		}
		if (DeListTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(DeListTime);
		}
		if (DisplayMode != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DisplayMode);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MallShop other)
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
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.ExchangeItemId != 0)
			{
				ExchangeItemId = other.ExchangeItemId;
			}
			if (other.ExchangeItemQty != 0)
			{
				ExchangeItemQty = other.ExchangeItemQty;
			}
			if (other.Stock != 0)
			{
				Stock = other.Stock;
			}
			if (other.RefreshType != 0)
			{
				RefreshType = other.RefreshType;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.ItemQty != 0)
			{
				ItemQty = other.ItemQty;
			}
			if (other.ListCondType != 0)
			{
				ListCondType = other.ListCondType;
			}
			if (other.ListCondParams.Length != 0)
			{
				ListCondParams = other.ListCondParams;
			}
			if (other.OrderCondType != 0)
			{
				OrderCondType = other.OrderCondType;
			}
			if (other.OrderCondParams.Length != 0)
			{
				OrderCondParams = other.OrderCondParams;
			}
			if (other.ListTime.Length != 0)
			{
				ListTime = other.ListTime;
			}
			if (other.DeListTime.Length != 0)
			{
				DeListTime = other.DeListTime;
			}
			if (other.DisplayMode != 0)
			{
				DisplayMode = other.DisplayMode;
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
			case 32u:
				GroupId = input.ReadInt32();
				break;
			case 40u:
				Sort = input.ReadInt32();
				break;
			case 48u:
				ExchangeItemId = input.ReadInt32();
				break;
			case 56u:
				ExchangeItemQty = input.ReadInt32();
				break;
			case 64u:
				Stock = input.ReadInt32();
				break;
			case 72u:
				RefreshType = input.ReadInt32();
				break;
			case 80u:
				ItemId = input.ReadInt32();
				break;
			case 88u:
				ItemQty = input.ReadInt32();
				break;
			case 96u:
				ListCondType = input.ReadInt32();
				break;
			case 106u:
				ListCondParams = input.ReadString();
				break;
			case 112u:
				OrderCondType = input.ReadInt32();
				break;
			case 122u:
				OrderCondParams = input.ReadString();
				break;
			case 130u:
				ListTime = input.ReadString();
				break;
			case 138u:
				DeListTime = input.ReadString();
				break;
			case 144u:
				DisplayMode = input.ReadInt32();
				break;
			}
		}
	}
}
