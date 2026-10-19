using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapSetupTracePointReq : IMessage<MapSetupTracePointReq>, IMessage, IEquatable<MapSetupTracePointReq>, IDeepCloneable<MapSetupTracePointReq>, IBufferMessage
{
	private static readonly MessageParser<MapSetupTracePointReq> _parser = new MessageParser<MapSetupTracePointReq>(() => new MapSetupTracePointReq());

	private UnknownFieldSet _unknownFields;

	public const int PointFieldNumber = 1;

	private MapTrancePoint point_;

	public const int CancelFieldNumber = 2;

	private bool cancel_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapSetupTracePointReq> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapTrancePoint Point
	{
		get
		{
			return point_;
		}
		set
		{
			point_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Cancel
	{
		get
		{
			return cancel_;
		}
		set
		{
			cancel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSetupTracePointReq()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSetupTracePointReq(MapSetupTracePointReq other)
		: this()
	{
		point_ = ((other.point_ != null) ? other.point_.Clone() : null);
		cancel_ = other.cancel_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapSetupTracePointReq Clone()
	{
		return new MapSetupTracePointReq(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapSetupTracePointReq);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapSetupTracePointReq other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(Point, other.Point))
		{
			return false;
		}
		if (Cancel != other.Cancel)
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
		if (point_ != null)
		{
			num ^= Point.GetHashCode();
		}
		if (Cancel)
		{
			num ^= Cancel.GetHashCode();
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
		if (point_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(Point);
		}
		if (Cancel)
		{
			output.WriteRawTag(16);
			output.WriteBool(Cancel);
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
		if (point_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Point);
		}
		if (Cancel)
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
	public void MergeFrom(MapSetupTracePointReq other)
	{
		if (other == null)
		{
			return;
		}
		if (other.point_ != null)
		{
			if (point_ == null)
			{
				Point = new MapTrancePoint();
			}
			Point.MergeFrom(other.Point);
		}
		if (other.Cancel)
		{
			Cancel = other.Cancel;
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
				if (point_ == null)
				{
					Point = new MapTrancePoint();
				}
				input.ReadMessage(Point);
				break;
			case 16u:
				Cancel = input.ReadBool();
				break;
			}
		}
	}
}
