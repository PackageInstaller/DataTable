using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapAreaExploreQueryAck : IMessage<MapAreaExploreQueryAck>, IMessage, IEquatable<MapAreaExploreQueryAck>, IDeepCloneable<MapAreaExploreQueryAck>, IBufferMessage
{
	private static readonly MessageParser<MapAreaExploreQueryAck> _parser = new MessageParser<MapAreaExploreQueryAck>(() => new MapAreaExploreQueryAck());

	private UnknownFieldSet _unknownFields;

	public const int AreaExploreFieldNumber = 1;

	private static readonly MapField<int, MapAreaExplore>.Codec _map_areaExplore_codec = new MapField<int, MapAreaExplore>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapAreaExplore.Parser), 10u);

	private readonly MapField<int, MapAreaExplore> areaExplore_ = new MapField<int, MapAreaExplore>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapAreaExploreQueryAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[19];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapAreaExplore> AreaExplore => areaExplore_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaExploreQueryAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaExploreQueryAck(MapAreaExploreQueryAck other)
		: this()
	{
		areaExplore_ = other.areaExplore_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaExploreQueryAck Clone()
	{
		return new MapAreaExploreQueryAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapAreaExploreQueryAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapAreaExploreQueryAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!AreaExplore.Equals(other.AreaExplore))
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
		num ^= AreaExplore.GetHashCode();
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
		areaExplore_.WriteTo(ref output, _map_areaExplore_codec);
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
		num += areaExplore_.CalculateSize(_map_areaExplore_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapAreaExploreQueryAck other)
	{
		if (other != null)
		{
			areaExplore_.Add(other.areaExplore_);
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
				areaExplore_.AddEntriesFrom(ref input, _map_areaExplore_codec);
			}
		}
	}
}
