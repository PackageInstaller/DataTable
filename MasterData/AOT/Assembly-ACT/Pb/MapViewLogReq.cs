using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapViewLogReq : IMessage<MapViewLogReq>, IMessage, IEquatable<MapViewLogReq>, IDeepCloneable<MapViewLogReq>, IBufferMessage
{
	private static readonly MessageParser<MapViewLogReq> _parser = new MessageParser<MapViewLogReq>(() => new MapViewLogReq());

	private UnknownFieldSet _unknownFields;

	public const int LayerFieldNumber = 1;

	private string layer_ = "";

	public const int PositionFieldNumber = 2;

	private PBVector2Int position_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapViewLogReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[25];

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
	public PBVector2Int Position
	{
		get
		{
			return position_;
		}
		set
		{
			position_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewLogReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewLogReq(MapViewLogReq other)
		: this()
	{
		layer_ = other.layer_;
		position_ = ((other.position_ != null) ? other.position_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapViewLogReq Clone()
	{
		return new MapViewLogReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapViewLogReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapViewLogReq other)
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
		if (!object.Equals(Position, other.Position))
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
		if (position_ != null)
		{
			num ^= Position.GetHashCode();
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
		if (position_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(Position);
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
		if (position_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Position);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapViewLogReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Layer.Length != 0)
		{
			Layer = other.Layer;
		}
		if (other.position_ != null)
		{
			if (position_ == null)
			{
				Position = new PBVector2Int();
			}
			Position.MergeFrom(other.Position);
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
			case 10u:
				Layer = input.ReadString();
				break;
			case 18u:
				if (position_ == null)
				{
					Position = new PBVector2Int();
				}
				input.ReadMessage(Position);
				break;
			}
		}
	}
}
