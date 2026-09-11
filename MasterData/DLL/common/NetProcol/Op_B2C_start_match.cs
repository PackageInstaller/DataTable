using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(125)]
public sealed class Op_B2C_start_match : IMessage<Op_B2C_start_match>, IMessage, IEquatable<Op_B2C_start_match>, IDeepCloneable<Op_B2C_start_match>
{
	private static readonly MessageParser<Op_B2C_start_match> _parser = new MessageParser<Op_B2C_start_match>(() => new Op_B2C_start_match());

	public const int RoomKeyFieldNumber = 1;

	private long roomKey_;

	public const int PlayerNetIdFieldNumber = 2;

	private static readonly MapField<ulong, MatchMember>.Codec _map_playerNetId_codec = new MapField<ulong, MatchMember>.Codec(FieldCodec.ForUInt64(8u), FieldCodec.ForMessage(18u, MatchMember.Parser), 18u);

	private readonly MapField<ulong, MatchMember> playerNetId_ = new MapField<ulong, MatchMember>();

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_start_match> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[30];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long RoomKey
	{
		get
		{
			return roomKey_;
		}
		set
		{
			roomKey_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MapField<ulong, MatchMember> PlayerNetId => playerNetId_;

	[DebuggerNonUserCode]
	public Op_B2C_start_match()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_start_match(Op_B2C_start_match other)
		: this()
	{
		roomKey_ = other.roomKey_;
		playerNetId_ = other.playerNetId_.Clone();
	}

	[DebuggerNonUserCode]
	public Op_B2C_start_match Clone()
	{
		return new Op_B2C_start_match(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_start_match);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_start_match other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (RoomKey != other.RoomKey)
		{
			return false;
		}
		if (!PlayerNetId.Equals(other.PlayerNetId))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (RoomKey != 0L)
		{
			num ^= RoomKey.GetHashCode();
		}
		return num ^ PlayerNetId.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (RoomKey != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(RoomKey);
		}
		playerNetId_.WriteTo(output, _map_playerNetId_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (RoomKey != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(RoomKey);
		}
		return num + playerNetId_.CalculateSize(_map_playerNetId_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_start_match other)
	{
		if (other != null)
		{
			if (other.RoomKey != 0L)
			{
				RoomKey = other.RoomKey;
			}
			playerNetId_.Add(other.playerNetId_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				input.SkipLastField();
				break;
			case 8u:
				RoomKey = input.ReadInt64();
				break;
			case 18u:
				playerNetId_.AddEntriesFrom(input, _map_playerNetId_codec);
				break;
			}
		}
	}
}
