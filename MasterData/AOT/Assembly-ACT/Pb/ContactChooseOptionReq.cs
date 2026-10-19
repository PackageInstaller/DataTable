using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ContactChooseOptionReq : IMessage<ContactChooseOptionReq>, IMessage, IEquatable<ContactChooseOptionReq>, IDeepCloneable<ContactChooseOptionReq>, IBufferMessage
{
	private static readonly MessageParser<ContactChooseOptionReq> _parser = new MessageParser<ContactChooseOptionReq>(() => new ContactChooseOptionReq());

	private UnknownFieldSet _unknownFields;

	public const int SessionIdFieldNumber = 1;

	private int sessionId_;

	public const int ChooseIdxFieldNumber = 2;

	private int chooseIdx_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ContactChooseOptionReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ContactReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SessionId
	{
		get
		{
			return sessionId_;
		}
		set
		{
			sessionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChooseIdx
	{
		get
		{
			return chooseIdx_;
		}
		set
		{
			chooseIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactChooseOptionReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactChooseOptionReq(ContactChooseOptionReq other)
		: this()
	{
		sessionId_ = other.sessionId_;
		chooseIdx_ = other.chooseIdx_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactChooseOptionReq Clone()
	{
		return new ContactChooseOptionReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ContactChooseOptionReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ContactChooseOptionReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SessionId != other.SessionId)
		{
			return false;
		}
		if (ChooseIdx != other.ChooseIdx)
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
		if (SessionId != 0)
		{
			num ^= SessionId.GetHashCode();
		}
		if (ChooseIdx != 0)
		{
			num ^= ChooseIdx.GetHashCode();
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
		if (SessionId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SessionId);
		}
		if (ChooseIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ChooseIdx);
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
		if (SessionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SessionId);
		}
		if (ChooseIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChooseIdx);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ContactChooseOptionReq other)
	{
		if (other != null)
		{
			if (other.SessionId != 0)
			{
				SessionId = other.SessionId;
			}
			if (other.ChooseIdx != 0)
			{
				ChooseIdx = other.ChooseIdx;
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
				SessionId = input.ReadInt32();
				break;
			case 16u:
				ChooseIdx = input.ReadInt32();
				break;
			}
		}
	}
}
