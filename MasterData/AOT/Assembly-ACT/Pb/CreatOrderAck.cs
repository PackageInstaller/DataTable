using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class CreatOrderAck : IMessage<CreatOrderAck>, IMessage, IEquatable<CreatOrderAck>, IDeepCloneable<CreatOrderAck>, IBufferMessage
{
	private static readonly MessageParser<CreatOrderAck> _parser = new MessageParser<CreatOrderAck>(() => new CreatOrderAck());

	private UnknownFieldSet _unknownFields;

	public const int OrderIdFieldNumber = 1;

	private string orderId_ = "";

	public const int MoneyFieldNumber = 2;

	private int money_;

	public const int CallbackUrlFieldNumber = 3;

	private string callbackUrl_ = "";

	public const int ExtraFieldNumber = 4;

	private string extra_ = "";

	public const int SignFieldNumber = 5;

	private string sign_ = "";

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<CreatOrderAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => BillReflection.Descriptor.MessageTypes[1];

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
	public int Money
	{
		get
		{
			return money_;
		}
		set
		{
			money_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string CallbackUrl
	{
		get
		{
			return callbackUrl_;
		}
		set
		{
			callbackUrl_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Extra
	{
		get
		{
			return extra_;
		}
		set
		{
			extra_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Sign
	{
		get
		{
			return sign_;
		}
		set
		{
			sign_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreatOrderAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreatOrderAck(CreatOrderAck other)
		: this()
	{
		orderId_ = other.orderId_;
		money_ = other.money_;
		callbackUrl_ = other.callbackUrl_;
		extra_ = other.extra_;
		sign_ = other.sign_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CreatOrderAck Clone()
	{
		return new CreatOrderAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as CreatOrderAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(CreatOrderAck other)
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
		if (Money != other.Money)
		{
			return false;
		}
		if (CallbackUrl != other.CallbackUrl)
		{
			return false;
		}
		if (Extra != other.Extra)
		{
			return false;
		}
		if (Sign != other.Sign)
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
		if (Money != 0)
		{
			num ^= Money.GetHashCode();
		}
		if (CallbackUrl.Length != 0)
		{
			num ^= CallbackUrl.GetHashCode();
		}
		if (Extra.Length != 0)
		{
			num ^= Extra.GetHashCode();
		}
		if (Sign.Length != 0)
		{
			num ^= Sign.GetHashCode();
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
		if (OrderId.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(OrderId);
		}
		if (Money != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Money);
		}
		if (CallbackUrl.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(CallbackUrl);
		}
		if (Extra.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Extra);
		}
		if (Sign.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Sign);
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
		if (OrderId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OrderId);
		}
		if (Money != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Money);
		}
		if (CallbackUrl.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CallbackUrl);
		}
		if (Extra.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Extra);
		}
		if (Sign.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Sign);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CreatOrderAck other)
	{
		if (other != null)
		{
			if (other.OrderId.Length != 0)
			{
				OrderId = other.OrderId;
			}
			if (other.Money != 0)
			{
				Money = other.Money;
			}
			if (other.CallbackUrl.Length != 0)
			{
				CallbackUrl = other.CallbackUrl;
			}
			if (other.Extra.Length != 0)
			{
				Extra = other.Extra;
			}
			if (other.Sign.Length != 0)
			{
				Sign = other.Sign;
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
				OrderId = input.ReadString();
				break;
			case 16u:
				Money = input.ReadInt32();
				break;
			case 26u:
				CallbackUrl = input.ReadString();
				break;
			case 34u:
				Extra = input.ReadString();
				break;
			case 42u:
				Sign = input.ReadString();
				break;
			}
		}
	}
}
