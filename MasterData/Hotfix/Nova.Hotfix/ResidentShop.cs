using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ResidentShop : IMessage<ResidentShop>, IMessage, IEquatable<ResidentShop>, IDeepCloneable<ResidentShop>
{
	private static readonly MessageParser<ResidentShop> _parser = new MessageParser<ResidentShop>(() => new ResidentShop());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ShopCoinFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_shopCoin_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> shopCoin_ = new RepeatedField<int>();

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int SequenceFieldNumber = 5;

	private int sequence_;

	public const int RefreshTimeTypeFieldNumber = 6;

	private int refreshTimeType_;

	public const int RefreshIntervalFieldNumber = 7;

	private int refreshInterval_;

	public const int UnlockCondTypeFieldNumber = 8;

	private int unlockCondType_;

	public const int UnlockCondParamsFieldNumber = 9;

	private string unlockCondParams_ = "";

	public const int OpenTimeFieldNumber = 10;

	private string openTime_ = "";

	public const int CloseTimeFieldNumber = 11;

	private string closeTime_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ResidentShop> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(686);

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
	public RepeatedField<int> ShopCoin => shopCoin_;

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
	public string OpenTime
	{
		get
		{
			return openTime_;
		}
		set
		{
			openTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CloseTime
	{
		get
		{
			return closeTime_;
		}
		set
		{
			closeTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ResidentShop()
	{
	}

	[DebuggerNonUserCode]
	public ResidentShop(ResidentShop other)
		: this()
	{
		id_ = other.id_;
		shopCoin_ = other.shopCoin_.Clone();
		type_ = other.type_;
		name_ = other.name_;
		sequence_ = other.sequence_;
		refreshTimeType_ = other.refreshTimeType_;
		refreshInterval_ = other.refreshInterval_;
		unlockCondType_ = other.unlockCondType_;
		unlockCondParams_ = other.unlockCondParams_;
		openTime_ = other.openTime_;
		closeTime_ = other.closeTime_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ResidentShop Clone()
	{
		return new ResidentShop(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ResidentShop);
	}

	[DebuggerNonUserCode]
	public bool Equals(ResidentShop other)
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
		if (!shopCoin_.Equals(other.shopCoin_))
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
		if (OpenTime != other.OpenTime)
		{
			return false;
		}
		if (CloseTime != other.CloseTime)
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
		num ^= shopCoin_.GetHashCode();
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
		if (OpenTime.Length != 0)
		{
			num ^= OpenTime.GetHashCode();
		}
		if (CloseTime.Length != 0)
		{
			num ^= CloseTime.GetHashCode();
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
		shopCoin_.WriteTo(output, _repeated_shopCoin_codec);
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Sequence != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Sequence);
		}
		if (RefreshTimeType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RefreshTimeType);
		}
		if (RefreshInterval != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RefreshInterval);
		}
		if (UnlockCondType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(UnlockCondType);
		}
		if (UnlockCondParams.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(UnlockCondParams);
		}
		if (OpenTime.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(OpenTime);
		}
		if (CloseTime.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(CloseTime);
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
		num += shopCoin_.CalculateSize(_repeated_shopCoin_codec);
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
		if (OpenTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenTime);
		}
		if (CloseTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CloseTime);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ResidentShop other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			shopCoin_.Add(other.shopCoin_);
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
			if (other.OpenTime.Length != 0)
			{
				OpenTime = other.OpenTime;
			}
			if (other.CloseTime.Length != 0)
			{
				CloseTime = other.CloseTime;
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
			case 18u:
				shopCoin_.AddEntriesFrom(input, _repeated_shopCoin_codec);
				break;
			case 24u:
				Type = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 40u:
				Sequence = input.ReadInt32();
				break;
			case 48u:
				RefreshTimeType = input.ReadInt32();
				break;
			case 56u:
				RefreshInterval = input.ReadInt32();
				break;
			case 64u:
				UnlockCondType = input.ReadInt32();
				break;
			case 74u:
				UnlockCondParams = input.ReadString();
				break;
			case 82u:
				OpenTime = input.ReadString();
				break;
			case 90u:
				CloseTime = input.ReadString();
				break;
			}
		}
	}
}
