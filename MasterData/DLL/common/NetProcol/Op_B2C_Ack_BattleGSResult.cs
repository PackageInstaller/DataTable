using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(135)]
public sealed class Op_B2C_Ack_BattleGSResult : IMessage<Op_B2C_Ack_BattleGSResult>, IMessage, IEquatable<Op_B2C_Ack_BattleGSResult>, IDeepCloneable<Op_B2C_Ack_BattleGSResult>
{
	private static readonly MessageParser<Op_B2C_Ack_BattleGSResult> _parser = new MessageParser<Op_B2C_Ack_BattleGSResult>(() => new Op_B2C_Ack_BattleGSResult());

	public const int CodeFieldNumber = 1;

	private int code_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_Ack_BattleGSResult> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[40];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Code
	{
		get
		{
			return code_;
		}
		set
		{
			code_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_B2C_Ack_BattleGSResult()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_Ack_BattleGSResult(Op_B2C_Ack_BattleGSResult other)
		: this()
	{
		code_ = other.code_;
	}

	[DebuggerNonUserCode]
	public Op_B2C_Ack_BattleGSResult Clone()
	{
		return new Op_B2C_Ack_BattleGSResult(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_Ack_BattleGSResult);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_Ack_BattleGSResult other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Code != other.Code)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Code != 0)
		{
			num ^= Code.GetHashCode();
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
		if (Code != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Code);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Code != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Code);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_Ack_BattleGSResult other)
	{
		if (other != null && other.Code != 0)
		{
			Code = other.Code;
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
				Code = input.ReadInt32();
			}
		}
	}
}
