using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RogueRoomRecord : IMessage<RogueRoomRecord>, IMessage, IEquatable<RogueRoomRecord>, IDeepCloneable<RogueRoomRecord>, IBufferMessage
{
	private static readonly MessageParser<RogueRoomRecord> _parser = new MessageParser<RogueRoomRecord>(() => new RogueRoomRecord());

	private UnknownFieldSet _unknownFields;

	public const int RoomTypeFieldNumber = 1;

	private RogueRoomType roomType_;

	public const int GameWorldIdFieldNumber = 2;

	private int gameWorldId_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueRoomRecord> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[235];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomType RoomType
	{
		get
		{
			return roomType_;
		}
		set
		{
			roomType_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int GameWorldId
	{
		get
		{
			return gameWorldId_;
		}
		set
		{
			gameWorldId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomRecord()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomRecord(RogueRoomRecord other)
		: this()
	{
		roomType_ = other.roomType_;
		gameWorldId_ = other.gameWorldId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomRecord Clone()
	{
		return new RogueRoomRecord(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueRoomRecord);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueRoomRecord other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (RoomType != other.RoomType)
		{
			return false;
		}
		if (GameWorldId != other.GameWorldId)
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
		if (RoomType != RogueRoomType.Null)
		{
			num ^= RoomType.GetHashCode();
		}
		if (GameWorldId != 0)
		{
			num ^= GameWorldId.GetHashCode();
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
		if (RoomType != RogueRoomType.Null)
		{
			output.WriteRawTag(8);
			output.WriteEnum((int)RoomType);
		}
		if (GameWorldId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GameWorldId);
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
		if (RoomType != RogueRoomType.Null)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)RoomType);
		}
		if (GameWorldId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GameWorldId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueRoomRecord other)
	{
		if (other != null)
		{
			if (other.RoomType != RogueRoomType.Null)
			{
				RoomType = other.RoomType;
			}
			if (other.GameWorldId != 0)
			{
				GameWorldId = other.GameWorldId;
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
				RoomType = (RogueRoomType)input.ReadEnum();
				break;
			case 16u:
				GameWorldId = input.ReadInt32();
				break;
			}
		}
	}
}
