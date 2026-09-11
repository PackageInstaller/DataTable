using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class CDCompensationInfo : IMessage<CDCompensationInfo>, IMessage, IEquatable<CDCompensationInfo>, IDeepCloneable<CDCompensationInfo>
{
	private static readonly MessageParser<CDCompensationInfo> _parser = new MessageParser<CDCompensationInfo>(() => new CDCompensationInfo());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int StartFieldNumber = 2;

	private int start_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int CDCompensationFieldNumber = 4;

	private int cDCompensation_;

	[DebuggerNonUserCode]
	public static MessageParser<CDCompensationInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[19];

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
	public int CDCompensation
	{
		get
		{
			return cDCompensation_;
		}
		set
		{
			cDCompensation_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CDCompensationInfo()
	{
	}

	[DebuggerNonUserCode]
	public CDCompensationInfo(CDCompensationInfo other)
		: this()
	{
		iD_ = other.iD_;
		start_ = other.start_;
		duration_ = other.duration_;
		cDCompensation_ = other.cDCompensation_;
	}

	[DebuggerNonUserCode]
	public CDCompensationInfo Clone()
	{
		return new CDCompensationInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CDCompensationInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(CDCompensationInfo other)
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
		if (CDCompensation != other.CDCompensation)
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
		if (CDCompensation != 0)
		{
			num ^= CDCompensation.GetHashCode();
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
		if (CDCompensation != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CDCompensation);
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
		if (CDCompensation != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CDCompensation);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CDCompensationInfo other)
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
			if (other.CDCompensation != 0)
			{
				CDCompensation = other.CDCompensation;
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
				CDCompensation = input.ReadInt32();
				break;
			}
		}
	}
}
