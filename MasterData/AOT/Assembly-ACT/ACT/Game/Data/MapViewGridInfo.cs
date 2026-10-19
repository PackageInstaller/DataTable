using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapViewGridInfo : IMessage<MapViewGridInfo>, IMessage, IEquatable<MapViewGridInfo>, IDeepCloneable<MapViewGridInfo>, IBufferMessage
{
	private static readonly MessageParser<MapViewGridInfo> _parser = new MessageParser<MapViewGridInfo>(() => new MapViewGridInfo());

	private UnknownFieldSet _unknownFields;

	public const int GridInfoFieldNumber = 1;

	private static readonly MapField<string, PBVector2IntList>.Codec _map_gridInfo_codec = new MapField<string, PBVector2IntList>.Codec(FieldCodec.ForString(10u, ""), FieldCodec.ForMessage(18u, PBVector2IntList.Parser), 10u);

	private readonly MapField<string, PBVector2IntList> gridInfo_ = new MapField<string, PBVector2IntList>();

	public const int LayerIsCompleteFieldNumber = 2;

	private bool layerIsComplete_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapViewGridInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[198];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<string, PBVector2IntList> GridInfo => gridInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool LayerIsComplete
	{
		get
		{
			return layerIsComplete_;
		}
		set
		{
			layerIsComplete_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewGridInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewGridInfo(MapViewGridInfo other)
		: this()
	{
		gridInfo_ = other.gridInfo_.Clone();
		layerIsComplete_ = other.layerIsComplete_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewGridInfo Clone()
	{
		return new MapViewGridInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapViewGridInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapViewGridInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!GridInfo.Equals(other.GridInfo))
		{
			return false;
		}
		if (LayerIsComplete != other.LayerIsComplete)
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
		num ^= GridInfo.GetHashCode();
		if (LayerIsComplete)
		{
			num ^= LayerIsComplete.GetHashCode();
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
		gridInfo_.WriteTo(ref output, _map_gridInfo_codec);
		if (LayerIsComplete)
		{
			output.WriteRawTag(16);
			output.WriteBool(LayerIsComplete);
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
		num += gridInfo_.CalculateSize(_map_gridInfo_codec);
		if (LayerIsComplete)
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
	public void MergeFrom(MapViewGridInfo other)
	{
		if (other != null)
		{
			gridInfo_.Add(other.gridInfo_);
			if (other.LayerIsComplete)
			{
				LayerIsComplete = other.LayerIsComplete;
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
			case 10u:
				gridInfo_.AddEntriesFrom(ref input, _map_gridInfo_codec);
				break;
			case 16u:
				LayerIsComplete = input.ReadBool();
				break;
			}
		}
	}
}
