using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RoomForwardingMessageNtf : IMessage<RoomForwardingMessageNtf>, IMessage, IEquatable<RoomForwardingMessageNtf>, IDeepCloneable<RoomForwardingMessageNtf>, IBufferMessage
{
	private static readonly MessageParser<RoomForwardingMessageNtf> _parser = new MessageParser<RoomForwardingMessageNtf>(() => new RoomForwardingMessageNtf());

	private UnknownFieldSet _unknownFields;

	public const int PidFieldNumber = 1;

	private long pid_;

	public const int DataFieldNumber = 2;

	private ByteString data_ = ByteString.Empty;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RoomForwardingMessageNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RoomReflection.Descriptor.MessageTypes[20];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Pid
	{
		get
		{
			return pid_;
		}
		set
		{
			pid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ByteString Data
	{
		get
		{
			return data_;
		}
		set
		{
			data_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RoomForwardingMessageNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RoomForwardingMessageNtf(RoomForwardingMessageNtf other)
		: this()
	{
		pid_ = other.pid_;
		data_ = other.data_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RoomForwardingMessageNtf Clone()
	{
		return new RoomForwardingMessageNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RoomForwardingMessageNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RoomForwardingMessageNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Pid != other.Pid)
		{
			return false;
		}
		if (Data != other.Data)
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
		if (Pid != 0L)
		{
			num ^= Pid.GetHashCode();
		}
		if (Data.Length != 0)
		{
			num ^= Data.GetHashCode();
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
		if (Pid != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Pid);
		}
		if (Data.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteBytes(Data);
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
		if (Pid != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Pid);
		}
		if (Data.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeBytesSize(Data);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RoomForwardingMessageNtf other)
	{
		if (other != null)
		{
			if (other.Pid != 0L)
			{
				Pid = other.Pid;
			}
			if (other.Data.Length != 0)
			{
				Data = other.Data;
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
				Pid = input.ReadInt64();
				break;
			case 18u:
				Data = input.ReadBytes();
				break;
			}
		}
	}
}
