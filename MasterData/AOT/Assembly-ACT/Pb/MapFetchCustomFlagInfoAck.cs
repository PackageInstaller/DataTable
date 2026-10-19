using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class MapFetchCustomFlagInfoAck : IMessage<MapFetchCustomFlagInfoAck>, IMessage, IEquatable<MapFetchCustomFlagInfoAck>, IDeepCloneable<MapFetchCustomFlagInfoAck>, IBufferMessage
{
	private static readonly MessageParser<MapFetchCustomFlagInfoAck> _parser = new MessageParser<MapFetchCustomFlagInfoAck>(() => new MapFetchCustomFlagInfoAck());

	private UnknownFieldSet _unknownFields;

	public const int AreaFlagsFieldNumber = 1;

	private MapCustomFlags areaFlags_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<MapFetchCustomFlagInfoAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => MapReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapCustomFlags AreaFlags
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
	public MapFetchCustomFlagInfoAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapFetchCustomFlagInfoAck(MapFetchCustomFlagInfoAck other)
		: this()
	{
		areaFlags_ = ((other.areaFlags_ != null) ? other.areaFlags_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapFetchCustomFlagInfoAck Clone()
	{
		return new MapFetchCustomFlagInfoAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as MapFetchCustomFlagInfoAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(MapFetchCustomFlagInfoAck other)
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(MapFetchCustomFlagInfoAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.areaFlags_ != null)
		{
			if (areaFlags_ == null)
			{
				AreaFlags = new MapCustomFlags();
			}
			AreaFlags.MergeFrom(other.AreaFlags);
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
			if (areaFlags_ == null)
			{
				AreaFlags = new MapCustomFlags();
			}
			input.ReadMessage(AreaFlags);
		}
	}
}
