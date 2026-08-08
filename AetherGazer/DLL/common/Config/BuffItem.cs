using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class BuffItem : IMessage<BuffItem>, IMessage, IEquatable<BuffItem>, IDeepCloneable<BuffItem>
{
	private static readonly MessageParser<BuffItem> _parser = new MessageParser<BuffItem>(() => new BuffItem());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DescribeFieldNumber = 2;

	private string describe_ = "";

	public const int TimelineIdFieldNumber = 3;

	private int timelineId_;

	public const int BuffIdFieldNumber = 4;

	private int buffId_;

	public const int LevelFieldNumber = 5;

	private int level_;

	public const int Param1FieldNumber = 6;

	private int param1_;

	public const int Param2FieldNumber = 7;

	private int param2_;

	public const int Param3FieldNumber = 8;

	private int param3_;

	public const int Param4FieldNumber = 9;

	private int param4_;

	[DebuggerNonUserCode]
	public static MessageParser<BuffItem> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[18];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Describe
	{
		get
		{
			return describe_;
		}
		set
		{
			describe_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TimelineId
	{
		get
		{
			return timelineId_;
		}
		set
		{
			timelineId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffId
	{
		get
		{
			return buffId_;
		}
		set
		{
			buffId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BuffItem()
	{
	}

	[DebuggerNonUserCode]
	public BuffItem(BuffItem other)
		: this()
	{
		iD_ = other.iD_;
		describe_ = other.describe_;
		timelineId_ = other.timelineId_;
		buffId_ = other.buffId_;
		level_ = other.level_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
	}

	[DebuggerNonUserCode]
	public BuffItem Clone()
	{
		return new BuffItem(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BuffItem);
	}

	[DebuggerNonUserCode]
	public bool Equals(BuffItem other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Describe != other.Describe)
		{
			return false;
		}
		if (TimelineId != other.TimelineId)
		{
			return false;
		}
		if (BuffId != other.BuffId)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Describe.Length != 0)
		{
			num ^= Describe.GetHashCode();
		}
		if (TimelineId != 0)
		{
			num ^= TimelineId.GetHashCode();
		}
		if (BuffId != 0)
		{
			num ^= BuffId.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Param1 != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2 != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3 != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4 != 0)
		{
			num ^= Param4.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Describe.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Describe);
		}
		if (TimelineId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TimelineId);
		}
		if (BuffId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BuffId);
		}
		if (Level != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Level);
		}
		if (Param1 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Param1);
		}
		if (Param2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Param2);
		}
		if (Param3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Param3);
		}
		if (Param4 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Param4);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Describe.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Describe);
		}
		if (TimelineId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimelineId);
		}
		if (BuffId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffId);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Param1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param1);
		}
		if (Param2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param2);
		}
		if (Param3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param3);
		}
		if (Param4 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Param4);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BuffItem other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Describe.Length != 0)
			{
				Describe = other.Describe;
			}
			if (other.TimelineId != 0)
			{
				TimelineId = other.TimelineId;
			}
			if (other.BuffId != 0)
			{
				BuffId = other.BuffId;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Param1 != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2 != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3 != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4 != 0)
			{
				Param4 = other.Param4;
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
				ID = input.ReadInt32();
				break;
			case 18u:
				Describe = input.ReadString();
				break;
			case 24u:
				TimelineId = input.ReadInt32();
				break;
			case 32u:
				BuffId = input.ReadInt32();
				break;
			case 40u:
				Level = input.ReadInt32();
				break;
			case 48u:
				Param1 = input.ReadInt32();
				break;
			case 56u:
				Param2 = input.ReadInt32();
				break;
			case 64u:
				Param3 = input.ReadInt32();
				break;
			case 72u:
				Param4 = input.ReadInt32();
				break;
			}
		}
	}
}
