using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(128)]
public sealed class Op_C2B_fetch_team_info : IMessage<Op_C2B_fetch_team_info>, IMessage, IEquatable<Op_C2B_fetch_team_info>, IDeepCloneable<Op_C2B_fetch_team_info>
{
	private static readonly MessageParser<Op_C2B_fetch_team_info> _parser = new MessageParser<Op_C2B_fetch_team_info>(() => new Op_C2B_fetch_team_info());

	public const int BattleIdFieldNumber = 1;

	private long battleId_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_C2B_fetch_team_info> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[33];

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
	public Op_C2B_fetch_team_info()
	{
	}

	[DebuggerNonUserCode]
	public Op_C2B_fetch_team_info(Op_C2B_fetch_team_info other)
		: this()
	{
		battleId_ = other.battleId_;
	}

	[DebuggerNonUserCode]
	public Op_C2B_fetch_team_info Clone()
	{
		return new Op_C2B_fetch_team_info(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_C2B_fetch_team_info);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_C2B_fetch_team_info other)
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
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (BattleId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BattleId);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_C2B_fetch_team_info other)
	{
		if (other != null && other.BattleId != 0L)
		{
			BattleId = other.BattleId;
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 8)
			{
				input.SkipLastField();
			}
			else
			{
				BattleId = input.ReadInt64();
			}
		}
	}
}
