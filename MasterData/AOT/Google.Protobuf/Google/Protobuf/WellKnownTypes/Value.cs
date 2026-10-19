using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class Value : IMessage<Value>, IMessage, IEquatable<Value>, IDeepCloneable<Value>, IBufferMessage
{
	public enum KindOneofCase
	{
		None,
		NullValue,
		NumberValue,
		StringValue,
		BoolValue,
		StructValue,
		ListValue
	}

	private static readonly MessageParser<Value> _parser = new MessageParser<Value>(() => new Value());

	private UnknownFieldSet _unknownFields;

	private object kind_;

	private KindOneofCase kindCase_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Value> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => StructReflection.Descriptor.MessageTypes[1];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public NullValue NullValue
	{
		get
		{
			if (kindCase_ != KindOneofCase.NullValue)
			{
				return NullValue.NullValue;
			}
			return (NullValue)kind_;
		}
		set
		{
			kind_ = value;
			kindCase_ = KindOneofCase.NullValue;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public double NumberValue
	{
		get
		{
			if (kindCase_ != KindOneofCase.NumberValue)
			{
				return 0.0;
			}
			return (double)kind_;
		}
		set
		{
			kind_ = value;
			kindCase_ = KindOneofCase.NumberValue;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string StringValue
	{
		get
		{
			if (kindCase_ != KindOneofCase.StringValue)
			{
				return "";
			}
			return (string)kind_;
		}
		set
		{
			kind_ = ProtoPreconditions.CheckNotNull(value, "value");
			kindCase_ = KindOneofCase.StringValue;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool BoolValue
	{
		get
		{
			if (kindCase_ != KindOneofCase.BoolValue)
			{
				return false;
			}
			return (bool)kind_;
		}
		set
		{
			kind_ = value;
			kindCase_ = KindOneofCase.BoolValue;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Struct StructValue
	{
		get
		{
			if (kindCase_ != KindOneofCase.StructValue)
			{
				return null;
			}
			return (Struct)kind_;
		}
		set
		{
			kind_ = value;
			kindCase_ = ((value != null) ? KindOneofCase.StructValue : KindOneofCase.None);
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public ListValue ListValue
	{
		get
		{
			if (kindCase_ != KindOneofCase.ListValue)
			{
				return null;
			}
			return (ListValue)kind_;
		}
		set
		{
			kind_ = value;
			kindCase_ = ((value != null) ? KindOneofCase.ListValue : KindOneofCase.None);
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public KindOneofCase KindCase => kindCase_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Value()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Value(Value other)
		: this()
	{
		switch (other.KindCase)
		{
		case KindOneofCase.NullValue:
			NullValue = other.NullValue;
			break;
		case KindOneofCase.NumberValue:
			NumberValue = other.NumberValue;
			break;
		case KindOneofCase.StringValue:
			StringValue = other.StringValue;
			break;
		case KindOneofCase.BoolValue:
			BoolValue = other.BoolValue;
			break;
		case KindOneofCase.StructValue:
			StructValue = other.StructValue.Clone();
			break;
		case KindOneofCase.ListValue:
			ListValue = other.ListValue.Clone();
			break;
		}
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public Value Clone()
	{
		return new Value(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Value);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(Value other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (NullValue != other.NullValue)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseDoubleEqualityComparer.Equals(NumberValue, other.NumberValue))
		{
			return false;
		}
		if (StringValue != other.StringValue)
		{
			return false;
		}
		if (BoolValue != other.BoolValue)
		{
			return false;
		}
		if (!object.Equals(StructValue, other.StructValue))
		{
			return false;
		}
		if (!object.Equals(ListValue, other.ListValue))
		{
			return false;
		}
		if (KindCase != other.KindCase)
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
		if (kindCase_ == KindOneofCase.NullValue)
		{
			num ^= NullValue.GetHashCode();
		}
		if (kindCase_ == KindOneofCase.NumberValue)
		{
			num ^= ProtobufEqualityComparers.BitwiseDoubleEqualityComparer.GetHashCode(NumberValue);
		}
		if (kindCase_ == KindOneofCase.StringValue)
		{
			num ^= StringValue.GetHashCode();
		}
		if (kindCase_ == KindOneofCase.BoolValue)
		{
			num ^= BoolValue.GetHashCode();
		}
		if (kindCase_ == KindOneofCase.StructValue)
		{
			num ^= StructValue.GetHashCode();
		}
		if (kindCase_ == KindOneofCase.ListValue)
		{
			num ^= ListValue.GetHashCode();
		}
		num ^= (int)kindCase_;
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (kindCase_ == KindOneofCase.NullValue)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)NullValue);
		}
		if (kindCase_ == KindOneofCase.NumberValue)
		{
			output.WriteRawTag(17);
			output.WriteDouble(NumberValue);
		}
		if (kindCase_ == KindOneofCase.StringValue)
		{
			output.WriteRawTag(26);
			output.WriteString(StringValue);
		}
		if (kindCase_ == KindOneofCase.BoolValue)
		{
			output.WriteRawTag(32);
			output.WriteBool(BoolValue);
		}
		if (kindCase_ == KindOneofCase.StructValue)
		{
			output.WriteRawTag(42);
			output.WriteMessage(StructValue);
		}
		if (kindCase_ == KindOneofCase.ListValue)
		{
			output.WriteRawTag(50);
			output.WriteMessage(ListValue);
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
		if (kindCase_ == KindOneofCase.NullValue)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)NullValue);
		}
		if (kindCase_ == KindOneofCase.NumberValue)
		{
			num += 9;
		}
		if (kindCase_ == KindOneofCase.StringValue)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StringValue);
		}
		if (kindCase_ == KindOneofCase.BoolValue)
		{
			num += 2;
		}
		if (kindCase_ == KindOneofCase.StructValue)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(StructValue);
		}
		if (kindCase_ == KindOneofCase.ListValue)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ListValue);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Value other)
	{
		if (other == null)
		{
			return;
		}
		switch (other.KindCase)
		{
		case KindOneofCase.NullValue:
			NullValue = other.NullValue;
			break;
		case KindOneofCase.NumberValue:
			NumberValue = other.NumberValue;
			break;
		case KindOneofCase.StringValue:
			StringValue = other.StringValue;
			break;
		case KindOneofCase.BoolValue:
			BoolValue = other.BoolValue;
			break;
		case KindOneofCase.StructValue:
			if (StructValue == null)
			{
				StructValue = new Struct();
			}
			StructValue.MergeFrom(other.StructValue);
			break;
		case KindOneofCase.ListValue:
			if (ListValue == null)
			{
				ListValue = new ListValue();
			}
			ListValue.MergeFrom(other.ListValue);
			break;
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				kind_ = input.ReadEnum();
				kindCase_ = KindOneofCase.NullValue;
				break;
			case 17u:
				NumberValue = input.ReadDouble();
				break;
			case 26u:
				StringValue = input.ReadString();
				break;
			case 32u:
				BoolValue = input.ReadBool();
				break;
			case 42u:
			{
				Struct obj = new Struct();
				if (kindCase_ == KindOneofCase.StructValue)
				{
					obj.MergeFrom(StructValue);
				}
				input.ReadMessage(obj);
				StructValue = obj;
				break;
			}
			case 50u:
			{
				ListValue listValue = new ListValue();
				if (kindCase_ == KindOneofCase.ListValue)
				{
					listValue.MergeFrom(ListValue);
				}
				input.ReadMessage(listValue);
				ListValue = listValue;
				break;
			}
			}
		}
	}

	public static Value ForNull()
	{
		return new Value
		{
			NullValue = NullValue.NullValue
		};
	}
}
