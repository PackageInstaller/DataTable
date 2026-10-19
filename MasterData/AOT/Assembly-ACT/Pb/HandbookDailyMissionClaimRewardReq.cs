using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class HandbookDailyMissionClaimRewardReq : IMessage<HandbookDailyMissionClaimRewardReq>, IMessage, IEquatable<HandbookDailyMissionClaimRewardReq>, IDeepCloneable<HandbookDailyMissionClaimRewardReq>, IBufferMessage
{
	private static readonly MessageParser<HandbookDailyMissionClaimRewardReq> _parser = new MessageParser<HandbookDailyMissionClaimRewardReq>(() => new HandbookDailyMissionClaimRewardReq());

	private UnknownFieldSet _unknownFields;

	public const int RowIdFieldNumber = 1;

	private int rowId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<HandbookDailyMissionClaimRewardReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => HandbookReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int RowId
	{
		get
		{
			return rowId_;
		}
		set
		{
			rowId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyMissionClaimRewardReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyMissionClaimRewardReq(HandbookDailyMissionClaimRewardReq other)
		: this()
	{
		rowId_ = other.rowId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public HandbookDailyMissionClaimRewardReq Clone()
	{
		return new HandbookDailyMissionClaimRewardReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as HandbookDailyMissionClaimRewardReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(HandbookDailyMissionClaimRewardReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (RowId != other.RowId)
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
		if (RowId != 0)
		{
			num ^= RowId.GetHashCode();
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
		if (RowId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(RowId);
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
		if (RowId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RowId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(HandbookDailyMissionClaimRewardReq other)
	{
		if (other != null)
		{
			if (other.RowId != 0)
			{
				RowId = other.RowId;
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
				RowId = input.ReadInt32();
			}
		}
	}
}
