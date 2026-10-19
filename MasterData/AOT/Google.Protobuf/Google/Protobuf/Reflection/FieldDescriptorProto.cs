using System;
using System.CodeDom.Compiler;
using System.Diagnostics;

namespace Google.Protobuf.Reflection;

public sealed class FieldDescriptorProto : IMessage<FieldDescriptorProto>, IMessage, IEquatable<FieldDescriptorProto>, IDeepCloneable<FieldDescriptorProto>, IBufferMessage
{
	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static class Types
	{
		public enum Type
		{
			[OriginalName("TYPE_DOUBLE")]
			Double = 1,
			[OriginalName("TYPE_FLOAT")]
			Float,
			[OriginalName("TYPE_INT64")]
			Int64,
			[OriginalName("TYPE_UINT64")]
			Uint64,
			[OriginalName("TYPE_INT32")]
			Int32,
			[OriginalName("TYPE_FIXED64")]
			Fixed64,
			[OriginalName("TYPE_FIXED32")]
			Fixed32,
			[OriginalName("TYPE_BOOL")]
			Bool,
			[OriginalName("TYPE_STRING")]
			String,
			[OriginalName("TYPE_GROUP")]
			Group,
			[OriginalName("TYPE_MESSAGE")]
			Message,
			[OriginalName("TYPE_BYTES")]
			Bytes,
			[OriginalName("TYPE_UINT32")]
			Uint32,
			[OriginalName("TYPE_ENUM")]
			Enum,
			[OriginalName("TYPE_SFIXED32")]
			Sfixed32,
			[OriginalName("TYPE_SFIXED64")]
			Sfixed64,
			[OriginalName("TYPE_SINT32")]
			Sint32,
			[OriginalName("TYPE_SINT64")]
			Sint64
		}

		public enum Label
		{
			[OriginalName("LABEL_OPTIONAL")]
			Optional = 1,
			[OriginalName("LABEL_REQUIRED")]
			Required,
			[OriginalName("LABEL_REPEATED")]
			Repeated
		}
	}

	private static readonly MessageParser<FieldDescriptorProto> _parser = new MessageParser<FieldDescriptorProto>(() => new FieldDescriptorProto());

	private UnknownFieldSet _unknownFields;

	private int _hasBits0;

	private static readonly string NameDefaultValue = "";

	private string name_;

	private static readonly int NumberDefaultValue = 0;

	private int number_;

	private static readonly Types.Label LabelDefaultValue = Types.Label.Optional;

	private Types.Label label_;

	private static readonly Types.Type TypeDefaultValue = Types.Type.Double;

	private Types.Type type_;

	private static readonly string TypeNameDefaultValue = "";

	private string typeName_;

	private static readonly string ExtendeeDefaultValue = "";

	private string extendee_;

	private static readonly string DefaultValueDefaultValue = "";

	private string defaultValue_;

	private static readonly int OneofIndexDefaultValue = 0;

	private int oneofIndex_;

	private static readonly string JsonNameDefaultValue = "";

	private string jsonName_;

	private FieldOptions options_;

	private static readonly bool Proto3OptionalDefaultValue = false;

	private bool proto3Optional_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<FieldDescriptorProto> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[4];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public Types.Label Label
	{
		get
		{
			if ((_hasBits0 & 2) != 0)
			{
				return label_;
			}
			return LabelDefaultValue;
		}
		set
		{
			_hasBits0 |= 2;
			label_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasLabel => (_hasBits0 & 2) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Types.Type Type
	{
		get
		{
			if ((_hasBits0 & 4) != 0)
			{
				return type_;
			}
			return TypeDefaultValue;
		}
		set
		{
			_hasBits0 |= 4;
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasType => (_hasBits0 & 4) != 0;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string TypeName
	{
		get
		{
			return typeName_ ?? TypeNameDefaultValue;
		}
		set
		{
			typeName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasTypeName => typeName_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Extendee
	{
		get
		{
			return extendee_ ?? ExtendeeDefaultValue;
		}
		set
		{
			extendee_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasExtendee => extendee_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string DefaultValue
	{
		get
		{
			return defaultValue_ ?? DefaultValueDefaultValue;
		}
		set
		{
			defaultValue_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasDefaultValue => defaultValue_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int OneofIndex
	{
		get
		{
			if ((_hasBits0 & 8) != 0)
			{
				return oneofIndex_;
			}
			return OneofIndexDefaultValue;
		}
		set
		{
			_hasBits0 |= 8;
			oneofIndex_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasOneofIndex => (_hasBits0 & 8) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string JsonName
	{
		get
		{
			return jsonName_ ?? JsonNameDefaultValue;
		}
		set
		{
			jsonName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasJsonName => jsonName_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public FieldOptions Options
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Proto3Optional
	{
		get
		{
			if ((_hasBits0 & 0x10) != 0)
			{
				return proto3Optional_;
			}
			return Proto3OptionalDefaultValue;
		}
		set
		{
			_hasBits0 |= 16;
			proto3Optional_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasProto3Optional => (_hasBits0 & 0x10) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FieldDescriptorProto()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FieldDescriptorProto(FieldDescriptorProto other)
		: this()
	{
		_hasBits0 = other._hasBits0;
		name_ = other.name_;
		number_ = other.number_;
		label_ = other.label_;
		type_ = other.type_;
		typeName_ = other.typeName_;
		extendee_ = other.extendee_;
		defaultValue_ = other.defaultValue_;
		oneofIndex_ = other.oneofIndex_;
		jsonName_ = other.jsonName_;
		options_ = ((other.options_ != null) ? other.options_.Clone() : null);
		proto3Optional_ = other.proto3Optional_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FieldDescriptorProto Clone()
	{
		return new FieldDescriptorProto(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FieldDescriptorProto);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(FieldDescriptorProto other)
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
		if (Label != other.Label)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (TypeName != other.TypeName)
		{
			return false;
		}
		if (Extendee != other.Extendee)
		{
			return false;
		}
		if (DefaultValue != other.DefaultValue)
		{
			return false;
		}
		if (OneofIndex != other.OneofIndex)
		{
			return false;
		}
		if (JsonName != other.JsonName)
		{
			return false;
		}
		if (!object.Equals(Options, other.Options))
		{
			return false;
		}
		if (Proto3Optional != other.Proto3Optional)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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
		if (HasLabel)
		{
			num ^= Label.GetHashCode();
		}
		if (HasType)
		{
			num ^= Type.GetHashCode();
		}
		if (HasTypeName)
		{
			num ^= TypeName.GetHashCode();
		}
		if (HasExtendee)
		{
			num ^= Extendee.GetHashCode();
		}
		if (HasDefaultValue)
		{
			num ^= DefaultValue.GetHashCode();
		}
		if (HasOneofIndex)
		{
			num ^= OneofIndex.GetHashCode();
		}
		if (HasJsonName)
		{
			num ^= JsonName.GetHashCode();
		}
		if (options_ != null)
		{
			num ^= Options.GetHashCode();
		}
		if (HasProto3Optional)
		{
			num ^= Proto3Optional.GetHashCode();
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (HasName)
		{
			output.WriteRawTag(10);
			output.WriteString(Name);
		}
		if (HasExtendee)
		{
			output.WriteRawTag(18);
			output.WriteString(Extendee);
		}
		if (HasNumber)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Number);
		}
		if (HasLabel)
		{
			output.WriteRawTag(32);
			output.WriteEnum((int)Label);
		}
		if (HasType)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)Type);
		}
		if (HasTypeName)
		{
			output.WriteRawTag(50);
			output.WriteString(TypeName);
		}
		if (HasDefaultValue)
		{
			output.WriteRawTag(58);
			output.WriteString(DefaultValue);
		}
		if (options_ != null)
		{
			output.WriteRawTag(66);
			output.WriteMessage(Options);
		}
		if (HasOneofIndex)
		{
			output.WriteRawTag(72);
			output.WriteInt32(OneofIndex);
		}
		if (HasJsonName)
		{
			output.WriteRawTag(82);
			output.WriteString(JsonName);
		}
		if (HasProto3Optional)
		{
			output.WriteRawTag(136, 1);
			output.WriteBool(Proto3Optional);
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
		if (HasLabel)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Label);
		}
		if (HasType)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Type);
		}
		if (HasTypeName)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TypeName);
		}
		if (HasExtendee)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Extendee);
		}
		if (HasDefaultValue)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DefaultValue);
		}
		if (HasOneofIndex)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OneofIndex);
		}
		if (HasJsonName)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(JsonName);
		}
		if (options_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Options);
		}
		if (HasProto3Optional)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(FieldDescriptorProto other)
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
		if (other.HasLabel)
		{
			Label = other.Label;
		}
		if (other.HasType)
		{
			Type = other.Type;
		}
		if (other.HasTypeName)
		{
			TypeName = other.TypeName;
		}
		if (other.HasExtendee)
		{
			Extendee = other.Extendee;
		}
		if (other.HasDefaultValue)
		{
			DefaultValue = other.DefaultValue;
		}
		if (other.HasOneofIndex)
		{
			OneofIndex = other.OneofIndex;
		}
		if (other.HasJsonName)
		{
			JsonName = other.JsonName;
		}
		if (other.options_ != null)
		{
			if (options_ == null)
			{
				Options = new FieldOptions();
			}
			Options.MergeFrom(other.Options);
		}
		if (other.HasProto3Optional)
		{
			Proto3Optional = other.Proto3Optional;
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
			case 18u:
				Extendee = input.ReadString();
				break;
			case 24u:
				Number = input.ReadInt32();
				break;
			case 32u:
				Label = (Types.Label)input.ReadEnum();
				break;
			case 40u:
				Type = (Types.Type)input.ReadEnum();
				break;
			case 50u:
				TypeName = input.ReadString();
				break;
			case 58u:
				DefaultValue = input.ReadString();
				break;
			case 66u:
				if (options_ == null)
				{
					Options = new FieldOptions();
				}
				input.ReadMessage(Options);
				break;
			case 72u:
				OneofIndex = input.ReadInt32();
				break;
			case 82u:
				JsonName = input.ReadString();
				break;
			case 136u:
				Proto3Optional = input.ReadBool();
				break;
			}
		}
	}
}
