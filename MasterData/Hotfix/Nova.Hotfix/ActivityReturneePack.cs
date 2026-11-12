using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityReturneePack : IMessage<ActivityReturneePack>, IMessage, IEquatable<ActivityReturneePack>, IDeepCloneable<ActivityReturneePack>
{
	private static readonly MessageParser<ActivityReturneePack> _parser = new MessageParser<ActivityReturneePack>(() => new ActivityReturneePack());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int ReturneeIdFieldNumber = 2;

	private int returneeId_;

	public const int ItemsFieldNumber = 3;

	private string items_ = "";

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int DetailNameFieldNumber = 5;

	private string detailName_ = "";

	public const int GroupIdFieldNumber = 6;

	private int groupId_;

	public const int StatisticalGroupFieldNumber = 7;

	private string statisticalGroup_ = "";

	public const int SaleRateFieldNumber = 8;

	private int saleRate_;

	public const int TagFieldNumber = 9;

	private int tag_;

	public const int SortFieldNumber = 10;

	private int sort_;

	public const int CurrencyTypeFieldNumber = 11;

	private int currencyType_;

	public const int CurrencyItemIdFieldNumber = 12;

	private int currencyItemId_;

	public const int CurrencyItemQtyFieldNumber = 13;

	private int currencyItemQty_;

	public const int CurrencyShowPriceFieldNumber = 14;

	private string currencyShowPrice_ = "";

	public const int StockFieldNumber = 15;

	private int stock_;

	public const int RefreshTypeFieldNumber = 16;

	private int refreshType_;

	public const int ListCondTypeFieldNumber = 17;

	private int listCondType_;

	public const int ListCondParamsFieldNumber = 18;

	private string listCondParams_ = "";

	public const int OrderCondTypeFieldNumber = 19;

	private int orderCondType_;

	public const int OrderCondParamsFieldNumber = 20;

	private string orderCondParams_ = "";

	public const int ListTimeFieldNumber = 21;

	private string listTime_ = "";

	public const int DeListTimeFieldNumber = 22;

	private string deListTime_ = "";

	public const int ProDeListTimeFieldNumber = 23;

	private string proDeListTime_ = "";

	public const int IsSaleSkinFieldNumber = 24;

	private bool isSaleSkin_;

	public const int BasePriceFieldNumber = 25;

	private int basePrice_;

	public const int CurrencyShowBasePriceFieldNumber = 26;

	private string currencyShowBasePrice_ = "";

	public const int ContentIconFieldNumber = 27;

	private static readonly FieldCodec<int> _repeated_contentIcon_codec = FieldCodec.ForInt32(218u);

	private readonly RepeatedField<int> contentIcon_ = new RepeatedField<int>();

	public const int DisplayModeFieldNumber = 28;

	private int displayMode_;

	public const int IconFieldNumber = 29;

	private string icon_ = "";

	public const int IconBgFieldNumber = 30;

	private string iconBg_ = "";

	public const int SimpleNameFieldNumber = 31;

	private string simpleName_ = "";

	public const int RarityFieldNumber = 32;

	private int rarity_;

	public const int IsNewFieldNumber = 33;

	private bool isNew_;

	public const int PaymentCenterOnlyFieldNumber = 34;

	private bool paymentCenterOnly_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityReturneePack> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(40);

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
	public string Items
	{
		get
		{
			return items_;
		}
		set
		{
			items_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string DetailName
	{
		get
		{
			return detailName_;
		}
		set
		{
			detailName_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int SaleRate
	{
		get
		{
			return saleRate_;
		}
		set
		{
			saleRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Tag
	{
		get
		{
			return tag_;
		}
		set
		{
			tag_ = value;
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
	public int CurrencyType
	{
		get
		{
			return currencyType_;
		}
		set
		{
			currencyType_ = value;
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
	public string CurrencyShowPrice
	{
		get
		{
			return currencyShowPrice_;
		}
		set
		{
			currencyShowPrice_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string ProDeListTime
	{
		get
		{
			return proDeListTime_;
		}
		set
		{
			proDeListTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsSaleSkin
	{
		get
		{
			return isSaleSkin_;
		}
		set
		{
			isSaleSkin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BasePrice
	{
		get
		{
			return basePrice_;
		}
		set
		{
			basePrice_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CurrencyShowBasePrice
	{
		get
		{
			return currencyShowBasePrice_;
		}
		set
		{
			currencyShowBasePrice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ContentIcon => contentIcon_;

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
	public string SimpleName
	{
		get
		{
			return simpleName_;
		}
		set
		{
			simpleName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsNew
	{
		get
		{
			return isNew_;
		}
		set
		{
			isNew_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool PaymentCenterOnly
	{
		get
		{
			return paymentCenterOnly_;
		}
		set
		{
			paymentCenterOnly_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityReturneePack()
	{
	}

	[DebuggerNonUserCode]
	public ActivityReturneePack(ActivityReturneePack other)
		: this()
	{
		id_ = other.id_;
		returneeId_ = other.returneeId_;
		items_ = other.items_;
		name_ = other.name_;
		detailName_ = other.detailName_;
		groupId_ = other.groupId_;
		statisticalGroup_ = other.statisticalGroup_;
		saleRate_ = other.saleRate_;
		tag_ = other.tag_;
		sort_ = other.sort_;
		currencyType_ = other.currencyType_;
		currencyItemId_ = other.currencyItemId_;
		currencyItemQty_ = other.currencyItemQty_;
		currencyShowPrice_ = other.currencyShowPrice_;
		stock_ = other.stock_;
		refreshType_ = other.refreshType_;
		listCondType_ = other.listCondType_;
		listCondParams_ = other.listCondParams_;
		orderCondType_ = other.orderCondType_;
		orderCondParams_ = other.orderCondParams_;
		listTime_ = other.listTime_;
		deListTime_ = other.deListTime_;
		proDeListTime_ = other.proDeListTime_;
		isSaleSkin_ = other.isSaleSkin_;
		basePrice_ = other.basePrice_;
		currencyShowBasePrice_ = other.currencyShowBasePrice_;
		contentIcon_ = other.contentIcon_.Clone();
		displayMode_ = other.displayMode_;
		icon_ = other.icon_;
		iconBg_ = other.iconBg_;
		simpleName_ = other.simpleName_;
		rarity_ = other.rarity_;
		isNew_ = other.isNew_;
		paymentCenterOnly_ = other.paymentCenterOnly_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityReturneePack Clone()
	{
		return new ActivityReturneePack(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityReturneePack);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityReturneePack other)
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
		if (ReturneeId != other.ReturneeId)
		{
			return false;
		}
		if (Items != other.Items)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (DetailName != other.DetailName)
		{
			return false;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (StatisticalGroup != other.StatisticalGroup)
		{
			return false;
		}
		if (SaleRate != other.SaleRate)
		{
			return false;
		}
		if (Tag != other.Tag)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (CurrencyType != other.CurrencyType)
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
		if (CurrencyShowPrice != other.CurrencyShowPrice)
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
		if (ProDeListTime != other.ProDeListTime)
		{
			return false;
		}
		if (IsSaleSkin != other.IsSaleSkin)
		{
			return false;
		}
		if (BasePrice != other.BasePrice)
		{
			return false;
		}
		if (CurrencyShowBasePrice != other.CurrencyShowBasePrice)
		{
			return false;
		}
		if (!contentIcon_.Equals(other.contentIcon_))
		{
			return false;
		}
		if (DisplayMode != other.DisplayMode)
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
		if (SimpleName != other.SimpleName)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (IsNew != other.IsNew)
		{
			return false;
		}
		if (PaymentCenterOnly != other.PaymentCenterOnly)
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
		if (ReturneeId != 0)
		{
			num ^= ReturneeId.GetHashCode();
		}
		if (Items.Length != 0)
		{
			num ^= Items.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (DetailName.Length != 0)
		{
			num ^= DetailName.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (StatisticalGroup.Length != 0)
		{
			num ^= StatisticalGroup.GetHashCode();
		}
		if (SaleRate != 0)
		{
			num ^= SaleRate.GetHashCode();
		}
		if (Tag != 0)
		{
			num ^= Tag.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (CurrencyType != 0)
		{
			num ^= CurrencyType.GetHashCode();
		}
		if (CurrencyItemId != 0)
		{
			num ^= CurrencyItemId.GetHashCode();
		}
		if (CurrencyItemQty != 0)
		{
			num ^= CurrencyItemQty.GetHashCode();
		}
		if (CurrencyShowPrice.Length != 0)
		{
			num ^= CurrencyShowPrice.GetHashCode();
		}
		if (Stock != 0)
		{
			num ^= Stock.GetHashCode();
		}
		if (RefreshType != 0)
		{
			num ^= RefreshType.GetHashCode();
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
		if (ProDeListTime.Length != 0)
		{
			num ^= ProDeListTime.GetHashCode();
		}
		if (IsSaleSkin)
		{
			num ^= IsSaleSkin.GetHashCode();
		}
		if (BasePrice != 0)
		{
			num ^= BasePrice.GetHashCode();
		}
		if (CurrencyShowBasePrice.Length != 0)
		{
			num ^= CurrencyShowBasePrice.GetHashCode();
		}
		num ^= contentIcon_.GetHashCode();
		if (DisplayMode != 0)
		{
			num ^= DisplayMode.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (IconBg.Length != 0)
		{
			num ^= IconBg.GetHashCode();
		}
		if (SimpleName.Length != 0)
		{
			num ^= SimpleName.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (IsNew)
		{
			num ^= IsNew.GetHashCode();
		}
		if (PaymentCenterOnly)
		{
			num ^= PaymentCenterOnly.GetHashCode();
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
		if (ReturneeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ReturneeId);
		}
		if (Items.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Items);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (DetailName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DetailName);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(GroupId);
		}
		if (StatisticalGroup.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(StatisticalGroup);
		}
		if (SaleRate != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SaleRate);
		}
		if (Tag != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Tag);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Sort);
		}
		if (CurrencyType != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(CurrencyType);
		}
		if (CurrencyItemId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(CurrencyItemId);
		}
		if (CurrencyItemQty != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(CurrencyItemQty);
		}
		if (CurrencyShowPrice.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(CurrencyShowPrice);
		}
		if (Stock != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(Stock);
		}
		if (RefreshType != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(RefreshType);
		}
		if (ListCondType != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ListCondType);
		}
		if (ListCondParams.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(ListCondParams);
		}
		if (OrderCondType != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(OrderCondType);
		}
		if (OrderCondParams.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(OrderCondParams);
		}
		if (ListTime.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(ListTime);
		}
		if (DeListTime.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(DeListTime);
		}
		if (ProDeListTime.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(ProDeListTime);
		}
		if (IsSaleSkin)
		{
			output.WriteRawTag(192, 1);
			output.WriteBool(IsSaleSkin);
		}
		if (BasePrice != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(BasePrice);
		}
		if (CurrencyShowBasePrice.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(CurrencyShowBasePrice);
		}
		contentIcon_.WriteTo(output, _repeated_contentIcon_codec);
		if (DisplayMode != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(DisplayMode);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(234, 1);
			output.WriteString(Icon);
		}
		if (IconBg.Length != 0)
		{
			output.WriteRawTag(242, 1);
			output.WriteString(IconBg);
		}
		if (SimpleName.Length != 0)
		{
			output.WriteRawTag(250, 1);
			output.WriteString(SimpleName);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(Rarity);
		}
		if (IsNew)
		{
			output.WriteRawTag(136, 2);
			output.WriteBool(IsNew);
		}
		if (PaymentCenterOnly)
		{
			output.WriteRawTag(144, 2);
			output.WriteBool(PaymentCenterOnly);
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
		if (ReturneeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReturneeId);
		}
		if (Items.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Items);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (DetailName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DetailName);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (StatisticalGroup.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StatisticalGroup);
		}
		if (SaleRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SaleRate);
		}
		if (Tag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Tag);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (CurrencyType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrencyType);
		}
		if (CurrencyItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrencyItemId);
		}
		if (CurrencyItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrencyItemQty);
		}
		if (CurrencyShowPrice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CurrencyShowPrice);
		}
		if (Stock != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stock);
		}
		if (RefreshType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RefreshType);
		}
		if (ListCondType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ListCondType);
		}
		if (ListCondParams.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ListCondParams);
		}
		if (OrderCondType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(OrderCondType);
		}
		if (OrderCondParams.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(OrderCondParams);
		}
		if (ListTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ListTime);
		}
		if (DeListTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(DeListTime);
		}
		if (ProDeListTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ProDeListTime);
		}
		if (IsSaleSkin)
		{
			num += 3;
		}
		if (BasePrice != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BasePrice);
		}
		if (CurrencyShowBasePrice.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CurrencyShowBasePrice);
		}
		num += contentIcon_.CalculateSize(_repeated_contentIcon_codec);
		if (DisplayMode != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DisplayMode);
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (IconBg.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(IconBg);
		}
		if (SimpleName.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SimpleName);
		}
		if (Rarity != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (IsNew)
		{
			num += 3;
		}
		if (PaymentCenterOnly)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityReturneePack other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.ReturneeId != 0)
			{
				ReturneeId = other.ReturneeId;
			}
			if (other.Items.Length != 0)
			{
				Items = other.Items;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.DetailName.Length != 0)
			{
				DetailName = other.DetailName;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.StatisticalGroup.Length != 0)
			{
				StatisticalGroup = other.StatisticalGroup;
			}
			if (other.SaleRate != 0)
			{
				SaleRate = other.SaleRate;
			}
			if (other.Tag != 0)
			{
				Tag = other.Tag;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.CurrencyType != 0)
			{
				CurrencyType = other.CurrencyType;
			}
			if (other.CurrencyItemId != 0)
			{
				CurrencyItemId = other.CurrencyItemId;
			}
			if (other.CurrencyItemQty != 0)
			{
				CurrencyItemQty = other.CurrencyItemQty;
			}
			if (other.CurrencyShowPrice.Length != 0)
			{
				CurrencyShowPrice = other.CurrencyShowPrice;
			}
			if (other.Stock != 0)
			{
				Stock = other.Stock;
			}
			if (other.RefreshType != 0)
			{
				RefreshType = other.RefreshType;
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
			if (other.ProDeListTime.Length != 0)
			{
				ProDeListTime = other.ProDeListTime;
			}
			if (other.IsSaleSkin)
			{
				IsSaleSkin = other.IsSaleSkin;
			}
			if (other.BasePrice != 0)
			{
				BasePrice = other.BasePrice;
			}
			if (other.CurrencyShowBasePrice.Length != 0)
			{
				CurrencyShowBasePrice = other.CurrencyShowBasePrice;
			}
			contentIcon_.Add(other.contentIcon_);
			if (other.DisplayMode != 0)
			{
				DisplayMode = other.DisplayMode;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.IconBg.Length != 0)
			{
				IconBg = other.IconBg;
			}
			if (other.SimpleName.Length != 0)
			{
				SimpleName = other.SimpleName;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.IsNew)
			{
				IsNew = other.IsNew;
			}
			if (other.PaymentCenterOnly)
			{
				PaymentCenterOnly = other.PaymentCenterOnly;
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
			case 16u:
				ReturneeId = input.ReadInt32();
				break;
			case 26u:
				Items = input.ReadString();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				DetailName = input.ReadString();
				break;
			case 48u:
				GroupId = input.ReadInt32();
				break;
			case 58u:
				StatisticalGroup = input.ReadString();
				break;
			case 64u:
				SaleRate = input.ReadInt32();
				break;
			case 72u:
				Tag = input.ReadInt32();
				break;
			case 80u:
				Sort = input.ReadInt32();
				break;
			case 88u:
				CurrencyType = input.ReadInt32();
				break;
			case 96u:
				CurrencyItemId = input.ReadInt32();
				break;
			case 104u:
				CurrencyItemQty = input.ReadInt32();
				break;
			case 114u:
				CurrencyShowPrice = input.ReadString();
				break;
			case 120u:
				Stock = input.ReadInt32();
				break;
			case 128u:
				RefreshType = input.ReadInt32();
				break;
			case 136u:
				ListCondType = input.ReadInt32();
				break;
			case 146u:
				ListCondParams = input.ReadString();
				break;
			case 152u:
				OrderCondType = input.ReadInt32();
				break;
			case 162u:
				OrderCondParams = input.ReadString();
				break;
			case 170u:
				ListTime = input.ReadString();
				break;
			case 178u:
				DeListTime = input.ReadString();
				break;
			case 186u:
				ProDeListTime = input.ReadString();
				break;
			case 192u:
				IsSaleSkin = input.ReadBool();
				break;
			case 200u:
				BasePrice = input.ReadInt32();
				break;
			case 210u:
				CurrencyShowBasePrice = input.ReadString();
				break;
			case 216u:
			case 218u:
				contentIcon_.AddEntriesFrom(input, _repeated_contentIcon_codec);
				break;
			case 224u:
				DisplayMode = input.ReadInt32();
				break;
			case 234u:
				Icon = input.ReadString();
				break;
			case 242u:
				IconBg = input.ReadString();
				break;
			case 250u:
				SimpleName = input.ReadString();
				break;
			case 256u:
				Rarity = input.ReadInt32();
				break;
			case 264u:
				IsNew = input.ReadBool();
				break;
			case 272u:
				PaymentCenterOnly = input.ReadBool();
				break;
			}
		}
	}
}
