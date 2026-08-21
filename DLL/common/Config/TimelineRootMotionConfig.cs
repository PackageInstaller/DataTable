using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class TimelineRootMotionConfig : IMessage<TimelineRootMotionConfig>, IMessage, IEquatable<TimelineRootMotionConfig>, IDeepCloneable<TimelineRootMotionConfig>
{
	private static readonly MessageParser<TimelineRootMotionConfig> _parser = new MessageParser<TimelineRootMotionConfig>(() => new TimelineRootMotionConfig());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int ModelIDFieldNumber = 2;

	private int modelID_;

	public const int ActionNameFieldNumber = 3;

	private string actionName_ = "";

	public const int YBakeIntoPoseFieldNumber = 4;

	private int yBakeIntoPose_;

	public const int YOriginalOrRootNodeFieldNumber = 5;

	private int yOriginalOrRootNode_;

	public const int XZBakeIntoPoseFieldNumber = 6;

	private int xZBakeIntoPose_;

	public const int XZOriginalOrRootNodeFieldNumber = 7;

	private int xZOriginalOrRootNode_;

	[DebuggerNonUserCode]
	public static MessageParser<TimelineRootMotionConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[65];

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
	public int ModelID
	{
		get
		{
			return modelID_;
		}
		set
		{
			modelID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ActionName
	{
		get
		{
			return actionName_;
		}
		set
		{
			actionName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int YBakeIntoPose
	{
		get
		{
			return yBakeIntoPose_;
		}
		set
		{
			yBakeIntoPose_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int YOriginalOrRootNode
	{
		get
		{
			return yOriginalOrRootNode_;
		}
		set
		{
			yOriginalOrRootNode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int XZBakeIntoPose
	{
		get
		{
			return xZBakeIntoPose_;
		}
		set
		{
			xZBakeIntoPose_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int XZOriginalOrRootNode
	{
		get
		{
			return xZOriginalOrRootNode_;
		}
		set
		{
			xZOriginalOrRootNode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TimelineRootMotionConfig()
	{
	}

	[DebuggerNonUserCode]
	public TimelineRootMotionConfig(TimelineRootMotionConfig other)
		: this()
	{
		iD_ = other.iD_;
		modelID_ = other.modelID_;
		actionName_ = other.actionName_;
		yBakeIntoPose_ = other.yBakeIntoPose_;
		yOriginalOrRootNode_ = other.yOriginalOrRootNode_;
		xZBakeIntoPose_ = other.xZBakeIntoPose_;
		xZOriginalOrRootNode_ = other.xZOriginalOrRootNode_;
	}

	[DebuggerNonUserCode]
	public TimelineRootMotionConfig Clone()
	{
		return new TimelineRootMotionConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TimelineRootMotionConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(TimelineRootMotionConfig other)
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
		if (ModelID != other.ModelID)
		{
			return false;
		}
		if (ActionName != other.ActionName)
		{
			return false;
		}
		if (YBakeIntoPose != other.YBakeIntoPose)
		{
			return false;
		}
		if (YOriginalOrRootNode != other.YOriginalOrRootNode)
		{
			return false;
		}
		if (XZBakeIntoPose != other.XZBakeIntoPose)
		{
			return false;
		}
		if (XZOriginalOrRootNode != other.XZOriginalOrRootNode)
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
		if (ModelID != 0)
		{
			num ^= ModelID.GetHashCode();
		}
		if (ActionName.Length != 0)
		{
			num ^= ActionName.GetHashCode();
		}
		if (YBakeIntoPose != 0)
		{
			num ^= YBakeIntoPose.GetHashCode();
		}
		if (YOriginalOrRootNode != 0)
		{
			num ^= YOriginalOrRootNode.GetHashCode();
		}
		if (XZBakeIntoPose != 0)
		{
			num ^= XZBakeIntoPose.GetHashCode();
		}
		if (XZOriginalOrRootNode != 0)
		{
			num ^= XZOriginalOrRootNode.GetHashCode();
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
		if (ModelID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ModelID);
		}
		if (ActionName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ActionName);
		}
		if (YBakeIntoPose != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(YBakeIntoPose);
		}
		if (YOriginalOrRootNode != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(YOriginalOrRootNode);
		}
		if (XZBakeIntoPose != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(XZBakeIntoPose);
		}
		if (XZOriginalOrRootNode != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(XZOriginalOrRootNode);
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
		if (ModelID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ModelID);
		}
		if (ActionName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ActionName);
		}
		if (YBakeIntoPose != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(YBakeIntoPose);
		}
		if (YOriginalOrRootNode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(YOriginalOrRootNode);
		}
		if (XZBakeIntoPose != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(XZBakeIntoPose);
		}
		if (XZOriginalOrRootNode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(XZOriginalOrRootNode);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TimelineRootMotionConfig other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.ModelID != 0)
			{
				ModelID = other.ModelID;
			}
			if (other.ActionName.Length != 0)
			{
				ActionName = other.ActionName;
			}
			if (other.YBakeIntoPose != 0)
			{
				YBakeIntoPose = other.YBakeIntoPose;
			}
			if (other.YOriginalOrRootNode != 0)
			{
				YOriginalOrRootNode = other.YOriginalOrRootNode;
			}
			if (other.XZBakeIntoPose != 0)
			{
				XZBakeIntoPose = other.XZBakeIntoPose;
			}
			if (other.XZOriginalOrRootNode != 0)
			{
				XZOriginalOrRootNode = other.XZOriginalOrRootNode;
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
				ModelID = input.ReadInt32();
				break;
			case 26u:
				ActionName = input.ReadString();
				break;
			case 32u:
				YBakeIntoPose = input.ReadInt32();
				break;
			case 40u:
				YOriginalOrRootNode = input.ReadInt32();
				break;
			case 48u:
				XZBakeIntoPose = input.ReadInt32();
				break;
			case 56u:
				XZOriginalOrRootNode = input.ReadInt32();
				break;
			}
		}
	}
}
