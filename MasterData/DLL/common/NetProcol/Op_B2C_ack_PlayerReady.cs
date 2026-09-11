using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(131)]
public sealed class Op_B2C_ack_PlayerReady : IMessage<Op_B2C_ack_PlayerReady>, IMessage, IEquatable<Op_B2C_ack_PlayerReady>, IDeepCloneable<Op_B2C_ack_PlayerReady>
{
	private static readonly MessageParser<Op_B2C_ack_PlayerReady> _parser = new MessageParser<Op_B2C_ack_PlayerReady>(() => new Op_B2C_ack_PlayerReady());

	public const int PlayerIdFieldNumber = 1;

	private long playerId_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_ack_PlayerReady> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[36];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long PlayerId
	{
		get
		{
			return playerId_;
		}
		set
		{
			playerId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_B2C_ack_PlayerReady()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_ack_PlayerReady(Op_B2C_ack_PlayerReady other)
		: this()
	{
		playerId_ = other.playerId_;
	}

	[DebuggerNonUserCode]
	public Op_B2C_ack_PlayerReady Clone()
	{
		return new Op_B2C_ack_PlayerReady(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_ack_PlayerReady);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_ack_PlayerReady other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PlayerId != other.PlayerId)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (PlayerId != 0L)
		{
			num ^= PlayerId.GetHashCode();
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
		if (PlayerId != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(PlayerId);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (PlayerId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(PlayerId);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_ack_PlayerReady other)
	{
		if (other != null && other.PlayerId != 0L)
		{
			PlayerId = other.PlayerId;
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
				PlayerId = input.ReadInt64();
			}
		}
	}
}
