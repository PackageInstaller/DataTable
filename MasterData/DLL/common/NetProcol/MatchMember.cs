using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

public sealed class MatchMember : IMessage<MatchMember>, IMessage, IEquatable<MatchMember>, IDeepCloneable<MatchMember>
{
	private static readonly MessageParser<MatchMember> _parser = new MessageParser<MatchMember>(() => new MatchMember());

	public const int NetIDFieldNumber = 1;

	private long netID_;

	public const int PosFieldNumber = 2;

	private int pos_;

	[DebuggerNonUserCode]
	public static MessageParser<MatchMember> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[29];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long NetID
	{
		get
		{
			return netID_;
		}
		set
		{
			netID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Pos
	{
		get
		{
			return pos_;
		}
		set
		{
			pos_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MatchMember()
	{
	}

	[DebuggerNonUserCode]
	public MatchMember(MatchMember other)
		: this()
	{
		netID_ = other.netID_;
		pos_ = other.pos_;
	}

	[DebuggerNonUserCode]
	public MatchMember Clone()
	{
		return new MatchMember(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MatchMember);
	}

	[DebuggerNonUserCode]
	public bool Equals(MatchMember other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (NetID != other.NetID)
		{
			return false;
		}
		if (Pos != other.Pos)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (NetID != 0L)
		{
			num ^= NetID.GetHashCode();
		}
		if (Pos != 0)
		{
			num ^= Pos.GetHashCode();
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
		if (NetID != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(NetID);
		}
		if (Pos != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Pos);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (NetID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(NetID);
		}
		if (Pos != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Pos);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MatchMember other)
	{
		if (other != null)
		{
			if (other.NetID != 0L)
			{
				NetID = other.NetID;
			}
			if (other.Pos != 0)
			{
				Pos = other.Pos;
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
				NetID = input.ReadInt64();
				break;
			case 16u:
				Pos = input.ReadInt32();
				break;
			}
		}
	}
}
