using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(109)]
public sealed class Op_CMD_move_dir : IMessage<Op_CMD_move_dir>, IMessage, IEquatable<Op_CMD_move_dir>, IDeepCloneable<Op_CMD_move_dir>
{
	private static readonly MessageParser<Op_CMD_move_dir> _parser = new MessageParser<Op_CMD_move_dir>(() => new Op_CMD_move_dir());

	public const int AngleFieldNumber = 1;

	private int angle_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_move_dir> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Angle
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
	public Op_CMD_move_dir()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_move_dir(Op_CMD_move_dir other)
		: this()
	{
		angle_ = other.angle_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_move_dir Clone()
	{
		return new Op_CMD_move_dir(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_move_dir);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_move_dir other)
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
		if (Angle != 0)
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
		if (Angle != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Angle);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Angle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Angle);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_move_dir other)
	{
		if (other != null && other.Angle != 0)
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
				Angle = input.ReadInt32();
			}
		}
	}
}
