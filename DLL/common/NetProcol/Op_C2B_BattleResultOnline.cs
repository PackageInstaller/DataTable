using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(137)]
public sealed class Op_C2B_BattleResultOnline : IMessage<Op_C2B_BattleResultOnline>, IMessage, IEquatable<Op_C2B_BattleResultOnline>, IDeepCloneable<Op_C2B_BattleResultOnline>
{
	private static readonly MessageParser<Op_C2B_BattleResultOnline> _parser = new MessageParser<Op_C2B_BattleResultOnline>(() => new Op_C2B_BattleResultOnline());

	public const int BattleIDFieldNumber = 1;

	private long battleID_;

	public const int UuidFieldNumber = 2;

	private ulong uuid_;

	public const int ResultFieldNumber = 3;

	private int result_;

	public const int InfoFieldNumber = 4;

	private BattleResultInfo info_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_C2B_BattleResultOnline> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[42];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long BattleID
	{
		get
		{
			return battleID_;
		}
		set
		{
			battleID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ulong Uuid
	{
		get
		{
			return uuid_;
		}
		set
		{
			uuid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Result
	{
		get
		{
			return result_;
		}
		set
		{
			result_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BattleResultInfo Info
	{
		get
		{
			return info_;
		}
		set
		{
			info_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_C2B_BattleResultOnline()
	{
	}

	[DebuggerNonUserCode]
	public Op_C2B_BattleResultOnline(Op_C2B_BattleResultOnline other)
		: this()
	{
		battleID_ = other.battleID_;
		uuid_ = other.uuid_;
		result_ = other.result_;
		Info = ((other.info_ != null) ? other.Info.Clone() : null);
	}

	[DebuggerNonUserCode]
	public Op_C2B_BattleResultOnline Clone()
	{
		return new Op_C2B_BattleResultOnline(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_C2B_BattleResultOnline);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_C2B_BattleResultOnline other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (BattleID != other.BattleID)
		{
			return false;
		}
		if (Uuid != other.Uuid)
		{
			return false;
		}
		if (Result != other.Result)
		{
			return false;
		}
		if (!object.Equals(Info, other.Info))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (BattleID != 0L)
		{
			num ^= BattleID.GetHashCode();
		}
		if (Uuid != 0L)
		{
			num ^= Uuid.GetHashCode();
		}
		if (Result != 0)
		{
			num ^= Result.GetHashCode();
		}
		if (info_ != null)
		{
			num ^= Info.GetHashCode();
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
		if (BattleID != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(BattleID);
		}
		if (Uuid != 0L)
		{
			output.WriteRawTag(16);
			output.WriteUInt64(Uuid);
		}
		if (Result != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Result);
		}
		if (info_ != null)
		{
			output.WriteRawTag(34);
			output.WriteMessage(Info);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (BattleID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BattleID);
		}
		if (Uuid != 0L)
		{
			num += 1 + CodedOutputStream.ComputeUInt64Size(Uuid);
		}
		if (Result != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Result);
		}
		if (info_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Info);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_C2B_BattleResultOnline other)
	{
		if (other == null)
		{
			return;
		}
		if (other.BattleID != 0L)
		{
			BattleID = other.BattleID;
		}
		if (other.Uuid != 0L)
		{
			Uuid = other.Uuid;
		}
		if (other.Result != 0)
		{
			Result = other.Result;
		}
		if (other.info_ != null)
		{
			if (info_ == null)
			{
				info_ = new BattleResultInfo();
			}
			Info.MergeFrom(other.Info);
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
				BattleID = input.ReadInt64();
				break;
			case 16u:
				Uuid = input.ReadUInt64();
				break;
			case 24u:
				Result = input.ReadInt32();
				break;
			case 34u:
				if (info_ == null)
				{
					info_ = new BattleResultInfo();
				}
				input.ReadMessage(info_);
				break;
			}
		}
	}
}
