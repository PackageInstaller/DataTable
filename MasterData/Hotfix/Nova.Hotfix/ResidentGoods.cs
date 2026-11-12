using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ResidentGoods : IMessage<ResidentGoods>, IMessage, IEquatable<ResidentGoods>, IDeepCloneable<ResidentGoods>
{
	private static readonly MessageParser<ResidentGoods> _parser = new MessageParser<ResidentGoods>(() => new ResidentGoods());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int ShopIdFieldNumber = 4;

	private int shopId_;

	public const int SaleNumberFieldNumber = 5;

	private int saleNumber_;

	public const int ItemIdFieldNumber = 6;

	private int itemId_;

	public const int ItemQuantityFieldNumber = 7;

	private int itemQuantity_;

	public const int MaximumLimitFieldNumber = 8;

	private int maximumLimit_;

	public const int CurrencyItemIdFieldNumber = 9;

	private int currencyItemId_;

	public const int PriceFieldNumber = 10;

	private int price_;

	public const int OriginalPriceFieldNumber = 11;

	private int originalPrice_;

	public const int DiscountFieldNumber = 12;

	private int discount_;

	public const int AppearCondTypeFieldNumber = 13;

	private int appearCondType_;

	public const int AppearCondParamsFieldNumber = 14;

	private string appearCondParams_ = "";

	public const int PurchaseCondTypeFieldNumber = 15;

	private int purchaseCondType_;

	public const int PurchaseCondParamsFieldNumber = 16;

	private string purchaseCondParams_ = "";

	public const int UpShelfTimeFieldNumber = 17;

	private string upShelfTime_ = "";

	public const int DownShelfTimeFieldNumber = 18;

	private string downShelfTime_ = "";

	public const int UnlockPurchaseTimeFieldNumber = 19;

	private string unlockPurchaseTime_ = "";

	public const int DisplayModeFieldNumber = 20;

	private int displayMode_;

	[DebuggerNonUserCode]
	public static MessageParser<ResidentGoods> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(684);

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
	public int ShopId
	{
		get
		{
			return shopId_;
		}
		set
		{
			shopId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SaleNumber
	{
		get
		{
			return saleNumber_;
		}
		set
		{
			saleNumber_ = value;
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
	public int ItemQuantity
	{
		get
		{
			return itemQuantity_;
		}
		set
		{
			itemQuantity_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaximumLimit
	{
		get
		{
			return maximumLimit_;
		}
		set
		{
			maximumLimit_ = value;
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
	public int OriginalPrice
	{
		get
		{
			return originalPrice_;
		}
		set
		{
			originalPrice_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Discount
	{
		get
		{
			return discount_;
		}
		set
		{
			discount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AppearCondType
	{
		get
		{
			return appearCondType_;
		}
		set
		{
			appearCondType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AppearCondParams
	{
		get
		{
			return appearCondParams_;
		}
		set
		{
			appearCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PurchaseCondType
	{
		get
		{
			return purchaseCondType_;
		}
		set
		{
			purchaseCondType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PurchaseCondParams
	{
		get
		{
			return purchaseCondParams_;
		}
		set
		{
			purchaseCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string UpShelfTime
	{
		get
		{
			return upShelfTime_;
		}
		set
		{
			upShelfTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DownShelfTime
	{
		get
		{
			return downShelfTime_;
		}
		set
		{
			downShelfTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string UnlockPurchaseTime
	{
		get
		{
			return unlockPurchaseTime_;
		}
		set
		{
			unlockPurchaseTime_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public ResidentGoods()
	{
	}

	[DebuggerNonUserCode]
	public ResidentGoods(ResidentGoods other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		shopId_ = other.shopId_;
		saleNumber_ = other.saleNumber_;
		itemId_ = other.itemId_;
		itemQuantity_ = other.itemQuantity_;
		maximumLimit_ = other.maximumLimit_;
		currencyItemId_ = other.currencyItemId_;
		price_ = other.price_;
		originalPrice_ = other.originalPrice_;
		discount_ = other.discount_;
		appearCondType_ = other.appearCondType_;
		appearCondParams_ = other.appearCondParams_;
		purchaseCondType_ = other.purchaseCondType_;
		purchaseCondParams_ = other.purchaseCondParams_;
		upShelfTime_ = other.upShelfTime_;
		downShelfTime_ = other.downShelfTime_;
		unlockPurchaseTime_ = other.unlockPurchaseTime_;
		displayMode_ = other.displayMode_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ResidentGoods Clone()
	{
		return new ResidentGoods(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ResidentGoods);
	}

	[DebuggerNonUserCode]
	public bool Equals(ResidentGoods other)
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
		if (ShopId != other.ShopId)
		{
			return false;
		}
		if (SaleNumber != other.SaleNumber)
		{
			return false;
		}
		if (ItemId != other.ItemId)
		{
			return false;
		}
		if (ItemQuantity != other.ItemQuantity)
		{
			return false;
		}
		if (MaximumLimit != other.MaximumLimit)
		{
			return false;
		}
		if (CurrencyItemId != other.CurrencyItemId)
		{
			return false;
		}
		if (Price != other.Price)
		{
			return false;
		}
		if (OriginalPrice != other.OriginalPrice)
		{
			return false;
		}
		if (Discount != other.Discount)
		{
			return false;
		}
		if (AppearCondType != other.AppearCondType)
		{
			return false;
		}
		if (AppearCondParams != other.AppearCondParams)
		{
			return false;
		}
		if (PurchaseCondType != other.PurchaseCondType)
		{
			return false;
		}
		if (PurchaseCondParams != other.PurchaseCondParams)
		{
			return false;
		}
		if (UpShelfTime != other.UpShelfTime)
		{
			return false;
		}
		if (DownShelfTime != other.DownShelfTime)
		{
			return false;
		}
		if (UnlockPurchaseTime != other.UnlockPurchaseTime)
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
		if (Id != 0)
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
		if (ShopId != 0)
		{
			num ^= ShopId.GetHashCode();
		}
		if (SaleNumber != 0)
		{
			num ^= SaleNumber.GetHashCode();
		}
		if (ItemId != 0)
		{
			num ^= ItemId.GetHashCode();
		}
		if (ItemQuantity != 0)
		{
			num ^= ItemQuantity.GetHashCode();
		}
		if (MaximumLimit != 0)
		{
			num ^= MaximumLimit.GetHashCode();
		}
		if (CurrencyItemId != 0)
		{
			num ^= CurrencyItemId.GetHashCode();
		}
		if (Price != 0)
		{
			num ^= Price.GetHashCode();
		}
		if (OriginalPrice != 0)
		{
			num ^= OriginalPrice.GetHashCode();
		}
		if (Discount != 0)
		{
			num ^= Discount.GetHashCode();
		}
		if (AppearCondType != 0)
		{
			num ^= AppearCondType.GetHashCode();
		}
		if (AppearCondParams.Length != 0)
		{
			num ^= AppearCondParams.GetHashCode();
		}
		if (PurchaseCondType != 0)
		{
			num ^= PurchaseCondType.GetHashCode();
		}
		if (PurchaseCondParams.Length != 0)
		{
			num ^= PurchaseCondParams.GetHashCode();
		}
		if (UpShelfTime.Length != 0)
		{
			num ^= UpShelfTime.GetHashCode();
		}
		if (DownShelfTime.Length != 0)
		{
			num ^= DownShelfTime.GetHashCode();
		}
		if (UnlockPurchaseTime.Length != 0)
		{
			num ^= UnlockPurchaseTime.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
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
		if (ShopId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ShopId);
		}
		if (SaleNumber != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SaleNumber);
		}
		if (ItemId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(ItemId);
		}
		if (ItemQuantity != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ItemQuantity);
		}
		if (MaximumLimit != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(MaximumLimit);
		}
		if (CurrencyItemId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CurrencyItemId);
		}
		if (Price != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Price);
		}
		if (OriginalPrice != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(OriginalPrice);
		}
		if (Discount != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Discount);
		}
		if (AppearCondType != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(AppearCondType);
		}
		if (AppearCondParams.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(AppearCondParams);
		}
		if (PurchaseCondType != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(PurchaseCondType);
		}
		if (PurchaseCondParams.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(PurchaseCondParams);
		}
		if (UpShelfTime.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(UpShelfTime);
		}
		if (DownShelfTime.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(DownShelfTime);
		}
		if (UnlockPurchaseTime.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(UnlockPurchaseTime);
		}
		if (DisplayMode != 0)
		{
			output.WriteRawTag(160, 1);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (ShopId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShopId);
		}
		if (SaleNumber != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SaleNumber);
		}
		if (ItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemId);
		}
		if (ItemQuantity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemQuantity);
		}
		if (MaximumLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaximumLimit);
		}
		if (CurrencyItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrencyItemId);
		}
		if (Price != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Price);
		}
		if (OriginalPrice != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OriginalPrice);
		}
		if (Discount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Discount);
		}
		if (AppearCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AppearCondType);
		}
		if (AppearCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AppearCondParams);
		}
		if (PurchaseCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PurchaseCondType);
		}
		if (PurchaseCondParams.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PurchaseCondParams);
		}
		if (UpShelfTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(UpShelfTime);
		}
		if (DownShelfTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(DownShelfTime);
		}
		if (UnlockPurchaseTime.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(UnlockPurchaseTime);
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
	public void MergeFrom(ResidentGoods other)
	{
		if (other != null)
		{
			if (other.Id != 0)
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
			if (other.ShopId != 0)
			{
				ShopId = other.ShopId;
			}
			if (other.SaleNumber != 0)
			{
				SaleNumber = other.SaleNumber;
			}
			if (other.ItemId != 0)
			{
				ItemId = other.ItemId;
			}
			if (other.ItemQuantity != 0)
			{
				ItemQuantity = other.ItemQuantity;
			}
			if (other.MaximumLimit != 0)
			{
				MaximumLimit = other.MaximumLimit;
			}
			if (other.CurrencyItemId != 0)
			{
				CurrencyItemId = other.CurrencyItemId;
			}
			if (other.Price != 0)
			{
				Price = other.Price;
			}
			if (other.OriginalPrice != 0)
			{
				OriginalPrice = other.OriginalPrice;
			}
			if (other.Discount != 0)
			{
				Discount = other.Discount;
			}
			if (other.AppearCondType != 0)
			{
				AppearCondType = other.AppearCondType;
			}
			if (other.AppearCondParams.Length != 0)
			{
				AppearCondParams = other.AppearCondParams;
			}
			if (other.PurchaseCondType != 0)
			{
				PurchaseCondType = other.PurchaseCondType;
			}
			if (other.PurchaseCondParams.Length != 0)
			{
				PurchaseCondParams = other.PurchaseCondParams;
			}
			if (other.UpShelfTime.Length != 0)
			{
				UpShelfTime = other.UpShelfTime;
			}
			if (other.DownShelfTime.Length != 0)
			{
				DownShelfTime = other.DownShelfTime;
			}
			if (other.UnlockPurchaseTime.Length != 0)
			{
				UnlockPurchaseTime = other.UnlockPurchaseTime;
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
			case 8u:
				Id = input.ReadInt32();
				break;
			case 18u:
				Name = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				ShopId = input.ReadInt32();
				break;
			case 40u:
				SaleNumber = input.ReadInt32();
				break;
			case 48u:
				ItemId = input.ReadInt32();
				break;
			case 56u:
				ItemQuantity = input.ReadInt32();
				break;
			case 64u:
				MaximumLimit = input.ReadInt32();
				break;
			case 72u:
				CurrencyItemId = input.ReadInt32();
				break;
			case 80u:
				Price = input.ReadInt32();
				break;
			case 88u:
				OriginalPrice = input.ReadInt32();
				break;
			case 96u:
				Discount = input.ReadInt32();
				break;
			case 104u:
				AppearCondType = input.ReadInt32();
				break;
			case 114u:
				AppearCondParams = input.ReadString();
				break;
			case 120u:
				PurchaseCondType = input.ReadInt32();
				break;
			case 130u:
				PurchaseCondParams = input.ReadString();
				break;
			case 138u:
				UpShelfTime = input.ReadString();
				break;
			case 146u:
				DownShelfTime = input.ReadString();
				break;
			case 154u:
				UnlockPurchaseTime = input.ReadString();
				break;
			case 160u:
				DisplayMode = input.ReadInt32();
				break;
			}
		}
	}
}
