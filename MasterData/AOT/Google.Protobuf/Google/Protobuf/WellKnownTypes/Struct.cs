using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Google.Protobuf.WellKnownTypes;

public sealed class Struct : IMessage<Struct>, IMessage, IEquatable<Struct>, IDeepCloneable<Struct>, IBufferMessage
{
	private static readonly MessageParser<Struct> _parser = new MessageParser<Struct>(() => new Struct());

	private UnknownFieldSet _unknownFields;

	private static readonly MapField<string, Value>.Codec _map_fields_codec = new MapField<string, Value>.Codec(FieldCodec.ForString(10u, ""), FieldCodec.ForMessage(18u, Value.Parser), 10u);

	private readonly MapField<string, Value> fields_ = new MapField<string, Value>();

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageParser<Struct> Parser => _parser;

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => StructReflection.Descriptor.MessageTypes[0];

	[GeneratedCode("protoc", null)]
	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<string, Value> Fields => fields_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Struct()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Struct(Struct other)
		: this()
	{
		fields_ = other.fields_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Struct Clone()
	{
		return new Struct(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Struct);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Struct other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Fields.Equals(other.Fields))
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
		num ^= Fields.GetHashCode();
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
		fields_.WriteTo(ref output, _map_fields_codec);
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
		num += fields_.CalculateSize(_map_fields_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Struct other)
	{
		if (other != null)
		{
			fields_.Add(other.fields_);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
			}
			else
			{
				fields_.AddEntriesFrom(ref input, _map_fields_codec);
			}
		}
	}
}
