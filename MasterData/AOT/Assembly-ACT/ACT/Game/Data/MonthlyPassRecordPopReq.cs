using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MonthlyPassRecordPopReq : IMessage<MonthlyPassRecordPopReq>, IMessage, IEquatable<MonthlyPassRecordPopReq>, IDeepCloneable<MonthlyPassRecordPopReq>, IBufferMessage
{
	private static readonly MessageParser<MonthlyPassRecordPopReq> _parser = new MessageParser<MonthlyPassRecordPopReq>(() => new MonthlyPassRecordPopReq());

	private UnknownFieldSet _unknownFields;

	public const int PassIdFieldNumber = 1;

	private int passId_;

	public const int LastPopTimeUnixFieldNumber = 2;

	private long lastPopTimeUnix_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MonthlyPassRecordPopReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[26];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PassId
	{
		get
		{
			return passId_;
		}
		set
		{
			passId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long LastPopTimeUnix
	{
		get
		{
			return lastPopTimeUnix_;
		}
		set
		{
			lastPopTimeUnix_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassRecordPopReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassRecordPopReq(MonthlyPassRecordPopReq other)
		: this()
	{
		passId_ = other.passId_;
		lastPopTimeUnix_ = other.lastPopTimeUnix_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MonthlyPassRecordPopReq Clone()
	{
		return new MonthlyPassRecordPopReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MonthlyPassRecordPopReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MonthlyPassRecordPopReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PassId != other.PassId)
		{
			return false;
		}
		if (LastPopTimeUnix != other.LastPopTimeUnix)
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
		if (PassId != 0)
		{
			num ^= PassId.GetHashCode();
		}
		if (LastPopTimeUnix != 0L)
		{
			num ^= LastPopTimeUnix.GetHashCode();
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
		if (PassId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PassId);
		}
		if (LastPopTimeUnix != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(LastPopTimeUnix);
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
		if (PassId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PassId);
		}
		if (LastPopTimeUnix != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(LastPopTimeUnix);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MonthlyPassRecordPopReq other)
	{
		if (other != null)
		{
			if (other.PassId != 0)
			{
				PassId = other.PassId;
			}
			if (other.LastPopTimeUnix != 0L)
			{
				LastPopTimeUnix = other.LastPopTimeUnix;
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
				PassId = input.ReadInt32();
				break;
			case 16u:
				LastPopTimeUnix = input.ReadInt64();
				break;
			}
		}
	}
}
