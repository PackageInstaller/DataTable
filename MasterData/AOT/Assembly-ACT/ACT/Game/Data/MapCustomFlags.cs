using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapCustomFlags : IMessage<MapCustomFlags>, IMessage, IEquatable<MapCustomFlags>, IDeepCloneable<MapCustomFlags>, IBufferMessage
{
	private static readonly MessageParser<MapCustomFlags> _parser = new MessageParser<MapCustomFlags>(() => new MapCustomFlags());

	private UnknownFieldSet _unknownFields;

	public const int FlagsFieldNumber = 1;

	private static readonly MapField<int, MapCustomFlag>.Codec _map_flags_codec = new MapField<int, MapCustomFlag>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapCustomFlag.Parser), 10u);

	private readonly MapField<int, MapCustomFlag> flags_ = new MapField<int, MapCustomFlag>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapCustomFlags> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[87];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapCustomFlag> Flags => flags_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlags()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlags(MapCustomFlags other)
		: this()
	{
		flags_ = other.flags_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlags Clone()
	{
		return new MapCustomFlags(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapCustomFlags);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapCustomFlags other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Flags.Equals(other.Flags))
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
		num ^= Flags.GetHashCode();
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
		flags_.WriteTo(ref output, _map_flags_codec);
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
		num += flags_.CalculateSize(_map_flags_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapCustomFlags other)
	{
		if (other != null)
		{
			flags_.Add(other.flags_);
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
				flags_.AddEntriesFrom(ref input, _map_flags_codec);
			}
		}
	}
}
