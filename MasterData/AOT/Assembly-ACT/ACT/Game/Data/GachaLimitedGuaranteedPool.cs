using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GachaLimitedGuaranteedPool : IMessage<GachaLimitedGuaranteedPool>, IMessage, IEquatable<GachaLimitedGuaranteedPool>, IDeepCloneable<GachaLimitedGuaranteedPool>, IBufferMessage
{
	private static readonly MessageParser<GachaLimitedGuaranteedPool> _parser = new MessageParser<GachaLimitedGuaranteedPool>(() => new GachaLimitedGuaranteedPool());

	private UnknownFieldSet _unknownFields;

	public const int TotalCountFieldNumber = 1;

	private int totalCount_;

	public const int CountForNotExchangeFinalGuaranteedFieldNumber = 2;

	private int countForNotExchangeFinalGuaranteed_;

	public const int CountForNotTargetFieldNumber = 3;

	private int countForNotTarget_;

	public const int CountForNotHighQualityFieldNumber = 4;

	private int countForNotHighQuality_;

	public const int ExchangedFinalGuaranteedFieldNumber = 5;

	private bool exchangedFinalGuaranteed_;

	public const int CountForNotHighQualityUpFieldNumber = 6;

	private int countForNotHighQualityUp_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaLimitedGuaranteedPool> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[151];

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
	public int CountForNotTarget
	{
		get
		{
			return countForNotTarget_;
		}
		set
		{
			countForNotTarget_ = value;
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
	public GachaLimitedGuaranteedPool()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaLimitedGuaranteedPool(GachaLimitedGuaranteedPool other)
		: this()
	{
		totalCount_ = other.totalCount_;
		countForNotExchangeFinalGuaranteed_ = other.countForNotExchangeFinalGuaranteed_;
		countForNotTarget_ = other.countForNotTarget_;
		countForNotHighQuality_ = other.countForNotHighQuality_;
		exchangedFinalGuaranteed_ = other.exchangedFinalGuaranteed_;
		countForNotHighQualityUp_ = other.countForNotHighQualityUp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaLimitedGuaranteedPool Clone()
	{
		return new GachaLimitedGuaranteedPool(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaLimitedGuaranteedPool);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaLimitedGuaranteedPool other)
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
		if (CountForNotExchangeFinalGuaranteed != other.CountForNotExchangeFinalGuaranteed)
		{
			return false;
		}
		if (CountForNotTarget != other.CountForNotTarget)
		{
			return false;
		}
		if (CountForNotHighQuality != other.CountForNotHighQuality)
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
		if (CountForNotExchangeFinalGuaranteed != 0)
		{
			num ^= CountForNotExchangeFinalGuaranteed.GetHashCode();
		}
		if (CountForNotTarget != 0)
		{
			num ^= CountForNotTarget.GetHashCode();
		}
		if (CountForNotHighQuality != 0)
		{
			num ^= CountForNotHighQuality.GetHashCode();
		}
		if (ExchangedFinalGuaranteed)
		{
			num ^= ExchangedFinalGuaranteed.GetHashCode();
		}
		if (CountForNotHighQualityUp != 0)
		{
			num ^= CountForNotHighQualityUp.GetHashCode();
		}
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
		if (CountForNotExchangeFinalGuaranteed != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CountForNotExchangeFinalGuaranteed);
		}
		if (CountForNotTarget != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CountForNotTarget);
		}
		if (CountForNotHighQuality != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CountForNotHighQuality);
		}
		if (ExchangedFinalGuaranteed)
		{
			output.WriteRawTag(40);
			output.WriteBool(ExchangedFinalGuaranteed);
		}
		if (CountForNotHighQualityUp != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(CountForNotHighQualityUp);
		}
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
		if (CountForNotExchangeFinalGuaranteed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotExchangeFinalGuaranteed);
		}
		if (CountForNotTarget != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotTarget);
		}
		if (CountForNotHighQuality != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotHighQuality);
		}
		if (ExchangedFinalGuaranteed)
		{
			num += 2;
		}
		if (CountForNotHighQualityUp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotHighQualityUp);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaLimitedGuaranteedPool other)
	{
		if (other != null)
		{
			if (other.TotalCount != 0)
			{
				TotalCount = other.TotalCount;
			}
			if (other.CountForNotExchangeFinalGuaranteed != 0)
			{
				CountForNotExchangeFinalGuaranteed = other.CountForNotExchangeFinalGuaranteed;
			}
			if (other.CountForNotTarget != 0)
			{
				CountForNotTarget = other.CountForNotTarget;
			}
			if (other.CountForNotHighQuality != 0)
			{
				CountForNotHighQuality = other.CountForNotHighQuality;
			}
			if (other.ExchangedFinalGuaranteed)
			{
				ExchangedFinalGuaranteed = other.ExchangedFinalGuaranteed;
			}
			if (other.CountForNotHighQualityUp != 0)
			{
				CountForNotHighQualityUp = other.CountForNotHighQualityUp;
			}
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
				CountForNotExchangeFinalGuaranteed = input.ReadInt32();
				break;
			case 24u:
				CountForNotTarget = input.ReadInt32();
				break;
			case 32u:
				CountForNotHighQuality = input.ReadInt32();
				break;
			case 40u:
				ExchangedFinalGuaranteed = input.ReadBool();
				break;
			case 48u:
				CountForNotHighQualityUp = input.ReadInt32();
				break;
			}
		}
	}
}
