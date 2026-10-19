using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapChunkExplore : IMessage<MapChunkExplore>, IMessage, IEquatable<MapChunkExplore>, IDeepCloneable<MapChunkExplore>, IBufferMessage
{
	private static readonly MessageParser<MapChunkExplore> _parser = new MessageParser<MapChunkExplore>(() => new MapChunkExplore());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GroupExploreFieldNumber = 2;

	private static readonly MapField<int, MapExploreGroupProgress>.Codec _map_groupExplore_codec = new MapField<int, MapExploreGroupProgress>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapExploreGroupProgress.Parser), 18u);

	private readonly MapField<int, MapExploreGroupProgress> groupExplore_ = new MapField<int, MapExploreGroupProgress>();

	public const int TotalExploreFieldNumber = 3;

	private int totalExplore_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapChunkExplore> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[93];

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
	public MapChunkExplore()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapChunkExplore(MapChunkExplore other)
		: this()
	{
		id_ = other.id_;
		groupExplore_ = other.groupExplore_.Clone();
		totalExplore_ = other.totalExplore_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapChunkExplore Clone()
	{
		return new MapChunkExplore(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapChunkExplore);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapChunkExplore other)
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapChunkExplore other)
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
			}
		}
	}
}
