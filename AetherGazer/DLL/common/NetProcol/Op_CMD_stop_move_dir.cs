using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(110)]
public sealed class Op_CMD_stop_move_dir : IMessage<Op_CMD_stop_move_dir>, IMessage, IEquatable<Op_CMD_stop_move_dir>, IDeepCloneable<Op_CMD_stop_move_dir>
{
	private static readonly MessageParser<Op_CMD_stop_move_dir> _parser = new MessageParser<Op_CMD_stop_move_dir>(() => new Op_CMD_stop_move_dir());

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_stop_move_dir> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[10];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public Op_CMD_stop_move_dir()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_stop_move_dir(Op_CMD_stop_move_dir other)
		: this()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_stop_move_dir Clone()
	{
		return new Op_CMD_stop_move_dir(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_stop_move_dir);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_stop_move_dir other)
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
	public void MergeFrom(Op_CMD_stop_move_dir other)
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
