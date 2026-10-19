using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapCustomFlagNtf : IMessage<MapCustomFlagNtf>, IMessage, IEquatable<MapCustomFlagNtf>, IDeepCloneable<MapCustomFlagNtf>, IBufferMessage
{
	private static readonly MessageParser<MapCustomFlagNtf> _parser = new MessageParser<MapCustomFlagNtf>(() => new MapCustomFlagNtf());

	private UnknownFieldSet _unknownFields;

	public const int AreaFlagsFieldNumber = 1;

	private static readonly MapField<int, MapCustomFlags>.Codec _map_areaFlags_codec = new MapField<int, MapCustomFlags>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapCustomFlags.Parser), 10u);

	private readonly MapField<int, MapCustomFlags> areaFlags_ = new MapField<int, MapCustomFlags>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapCustomFlagNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapCustomFlags> AreaFlags => areaFlags_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlagNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlagNtf(MapCustomFlagNtf other)
		: this()
	{
		areaFlags_ = other.areaFlags_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlagNtf Clone()
	{
		return new MapCustomFlagNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapCustomFlagNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapCustomFlagNtf other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!AreaFlags.Equals(other.AreaFlags))
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
		num ^= AreaFlags.GetHashCode();
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
		areaFlags_.WriteTo(ref output, _map_areaFlags_codec);
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
		num += areaFlags_.CalculateSize(_map_areaFlags_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapCustomFlagNtf other)
	{
		if (other != null)
		{
			areaFlags_.Add(other.areaFlags_);
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
				areaFlags_.AddEntriesFrom(ref input, _map_areaFlags_codec);
			}
		}
	}
}
