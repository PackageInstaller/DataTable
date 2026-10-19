using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GachaLimitedUpPool : IMessage<GachaLimitedUpPool>, IMessage, IEquatable<GachaLimitedUpPool>, IDeepCloneable<GachaLimitedUpPool>, IBufferMessage
{
	private static readonly MessageParser<GachaLimitedUpPool> _parser = new MessageParser<GachaLimitedUpPool>(() => new GachaLimitedUpPool());

	private UnknownFieldSet _unknownFields;

	public const int TotalCountFieldNumber = 1;

	private int totalCount_;

	public const int CountForNotHighestQualityFieldNumber = 2;

	private int countForNotHighestQuality_;

	public const int CountForNotUpTargetFieldNumber = 3;

	private int countForNotUpTarget_;

	public const int CountForNotHighQualityFieldNumber = 4;

	private int countForNotHighQuality_;

	public const int CountForNotExchangeFinalGuaranteedFieldNumber = 5;

	private int countForNotExchangeFinalGuaranteed_;

	public const int ExchangedFinalGuaranteedFieldNumber = 6;

	private bool exchangedFinalGuaranteed_;

	public const int DrawCountForNotUpTargetFieldNumber = 7;

	private int drawCountForNotUpTarget_;

	public const int CountForNotHighQualityUpFieldNumber = 8;

	private int countForNotHighQualityUp_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaLimitedUpPool> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[152];

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
	public int CountForNotUpTarget
	{
		get
		{
			return countForNotUpTarget_;
		}
		set
		{
			countForNotUpTarget_ = value;
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
	public int DrawCountForNotUpTarget
	{
		get
		{
			return drawCountForNotUpTarget_;
		}
		set
		{
			drawCountForNotUpTarget_ = value;
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
	public GachaLimitedUpPool()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaLimitedUpPool(GachaLimitedUpPool other)
		: this()
	{
		totalCount_ = other.totalCount_;
		countForNotHighestQuality_ = other.countForNotHighestQuality_;
		countForNotUpTarget_ = other.countForNotUpTarget_;
		countForNotHighQuality_ = other.countForNotHighQuality_;
		countForNotExchangeFinalGuaranteed_ = other.countForNotExchangeFinalGuaranteed_;
		exchangedFinalGuaranteed_ = other.exchangedFinalGuaranteed_;
		drawCountForNotUpTarget_ = other.drawCountForNotUpTarget_;
		countForNotHighQualityUp_ = other.countForNotHighQualityUp_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaLimitedUpPool Clone()
	{
		return new GachaLimitedUpPool(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaLimitedUpPool);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaLimitedUpPool other)
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
		if (CountForNotHighestQuality != other.CountForNotHighestQuality)
		{
			return false;
		}
		if (CountForNotUpTarget != other.CountForNotUpTarget)
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
		if (ExchangedFinalGuaranteed != other.ExchangedFinalGuaranteed)
		{
			return false;
		}
		if (DrawCountForNotUpTarget != other.DrawCountForNotUpTarget)
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
		if (CountForNotHighestQuality != 0)
		{
			num ^= CountForNotHighestQuality.GetHashCode();
		}
		if (CountForNotUpTarget != 0)
		{
			num ^= CountForNotUpTarget.GetHashCode();
		}
		if (CountForNotHighQuality != 0)
		{
			num ^= CountForNotHighQuality.GetHashCode();
		}
		if (CountForNotExchangeFinalGuaranteed != 0)
		{
			num ^= CountForNotExchangeFinalGuaranteed.GetHashCode();
		}
		if (ExchangedFinalGuaranteed)
		{
			num ^= ExchangedFinalGuaranteed.GetHashCode();
		}
		if (DrawCountForNotUpTarget != 0)
		{
			num ^= DrawCountForNotUpTarget.GetHashCode();
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
		if (CountForNotHighestQuality != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CountForNotHighestQuality);
		}
		if (CountForNotUpTarget != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CountForNotUpTarget);
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
		if (ExchangedFinalGuaranteed)
		{
			output.WriteRawTag(48);
			output.WriteBool(ExchangedFinalGuaranteed);
		}
		if (DrawCountForNotUpTarget != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(DrawCountForNotUpTarget);
		}
		if (CountForNotHighQualityUp != 0)
		{
			output.WriteRawTag(64);
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
		if (CountForNotHighestQuality != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotHighestQuality);
		}
		if (CountForNotUpTarget != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotUpTarget);
		}
		if (CountForNotHighQuality != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotHighQuality);
		}
		if (CountForNotExchangeFinalGuaranteed != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountForNotExchangeFinalGuaranteed);
		}
		if (ExchangedFinalGuaranteed)
		{
			num += 2;
		}
		if (DrawCountForNotUpTarget != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DrawCountForNotUpTarget);
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
	public void MergeFrom(GachaLimitedUpPool other)
	{
		if (other != null)
		{
			if (other.TotalCount != 0)
			{
				TotalCount = other.TotalCount;
			}
			if (other.CountForNotHighestQuality != 0)
			{
				CountForNotHighestQuality = other.CountForNotHighestQuality;
			}
			if (other.CountForNotUpTarget != 0)
			{
				CountForNotUpTarget = other.CountForNotUpTarget;
			}
			if (other.CountForNotHighQuality != 0)
			{
				CountForNotHighQuality = other.CountForNotHighQuality;
			}
			if (other.CountForNotExchangeFinalGuaranteed != 0)
			{
				CountForNotExchangeFinalGuaranteed = other.CountForNotExchangeFinalGuaranteed;
			}
			if (other.ExchangedFinalGuaranteed)
			{
				ExchangedFinalGuaranteed = other.ExchangedFinalGuaranteed;
			}
			if (other.DrawCountForNotUpTarget != 0)
			{
				DrawCountForNotUpTarget = other.DrawCountForNotUpTarget;
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
				CountForNotHighestQuality = input.ReadInt32();
				break;
			case 24u:
				CountForNotUpTarget = input.ReadInt32();
				break;
			case 32u:
				CountForNotHighQuality = input.ReadInt32();
				break;
			case 40u:
				CountForNotExchangeFinalGuaranteed = input.ReadInt32();
				break;
			case 48u:
				ExchangedFinalGuaranteed = input.ReadBool();
				break;
			case 56u:
				DrawCountForNotUpTarget = input.ReadInt32();
				break;
			case 64u:
				CountForNotHighQualityUp = input.ReadInt32();
				break;
			}
		}
	}
}
