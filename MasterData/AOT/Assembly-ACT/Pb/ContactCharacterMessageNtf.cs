using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class ContactCharacterMessageNtf : IMessage<ContactCharacterMessageNtf>, IMessage, IEquatable<ContactCharacterMessageNtf>, IDeepCloneable<ContactCharacterMessageNtf>, IBufferMessage
{
	private static readonly MessageParser<ContactCharacterMessageNtf> _parser = new MessageParser<ContactCharacterMessageNtf>(() => new ContactCharacterMessageNtf());

	private UnknownFieldSet _unknownFields;

	public const int SessionIdFieldNumber = 1;

	private int sessionId_;

	public const int NewMessagesFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_newMessages_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> newMessages_ = new RepeatedField<int>();

	public const int SessionFinishFieldNumber = 3;

	private bool sessionFinish_;

	public const int UpdateTimeStampFieldNumber = 4;

	private int updateTimeStamp_;

	public const int NewMessagesInt64FieldNumber = 5;

	private static readonly FieldCodec<long> _repeated_newMessagesInt64_codec = FieldCodec.ForInt64(42u);

	private readonly RepeatedField<long> newMessagesInt64_ = new RepeatedField<long>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ContactCharacterMessageNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ContactReflection.Descriptor.MessageTypes[1];

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
	public RepeatedField<int> NewMessages => newMessages_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool SessionFinish
	{
		get
		{
			return sessionFinish_;
		}
		set
		{
			sessionFinish_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int UpdateTimeStamp
	{
		get
		{
			return updateTimeStamp_;
		}
		set
		{
			updateTimeStamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<long> NewMessagesInt64 => newMessagesInt64_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterMessageNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterMessageNtf(ContactCharacterMessageNtf other)
		: this()
	{
		sessionId_ = other.sessionId_;
		newMessages_ = other.newMessages_.Clone();
		sessionFinish_ = other.sessionFinish_;
		updateTimeStamp_ = other.updateTimeStamp_;
		newMessagesInt64_ = other.newMessagesInt64_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterMessageNtf Clone()
	{
		return new ContactCharacterMessageNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ContactCharacterMessageNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ContactCharacterMessageNtf other)
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
		if (!newMessages_.Equals(other.newMessages_))
		{
			return false;
		}
		if (SessionFinish != other.SessionFinish)
		{
			return false;
		}
		if (UpdateTimeStamp != other.UpdateTimeStamp)
		{
			return false;
		}
		if (!newMessagesInt64_.Equals(other.newMessagesInt64_))
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
		num ^= newMessages_.GetHashCode();
		if (SessionFinish)
		{
			num ^= SessionFinish.GetHashCode();
		}
		if (UpdateTimeStamp != 0)
		{
			num ^= UpdateTimeStamp.GetHashCode();
		}
		num ^= newMessagesInt64_.GetHashCode();
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
		newMessages_.WriteTo(ref output, _repeated_newMessages_codec);
		if (SessionFinish)
		{
			output.WriteRawTag(24);
			output.WriteBool(SessionFinish);
		}
		if (UpdateTimeStamp != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UpdateTimeStamp);
		}
		newMessagesInt64_.WriteTo(ref output, _repeated_newMessagesInt64_codec);
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
		num += newMessages_.CalculateSize(_repeated_newMessages_codec);
		if (SessionFinish)
		{
			num += 2;
		}
		if (UpdateTimeStamp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpdateTimeStamp);
		}
		num += newMessagesInt64_.CalculateSize(_repeated_newMessagesInt64_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ContactCharacterMessageNtf other)
	{
		if (other != null)
		{
			if (other.SessionId != 0)
			{
				SessionId = other.SessionId;
			}
			newMessages_.Add(other.newMessages_);
			if (other.SessionFinish)
			{
				SessionFinish = other.SessionFinish;
			}
			if (other.UpdateTimeStamp != 0)
			{
				UpdateTimeStamp = other.UpdateTimeStamp;
			}
			newMessagesInt64_.Add(other.newMessagesInt64_);
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
			case 18u:
				newMessages_.AddEntriesFrom(ref input, _repeated_newMessages_codec);
				break;
			case 24u:
				SessionFinish = input.ReadBool();
				break;
			case 32u:
				UpdateTimeStamp = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				newMessagesInt64_.AddEntriesFrom(ref input, _repeated_newMessagesInt64_codec);
				break;
			}
		}
	}
}
