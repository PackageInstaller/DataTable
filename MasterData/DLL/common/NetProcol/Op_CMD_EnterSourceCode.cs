using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(116)]
public sealed class Op_CMD_EnterSourceCode : IMessage<Op_CMD_EnterSourceCode>, IMessage, IEquatable<Op_CMD_EnterSourceCode>, IDeepCloneable<Op_CMD_EnterSourceCode>
{
	private static readonly MessageParser<Op_CMD_EnterSourceCode> _parser = new MessageParser<Op_CMD_EnterSourceCode>(() => new Op_CMD_EnterSourceCode());

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_EnterSourceCode> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[20];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public Op_CMD_EnterSourceCode()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_EnterSourceCode(Op_CMD_EnterSourceCode other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_EnterSourceCode Clone()
	{
		return new Op_CMD_EnterSourceCode(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_EnterSourceCode);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_EnterSourceCode other)
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
	public void MergeFrom(Op_CMD_EnterSourceCode other)
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
