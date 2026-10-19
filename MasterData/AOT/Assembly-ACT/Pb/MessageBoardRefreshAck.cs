using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MessageBoardRefreshAck : IMessage<MessageBoardRefreshAck>, IMessage, IEquatable<MessageBoardRefreshAck>, IDeepCloneable<MessageBoardRefreshAck>, IBufferMessage
{
	private static readonly MessageParser<MessageBoardRefreshAck> _parser = new MessageParser<MessageBoardRefreshAck>(() => new MessageBoardRefreshAck());

	private UnknownFieldSet _unknownFields;

	public const int OwnedMessagesFieldNumber = 1;

	private static readonly MapField<long, SceneMessageInfo>.Codec _map_ownedMessages_codec = new MapField<long, SceneMessageInfo>.Codec(FieldCodec.ForInt64(8u, 0L), FieldCodec.ForMessage(18u, SceneMessageInfo.Parser), 10u);

	private readonly MapField<long, SceneMessageInfo> ownedMessages_ = new MapField<long, SceneMessageInfo>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MessageBoardRefreshAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MessageboardReflection.Descriptor.MessageTypes[11];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<long, SceneMessageInfo> OwnedMessages => ownedMessages_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardRefreshAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardRefreshAck(MessageBoardRefreshAck other)
		: this()
	{
		ownedMessages_ = other.ownedMessages_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageBoardRefreshAck Clone()
	{
		return new MessageBoardRefreshAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MessageBoardRefreshAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MessageBoardRefreshAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!OwnedMessages.Equals(other.OwnedMessages))
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
		num ^= OwnedMessages.GetHashCode();
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
		ownedMessages_.WriteTo(ref output, _map_ownedMessages_codec);
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
		num += ownedMessages_.CalculateSize(_map_ownedMessages_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MessageBoardRefreshAck other)
	{
		if (other != null)
		{
			ownedMessages_.Add(other.ownedMessages_);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				ownedMessages_.AddEntriesFrom(ref input, _map_ownedMessages_codec);
			}
		}
	}
}
