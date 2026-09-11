using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(107)]
public sealed class Op_G2B_Ack_BattleResult : IMessage<Op_G2B_Ack_BattleResult>, IMessage, IEquatable<Op_G2B_Ack_BattleResult>, IDeepCloneable<Op_G2B_Ack_BattleResult>
{
	private static readonly MessageParser<Op_G2B_Ack_BattleResult> _parser = new MessageParser<Op_G2B_Ack_BattleResult>(() => new Op_G2B_Ack_BattleResult());

	public const int ResultCodeFieldNumber = 1;

	private int resultCode_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_G2B_Ack_BattleResult> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[7];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ResultCode
	{
		get
		{
			return resultCode_;
		}
		set
		{
			resultCode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_G2B_Ack_BattleResult()
	{
	}

	[DebuggerNonUserCode]
	public Op_G2B_Ack_BattleResult(Op_G2B_Ack_BattleResult other)
		: this()
	{
		resultCode_ = other.resultCode_;
	}

	[DebuggerNonUserCode]
	public Op_G2B_Ack_BattleResult Clone()
	{
		return new Op_G2B_Ack_BattleResult(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_G2B_Ack_BattleResult);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_G2B_Ack_BattleResult other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ResultCode != other.ResultCode)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ResultCode != 0)
		{
			num ^= ResultCode.GetHashCode();
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
		if (ResultCode != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ResultCode);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ResultCode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ResultCode);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_G2B_Ack_BattleResult other)
	{
		if (other != null && other.ResultCode != 0)
		{
			ResultCode = other.ResultCode;
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 8)
			{
				input.SkipLastField();
			}
			else
			{
				ResultCode = input.ReadInt32();
			}
		}
	}
}
