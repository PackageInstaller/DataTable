using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapAreaExplore : IMessage<MapAreaExplore>, IMessage, IEquatable<MapAreaExplore>, IDeepCloneable<MapAreaExplore>, IBufferMessage
{
	private static readonly MessageParser<MapAreaExplore> _parser = new MessageParser<MapAreaExplore>(() => new MapAreaExplore());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SubAreaExploreFieldNumber = 2;

	private static readonly MapField<int, MapSubAreaExplore>.Codec _map_subAreaExplore_codec = new MapField<int, MapSubAreaExplore>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapSubAreaExplore.Parser), 18u);

	private readonly MapField<int, MapSubAreaExplore> subAreaExplore_ = new MapField<int, MapSubAreaExplore>();

	public const int TotalExploreFieldNumber = 3;

	private int totalExplore_;

	public const int ClaimedRewardFieldNumber = 4;

	private static readonly MapField<int, bool>.Codec _map_claimedReward_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 34u);

	private readonly MapField<int, bool> claimedReward_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapAreaExplore> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[94];

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
	public MapField<int, MapSubAreaExplore> SubAreaExplore => subAreaExplore_;

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
	public MapAreaExplore()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaExplore(MapAreaExplore other)
		: this()
	{
		id_ = other.id_;
		subAreaExplore_ = other.subAreaExplore_.Clone();
		totalExplore_ = other.totalExplore_;
		claimedReward_ = other.claimedReward_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapAreaExplore Clone()
	{
		return new MapAreaExplore(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapAreaExplore);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapAreaExplore other)
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
		if (!SubAreaExplore.Equals(other.SubAreaExplore))
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
		num ^= SubAreaExplore.GetHashCode();
		if (TotalExplore != 0)
		{
			num ^= TotalExplore.GetHashCode();
		}
		num ^= ClaimedReward.GetHashCode();
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
		subAreaExplore_.WriteTo(ref output, _map_subAreaExplore_codec);
		if (TotalExplore != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TotalExplore);
		}
		claimedReward_.WriteTo(ref output, _map_claimedReward_codec);
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
		num += subAreaExplore_.CalculateSize(_map_subAreaExplore_codec);
		if (TotalExplore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalExplore);
		}
		num += claimedReward_.CalculateSize(_map_claimedReward_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapAreaExplore other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			subAreaExplore_.Add(other.subAreaExplore_);
			if (other.TotalExplore != 0)
			{
				TotalExplore = other.TotalExplore;
			}
			claimedReward_.Add(other.claimedReward_);
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
				subAreaExplore_.AddEntriesFrom(ref input, _map_subAreaExplore_codec);
				break;
			case 24u:
				TotalExplore = input.ReadInt32();
				break;
			case 34u:
				claimedReward_.AddEntriesFrom(ref input, _map_claimedReward_codec);
				break;
			}
		}
	}
}
