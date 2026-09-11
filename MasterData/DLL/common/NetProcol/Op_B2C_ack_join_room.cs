using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(127)]
public sealed class Op_B2C_ack_join_room : IMessage<Op_B2C_ack_join_room>, IMessage, IEquatable<Op_B2C_ack_join_room>, IDeepCloneable<Op_B2C_ack_join_room>
{
	private static readonly MessageParser<Op_B2C_ack_join_room> _parser = new MessageParser<Op_B2C_ack_join_room>(() => new Op_B2C_ack_join_room());

	public const int BattleIdFieldNumber = 1;

	private long battleId_;

	public const int SeatIdFieldNumber = 2;

	private int seatId_;

	public const int RoleIdFieldNumber = 3;

	private int roleId_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_ack_join_room> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[32];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long BattleId
	{
		get
		{
			return battleId_;
		}
		set
		{
			battleId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SeatId
	{
		get
		{
			return seatId_;
		}
		set
		{
			seatId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RoleId
	{
		get
		{
			return roleId_;
		}
		set
		{
			roleId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_B2C_ack_join_room()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_ack_join_room(Op_B2C_ack_join_room other)
		: this()
	{
		battleId_ = other.battleId_;
		seatId_ = other.seatId_;
		roleId_ = other.roleId_;
	}

	[DebuggerNonUserCode]
	public Op_B2C_ack_join_room Clone()
	{
		return new Op_B2C_ack_join_room(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_ack_join_room);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_ack_join_room other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (BattleId != other.BattleId)
		{
			return false;
		}
		if (SeatId != other.SeatId)
		{
			return false;
		}
		if (RoleId != other.RoleId)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (BattleId != 0L)
		{
			num ^= BattleId.GetHashCode();
		}
		if (SeatId != 0)
		{
			num ^= SeatId.GetHashCode();
		}
		if (RoleId != 0)
		{
			num ^= RoleId.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (BattleId != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(BattleId);
		}
		if (SeatId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SeatId);
		}
		if (RoleId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RoleId);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (BattleId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BattleId);
		}
		if (SeatId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SeatId);
		}
		if (RoleId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RoleId);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_ack_join_room other)
	{
		if (other != null)
		{
			if (other.BattleId != 0L)
			{
				BattleId = other.BattleId;
			}
			if (other.SeatId != 0)
			{
				SeatId = other.SeatId;
			}
			if (other.RoleId != 0)
			{
				RoleId = other.RoleId;
			}
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
				BattleId = input.ReadInt64();
				break;
			case 16u:
				SeatId = input.ReadInt32();
				break;
			case 24u:
				RoleId = input.ReadInt32();
				break;
			}
		}
	}
}
