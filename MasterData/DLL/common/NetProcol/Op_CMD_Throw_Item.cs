using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(119)]
public sealed class Op_CMD_Throw_Item : IMessage<Op_CMD_Throw_Item>, IMessage, IEquatable<Op_CMD_Throw_Item>, IDeepCloneable<Op_CMD_Throw_Item>
{
	private static readonly MessageParser<Op_CMD_Throw_Item> _parser = new MessageParser<Op_CMD_Throw_Item>(() => new Op_CMD_Throw_Item());

	public const int PositionXFieldNumber = 1;

	private int positionX_;

	public const int PositionYFieldNumber = 2;

	private int positionY_;

	public const int PositionZFieldNumber = 3;

	private int positionZ_;

	public const int ForwardXFieldNumber = 4;

	private int forwardX_;

	public const int ForwardZFieldNumber = 5;

	private int forwardZ_;

	public const int TimelineIDFieldNumber = 6;

	private int timelineID_;

	public const int UseCommonFieldNumber = 7;

	private bool useCommon_;

	public const int SpawnTimelineIDFieldNumber = 8;

	private int spawnTimelineID_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_Throw_Item> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[23];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int PositionX
	{
		get
		{
			return positionX_;
		}
		set
		{
			positionX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PositionY
	{
		get
		{
			return positionY_;
		}
		set
		{
			positionY_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PositionZ
	{
		get
		{
			return positionZ_;
		}
		set
		{
			positionZ_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ForwardX
	{
		get
		{
			return forwardX_;
		}
		set
		{
			forwardX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ForwardZ
	{
		get
		{
			return forwardZ_;
		}
		set
		{
			forwardZ_ = value;
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
	public bool UseCommon
	{
		get
		{
			return useCommon_;
		}
		set
		{
			useCommon_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpawnTimelineID
	{
		get
		{
			return spawnTimelineID_;
		}
		set
		{
			spawnTimelineID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_Throw_Item()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_Throw_Item(Op_CMD_Throw_Item other)
		: this()
	{
		positionX_ = other.positionX_;
		positionY_ = other.positionY_;
		positionZ_ = other.positionZ_;
		forwardX_ = other.forwardX_;
		forwardZ_ = other.forwardZ_;
		timelineID_ = other.timelineID_;
		useCommon_ = other.useCommon_;
		spawnTimelineID_ = other.spawnTimelineID_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_Throw_Item Clone()
	{
		return new Op_CMD_Throw_Item(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_Throw_Item);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_Throw_Item other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PositionX != other.PositionX)
		{
			return false;
		}
		if (PositionY != other.PositionY)
		{
			return false;
		}
		if (PositionZ != other.PositionZ)
		{
			return false;
		}
		if (ForwardX != other.ForwardX)
		{
			return false;
		}
		if (ForwardZ != other.ForwardZ)
		{
			return false;
		}
		if (TimelineID != other.TimelineID)
		{
			return false;
		}
		if (UseCommon != other.UseCommon)
		{
			return false;
		}
		if (SpawnTimelineID != other.SpawnTimelineID)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (PositionX != 0)
		{
			num ^= PositionX.GetHashCode();
		}
		if (PositionY != 0)
		{
			num ^= PositionY.GetHashCode();
		}
		if (PositionZ != 0)
		{
			num ^= PositionZ.GetHashCode();
		}
		if (ForwardX != 0)
		{
			num ^= ForwardX.GetHashCode();
		}
		if (ForwardZ != 0)
		{
			num ^= ForwardZ.GetHashCode();
		}
		if (TimelineID != 0)
		{
			num ^= TimelineID.GetHashCode();
		}
		if (UseCommon)
		{
			num ^= UseCommon.GetHashCode();
		}
		if (SpawnTimelineID != 0)
		{
			num ^= SpawnTimelineID.GetHashCode();
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
		if (PositionX != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PositionX);
		}
		if (PositionY != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PositionY);
		}
		if (PositionZ != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PositionZ);
		}
		if (ForwardX != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ForwardX);
		}
		if (ForwardZ != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ForwardZ);
		}
		if (TimelineID != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TimelineID);
		}
		if (UseCommon)
		{
			output.WriteRawTag(56);
			output.WriteBool(UseCommon);
		}
		if (SpawnTimelineID != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SpawnTimelineID);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (PositionX != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PositionX);
		}
		if (PositionY != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PositionY);
		}
		if (PositionZ != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PositionZ);
		}
		if (ForwardX != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ForwardX);
		}
		if (ForwardZ != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ForwardZ);
		}
		if (TimelineID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimelineID);
		}
		if (UseCommon)
		{
			num += 2;
		}
		if (SpawnTimelineID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnTimelineID);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_Throw_Item other)
	{
		if (other != null)
		{
			if (other.PositionX != 0)
			{
				PositionX = other.PositionX;
			}
			if (other.PositionY != 0)
			{
				PositionY = other.PositionY;
			}
			if (other.PositionZ != 0)
			{
				PositionZ = other.PositionZ;
			}
			if (other.ForwardX != 0)
			{
				ForwardX = other.ForwardX;
			}
			if (other.ForwardZ != 0)
			{
				ForwardZ = other.ForwardZ;
			}
			if (other.TimelineID != 0)
			{
				TimelineID = other.TimelineID;
			}
			if (other.UseCommon)
			{
				UseCommon = other.UseCommon;
			}
			if (other.SpawnTimelineID != 0)
			{
				SpawnTimelineID = other.SpawnTimelineID;
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
				PositionX = input.ReadInt32();
				break;
			case 16u:
				PositionY = input.ReadInt32();
				break;
			case 24u:
				PositionZ = input.ReadInt32();
				break;
			case 32u:
				ForwardX = input.ReadInt32();
				break;
			case 40u:
				ForwardZ = input.ReadInt32();
				break;
			case 48u:
				TimelineID = input.ReadInt32();
				break;
			case 56u:
				UseCommon = input.ReadBool();
				break;
			case 64u:
				SpawnTimelineID = input.ReadInt32();
				break;
			}
		}
	}
}
