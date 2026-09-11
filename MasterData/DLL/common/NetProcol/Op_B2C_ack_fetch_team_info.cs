using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(129)]
public sealed class Op_B2C_ack_fetch_team_info : IMessage<Op_B2C_ack_fetch_team_info>, IMessage, IEquatable<Op_B2C_ack_fetch_team_info>, IDeepCloneable<Op_B2C_ack_fetch_team_info>
{
	private static readonly MessageParser<Op_B2C_ack_fetch_team_info> _parser = new MessageParser<Op_B2C_ack_fetch_team_info>(() => new Op_B2C_ack_fetch_team_info());

	public const int TeamFieldNumber = 1;

	private static readonly MapField<ulong, MatchMember>.Codec _map_team_codec = new MapField<ulong, MatchMember>.Codec(FieldCodec.ForUInt64(8u), FieldCodec.ForMessage(18u, MatchMember.Parser), 10u);

	private readonly MapField<ulong, MatchMember> team_ = new MapField<ulong, MatchMember>();

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_ack_fetch_team_info> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[34];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public MapField<ulong, MatchMember> Team => team_;

	[DebuggerNonUserCode]
	public Op_B2C_ack_fetch_team_info()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_ack_fetch_team_info(Op_B2C_ack_fetch_team_info other)
		: this()
	{
		team_ = other.team_.Clone();
	}

	[DebuggerNonUserCode]
	public Op_B2C_ack_fetch_team_info Clone()
	{
		return new Op_B2C_ack_fetch_team_info(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_ack_fetch_team_info);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_ack_fetch_team_info other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!Team.Equals(other.Team))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		return num ^ Team.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		team_.WriteTo(output, _map_team_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		return num + team_.CalculateSize(_map_team_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_ack_fetch_team_info other)
	{
		if (other != null)
		{
			team_.Add(other.team_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 10)
			{
				input.SkipLastField();
			}
			else
			{
				team_.AddEntriesFrom(input, _map_team_codec);
			}
		}
	}
}
