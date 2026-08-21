using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class LockLimitParam : IMessage<LockLimitParam>, IMessage, IEquatable<LockLimitParam>, IDeepCloneable<LockLimitParam>
{
	private static readonly MessageParser<LockLimitParam> _parser = new MessageParser<LockLimitParam>(() => new LockLimitParam());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int LockFarestDistanceFieldNumber = 2;

	private int lockFarestDistance_;

	[DebuggerNonUserCode]
	public static MessageParser<LockLimitParam> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[39];

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
	public int LockFarestDistance
	{
		get
		{
			return lockFarestDistance_;
		}
		set
		{
			lockFarestDistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public LockLimitParam()
	{
	}

	[DebuggerNonUserCode]
	public LockLimitParam(LockLimitParam other)
		: this()
	{
		iD_ = other.iD_;
		lockFarestDistance_ = other.lockFarestDistance_;
	}

	[DebuggerNonUserCode]
	public LockLimitParam Clone()
	{
		return new LockLimitParam(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as LockLimitParam);
	}

	[DebuggerNonUserCode]
	public bool Equals(LockLimitParam other)
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
		if (LockFarestDistance != other.LockFarestDistance)
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
		if (LockFarestDistance != 0)
		{
			num ^= LockFarestDistance.GetHashCode();
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
		if (LockFarestDistance != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(LockFarestDistance);
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
		if (LockFarestDistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LockFarestDistance);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(LockLimitParam other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.LockFarestDistance != 0)
			{
				LockFarestDistance = other.LockFarestDistance;
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
				LockFarestDistance = input.ReadInt32();
				break;
			}
		}
	}
}
