using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class FieldOptions : IExtendableMessage<FieldOptions>, IMessage<FieldOptions>, IMessage, IEquatable<FieldOptions>, IDeepCloneable<FieldOptions>, IBufferMessage
{
	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static class Types
	{
		public enum CType
		{
			[OriginalName("STRING")]
			String,
			[OriginalName("CORD")]
			Cord,
			[OriginalName("STRING_PIECE")]
			StringPiece
		}

		public enum JSType
		{
			[OriginalName("JS_NORMAL")]
			JsNormal,
			[OriginalName("JS_STRING")]
			JsString,
			[OriginalName("JS_NUMBER")]
			JsNumber
		}
	}

	private static readonly MessageParser<FieldOptions> _parser = new MessageParser<FieldOptions>(() => new FieldOptions());

	private UnknownFieldSet _unknownFields;

	internal ExtensionSet<FieldOptions> _extensions;

	private int _hasBits0;

	private static readonly Types.CType CtypeDefaultValue = Types.CType.String;

	private Types.CType ctype_;

	private static readonly bool PackedDefaultValue = false;

	private bool packed_;

	private static readonly Types.JSType JstypeDefaultValue = Types.JSType.JsNormal;

	private Types.JSType jstype_;

	private static readonly bool LazyDefaultValue = false;

	private bool lazy_;

	private static readonly bool DeprecatedDefaultValue = false;

	private bool deprecated_;

	private static readonly bool WeakDefaultValue = false;

	private bool weak_;

	private static readonly FieldCodec<UninterpretedOption> _repeated_uninterpretedOption_codec = FieldCodec.ForMessage(7994u, UninterpretedOption.Parser);

	private readonly RepeatedField<UninterpretedOption> uninterpretedOption_ = new RepeatedField<UninterpretedOption>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<FieldOptions> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[12];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Types.CType Ctype
	{
		get
		{
			if ((_hasBits0 & 1) != 0)
			{
				return ctype_;
			}
			return CtypeDefaultValue;
		}
		set
		{
			_hasBits0 |= 1;
			ctype_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasCtype => (_hasBits0 & 1) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Packed
	{
		get
		{
			if ((_hasBits0 & 2) != 0)
			{
				return packed_;
			}
			return PackedDefaultValue;
		}
		set
		{
			_hasBits0 |= 2;
			packed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasPacked => (_hasBits0 & 2) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Types.JSType Jstype
	{
		get
		{
			if ((_hasBits0 & 0x10) != 0)
			{
				return jstype_;
			}
			return JstypeDefaultValue;
		}
		set
		{
			_hasBits0 |= 16;
			jstype_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasJstype => (_hasBits0 & 0x10) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Lazy
	{
		get
		{
			if ((_hasBits0 & 8) != 0)
			{
				return lazy_;
			}
			return LazyDefaultValue;
		}
		set
		{
			_hasBits0 |= 8;
			lazy_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasLazy => (_hasBits0 & 8) != 0;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Deprecated
	{
		get
		{
			if ((_hasBits0 & 4) != 0)
			{
				return deprecated_;
			}
			return DeprecatedDefaultValue;
		}
		set
		{
			_hasBits0 |= 4;
			deprecated_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasDeprecated => (_hasBits0 & 4) != 0;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Weak
	{
		get
		{
			if ((_hasBits0 & 0x20) != 0)
			{
				return weak_;
			}
			return WeakDefaultValue;
		}
		set
		{
			_hasBits0 |= 32;
			weak_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasWeak => (_hasBits0 & 0x20) != 0;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public FieldOptions()
	{
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public FieldOptions(FieldOptions other)
		: this()
	{
		_hasBits0 = other._hasBits0;
		ctype_ = other.ctype_;
		packed_ = other.packed_;
		jstype_ = other.jstype_;
		lazy_ = other.lazy_;
		deprecated_ = other.deprecated_;
		weak_ = other.weak_;
		uninterpretedOption_ = other.uninterpretedOption_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
		_extensions = ExtensionSet.Clone(other._extensions);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public FieldOptions Clone()
	{
		return new FieldOptions(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as FieldOptions);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(FieldOptions other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Ctype != other.Ctype)
		{
			return false;
		}
		if (Packed != other.Packed)
		{
			return false;
		}
		if (Jstype != other.Jstype)
		{
			return false;
		}
		if (Lazy != other.Lazy)
		{
			return false;
		}
		if (Deprecated != other.Deprecated)
		{
			return false;
		}
		if (Weak != other.Weak)
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (HasCtype)
		{
			num ^= Ctype.GetHashCode();
		}
		if (HasPacked)
		{
			num ^= Packed.GetHashCode();
		}
		if (HasJstype)
		{
			num ^= Jstype.GetHashCode();
		}
		if (HasLazy)
		{
			num ^= Lazy.GetHashCode();
		}
		if (HasDeprecated)
		{
			num ^= Deprecated.GetHashCode();
		}
		if (HasWeak)
		{
			num ^= Weak.GetHashCode();
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
		if (HasCtype)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)Ctype);
		}
		if (HasPacked)
		{
			output.WriteRawTag(16);
			output.WriteBool(Packed);
		}
		if (HasDeprecated)
		{
			output.WriteRawTag(24);
			output.WriteBool(Deprecated);
		}
		if (HasLazy)
		{
			output.WriteRawTag(40);
			output.WriteBool(Lazy);
		}
		if (HasJstype)
		{
			output.WriteRawTag(48);
			output.WriteEnum((int)Jstype);
		}
		if (HasWeak)
		{
			output.WriteRawTag(80);
			output.WriteBool(Weak);
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (HasCtype)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Ctype);
		}
		if (HasPacked)
		{
			num += 2;
		}
		if (HasJstype)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Jstype);
		}
		if (HasLazy)
		{
			num += 2;
		}
		if (HasDeprecated)
		{
			num += 2;
		}
		if (HasWeak)
		{
			num += 2;
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public void MergeFrom(FieldOptions other)
	{
		if (other != null)
		{
			if (other.HasCtype)
			{
				Ctype = other.Ctype;
			}
			if (other.HasPacked)
			{
				Packed = other.Packed;
			}
			if (other.HasJstype)
			{
				Jstype = other.Jstype;
			}
			if (other.HasLazy)
			{
				Lazy = other.Lazy;
			}
			if (other.HasDeprecated)
			{
				Deprecated = other.Deprecated;
			}
			if (other.HasWeak)
			{
				Weak = other.Weak;
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

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			case 8u:
				Ctype = (Types.CType)input.ReadEnum();
				continue;
			case 16u:
				Packed = input.ReadBool();
				continue;
			case 24u:
				Deprecated = input.ReadBool();
				continue;
			case 40u:
				Lazy = input.ReadBool();
				continue;
			case 48u:
				Jstype = (Types.JSType)input.ReadEnum();
				continue;
			case 80u:
				Weak = input.ReadBool();
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

	public TValue GetExtension<TValue>(Extension<FieldOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetExtension<TValue>(RepeatedExtension<FieldOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetOrInitializeExtension<TValue>(RepeatedExtension<FieldOptions, TValue> extension)
	{
		return ExtensionSet.GetOrInitialize(ref _extensions, extension);
	}

	public void SetExtension<TValue>(Extension<FieldOptions, TValue> extension, TValue value)
	{
		ExtensionSet.Set(ref _extensions, extension, value);
	}

	public bool HasExtension<TValue>(Extension<FieldOptions, TValue> extension)
	{
		return ExtensionSet.Has(ref _extensions, extension);
	}

	public void ClearExtension<TValue>(Extension<FieldOptions, TValue> extension)
	{
		ExtensionSet.Clear(ref _extensions, extension);
	}
}
