using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(122)]
public sealed class Op_CMD_Resurrect : IMessage<Op_CMD_Resurrect>, IMessage, IEquatable<Op_CMD_Resurrect>, IDeepCloneable<Op_CMD_Resurrect>
{
	private static readonly MessageParser<Op_CMD_Resurrect> _parser = new MessageParser<Op_CMD_Resurrect>(() => new Op_CMD_Resurrect());

	public const int TargetEntityIDFieldNumber = 1;

	private int targetEntityID_;

	public const int ResultFieldNumber = 2;

	private bool result_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_Resurrect> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[26];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int TargetEntityID
	{
		get
		{
			return targetEntityID_;
		}
		set
		{
			targetEntityID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Result
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
	public Op_CMD_Resurrect()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_Resurrect(Op_CMD_Resurrect other)
		: this()
	{
		targetEntityID_ = other.targetEntityID_;
		result_ = other.result_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_Resurrect Clone()
	{
		return new Op_CMD_Resurrect(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_Resurrect);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_Resurrect other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TargetEntityID != other.TargetEntityID)
		{
			return false;
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
		if (TargetEntityID != 0)
		{
			num ^= TargetEntityID.GetHashCode();
		}
		if (Result)
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
		if (TargetEntityID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TargetEntityID);
		}
		if (Result)
		{
			output.WriteRawTag(16);
			output.WriteBool(Result);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (TargetEntityID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetEntityID);
		}
		if (Result)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_Resurrect other)
	{
		if (other != null)
		{
			if (other.TargetEntityID != 0)
			{
				TargetEntityID = other.TargetEntityID;
			}
			if (other.Result)
			{
				Result = other.Result;
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
				TargetEntityID = input.ReadInt32();
				break;
			case 16u:
				Result = input.ReadBool();
				break;
			}
		}
	}
}
