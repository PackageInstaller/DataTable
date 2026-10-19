using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ErrorParam : IMessage<ErrorParam>, IMessage, IEquatable<ErrorParam>, IDeepCloneable<ErrorParam>, IBufferMessage
{
	private static readonly MessageParser<ErrorParam> _parser = new MessageParser<ErrorParam>(() => new ErrorParam());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private long uid_;

	public const int BanEndTimestampFieldNumber = 2;

	private long banEndTimestamp_;

	public const int FairTagFieldNumber = 3;

	private int fairTag_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ErrorParam> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long BanEndTimestamp
	{
		get
		{
			return banEndTimestamp_;
		}
		set
		{
			banEndTimestamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int FairTag
	{
		get
		{
			return fairTag_;
		}
		set
		{
			fairTag_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorParam()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorParam(ErrorParam other)
		: this()
	{
		uid_ = other.uid_;
		banEndTimestamp_ = other.banEndTimestamp_;
		fairTag_ = other.fairTag_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ErrorParam Clone()
	{
		return new ErrorParam(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ErrorParam);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ErrorParam other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (BanEndTimestamp != other.BanEndTimestamp)
		{
			return false;
		}
		if (FairTag != other.FairTag)
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
		if (Uid != 0L)
		{
			num ^= Uid.GetHashCode();
		}
		if (BanEndTimestamp != 0L)
		{
			num ^= BanEndTimestamp.GetHashCode();
		}
		if (FairTag != 0)
		{
			num ^= FairTag.GetHashCode();
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
		if (Uid != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Uid);
		}
		if (BanEndTimestamp != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(BanEndTimestamp);
		}
		if (FairTag != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(FairTag);
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
		if (Uid != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Uid);
		}
		if (BanEndTimestamp != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BanEndTimestamp);
		}
		if (FairTag != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FairTag);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ErrorParam other)
	{
		if (other != null)
		{
			if (other.Uid != 0L)
			{
				Uid = other.Uid;
			}
			if (other.BanEndTimestamp != 0L)
			{
				BanEndTimestamp = other.BanEndTimestamp;
			}
			if (other.FairTag != 0)
			{
				FairTag = other.FairTag;
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
				Uid = input.ReadInt64();
				break;
			case 16u:
				BanEndTimestamp = input.ReadInt64();
				break;
			case 24u:
				FairTag = input.ReadInt32();
				break;
			}
		}
	}
}
