using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MessageBoardNtf : IMessage<MessageBoardNtf>, IMessage, IEquatable<MessageBoardNtf>, IDeepCloneable<MessageBoardNtf>, IBufferMessage
{
	private static readonly MessageParser<MessageBoardNtf> _parser = new MessageParser<MessageBoardNtf>(() => new MessageBoardNtf());

	private UnknownFieldSet _unknownFields;

	public const int MessageBoardInfoFieldNumber = 1;

	private MessageBoardInfo messageBoardInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MessageBoardNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MessageboardReflection.Descriptor.MessageTypes[0];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardInfo MessageBoardInfo
	{
		get
		{
			return messageBoardInfo_;
		}
		set
		{
			messageBoardInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardNtf(MessageBoardNtf other)
		: this()
	{
		messageBoardInfo_ = ((other.messageBoardInfo_ != null) ? other.messageBoardInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardNtf Clone()
	{
		return new MessageBoardNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MessageBoardNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MessageBoardNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(MessageBoardInfo, other.MessageBoardInfo))
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
		if (messageBoardInfo_ != null)
		{
			num ^= MessageBoardInfo.GetHashCode();
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
		if (messageBoardInfo_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(MessageBoardInfo);
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
		if (messageBoardInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MessageBoardInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MessageBoardNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.messageBoardInfo_ != null)
		{
			if (messageBoardInfo_ == null)
			{
				MessageBoardInfo = new MessageBoardInfo();
			}
			MessageBoardInfo.MergeFrom(other.MessageBoardInfo);
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (messageBoardInfo_ == null)
			{
				MessageBoardInfo = new MessageBoardInfo();
			}
			input.ReadMessage(MessageBoardInfo);
		}
	}
}
