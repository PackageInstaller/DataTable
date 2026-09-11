using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(143)]
public sealed class Op_CMD_signal_exchange : IMessage<Op_CMD_signal_exchange>, IMessage, IEquatable<Op_CMD_signal_exchange>, IDeepCloneable<Op_CMD_signal_exchange>
{
	private static readonly MessageParser<Op_CMD_signal_exchange> _parser = new MessageParser<Op_CMD_signal_exchange>(() => new Op_CMD_signal_exchange());

	public const int SignalIndexFieldNumber = 1;

	private int signalIndex_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_signal_exchange> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[48];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int SignalIndex
	{
		get
		{
			return signalIndex_;
		}
		set
		{
			signalIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_signal_exchange()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_signal_exchange(Op_CMD_signal_exchange other)
		: this()
	{
		signalIndex_ = other.signalIndex_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_signal_exchange Clone()
	{
		return new Op_CMD_signal_exchange(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_signal_exchange);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_signal_exchange other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SignalIndex != other.SignalIndex)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (SignalIndex != 0)
		{
			num ^= SignalIndex.GetHashCode();
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
		if (SignalIndex != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SignalIndex);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (SignalIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SignalIndex);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_signal_exchange other)
	{
		if (other != null && other.SignalIndex != 0)
		{
			SignalIndex = other.SignalIndex;
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
				SignalIndex = input.ReadInt32();
			}
		}
	}
}
