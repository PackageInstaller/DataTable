using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(140)]
public sealed class Op_CMD_trigger_parameters : IMessage<Op_CMD_trigger_parameters>, IMessage, IEquatable<Op_CMD_trigger_parameters>, IDeepCloneable<Op_CMD_trigger_parameters>
{
	private static readonly MessageParser<Op_CMD_trigger_parameters> _parser = new MessageParser<Op_CMD_trigger_parameters>(() => new Op_CMD_trigger_parameters());

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_trigger_parameters> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[45];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public Op_CMD_trigger_parameters()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_trigger_parameters(Op_CMD_trigger_parameters other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_trigger_parameters Clone()
	{
		return new Op_CMD_trigger_parameters(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_trigger_parameters);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_trigger_parameters other)
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
	public void MergeFrom(Op_CMD_trigger_parameters other)
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
