using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapSubAreaExplore : IMessage<MapSubAreaExplore>, IMessage, IEquatable<MapSubAreaExplore>, IDeepCloneable<MapSubAreaExplore>, IBufferMessage
{
	private static readonly MessageParser<MapSubAreaExplore> _parser = new MessageParser<MapSubAreaExplore>(() => new MapSubAreaExplore());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupExploreFieldNumber = 2;

	private static readonly MapField<int, MapExploreGroupProgress>.Codec _map_groupExplore_codec = new MapField<int, MapExploreGroupProgress>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapExploreGroupProgress.Parser), 18u);

	private readonly MapField<int, MapExploreGroupProgress> groupExplore_ = new MapField<int, MapExploreGroupProgress>();

	public const int TotalExploreFieldNumber = 3;

	private int totalExplore_;

	public const int ClaimedRewardFieldNumber = 4;

	private static readonly MapField<int, bool>.Codec _map_claimedReward_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 34u);

	private readonly MapField<int, bool> claimedReward_ = new MapField<int, bool>();

	public const int ChunkExploreFieldNumber = 5;

	private static readonly MapField<int, MapChunkExplore>.Codec _map_chunkExplore_codec = new MapField<int, MapChunkExplore>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapChunkExplore.Parser), 42u);

	private readonly MapField<int, MapChunkExplore> chunkExplore_ = new MapField<int, MapChunkExplore>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapSubAreaExplore> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[92];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapExploreGroupProgress> GroupExplore => groupExplore_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TotalExplore
	{
		get
		{
			return totalExplore_;
		}
		set
		{
			totalExplore_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ClaimedReward => claimedReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapChunkExplore> ChunkExplore => chunkExplore_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSubAreaExplore()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSubAreaExplore(MapSubAreaExplore other)
		: this()
	{
		id_ = other.id_;
		groupExplore_ = other.groupExplore_.Clone();
		totalExplore_ = other.totalExplore_;
		claimedReward_ = other.claimedReward_.Clone();
		chunkExplore_ = other.chunkExplore_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSubAreaExplore Clone()
	{
		return new MapSubAreaExplore(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapSubAreaExplore);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapSubAreaExplore other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
		{
			return false;
		}
		if (!GroupExplore.Equals(other.GroupExplore))
		{
			return false;
		}
		if (TotalExplore != other.TotalExplore)
		{
			return false;
		}
		if (!ClaimedReward.Equals(other.ClaimedReward))
		{
			return false;
		}
		if (!ChunkExplore.Equals(other.ChunkExplore))
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		num ^= GroupExplore.GetHashCode();
		if (TotalExplore != 0)
		{
			num ^= TotalExplore.GetHashCode();
		}
		num ^= ClaimedReward.GetHashCode();
		num ^= ChunkExplore.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		groupExplore_.WriteTo(ref output, _map_groupExplore_codec);
		if (TotalExplore != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TotalExplore);
		}
		claimedReward_.WriteTo(ref output, _map_claimedReward_codec);
		chunkExplore_.WriteTo(ref output, _map_chunkExplore_codec);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		num += groupExplore_.CalculateSize(_map_groupExplore_codec);
		if (TotalExplore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalExplore);
		}
		num += claimedReward_.CalculateSize(_map_claimedReward_codec);
		num += chunkExplore_.CalculateSize(_map_chunkExplore_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapSubAreaExplore other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			groupExplore_.Add(other.groupExplore_);
			if (other.TotalExplore != 0)
			{
				TotalExplore = other.TotalExplore;
			}
			claimedReward_.Add(other.claimedReward_);
			chunkExplore_.Add(other.chunkExplore_);
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
				Id = input.ReadInt32();
				break;
			case 18u:
				groupExplore_.AddEntriesFrom(ref input, _map_groupExplore_codec);
				break;
			case 24u:
				TotalExplore = input.ReadInt32();
				break;
			case 34u:
				claimedReward_.AddEntriesFrom(ref input, _map_claimedReward_codec);
				break;
			case 42u:
				chunkExplore_.AddEntriesFrom(ref input, _map_chunkExplore_codec);
				break;
			}
		}
	}
}
