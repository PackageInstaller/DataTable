using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GachaResidentPool : IMessage<GachaResidentPool>, IMessage, IEquatable<GachaResidentPool>, IDeepCloneable<GachaResidentPool>, IBufferMessage
{
	private static readonly MessageParser<GachaResidentPool> _parser = new MessageParser<GachaResidentPool>(() => new GachaResidentPool());

	private UnknownFieldSet _unknownFields;

	public const int TotalCountFieldNumber = 1;

	private int totalCount_;

	public const int CountForTenConsecutiveDiscountFieldNumber = 2;

	private int countForTenConsecutiveDiscount_;

	public const int CountForNotHighestQualityFieldNumber = 3;

	private int countForNotHighestQuality_;

	public const int CountForNotHighQualityFieldNumber = 4;

	private int countForNotHighQuality_;

	public const int CountForNotExchangeFinalGuaranteedFieldNumber = 5;

	private int countForNotExchangeFinalGuaranteed_;

	public const int GotNewbieGuaranteedFieldNumber = 6;

	private bool gotNewbieGuaranteed_;

	public const int ExchangedFinalGuaranteedFieldNumber = 7;

	private bool exchangedFinalGuaranteed_;

	public const int CountForNotHighQualityUpFieldNumber = 8;

	private int countForNotHighQualityUp_;

	public const int LatestDrawItemTypeListFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_latestDrawItemTypeList_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> latestDrawItemTypeList_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaResidentPool> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[153];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TotalCount
	{
		get
		{
			return totalCount_;
		}
		set
		{
			totalCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CountForTenConsecutiveDiscount
	{
		get
		{
			return countForTenConsecutiveDiscount_;
		}
		set
		{
			countForTenConsecutiveDiscount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CountForNotHighestQuality
	{
		get
		{
			return countForNotHighestQuality_;
		}
		set
		{
			countForNotHighestQuality_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CountForNotHighQuality
	{
		get
		{
			return countForNotHighQuality_;
		}
		set
		{
			countForNotHighQuality_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CountForNotExchangeFinalGuaranteed
	{
		get
		{
			return countForNotExchangeFinalGuaranteed_;
		}
		set
		{
			countForNotExchangeFinalGuaranteed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool GotNewbieGuaranteed
	{
		get
		{
			return gotNewbieGuaranteed_;
		}
		set
		{
			gotNewbieGuaranteed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool ExchangedFinalGuaranteed
	{
		get
		{
			return exchangedFinalGuaranteed_;
		}
		set
		{
			exchangedFinalGuaranteed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CountForNotHighQualityUp
	{
		get
		{
			return countForNotHighQualityUp_;
		}
		set
		{
			countForNotHighQualityUp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> LatestDrawItemTypeList => latestDrawItemTypeList_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaResidentPool()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaResidentPool(GachaResidentPool other)
		: this()
	{
		totalCount_ = other.totalCount_;
		countForTenConsecutiveDiscount_ = other.countForTenConsecutiveDiscount_;
		countForNotHighestQuality_ = other.countForNotHighestQuality_;
		countForNotHighQuality_ = other.countForNotHighQuality_;
		countForNotExchangeFinalGuaranteed_ = other.countForNotExchangeFinalGuaranteed_;
		gotNewbieGuaranteed_ = other.gotNewbieGuaranteed_;
		exchangedFinalGuaranteed_ = other.exchangedFinalGuaranteed_;
		countForNotHighQualityUp_ = other.countForNotHighQualityUp_;
		latestDrawItemTypeList_ = other.latestDrawItemTypeList_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaResidentPool Clone()
	{
		return new GachaResidentPool(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaResidentPool);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaResidentPool other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TotalCount != other.TotalCount)
		{
			return false;
		}
		if (CountForTenConsecutiveDiscount != other.CountForTenConsecutiveDiscount)
		{
			return false;
		}
		if (CountForNotHighestQuality != other.CountForNotHighestQuality)
		{
			return false;
		}
		if (CountForNotHighQuality != other.CountForNotHighQuality)
		{
			return false;
		}
		if (CountForNotExchangeFinalGuaranteed != other.CountForNotExchangeFinalGuaranteed)
		{
			return false;
		}
		if (GotNewbieGuaranteed != other.GotNewbieGuaranteed)
		{
			return false;
		}
		if (ExchangedFinalGuaranteed != other.ExchangedFinalGuaranteed)
		{
			return false;
		}
		if (CountForNotHighQualityUp != other.CountForNotHighQualityUp)
		{
			return false;
		}
		if (!latestDrawItemTypeList_.Equals(other.latestDrawItemTypeList_))
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (TotalCount != 0)
		{
			num ^= TotalCount.GetHashCode();
		}
		if (CountForTenConsecutiveDiscount != 0)
		{
			num ^= CountForTenConsecutiveDiscount.GetHashCode();
		}
		if (CountForNotHighestQuality != 0)
		{
			num ^= CountForNotHighestQuality.GetHashCode();
		}
		if (CountForNotHighQuality != 0)
		{
			num ^= CountForNotHighQuality.GetHashCode();
		}
		if (CountForNotExchangeFinalGuaranteed != 0)
		{
			num ^= CountForNotExchangeFinalGuaranteed.GetHashCode();
		}
		if (GotNewbieGuaranteed)
		{
			num ^= GotNewbieGuaranteed.GetHashCode();
		}
		if (ExchangedFinalGuaranteed)
		{
			num ^= ExchangedFinalGuaranteed.GetHashCode();
		}
		if (CountForNotHighQualityUp != 0)
		{
			num ^= CountForNotHighQualityUp.GetHashCode();
		}
		num ^= latestDrawItemTypeList_.GetHashCode();
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (TotalCount != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TotalCount);
		}
		if (CountForTenConsecutiveDiscount != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CountForTenConsecutiveDiscount);
		}
		if (CountForNotHighestQuality != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CountForNotHighestQuality);
		}
		if (CountForNotHighQuality != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CountForNotHighQuality);
		}
		if (CountForNotExchangeFinalGuaranteed != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CountForNotExchangeFinalGuaranteed);
		}
		if (GotNewbieGuaranteed)
		{
			output.WriteRawTag(48);
			output.WriteBool(GotNewbieGuaranteed);
		}
		if (ExchangedFinalGuaranteed)
		{
			output.WriteRawTag(56);
			output.WriteBool(ExchangedFinalGuaranteed);
		}
		if (CountForNotHighQualityUp != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(CountForNotHighQualityUp);
		}
		latestDrawItemTypeList_.WriteTo(ref output, _repeated_latestDrawItemTypeList_codec);
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (TotalCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalCount);
		}
		if (CountForTenConsecutiveDiscount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForTenConsecutiveDiscount);
		}
		if (CountForNotHighestQuality != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotHighestQuality);
		}
		if (CountForNotHighQuality != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotHighQuality);
		}
		if (CountForNotExchangeFinalGuaranteed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotExchangeFinalGuaranteed);
		}
		if (GotNewbieGuaranteed)
		{
			num += 2;
		}
		if (ExchangedFinalGuaranteed)
		{
			num += 2;
		}
		if (CountForNotHighQualityUp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotHighQualityUp);
		}
		num += latestDrawItemTypeList_.CalculateSize(_repeated_latestDrawItemTypeList_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaResidentPool other)
	{
		if (other != null)
		{
			if (other.TotalCount != 0)
			{
				TotalCount = other.TotalCount;
			}
			if (other.CountForTenConsecutiveDiscount != 0)
			{
				CountForTenConsecutiveDiscount = other.CountForTenConsecutiveDiscount;
			}
			if (other.CountForNotHighestQuality != 0)
			{
				CountForNotHighestQuality = other.CountForNotHighestQuality;
			}
			if (other.CountForNotHighQuality != 0)
			{
				CountForNotHighQuality = other.CountForNotHighQuality;
			}
			if (other.CountForNotExchangeFinalGuaranteed != 0)
			{
				CountForNotExchangeFinalGuaranteed = other.CountForNotExchangeFinalGuaranteed;
			}
			if (other.GotNewbieGuaranteed)
			{
				GotNewbieGuaranteed = other.GotNewbieGuaranteed;
			}
			if (other.ExchangedFinalGuaranteed)
			{
				ExchangedFinalGuaranteed = other.ExchangedFinalGuaranteed;
			}
			if (other.CountForNotHighQualityUp != 0)
			{
				CountForNotHighQualityUp = other.CountForNotHighQualityUp;
			}
			latestDrawItemTypeList_.Add(other.latestDrawItemTypeList_);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				TotalCount = input.ReadInt32();
				break;
			case 16u:
				CountForTenConsecutiveDiscount = input.ReadInt32();
				break;
			case 24u:
				CountForNotHighestQuality = input.ReadInt32();
				break;
			case 32u:
				CountForNotHighQuality = input.ReadInt32();
				break;
			case 40u:
				CountForNotExchangeFinalGuaranteed = input.ReadInt32();
				break;
			case 48u:
				GotNewbieGuaranteed = input.ReadBool();
				break;
			case 56u:
				ExchangedFinalGuaranteed = input.ReadBool();
				break;
			case 64u:
				CountForNotHighQualityUp = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				latestDrawItemTypeList_.AddEntriesFrom(ref input, _repeated_latestDrawItemTypeList_codec);
				break;
			}
		}
	}
}
