using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class ExtensionRangeOptions : IExtendableMessage<ExtensionRangeOptions>, IMessage<ExtensionRangeOptions>, IMessage, IEquatable<ExtensionRangeOptions>, IDeepCloneable<ExtensionRangeOptions>, IBufferMessage
{
	private static readonly MessageParser<ExtensionRangeOptions> _parser = new MessageParser<ExtensionRangeOptions>(() => new ExtensionRangeOptions());

	private UnknownFieldSet _unknownFields;

	internal ExtensionSet<ExtensionRangeOptions> _extensions;

	private static readonly FieldCodec<UninterpretedOption> _repeated_uninterpretedOption_codec = FieldCodec.ForMessage(7994u, UninterpretedOption.Parser);

	private readonly RepeatedField<UninterpretedOption> uninterpretedOption_ = new RepeatedField<UninterpretedOption>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<ExtensionRangeOptions> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[3];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ExtensionRangeOptions()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ExtensionRangeOptions(ExtensionRangeOptions other)
		: this()
	{
		uninterpretedOption_ = other.uninterpretedOption_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
		_extensions = ExtensionSet.Clone(other._extensions);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ExtensionRangeOptions Clone()
	{
		return new ExtensionRangeOptions(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ExtensionRangeOptions);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(ExtensionRangeOptions other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
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
	public void MergeFrom(ExtensionRangeOptions other)
	{
		if (other != null)
		{
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
			if (num != 7994)
			{
				if (!ExtensionSet.TryMergeFieldFrom(ref _extensions, ref input))
				{
					_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				}
			}
			else
			{
				uninterpretedOption_.AddEntriesFrom(ref input, _repeated_uninterpretedOption_codec);
			}
		}
	}

	public TValue GetExtension<TValue>(Extension<ExtensionRangeOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetExtension<TValue>(RepeatedExtension<ExtensionRangeOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetOrInitializeExtension<TValue>(RepeatedExtension<ExtensionRangeOptions, TValue> extension)
	{
		return ExtensionSet.GetOrInitialize(ref _extensions, extension);
	}

	public void SetExtension<TValue>(Extension<ExtensionRangeOptions, TValue> extension, TValue value)
	{
		ExtensionSet.Set(ref _extensions, extension, value);
	}

	public bool HasExtension<TValue>(Extension<ExtensionRangeOptions, TValue> extension)
	{
		return ExtensionSet.Has(ref _extensions, extension);
	}

	public void ClearExtension<TValue>(Extension<ExtensionRangeOptions, TValue> extension)
	{
		ExtensionSet.Clear(ref _extensions, extension);
	}
}
