using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(111)]
public sealed class Op_CMD_melee_attack : IMessage<Op_CMD_melee_attack>, IMessage, IEquatable<Op_CMD_melee_attack>, IDeepCloneable<Op_CMD_melee_attack>
{
	private static readonly MessageParser<Op_CMD_melee_attack> _parser = new MessageParser<Op_CMD_melee_attack>(() => new Op_CMD_melee_attack());

	public const int AttackIdFieldNumber = 1;

	private int attackId_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_melee_attack> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[11];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int AttackId
	{
		get
		{
			return attackId_;
		}
		set
		{
			attackId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_melee_attack()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_melee_attack(Op_CMD_melee_attack other)
		: this()
	{
		attackId_ = other.attackId_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_melee_attack Clone()
	{
		return new Op_CMD_melee_attack(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_melee_attack);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_melee_attack other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (AttackId != other.AttackId)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (AttackId != 0)
		{
			num ^= AttackId.GetHashCode();
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
		if (AttackId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(AttackId);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (AttackId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttackId);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_melee_attack other)
	{
		if (other != null && other.AttackId != 0)
		{
			AttackId = other.AttackId;
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
				AttackId = input.ReadInt32();
			}
		}
	}
}
