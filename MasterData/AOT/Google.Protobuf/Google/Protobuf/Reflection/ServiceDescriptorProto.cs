using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class ServiceDescriptorProto : IMessage<ServiceDescriptorProto>, IMessage, IEquatable<ServiceDescriptorProto>, IDeepCloneable<ServiceDescriptorProto>, IBufferMessage
{
	private static readonly MessageParser<ServiceDescriptorProto> _parser = new MessageParser<ServiceDescriptorProto>(() => new ServiceDescriptorProto());

	private UnknownFieldSet _unknownFields;

	private static readonly string NameDefaultValue = "";

	private string name_;

	private static readonly FieldCodec<MethodDescriptorProto> _repeated_method_codec = FieldCodec.ForMessage(18u, MethodDescriptorProto.Parser);

	private readonly RepeatedField<MethodDescriptorProto> method_ = new RepeatedField<MethodDescriptorProto>();

	private ServiceOptions options_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ServiceDescriptorProto> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasName => name_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public RepeatedField<MethodDescriptorProto> Method => method_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ServiceOptions Options
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
	public ServiceDescriptorProto()
	{
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public ServiceDescriptorProto(ServiceDescriptorProto other)
		: this()
	{
		name_ = other.name_;
		method_ = other.method_.Clone();
		options_ = ((other.options_ != null) ? other.options_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public ServiceDescriptorProto Clone()
	{
		return new ServiceDescriptorProto(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ServiceDescriptorProto);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(ServiceDescriptorProto other)
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
		if (!method_.Equals(other.method_))
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
		num ^= method_.GetHashCode();
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
		if (HasName)
		{
			output.WriteRawTag(10);
			output.WriteString(Name);
		}
		method_.WriteTo(ref output, _repeated_method_codec);
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
		num += method_.CalculateSize(_repeated_method_codec);
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
	public void MergeFrom(ServiceDescriptorProto other)
	{
		if (other == null)
		{
			return;
		}
		if (other.HasName)
		{
			Name = other.Name;
		}
		method_.Add(other.method_);
		if (other.options_ != null)
		{
			if (options_ == null)
			{
				Options = new ServiceOptions();
			}
			Options.MergeFrom(other.Options);
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
				method_.AddEntriesFrom(ref input, _repeated_method_codec);
				break;
			case 26u:
				if (options_ == null)
				{
					Options = new ServiceOptions();
				}
				input.ReadMessage(Options);
				break;
			}
		}
	}
}
