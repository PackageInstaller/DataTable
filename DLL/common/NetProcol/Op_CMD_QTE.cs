using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(147)]
public sealed class Op_CMD_QTE : IMessage<Op_CMD_QTE>, IMessage, IEquatable<Op_CMD_QTE>, IDeepCloneable<Op_CMD_QTE>
{
	private static readonly MessageParser<Op_CMD_QTE> _parser = new MessageParser<Op_CMD_QTE>(() => new Op_CMD_QTE());

	public const int StatusFieldNumber = 1;

	private int status_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_QTE> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[52];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Status
	{
		get
		{
			return status_;
		}
		set
		{
			status_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_QTE()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_QTE(Op_CMD_QTE other)
		: this()
	{
		status_ = other.status_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_QTE Clone()
	{
		return new Op_CMD_QTE(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_QTE);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_QTE other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Status != other.Status)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Status != 0)
		{
			num ^= Status.GetHashCode();
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
		if (Status != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Status);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Status != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Status);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_QTE other)
	{
		if (other != null && other.Status != 0)
		{
			Status = other.Status;
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
				Status = input.ReadInt32();
			}
		}
	}
}
