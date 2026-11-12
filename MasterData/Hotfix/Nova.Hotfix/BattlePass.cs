using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BattlePass : IMessage<BattlePass>, IMessage, IEquatable<BattlePass>, IDeepCloneable<BattlePass>
{
	private static readonly MessageParser<BattlePass> _parser = new MessageParser<BattlePass>(() => new BattlePass());

	private UnknownFieldSet _unknownFields;

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int StartTimeFieldNumber = 3;

	private string startTime_ = "";

	public const int EndTimeFieldNumber = 4;

	private string endTime_ = "";

	public const int LuxuryProductIdFieldNumber = 5;

	private string luxuryProductId_ = "";

	public const int LuxuryPriceFieldNumber = 6;

	private int luxuryPrice_;

	public const int LuxuryShowPriceFieldNumber = 7;

	private string luxuryShowPrice_ = "";

	public const int LuxuryBonusLevelFieldNumber = 8;

	private int luxuryBonusLevel_;

	public const int LuxuryTidFieldNumber = 9;

	private int luxuryTid_;

	public const int LuxuryQtyFieldNumber = 10;

	private int luxuryQty_;

	public const int PremiumProductIdFieldNumber = 11;

	private string premiumProductId_ = "";

	public const int PremiumPriceFieldNumber = 12;

	private int premiumPrice_;

	public const int PremiumShowPriceFieldNumber = 13;

	private string premiumShowPrice_ = "";

	public const int PremiumTidFieldNumber = 14;

	private int premiumTid_;

	public const int PremiumQtyFieldNumber = 15;

	private int premiumQty_;

	public const int ComplementaryProductIdFieldNumber = 16;

	private string complementaryProductId_ = "";

	public const int ComplementaryPriceFieldNumber = 17;

	private int complementaryPrice_;

	public const int ComplementaryShowPriceFieldNumber = 18;

	private string complementaryShowPrice_ = "";

	public const int ComplementaryTidFieldNumber = 19;

	private int complementaryTid_;

	public const int ComplementaryQtyFieldNumber = 20;

	private int complementaryQty_;

	public const int OriginShowPriceFieldNumber = 21;

	private string originShowPrice_ = "";

	public const int CoverColorFieldNumber = 22;

	private string coverColor_ = "";

	public const int CoverFieldNumber = 23;

	private int cover_;

	public const int PremiumShowItemsFieldNumber = 24;

	private static readonly FieldCodec<int> _repeated_premiumShowItems_codec = FieldCodec.ForInt32(194u);

	private readonly RepeatedField<int> premiumShowItems_ = new RepeatedField<int>();

	public const int LuxuryShowItemsFieldNumber = 25;

	private static readonly FieldCodec<int> _repeated_luxuryShowItems_codec = FieldCodec.ForInt32(202u);

	private readonly RepeatedField<int> luxuryShowItems_ = new RepeatedField<int>();

	public const int OutfitPackageShowItemFieldNumber = 26;

	private int outfitPackageShowItem_;

	[DebuggerNonUserCode]
	public static MessageParser<BattlePass> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(110);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
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
	public string StartTime
	{
		get
		{
			return startTime_;
		}
		set
		{
			startTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LuxuryProductId
	{
		get
		{
			return luxuryProductId_;
		}
		set
		{
			luxuryProductId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int LuxuryPrice
	{
		get
		{
			return luxuryPrice_;
		}
		set
		{
			luxuryPrice_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string LuxuryShowPrice
	{
		get
		{
			return luxuryShowPrice_;
		}
		set
		{
			luxuryShowPrice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int LuxuryBonusLevel
	{
		get
		{
			return luxuryBonusLevel_;
		}
		set
		{
			luxuryBonusLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LuxuryTid
	{
		get
		{
			return luxuryTid_;
		}
		set
		{
			luxuryTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LuxuryQty
	{
		get
		{
			return luxuryQty_;
		}
		set
		{
			luxuryQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PremiumProductId
	{
		get
		{
			return premiumProductId_;
		}
		set
		{
			premiumProductId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PremiumPrice
	{
		get
		{
			return premiumPrice_;
		}
		set
		{
			premiumPrice_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PremiumShowPrice
	{
		get
		{
			return premiumShowPrice_;
		}
		set
		{
			premiumShowPrice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PremiumTid
	{
		get
		{
			return premiumTid_;
		}
		set
		{
			premiumTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PremiumQty
	{
		get
		{
			return premiumQty_;
		}
		set
		{
			premiumQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ComplementaryProductId
	{
		get
		{
			return complementaryProductId_;
		}
		set
		{
			complementaryProductId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ComplementaryPrice
	{
		get
		{
			return complementaryPrice_;
		}
		set
		{
			complementaryPrice_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ComplementaryShowPrice
	{
		get
		{
			return complementaryShowPrice_;
		}
		set
		{
			complementaryShowPrice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ComplementaryTid
	{
		get
		{
			return complementaryTid_;
		}
		set
		{
			complementaryTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ComplementaryQty
	{
		get
		{
			return complementaryQty_;
		}
		set
		{
			complementaryQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OriginShowPrice
	{
		get
		{
			return originShowPrice_;
		}
		set
		{
			originShowPrice_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CoverColor
	{
		get
		{
			return coverColor_;
		}
		set
		{
			coverColor_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Cover
	{
		get
		{
			return cover_;
		}
		set
		{
			cover_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> PremiumShowItems => premiumShowItems_;

	[DebuggerNonUserCode]
	public RepeatedField<int> LuxuryShowItems => luxuryShowItems_;

	[DebuggerNonUserCode]
	public int OutfitPackageShowItem
	{
		get
		{
			return outfitPackageShowItem_;
		}
		set
		{
			outfitPackageShowItem_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BattlePass()
	{
	}

	[DebuggerNonUserCode]
	public BattlePass(BattlePass other)
		: this()
	{
		iD_ = other.iD_;
		name_ = other.name_;
		startTime_ = other.startTime_;
		endTime_ = other.endTime_;
		luxuryProductId_ = other.luxuryProductId_;
		luxuryPrice_ = other.luxuryPrice_;
		luxuryShowPrice_ = other.luxuryShowPrice_;
		luxuryBonusLevel_ = other.luxuryBonusLevel_;
		luxuryTid_ = other.luxuryTid_;
		luxuryQty_ = other.luxuryQty_;
		premiumProductId_ = other.premiumProductId_;
		premiumPrice_ = other.premiumPrice_;
		premiumShowPrice_ = other.premiumShowPrice_;
		premiumTid_ = other.premiumTid_;
		premiumQty_ = other.premiumQty_;
		complementaryProductId_ = other.complementaryProductId_;
		complementaryPrice_ = other.complementaryPrice_;
		complementaryShowPrice_ = other.complementaryShowPrice_;
		complementaryTid_ = other.complementaryTid_;
		complementaryQty_ = other.complementaryQty_;
		originShowPrice_ = other.originShowPrice_;
		coverColor_ = other.coverColor_;
		cover_ = other.cover_;
		premiumShowItems_ = other.premiumShowItems_.Clone();
		luxuryShowItems_ = other.luxuryShowItems_.Clone();
		outfitPackageShowItem_ = other.outfitPackageShowItem_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BattlePass Clone()
	{
		return new BattlePass(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BattlePass);
	}

	[DebuggerNonUserCode]
	public bool Equals(BattlePass other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (LuxuryProductId != other.LuxuryProductId)
		{
			return false;
		}
		if (LuxuryPrice != other.LuxuryPrice)
		{
			return false;
		}
		if (LuxuryShowPrice != other.LuxuryShowPrice)
		{
			return false;
		}
		if (LuxuryBonusLevel != other.LuxuryBonusLevel)
		{
			return false;
		}
		if (LuxuryTid != other.LuxuryTid)
		{
			return false;
		}
		if (LuxuryQty != other.LuxuryQty)
		{
			return false;
		}
		if (PremiumProductId != other.PremiumProductId)
		{
			return false;
		}
		if (PremiumPrice != other.PremiumPrice)
		{
			return false;
		}
		if (PremiumShowPrice != other.PremiumShowPrice)
		{
			return false;
		}
		if (PremiumTid != other.PremiumTid)
		{
			return false;
		}
		if (PremiumQty != other.PremiumQty)
		{
			return false;
		}
		if (ComplementaryProductId != other.ComplementaryProductId)
		{
			return false;
		}
		if (ComplementaryPrice != other.ComplementaryPrice)
		{
			return false;
		}
		if (ComplementaryShowPrice != other.ComplementaryShowPrice)
		{
			return false;
		}
		if (ComplementaryTid != other.ComplementaryTid)
		{
			return false;
		}
		if (ComplementaryQty != other.ComplementaryQty)
		{
			return false;
		}
		if (OriginShowPrice != other.OriginShowPrice)
		{
			return false;
		}
		if (CoverColor != other.CoverColor)
		{
			return false;
		}
		if (Cover != other.Cover)
		{
			return false;
		}
		if (!premiumShowItems_.Equals(other.premiumShowItems_))
		{
			return false;
		}
		if (!luxuryShowItems_.Equals(other.luxuryShowItems_))
		{
			return false;
		}
		if (OutfitPackageShowItem != other.OutfitPackageShowItem)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		if (LuxuryProductId.Length != 0)
		{
			num ^= LuxuryProductId.GetHashCode();
		}
		if (LuxuryPrice != 0)
		{
			num ^= LuxuryPrice.GetHashCode();
		}
		if (LuxuryShowPrice.Length != 0)
		{
			num ^= LuxuryShowPrice.GetHashCode();
		}
		if (LuxuryBonusLevel != 0)
		{
			num ^= LuxuryBonusLevel.GetHashCode();
		}
		if (LuxuryTid != 0)
		{
			num ^= LuxuryTid.GetHashCode();
		}
		if (LuxuryQty != 0)
		{
			num ^= LuxuryQty.GetHashCode();
		}
		if (PremiumProductId.Length != 0)
		{
			num ^= PremiumProductId.GetHashCode();
		}
		if (PremiumPrice != 0)
		{
			num ^= PremiumPrice.GetHashCode();
		}
		if (PremiumShowPrice.Length != 0)
		{
			num ^= PremiumShowPrice.GetHashCode();
		}
		if (PremiumTid != 0)
		{
			num ^= PremiumTid.GetHashCode();
		}
		if (PremiumQty != 0)
		{
			num ^= PremiumQty.GetHashCode();
		}
		if (ComplementaryProductId.Length != 0)
		{
			num ^= ComplementaryProductId.GetHashCode();
		}
		if (ComplementaryPrice != 0)
		{
			num ^= ComplementaryPrice.GetHashCode();
		}
		if (ComplementaryShowPrice.Length != 0)
		{
			num ^= ComplementaryShowPrice.GetHashCode();
		}
		if (ComplementaryTid != 0)
		{
			num ^= ComplementaryTid.GetHashCode();
		}
		if (ComplementaryQty != 0)
		{
			num ^= ComplementaryQty.GetHashCode();
		}
		if (OriginShowPrice.Length != 0)
		{
			num ^= OriginShowPrice.GetHashCode();
		}
		if (CoverColor.Length != 0)
		{
			num ^= CoverColor.GetHashCode();
		}
		if (Cover != 0)
		{
			num ^= Cover.GetHashCode();
		}
		num ^= premiumShowItems_.GetHashCode();
		num ^= luxuryShowItems_.GetHashCode();
		if (OutfitPackageShowItem != 0)
		{
			num ^= OutfitPackageShowItem.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(StartTime);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(EndTime);
		}
		if (LuxuryProductId.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(LuxuryProductId);
		}
		if (LuxuryPrice != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(LuxuryPrice);
		}
		if (LuxuryShowPrice.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(LuxuryShowPrice);
		}
		if (LuxuryBonusLevel != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(LuxuryBonusLevel);
		}
		if (LuxuryTid != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(LuxuryTid);
		}
		if (LuxuryQty != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(LuxuryQty);
		}
		if (PremiumProductId.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(PremiumProductId);
		}
		if (PremiumPrice != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(PremiumPrice);
		}
		if (PremiumShowPrice.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(PremiumShowPrice);
		}
		if (PremiumTid != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(PremiumTid);
		}
		if (PremiumQty != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(PremiumQty);
		}
		if (ComplementaryProductId.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(ComplementaryProductId);
		}
		if (ComplementaryPrice != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ComplementaryPrice);
		}
		if (ComplementaryShowPrice.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(ComplementaryShowPrice);
		}
		if (ComplementaryTid != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(ComplementaryTid);
		}
		if (ComplementaryQty != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(ComplementaryQty);
		}
		if (OriginShowPrice.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(OriginShowPrice);
		}
		if (CoverColor.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(CoverColor);
		}
		if (Cover != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(Cover);
		}
		premiumShowItems_.WriteTo(output, _repeated_premiumShowItems_codec);
		luxuryShowItems_.WriteTo(output, _repeated_luxuryShowItems_codec);
		if (OutfitPackageShowItem != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(OutfitPackageShowItem);
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
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (EndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		if (LuxuryProductId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LuxuryProductId);
		}
		if (LuxuryPrice != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LuxuryPrice);
		}
		if (LuxuryShowPrice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LuxuryShowPrice);
		}
		if (LuxuryBonusLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LuxuryBonusLevel);
		}
		if (LuxuryTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LuxuryTid);
		}
		if (LuxuryQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LuxuryQty);
		}
		if (PremiumProductId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PremiumProductId);
		}
		if (PremiumPrice != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PremiumPrice);
		}
		if (PremiumShowPrice.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PremiumShowPrice);
		}
		if (PremiumTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PremiumTid);
		}
		if (PremiumQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PremiumQty);
		}
		if (ComplementaryProductId.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ComplementaryProductId);
		}
		if (ComplementaryPrice != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ComplementaryPrice);
		}
		if (ComplementaryShowPrice.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ComplementaryShowPrice);
		}
		if (ComplementaryTid != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ComplementaryTid);
		}
		if (ComplementaryQty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ComplementaryQty);
		}
		if (OriginShowPrice.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(OriginShowPrice);
		}
		if (CoverColor.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CoverColor);
		}
		if (Cover != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Cover);
		}
		num += premiumShowItems_.CalculateSize(_repeated_premiumShowItems_codec);
		num += luxuryShowItems_.CalculateSize(_repeated_luxuryShowItems_codec);
		if (OutfitPackageShowItem != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(OutfitPackageShowItem);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BattlePass other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			if (other.LuxuryProductId.Length != 0)
			{
				LuxuryProductId = other.LuxuryProductId;
			}
			if (other.LuxuryPrice != 0)
			{
				LuxuryPrice = other.LuxuryPrice;
			}
			if (other.LuxuryShowPrice.Length != 0)
			{
				LuxuryShowPrice = other.LuxuryShowPrice;
			}
			if (other.LuxuryBonusLevel != 0)
			{
				LuxuryBonusLevel = other.LuxuryBonusLevel;
			}
			if (other.LuxuryTid != 0)
			{
				LuxuryTid = other.LuxuryTid;
			}
			if (other.LuxuryQty != 0)
			{
				LuxuryQty = other.LuxuryQty;
			}
			if (other.PremiumProductId.Length != 0)
			{
				PremiumProductId = other.PremiumProductId;
			}
			if (other.PremiumPrice != 0)
			{
				PremiumPrice = other.PremiumPrice;
			}
			if (other.PremiumShowPrice.Length != 0)
			{
				PremiumShowPrice = other.PremiumShowPrice;
			}
			if (other.PremiumTid != 0)
			{
				PremiumTid = other.PremiumTid;
			}
			if (other.PremiumQty != 0)
			{
				PremiumQty = other.PremiumQty;
			}
			if (other.ComplementaryProductId.Length != 0)
			{
				ComplementaryProductId = other.ComplementaryProductId;
			}
			if (other.ComplementaryPrice != 0)
			{
				ComplementaryPrice = other.ComplementaryPrice;
			}
			if (other.ComplementaryShowPrice.Length != 0)
			{
				ComplementaryShowPrice = other.ComplementaryShowPrice;
			}
			if (other.ComplementaryTid != 0)
			{
				ComplementaryTid = other.ComplementaryTid;
			}
			if (other.ComplementaryQty != 0)
			{
				ComplementaryQty = other.ComplementaryQty;
			}
			if (other.OriginShowPrice.Length != 0)
			{
				OriginShowPrice = other.OriginShowPrice;
			}
			if (other.CoverColor.Length != 0)
			{
				CoverColor = other.CoverColor;
			}
			if (other.Cover != 0)
			{
				Cover = other.Cover;
			}
			premiumShowItems_.Add(other.premiumShowItems_);
			luxuryShowItems_.Add(other.luxuryShowItems_);
			if (other.OutfitPackageShowItem != 0)
			{
				OutfitPackageShowItem = other.OutfitPackageShowItem;
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
				ID = input.ReadInt32();
				break;
			case 18u:
				Name = input.ReadString();
				break;
			case 26u:
				StartTime = input.ReadString();
				break;
			case 34u:
				EndTime = input.ReadString();
				break;
			case 42u:
				LuxuryProductId = input.ReadString();
				break;
			case 48u:
				LuxuryPrice = input.ReadInt32();
				break;
			case 58u:
				LuxuryShowPrice = input.ReadString();
				break;
			case 64u:
				LuxuryBonusLevel = input.ReadInt32();
				break;
			case 72u:
				LuxuryTid = input.ReadInt32();
				break;
			case 80u:
				LuxuryQty = input.ReadInt32();
				break;
			case 90u:
				PremiumProductId = input.ReadString();
				break;
			case 96u:
				PremiumPrice = input.ReadInt32();
				break;
			case 106u:
				PremiumShowPrice = input.ReadString();
				break;
			case 112u:
				PremiumTid = input.ReadInt32();
				break;
			case 120u:
				PremiumQty = input.ReadInt32();
				break;
			case 130u:
				ComplementaryProductId = input.ReadString();
				break;
			case 136u:
				ComplementaryPrice = input.ReadInt32();
				break;
			case 146u:
				ComplementaryShowPrice = input.ReadString();
				break;
			case 152u:
				ComplementaryTid = input.ReadInt32();
				break;
			case 160u:
				ComplementaryQty = input.ReadInt32();
				break;
			case 170u:
				OriginShowPrice = input.ReadString();
				break;
			case 178u:
				CoverColor = input.ReadString();
				break;
			case 184u:
				Cover = input.ReadInt32();
				break;
			case 192u:
			case 194u:
				premiumShowItems_.AddEntriesFrom(input, _repeated_premiumShowItems_codec);
				break;
			case 200u:
			case 202u:
				luxuryShowItems_.AddEntriesFrom(input, _repeated_luxuryShowItems_codec);
				break;
			case 208u:
				OutfitPackageShowItem = input.ReadInt32();
				break;
			}
		}
	}
}
