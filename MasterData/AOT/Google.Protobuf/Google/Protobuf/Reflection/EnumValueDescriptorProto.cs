using System;
using System.CodeDom.Compiler;
using System.Diagnostics;

namespace Google.Protobuf.Reflection;

public sealed class EnumValueDescriptorProto : IMessage<EnumValueDescriptorProto>, IMessage, IEquatable<EnumValueDescriptorProto>, IDeepCloneable<EnumValueDescriptorProto>, IBufferMessage
{
	private static readonly MessageParser<EnumValueDescriptorProto> _parser = new MessageParser<EnumValueDescriptorProto>(() => new EnumValueDescriptorProto());

	private UnknownFieldSet _unknownFields;

	private int _hasBits0;

	private static readonly string NameDefaultValue = "";

	private string name_;

	private static readonly int NumberDefaultValue = 0;

	private int number_;

	private EnumValueOptions options_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<EnumValueDescriptorProto> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Name
	{
		get
		{
			return name_ ?? NameDefaultValue;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasName => name_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Number
	{
		get
		{
			if ((_hasBits0 & 1) != 0)
			{
				return number_;
			}
			return NumberDefaultValue;
		}
		set
		{
			_hasBits0 |= 1;
			number_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasNumber => (_hasBits0 & 1) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnumValueOptions Options
	{
		get
		{
			return options_;
		}
		set
		{
			options_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public EnumValueDescriptorProto()
	{
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public EnumValueDescriptorProto(EnumValueDescriptorProto other)
		: this()
	{
		_hasBits0 = other._hasBits0;
		name_ = other.name_;
		number_ = other.number_;
		options_ = ((other.options_ != null) ? other.options_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public EnumValueDescriptorProto Clone()
	{
		return new EnumValueDescriptorProto(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as EnumValueDescriptorProto);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(EnumValueDescriptorProto other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Number != other.Number)
		{
			return false;
		}
		if (!object.Equals(Options, other.Options))
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
		if (HasName)
		{
			num ^= Name.GetHashCode();
		}
		if (HasNumber)
		{
			num ^= Number.GetHashCode();
		}
		if (options_ != null)
		{
			num ^= Options.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (HasName)
		{
			output.WriteRawTag(10);
			output.WriteString(Name);
		}
		if (HasNumber)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Number);
		}
		if (options_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(Options);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (HasName)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (HasNumber)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Number);
		}
		if (options_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Options);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(EnumValueDescriptorProto other)
	{
		if (other == null)
		{
			return;
		}
		if (other.HasName)
		{
			Name = other.Name;
		}
		if (other.HasNumber)
		{
			Number = other.Number;
		}
		if (other.options_ != null)
		{
			if (options_ == null)
			{
				Options = new EnumValueOptions();
			}
			Options.MergeFrom(other.Options);
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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
				Name = input.ReadString();
				break;
			case 16u:
				Number = input.ReadInt32();
				break;
			case 26u:
				if (options_ == null)
				{
					Options = new EnumValueOptions();
				}
				input.ReadMessage(Options);
				break;
			}
		}
	}
}
