using System;
using System.CodeDom.Compiler;
using System.Diagnostics;

namespace Google.Protobuf.Reflection;

public sealed class MethodDescriptorProto : IMessage<MethodDescriptorProto>, IMessage, IEquatable<MethodDescriptorProto>, IDeepCloneable<MethodDescriptorProto>, IBufferMessage
{
	private static readonly MessageParser<MethodDescriptorProto> _parser = new MessageParser<MethodDescriptorProto>(() => new MethodDescriptorProto());

	private UnknownFieldSet _unknownFields;

	private int _hasBits0;

	private static readonly string NameDefaultValue = "";

	private string name_;

	private static readonly string InputTypeDefaultValue = "";

	private string inputType_;

	private static readonly string OutputTypeDefaultValue = "";

	private string outputType_;

	private MethodOptions options_;

	private static readonly bool ClientStreamingDefaultValue = false;

	private bool clientStreaming_;

	private static readonly bool ServerStreamingDefaultValue = false;

	private bool serverStreaming_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MethodDescriptorProto> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[9];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
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
	public string InputType
	{
		get
		{
			return inputType_ ?? InputTypeDefaultValue;
		}
		set
		{
			inputType_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasInputType => inputType_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string OutputType
	{
		get
		{
			return outputType_ ?? OutputTypeDefaultValue;
		}
		set
		{
			outputType_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasOutputType => outputType_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MethodOptions Options
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
	public bool ClientStreaming
	{
		get
		{
			if ((_hasBits0 & 1) != 0)
			{
				return clientStreaming_;
			}
			return ClientStreamingDefaultValue;
		}
		set
		{
			_hasBits0 |= 1;
			clientStreaming_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasClientStreaming => (_hasBits0 & 1) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool ServerStreaming
	{
		get
		{
			if ((_hasBits0 & 2) != 0)
			{
				return serverStreaming_;
			}
			return ServerStreamingDefaultValue;
		}
		set
		{
			_hasBits0 |= 2;
			serverStreaming_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasServerStreaming => (_hasBits0 & 2) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MethodDescriptorProto()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MethodDescriptorProto(MethodDescriptorProto other)
		: this()
	{
		_hasBits0 = other._hasBits0;
		name_ = other.name_;
		inputType_ = other.inputType_;
		outputType_ = other.outputType_;
		options_ = ((other.options_ != null) ? other.options_.Clone() : null);
		clientStreaming_ = other.clientStreaming_;
		serverStreaming_ = other.serverStreaming_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MethodDescriptorProto Clone()
	{
		return new MethodDescriptorProto(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MethodDescriptorProto);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MethodDescriptorProto other)
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
		if (InputType != other.InputType)
		{
			return false;
		}
		if (OutputType != other.OutputType)
		{
			return false;
		}
		if (!object.Equals(Options, other.Options))
		{
			return false;
		}
		if (ClientStreaming != other.ClientStreaming)
		{
			return false;
		}
		if (ServerStreaming != other.ServerStreaming)
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
		if (HasInputType)
		{
			num ^= InputType.GetHashCode();
		}
		if (HasOutputType)
		{
			num ^= OutputType.GetHashCode();
		}
		if (options_ != null)
		{
			num ^= Options.GetHashCode();
		}
		if (HasClientStreaming)
		{
			num ^= ClientStreaming.GetHashCode();
		}
		if (HasServerStreaming)
		{
			num ^= ServerStreaming.GetHashCode();
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
		if (HasInputType)
		{
			output.WriteRawTag(18);
			output.WriteString(InputType);
		}
		if (HasOutputType)
		{
			output.WriteRawTag(26);
			output.WriteString(OutputType);
		}
		if (options_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(Options);
		}
		if (HasClientStreaming)
		{
			output.WriteRawTag(40);
			output.WriteBool(ClientStreaming);
		}
		if (HasServerStreaming)
		{
			output.WriteRawTag(48);
			output.WriteBool(ServerStreaming);
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
		if (HasInputType)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(InputType);
		}
		if (HasOutputType)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OutputType);
		}
		if (options_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Options);
		}
		if (HasClientStreaming)
		{
			num += 2;
		}
		if (HasServerStreaming)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(MethodDescriptorProto other)
	{
		if (other == null)
		{
			return;
		}
		if (other.HasName)
		{
			Name = other.Name;
		}
		if (other.HasInputType)
		{
			InputType = other.InputType;
		}
		if (other.HasOutputType)
		{
			OutputType = other.OutputType;
		}
		if (other.options_ != null)
		{
			if (options_ == null)
			{
				Options = new MethodOptions();
			}
			Options.MergeFrom(other.Options);
		}
		if (other.HasClientStreaming)
		{
			ClientStreaming = other.ClientStreaming;
		}
		if (other.HasServerStreaming)
		{
			ServerStreaming = other.ServerStreaming;
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
				InputType = input.ReadString();
				break;
			case 26u:
				OutputType = input.ReadString();
				break;
			case 34u:
				if (options_ == null)
				{
					Options = new MethodOptions();
				}
				input.ReadMessage(Options);
				break;
			case 40u:
				ClientStreaming = input.ReadBool();
				break;
			case 48u:
				ServerStreaming = input.ReadBool();
				break;
			}
		}
	}
}
