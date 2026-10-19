using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GmChatNtf : IMessage<GmChatNtf>, IMessage, IEquatable<GmChatNtf>, IDeepCloneable<GmChatNtf>, IBufferMessage
{
	private static readonly MessageParser<GmChatNtf> _parser = new MessageParser<GmChatNtf>(() => new GmChatNtf());

	private UnknownFieldSet _unknownFields;

	public const int ChatFieldNumber = 1;

	private GmChat chat_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GmChatNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => GmReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GmChat Chat
	{
		get
		{
			return chat_;
		}
		set
		{
			chat_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GmChatNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GmChatNtf(GmChatNtf other)
		: this()
	{
		chat_ = ((other.chat_ != null) ? other.chat_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GmChatNtf Clone()
	{
		return new GmChatNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GmChatNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GmChatNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Chat, other.Chat))
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
		if (chat_ != null)
		{
			num ^= Chat.GetHashCode();
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
		if (chat_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Chat);
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
		if (chat_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Chat);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GmChatNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.chat_ != null)
		{
			if (chat_ == null)
			{
				Chat = new GmChat();
			}
			Chat.MergeFrom(other.Chat);
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
			if (chat_ == null)
			{
				Chat = new GmChat();
			}
			input.ReadMessage(Chat);
		}
	}
}
