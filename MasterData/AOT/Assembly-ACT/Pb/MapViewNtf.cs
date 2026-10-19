using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapViewNtf : IMessage<MapViewNtf>, IMessage, IEquatable<MapViewNtf>, IDeepCloneable<MapViewNtf>, IBufferMessage
{
	private static readonly MessageParser<MapViewNtf> _parser = new MessageParser<MapViewNtf>(() => new MapViewNtf());

	private UnknownFieldSet _unknownFields;

	public const int WidFieldNumber = 1;

	private int wid_;

	public const int MapViewFieldNumber = 2;

	private MapViewInfo mapView_;

	public const int MapViewFullFieldNumber = 3;

	private MapViewFullInfo mapViewFull_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapViewNtf> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[29];

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
	public MapViewNtf()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewNtf(MapViewNtf other)
		: this()
	{
		wid_ = other.wid_;
		mapView_ = ((other.mapView_ != null) ? other.mapView_.Clone() : null);
		mapViewFull_ = ((other.mapViewFull_ != null) ? other.mapViewFull_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewNtf Clone()
	{
		return new MapViewNtf(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapViewNtf);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapViewNtf other)
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
		if (!object.Equals(MapView, other.MapView))
		{
			return false;
		}
		if (!object.Equals(MapViewFull, other.MapViewFull))
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
		if (mapView_ != null)
		{
			num ^= MapView.GetHashCode();
		}
		if (mapViewFull_ != null)
		{
			num ^= MapViewFull.GetHashCode();
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
		if (Wid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Wid);
		}
		if (mapView_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(MapView);
		}
		if (mapViewFull_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(MapViewFull);
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
		if (Wid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Wid);
		}
		if (mapView_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MapView);
		}
		if (mapViewFull_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(MapViewFull);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapViewNtf other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Wid != 0)
		{
			Wid = other.Wid;
		}
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
				Wid = input.ReadInt32();
				break;
			case 18u:
				if (mapView_ == null)
				{
					MapView = new MapViewInfo();
				}
				input.ReadMessage(MapView);
				break;
			case 26u:
				if (mapViewFull_ == null)
				{
					MapViewFull = new MapViewFullInfo();
				}
				input.ReadMessage(MapViewFull);
				break;
			}
		}
	}
}
