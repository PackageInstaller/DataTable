using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MailChangeStateReq : IMessage<MailChangeStateReq>, IMessage, IEquatable<MailChangeStateReq>, IDeepCloneable<MailChangeStateReq>, IBufferMessage
{
	private static readonly MessageParser<MailChangeStateReq> _parser = new MessageParser<MailChangeStateReq>(() => new MailChangeStateReq());

	private UnknownFieldSet _unknownFields;

	public const int IdsFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_ids_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> ids_ = new RepeatedField<int>();

	public const int ToStateFieldNumber = 2;

	private MailState toState_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MailChangeStateReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MailReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Ids => ids_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MailState ToState
	{
		get
		{
			return toState_;
		}
		set
		{
			toState_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MailChangeStateReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MailChangeStateReq(MailChangeStateReq other)
		: this()
	{
		ids_ = other.ids_.Clone();
		toState_ = other.toState_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MailChangeStateReq Clone()
	{
		return new MailChangeStateReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MailChangeStateReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MailChangeStateReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!ids_.Equals(other.ids_))
		{
			return false;
		}
		if (ToState != other.ToState)
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
		num ^= ids_.GetHashCode();
		if (ToState != MailState.Unread)
		{
			num ^= ToState.GetHashCode();
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
		ids_.WriteTo(ref output, _repeated_ids_codec);
		if (ToState != MailState.Unread)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)ToState);
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
		num += ids_.CalculateSize(_repeated_ids_codec);
		if (ToState != MailState.Unread)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)ToState);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MailChangeStateReq other)
	{
		if (other != null)
		{
			ids_.Add(other.ids_);
			if (other.ToState != MailState.Unread)
			{
				ToState = other.ToState;
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
			case 10u:
				ids_.AddEntriesFrom(ref input, _repeated_ids_codec);
				break;
			case 16u:
				ToState = (MailState)input.ReadEnum();
				break;
			}
		}
	}
}
