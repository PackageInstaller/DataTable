using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class FileOptions : IExtendableMessage<FileOptions>, IMessage<FileOptions>, IMessage, IEquatable<FileOptions>, IDeepCloneable<FileOptions>, IBufferMessage
{
	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static class Types
	{
		public enum OptimizeMode
		{
			[OriginalName("SPEED")]
			Speed = 1,
			[OriginalName("CODE_SIZE")]
			CodeSize,
			[OriginalName("LITE_RUNTIME")]
			LiteRuntime
		}
	}

	private static readonly MessageParser<FileOptions> _parser = new MessageParser<FileOptions>(() => new FileOptions());

	private UnknownFieldSet _unknownFields;

	internal ExtensionSet<FileOptions> _extensions;

	private int _hasBits0;

	private static readonly string JavaPackageDefaultValue = "";

	private string javaPackage_;

	private static readonly string JavaOuterClassnameDefaultValue = "";

	private string javaOuterClassname_;

	private static readonly bool JavaMultipleFilesDefaultValue = false;

	private bool javaMultipleFiles_;

	private static readonly bool JavaGenerateEqualsAndHashDefaultValue = false;

	private bool javaGenerateEqualsAndHash_;

	private static readonly bool JavaStringCheckUtf8DefaultValue = false;

	private bool javaStringCheckUtf8_;

	private static readonly Types.OptimizeMode OptimizeForDefaultValue = Types.OptimizeMode.Speed;

	private Types.OptimizeMode optimizeFor_;

	private static readonly string GoPackageDefaultValue = "";

	private string goPackage_;

	private static readonly bool CcGenericServicesDefaultValue = false;

	private bool ccGenericServices_;

	private static readonly bool JavaGenericServicesDefaultValue = false;

	private bool javaGenericServices_;

	private static readonly bool PyGenericServicesDefaultValue = false;

	private bool pyGenericServices_;

	private static readonly bool PhpGenericServicesDefaultValue = false;

	private bool phpGenericServices_;

	private static readonly bool DeprecatedDefaultValue = false;

	private bool deprecated_;

	private static readonly bool CcEnableArenasDefaultValue = true;

	private bool ccEnableArenas_;

	private static readonly string ObjcClassPrefixDefaultValue = "";

	private string objcClassPrefix_;

	private static readonly string CsharpNamespaceDefaultValue = "";

	private string csharpNamespace_;

	private static readonly string SwiftPrefixDefaultValue = "";

	private string swiftPrefix_;

	private static readonly string PhpClassPrefixDefaultValue = "";

	private string phpClassPrefix_;

	private static readonly string PhpNamespaceDefaultValue = "";

	private string phpNamespace_;

	private static readonly string PhpMetadataNamespaceDefaultValue = "";

	private string phpMetadataNamespace_;

	private static readonly string RubyPackageDefaultValue = "";

	private string rubyPackage_;

	private static readonly FieldCodec<UninterpretedOption> _repeated_uninterpretedOption_codec = FieldCodec.ForMessage(7994u, UninterpretedOption.Parser);

	private readonly RepeatedField<UninterpretedOption> uninterpretedOption_ = new RepeatedField<UninterpretedOption>();

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageParser<FileOptions> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[10];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string JavaPackage
	{
		get
		{
			return javaPackage_ ?? JavaPackageDefaultValue;
		}
		set
		{
			javaPackage_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasJavaPackage => javaPackage_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string JavaOuterClassname
	{
		get
		{
			return javaOuterClassname_ ?? JavaOuterClassnameDefaultValue;
		}
		set
		{
			javaOuterClassname_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasJavaOuterClassname => javaOuterClassname_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool JavaMultipleFiles
	{
		get
		{
			if ((_hasBits0 & 2) != 0)
			{
				return javaMultipleFiles_;
			}
			return JavaMultipleFilesDefaultValue;
		}
		set
		{
			_hasBits0 |= 2;
			javaMultipleFiles_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasJavaMultipleFiles => (_hasBits0 & 2) != 0;

	[Obsolete]
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool JavaGenerateEqualsAndHash
	{
		get
		{
			if ((_hasBits0 & 0x20) != 0)
			{
				return javaGenerateEqualsAndHash_;
			}
			return JavaGenerateEqualsAndHashDefaultValue;
		}
		set
		{
			_hasBits0 |= 32;
			javaGenerateEqualsAndHash_ = value;
		}
	}

	[Obsolete]
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasJavaGenerateEqualsAndHash => (_hasBits0 & 0x20) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool JavaStringCheckUtf8
	{
		get
		{
			if ((_hasBits0 & 0x80) != 0)
			{
				return javaStringCheckUtf8_;
			}
			return JavaStringCheckUtf8DefaultValue;
		}
		set
		{
			_hasBits0 |= 128;
			javaStringCheckUtf8_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasJavaStringCheckUtf8 => (_hasBits0 & 0x80) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Types.OptimizeMode OptimizeFor
	{
		get
		{
			if ((_hasBits0 & 1) != 0)
			{
				return optimizeFor_;
			}
			return OptimizeForDefaultValue;
		}
		set
		{
			_hasBits0 |= 1;
			optimizeFor_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasOptimizeFor => (_hasBits0 & 1) != 0;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string GoPackage
	{
		get
		{
			return goPackage_ ?? GoPackageDefaultValue;
		}
		set
		{
			goPackage_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasGoPackage => goPackage_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool CcGenericServices
	{
		get
		{
			if ((_hasBits0 & 4) != 0)
			{
				return ccGenericServices_;
			}
			return CcGenericServicesDefaultValue;
		}
		set
		{
			_hasBits0 |= 4;
			ccGenericServices_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasCcGenericServices => (_hasBits0 & 4) != 0;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool JavaGenericServices
	{
		get
		{
			if ((_hasBits0 & 8) != 0)
			{
				return javaGenericServices_;
			}
			return JavaGenericServicesDefaultValue;
		}
		set
		{
			_hasBits0 |= 8;
			javaGenericServices_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasJavaGenericServices => (_hasBits0 & 8) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool PyGenericServices
	{
		get
		{
			if ((_hasBits0 & 0x10) != 0)
			{
				return pyGenericServices_;
			}
			return PyGenericServicesDefaultValue;
		}
		set
		{
			_hasBits0 |= 16;
			pyGenericServices_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasPyGenericServices => (_hasBits0 & 0x10) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool PhpGenericServices
	{
		get
		{
			if ((_hasBits0 & 0x200) != 0)
			{
				return phpGenericServices_;
			}
			return PhpGenericServicesDefaultValue;
		}
		set
		{
			_hasBits0 |= 512;
			phpGenericServices_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasPhpGenericServices => (_hasBits0 & 0x200) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Deprecated
	{
		get
		{
			if ((_hasBits0 & 0x40) != 0)
			{
				return deprecated_;
			}
			return DeprecatedDefaultValue;
		}
		set
		{
			_hasBits0 |= 64;
			deprecated_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasDeprecated => (_hasBits0 & 0x40) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool CcEnableArenas
	{
		get
		{
			if ((_hasBits0 & 0x100) != 0)
			{
				return ccEnableArenas_;
			}
			return CcEnableArenasDefaultValue;
		}
		set
		{
			_hasBits0 |= 256;
			ccEnableArenas_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasCcEnableArenas => (_hasBits0 & 0x100) != 0;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string ObjcClassPrefix
	{
		get
		{
			return objcClassPrefix_ ?? ObjcClassPrefixDefaultValue;
		}
		set
		{
			objcClassPrefix_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasObjcClassPrefix => objcClassPrefix_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string CsharpNamespace
	{
		get
		{
			return csharpNamespace_ ?? CsharpNamespaceDefaultValue;
		}
		set
		{
			csharpNamespace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasCsharpNamespace => csharpNamespace_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string SwiftPrefix
	{
		get
		{
			return swiftPrefix_ ?? SwiftPrefixDefaultValue;
		}
		set
		{
			swiftPrefix_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasSwiftPrefix => swiftPrefix_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string PhpClassPrefix
	{
		get
		{
			return phpClassPrefix_ ?? PhpClassPrefixDefaultValue;
		}
		set
		{
			phpClassPrefix_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasPhpClassPrefix => phpClassPrefix_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string PhpNamespace
	{
		get
		{
			return phpNamespace_ ?? PhpNamespaceDefaultValue;
		}
		set
		{
			phpNamespace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasPhpNamespace => phpNamespace_ != null;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string PhpMetadataNamespace
	{
		get
		{
			return phpMetadataNamespace_ ?? PhpMetadataNamespaceDefaultValue;
		}
		set
		{
			phpMetadataNamespace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasPhpMetadataNamespace => phpMetadataNamespace_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public string RubyPackage
	{
		get
		{
			return rubyPackage_ ?? RubyPackageDefaultValue;
		}
		set
		{
			rubyPackage_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasRubyPackage => rubyPackage_ != null;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public FileOptions()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FileOptions(FileOptions other)
		: this()
	{
		_hasBits0 = other._hasBits0;
		javaPackage_ = other.javaPackage_;
		javaOuterClassname_ = other.javaOuterClassname_;
		javaMultipleFiles_ = other.javaMultipleFiles_;
		javaGenerateEqualsAndHash_ = other.javaGenerateEqualsAndHash_;
		javaStringCheckUtf8_ = other.javaStringCheckUtf8_;
		optimizeFor_ = other.optimizeFor_;
		goPackage_ = other.goPackage_;
		ccGenericServices_ = other.ccGenericServices_;
		javaGenericServices_ = other.javaGenericServices_;
		pyGenericServices_ = other.pyGenericServices_;
		phpGenericServices_ = other.phpGenericServices_;
		deprecated_ = other.deprecated_;
		ccEnableArenas_ = other.ccEnableArenas_;
		objcClassPrefix_ = other.objcClassPrefix_;
		csharpNamespace_ = other.csharpNamespace_;
		swiftPrefix_ = other.swiftPrefix_;
		phpClassPrefix_ = other.phpClassPrefix_;
		phpNamespace_ = other.phpNamespace_;
		phpMetadataNamespace_ = other.phpMetadataNamespace_;
		rubyPackage_ = other.rubyPackage_;
		uninterpretedOption_ = other.uninterpretedOption_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
		_extensions = ExtensionSet.Clone(other._extensions);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FileOptions Clone()
	{
		return new FileOptions(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FileOptions);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(FileOptions other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (JavaPackage != other.JavaPackage)
		{
			return false;
		}
		if (JavaOuterClassname != other.JavaOuterClassname)
		{
			return false;
		}
		if (JavaMultipleFiles != other.JavaMultipleFiles)
		{
			return false;
		}
		if (JavaGenerateEqualsAndHash != other.JavaGenerateEqualsAndHash)
		{
			return false;
		}
		if (JavaStringCheckUtf8 != other.JavaStringCheckUtf8)
		{
			return false;
		}
		if (OptimizeFor != other.OptimizeFor)
		{
			return false;
		}
		if (GoPackage != other.GoPackage)
		{
			return false;
		}
		if (CcGenericServices != other.CcGenericServices)
		{
			return false;
		}
		if (JavaGenericServices != other.JavaGenericServices)
		{
			return false;
		}
		if (PyGenericServices != other.PyGenericServices)
		{
			return false;
		}
		if (PhpGenericServices != other.PhpGenericServices)
		{
			return false;
		}
		if (Deprecated != other.Deprecated)
		{
			return false;
		}
		if (CcEnableArenas != other.CcEnableArenas)
		{
			return false;
		}
		if (ObjcClassPrefix != other.ObjcClassPrefix)
		{
			return false;
		}
		if (CsharpNamespace != other.CsharpNamespace)
		{
			return false;
		}
		if (SwiftPrefix != other.SwiftPrefix)
		{
			return false;
		}
		if (PhpClassPrefix != other.PhpClassPrefix)
		{
			return false;
		}
		if (PhpNamespace != other.PhpNamespace)
		{
			return false;
		}
		if (PhpMetadataNamespace != other.PhpMetadataNamespace)
		{
			return false;
		}
		if (RubyPackage != other.RubyPackage)
		{
			return false;
		}
		if (!uninterpretedOption_.Equals(other.uninterpretedOption_))
		{
			return false;
		}
		if (!object.Equals(_extensions, other._extensions))
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
		if (HasJavaPackage)
		{
			num ^= JavaPackage.GetHashCode();
		}
		if (HasJavaOuterClassname)
		{
			num ^= JavaOuterClassname.GetHashCode();
		}
		if (HasJavaMultipleFiles)
		{
			num ^= JavaMultipleFiles.GetHashCode();
		}
		if (HasJavaGenerateEqualsAndHash)
		{
			num ^= JavaGenerateEqualsAndHash.GetHashCode();
		}
		if (HasJavaStringCheckUtf8)
		{
			num ^= JavaStringCheckUtf8.GetHashCode();
		}
		if (HasOptimizeFor)
		{
			num ^= OptimizeFor.GetHashCode();
		}
		if (HasGoPackage)
		{
			num ^= GoPackage.GetHashCode();
		}
		if (HasCcGenericServices)
		{
			num ^= CcGenericServices.GetHashCode();
		}
		if (HasJavaGenericServices)
		{
			num ^= JavaGenericServices.GetHashCode();
		}
		if (HasPyGenericServices)
		{
			num ^= PyGenericServices.GetHashCode();
		}
		if (HasPhpGenericServices)
		{
			num ^= PhpGenericServices.GetHashCode();
		}
		if (HasDeprecated)
		{
			num ^= Deprecated.GetHashCode();
		}
		if (HasCcEnableArenas)
		{
			num ^= CcEnableArenas.GetHashCode();
		}
		if (HasObjcClassPrefix)
		{
			num ^= ObjcClassPrefix.GetHashCode();
		}
		if (HasCsharpNamespace)
		{
			num ^= CsharpNamespace.GetHashCode();
		}
		if (HasSwiftPrefix)
		{
			num ^= SwiftPrefix.GetHashCode();
		}
		if (HasPhpClassPrefix)
		{
			num ^= PhpClassPrefix.GetHashCode();
		}
		if (HasPhpNamespace)
		{
			num ^= PhpNamespace.GetHashCode();
		}
		if (HasPhpMetadataNamespace)
		{
			num ^= PhpMetadataNamespace.GetHashCode();
		}
		if (HasRubyPackage)
		{
			num ^= RubyPackage.GetHashCode();
		}
		num ^= uninterpretedOption_.GetHashCode();
		if (_extensions != null)
		{
			num ^= _extensions.GetHashCode();
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
		if (HasJavaPackage)
		{
			output.WriteRawTag(10);
			output.WriteString(JavaPackage);
		}
		if (HasJavaOuterClassname)
		{
			output.WriteRawTag(66);
			output.WriteString(JavaOuterClassname);
		}
		if (HasOptimizeFor)
		{
			output.WriteRawTag(72);
			output.WriteEnum((int)OptimizeFor);
		}
		if (HasJavaMultipleFiles)
		{
			output.WriteRawTag(80);
			output.WriteBool(JavaMultipleFiles);
		}
		if (HasGoPackage)
		{
			output.WriteRawTag(90);
			output.WriteString(GoPackage);
		}
		if (HasCcGenericServices)
		{
			output.WriteRawTag(128, 1);
			output.WriteBool(CcGenericServices);
		}
		if (HasJavaGenericServices)
		{
			output.WriteRawTag(136, 1);
			output.WriteBool(JavaGenericServices);
		}
		if (HasPyGenericServices)
		{
			output.WriteRawTag(144, 1);
			output.WriteBool(PyGenericServices);
		}
		if (HasJavaGenerateEqualsAndHash)
		{
			output.WriteRawTag(160, 1);
			output.WriteBool(JavaGenerateEqualsAndHash);
		}
		if (HasDeprecated)
		{
			output.WriteRawTag(184, 1);
			output.WriteBool(Deprecated);
		}
		if (HasJavaStringCheckUtf8)
		{
			output.WriteRawTag(216, 1);
			output.WriteBool(JavaStringCheckUtf8);
		}
		if (HasCcEnableArenas)
		{
			output.WriteRawTag(248, 1);
			output.WriteBool(CcEnableArenas);
		}
		if (HasObjcClassPrefix)
		{
			output.WriteRawTag(162, 2);
			output.WriteString(ObjcClassPrefix);
		}
		if (HasCsharpNamespace)
		{
			output.WriteRawTag(170, 2);
			output.WriteString(CsharpNamespace);
		}
		if (HasSwiftPrefix)
		{
			output.WriteRawTag(186, 2);
			output.WriteString(SwiftPrefix);
		}
		if (HasPhpClassPrefix)
		{
			output.WriteRawTag(194, 2);
			output.WriteString(PhpClassPrefix);
		}
		if (HasPhpNamespace)
		{
			output.WriteRawTag(202, 2);
			output.WriteString(PhpNamespace);
		}
		if (HasPhpGenericServices)
		{
			output.WriteRawTag(208, 2);
			output.WriteBool(PhpGenericServices);
		}
		if (HasPhpMetadataNamespace)
		{
			output.WriteRawTag(226, 2);
			output.WriteString(PhpMetadataNamespace);
		}
		if (HasRubyPackage)
		{
			output.WriteRawTag(234, 2);
			output.WriteString(RubyPackage);
		}
		uninterpretedOption_.WriteTo(ref output, _repeated_uninterpretedOption_codec);
		if (_extensions != null)
		{
			_extensions.WriteTo(ref output);
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
		if (HasJavaPackage)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(JavaPackage);
		}
		if (HasJavaOuterClassname)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(JavaOuterClassname);
		}
		if (HasJavaMultipleFiles)
		{
			num += 2;
		}
		if (HasJavaGenerateEqualsAndHash)
		{
			num += 3;
		}
		if (HasJavaStringCheckUtf8)
		{
			num += 3;
		}
		if (HasOptimizeFor)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)OptimizeFor);
		}
		if (HasGoPackage)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GoPackage);
		}
		if (HasCcGenericServices)
		{
			num += 3;
		}
		if (HasJavaGenericServices)
		{
			num += 3;
		}
		if (HasPyGenericServices)
		{
			num += 3;
		}
		if (HasPhpGenericServices)
		{
			num += 3;
		}
		if (HasDeprecated)
		{
			num += 3;
		}
		if (HasCcEnableArenas)
		{
			num += 3;
		}
		if (HasObjcClassPrefix)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ObjcClassPrefix);
		}
		if (HasCsharpNamespace)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CsharpNamespace);
		}
		if (HasSwiftPrefix)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SwiftPrefix);
		}
		if (HasPhpClassPrefix)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PhpClassPrefix);
		}
		if (HasPhpNamespace)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PhpNamespace);
		}
		if (HasPhpMetadataNamespace)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PhpMetadataNamespace);
		}
		if (HasRubyPackage)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RubyPackage);
		}
		num += uninterpretedOption_.CalculateSize(_repeated_uninterpretedOption_codec);
		if (_extensions != null)
		{
			num += _extensions.CalculateSize();
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(FileOptions other)
	{
		if (other != null)
		{
			if (other.HasJavaPackage)
			{
				JavaPackage = other.JavaPackage;
			}
			if (other.HasJavaOuterClassname)
			{
				JavaOuterClassname = other.JavaOuterClassname;
			}
			if (other.HasJavaMultipleFiles)
			{
				JavaMultipleFiles = other.JavaMultipleFiles;
			}
			if (other.HasJavaGenerateEqualsAndHash)
			{
				JavaGenerateEqualsAndHash = other.JavaGenerateEqualsAndHash;
			}
			if (other.HasJavaStringCheckUtf8)
			{
				JavaStringCheckUtf8 = other.JavaStringCheckUtf8;
			}
			if (other.HasOptimizeFor)
			{
				OptimizeFor = other.OptimizeFor;
			}
			if (other.HasGoPackage)
			{
				GoPackage = other.GoPackage;
			}
			if (other.HasCcGenericServices)
			{
				CcGenericServices = other.CcGenericServices;
			}
			if (other.HasJavaGenericServices)
			{
				JavaGenericServices = other.JavaGenericServices;
			}
			if (other.HasPyGenericServices)
			{
				PyGenericServices = other.PyGenericServices;
			}
			if (other.HasPhpGenericServices)
			{
				PhpGenericServices = other.PhpGenericServices;
			}
			if (other.HasDeprecated)
			{
				Deprecated = other.Deprecated;
			}
			if (other.HasCcEnableArenas)
			{
				CcEnableArenas = other.CcEnableArenas;
			}
			if (other.HasObjcClassPrefix)
			{
				ObjcClassPrefix = other.ObjcClassPrefix;
			}
			if (other.HasCsharpNamespace)
			{
				CsharpNamespace = other.CsharpNamespace;
			}
			if (other.HasSwiftPrefix)
			{
				SwiftPrefix = other.SwiftPrefix;
			}
			if (other.HasPhpClassPrefix)
			{
				PhpClassPrefix = other.PhpClassPrefix;
			}
			if (other.HasPhpNamespace)
			{
				PhpNamespace = other.PhpNamespace;
			}
			if (other.HasPhpMetadataNamespace)
			{
				PhpMetadataNamespace = other.PhpMetadataNamespace;
			}
			if (other.HasRubyPackage)
			{
				RubyPackage = other.RubyPackage;
			}
			uninterpretedOption_.Add(other.uninterpretedOption_);
			ExtensionSet.MergeFrom(ref _extensions, other._extensions);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
			case 10u:
				JavaPackage = input.ReadString();
				continue;
			case 66u:
				JavaOuterClassname = input.ReadString();
				continue;
			case 72u:
				OptimizeFor = (Types.OptimizeMode)input.ReadEnum();
				continue;
			case 80u:
				JavaMultipleFiles = input.ReadBool();
				continue;
			case 90u:
				GoPackage = input.ReadString();
				continue;
			case 128u:
				CcGenericServices = input.ReadBool();
				continue;
			case 136u:
				JavaGenericServices = input.ReadBool();
				continue;
			case 144u:
				PyGenericServices = input.ReadBool();
				continue;
			case 160u:
				JavaGenerateEqualsAndHash = input.ReadBool();
				continue;
			case 184u:
				Deprecated = input.ReadBool();
				continue;
			case 216u:
				JavaStringCheckUtf8 = input.ReadBool();
				continue;
			case 248u:
				CcEnableArenas = input.ReadBool();
				continue;
			case 290u:
				ObjcClassPrefix = input.ReadString();
				continue;
			case 298u:
				CsharpNamespace = input.ReadString();
				continue;
			case 314u:
				SwiftPrefix = input.ReadString();
				continue;
			case 322u:
				PhpClassPrefix = input.ReadString();
				continue;
			case 330u:
				PhpNamespace = input.ReadString();
				continue;
			case 336u:
				PhpGenericServices = input.ReadBool();
				continue;
			case 354u:
				PhpMetadataNamespace = input.ReadString();
				continue;
			case 362u:
				RubyPackage = input.ReadString();
				continue;
			case 7994u:
				uninterpretedOption_.AddEntriesFrom(ref input, _repeated_uninterpretedOption_codec);
				continue;
			}
			if (!ExtensionSet.TryMergeFieldFrom(ref _extensions, ref input))
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
		}
	}

	public TValue GetExtension<TValue>(Extension<FileOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetExtension<TValue>(RepeatedExtension<FileOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetOrInitializeExtension<TValue>(RepeatedExtension<FileOptions, TValue> extension)
	{
		return ExtensionSet.GetOrInitialize(ref _extensions, extension);
	}

	public void SetExtension<TValue>(Extension<FileOptions, TValue> extension, TValue value)
	{
		ExtensionSet.Set(ref _extensions, extension, value);
	}

	public bool HasExtension<TValue>(Extension<FileOptions, TValue> extension)
	{
		return ExtensionSet.Has(ref _extensions, extension);
	}

	public void ClearExtension<TValue>(Extension<FileOptions, TValue> extension)
	{
		ExtensionSet.Clear(ref _extensions, extension);
	}
}
