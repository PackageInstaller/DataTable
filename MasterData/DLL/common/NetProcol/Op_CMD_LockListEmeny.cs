using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(148)]
public sealed class Op_CMD_LockListEmeny : IMessage<Op_CMD_LockListEmeny>, IMessage, IEquatable<Op_CMD_LockListEmeny>, IDeepCloneable<Op_CMD_LockListEmeny>
{
	private static readonly MessageParser<Op_CMD_LockListEmeny> _parser = new MessageParser<Op_CMD_LockListEmeny>(() => new Op_CMD_LockListEmeny());

	public const int LockEntityIDFieldNumber = 1;

	private static readonly FieldCodec<int> _repeated_lockEntityID_codec = FieldCodec.ForInt32(10u);

	private readonly RepeatedField<int> lockEntityID_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_LockListEmeny> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[53];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public RepeatedField<int> LockEntityID => lockEntityID_;

	[DebuggerNonUserCode]
	public Op_CMD_LockListEmeny()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_LockListEmeny(Op_CMD_LockListEmeny other)
		: this()
	{
		lockEntityID_ = other.lockEntityID_.Clone();
	}

	[DebuggerNonUserCode]
	public Op_CMD_LockListEmeny Clone()
	{
		return new Op_CMD_LockListEmeny(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_LockListEmeny);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_LockListEmeny other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!lockEntityID_.Equals(other.lockEntityID_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		return num ^ lockEntityID_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		lockEntityID_.WriteTo(output, _repeated_lockEntityID_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		return num + lockEntityID_.CalculateSize(_repeated_lockEntityID_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_LockListEmeny other)
	{
		if (other != null)
		{
			lockEntityID_.Add(other.lockEntityID_);
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			if (num != 8 && num != 10)
			{
				input.SkipLastField();
			}
			else
			{
				lockEntityID_.AddEntriesFrom(input, _repeated_lockEntityID_codec);
			}
		}
	}
}
