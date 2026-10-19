using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class MethodOptions : IExtendableMessage<MethodOptions>, IMessage<MethodOptions>, IMessage, IEquatable<MethodOptions>, IDeepCloneable<MethodOptions>, IBufferMessage
{
	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static class Types
	{
		public enum IdempotencyLevel
		{
			[OriginalName("IDEMPOTENCY_UNKNOWN")]
			IdempotencyUnknown,
			[OriginalName("NO_SIDE_EFFECTS")]
			NoSideEffects,
			[OriginalName("IDEMPOTENT")]
			Idempotent
		}
	}

	private static readonly MessageParser<MethodOptions> _parser = new MessageParser<MethodOptions>(() => new MethodOptions());

	private UnknownFieldSet _unknownFields;

	internal ExtensionSet<MethodOptions> _extensions;

	private int _hasBits0;

	private static readonly bool DeprecatedDefaultValue = false;

	private bool deprecated_;

	private static readonly Types.IdempotencyLevel IdempotencyLevelDefaultValue = Types.IdempotencyLevel.IdempotencyUnknown;

	private Types.IdempotencyLevel idempotencyLevel_;

	private static readonly FieldCodec<UninterpretedOption> _repeated_uninterpretedOption_codec = FieldCodec.ForMessage(7994u, UninterpretedOption.Parser);

	private readonly RepeatedField<UninterpretedOption> uninterpretedOption_ = new RepeatedField<UninterpretedOption>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MethodOptions> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[17];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Deprecated
	{
		get
		{
			if ((_hasBits0 & 1) != 0)
			{
				return deprecated_;
			}
			return DeprecatedDefaultValue;
		}
		set
		{
			_hasBits0 |= 1;
			deprecated_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasDeprecated => (_hasBits0 & 1) != 0;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public Types.IdempotencyLevel IdempotencyLevel
	{
		get
		{
			if ((_hasBits0 & 2) != 0)
			{
				return idempotencyLevel_;
			}
			return IdempotencyLevelDefaultValue;
		}
		set
		{
			_hasBits0 |= 2;
			idempotencyLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasIdempotencyLevel => (_hasBits0 & 2) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MethodOptions()
	{
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public MethodOptions(MethodOptions other)
		: this()
	{
		_hasBits0 = other._hasBits0;
		deprecated_ = other.deprecated_;
		idempotencyLevel_ = other.idempotencyLevel_;
		uninterpretedOption_ = other.uninterpretedOption_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
		_extensions = ExtensionSet.Clone(other._extensions);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MethodOptions Clone()
	{
		return new MethodOptions(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MethodOptions);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MethodOptions other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Deprecated != other.Deprecated)
		{
			return false;
		}
		if (IdempotencyLevel != other.IdempotencyLevel)
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
		if (HasDeprecated)
		{
			num ^= Deprecated.GetHashCode();
		}
		if (HasIdempotencyLevel)
		{
			num ^= IdempotencyLevel.GetHashCode();
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
		if (HasDeprecated)
		{
			output.WriteRawTag(136, 2);
			output.WriteBool(Deprecated);
		}
		if (HasIdempotencyLevel)
		{
			output.WriteRawTag(144, 2);
			output.WriteEnum((int)IdempotencyLevel);
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
		if (HasDeprecated)
		{
			num += 3;
		}
		if (HasIdempotencyLevel)
		{
			num += 2 + CodedOutputStream.ComputeEnumSize((int)IdempotencyLevel);
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
	public void MergeFrom(MethodOptions other)
	{
		if (other != null)
		{
			if (other.HasDeprecated)
			{
				Deprecated = other.Deprecated;
			}
			if (other.HasIdempotencyLevel)
			{
				IdempotencyLevel = other.IdempotencyLevel;
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
			case 264u:
				Deprecated = input.ReadBool();
				continue;
			case 272u:
				IdempotencyLevel = (Types.IdempotencyLevel)input.ReadEnum();
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

	public TValue GetExtension<TValue>(Extension<MethodOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetExtension<TValue>(RepeatedExtension<MethodOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetOrInitializeExtension<TValue>(RepeatedExtension<MethodOptions, TValue> extension)
	{
		return ExtensionSet.GetOrInitialize(ref _extensions, extension);
	}

	public void SetExtension<TValue>(Extension<MethodOptions, TValue> extension, TValue value)
	{
		ExtensionSet.Set(ref _extensions, extension, value);
	}

	public bool HasExtension<TValue>(Extension<MethodOptions, TValue> extension)
	{
		return ExtensionSet.Has(ref _extensions, extension);
	}

	public void ClearExtension<TValue>(Extension<MethodOptions, TValue> extension)
	{
		ExtensionSet.Clear(ref _extensions, extension);
	}
}
