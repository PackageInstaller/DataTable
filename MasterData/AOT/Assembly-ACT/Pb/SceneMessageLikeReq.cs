using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SceneMessageLikeReq : IMessage<SceneMessageLikeReq>, IMessage, IEquatable<SceneMessageLikeReq>, IDeepCloneable<SceneMessageLikeReq>, IBufferMessage
{
	private static readonly MessageParser<SceneMessageLikeReq> _parser = new MessageParser<SceneMessageLikeReq>(() => new SceneMessageLikeReq());

	private UnknownFieldSet _unknownFields;

	public const int MessageIdFieldNumber = 1;

	private long messageId_;

	public const int EmojiIdFieldNumber = 2;

	private int emojiId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneMessageLikeReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MessageboardReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long MessageId
	{
		get
		{
			return messageId_;
		}
		set
		{
			messageId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EmojiId
	{
		get
		{
			return emojiId_;
		}
		set
		{
			emojiId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageLikeReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageLikeReq(SceneMessageLikeReq other)
		: this()
	{
		messageId_ = other.messageId_;
		emojiId_ = other.emojiId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageLikeReq Clone()
	{
		return new SceneMessageLikeReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneMessageLikeReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneMessageLikeReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MessageId != other.MessageId)
		{
			return false;
		}
		if (EmojiId != other.EmojiId)
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
		if (MessageId != 0L)
		{
			num ^= MessageId.GetHashCode();
		}
		if (EmojiId != 0)
		{
			num ^= EmojiId.GetHashCode();
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
		if (MessageId != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(MessageId);
		}
		if (EmojiId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(EmojiId);
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
		if (MessageId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(MessageId);
		}
		if (EmojiId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EmojiId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneMessageLikeReq other)
	{
		if (other != null)
		{
			if (other.MessageId != 0L)
			{
				MessageId = other.MessageId;
			}
			if (other.EmojiId != 0)
			{
				EmojiId = other.EmojiId;
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
				MessageId = input.ReadInt64();
				break;
			case 16u:
				EmojiId = input.ReadInt32();
				break;
			}
		}
	}
}
