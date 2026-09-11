using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(114)]
public sealed class Op_CMD_modify_trigger_state : IMessage<Op_CMD_modify_trigger_state>, IMessage, IEquatable<Op_CMD_modify_trigger_state>, IDeepCloneable<Op_CMD_modify_trigger_state>
{
	private static readonly MessageParser<Op_CMD_modify_trigger_state> _parser = new MessageParser<Op_CMD_modify_trigger_state>(() => new Op_CMD_modify_trigger_state());

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_modify_trigger_state> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[14];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public Op_CMD_modify_trigger_state()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_modify_trigger_state(Op_CMD_modify_trigger_state other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_modify_trigger_state Clone()
	{
		return new Op_CMD_modify_trigger_state(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_modify_trigger_state);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_modify_trigger_state other)
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
	public void MergeFrom(Op_CMD_modify_trigger_state other)
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
