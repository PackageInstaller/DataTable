using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class SceneMessageCreateAck : IMessage<SceneMessageCreateAck>, IMessage, IEquatable<SceneMessageCreateAck>, IDeepCloneable<SceneMessageCreateAck>, IBufferMessage
{
	private static readonly MessageParser<SceneMessageCreateAck> _parser = new MessageParser<SceneMessageCreateAck>(() => new SceneMessageCreateAck());

	private UnknownFieldSet _unknownFields;

	public const int NewMessageFieldNumber = 1;

	private SceneMessageInfo newMessage_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<SceneMessageCreateAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MessageboardReflection.Descriptor.MessageTypes[5];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageInfo NewMessage
	{
		get
		{
			return newMessage_;
		}
		set
		{
			newMessage_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageCreateAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageCreateAck(SceneMessageCreateAck other)
		: this()
	{
		newMessage_ = ((other.newMessage_ != null) ? other.newMessage_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public SceneMessageCreateAck Clone()
	{
		return new SceneMessageCreateAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as SceneMessageCreateAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(SceneMessageCreateAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(NewMessage, other.NewMessage))
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
		if (newMessage_ != null)
		{
			num ^= NewMessage.GetHashCode();
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
		if (newMessage_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(NewMessage);
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
		if (newMessage_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(NewMessage);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(SceneMessageCreateAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.newMessage_ != null)
		{
			if (newMessage_ == null)
			{
				NewMessage = new SceneMessageInfo();
			}
			NewMessage.MergeFrom(other.NewMessage);
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
			if (newMessage_ == null)
			{
				NewMessage = new SceneMessageInfo();
			}
			input.ReadMessage(NewMessage);
		}
	}
}
