using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(103)]
public sealed class Op_G2B_ConnectResponse : IMessage<Op_G2B_ConnectResponse>, IMessage, IEquatable<Op_G2B_ConnectResponse>, IDeepCloneable<Op_G2B_ConnectResponse>
{
	private static readonly MessageParser<Op_G2B_ConnectResponse> _parser = new MessageParser<Op_G2B_ConnectResponse>(() => new Op_G2B_ConnectResponse());

	public const int ErrorCodeFieldNumber = 1;

	private uint errorCode_;

	public const int BattleServerIdFieldNumber = 2;

	private uint battleServerId_;

	public const int IsServiceOpenFieldNumber = 3;

	private bool isServiceOpen_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_G2B_ConnectResponse> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[3];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public uint ErrorCode
	{
		get
		{
			return errorCode_;
		}
		set
		{
			errorCode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public uint BattleServerId
	{
		get
		{
			return battleServerId_;
		}
		set
		{
			battleServerId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsServiceOpen
	{
		get
		{
			return isServiceOpen_;
		}
		set
		{
			isServiceOpen_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_G2B_ConnectResponse()
	{
	}

	[DebuggerNonUserCode]
	public Op_G2B_ConnectResponse(Op_G2B_ConnectResponse other)
		: this()
	{
		errorCode_ = other.errorCode_;
		battleServerId_ = other.battleServerId_;
		isServiceOpen_ = other.isServiceOpen_;
	}

	[DebuggerNonUserCode]
	public Op_G2B_ConnectResponse Clone()
	{
		return new Op_G2B_ConnectResponse(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_G2B_ConnectResponse);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_G2B_ConnectResponse other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ErrorCode != other.ErrorCode)
		{
			return false;
		}
		if (BattleServerId != other.BattleServerId)
		{
			return false;
		}
		if (IsServiceOpen != other.IsServiceOpen)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ErrorCode != 0)
		{
			num ^= ErrorCode.GetHashCode();
		}
		if (BattleServerId != 0)
		{
			num ^= BattleServerId.GetHashCode();
		}
		if (IsServiceOpen)
		{
			num ^= IsServiceOpen.GetHashCode();
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
		if (ErrorCode != 0)
		{
			output.WriteRawTag(8);
			output.WriteUInt32(ErrorCode);
		}
		if (BattleServerId != 0)
		{
			output.WriteRawTag(16);
			output.WriteUInt32(BattleServerId);
		}
		if (IsServiceOpen)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsServiceOpen);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ErrorCode != 0)
		{
			num += 1 + CodedOutputStream.ComputeUInt32Size(ErrorCode);
		}
		if (BattleServerId != 0)
		{
			num += 1 + CodedOutputStream.ComputeUInt32Size(BattleServerId);
		}
		if (IsServiceOpen)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_G2B_ConnectResponse other)
	{
		if (other != null)
		{
			if (other.ErrorCode != 0)
			{
				ErrorCode = other.ErrorCode;
			}
			if (other.BattleServerId != 0)
			{
				BattleServerId = other.BattleServerId;
			}
			if (other.IsServiceOpen)
			{
				IsServiceOpen = other.IsServiceOpen;
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
				ErrorCode = input.ReadUInt32();
				break;
			case 16u:
				BattleServerId = input.ReadUInt32();
				break;
			case 24u:
				IsServiceOpen = input.ReadBool();
				break;
			}
		}
	}
}
