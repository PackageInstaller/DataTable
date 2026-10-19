using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class RogueRoomInfo : IMessage<RogueRoomInfo>, IMessage, IEquatable<RogueRoomInfo>, IDeepCloneable<RogueRoomInfo>, IBufferMessage
{
	private static readonly MessageParser<RogueRoomInfo> _parser = new MessageParser<RogueRoomInfo>(() => new RogueRoomInfo());

	private UnknownFieldSet _unknownFields;

	public const int GameWorldIdFieldNumber = 1;

	private int gameWorldId_;

	public const int RoomTypeFieldNumber = 2;

	private RogueRoomType roomType_;

	public const int NextRoomTypesFieldNumber = 3;

	private static readonly FieldCodec<RogueRoomType> _repeated_nextRoomTypes_codec = FieldCodec.ForEnum(26u, (RogueRoomType x) => (int)x, (int x) => (RogueRoomType)x);

	private readonly RepeatedField<RogueRoomType> nextRoomTypes_ = new RepeatedField<RogueRoomType>();

	public const int RewardsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_rewards_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> rewards_ = new RepeatedField<int>();

	public const int RoomStatusFieldNumber = 5;

	private RogueRoomStatus roomStatus_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<RogueRoomInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[234];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public RepeatedField<RogueRoomType> NextRoomTypes => nextRoomTypes_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> Rewards => rewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomStatus RoomStatus
	{
		get
		{
			return roomStatus_;
		}
		set
		{
			roomStatus_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomInfo(RogueRoomInfo other)
		: this()
	{
		gameWorldId_ = other.gameWorldId_;
		roomType_ = other.roomType_;
		nextRoomTypes_ = other.nextRoomTypes_.Clone();
		rewards_ = other.rewards_.Clone();
		roomStatus_ = other.roomStatus_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RogueRoomInfo Clone()
	{
		return new RogueRoomInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as RogueRoomInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(RogueRoomInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (GameWorldId != other.GameWorldId)
		{
			return false;
		}
		if (RoomType != other.RoomType)
		{
			return false;
		}
		if (!nextRoomTypes_.Equals(other.nextRoomTypes_))
		{
			return false;
		}
		if (!rewards_.Equals(other.rewards_))
		{
			return false;
		}
		if (RoomStatus != other.RoomStatus)
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
		if (GameWorldId != 0)
		{
			num ^= GameWorldId.GetHashCode();
		}
		if (RoomType != RogueRoomType.Null)
		{
			num ^= RoomType.GetHashCode();
		}
		num ^= nextRoomTypes_.GetHashCode();
		num ^= rewards_.GetHashCode();
		if (RoomStatus != RogueRoomStatus.Unfinished)
		{
			num ^= RoomStatus.GetHashCode();
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
		if (GameWorldId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(GameWorldId);
		}
		if (RoomType != RogueRoomType.Null)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)RoomType);
		}
		nextRoomTypes_.WriteTo(ref output, _repeated_nextRoomTypes_codec);
		rewards_.WriteTo(ref output, _repeated_rewards_codec);
		if (RoomStatus != RogueRoomStatus.Unfinished)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)RoomStatus);
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
		if (GameWorldId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GameWorldId);
		}
		if (RoomType != RogueRoomType.Null)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)RoomType);
		}
		num += nextRoomTypes_.CalculateSize(_repeated_nextRoomTypes_codec);
		num += rewards_.CalculateSize(_repeated_rewards_codec);
		if (RoomStatus != RogueRoomStatus.Unfinished)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)RoomStatus);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(RogueRoomInfo other)
	{
		if (other != null)
		{
			if (other.GameWorldId != 0)
			{
				GameWorldId = other.GameWorldId;
			}
			if (other.RoomType != RogueRoomType.Null)
			{
				RoomType = other.RoomType;
			}
			nextRoomTypes_.Add(other.nextRoomTypes_);
			rewards_.Add(other.rewards_);
			if (other.RoomStatus != RogueRoomStatus.Unfinished)
			{
				RoomStatus = other.RoomStatus;
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
				GameWorldId = input.ReadInt32();
				break;
			case 16u:
				RoomType = (RogueRoomType)input.ReadEnum();
				break;
			case 24u:
			case 26u:
				nextRoomTypes_.AddEntriesFrom(ref input, _repeated_nextRoomTypes_codec);
				break;
			case 32u:
			case 34u:
				rewards_.AddEntriesFrom(ref input, _repeated_rewards_codec);
				break;
			case 40u:
				RoomStatus = (RogueRoomStatus)input.ReadEnum();
				break;
			}
		}
	}
}
