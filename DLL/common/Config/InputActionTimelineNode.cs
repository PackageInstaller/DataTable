using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class InputActionTimelineNode : IMessage<InputActionTimelineNode>, IMessage, IEquatable<InputActionTimelineNode>, IDeepCloneable<InputActionTimelineNode>
{
	private static readonly MessageParser<InputActionTimelineNode> _parser = new MessageParser<InputActionTimelineNode>(() => new InputActionTimelineNode());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int EnableFieldNumber = 2;

	private bool enable_;

	public const int StartFieldNumber = 3;

	private int start_;

	public const int DurationFieldNumber = 4;

	private int duration_;

	[DebuggerNonUserCode]
	public static MessageParser<InputActionTimelineNode> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[32];

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
	public bool Enable
	{
		get
		{
			return enable_;
		}
		set
		{
			enable_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Start
	{
		get
		{
			return start_;
		}
		set
		{
			start_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public InputActionTimelineNode()
	{
	}

	[DebuggerNonUserCode]
	public InputActionTimelineNode(InputActionTimelineNode other)
		: this()
	{
		iD_ = other.iD_;
		enable_ = other.enable_;
		start_ = other.start_;
		duration_ = other.duration_;
	}

	[DebuggerNonUserCode]
	public InputActionTimelineNode Clone()
	{
		return new InputActionTimelineNode(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InputActionTimelineNode);
	}

	[DebuggerNonUserCode]
	public bool Equals(InputActionTimelineNode other)
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
		if (Enable != other.Enable)
		{
			return false;
		}
		if (Start != other.Start)
		{
			return false;
		}
		if (Duration != other.Duration)
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
		if (Enable)
		{
			num ^= Enable.GetHashCode();
		}
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
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
		if (Enable)
		{
			output.WriteRawTag(16);
			output.WriteBool(Enable);
		}
		if (Start != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Start);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Duration);
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
		if (Enable)
		{
			num += 2;
		}
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InputActionTimelineNode other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Enable)
			{
				Enable = other.Enable;
			}
			if (other.Start != 0)
			{
				Start = other.Start;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
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
			case 16u:
				Enable = input.ReadBool();
				break;
			case 24u:
				Start = input.ReadInt32();
				break;
			case 32u:
				Duration = input.ReadInt32();
				break;
			}
		}
	}
}
