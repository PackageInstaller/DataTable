using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapDbModel : IMessage<MapDbModel>, IMessage, IEquatable<MapDbModel>, IDeepCloneable<MapDbModel>, IBufferMessage
{
	private static readonly MessageParser<MapDbModel> _parser = new MessageParser<MapDbModel>(() => new MapDbModel());

	private UnknownFieldSet _unknownFields;

	public const int AreaFlagsFieldNumber = 1;

	private AreaMapCustomFlags areaFlags_;

	public const int MapTracePointFieldNumber = 2;

	private MapTrancePoint mapTracePoint_;

	public const int AreaDivinePupilsFieldNumber = 3;

	private AreaDivinePupils areaDivinePupils_;

	public const int AreaExploreClaimedRewardFieldNumber = 4;

	private static readonly MapField<int, MapExploreClaimedReward>.Codec _map_areaExploreClaimedReward_codec = new MapField<int, MapExploreClaimedReward>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapExploreClaimedReward.Parser), 34u);

	private readonly MapField<int, MapExploreClaimedReward> areaExploreClaimedReward_ = new MapField<int, MapExploreClaimedReward>();

	public const int SubAreaExploreClaimedRewardFieldNumber = 5;

	private static readonly MapField<int, MapExploreClaimedReward>.Codec _map_subAreaExploreClaimedReward_codec = new MapField<int, MapExploreClaimedReward>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapExploreClaimedReward.Parser), 42u);

	private readonly MapField<int, MapExploreClaimedReward> subAreaExploreClaimedReward_ = new MapField<int, MapExploreClaimedReward>();

	public const int UnlockedAreasFieldNumber = 6;

	private static readonly MapField<int, bool>.Codec _map_unlockedAreas_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 50u);

	private readonly MapField<int, bool> unlockedAreas_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapDbModel> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[84];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AreaMapCustomFlags AreaFlags
	{
		get
		{
			return areaFlags_;
		}
		set
		{
			areaFlags_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapTrancePoint MapTracePoint
	{
		get
		{
			return mapTracePoint_;
		}
		set
		{
			mapTracePoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AreaDivinePupils AreaDivinePupils
	{
		get
		{
			return areaDivinePupils_;
		}
		set
		{
			areaDivinePupils_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapExploreClaimedReward> AreaExploreClaimedReward => areaExploreClaimedReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapExploreClaimedReward> SubAreaExploreClaimedReward => subAreaExploreClaimedReward_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> UnlockedAreas => unlockedAreas_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapDbModel()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapDbModel(MapDbModel other)
		: this()
	{
		areaFlags_ = ((other.areaFlags_ != null) ? other.areaFlags_.Clone() : null);
		mapTracePoint_ = ((other.mapTracePoint_ != null) ? other.mapTracePoint_.Clone() : null);
		areaDivinePupils_ = ((other.areaDivinePupils_ != null) ? other.areaDivinePupils_.Clone() : null);
		areaExploreClaimedReward_ = other.areaExploreClaimedReward_.Clone();
		subAreaExploreClaimedReward_ = other.subAreaExploreClaimedReward_.Clone();
		unlockedAreas_ = other.unlockedAreas_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapDbModel Clone()
	{
		return new MapDbModel(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapDbModel);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapDbModel other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(AreaFlags, other.AreaFlags))
		{
			return false;
		}
		if (!object.Equals(MapTracePoint, other.MapTracePoint))
		{
			return false;
		}
		if (!object.Equals(AreaDivinePupils, other.AreaDivinePupils))
		{
			return false;
		}
		if (!AreaExploreClaimedReward.Equals(other.AreaExploreClaimedReward))
		{
			return false;
		}
		if (!SubAreaExploreClaimedReward.Equals(other.SubAreaExploreClaimedReward))
		{
			return false;
		}
		if (!UnlockedAreas.Equals(other.UnlockedAreas))
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
		if (areaFlags_ != null)
		{
			num ^= AreaFlags.GetHashCode();
		}
		if (mapTracePoint_ != null)
		{
			num ^= MapTracePoint.GetHashCode();
		}
		if (areaDivinePupils_ != null)
		{
			num ^= AreaDivinePupils.GetHashCode();
		}
		num ^= AreaExploreClaimedReward.GetHashCode();
		num ^= SubAreaExploreClaimedReward.GetHashCode();
		num ^= UnlockedAreas.GetHashCode();
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
		if (areaFlags_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(AreaFlags);
		}
		if (mapTracePoint_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(MapTracePoint);
		}
		if (areaDivinePupils_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(AreaDivinePupils);
		}
		areaExploreClaimedReward_.WriteTo(ref output, _map_areaExploreClaimedReward_codec);
		subAreaExploreClaimedReward_.WriteTo(ref output, _map_subAreaExploreClaimedReward_codec);
		unlockedAreas_.WriteTo(ref output, _map_unlockedAreas_codec);
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
		if (areaFlags_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AreaFlags);
		}
		if (mapTracePoint_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MapTracePoint);
		}
		if (areaDivinePupils_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(AreaDivinePupils);
		}
		num += areaExploreClaimedReward_.CalculateSize(_map_areaExploreClaimedReward_codec);
		num += subAreaExploreClaimedReward_.CalculateSize(_map_subAreaExploreClaimedReward_codec);
		num += unlockedAreas_.CalculateSize(_map_unlockedAreas_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapDbModel other)
	{
		if (other == null)
		{
			return;
		}
		if (other.areaFlags_ != null)
		{
			if (areaFlags_ == null)
			{
				AreaFlags = new AreaMapCustomFlags();
			}
			AreaFlags.MergeFrom(other.AreaFlags);
		}
		if (other.mapTracePoint_ != null)
		{
			if (mapTracePoint_ == null)
			{
				MapTracePoint = new MapTrancePoint();
			}
			MapTracePoint.MergeFrom(other.MapTracePoint);
		}
		if (other.areaDivinePupils_ != null)
		{
			if (areaDivinePupils_ == null)
			{
				AreaDivinePupils = new AreaDivinePupils();
			}
			AreaDivinePupils.MergeFrom(other.AreaDivinePupils);
		}
		areaExploreClaimedReward_.Add(other.areaExploreClaimedReward_);
		subAreaExploreClaimedReward_.Add(other.subAreaExploreClaimedReward_);
		unlockedAreas_.Add(other.unlockedAreas_);
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
			case 10u:
				if (areaFlags_ == null)
				{
					AreaFlags = new AreaMapCustomFlags();
				}
				input.ReadMessage(AreaFlags);
				break;
			case 18u:
				if (mapTracePoint_ == null)
				{
					MapTracePoint = new MapTrancePoint();
				}
				input.ReadMessage(MapTracePoint);
				break;
			case 26u:
				if (areaDivinePupils_ == null)
				{
					AreaDivinePupils = new AreaDivinePupils();
				}
				input.ReadMessage(AreaDivinePupils);
				break;
			case 34u:
				areaExploreClaimedReward_.AddEntriesFrom(ref input, _map_areaExploreClaimedReward_codec);
				break;
			case 42u:
				subAreaExploreClaimedReward_.AddEntriesFrom(ref input, _map_subAreaExploreClaimedReward_codec);
				break;
			case 50u:
				unlockedAreas_.AddEntriesFrom(ref input, _map_unlockedAreas_codec);
				break;
			}
		}
	}
}
