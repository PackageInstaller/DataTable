using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapViewCompleteLayerReq : IMessage<MapViewCompleteLayerReq>, IMessage, IEquatable<MapViewCompleteLayerReq>, IDeepCloneable<MapViewCompleteLayerReq>, IBufferMessage
{
	private static readonly MessageParser<MapViewCompleteLayerReq> _parser = new MessageParser<MapViewCompleteLayerReq>(() => new MapViewCompleteLayerReq());

	private UnknownFieldSet _unknownFields;

	public const int LayerFieldNumber = 1;

	private string layer_ = "";

	public const int AreaIDFieldNumber = 2;

	private int areaID_;

	public const int ChunkIDFieldNumber = 3;

	private int chunkID_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapViewCompleteLayerReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[27];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public string Layer
	{
		get
		{
			return layer_;
		}
		set
		{
			layer_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public MapViewCompleteLayerReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewCompleteLayerReq(MapViewCompleteLayerReq other)
		: this()
	{
		layer_ = other.layer_;
		areaID_ = other.areaID_;
		chunkID_ = other.chunkID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewCompleteLayerReq Clone()
	{
		return new MapViewCompleteLayerReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapViewCompleteLayerReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapViewCompleteLayerReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Layer != other.Layer)
		{
			return false;
		}
		if (AreaID != other.AreaID)
		{
			return false;
		}
		if (ChunkID != other.ChunkID)
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
		if (Layer.Length != 0)
		{
			num ^= Layer.GetHashCode();
		}
		if (AreaID != 0)
		{
			num ^= AreaID.GetHashCode();
		}
		if (ChunkID != 0)
		{
			num ^= ChunkID.GetHashCode();
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
		if (Layer.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Layer);
		}
		if (AreaID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AreaID);
		}
		if (ChunkID != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(ChunkID);
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
		if (Layer.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Layer);
		}
		if (AreaID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AreaID);
		}
		if (ChunkID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChunkID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapViewCompleteLayerReq other)
	{
		if (other != null)
		{
			if (other.Layer.Length != 0)
			{
				Layer = other.Layer;
			}
			if (other.AreaID != 0)
			{
				AreaID = other.AreaID;
			}
			if (other.ChunkID != 0)
			{
				ChunkID = other.ChunkID;
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
				Layer = input.ReadString();
				break;
			case 16u:
				AreaID = input.ReadInt32();
				break;
			case 24u:
				ChunkID = input.ReadInt32();
				break;
			}
		}
	}
}
