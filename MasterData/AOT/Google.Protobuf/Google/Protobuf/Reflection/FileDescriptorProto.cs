using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class FileDescriptorProto : IMessage<FileDescriptorProto>, IMessage, IEquatable<FileDescriptorProto>, IDeepCloneable<FileDescriptorProto>, IBufferMessage
{
	private static readonly MessageParser<FileDescriptorProto> _parser = new MessageParser<FileDescriptorProto>(() => new FileDescriptorProto());

	private UnknownFieldSet _unknownFields;

	private static readonly string NameDefaultValue = "";

	private string name_;

	private static readonly string PackageDefaultValue = "";

	private string package_;

	private static readonly FieldCodec<string> _repeated_dependency_codec = FieldCodec.ForString(26u);

	private readonly RepeatedField<string> dependency_ = new RepeatedField<string>();

	private static readonly FieldCodec<int> _repeated_publicDependency_codec = FieldCodec.ForInt32(80u);

	private readonly RepeatedField<int> publicDependency_ = new RepeatedField<int>();

	private static readonly FieldCodec<int> _repeated_weakDependency_codec = FieldCodec.ForInt32(88u);

	private readonly RepeatedField<int> weakDependency_ = new RepeatedField<int>();

	private static readonly FieldCodec<DescriptorProto> _repeated_messageType_codec = FieldCodec.ForMessage(34u, DescriptorProto.Parser);

	private readonly RepeatedField<DescriptorProto> messageType_ = new RepeatedField<DescriptorProto>();

	private static readonly FieldCodec<EnumDescriptorProto> _repeated_enumType_codec = FieldCodec.ForMessage(42u, EnumDescriptorProto.Parser);

	private readonly RepeatedField<EnumDescriptorProto> enumType_ = new RepeatedField<EnumDescriptorProto>();

	private static readonly FieldCodec<ServiceDescriptorProto> _repeated_service_codec = FieldCodec.ForMessage(50u, ServiceDescriptorProto.Parser);

	private readonly RepeatedField<ServiceDescriptorProto> service_ = new RepeatedField<ServiceDescriptorProto>();

	private static readonly FieldCodec<FieldDescriptorProto> _repeated_extension_codec = FieldCodec.ForMessage(58u, FieldDescriptorProto.Parser);

	private readonly RepeatedField<FieldDescriptorProto> extension_ = new RepeatedField<FieldDescriptorProto>();

	private FileOptions options_;

	private SourceCodeInfo sourceCodeInfo_;

	private static readonly string SyntaxDefaultValue = "";

	private string syntax_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<FileDescriptorProto> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[1];

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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasName => name_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Package
	{
		get
		{
			return package_ ?? PackageDefaultValue;
		}
		set
		{
			package_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasPackage => package_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<string> Dependency => dependency_;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public RepeatedField<int> PublicDependency => publicDependency_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<DescriptorProto> MessageType => messageType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<EnumDescriptorProto> EnumType => enumType_;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public RepeatedField<ServiceDescriptorProto> Service => service_;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public RepeatedField<FieldDescriptorProto> Extension => extension_;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public FileOptions Options
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
	public SourceCodeInfo SourceCodeInfo
	{
		get
		{
			return sourceCodeInfo_;
		}
		set
		{
			sourceCodeInfo_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string Syntax
	{
		get
		{
			return syntax_ ?? SyntaxDefaultValue;
		}
		set
		{
			syntax_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasSyntax => syntax_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FileDescriptorProto()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FileDescriptorProto(FileDescriptorProto other)
		: this()
	{
		name_ = other.name_;
		package_ = other.package_;
		dependency_ = other.dependency_.Clone();
		publicDependency_ = other.publicDependency_.Clone();
		weakDependency_ = other.weakDependency_.Clone();
		messageType_ = other.messageType_.Clone();
		enumType_ = other.enumType_.Clone();
		service_ = other.service_.Clone();
		extension_ = other.extension_.Clone();
		options_ = ((other.options_ != null) ? other.options_.Clone() : null);
		sourceCodeInfo_ = ((other.sourceCodeInfo_ != null) ? other.sourceCodeInfo_.Clone() : null);
		syntax_ = other.syntax_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FileDescriptorProto Clone()
	{
		return new FileDescriptorProto(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FileDescriptorProto);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(FileDescriptorProto other)
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
		if (Package != other.Package)
		{
			return false;
		}
		if (!dependency_.Equals(other.dependency_))
		{
			return false;
		}
		if (!publicDependency_.Equals(other.publicDependency_))
		{
			return false;
		}
		if (!weakDependency_.Equals(other.weakDependency_))
		{
			return false;
		}
		if (!messageType_.Equals(other.messageType_))
		{
			return false;
		}
		if (!enumType_.Equals(other.enumType_))
		{
			return false;
		}
		if (!service_.Equals(other.service_))
		{
			return false;
		}
		if (!extension_.Equals(other.extension_))
		{
			return false;
		}
		if (!object.Equals(Options, other.Options))
		{
			return false;
		}
		if (!object.Equals(SourceCodeInfo, other.SourceCodeInfo))
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
		if (HasName)
		{
			num ^= Name.GetHashCode();
		}
		if (HasPackage)
		{
			num ^= Package.GetHashCode();
		}
		num ^= dependency_.GetHashCode();
		num ^= publicDependency_.GetHashCode();
		num ^= weakDependency_.GetHashCode();
		num ^= messageType_.GetHashCode();
		num ^= enumType_.GetHashCode();
		num ^= service_.GetHashCode();
		num ^= extension_.GetHashCode();
		if (options_ != null)
		{
			num ^= Options.GetHashCode();
		}
		if (sourceCodeInfo_ != null)
		{
			num ^= SourceCodeInfo.GetHashCode();
		}
		if (HasSyntax)
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
		if (HasPackage)
		{
			output.WriteRawTag(18);
			output.WriteString(Package);
		}
		dependency_.WriteTo(ref output, _repeated_dependency_codec);
		messageType_.WriteTo(ref output, _repeated_messageType_codec);
		enumType_.WriteTo(ref output, _repeated_enumType_codec);
		service_.WriteTo(ref output, _repeated_service_codec);
		extension_.WriteTo(ref output, _repeated_extension_codec);
		if (options_ != null)
		{
			output.WriteRawTag(66);
			output.WriteMessage(Options);
		}
		if (sourceCodeInfo_ != null)
		{
			output.WriteRawTag(74);
			output.WriteMessage(SourceCodeInfo);
		}
		publicDependency_.WriteTo(ref output, _repeated_publicDependency_codec);
		weakDependency_.WriteTo(ref output, _repeated_weakDependency_codec);
		if (HasSyntax)
		{
			output.WriteRawTag(98);
			output.WriteString(Syntax);
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
		if (HasPackage)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Package);
		}
		num += dependency_.CalculateSize(_repeated_dependency_codec);
		num += publicDependency_.CalculateSize(_repeated_publicDependency_codec);
		num += weakDependency_.CalculateSize(_repeated_weakDependency_codec);
		num += messageType_.CalculateSize(_repeated_messageType_codec);
		num += enumType_.CalculateSize(_repeated_enumType_codec);
		num += service_.CalculateSize(_repeated_service_codec);
		num += extension_.CalculateSize(_repeated_extension_codec);
		if (options_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Options);
		}
		if (sourceCodeInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SourceCodeInfo);
		}
		if (HasSyntax)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Syntax);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(FileDescriptorProto other)
	{
		if (other == null)
		{
			return;
		}
		if (other.HasName)
		{
			Name = other.Name;
		}
		if (other.HasPackage)
		{
			Package = other.Package;
		}
		dependency_.Add(other.dependency_);
		publicDependency_.Add(other.publicDependency_);
		weakDependency_.Add(other.weakDependency_);
		messageType_.Add(other.messageType_);
		enumType_.Add(other.enumType_);
		service_.Add(other.service_);
		extension_.Add(other.extension_);
		if (other.options_ != null)
		{
			if (options_ == null)
			{
				Options = new FileOptions();
			}
			Options.MergeFrom(other.Options);
		}
		if (other.sourceCodeInfo_ != null)
		{
			if (sourceCodeInfo_ == null)
			{
				SourceCodeInfo = new SourceCodeInfo();
			}
			SourceCodeInfo.MergeFrom(other.SourceCodeInfo);
		}
		if (other.HasSyntax)
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
				Package = input.ReadString();
				break;
			case 26u:
				dependency_.AddEntriesFrom(ref input, _repeated_dependency_codec);
				break;
			case 34u:
				messageType_.AddEntriesFrom(ref input, _repeated_messageType_codec);
				break;
			case 42u:
				enumType_.AddEntriesFrom(ref input, _repeated_enumType_codec);
				break;
			case 50u:
				service_.AddEntriesFrom(ref input, _repeated_service_codec);
				break;
			case 58u:
				extension_.AddEntriesFrom(ref input, _repeated_extension_codec);
				break;
			case 66u:
				if (options_ == null)
				{
					Options = new FileOptions();
				}
				input.ReadMessage(Options);
				break;
			case 74u:
				if (sourceCodeInfo_ == null)
				{
					SourceCodeInfo = new SourceCodeInfo();
				}
				input.ReadMessage(SourceCodeInfo);
				break;
			case 80u:
			case 82u:
				publicDependency_.AddEntriesFrom(ref input, _repeated_publicDependency_codec);
				break;
			case 88u:
			case 90u:
				weakDependency_.AddEntriesFrom(ref input, _repeated_weakDependency_codec);
				break;
			case 98u:
				Syntax = input.ReadString();
				break;
			}
		}
	}
}
