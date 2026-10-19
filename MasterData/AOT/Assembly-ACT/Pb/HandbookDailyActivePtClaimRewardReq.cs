using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class HandbookDailyActivePtClaimRewardReq : IMessage<HandbookDailyActivePtClaimRewardReq>, IMessage, IEquatable<HandbookDailyActivePtClaimRewardReq>, IDeepCloneable<HandbookDailyActivePtClaimRewardReq>, IBufferMessage
{
	private static readonly MessageParser<HandbookDailyActivePtClaimRewardReq> _parser = new MessageParser<HandbookDailyActivePtClaimRewardReq>(() => new HandbookDailyActivePtClaimRewardReq());

	private UnknownFieldSet _unknownFields;

	public const int PtRewardIdFieldNumber = 1;

	private int ptRewardId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<HandbookDailyActivePtClaimRewardReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => HandbookReflection.Descriptor.MessageTypes[6];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PtRewardId
	{
		get
		{
			return ptRewardId_;
		}
		set
		{
			ptRewardId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyActivePtClaimRewardReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyActivePtClaimRewardReq(HandbookDailyActivePtClaimRewardReq other)
		: this()
	{
		ptRewardId_ = other.ptRewardId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyActivePtClaimRewardReq Clone()
	{
		return new HandbookDailyActivePtClaimRewardReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as HandbookDailyActivePtClaimRewardReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(HandbookDailyActivePtClaimRewardReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PtRewardId != other.PtRewardId)
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
		if (PtRewardId != 0)
		{
			num ^= PtRewardId.GetHashCode();
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
		if (PtRewardId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PtRewardId);
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
		if (PtRewardId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PtRewardId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(HandbookDailyActivePtClaimRewardReq other)
	{
		if (other != null)
		{
			if (other.PtRewardId != 0)
			{
				PtRewardId = other.PtRewardId;
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
			if (num != 8)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				PtRewardId = input.ReadInt32();
			}
		}
	}
}
