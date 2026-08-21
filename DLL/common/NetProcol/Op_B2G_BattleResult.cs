using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(106)]
public sealed class Op_B2G_BattleResult : IMessage<Op_B2G_BattleResult>, IMessage, IEquatable<Op_B2G_BattleResult>, IDeepCloneable<Op_B2G_BattleResult>
{
	private static readonly MessageParser<Op_B2G_BattleResult> _parser = new MessageParser<Op_B2G_BattleResult>(() => new Op_B2G_BattleResult());

	public const int GameServerRoomIDFieldNumber = 1;

	private int gameServerRoomID_;

	public const int UuidFieldNumber = 2;

	private int uuid_;

	public const int ResultFieldNumber = 3;

	private int result_;

	public const int InfoFieldNumber = 4;

	private BattleResultInfo info_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2G_BattleResult> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[6];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int GameServerRoomID
	{
		get
		{
			return gameServerRoomID_;
		}
		set
		{
			gameServerRoomID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Uuid
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
	public Op_B2G_BattleResult()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2G_BattleResult(Op_B2G_BattleResult other)
		: this()
	{
		gameServerRoomID_ = other.gameServerRoomID_;
		uuid_ = other.uuid_;
		result_ = other.result_;
		Info = ((other.info_ != null) ? other.Info.Clone() : null);
	}

	[DebuggerNonUserCode]
	public Op_B2G_BattleResult Clone()
	{
		return new Op_B2G_BattleResult(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2G_BattleResult);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2G_BattleResult other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (GameServerRoomID != other.GameServerRoomID)
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
		if (GameServerRoomID != 0)
		{
			num ^= GameServerRoomID.GetHashCode();
		}
		if (Uuid != 0)
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
		if (GameServerRoomID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(GameServerRoomID);
		}
		if (Uuid != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Uuid);
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
		if (GameServerRoomID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GameServerRoomID);
		}
		if (Uuid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uuid);
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
	public void MergeFrom(Op_B2G_BattleResult other)
	{
		if (other == null)
		{
			return;
		}
		if (other.GameServerRoomID != 0)
		{
			GameServerRoomID = other.GameServerRoomID;
		}
		if (other.Uuid != 0)
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
				GameServerRoomID = input.ReadInt32();
				break;
			case 16u:
				Uuid = input.ReadInt32();
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
