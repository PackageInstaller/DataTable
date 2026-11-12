using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GMOrder : IMessage<GMOrder>, IMessage, IEquatable<GMOrder>, IDeepCloneable<GMOrder>
{
	private static readonly MessageParser<GMOrder> _parser = new MessageParser<GMOrder>(() => new GMOrder());

	private UnknownFieldSet _unknownFields;

	public const int OrderFieldNumber = 1;

	private string order_ = "";

	public const int DescFieldNumber = 2;

	private string desc_ = "";

	public const int ParamCountFieldNumber = 3;

	private int paramCount_;

	public const int ParamName1FieldNumber = 4;

	private string paramName1_ = "";

	public const int ParamName2FieldNumber = 5;

	private string paramName2_ = "";

	public const int ParamName3FieldNumber = 6;

	private string paramName3_ = "";

	public const int ParamName4FieldNumber = 7;

	private string paramName4_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<GMOrder> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(382);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Order
	{
		get
		{
			return order_;
		}
		set
		{
			order_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ParamCount
	{
		get
		{
			return paramCount_;
		}
		set
		{
			paramCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ParamName1
	{
		get
		{
			return paramName1_;
		}
		set
		{
			paramName1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ParamName2
	{
		get
		{
			return paramName2_;
		}
		set
		{
			paramName2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ParamName3
	{
		get
		{
			return paramName3_;
		}
		set
		{
			paramName3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ParamName4
	{
		get
		{
			return paramName4_;
		}
		set
		{
			paramName4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public GMOrder()
	{
	}

	[DebuggerNonUserCode]
	public GMOrder(GMOrder other)
		: this()
	{
		order_ = other.order_;
		desc_ = other.desc_;
		paramCount_ = other.paramCount_;
		paramName1_ = other.paramName1_;
		paramName2_ = other.paramName2_;
		paramName3_ = other.paramName3_;
		paramName4_ = other.paramName4_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GMOrder Clone()
	{
		return new GMOrder(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GMOrder);
	}

	[DebuggerNonUserCode]
	public bool Equals(GMOrder other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Order != other.Order)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (ParamCount != other.ParamCount)
		{
			return false;
		}
		if (ParamName1 != other.ParamName1)
		{
			return false;
		}
		if (ParamName2 != other.ParamName2)
		{
			return false;
		}
		if (ParamName3 != other.ParamName3)
		{
			return false;
		}
		if (ParamName4 != other.ParamName4)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Order.Length != 0)
		{
			num ^= Order.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (ParamCount != 0)
		{
			num ^= ParamCount.GetHashCode();
		}
		if (ParamName1.Length != 0)
		{
			num ^= ParamName1.GetHashCode();
		}
		if (ParamName2.Length != 0)
		{
			num ^= ParamName2.GetHashCode();
		}
		if (ParamName3.Length != 0)
		{
			num ^= ParamName3.GetHashCode();
		}
		if (ParamName4.Length != 0)
		{
			num ^= ParamName4.GetHashCode();
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
		if (Order.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Order);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Desc);
		}
		if (ParamCount != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ParamCount);
		}
		if (ParamName1.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(ParamName1);
		}
		if (ParamName2.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(ParamName2);
		}
		if (ParamName3.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ParamName3);
		}
		if (ParamName4.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(ParamName4);
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
		if (Order.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Order);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (ParamCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ParamCount);
		}
		if (ParamName1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ParamName1);
		}
		if (ParamName2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ParamName2);
		}
		if (ParamName3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ParamName3);
		}
		if (ParamName4.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ParamName4);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GMOrder other)
	{
		if (other != null)
		{
			if (other.Order.Length != 0)
			{
				Order = other.Order;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.ParamCount != 0)
			{
				ParamCount = other.ParamCount;
			}
			if (other.ParamName1.Length != 0)
			{
				ParamName1 = other.ParamName1;
			}
			if (other.ParamName2.Length != 0)
			{
				ParamName2 = other.ParamName2;
			}
			if (other.ParamName3.Length != 0)
			{
				ParamName3 = other.ParamName3;
			}
			if (other.ParamName4.Length != 0)
			{
				ParamName4 = other.ParamName4;
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
			case 10u:
				Order = input.ReadString();
				break;
			case 18u:
				Desc = input.ReadString();
				break;
			case 24u:
				ParamCount = input.ReadInt32();
				break;
			case 34u:
				ParamName1 = input.ReadString();
				break;
			case 42u:
				ParamName2 = input.ReadString();
				break;
			case 50u:
				ParamName3 = input.ReadString();
				break;
			case 58u:
				ParamName4 = input.ReadString();
				break;
			}
		}
	}
}
