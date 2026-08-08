using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class AbilityStateInfo : IMessage<AbilityStateInfo>, IMessage, IEquatable<AbilityStateInfo>, IDeepCloneable<AbilityStateInfo>
{
	private static readonly MessageParser<AbilityStateInfo> _parser = new MessageParser<AbilityStateInfo>(() => new AbilityStateInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int AbilityStateIndexFieldNumber = 4;

	private int abilityStateIndex_;

	[DebuggerNonUserCode]
	public static MessageParser<AbilityStateInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[9];

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
	public int AbilityStateIndex
	{
		get
		{
			return abilityStateIndex_;
		}
		set
		{
			abilityStateIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AbilityStateInfo()
	{
	}

	[DebuggerNonUserCode]
	public AbilityStateInfo(AbilityStateInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		abilityStateIndex_ = other.abilityStateIndex_;
	}

	[DebuggerNonUserCode]
	public AbilityStateInfo Clone()
	{
		return new AbilityStateInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AbilityStateInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(AbilityStateInfo other)
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
		if (Start != other.Start)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (AbilityStateIndex != other.AbilityStateIndex)
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
		if (Start != 0)
		{
			num ^= Start.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (AbilityStateIndex != 0)
		{
			num ^= AbilityStateIndex.GetHashCode();
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
		if (Start != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Start);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Duration);
		}
		if (AbilityStateIndex != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AbilityStateIndex);
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
		if (Start != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Start);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (AbilityStateIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AbilityStateIndex);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(AbilityStateInfo other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Start != 0)
			{
				Start = other.Start;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			if (other.AbilityStateIndex != 0)
			{
				AbilityStateIndex = other.AbilityStateIndex;
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
				Start = input.ReadInt32();
				break;
			case 24u:
				Duration = input.ReadInt32();
				break;
			case 32u:
				AbilityStateIndex = input.ReadInt32();
				break;
			}
		}
	}
}
