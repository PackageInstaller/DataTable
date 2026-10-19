using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class AchievementRecordConversationReq : IMessage<AchievementRecordConversationReq>, IMessage, IEquatable<AchievementRecordConversationReq>, IDeepCloneable<AchievementRecordConversationReq>, IBufferMessage
{
	private static readonly MessageParser<AchievementRecordConversationReq> _parser = new MessageParser<AchievementRecordConversationReq>(() => new AchievementRecordConversationReq());

	private UnknownFieldSet _unknownFields;

	public const int KeysFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_keys_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> keys_ = new RepeatedField<int>();

	public const int OpFieldNumber = 2;

	private RecordConversationOP op_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AchievementRecordConversationReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[51];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Keys => keys_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RecordConversationOP Op
	{
		get
		{
			return op_;
		}
		set
		{
			op_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementRecordConversationReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementRecordConversationReq(AchievementRecordConversationReq other)
		: this()
	{
		keys_ = other.keys_.Clone();
		op_ = other.op_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AchievementRecordConversationReq Clone()
	{
		return new AchievementRecordConversationReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AchievementRecordConversationReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AchievementRecordConversationReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!keys_.Equals(other.keys_))
		{
			return false;
		}
		if (Op != other.Op)
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
		num ^= keys_.GetHashCode();
		if (Op != RecordConversationOP.RecordConversationAdd)
		{
			num ^= Op.GetHashCode();
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
		keys_.WriteTo(ref output, _repeated_keys_codec);
		if (Op != RecordConversationOP.RecordConversationAdd)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)Op);
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
		num += keys_.CalculateSize(_repeated_keys_codec);
		if (Op != RecordConversationOP.RecordConversationAdd)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Op);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AchievementRecordConversationReq other)
	{
		if (other != null)
		{
			keys_.Add(other.keys_);
			if (other.Op != RecordConversationOP.RecordConversationAdd)
			{
				Op = other.Op;
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
				keys_.AddEntriesFrom(ref input, _repeated_keys_codec);
				break;
			case 16u:
				Op = (RecordConversationOP)input.ReadEnum();
				break;
			}
		}
	}
}
