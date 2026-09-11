using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(118)]
public sealed class Op_CMD_Choose_Target : IMessage<Op_CMD_Choose_Target>, IMessage, IEquatable<Op_CMD_Choose_Target>, IDeepCloneable<Op_CMD_Choose_Target>
{
	private static readonly MessageParser<Op_CMD_Choose_Target> _parser = new MessageParser<Op_CMD_Choose_Target>(() => new Op_CMD_Choose_Target());

	public const int LastTargetIDFieldNumber = 1;

	private int lastTargetID_;

	public const int CameraAngleFieldNumber = 2;

	private int cameraAngle_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_Choose_Target> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[22];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int LastTargetID
	{
		get
		{
			return lastTargetID_;
		}
		set
		{
			lastTargetID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CameraAngle
	{
		get
		{
			return cameraAngle_;
		}
		set
		{
			cameraAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_Choose_Target()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_Choose_Target(Op_CMD_Choose_Target other)
		: this()
	{
		lastTargetID_ = other.lastTargetID_;
		cameraAngle_ = other.cameraAngle_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_Choose_Target Clone()
	{
		return new Op_CMD_Choose_Target(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_Choose_Target);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_Choose_Target other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (LastTargetID != other.LastTargetID)
		{
			return false;
		}
		if (CameraAngle != other.CameraAngle)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (LastTargetID != 0)
		{
			num ^= LastTargetID.GetHashCode();
		}
		if (CameraAngle != 0)
		{
			num ^= CameraAngle.GetHashCode();
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
		if (LastTargetID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(LastTargetID);
		}
		if (CameraAngle != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CameraAngle);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (LastTargetID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LastTargetID);
		}
		if (CameraAngle != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CameraAngle);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_Choose_Target other)
	{
		if (other != null)
		{
			if (other.LastTargetID != 0)
			{
				LastTargetID = other.LastTargetID;
			}
			if (other.CameraAngle != 0)
			{
				CameraAngle = other.CameraAngle;
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
				LastTargetID = input.ReadInt32();
				break;
			case 16u:
				CameraAngle = input.ReadInt32();
				break;
			}
		}
	}
}
