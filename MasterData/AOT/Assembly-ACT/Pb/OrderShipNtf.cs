using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class OrderShipNtf : IMessage<OrderShipNtf>, IMessage, IEquatable<OrderShipNtf>, IDeepCloneable<OrderShipNtf>, IBufferMessage
{
	private static readonly MessageParser<OrderShipNtf> _parser = new MessageParser<OrderShipNtf>(() => new OrderShipNtf());

	private UnknownFieldSet _unknownFields;

	public const int OrderIdFieldNumber = 1;

	private string orderId_ = "";

	public const int GotItemsFieldNumber = 2;

	private static readonly FieldCodec<UniversalItem> _repeated_gotItems_codec = FieldCodec.ForMessage(18u, UniversalItem.Parser);

	private readonly RepeatedField<UniversalItem> gotItems_ = new RepeatedField<UniversalItem>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<OrderShipNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => BillReflection.Descriptor.MessageTypes[4];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string OrderId
	{
		get
		{
			return orderId_;
		}
		set
		{
			orderId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<UniversalItem> GotItems => gotItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OrderShipNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OrderShipNtf(OrderShipNtf other)
		: this()
	{
		orderId_ = other.orderId_;
		gotItems_ = other.gotItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public OrderShipNtf Clone()
	{
		return new OrderShipNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as OrderShipNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(OrderShipNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (OrderId != other.OrderId)
		{
			return false;
		}
		if (!gotItems_.Equals(other.gotItems_))
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
		if (OrderId.Length != 0)
		{
			num ^= OrderId.GetHashCode();
		}
		num ^= gotItems_.GetHashCode();
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
		if (OrderId.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(OrderId);
		}
		gotItems_.WriteTo(ref output, _repeated_gotItems_codec);
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
		if (OrderId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OrderId);
		}
		num += gotItems_.CalculateSize(_repeated_gotItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(OrderShipNtf other)
	{
		if (other != null)
		{
			if (other.OrderId.Length != 0)
			{
				OrderId = other.OrderId;
			}
			gotItems_.Add(other.gotItems_);
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
				OrderId = input.ReadString();
				break;
			case 18u:
				gotItems_.AddEntriesFrom(ref input, _repeated_gotItems_codec);
				break;
			}
		}
	}
}
