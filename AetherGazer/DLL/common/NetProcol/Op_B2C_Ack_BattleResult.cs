using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(134)]
public sealed class Op_B2C_Ack_BattleResult : IMessage<Op_B2C_Ack_BattleResult>, IMessage, IEquatable<Op_B2C_Ack_BattleResult>, IDeepCloneable<Op_B2C_Ack_BattleResult>
{
	private static readonly MessageParser<Op_B2C_Ack_BattleResult> _parser = new MessageParser<Op_B2C_Ack_BattleResult>(() => new Op_B2C_Ack_BattleResult());

	public const int ResultFieldNumber = 1;

	private int result_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_Ack_BattleResult> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[39];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public Op_B2C_Ack_BattleResult()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_Ack_BattleResult(Op_B2C_Ack_BattleResult other)
		: this()
	{
		result_ = other.result_;
	}

	[DebuggerNonUserCode]
	public Op_B2C_Ack_BattleResult Clone()
	{
		return new Op_B2C_Ack_BattleResult(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_Ack_BattleResult);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_Ack_BattleResult other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Result != other.Result)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Result != 0)
		{
			num ^= Result.GetHashCode();
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
		if (Result != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Result);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Result != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Result);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_Ack_BattleResult other)
	{
		if (other != null && other.Result != 0)
		{
			Result = other.Result;
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
				Result = input.ReadInt32();
			}
		}
	}
}
