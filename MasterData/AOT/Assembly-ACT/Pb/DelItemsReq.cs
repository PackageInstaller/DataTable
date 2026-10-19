using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class DelItemsReq : IMessage<DelItemsReq>, IMessage, IEquatable<DelItemsReq>, IDeepCloneable<DelItemsReq>, IBufferMessage
{
	private static readonly MessageParser<DelItemsReq> _parser = new MessageParser<DelItemsReq>(() => new DelItemsReq());

	private UnknownFieldSet _unknownFields;

	public const int ItemTypeFieldNumber = 1;

	private int itemType_;

	public const int ItemsFieldNumber = 2;

	private static readonly FieldCodec<OperationItem> _repeated_items_codec = FieldCodec.ForMessage(18u, OperationItem.Parser);

	private readonly RepeatedField<OperationItem> items_ = new RepeatedField<OperationItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<DelItemsReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => ItemReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ItemType
	{
		get
		{
			return itemType_;
		}
		set
		{
			itemType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<OperationItem> Items => items_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DelItemsReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DelItemsReq(DelItemsReq other)
		: this()
	{
		itemType_ = other.itemType_;
		items_ = other.items_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public DelItemsReq Clone()
	{
		return new DelItemsReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as DelItemsReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(DelItemsReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ItemType != other.ItemType)
		{
			return false;
		}
		if (!items_.Equals(other.items_))
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
		if (ItemType != 0)
		{
			num ^= ItemType.GetHashCode();
		}
		num ^= items_.GetHashCode();
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
		if (ItemType != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ItemType);
		}
		items_.WriteTo(ref output, _repeated_items_codec);
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
		if (ItemType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemType);
		}
		num += items_.CalculateSize(_repeated_items_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(DelItemsReq other)
	{
		if (other != null)
		{
			if (other.ItemType != 0)
			{
				ItemType = other.ItemType;
			}
			items_.Add(other.items_);
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
				ItemType = input.ReadInt32();
				break;
			case 18u:
				items_.AddEntriesFrom(ref input, _repeated_items_codec);
				break;
			}
		}
	}
}
