using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RoomJoinConfirmReq : IMessage<RoomJoinConfirmReq>, IMessage, IEquatable<RoomJoinConfirmReq>, IDeepCloneable<RoomJoinConfirmReq>, IBufferMessage
{
	private static readonly MessageParser<RoomJoinConfirmReq> _parser = new MessageParser<RoomJoinConfirmReq>(() => new RoomJoinConfirmReq());

	private UnknownFieldSet _unknownFields;

	public const int JoinerPIDFieldNumber = 1;

	private long joinerPID_;

	public const int OkFieldNumber = 2;

	private bool ok_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RoomJoinConfirmReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RoomReflection.Descriptor.MessageTypes[10];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long JoinerPID
	{
		get
		{
			return joinerPID_;
		}
		set
		{
			joinerPID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Ok
	{
		get
		{
			return ok_;
		}
		set
		{
			ok_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RoomJoinConfirmReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RoomJoinConfirmReq(RoomJoinConfirmReq other)
		: this()
	{
		joinerPID_ = other.joinerPID_;
		ok_ = other.ok_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RoomJoinConfirmReq Clone()
	{
		return new RoomJoinConfirmReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RoomJoinConfirmReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RoomJoinConfirmReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (JoinerPID != other.JoinerPID)
		{
			return false;
		}
		if (Ok != other.Ok)
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
		if (JoinerPID != 0L)
		{
			num ^= JoinerPID.GetHashCode();
		}
		if (Ok)
		{
			num ^= Ok.GetHashCode();
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
		if (JoinerPID != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(JoinerPID);
		}
		if (Ok)
		{
			output.WriteRawTag(16);
			output.WriteBool(Ok);
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
		if (JoinerPID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(JoinerPID);
		}
		if (Ok)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RoomJoinConfirmReq other)
	{
		if (other != null)
		{
			if (other.JoinerPID != 0L)
			{
				JoinerPID = other.JoinerPID;
			}
			if (other.Ok)
			{
				Ok = other.Ok;
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
				JoinerPID = input.ReadInt64();
				break;
			case 16u:
				Ok = input.ReadBool();
				break;
			}
		}
	}
}
