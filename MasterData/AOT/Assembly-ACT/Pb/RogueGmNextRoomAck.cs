using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueGmNextRoomAck : IMessage<RogueGmNextRoomAck>, IMessage, IEquatable<RogueGmNextRoomAck>, IDeepCloneable<RogueGmNextRoomAck>, IBufferMessage
{
	private static readonly MessageParser<RogueGmNextRoomAck> _parser = new MessageParser<RogueGmNextRoomAck>(() => new RogueGmNextRoomAck());

	private UnknownFieldSet _unknownFields;

	public const int RoomInfoFieldNumber = 2;

	private RogueRoomInfo roomInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueGmNextRoomAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[34];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomInfo RoomInfo
	{
		get
		{
			return roomInfo_;
		}
		set
		{
			roomInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueGmNextRoomAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueGmNextRoomAck(RogueGmNextRoomAck other)
		: this()
	{
		roomInfo_ = ((other.roomInfo_ != null) ? other.roomInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueGmNextRoomAck Clone()
	{
		return new RogueGmNextRoomAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueGmNextRoomAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueGmNextRoomAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!object.Equals(RoomInfo, other.RoomInfo))
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
		if (roomInfo_ != null)
		{
			num ^= RoomInfo.GetHashCode();
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
		if (roomInfo_ != null)
		{
			output.WriteRawTag(18);
			output.WriteMessage(RoomInfo);
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
		if (roomInfo_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(RoomInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueGmNextRoomAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.roomInfo_ != null)
		{
			if (roomInfo_ == null)
			{
				RoomInfo = new RogueRoomInfo();
			}
			RoomInfo.MergeFrom(other.RoomInfo);
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
			if (num != 18)
			{
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				continue;
			}
			if (roomInfo_ == null)
			{
				RoomInfo = new RogueRoomInfo();
			}
			input.ReadMessage(RoomInfo);
		}
	}
}
