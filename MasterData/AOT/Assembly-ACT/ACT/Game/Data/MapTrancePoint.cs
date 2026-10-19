using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class MapTrancePoint : IMessage<MapTrancePoint>, IMessage, IEquatable<MapTrancePoint>, IDeepCloneable<MapTrancePoint>, IBufferMessage
{
	private static readonly MessageParser<MapTrancePoint> _parser = new MessageParser<MapTrancePoint>(() => new MapTrancePoint());

	private UnknownFieldSet _unknownFields;

	public const int AreaIDFieldNumber = 1;

	private int areaID_;

	public const int PointIDFieldNumber = 2;

	private int pointID_;

	public const int PointTypeFieldNumber = 3;

	private MapTracePointEnum pointType_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapTrancePoint> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[90];

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
	public int PointID
	{
		get
		{
			return pointID_;
		}
		set
		{
			pointID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapTracePointEnum PointType
	{
		get
		{
			return pointType_;
		}
		set
		{
			pointType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapTrancePoint()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapTrancePoint(MapTrancePoint other)
		: this()
	{
		areaID_ = other.areaID_;
		pointID_ = other.pointID_;
		pointType_ = other.pointType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapTrancePoint Clone()
	{
		return new MapTrancePoint(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapTrancePoint);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapTrancePoint other)
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
		if (PointID != other.PointID)
		{
			return false;
		}
		if (PointType != other.PointType)
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
		if (PointID != 0)
		{
			num ^= PointID.GetHashCode();
		}
		if (PointType != MapTracePointEnum.MapTraceCustomPoint)
		{
			num ^= PointType.GetHashCode();
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
		if (PointID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PointID);
		}
		if (PointType != MapTracePointEnum.MapTraceCustomPoint)
		{
			output.WriteRawTag(24);
			output.WriteEnum((int)PointType);
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
		if (PointID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PointID);
		}
		if (PointType != MapTracePointEnum.MapTraceCustomPoint)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)PointType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapTrancePoint other)
	{
		if (other != null)
		{
			if (other.AreaID != 0)
			{
				AreaID = other.AreaID;
			}
			if (other.PointID != 0)
			{
				PointID = other.PointID;
			}
			if (other.PointType != MapTracePointEnum.MapTraceCustomPoint)
			{
				PointType = other.PointType;
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
			case 16u:
				PointID = input.ReadInt32();
				break;
			case 24u:
				PointType = (MapTracePointEnum)input.ReadEnum();
				break;
			}
		}
	}
}
