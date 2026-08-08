using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(100)]
public sealed class Op_ping : IMessage<Op_ping>, IMessage, IEquatable<Op_ping>, IDeepCloneable<Op_ping>
{
	private static readonly MessageParser<Op_ping> _parser = new MessageParser<Op_ping>(() => new Op_ping());

	public const int ClientTimeFieldNumber = 1;

	private long clientTime_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_ping> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[0];

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
	public Op_ping()
	{
	}

	[DebuggerNonUserCode]
	public Op_ping(Op_ping other)
		: this()
	{
		clientTime_ = other.clientTime_;
	}

	[DebuggerNonUserCode]
	public Op_ping Clone()
	{
		return new Op_ping(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_ping);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_ping other)
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
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ClientTime != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ClientTime);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_ping other)
	{
		if (other != null && other.ClientTime != 0L)
		{
			ClientTime = other.ClientTime;
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
				ClientTime = input.ReadInt64();
			}
		}
	}
}
