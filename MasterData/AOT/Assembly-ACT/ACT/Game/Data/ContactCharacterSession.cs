using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ContactCharacterSession : IMessage<ContactCharacterSession>, IMessage, IEquatable<ContactCharacterSession>, IDeepCloneable<ContactCharacterSession>, IBufferMessage
{
	private static readonly MessageParser<ContactCharacterSession> _parser = new MessageParser<ContactCharacterSession>(() => new ContactCharacterSession());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StateFieldNumber = 2;

	private ContactSessionState state_;

	public const int GenerateTimeStampFieldNumber = 3;

	private int generateTimeStamp_;

	public const int MessagesFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_messages_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> messages_ = new RepeatedField<int>();

	public const int UpdateTimeStampFieldNumber = 5;

	private int updateTimeStamp_;

	public const int MessagesInt64FieldNumber = 6;

	private static readonly FieldCodec<long> _repeated_messagesInt64_codec = FieldCodec.ForInt64(50u);

	private readonly RepeatedField<long> messagesInt64_ = new RepeatedField<long>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ContactCharacterSession> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[245];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactSessionState State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GenerateTimeStamp
	{
		get
		{
			return generateTimeStamp_;
		}
		set
		{
			generateTimeStamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Messages => messages_;

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
	public RepeatedField<long> MessagesInt64 => messagesInt64_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterSession()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterSession(ContactCharacterSession other)
		: this()
	{
		id_ = other.id_;
		state_ = other.state_;
		generateTimeStamp_ = other.generateTimeStamp_;
		messages_ = other.messages_.Clone();
		updateTimeStamp_ = other.updateTimeStamp_;
		messagesInt64_ = other.messagesInt64_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ContactCharacterSession Clone()
	{
		return new ContactCharacterSession(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ContactCharacterSession);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ContactCharacterSession other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (State != other.State)
		{
			return false;
		}
		if (GenerateTimeStamp != other.GenerateTimeStamp)
		{
			return false;
		}
		if (!messages_.Equals(other.messages_))
		{
			return false;
		}
		if (UpdateTimeStamp != other.UpdateTimeStamp)
		{
			return false;
		}
		if (!messagesInt64_.Equals(other.messagesInt64_))
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (State != ContactSessionState.Lock)
		{
			num ^= State.GetHashCode();
		}
		if (GenerateTimeStamp != 0)
		{
			num ^= GenerateTimeStamp.GetHashCode();
		}
		num ^= messages_.GetHashCode();
		if (UpdateTimeStamp != 0)
		{
			num ^= UpdateTimeStamp.GetHashCode();
		}
		num ^= messagesInt64_.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (State != ContactSessionState.Lock)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)State);
		}
		if (GenerateTimeStamp != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GenerateTimeStamp);
		}
		messages_.WriteTo(ref output, _repeated_messages_codec);
		if (UpdateTimeStamp != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(UpdateTimeStamp);
		}
		messagesInt64_.WriteTo(ref output, _repeated_messagesInt64_codec);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (State != ContactSessionState.Lock)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		if (GenerateTimeStamp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GenerateTimeStamp);
		}
		num += messages_.CalculateSize(_repeated_messages_codec);
		if (UpdateTimeStamp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpdateTimeStamp);
		}
		num += messagesInt64_.CalculateSize(_repeated_messagesInt64_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ContactCharacterSession other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.State != ContactSessionState.Lock)
			{
				State = other.State;
			}
			if (other.GenerateTimeStamp != 0)
			{
				GenerateTimeStamp = other.GenerateTimeStamp;
			}
			messages_.Add(other.messages_);
			if (other.UpdateTimeStamp != 0)
			{
				UpdateTimeStamp = other.UpdateTimeStamp;
			}
			messagesInt64_.Add(other.messagesInt64_);
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
				Id = input.ReadInt32();
				break;
			case 16u:
				State = (ContactSessionState)input.ReadEnum();
				break;
			case 24u:
				GenerateTimeStamp = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				messages_.AddEntriesFrom(ref input, _repeated_messages_codec);
				break;
			case 40u:
				UpdateTimeStamp = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				messagesInt64_.AddEntriesFrom(ref input, _repeated_messagesInt64_codec);
				break;
			}
		}
	}
}
