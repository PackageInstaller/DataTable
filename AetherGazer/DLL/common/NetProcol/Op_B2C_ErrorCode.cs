using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(133)]
public sealed class Op_B2C_ErrorCode : IMessage<Op_B2C_ErrorCode>, IMessage, IEquatable<Op_B2C_ErrorCode>, IDeepCloneable<Op_B2C_ErrorCode>
{
	private static readonly MessageParser<Op_B2C_ErrorCode> _parser = new MessageParser<Op_B2C_ErrorCode>(() => new Op_B2C_ErrorCode());

	public const int CodeFieldNumber = 1;

	private int code_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_ErrorCode> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[38];

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
	public Op_B2C_ErrorCode()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_ErrorCode(Op_B2C_ErrorCode other)
		: this()
	{
		code_ = other.code_;
	}

	[DebuggerNonUserCode]
	public Op_B2C_ErrorCode Clone()
	{
		return new Op_B2C_ErrorCode(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_ErrorCode);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_ErrorCode other)
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
	public void MergeFrom(Op_B2C_ErrorCode other)
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
