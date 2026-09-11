using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(117)]
public sealed class Op_CMD_AbilityDirection : IMessage<Op_CMD_AbilityDirection>, IMessage, IEquatable<Op_CMD_AbilityDirection>, IDeepCloneable<Op_CMD_AbilityDirection>
{
	private static readonly MessageParser<Op_CMD_AbilityDirection> _parser = new MessageParser<Op_CMD_AbilityDirection>(() => new Op_CMD_AbilityDirection());

	public const int AngleFieldNumber = 1;

	private long angle_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_AbilityDirection> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[21];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long Angle
	{
		get
		{
			return angle_;
		}
		set
		{
			angle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_AbilityDirection()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_AbilityDirection(Op_CMD_AbilityDirection other)
		: this()
	{
		angle_ = other.angle_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_AbilityDirection Clone()
	{
		return new Op_CMD_AbilityDirection(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_AbilityDirection);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_AbilityDirection other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Angle != other.Angle)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Angle != 0L)
		{
			num ^= Angle.GetHashCode();
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
		if (Angle != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Angle);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Angle != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Angle);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_AbilityDirection other)
	{
		if (other != null && other.Angle != 0L)
		{
			Angle = other.Angle;
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
				Angle = input.ReadInt64();
			}
		}
	}
}
