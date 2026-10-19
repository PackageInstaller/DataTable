using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class Type : IMessage<Type>, IMessage, IEquatable<Type>, IDeepCloneable<Type>, IBufferMessage
{
	private static readonly MessageParser<Type> _parser = new MessageParser<Type>(() => new Type());

	private UnknownFieldSet _unknownFields;

	private string name_ = "";

	private static readonly FieldCodec<Field> _repeated_fields_codec = FieldCodec.ForMessage(18u, Field.Parser);

	private readonly RepeatedField<Field> fields_ = new RepeatedField<Field>();

	private static readonly FieldCodec<string> _repeated_oneofs_codec = FieldCodec.ForString(26u);

	private readonly RepeatedField<string> oneofs_ = new RepeatedField<string>();

	private static readonly FieldCodec<Option> _repeated_options_codec = FieldCodec.ForMessage(34u, Option.Parser);

	private readonly RepeatedField<Option> options_ = new RepeatedField<Option>();

	private SourceContext sourceContext_;

	private Syntax syntax_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Type> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => TypeReflection.Descriptor.MessageTypes[0];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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
	public Type()
	{
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public Type(Type other)
		: this()
	{
		name_ = other.name_;
		fields_ = other.fields_.Clone();
		oneofs_ = other.oneofs_.Clone();
		options_ = other.options_.Clone();
		sourceContext_ = ((other.sourceContext_ != null) ? other.sourceContext_.Clone() : null);
		syntax_ = other.syntax_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Type Clone()
	{
		return new Type(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Type);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Type other)
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
		if (!fields_.Equals(other.fields_))
		{
			return false;
		}
		if (!oneofs_.Equals(other.oneofs_))
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		num ^= fields_.GetHashCode();
		num ^= oneofs_.GetHashCode();
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Name);
		}
		fields_.WriteTo(ref output, _repeated_fields_codec);
		oneofs_.WriteTo(ref output, _repeated_oneofs_codec);
		options_.WriteTo(ref output, _repeated_options_codec);
		if (sourceContext_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(SourceContext);
		}
		if (Syntax != Syntax.Proto2)
		{
			output.WriteRawTag(48);
			output.WriteEnum((int)Syntax);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		num += fields_.CalculateSize(_repeated_fields_codec);
		num += oneofs_.CalculateSize(_repeated_oneofs_codec);
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(Type other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Name.Length != 0)
		{
			Name = other.Name;
		}
		fields_.Add(other.fields_);
		oneofs_.Add(other.oneofs_);
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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
				fields_.AddEntriesFrom(ref input, _repeated_fields_codec);
				break;
			case 26u:
				oneofs_.AddEntriesFrom(ref input, _repeated_oneofs_codec);
				break;
			case 34u:
				options_.AddEntriesFrom(ref input, _repeated_options_codec);
				break;
			case 42u:
				if (sourceContext_ == null)
				{
					SourceContext = new SourceContext();
				}
				input.ReadMessage(SourceContext);
				break;
			case 48u:
				Syntax = (Syntax)input.ReadEnum();
				break;
			}
		}
	}
}
