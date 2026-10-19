using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapModifyCustomFlagTypeAck : IMessage<MapModifyCustomFlagTypeAck>, IMessage, IEquatable<MapModifyCustomFlagTypeAck>, IDeepCloneable<MapModifyCustomFlagTypeAck>, IBufferMessage
{
	private static readonly MessageParser<MapModifyCustomFlagTypeAck> _parser = new MessageParser<MapModifyCustomFlagTypeAck>(() => new MapModifyCustomFlagTypeAck());

	private UnknownFieldSet _unknownFields;

	public const int LatestCustomFlagFieldNumber = 1;

	private MapCustomFlag latestCustomFlag_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapModifyCustomFlagTypeAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlag LatestCustomFlag
	{
		get
		{
			return latestCustomFlag_;
		}
		set
		{
			latestCustomFlag_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapModifyCustomFlagTypeAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapModifyCustomFlagTypeAck(MapModifyCustomFlagTypeAck other)
		: this()
	{
		latestCustomFlag_ = ((other.latestCustomFlag_ != null) ? other.latestCustomFlag_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapModifyCustomFlagTypeAck Clone()
	{
		return new MapModifyCustomFlagTypeAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapModifyCustomFlagTypeAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapModifyCustomFlagTypeAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(LatestCustomFlag, other.LatestCustomFlag))
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
		if (latestCustomFlag_ != null)
		{
			num ^= LatestCustomFlag.GetHashCode();
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
		if (latestCustomFlag_ != null)
		{
			output.WriteRawTag(10);
			output.WriteMessage(LatestCustomFlag);
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
		if (latestCustomFlag_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(LatestCustomFlag);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapModifyCustomFlagTypeAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.latestCustomFlag_ != null)
		{
			if (latestCustomFlag_ == null)
			{
				LatestCustomFlag = new MapCustomFlag();
			}
			LatestCustomFlag.MergeFrom(other.LatestCustomFlag);
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
			if (num != 10)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (latestCustomFlag_ == null)
			{
				LatestCustomFlag = new MapCustomFlag();
			}
			input.ReadMessage(LatestCustomFlag);
		}
	}
}
