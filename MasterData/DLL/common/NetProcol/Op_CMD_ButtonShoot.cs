using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(142)]
public sealed class Op_CMD_ButtonShoot : IMessage<Op_CMD_ButtonShoot>, IMessage, IEquatable<Op_CMD_ButtonShoot>, IDeepCloneable<Op_CMD_ButtonShoot>
{
	private static readonly MessageParser<Op_CMD_ButtonShoot> _parser = new MessageParser<Op_CMD_ButtonShoot>(() => new Op_CMD_ButtonShoot());

	public const int TargetIDFieldNumber = 1;

	private int targetID_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_ButtonShoot> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[47];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int TargetID
	{
		get
		{
			return targetID_;
		}
		set
		{
			targetID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_ButtonShoot()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_ButtonShoot(Op_CMD_ButtonShoot other)
		: this()
	{
		targetID_ = other.targetID_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_ButtonShoot Clone()
	{
		return new Op_CMD_ButtonShoot(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_ButtonShoot);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_ButtonShoot other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TargetID != other.TargetID)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (TargetID != 0)
		{
			num ^= TargetID.GetHashCode();
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
		if (TargetID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TargetID);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (TargetID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetID);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_ButtonShoot other)
	{
		if (other != null && other.TargetID != 0)
		{
			TargetID = other.TargetID;
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
				TargetID = input.ReadInt32();
			}
		}
	}
}
