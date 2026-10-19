using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class TimeLimitItems : IMessage<TimeLimitItems>, IMessage, IEquatable<TimeLimitItems>, IDeepCloneable<TimeLimitItems>, IBufferMessage
{
	private static readonly MessageParser<TimeLimitItems> _parser = new MessageParser<TimeLimitItems>(() => new TimeLimitItems());

	private UnknownFieldSet _unknownFields;

	public const int ItemsFieldNumber = 1;

	private static readonly FieldCodec<Item> _repeated_items_codec = FieldCodec.ForMessage(10u, Item.Parser);

	private readonly RepeatedField<Item> items_ = new RepeatedField<Item>();

	public const int MaxIDFieldNumber = 2;

	private int maxID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<TimeLimitItems> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[120];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<Item> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MaxID
	{
		get
		{
			return maxID_;
		}
		set
		{
			maxID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TimeLimitItems()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TimeLimitItems(TimeLimitItems other)
		: this()
	{
		items_ = other.items_.Clone();
		maxID_ = other.maxID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public TimeLimitItems Clone()
	{
		return new TimeLimitItems(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as TimeLimitItems);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(TimeLimitItems other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!items_.Equals(other.items_))
		{
			return false;
		}
		if (MaxID != other.MaxID)
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
		num ^= items_.GetHashCode();
		if (MaxID != 0)
		{
			num ^= MaxID.GetHashCode();
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
		items_.WriteTo(ref output, _repeated_items_codec);
		if (MaxID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MaxID);
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
		num += items_.CalculateSize(_repeated_items_codec);
		if (MaxID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(TimeLimitItems other)
	{
		if (other != null)
		{
			items_.Add(other.items_);
			if (other.MaxID != 0)
			{
				MaxID = other.MaxID;
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
			case 10u:
				items_.AddEntriesFrom(ref input, _repeated_items_codec);
				break;
			case 16u:
				MaxID = input.ReadInt32();
				break;
			}
		}
	}
}
