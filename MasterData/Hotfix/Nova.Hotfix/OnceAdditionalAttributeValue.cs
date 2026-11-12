using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class OnceAdditionalAttributeValue : IMessage<OnceAdditionalAttributeValue>, IMessage, IEquatable<OnceAdditionalAttributeValue>, IDeepCloneable<OnceAdditionalAttributeValue>
{
	private static readonly MessageParser<OnceAdditionalAttributeValue> _parser = new MessageParser<OnceAdditionalAttributeValue>(() => new OnceAdditionalAttributeValue());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DamageType1FieldNumber = 2;

	private int damageType1_;

	public const int ElementType1FieldNumber = 3;

	private int elementType1_;

	public const int AttributeType1FieldNumber = 4;

	private int attributeType1_;

	public const int ParameterType1FieldNumber = 5;

	private int parameterType1_;

	public const int Value1FieldNumber = 6;

	private int value1_;

	public const int DamageType2FieldNumber = 7;

	private int damageType2_;

	public const int ElementType2FieldNumber = 8;

	private int elementType2_;

	public const int AttributeType2FieldNumber = 9;

	private int attributeType2_;

	public const int ParameterType2FieldNumber = 10;

	private int parameterType2_;

	public const int Value2FieldNumber = 11;

	private int value2_;

	public const int DamageType3FieldNumber = 12;

	private int damageType3_;

	public const int ElementType3FieldNumber = 13;

	private int elementType3_;

	public const int AttributeType3FieldNumber = 14;

	private int attributeType3_;

	public const int ParameterType3FieldNumber = 15;

	private int parameterType3_;

	public const int Value3FieldNumber = 16;

	private int value3_;

	[DebuggerNonUserCode]
	public static MessageParser<OnceAdditionalAttributeValue> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(606);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DamageType1
	{
		get
		{
			return damageType1_;
		}
		set
		{
			damageType1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ElementType1
	{
		get
		{
			return elementType1_;
		}
		set
		{
			elementType1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttributeType1
	{
		get
		{
			return attributeType1_;
		}
		set
		{
			attributeType1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ParameterType1
	{
		get
		{
			return parameterType1_;
		}
		set
		{
			parameterType1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Value1
	{
		get
		{
			return value1_;
		}
		set
		{
			value1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DamageType2
	{
		get
		{
			return damageType2_;
		}
		set
		{
			damageType2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ElementType2
	{
		get
		{
			return elementType2_;
		}
		set
		{
			elementType2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttributeType2
	{
		get
		{
			return attributeType2_;
		}
		set
		{
			attributeType2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ParameterType2
	{
		get
		{
			return parameterType2_;
		}
		set
		{
			parameterType2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Value2
	{
		get
		{
			return value2_;
		}
		set
		{
			value2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DamageType3
	{
		get
		{
			return damageType3_;
		}
		set
		{
			damageType3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ElementType3
	{
		get
		{
			return elementType3_;
		}
		set
		{
			elementType3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttributeType3
	{
		get
		{
			return attributeType3_;
		}
		set
		{
			attributeType3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ParameterType3
	{
		get
		{
			return parameterType3_;
		}
		set
		{
			parameterType3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Value3
	{
		get
		{
			return value3_;
		}
		set
		{
			value3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public OnceAdditionalAttributeValue()
	{
	}

	[DebuggerNonUserCode]
	public OnceAdditionalAttributeValue(OnceAdditionalAttributeValue other)
		: this()
	{
		id_ = other.id_;
		damageType1_ = other.damageType1_;
		elementType1_ = other.elementType1_;
		attributeType1_ = other.attributeType1_;
		parameterType1_ = other.parameterType1_;
		value1_ = other.value1_;
		damageType2_ = other.damageType2_;
		elementType2_ = other.elementType2_;
		attributeType2_ = other.attributeType2_;
		parameterType2_ = other.parameterType2_;
		value2_ = other.value2_;
		damageType3_ = other.damageType3_;
		elementType3_ = other.elementType3_;
		attributeType3_ = other.attributeType3_;
		parameterType3_ = other.parameterType3_;
		value3_ = other.value3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public OnceAdditionalAttributeValue Clone()
	{
		return new OnceAdditionalAttributeValue(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as OnceAdditionalAttributeValue);
	}

	[DebuggerNonUserCode]
	public bool Equals(OnceAdditionalAttributeValue other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (DamageType1 != other.DamageType1)
		{
			return false;
		}
		if (ElementType1 != other.ElementType1)
		{
			return false;
		}
		if (AttributeType1 != other.AttributeType1)
		{
			return false;
		}
		if (ParameterType1 != other.ParameterType1)
		{
			return false;
		}
		if (Value1 != other.Value1)
		{
			return false;
		}
		if (DamageType2 != other.DamageType2)
		{
			return false;
		}
		if (ElementType2 != other.ElementType2)
		{
			return false;
		}
		if (AttributeType2 != other.AttributeType2)
		{
			return false;
		}
		if (ParameterType2 != other.ParameterType2)
		{
			return false;
		}
		if (Value2 != other.Value2)
		{
			return false;
		}
		if (DamageType3 != other.DamageType3)
		{
			return false;
		}
		if (ElementType3 != other.ElementType3)
		{
			return false;
		}
		if (AttributeType3 != other.AttributeType3)
		{
			return false;
		}
		if (ParameterType3 != other.ParameterType3)
		{
			return false;
		}
		if (Value3 != other.Value3)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (DamageType1 != 0)
		{
			num ^= DamageType1.GetHashCode();
		}
		if (ElementType1 != 0)
		{
			num ^= ElementType1.GetHashCode();
		}
		if (AttributeType1 != 0)
		{
			num ^= AttributeType1.GetHashCode();
		}
		if (ParameterType1 != 0)
		{
			num ^= ParameterType1.GetHashCode();
		}
		if (Value1 != 0)
		{
			num ^= Value1.GetHashCode();
		}
		if (DamageType2 != 0)
		{
			num ^= DamageType2.GetHashCode();
		}
		if (ElementType2 != 0)
		{
			num ^= ElementType2.GetHashCode();
		}
		if (AttributeType2 != 0)
		{
			num ^= AttributeType2.GetHashCode();
		}
		if (ParameterType2 != 0)
		{
			num ^= ParameterType2.GetHashCode();
		}
		if (Value2 != 0)
		{
			num ^= Value2.GetHashCode();
		}
		if (DamageType3 != 0)
		{
			num ^= DamageType3.GetHashCode();
		}
		if (ElementType3 != 0)
		{
			num ^= ElementType3.GetHashCode();
		}
		if (AttributeType3 != 0)
		{
			num ^= AttributeType3.GetHashCode();
		}
		if (ParameterType3 != 0)
		{
			num ^= ParameterType3.GetHashCode();
		}
		if (Value3 != 0)
		{
			num ^= Value3.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (DamageType1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DamageType1);
		}
		if (ElementType1 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ElementType1);
		}
		if (AttributeType1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AttributeType1);
		}
		if (ParameterType1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ParameterType1);
		}
		if (Value1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Value1);
		}
		if (DamageType2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(DamageType2);
		}
		if (ElementType2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ElementType2);
		}
		if (AttributeType2 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AttributeType2);
		}
		if (ParameterType2 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ParameterType2);
		}
		if (Value2 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Value2);
		}
		if (DamageType3 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(DamageType3);
		}
		if (ElementType3 != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(ElementType3);
		}
		if (AttributeType3 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(AttributeType3);
		}
		if (ParameterType3 != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(ParameterType3);
		}
		if (Value3 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Value3);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (DamageType1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DamageType1);
		}
		if (ElementType1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ElementType1);
		}
		if (AttributeType1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttributeType1);
		}
		if (ParameterType1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ParameterType1);
		}
		if (Value1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Value1);
		}
		if (DamageType2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DamageType2);
		}
		if (ElementType2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ElementType2);
		}
		if (AttributeType2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttributeType2);
		}
		if (ParameterType2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ParameterType2);
		}
		if (Value2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Value2);
		}
		if (DamageType3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DamageType3);
		}
		if (ElementType3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ElementType3);
		}
		if (AttributeType3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttributeType3);
		}
		if (ParameterType3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ParameterType3);
		}
		if (Value3 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Value3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(OnceAdditionalAttributeValue other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DamageType1 != 0)
			{
				DamageType1 = other.DamageType1;
			}
			if (other.ElementType1 != 0)
			{
				ElementType1 = other.ElementType1;
			}
			if (other.AttributeType1 != 0)
			{
				AttributeType1 = other.AttributeType1;
			}
			if (other.ParameterType1 != 0)
			{
				ParameterType1 = other.ParameterType1;
			}
			if (other.Value1 != 0)
			{
				Value1 = other.Value1;
			}
			if (other.DamageType2 != 0)
			{
				DamageType2 = other.DamageType2;
			}
			if (other.ElementType2 != 0)
			{
				ElementType2 = other.ElementType2;
			}
			if (other.AttributeType2 != 0)
			{
				AttributeType2 = other.AttributeType2;
			}
			if (other.ParameterType2 != 0)
			{
				ParameterType2 = other.ParameterType2;
			}
			if (other.Value2 != 0)
			{
				Value2 = other.Value2;
			}
			if (other.DamageType3 != 0)
			{
				DamageType3 = other.DamageType3;
			}
			if (other.ElementType3 != 0)
			{
				ElementType3 = other.ElementType3;
			}
			if (other.AttributeType3 != 0)
			{
				AttributeType3 = other.AttributeType3;
			}
			if (other.ParameterType3 != 0)
			{
				ParameterType3 = other.ParameterType3;
			}
			if (other.Value3 != 0)
			{
				Value3 = other.Value3;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				DamageType1 = input.ReadInt32();
				break;
			case 24u:
				ElementType1 = input.ReadInt32();
				break;
			case 32u:
				AttributeType1 = input.ReadInt32();
				break;
			case 40u:
				ParameterType1 = input.ReadInt32();
				break;
			case 48u:
				Value1 = input.ReadInt32();
				break;
			case 56u:
				DamageType2 = input.ReadInt32();
				break;
			case 64u:
				ElementType2 = input.ReadInt32();
				break;
			case 72u:
				AttributeType2 = input.ReadInt32();
				break;
			case 80u:
				ParameterType2 = input.ReadInt32();
				break;
			case 88u:
				Value2 = input.ReadInt32();
				break;
			case 96u:
				DamageType3 = input.ReadInt32();
				break;
			case 104u:
				ElementType3 = input.ReadInt32();
				break;
			case 112u:
				AttributeType3 = input.ReadInt32();
				break;
			case 120u:
				ParameterType3 = input.ReadInt32();
				break;
			case 128u:
				Value3 = input.ReadInt32();
				break;
			}
		}
	}
}
