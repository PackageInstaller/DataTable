using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapViewRecordChunkParam : IMessage<MapViewRecordChunkParam>, IMessage, IEquatable<MapViewRecordChunkParam>, IDeepCloneable<MapViewRecordChunkParam>, IBufferMessage
{
	private static readonly MessageParser<MapViewRecordChunkParam> _parser = new MessageParser<MapViewRecordChunkParam>(() => new MapViewRecordChunkParam());

	private UnknownFieldSet _unknownFields;

	public const int ChunksFieldNumber = 1;

	private static readonly MapField<int, MapViewRecordPositionParam>.Codec _map_chunks_codec = new MapField<int, MapViewRecordPositionParam>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapViewRecordPositionParam.Parser), 10u);

	private readonly MapField<int, MapViewRecordPositionParam> chunks_ = new MapField<int, MapViewRecordPositionParam>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapViewRecordChunkParam> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[196];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapViewRecordPositionParam> Chunks => chunks_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewRecordChunkParam()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewRecordChunkParam(MapViewRecordChunkParam other)
		: this()
	{
		chunks_ = other.chunks_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewRecordChunkParam Clone()
	{
		return new MapViewRecordChunkParam(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapViewRecordChunkParam);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapViewRecordChunkParam other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Chunks.Equals(other.Chunks))
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
		num ^= Chunks.GetHashCode();
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
		chunks_.WriteTo(ref output, _map_chunks_codec);
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
		num += chunks_.CalculateSize(_map_chunks_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapViewRecordChunkParam other)
	{
		if (other != null)
		{
			chunks_.Add(other.chunks_);
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
				chunks_.AddEntriesFrom(ref input, _map_chunks_codec);
			}
		}
	}
}
