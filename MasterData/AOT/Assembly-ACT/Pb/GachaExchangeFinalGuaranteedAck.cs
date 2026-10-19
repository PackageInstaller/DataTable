using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class GachaExchangeFinalGuaranteedAck : IMessage<GachaExchangeFinalGuaranteedAck>, IMessage, IEquatable<GachaExchangeFinalGuaranteedAck>, IDeepCloneable<GachaExchangeFinalGuaranteedAck>, IBufferMessage
{
	private static readonly MessageParser<GachaExchangeFinalGuaranteedAck> _parser = new MessageParser<GachaExchangeFinalGuaranteedAck>(() => new GachaExchangeFinalGuaranteedAck());

	private UnknownFieldSet _unknownFields;

	public const int GotItemFieldNumber = 1;

	private Item gotItem_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaExchangeFinalGuaranteedAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => PlayerReflection.Descriptor.MessageTypes[26];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Item GotItem
	{
		get
		{
			return gotItem_;
		}
		set
		{
			gotItem_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaExchangeFinalGuaranteedAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaExchangeFinalGuaranteedAck(GachaExchangeFinalGuaranteedAck other)
		: this()
	{
		gotItem_ = ((other.gotItem_ != null) ? other.gotItem_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaExchangeFinalGuaranteedAck Clone()
	{
		return new GachaExchangeFinalGuaranteedAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaExchangeFinalGuaranteedAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaExchangeFinalGuaranteedAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(GotItem, other.GotItem))
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
		if (gotItem_ != null)
		{
			num ^= GotItem.GetHashCode();
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
		if (gotItem_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(GotItem);
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
		if (gotItem_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(GotItem);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaExchangeFinalGuaranteedAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.gotItem_ != null)
		{
			if (gotItem_ == null)
			{
				GotItem = new Item();
			}
			GotItem.MergeFrom(other.GotItem);
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
			if (gotItem_ == null)
			{
				GotItem = new Item();
			}
			input.ReadMessage(GotItem);
		}
	}
}
