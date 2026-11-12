using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityShop : IMessage<ActivityShop>, IMessage, IEquatable<ActivityShop>, IDeepCloneable<ActivityShop>
{
	private static readonly MessageParser<ActivityShop> _parser = new MessageParser<ActivityShop>(() => new ActivityShop());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int SequenceFieldNumber = 4;

	private int sequence_;

	public const int RefreshTimeTypeFieldNumber = 5;

	private int refreshTimeType_;

	public const int RefreshIntervalFieldNumber = 6;

	private int refreshInterval_;

	public const int UnlockCondTypeFieldNumber = 7;

	private int unlockCondType_;

	public const int UnlockCondParamsFieldNumber = 8;

	private string unlockCondParams_ = "";

	public const int CurrencyItemIdFieldNumber = 9;

	private int currencyItemId_;

	public const int ExchangeItemIdFieldNumber = 10;

	private int exchangeItemId_;

	public const int RateFieldNumber = 11;

	private float rate_;

	public const int OtherExchangeItem1FieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_otherExchangeItem1_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> otherExchangeItem1_ = new RepeatedField<int>();

	public const int OtherExchangeItem2FieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_otherExchangeItem2_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> otherExchangeItem2_ = new RepeatedField<int>();

	public const int OtherExchangeItem3FieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_otherExchangeItem3_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> otherExchangeItem3_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<ActivityShop> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(54);

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
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
	public int Sequence
	{
		get
		{
			return sequence_;
		}
		set
		{
			sequence_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RefreshTimeType
	{
		get
		{
			return refreshTimeType_;
		}
		set
		{
			refreshTimeType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RefreshInterval
	{
		get
		{
			return refreshInterval_;
		}
		set
		{
			refreshInterval_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockCondType
	{
		get
		{
			return unlockCondType_;
		}
		set
		{
			unlockCondType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string UnlockCondParams
	{
		get
		{
			return unlockCondParams_;
		}
		set
		{
			unlockCondParams_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public float Rate
	{
		get
		{
			return rate_;
		}
		set
		{
			rate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> OtherExchangeItem1 => otherExchangeItem1_;

	[DebuggerNonUserCode]
	public RepeatedField<int> OtherExchangeItem2 => otherExchangeItem2_;

	[DebuggerNonUserCode]
	public RepeatedField<int> OtherExchangeItem3 => otherExchangeItem3_;

	[DebuggerNonUserCode]
	public ActivityShop()
	{
	}

	[DebuggerNonUserCode]
	public ActivityShop(ActivityShop other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		name_ = other.name_;
		sequence_ = other.sequence_;
		refreshTimeType_ = other.refreshTimeType_;
		refreshInterval_ = other.refreshInterval_;
		unlockCondType_ = other.unlockCondType_;
		unlockCondParams_ = other.unlockCondParams_;
		currencyItemId_ = other.currencyItemId_;
		exchangeItemId_ = other.exchangeItemId_;
		rate_ = other.rate_;
		otherExchangeItem1_ = other.otherExchangeItem1_.Clone();
		otherExchangeItem2_ = other.otherExchangeItem2_.Clone();
		otherExchangeItem3_ = other.otherExchangeItem3_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityShop Clone()
	{
		return new ActivityShop(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityShop);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityShop other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Sequence != other.Sequence)
		{
			return false;
		}
		if (RefreshTimeType != other.RefreshTimeType)
		{
			return false;
		}
		if (RefreshInterval != other.RefreshInterval)
		{
			return false;
		}
		if (UnlockCondType != other.UnlockCondType)
		{
			return false;
		}
		if (UnlockCondParams != other.UnlockCondParams)
		{
			return false;
		}
		if (CurrencyItemId != other.CurrencyItemId)
		{
			return false;
		}
		if (ExchangeItemId != other.ExchangeItemId)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Rate, other.Rate))
		{
			return false;
		}
		if (!otherExchangeItem1_.Equals(other.otherExchangeItem1_))
		{
			return false;
		}
		if (!otherExchangeItem2_.Equals(other.otherExchangeItem2_))
		{
			return false;
		}
		if (!otherExchangeItem3_.Equals(other.otherExchangeItem3_))
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Sequence != 0)
		{
			num ^= Sequence.GetHashCode();
		}
		if (RefreshTimeType != 0)
		{
			num ^= RefreshTimeType.GetHashCode();
		}
		if (RefreshInterval != 0)
		{
			num ^= RefreshInterval.GetHashCode();
		}
		if (UnlockCondType != 0)
		{
			num ^= UnlockCondType.GetHashCode();
		}
		if (UnlockCondParams.Length != 0)
		{
			num ^= UnlockCondParams.GetHashCode();
		}
		if (CurrencyItemId != 0)
		{
			num ^= CurrencyItemId.GetHashCode();
		}
		if (ExchangeItemId != 0)
		{
			num ^= ExchangeItemId.GetHashCode();
		}
		if (Rate != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Rate);
		}
		num ^= otherExchangeItem1_.GetHashCode();
		num ^= otherExchangeItem2_.GetHashCode();
		num ^= otherExchangeItem3_.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (Sequence != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Sequence);
		}
		if (RefreshTimeType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(RefreshTimeType);
		}
		if (RefreshInterval != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RefreshInterval);
		}
		if (UnlockCondType != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(UnlockCondType);
		}
		if (UnlockCondParams.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(UnlockCondParams);
		}
		if (CurrencyItemId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CurrencyItemId);
		}
		if (ExchangeItemId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ExchangeItemId);
		}
		if (Rate != 0f)
		{
			output.WriteRawTag(93);
			output.WriteFloat(Rate);
		}
		otherExchangeItem1_.WriteTo(output, _repeated_otherExchangeItem1_codec);
		otherExchangeItem2_.WriteTo(output, _repeated_otherExchangeItem2_codec);
		otherExchangeItem3_.WriteTo(output, _repeated_otherExchangeItem3_codec);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Sequence != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sequence);
		}
		if (RefreshTimeType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefreshTimeType);
		}
		if (RefreshInterval != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefreshInterval);
		}
		if (UnlockCondType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockCondType);
		}
		if (UnlockCondParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UnlockCondParams);
		}
		if (CurrencyItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrencyItemId);
		}
		if (ExchangeItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExchangeItemId);
		}
		if (Rate != 0f)
		{
			num += 5;
		}
		num += otherExchangeItem1_.CalculateSize(_repeated_otherExchangeItem1_codec);
		num += otherExchangeItem2_.CalculateSize(_repeated_otherExchangeItem2_codec);
		num += otherExchangeItem3_.CalculateSize(_repeated_otherExchangeItem3_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityShop other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Sequence != 0)
			{
				Sequence = other.Sequence;
			}
			if (other.RefreshTimeType != 0)
			{
				RefreshTimeType = other.RefreshTimeType;
			}
			if (other.RefreshInterval != 0)
			{
				RefreshInterval = other.RefreshInterval;
			}
			if (other.UnlockCondType != 0)
			{
				UnlockCondType = other.UnlockCondType;
			}
			if (other.UnlockCondParams.Length != 0)
			{
				UnlockCondParams = other.UnlockCondParams;
			}
			if (other.CurrencyItemId != 0)
			{
				CurrencyItemId = other.CurrencyItemId;
			}
			if (other.ExchangeItemId != 0)
			{
				ExchangeItemId = other.ExchangeItemId;
			}
			if (other.Rate != 0f)
			{
				Rate = other.Rate;
			}
			otherExchangeItem1_.Add(other.otherExchangeItem1_);
			otherExchangeItem2_.Add(other.otherExchangeItem2_);
			otherExchangeItem3_.Add(other.otherExchangeItem3_);
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
				Type = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 32u:
				Sequence = input.ReadInt32();
				break;
			case 40u:
				RefreshTimeType = input.ReadInt32();
				break;
			case 48u:
				RefreshInterval = input.ReadInt32();
				break;
			case 56u:
				UnlockCondType = input.ReadInt32();
				break;
			case 66u:
				UnlockCondParams = input.ReadString();
				break;
			case 72u:
				CurrencyItemId = input.ReadInt32();
				break;
			case 80u:
				ExchangeItemId = input.ReadInt32();
				break;
			case 93u:
				Rate = input.ReadFloat();
				break;
			case 96u:
			case 98u:
				otherExchangeItem1_.AddEntriesFrom(input, _repeated_otherExchangeItem1_codec);
				break;
			case 104u:
			case 106u:
				otherExchangeItem2_.AddEntriesFrom(input, _repeated_otherExchangeItem2_codec);
				break;
			case 112u:
			case 114u:
				otherExchangeItem3_.AddEntriesFrom(input, _repeated_otherExchangeItem3_codec);
				break;
			}
		}
	}
}
