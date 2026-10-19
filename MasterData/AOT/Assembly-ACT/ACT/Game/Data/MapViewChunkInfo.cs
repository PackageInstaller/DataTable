using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapViewChunkInfo : IMessage<MapViewChunkInfo>, IMessage, IEquatable<MapViewChunkInfo>, IDeepCloneable<MapViewChunkInfo>, IBufferMessage
{
	private static readonly MessageParser<MapViewChunkInfo> _parser = new MessageParser<MapViewChunkInfo>(() => new MapViewChunkInfo());

	private UnknownFieldSet _unknownFields;

	public const int ChunkIDFieldNumber = 1;

	private int chunkID_;

	public const int GridsFieldNumber = 2;

	private static readonly MapField<string, PBVector2IntList>.Codec _map_grids_codec = new MapField<string, PBVector2IntList>.Codec(FieldCodec.ForString(10u, ""), FieldCodec.ForMessage(18u, PBVector2IntList.Parser), 18u);

	private readonly MapField<string, PBVector2IntList> grids_ = new MapField<string, PBVector2IntList>();

	public const int IsCompleteFieldNumber = 3;

	private bool isComplete_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapViewChunkInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[192];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ChunkID
	{
		get
		{
			return chunkID_;
		}
		set
		{
			chunkID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<string, PBVector2IntList> Grids => grids_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsComplete
	{
		get
		{
			return isComplete_;
		}
		set
		{
			isComplete_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewChunkInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewChunkInfo(MapViewChunkInfo other)
		: this()
	{
		chunkID_ = other.chunkID_;
		grids_ = other.grids_.Clone();
		isComplete_ = other.isComplete_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewChunkInfo Clone()
	{
		return new MapViewChunkInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapViewChunkInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapViewChunkInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ChunkID != other.ChunkID)
		{
			return false;
		}
		if (!Grids.Equals(other.Grids))
		{
			return false;
		}
		if (IsComplete != other.IsComplete)
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
		if (ChunkID != 0)
		{
			num ^= ChunkID.GetHashCode();
		}
		num ^= Grids.GetHashCode();
		if (IsComplete)
		{
			num ^= IsComplete.GetHashCode();
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
		if (ChunkID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ChunkID);
		}
		grids_.WriteTo(ref output, _map_grids_codec);
		if (IsComplete)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsComplete);
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
		if (ChunkID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkID);
		}
		num += grids_.CalculateSize(_map_grids_codec);
		if (IsComplete)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapViewChunkInfo other)
	{
		if (other != null)
		{
			if (other.ChunkID != 0)
			{
				ChunkID = other.ChunkID;
			}
			grids_.Add(other.grids_);
			if (other.IsComplete)
			{
				IsComplete = other.IsComplete;
			}
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
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				ChunkID = input.ReadInt32();
				break;
			case 18u:
				grids_.AddEntriesFrom(ref input, _map_grids_codec);
				break;
			case 24u:
				IsComplete = input.ReadBool();
				break;
			}
		}
	}
}
