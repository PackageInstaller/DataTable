using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GemSlot : IMessage<GemSlot>, IMessage, IEquatable<GemSlot>, IDeepCloneable<GemSlot>, IBufferMessage
{
	private static readonly MessageParser<GemSlot> _parser = new MessageParser<GemSlot>(() => new GemSlot());

	private UnknownFieldSet _unknownFields;

	public const int SlotIdFieldNumber = 1;

	private int slotId_;

	public const int SlotLevelFieldNumber = 2;

	private int slotLevel_;

	public const int GemIdFieldNumber = 3;

	private int gemId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GemSlot> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[53];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SlotId
	{
		get
		{
			return slotId_;
		}
		set
		{
			slotId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SlotLevel
	{
		get
		{
			return slotLevel_;
		}
		set
		{
			slotLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GemId
	{
		get
		{
			return gemId_;
		}
		set
		{
			gemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GemSlot()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GemSlot(GemSlot other)
		: this()
	{
		slotId_ = other.slotId_;
		slotLevel_ = other.slotLevel_;
		gemId_ = other.gemId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GemSlot Clone()
	{
		return new GemSlot(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GemSlot);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GemSlot other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SlotId != other.SlotId)
		{
			return false;
		}
		if (SlotLevel != other.SlotLevel)
		{
			return false;
		}
		if (GemId != other.GemId)
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
		if (SlotId != 0)
		{
			num ^= SlotId.GetHashCode();
		}
		if (SlotLevel != 0)
		{
			num ^= SlotLevel.GetHashCode();
		}
		if (GemId != 0)
		{
			num ^= GemId.GetHashCode();
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
		if (SlotId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SlotId);
		}
		if (SlotLevel != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SlotLevel);
		}
		if (GemId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GemId);
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
		if (SlotId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SlotId);
		}
		if (SlotLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SlotLevel);
		}
		if (GemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GemId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GemSlot other)
	{
		if (other != null)
		{
			if (other.SlotId != 0)
			{
				SlotId = other.SlotId;
			}
			if (other.SlotLevel != 0)
			{
				SlotLevel = other.SlotLevel;
			}
			if (other.GemId != 0)
			{
				GemId = other.GemId;
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
				SlotId = input.ReadInt32();
				break;
			case 16u:
				SlotLevel = input.ReadInt32();
				break;
			case 24u:
				GemId = input.ReadInt32();
				break;
			}
		}
	}
}
