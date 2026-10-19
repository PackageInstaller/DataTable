using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;

namespace Google.Protobuf.Reflection;

public sealed class MessageOptions : IExtendableMessage<MessageOptions>, IMessage<MessageOptions>, IMessage, IEquatable<MessageOptions>, IDeepCloneable<MessageOptions>, IBufferMessage
{
	private static readonly MessageParser<MessageOptions> _parser = new MessageParser<MessageOptions>(() => new MessageOptions());

	private UnknownFieldSet _unknownFields;

	internal ExtensionSet<MessageOptions> _extensions;

	private int _hasBits0;

	private static readonly bool MessageSetWireFormatDefaultValue = false;

	private bool messageSetWireFormat_;

	private static readonly bool NoStandardDescriptorAccessorDefaultValue = false;

	private bool noStandardDescriptorAccessor_;

	private static readonly bool DeprecatedDefaultValue = false;

	private bool deprecated_;

	private static readonly bool MapEntryDefaultValue = false;

	private bool mapEntry_;

	private static readonly FieldCodec<UninterpretedOption> _repeated_uninterpretedOption_codec = FieldCodec.ForMessage(7994u, UninterpretedOption.Parser);

	private readonly RepeatedField<UninterpretedOption> uninterpretedOption_ = new RepeatedField<UninterpretedOption>();

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageParser<MessageOptions> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => DescriptorReflection.Descriptor.MessageTypes[11];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool MessageSetWireFormat
	{
		get
		{
			if ((_hasBits0 & 1) != 0)
			{
				return messageSetWireFormat_;
			}
			return MessageSetWireFormatDefaultValue;
		}
		set
		{
			_hasBits0 |= 1;
			messageSetWireFormat_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasMessageSetWireFormat => (_hasBits0 & 1) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool NoStandardDescriptorAccessor
	{
		get
		{
			if ((_hasBits0 & 2) != 0)
			{
				return noStandardDescriptorAccessor_;
			}
			return NoStandardDescriptorAccessorDefaultValue;
		}
		set
		{
			_hasBits0 |= 2;
			noStandardDescriptorAccessor_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasNoStandardDescriptorAccessor => (_hasBits0 & 2) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	public bool MapEntry
	{
		get
		{
			if ((_hasBits0 & 8) != 0)
			{
				return mapEntry_;
			}
			return MapEntryDefaultValue;
		}
		set
		{
			_hasBits0 |= 8;
			mapEntry_ = value;
		}
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool HasMapEntry => (_hasBits0 & 8) != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageOptions()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MessageOptions(MessageOptions other)
		: this()
	{
		_hasBits0 = other._hasBits0;
		messageSetWireFormat_ = other.messageSetWireFormat_;
		noStandardDescriptorAccessor_ = other.noStandardDescriptorAccessor_;
		deprecated_ = other.deprecated_;
		mapEntry_ = other.mapEntry_;
		uninterpretedOption_ = other.uninterpretedOption_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
		_extensions = ExtensionSet.Clone(other._extensions);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public MessageOptions Clone()
	{
		return new MessageOptions(this);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MessageOptions);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(MessageOptions other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MessageSetWireFormat != other.MessageSetWireFormat)
		{
			return false;
		}
		if (NoStandardDescriptorAccessor != other.NoStandardDescriptorAccessor)
		{
			return false;
		}
		if (Deprecated != other.Deprecated)
		{
			return false;
		}
		if (MapEntry != other.MapEntry)
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
		if (HasMessageSetWireFormat)
		{
			num ^= MessageSetWireFormat.GetHashCode();
		}
		if (HasNoStandardDescriptorAccessor)
		{
			num ^= NoStandardDescriptorAccessor.GetHashCode();
		}
		if (HasDeprecated)
		{
			num ^= Deprecated.GetHashCode();
		}
		if (HasMapEntry)
		{
			num ^= MapEntry.GetHashCode();
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
		if (HasMessageSetWireFormat)
		{
			output.WriteRawTag(8);
			output.WriteBool(MessageSetWireFormat);
		}
		if (HasNoStandardDescriptorAccessor)
		{
			output.WriteRawTag(16);
			output.WriteBool(NoStandardDescriptorAccessor);
		}
		if (HasDeprecated)
		{
			output.WriteRawTag(24);
			output.WriteBool(Deprecated);
		}
		if (HasMapEntry)
		{
			output.WriteRawTag(56);
			output.WriteBool(MapEntry);
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
		if (HasMessageSetWireFormat)
		{
			num += 2;
		}
		if (HasNoStandardDescriptorAccessor)
		{
			num += 2;
		}
		if (HasDeprecated)
		{
			num += 2;
		}
		if (HasMapEntry)
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
	public void MergeFrom(MessageOptions other)
	{
		if (other != null)
		{
			if (other.HasMessageSetWireFormat)
			{
				MessageSetWireFormat = other.MessageSetWireFormat;
			}
			if (other.HasNoStandardDescriptorAccessor)
			{
				NoStandardDescriptorAccessor = other.NoStandardDescriptorAccessor;
			}
			if (other.HasDeprecated)
			{
				Deprecated = other.Deprecated;
			}
			if (other.HasMapEntry)
			{
				MapEntry = other.MapEntry;
			}
			uninterpretedOption_.Add(other.uninterpretedOption_);
			ExtensionSet.MergeFrom(ref _extensions, other._extensions);
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
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
			case 8u:
				MessageSetWireFormat = input.ReadBool();
				continue;
			case 16u:
				NoStandardDescriptorAccessor = input.ReadBool();
				continue;
			case 24u:
				Deprecated = input.ReadBool();
				continue;
			case 56u:
				MapEntry = input.ReadBool();
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

	public TValue GetExtension<TValue>(Extension<MessageOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetExtension<TValue>(RepeatedExtension<MessageOptions, TValue> extension)
	{
		return ExtensionSet.Get(ref _extensions, extension);
	}

	public RepeatedField<TValue> GetOrInitializeExtension<TValue>(RepeatedExtension<MessageOptions, TValue> extension)
	{
		return ExtensionSet.GetOrInitialize(ref _extensions, extension);
	}

	public void SetExtension<TValue>(Extension<MessageOptions, TValue> extension, TValue value)
	{
		ExtensionSet.Set(ref _extensions, extension, value);
	}

	public bool HasExtension<TValue>(Extension<MessageOptions, TValue> extension)
	{
		return ExtensionSet.Has(ref _extensions, extension);
	}

	public void ClearExtension<TValue>(Extension<MessageOptions, TValue> extension)
	{
		ExtensionSet.Clear(ref _extensions, extension);
	}
}
