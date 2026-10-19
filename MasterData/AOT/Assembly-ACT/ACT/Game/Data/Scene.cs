using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Scene : IMessage<Scene>, IMessage, IEquatable<Scene>, IDeepCloneable<Scene>, IBufferMessage
{
	private static readonly MessageParser<Scene> _parser = new MessageParser<Scene>(() => new Scene());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CustomFlagsFieldNumber = 2;

	private static readonly MapField<int, MapCustomFlag>.Codec _map_customFlags_codec = new MapField<int, MapCustomFlag>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapCustomFlag.Parser), 18u);

	private readonly MapField<int, MapCustomFlag> customFlags_ = new MapField<int, MapCustomFlag>();

	public const int ResourcesFieldNumber = 3;

	private static readonly MapField<int, SceneResource>.Codec _map_resources_codec = new MapField<int, SceneResource>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, SceneResource.Parser), 26u);

	private readonly MapField<int, SceneResource> resources_ = new MapField<int, SceneResource>();

	public const int LightedMapBlocksFieldNumber = 4;

	private static readonly MapField<int, bool>.Codec _map_lightedMapBlocks_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 34u);

	private readonly MapField<int, bool> lightedMapBlocks_ = new MapField<int, bool>();

	public const int MapViewFieldNumber = 5;

	private MapViewInfo mapView_;

	public const int MapViewFullFieldNumber = 6;

	private MapViewFullInfo mapViewFull_;

	public const int DropPackagesFieldNumber = 7;

	private static readonly MapField<uint, DropPackage>.Codec _map_dropPackages_codec = new MapField<uint, DropPackage>.Codec(FieldCodec.ForUInt32(8u, 0u), FieldCodec.ForMessage(18u, DropPackage.Parser), 58u);

	private readonly MapField<uint, DropPackage> dropPackages_ = new MapField<uint, DropPackage>();

	public const int DropPackageIDSeqFieldNumber = 8;

	private uint dropPackageIDSeq_;

	public const int DropItemIDSeqFieldNumber = 9;

	private uint dropItemIDSeq_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Scene> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[201];

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
	public MapField<int, MapCustomFlag> CustomFlags => customFlags_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, SceneResource> Resources => resources_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> LightedMapBlocks => lightedMapBlocks_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewInfo MapView
	{
		get
		{
			return mapView_;
		}
		set
		{
			mapView_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewFullInfo MapViewFull
	{
		get
		{
			return mapViewFull_;
		}
		set
		{
			mapViewFull_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<uint, DropPackage> DropPackages => dropPackages_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public uint DropPackageIDSeq
	{
		get
		{
			return dropPackageIDSeq_;
		}
		set
		{
			dropPackageIDSeq_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public uint DropItemIDSeq
	{
		get
		{
			return dropItemIDSeq_;
		}
		set
		{
			dropItemIDSeq_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Scene()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Scene(Scene other)
		: this()
	{
		id_ = other.id_;
		customFlags_ = other.customFlags_.Clone();
		resources_ = other.resources_.Clone();
		lightedMapBlocks_ = other.lightedMapBlocks_.Clone();
		mapView_ = ((other.mapView_ != null) ? other.mapView_.Clone() : null);
		mapViewFull_ = ((other.mapViewFull_ != null) ? other.mapViewFull_.Clone() : null);
		dropPackages_ = other.dropPackages_.Clone();
		dropPackageIDSeq_ = other.dropPackageIDSeq_;
		dropItemIDSeq_ = other.dropItemIDSeq_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Scene Clone()
	{
		return new Scene(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Scene);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Scene other)
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
		if (!CustomFlags.Equals(other.CustomFlags))
		{
			return false;
		}
		if (!Resources.Equals(other.Resources))
		{
			return false;
		}
		if (!LightedMapBlocks.Equals(other.LightedMapBlocks))
		{
			return false;
		}
		if (!object.Equals(MapView, other.MapView))
		{
			return false;
		}
		if (!object.Equals(MapViewFull, other.MapViewFull))
		{
			return false;
		}
		if (!DropPackages.Equals(other.DropPackages))
		{
			return false;
		}
		if (DropPackageIDSeq != other.DropPackageIDSeq)
		{
			return false;
		}
		if (DropItemIDSeq != other.DropItemIDSeq)
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
		num ^= CustomFlags.GetHashCode();
		num ^= Resources.GetHashCode();
		num ^= LightedMapBlocks.GetHashCode();
		if (mapView_ != null)
		{
			num ^= MapView.GetHashCode();
		}
		if (mapViewFull_ != null)
		{
			num ^= MapViewFull.GetHashCode();
		}
		num ^= DropPackages.GetHashCode();
		if (DropPackageIDSeq != 0)
		{
			num ^= DropPackageIDSeq.GetHashCode();
		}
		if (DropItemIDSeq != 0)
		{
			num ^= DropItemIDSeq.GetHashCode();
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
		customFlags_.WriteTo(ref output, _map_customFlags_codec);
		resources_.WriteTo(ref output, _map_resources_codec);
		lightedMapBlocks_.WriteTo(ref output, _map_lightedMapBlocks_codec);
		if (mapView_ != null)
		{
			output.WriteRawTag(42);
			output.WriteMessage(MapView);
		}
		if (mapViewFull_ != null)
		{
			output.WriteRawTag(50);
			output.WriteMessage(MapViewFull);
		}
		dropPackages_.WriteTo(ref output, _map_dropPackages_codec);
		if (DropPackageIDSeq != 0)
		{
			output.WriteRawTag(64);
			output.WriteUInt32(DropPackageIDSeq);
		}
		if (DropItemIDSeq != 0)
		{
			output.WriteRawTag(72);
			output.WriteUInt32(DropItemIDSeq);
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
		num += customFlags_.CalculateSize(_map_customFlags_codec);
		num += resources_.CalculateSize(_map_resources_codec);
		num += lightedMapBlocks_.CalculateSize(_map_lightedMapBlocks_codec);
		if (mapView_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MapView);
		}
		if (mapViewFull_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MapViewFull);
		}
		num += dropPackages_.CalculateSize(_map_dropPackages_codec);
		if (DropPackageIDSeq != 0)
		{
			num += 1 + CodedOutputStream.ComputeUInt32Size(DropPackageIDSeq);
		}
		if (DropItemIDSeq != 0)
		{
			num += 1 + CodedOutputStream.ComputeUInt32Size(DropItemIDSeq);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Scene other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0)
		{
			Id = other.Id;
		}
		customFlags_.Add(other.customFlags_);
		resources_.Add(other.resources_);
		lightedMapBlocks_.Add(other.lightedMapBlocks_);
		if (other.mapView_ != null)
		{
			if (mapView_ == null)
			{
				MapView = new MapViewInfo();
			}
			MapView.MergeFrom(other.MapView);
		}
		if (other.mapViewFull_ != null)
		{
			if (mapViewFull_ == null)
			{
				MapViewFull = new MapViewFullInfo();
			}
			MapViewFull.MergeFrom(other.MapViewFull);
		}
		dropPackages_.Add(other.dropPackages_);
		if (other.DropPackageIDSeq != 0)
		{
			DropPackageIDSeq = other.DropPackageIDSeq;
		}
		if (other.DropItemIDSeq != 0)
		{
			DropItemIDSeq = other.DropItemIDSeq;
		}
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
			case 8u:
				Id = input.ReadInt32();
				break;
			case 18u:
				customFlags_.AddEntriesFrom(ref input, _map_customFlags_codec);
				break;
			case 26u:
				resources_.AddEntriesFrom(ref input, _map_resources_codec);
				break;
			case 34u:
				lightedMapBlocks_.AddEntriesFrom(ref input, _map_lightedMapBlocks_codec);
				break;
			case 42u:
				if (mapView_ == null)
				{
					MapView = new MapViewInfo();
				}
				input.ReadMessage(MapView);
				break;
			case 50u:
				if (mapViewFull_ == null)
				{
					MapViewFull = new MapViewFullInfo();
				}
				input.ReadMessage(MapViewFull);
				break;
			case 58u:
				dropPackages_.AddEntriesFrom(ref input, _map_dropPackages_codec);
				break;
			case 64u:
				DropPackageIDSeq = input.ReadUInt32();
				break;
			case 72u:
				DropItemIDSeq = input.ReadUInt32();
				break;
			}
		}
	}
}
