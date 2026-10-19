using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class ListValue : IMessage<ListValue>, IMessage, IEquatable<ListValue>, IDeepCloneable<ListValue>, IBufferMessage
{
	private static readonly MessageParser<ListValue> _parser = new MessageParser<ListValue>(() => new ListValue());

	private UnknownFieldSet _unknownFields;

	private static readonly FieldCodec<Value> _repeated_values_codec = FieldCodec.ForMessage(10u, Value.Parser);

	private readonly RepeatedField<Value> values_ = new RepeatedField<Value>();

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageParser<ListValue> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => StructReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ListValue()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ListValue(ListValue other)
		: this()
	{
		values_ = other.values_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ListValue Clone()
	{
		return new ListValue(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as ListValue);
	}

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public bool Equals(ListValue other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!values_.Equals(other.values_))
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
		num ^= values_.GetHashCode();
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
		values_.WriteTo(ref output, _repeated_values_codec);
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
		num += values_.CalculateSize(_repeated_values_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(ListValue other)
	{
		if (other != null)
		{
			values_.Add(other.values_);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				values_.AddEntriesFrom(ref input, _repeated_values_codec);
			}
		}
	}
}
