using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(144)]
public sealed class Op_CMD_OnlineReady : IMessage<Op_CMD_OnlineReady>, IMessage, IEquatable<Op_CMD_OnlineReady>, IDeepCloneable<Op_CMD_OnlineReady>
{
	private static readonly MessageParser<Op_CMD_OnlineReady> _parser = new MessageParser<Op_CMD_OnlineReady>(() => new Op_CMD_OnlineReady());

	public const int IsReadyFieldNumber = 1;

	private bool isReady_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_OnlineReady> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[49];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public bool IsReady
	{
		get
		{
			return isReady_;
		}
		set
		{
			isReady_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_OnlineReady()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_OnlineReady(Op_CMD_OnlineReady other)
		: this()
	{
		isReady_ = other.isReady_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_OnlineReady Clone()
	{
		return new Op_CMD_OnlineReady(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_OnlineReady);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_OnlineReady other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (IsReady != other.IsReady)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (IsReady)
		{
			num ^= IsReady.GetHashCode();
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
		if (IsReady)
		{
			output.WriteRawTag(8);
			output.WriteBool(IsReady);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (IsReady)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_OnlineReady other)
	{
		if (other != null && other.IsReady)
		{
			IsReady = other.IsReady;
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
				IsReady = input.ReadBool();
			}
		}
	}
}
