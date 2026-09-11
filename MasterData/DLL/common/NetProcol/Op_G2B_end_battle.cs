using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(108)]
public sealed class Op_G2B_end_battle : IMessage<Op_G2B_end_battle>, IMessage, IEquatable<Op_G2B_end_battle>, IDeepCloneable<Op_G2B_end_battle>
{
	private static readonly MessageParser<Op_G2B_end_battle> _parser = new MessageParser<Op_G2B_end_battle>(() => new Op_G2B_end_battle());

	[DebuggerNonUserCode]
	public static MessageParser<Op_G2B_end_battle> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[8];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public Op_G2B_end_battle()
	{
	}

	[DebuggerNonUserCode]
	public Op_G2B_end_battle(Op_G2B_end_battle other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public Op_G2B_end_battle Clone()
	{
		return new Op_G2B_end_battle(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_G2B_end_battle);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_G2B_end_battle other)
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
	public void MergeFrom(Op_G2B_end_battle other)
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
