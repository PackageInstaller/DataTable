using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RogueElementChangeInfo : IMessage<RogueElementChangeInfo>, IMessage, IEquatable<RogueElementChangeInfo>, IDeepCloneable<RogueElementChangeInfo>, IBufferMessage
{
	private static readonly MessageParser<RogueElementChangeInfo> _parser = new MessageParser<RogueElementChangeInfo>(() => new RogueElementChangeInfo());

	private UnknownFieldSet _unknownFields;

	public const int ElementIdFieldNumber = 1;

	private int elementId_;

	public const int ElementTypeFieldNumber = 2;

	private int elementType_;

	public const int EventTypeFieldNumber = 3;

	private int eventType_;

	public const int ValueFieldNumber = 4;

	private int value_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueElementChangeInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[237];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ElementId
	{
		get
		{
			return elementId_;
		}
		set
		{
			elementId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ElementType
	{
		get
		{
			return elementType_;
		}
		set
		{
			elementType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EventType
	{
		get
		{
			return eventType_;
		}
		set
		{
			eventType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Value
	{
		get
		{
			return value_;
		}
		set
		{
			value_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueElementChangeInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueElementChangeInfo(RogueElementChangeInfo other)
		: this()
	{
		elementId_ = other.elementId_;
		elementType_ = other.elementType_;
		eventType_ = other.eventType_;
		value_ = other.value_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueElementChangeInfo Clone()
	{
		return new RogueElementChangeInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueElementChangeInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueElementChangeInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ElementId != other.ElementId)
		{
			return false;
		}
		if (ElementType != other.ElementType)
		{
			return false;
		}
		if (EventType != other.EventType)
		{
			return false;
		}
		if (Value != other.Value)
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
		if (ElementId != 0)
		{
			num ^= ElementId.GetHashCode();
		}
		if (ElementType != 0)
		{
			num ^= ElementType.GetHashCode();
		}
		if (EventType != 0)
		{
			num ^= EventType.GetHashCode();
		}
		if (Value != 0)
		{
			num ^= Value.GetHashCode();
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
		if (ElementId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ElementId);
		}
		if (ElementType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ElementType);
		}
		if (EventType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EventType);
		}
		if (Value != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Value);
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
		if (ElementId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ElementId);
		}
		if (ElementType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ElementType);
		}
		if (EventType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EventType);
		}
		if (Value != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Value);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueElementChangeInfo other)
	{
		if (other != null)
		{
			if (other.ElementId != 0)
			{
				ElementId = other.ElementId;
			}
			if (other.ElementType != 0)
			{
				ElementType = other.ElementType;
			}
			if (other.EventType != 0)
			{
				EventType = other.EventType;
			}
			if (other.Value != 0)
			{
				Value = other.Value;
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
				ElementId = input.ReadInt32();
				break;
			case 16u:
				ElementType = input.ReadInt32();
				break;
			case 24u:
				EventType = input.ReadInt32();
				break;
			case 32u:
				Value = input.ReadInt32();
				break;
			}
		}
	}
}
