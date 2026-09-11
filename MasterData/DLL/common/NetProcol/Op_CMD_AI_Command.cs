using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(115)]
public sealed class Op_CMD_AI_Command : IMessage<Op_CMD_AI_Command>, IMessage, IEquatable<Op_CMD_AI_Command>, IDeepCloneable<Op_CMD_AI_Command>
{
	private static readonly MessageParser<Op_CMD_AI_Command> _parser = new MessageParser<Op_CMD_AI_Command>(() => new Op_CMD_AI_Command());

	public const int TypeFieldNumber = 1;

	private int type_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_AI_Command> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[15];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_AI_Command()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_AI_Command(Op_CMD_AI_Command other)
		: this()
	{
		type_ = other.type_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_AI_Command Clone()
	{
		return new Op_CMD_AI_Command(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_AI_Command);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_AI_Command other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Type != other.Type)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Type);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_AI_Command other)
	{
		if (other != null && other.Type != 0)
		{
			Type = other.Type;
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
				Type = input.ReadInt32();
			}
		}
	}
}
