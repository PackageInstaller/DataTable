using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class ChipSlot : IMessage<ChipSlot>, IMessage, IEquatable<ChipSlot>, IDeepCloneable<ChipSlot>, IBufferMessage
{
	private static readonly MessageParser<ChipSlot> _parser = new MessageParser<ChipSlot>(() => new ChipSlot());

	private UnknownFieldSet _unknownFields;

	public const int CoreChipUidFieldNumber = 1;

	private int coreChipUid_;

	public const int SideSlotsFieldNumber = 2;

	private static readonly FieldCodec<ChipSideSlot> _repeated_sideSlots_codec = FieldCodec.ForMessage(18u, ChipSideSlot.Parser);

	private readonly RepeatedField<ChipSideSlot> sideSlots_ = new RepeatedField<ChipSideSlot>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ChipSlot> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[45];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CoreChipUid
	{
		get
		{
			return coreChipUid_;
		}
		set
		{
			coreChipUid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<ChipSideSlot> SideSlots => sideSlots_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipSlot()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipSlot(ChipSlot other)
		: this()
	{
		coreChipUid_ = other.coreChipUid_;
		sideSlots_ = other.sideSlots_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipSlot Clone()
	{
		return new ChipSlot(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ChipSlot);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ChipSlot other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CoreChipUid != other.CoreChipUid)
		{
			return false;
		}
		if (!sideSlots_.Equals(other.sideSlots_))
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
		if (CoreChipUid != 0)
		{
			num ^= CoreChipUid.GetHashCode();
		}
		num ^= sideSlots_.GetHashCode();
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
		if (CoreChipUid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CoreChipUid);
		}
		sideSlots_.WriteTo(ref output, _repeated_sideSlots_codec);
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
		if (CoreChipUid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CoreChipUid);
		}
		num += sideSlots_.CalculateSize(_repeated_sideSlots_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ChipSlot other)
	{
		if (other != null)
		{
			if (other.CoreChipUid != 0)
			{
				CoreChipUid = other.CoreChipUid;
			}
			sideSlots_.Add(other.sideSlots_);
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
				CoreChipUid = input.ReadInt32();
				break;
			case 18u:
				sideSlots_.AddEntriesFrom(ref input, _repeated_sideSlots_codec);
				break;
			}
		}
	}
}
