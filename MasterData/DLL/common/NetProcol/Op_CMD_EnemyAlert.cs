using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(139)]
public sealed class Op_CMD_EnemyAlert : IMessage<Op_CMD_EnemyAlert>, IMessage, IEquatable<Op_CMD_EnemyAlert>, IDeepCloneable<Op_CMD_EnemyAlert>
{
	private static readonly MessageParser<Op_CMD_EnemyAlert> _parser = new MessageParser<Op_CMD_EnemyAlert>(() => new Op_CMD_EnemyAlert());

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_EnemyAlert> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[44];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public Op_CMD_EnemyAlert()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_EnemyAlert(Op_CMD_EnemyAlert other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_EnemyAlert Clone()
	{
		return new Op_CMD_EnemyAlert(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_EnemyAlert);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_EnemyAlert other)
	{
		if (other == null)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		return 1;
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		return 0;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_EnemyAlert other)
	{
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			input.SkipLastField();
		}
	}
}
