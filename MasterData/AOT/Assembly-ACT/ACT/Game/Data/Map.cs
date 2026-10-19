using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Map : IMessage<Map>, IMessage, IEquatable<Map>, IDeepCloneable<Map>, IBufferMessage
{
	private static readonly MessageParser<Map> _parser = new MessageParser<Map>(() => new Map());

	private UnknownFieldSet _unknownFields;

	public const int WidFieldNumber = 1;

	private int wid_;

	public const int CustomFlagsFieldNumber = 2;

	private static readonly MapField<int, MapCustomFlag>.Codec _map_customFlags_codec = new MapField<int, MapCustomFlag>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, MapCustomFlag.Parser), 18u);

	private readonly MapField<int, MapCustomFlag> customFlags_ = new MapField<int, MapCustomFlag>();

	public const int ServiceSaveStateIdsFieldNumber = 3;

	private static readonly MapField<int, int>.Codec _map_serviceSaveStateIds_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 26u);

	private readonly MapField<int, int> serviceSaveStateIds_ = new MapField<int, int>();

	public const int ServiceBehaveIdsFieldNumber = 4;

	private static readonly MapField<int, int>.Codec _map_serviceBehaveIds_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 34u);

	private readonly MapField<int, int> serviceBehaveIds_ = new MapField<int, int>();

	public const int ServiceCleanedTsFieldNumber = 5;

	private static readonly MapField<int, int>.Codec _map_serviceCleanedTs_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 42u);

	private readonly MapField<int, int> serviceCleanedTs_ = new MapField<int, int>();

	public const int DropItemsFieldNumber = 6;

	private static readonly MapField<int, DropItem>.Codec _map_dropItems_codec = new MapField<int, DropItem>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, DropItem.Parser), 50u);

	private readonly MapField<int, DropItem> dropItems_ = new MapField<int, DropItem>();

	public const int LightedMapBlocksFieldNumber = 7;

	private static readonly MapField<int, bool>.Codec _map_lightedMapBlocks_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 58u);

	private readonly MapField<int, bool> lightedMapBlocks_ = new MapField<int, bool>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Map> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[83];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Wid
	{
		get
		{
			return wid_;
		}
		set
		{
			wid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, MapCustomFlag> CustomFlags => customFlags_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> ServiceSaveStateIds => serviceSaveStateIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> ServiceBehaveIds => serviceBehaveIds_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> ServiceCleanedTs => serviceCleanedTs_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, DropItem> DropItems => dropItems_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> LightedMapBlocks => lightedMapBlocks_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Map()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Map(Map other)
		: this()
	{
		wid_ = other.wid_;
		customFlags_ = other.customFlags_.Clone();
		serviceSaveStateIds_ = other.serviceSaveStateIds_.Clone();
		serviceBehaveIds_ = other.serviceBehaveIds_.Clone();
		serviceCleanedTs_ = other.serviceCleanedTs_.Clone();
		dropItems_ = other.dropItems_.Clone();
		lightedMapBlocks_ = other.lightedMapBlocks_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Map Clone()
	{
		return new Map(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Map);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Map other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Wid != other.Wid)
		{
			return false;
		}
		if (!CustomFlags.Equals(other.CustomFlags))
		{
			return false;
		}
		if (!ServiceSaveStateIds.Equals(other.ServiceSaveStateIds))
		{
			return false;
		}
		if (!ServiceBehaveIds.Equals(other.ServiceBehaveIds))
		{
			return false;
		}
		if (!ServiceCleanedTs.Equals(other.ServiceCleanedTs))
		{
			return false;
		}
		if (!DropItems.Equals(other.DropItems))
		{
			return false;
		}
		if (!LightedMapBlocks.Equals(other.LightedMapBlocks))
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
		if (Wid != 0)
		{
			num ^= Wid.GetHashCode();
		}
		num ^= CustomFlags.GetHashCode();
		num ^= ServiceSaveStateIds.GetHashCode();
		num ^= ServiceBehaveIds.GetHashCode();
		num ^= ServiceCleanedTs.GetHashCode();
		num ^= DropItems.GetHashCode();
		num ^= LightedMapBlocks.GetHashCode();
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
		if (Wid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Wid);
		}
		customFlags_.WriteTo(ref output, _map_customFlags_codec);
		serviceSaveStateIds_.WriteTo(ref output, _map_serviceSaveStateIds_codec);
		serviceBehaveIds_.WriteTo(ref output, _map_serviceBehaveIds_codec);
		serviceCleanedTs_.WriteTo(ref output, _map_serviceCleanedTs_codec);
		dropItems_.WriteTo(ref output, _map_dropItems_codec);
		lightedMapBlocks_.WriteTo(ref output, _map_lightedMapBlocks_codec);
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
		if (Wid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Wid);
		}
		num += customFlags_.CalculateSize(_map_customFlags_codec);
		num += serviceSaveStateIds_.CalculateSize(_map_serviceSaveStateIds_codec);
		num += serviceBehaveIds_.CalculateSize(_map_serviceBehaveIds_codec);
		num += serviceCleanedTs_.CalculateSize(_map_serviceCleanedTs_codec);
		num += dropItems_.CalculateSize(_map_dropItems_codec);
		num += lightedMapBlocks_.CalculateSize(_map_lightedMapBlocks_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Map other)
	{
		if (other != null)
		{
			if (other.Wid != 0)
			{
				Wid = other.Wid;
			}
			customFlags_.Add(other.customFlags_);
			serviceSaveStateIds_.Add(other.serviceSaveStateIds_);
			serviceBehaveIds_.Add(other.serviceBehaveIds_);
			serviceCleanedTs_.Add(other.serviceCleanedTs_);
			dropItems_.Add(other.dropItems_);
			lightedMapBlocks_.Add(other.lightedMapBlocks_);
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
				Wid = input.ReadInt32();
				break;
			case 18u:
				customFlags_.AddEntriesFrom(ref input, _map_customFlags_codec);
				break;
			case 26u:
				serviceSaveStateIds_.AddEntriesFrom(ref input, _map_serviceSaveStateIds_codec);
				break;
			case 34u:
				serviceBehaveIds_.AddEntriesFrom(ref input, _map_serviceBehaveIds_codec);
				break;
			case 42u:
				serviceCleanedTs_.AddEntriesFrom(ref input, _map_serviceCleanedTs_codec);
				break;
			case 50u:
				dropItems_.AddEntriesFrom(ref input, _map_dropItems_codec);
				break;
			case 58u:
				lightedMapBlocks_.AddEntriesFrom(ref input, _map_lightedMapBlocks_codec);
				break;
			}
		}
	}

	public bool transferIsActive(int transferUid)
	{
		ServiceSaveStateIds.TryGetValue(transferUid, out var value);
		return value == -2;
	}

	public bool lightHouseIsActive(int lightHouseUid)
	{
		ServiceSaveStateIds.TryGetValue(lightHouseUid, out var value);
		return value == -2;
	}
}
