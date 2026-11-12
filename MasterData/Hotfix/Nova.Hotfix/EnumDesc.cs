using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class EnumDesc : IMessage<EnumDesc>, IMessage, IEquatable<EnumDesc>, IDeepCloneable<EnumDesc>
{
	private static readonly MessageParser<EnumDesc> _parser = new MessageParser<EnumDesc>(() => new EnumDesc());

	private UnknownFieldSet _unknownFields;

	public const int EnumNameFieldNumber = 1;

	private string enumName_ = "";

	public const int ValueFieldNumber = 2;

	private int value_;

	public const int KeyFieldNumber = 3;

	private string key_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<EnumDesc> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(336);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string EnumName
	{
		get
		{
			return enumName_;
		}
		set
		{
			enumName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
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
	public string Key
	{
		get
		{
			return key_;
		}
		set
		{
			key_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public EnumDesc()
	{
	}

	[DebuggerNonUserCode]
	public EnumDesc(EnumDesc other)
		: this()
	{
		enumName_ = other.enumName_;
		value_ = other.value_;
		key_ = other.key_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public EnumDesc Clone()
	{
		return new EnumDesc(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as EnumDesc);
	}

	[DebuggerNonUserCode]
	public bool Equals(EnumDesc other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (EnumName != other.EnumName)
		{
			return false;
		}
		if (Value != other.Value)
		{
			return false;
		}
		if (Key != other.Key)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (EnumName.Length != 0)
		{
			num ^= EnumName.GetHashCode();
		}
		if (Value != 0)
		{
			num ^= Value.GetHashCode();
		}
		if (Key.Length != 0)
		{
			num ^= Key.GetHashCode();
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
		if (EnumName.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(EnumName);
		}
		if (Value != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Value);
		}
		if (Key.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Key);
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
		if (EnumName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EnumName);
		}
		if (Value != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Value);
		}
		if (Key.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Key);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(EnumDesc other)
	{
		if (other != null)
		{
			if (other.EnumName.Length != 0)
			{
				EnumName = other.EnumName;
			}
			if (other.Value != 0)
			{
				Value = other.Value;
			}
			if (other.Key.Length != 0)
			{
				Key = other.Key;
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
				EnumName = input.ReadString();
				break;
			case 16u:
				Value = input.ReadInt32();
				break;
			case 26u:
				Key = input.ReadString();
				break;
			}
		}
	}
}
