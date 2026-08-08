using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(130)]
public sealed class Op_C2B_PlayerReady : IMessage<Op_C2B_PlayerReady>, IMessage, IEquatable<Op_C2B_PlayerReady>, IDeepCloneable<Op_C2B_PlayerReady>
{
	private static readonly MessageParser<Op_C2B_PlayerReady> _parser = new MessageParser<Op_C2B_PlayerReady>(() => new Op_C2B_PlayerReady());

	public const int UuidFieldNumber = 1;

	private ulong uuid_;

	public const int BattleIDFieldNumber = 2;

	private long battleID_;

	public const int SceneDataForExcehangeFieldNumber = 3;

	private SceneDataForExcehangeInfo sceneDataForExcehange_;

	public const int BattleVersionCodeFieldNumber = 4;

	private int battleVersionCode_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_C2B_PlayerReady> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[35];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public SceneDataForExcehangeInfo SceneDataForExcehange
	{
		get
		{
			return sceneDataForExcehange_;
		}
		set
		{
			sceneDataForExcehange_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleVersionCode
	{
		get
		{
			return battleVersionCode_;
		}
		set
		{
			battleVersionCode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_C2B_PlayerReady()
	{
	}

	[DebuggerNonUserCode]
	public Op_C2B_PlayerReady(Op_C2B_PlayerReady other)
		: this()
	{
		uuid_ = other.uuid_;
		battleID_ = other.battleID_;
		SceneDataForExcehange = ((other.sceneDataForExcehange_ != null) ? other.SceneDataForExcehange.Clone() : null);
		battleVersionCode_ = other.battleVersionCode_;
	}

	[DebuggerNonUserCode]
	public Op_C2B_PlayerReady Clone()
	{
		return new Op_C2B_PlayerReady(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_C2B_PlayerReady);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_C2B_PlayerReady other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uuid != other.Uuid)
		{
			return false;
		}
		if (BattleID != other.BattleID)
		{
			return false;
		}
		if (!object.Equals(SceneDataForExcehange, other.SceneDataForExcehange))
		{
			return false;
		}
		if (BattleVersionCode != other.BattleVersionCode)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Uuid != 0L)
		{
			num ^= Uuid.GetHashCode();
		}
		if (BattleID != 0L)
		{
			num ^= BattleID.GetHashCode();
		}
		if (sceneDataForExcehange_ != null)
		{
			num ^= SceneDataForExcehange.GetHashCode();
		}
		if (BattleVersionCode != 0)
		{
			num ^= BattleVersionCode.GetHashCode();
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
		if (Uuid != 0L)
		{
			output.WriteRawTag(8);
			output.WriteUInt64(Uuid);
		}
		if (BattleID != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(BattleID);
		}
		if (sceneDataForExcehange_ != null)
		{
			output.WriteRawTag(26);
			output.WriteMessage(SceneDataForExcehange);
		}
		if (BattleVersionCode != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BattleVersionCode);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Uuid != 0L)
		{
			num += 1 + CodedOutputStream.ComputeUInt64Size(Uuid);
		}
		if (BattleID != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(BattleID);
		}
		if (sceneDataForExcehange_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(SceneDataForExcehange);
		}
		if (BattleVersionCode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleVersionCode);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_C2B_PlayerReady other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Uuid != 0L)
		{
			Uuid = other.Uuid;
		}
		if (other.BattleID != 0L)
		{
			BattleID = other.BattleID;
		}
		if (other.sceneDataForExcehange_ != null)
		{
			if (sceneDataForExcehange_ == null)
			{
				sceneDataForExcehange_ = new SceneDataForExcehangeInfo();
			}
			SceneDataForExcehange.MergeFrom(other.SceneDataForExcehange);
		}
		if (other.BattleVersionCode != 0)
		{
			BattleVersionCode = other.BattleVersionCode;
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
				Uuid = input.ReadUInt64();
				break;
			case 16u:
				BattleID = input.ReadInt64();
				break;
			case 26u:
				if (sceneDataForExcehange_ == null)
				{
					sceneDataForExcehange_ = new SceneDataForExcehangeInfo();
				}
				input.ReadMessage(sceneDataForExcehange_);
				break;
			case 32u:
				BattleVersionCode = input.ReadInt32();
				break;
			}
		}
	}
}
