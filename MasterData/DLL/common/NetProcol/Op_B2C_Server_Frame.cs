using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(124)]
public sealed class Op_B2C_Server_Frame : IMessage<Op_B2C_Server_Frame>, IMessage, IEquatable<Op_B2C_Server_Frame>, IDeepCloneable<Op_B2C_Server_Frame>
{
	private static readonly MessageParser<Op_B2C_Server_Frame> _parser = new MessageParser<Op_B2C_Server_Frame>(() => new Op_B2C_Server_Frame());

	public const int ServerFrameCountFieldNumber = 1;

	private long serverFrameCount_;

	public const int AllInputsFieldNumber = 2;

	private ByteString allInputs_ = ByteString.Empty;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_Server_Frame> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[28];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long ServerFrameCount
	{
		get
		{
			return serverFrameCount_;
		}
		set
		{
			serverFrameCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ByteString AllInputs
	{
		get
		{
			return allInputs_;
		}
		set
		{
			allInputs_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Op_B2C_Server_Frame()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_Server_Frame(Op_B2C_Server_Frame other)
		: this()
	{
		serverFrameCount_ = other.serverFrameCount_;
		allInputs_ = other.allInputs_;
	}

	[DebuggerNonUserCode]
	public Op_B2C_Server_Frame Clone()
	{
		return new Op_B2C_Server_Frame(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_Server_Frame);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_Server_Frame other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ServerFrameCount != other.ServerFrameCount)
		{
			return false;
		}
		if (AllInputs != other.AllInputs)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ServerFrameCount != 0L)
		{
			num ^= ServerFrameCount.GetHashCode();
		}
		if (AllInputs.Length != 0)
		{
			num ^= AllInputs.GetHashCode();
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
		if (ServerFrameCount != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(ServerFrameCount);
		}
		if (AllInputs.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteBytes(AllInputs);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ServerFrameCount != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(ServerFrameCount);
		}
		if (AllInputs.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeBytesSize(AllInputs);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_Server_Frame other)
	{
		if (other != null)
		{
			if (other.ServerFrameCount != 0L)
			{
				ServerFrameCount = other.ServerFrameCount;
			}
			if (other.AllInputs.Length != 0)
			{
				AllInputs = other.AllInputs;
			}
		}
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CodedInputStream input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				input.SkipLastField();
				break;
			case 8u:
				ServerFrameCount = input.ReadInt64();
				break;
			case 18u:
				AllInputs = input.ReadBytes();
				break;
			}
		}
	}
}
