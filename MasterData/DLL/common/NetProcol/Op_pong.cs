using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(101)]
public sealed class Op_pong : IMessage<Op_pong>, IMessage, IEquatable<Op_pong>, IDeepCloneable<Op_pong>
{
	private static readonly MessageParser<Op_pong> _parser = new MessageParser<Op_pong>(() => new Op_pong());

	public const int ClientTimeFieldNumber = 1;

	private long clientTime_;

	public const int ServerTimeFieldNumber = 2;

	private long serverTime_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_pong> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[1];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long ClientTime
	{
		get
		{
			return clientTime_;
		}
		set
		{
			clientTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long ServerTime
	{
		get
		{
			return serverTime_;
		}
		set
		{
			serverTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_pong()
	{
	}

	[DebuggerNonUserCode]
	public Op_pong(Op_pong other)
		: this()
	{
		clientTime_ = other.clientTime_;
		serverTime_ = other.serverTime_;
	}

	[DebuggerNonUserCode]
	public Op_pong Clone()
	{
		return new Op_pong(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_pong);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_pong other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ClientTime != other.ClientTime)
		{
			return false;
		}
		if (ServerTime != other.ServerTime)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ClientTime != 0L)
		{
			num ^= ClientTime.GetHashCode();
		}
		if (ServerTime != 0L)
		{
			num ^= ServerTime.GetHashCode();
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
		if (ClientTime != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(ClientTime);
		}
		if (ServerTime != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(ServerTime);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ClientTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ClientTime);
		}
		if (ServerTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ServerTime);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_pong other)
	{
		if (other != null)
		{
			if (other.ClientTime != 0L)
			{
				ClientTime = other.ClientTime;
			}
			if (other.ServerTime != 0L)
			{
				ServerTime = other.ServerTime;
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
				ClientTime = input.ReadInt64();
				break;
			case 16u:
				ServerTime = input.ReadInt64();
				break;
			}
		}
	}
}
