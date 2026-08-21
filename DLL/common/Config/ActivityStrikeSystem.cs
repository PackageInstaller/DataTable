using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class ActivityStrikeSystem : IMessage<ActivityStrikeSystem>, IMessage, IEquatable<ActivityStrikeSystem>, IDeepCloneable<ActivityStrikeSystem>
{
	private static readonly MessageParser<ActivityStrikeSystem> _parser = new MessageParser<ActivityStrikeSystem>(() => new ActivityStrikeSystem());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int CDFieldNumber = 2;

	private int cD_;

	public const int SpLogicPathFieldNumber = 3;

	private string spLogicPath_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityStrikeSystem> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[11];

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
	public int CD
	{
		get
		{
			return cD_;
		}
		set
		{
			cD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SpLogicPath
	{
		get
		{
			return spLogicPath_;
		}
		set
		{
			spLogicPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ActivityStrikeSystem()
	{
	}

	[DebuggerNonUserCode]
	public ActivityStrikeSystem(ActivityStrikeSystem other)
		: this()
	{
		iD_ = other.iD_;
		cD_ = other.cD_;
		spLogicPath_ = other.spLogicPath_;
	}

	[DebuggerNonUserCode]
	public ActivityStrikeSystem Clone()
	{
		return new ActivityStrikeSystem(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityStrikeSystem);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityStrikeSystem other)
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
		if (CD != other.CD)
		{
			return false;
		}
		if (SpLogicPath != other.SpLogicPath)
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
		if (CD != 0)
		{
			num ^= CD.GetHashCode();
		}
		if (SpLogicPath.Length != 0)
		{
			num ^= SpLogicPath.GetHashCode();
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
		if (CD != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CD);
		}
		if (SpLogicPath.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(SpLogicPath);
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
		if (CD != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CD);
		}
		if (SpLogicPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SpLogicPath);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityStrikeSystem other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.CD != 0)
			{
				CD = other.CD;
			}
			if (other.SpLogicPath.Length != 0)
			{
				SpLogicPath = other.SpLogicPath;
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
				CD = input.ReadInt32();
				break;
			case 26u:
				SpLogicPath = input.ReadString();
				break;
			}
		}
	}
}
