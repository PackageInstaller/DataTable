using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using ACT.Game.Data;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Pb;

public sealed class RogueEnterNextRoomAck : IMessage<RogueEnterNextRoomAck>, IMessage, IEquatable<RogueEnterNextRoomAck>, IDeepCloneable<RogueEnterNextRoomAck>, IBufferMessage
{
	private static readonly MessageParser<RogueEnterNextRoomAck> _parser = new MessageParser<RogueEnterNextRoomAck>(() => new RogueEnterNextRoomAck());

	private UnknownFieldSet _unknownFields;

	public const int CoinFieldNumber = 1;

	private int coin_;

	public const int RoomInfoFieldNumber = 2;

	private RogueRoomInfo roomInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueEnterNextRoomAck> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => RogueReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Coin
	{
		get
		{
			return coin_;
		}
		set
		{
			coin_ = value;
		}
	}

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
	public RogueEnterNextRoomAck()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueEnterNextRoomAck(RogueEnterNextRoomAck other)
		: this()
	{
		coin_ = other.coin_;
		roomInfo_ = ((other.roomInfo_ != null) ? other.roomInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueEnterNextRoomAck Clone()
	{
		return new RogueEnterNextRoomAck(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueEnterNextRoomAck);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueEnterNextRoomAck other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Coin != other.Coin)
		{
			return false;
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
		if (Coin != 0)
		{
			num ^= Coin.GetHashCode();
		}
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
		if (Coin != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Coin);
		}
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
		if (Coin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Coin);
		}
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
	public void MergeFrom(RogueEnterNextRoomAck other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Coin != 0)
		{
			Coin = other.Coin;
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
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Coin = input.ReadInt32();
				break;
			case 18u:
				if (roomInfo_ == null)
				{
					RoomInfo = new RogueRoomInfo();
				}
				input.ReadMessage(RoomInfo);
				break;
			}
		}
	}
}
