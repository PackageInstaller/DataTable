using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(120)]
public sealed class Op_CMD_Sub_Joystick : IMessage<Op_CMD_Sub_Joystick>, IMessage, IEquatable<Op_CMD_Sub_Joystick>, IDeepCloneable<Op_CMD_Sub_Joystick>
{
	private static readonly MessageParser<Op_CMD_Sub_Joystick> _parser = new MessageParser<Op_CMD_Sub_Joystick>(() => new Op_CMD_Sub_Joystick());

	public const int CommandCodeFieldNumber = 1;

	private int commandCode_;

	public const int TimelineIDFieldNumber = 2;

	private int timelineID_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_Sub_Joystick> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[24];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int CommandCode
	{
		get
		{
			return commandCode_;
		}
		set
		{
			commandCode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TimelineID
	{
		get
		{
			return timelineID_;
		}
		set
		{
			timelineID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_Sub_Joystick()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_Sub_Joystick(Op_CMD_Sub_Joystick other)
		: this()
	{
		commandCode_ = other.commandCode_;
		timelineID_ = other.timelineID_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_Sub_Joystick Clone()
	{
		return new Op_CMD_Sub_Joystick(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_Sub_Joystick);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_Sub_Joystick other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CommandCode != other.CommandCode)
		{
			return false;
		}
		if (TimelineID != other.TimelineID)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (CommandCode != 0)
		{
			num ^= CommandCode.GetHashCode();
		}
		if (TimelineID != 0)
		{
			num ^= TimelineID.GetHashCode();
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
		if (CommandCode != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CommandCode);
		}
		if (TimelineID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TimelineID);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (CommandCode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CommandCode);
		}
		if (TimelineID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimelineID);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_Sub_Joystick other)
	{
		if (other != null)
		{
			if (other.CommandCode != 0)
			{
				CommandCode = other.CommandCode;
			}
			if (other.TimelineID != 0)
			{
				TimelineID = other.TimelineID;
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
				CommandCode = input.ReadInt32();
				break;
			case 16u:
				TimelineID = input.ReadInt32();
				break;
			}
		}
	}
}
