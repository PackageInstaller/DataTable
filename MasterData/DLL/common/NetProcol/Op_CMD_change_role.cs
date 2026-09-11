using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(112)]
public sealed class Op_CMD_change_role : IMessage<Op_CMD_change_role>, IMessage, IEquatable<Op_CMD_change_role>, IDeepCloneable<Op_CMD_change_role>
{
	private static readonly MessageParser<Op_CMD_change_role> _parser = new MessageParser<Op_CMD_change_role>(() => new Op_CMD_change_role());

	public const int ConfigIdFieldNumber = 1;

	private int configId_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_change_role> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[12];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ConfigId
	{
		get
		{
			return configId_;
		}
		set
		{
			configId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_change_role()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_change_role(Op_CMD_change_role other)
		: this()
	{
		configId_ = other.configId_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_change_role Clone()
	{
		return new Op_CMD_change_role(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_change_role);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_change_role other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ConfigId != other.ConfigId)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ConfigId != 0)
		{
			num ^= ConfigId.GetHashCode();
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
		if (ConfigId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ConfigId);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ConfigId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConfigId);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_change_role other)
	{
		if (other != null && other.ConfigId != 0)
		{
			ConfigId = other.ConfigId;
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
				ConfigId = input.ReadInt32();
			}
		}
	}
}
