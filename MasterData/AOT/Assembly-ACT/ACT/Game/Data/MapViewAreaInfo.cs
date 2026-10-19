using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapViewAreaInfo : IMessage<MapViewAreaInfo>, IMessage, IEquatable<MapViewAreaInfo>, IDeepCloneable<MapViewAreaInfo>, IBufferMessage
{
	private static readonly MessageParser<MapViewAreaInfo> _parser = new MessageParser<MapViewAreaInfo>(() => new MapViewAreaInfo());

	private UnknownFieldSet _unknownFields;

	public const int AreaIDFieldNumber = 1;

	private int areaID_;

	public const int ChunksFieldNumber = 2;

	private static readonly MapField<int, MapViewChunkInfo>.Codec _map_chunks_codec = new MapField<int, MapViewChunkInfo>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapViewChunkInfo.Parser), 18u);

	private readonly MapField<int, MapViewChunkInfo> chunks_ = new MapField<int, MapViewChunkInfo>();

	public const int IsCompleteFieldNumber = 3;

	private bool isComplete_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapViewAreaInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[193];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int AreaID
	{
		get
		{
			return areaID_;
		}
		set
		{
			areaID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapViewChunkInfo> Chunks => chunks_;

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
	public MapViewAreaInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewAreaInfo(MapViewAreaInfo other)
		: this()
	{
		areaID_ = other.areaID_;
		chunks_ = other.chunks_.Clone();
		isComplete_ = other.isComplete_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewAreaInfo Clone()
	{
		return new MapViewAreaInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapViewAreaInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapViewAreaInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (AreaID != other.AreaID)
		{
			return false;
		}
		if (!Chunks.Equals(other.Chunks))
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
		if (AreaID != 0)
		{
			num ^= AreaID.GetHashCode();
		}
		num ^= Chunks.GetHashCode();
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
		if (AreaID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(AreaID);
		}
		chunks_.WriteTo(ref output, _map_chunks_codec);
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
		if (AreaID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaID);
		}
		num += chunks_.CalculateSize(_map_chunks_codec);
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
	public void MergeFrom(MapViewAreaInfo other)
	{
		if (other != null)
		{
			if (other.AreaID != 0)
			{
				AreaID = other.AreaID;
			}
			chunks_.Add(other.chunks_);
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
				AreaID = input.ReadInt32();
				break;
			case 18u:
				chunks_.AddEntriesFrom(ref input, _map_chunks_codec);
				break;
			case 24u:
				IsComplete = input.ReadBool();
				break;
			}
		}
	}
}
