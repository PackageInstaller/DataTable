using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(121)]
public sealed class Op_CMD_Story : IMessage<Op_CMD_Story>, IMessage, IEquatable<Op_CMD_Story>, IDeepCloneable<Op_CMD_Story>
{
	private static readonly MessageParser<Op_CMD_Story> _parser = new MessageParser<Op_CMD_Story>(() => new Op_CMD_Story());

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_Story> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[25];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public Op_CMD_Story()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_Story(Op_CMD_Story other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_Story Clone()
	{
		return new Op_CMD_Story(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_Story);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_Story other)
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
	public void MergeFrom(Op_CMD_Story other)
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
