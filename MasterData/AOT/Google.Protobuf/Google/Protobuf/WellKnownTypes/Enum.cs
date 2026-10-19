using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class Enum : IMessage<Enum>, IMessage, IEquatable<Enum>, IDeepCloneable<Enum>, IBufferMessage
{
	private static readonly MessageParser<Enum> _parser = new MessageParser<Enum>(() => new Enum());

	private UnknownFieldSet _unknownFields;

	private string name_ = "";

	private static readonly FieldCodec<EnumValue> _repeated_enumvalue_codec = FieldCodec.ForMessage(18u, EnumValue.Parser);

	private readonly RepeatedField<EnumValue> enumvalue_ = new RepeatedField<EnumValue>();

	private static readonly FieldCodec<Option> _repeated_options_codec = FieldCodec.ForMessage(26u, Option.Parser);

	private readonly RepeatedField<Option> options_ = new RepeatedField<Option>();

	private SourceContext sourceContext_;

	private Syntax syntax_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Enum> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => TypeReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public SourceContext SourceContext
	{
		get
		{
			return sourceContext_;
		}
		set
		{
			sourceContext_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public Syntax Syntax
	{
		get
		{
			return syntax_;
		}
		set
		{
			syntax_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Enum()
	{
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public Enum(Enum other)
		: this()
	{
		name_ = other.name_;
		enumvalue_ = other.enumvalue_.Clone();
		options_ = other.options_.Clone();
		sourceContext_ = ((other.sourceContext_ != null) ? other.sourceContext_.Clone() : null);
		syntax_ = other.syntax_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public Enum Clone()
	{
		return new Enum(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Enum);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Enum other)
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
		if (!enumvalue_.Equals(other.enumvalue_))
		{
			return false;
		}
		if (!options_.Equals(other.options_))
		{
			return false;
		}
		if (!object.Equals(SourceContext, other.SourceContext))
		{
			return false;
		}
		if (Syntax != other.Syntax)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		num ^= enumvalue_.GetHashCode();
		num ^= options_.GetHashCode();
		if (sourceContext_ != null)
		{
			num ^= SourceContext.GetHashCode();
		}
		if (Syntax != Syntax.Proto2)
		{
			num ^= Syntax.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Name);
		}
		enumvalue_.WriteTo(ref output, _repeated_enumvalue_codec);
		options_.WriteTo(ref output, _repeated_options_codec);
		if (sourceContext_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(SourceContext);
		}
		if (Syntax != Syntax.Proto2)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)Syntax);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		num += enumvalue_.CalculateSize(_repeated_enumvalue_codec);
		num += options_.CalculateSize(_repeated_options_codec);
		if (sourceContext_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SourceContext);
		}
		if (Syntax != Syntax.Proto2)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Syntax);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Enum other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Name.Length != 0)
		{
			Name = other.Name;
		}
		enumvalue_.Add(other.enumvalue_);
		options_.Add(other.options_);
		if (other.sourceContext_ != null)
		{
			if (sourceContext_ == null)
			{
				SourceContext = new SourceContext();
			}
			SourceContext.MergeFrom(other.SourceContext);
		}
		if (other.Syntax != Syntax.Proto2)
		{
			Syntax = other.Syntax;
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
			case 10u:
				Name = input.ReadString();
				break;
			case 18u:
				enumvalue_.AddEntriesFrom(ref input, _repeated_enumvalue_codec);
				break;
			case 26u:
				options_.AddEntriesFrom(ref input, _repeated_options_codec);
				break;
			case 34u:
				if (sourceContext_ == null)
				{
					SourceContext = new SourceContext();
				}
				input.ReadMessage(SourceContext);
				break;
			case 40u:
				Syntax = (Syntax)input.ReadEnum();
				break;
			}
		}
	}
}
