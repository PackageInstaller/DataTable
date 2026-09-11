using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(102)]
public sealed class Op_B2G_ConnectRequest : IMessage<Op_B2G_ConnectRequest>, IMessage, IEquatable<Op_B2G_ConnectRequest>, IDeepCloneable<Op_B2G_ConnectRequest>
{
	private static readonly MessageParser<Op_B2G_ConnectRequest> _parser = new MessageParser<Op_B2G_ConnectRequest>(() => new Op_B2G_ConnectRequest());

	public const int PortFieldNumber = 1;

	private uint port_;

	public const int TimestampFieldNumber = 2;

	private uint timestamp_;

	public const int VerificationFieldNumber = 3;

	private string verification_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2G_ConnectRequest> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[2];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public uint Port
	{
		get
		{
			return port_;
		}
		set
		{
			port_ = value;
		}
	}

	[DebuggerNonUserCode]
	public uint Timestamp
	{
		get
		{
			return timestamp_;
		}
		set
		{
			timestamp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Verification
	{
		get
		{
			return verification_;
		}
		set
		{
			verification_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Op_B2G_ConnectRequest()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2G_ConnectRequest(Op_B2G_ConnectRequest other)
		: this()
	{
		port_ = other.port_;
		timestamp_ = other.timestamp_;
		verification_ = other.verification_;
	}

	[DebuggerNonUserCode]
	public Op_B2G_ConnectRequest Clone()
	{
		return new Op_B2G_ConnectRequest(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2G_ConnectRequest);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2G_ConnectRequest other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Port != other.Port)
		{
			return false;
		}
		if (Timestamp != other.Timestamp)
		{
			return false;
		}
		if (Verification != other.Verification)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Port != 0)
		{
			num ^= Port.GetHashCode();
		}
		if (Timestamp != 0)
		{
			num ^= Timestamp.GetHashCode();
		}
		if (Verification.Length != 0)
		{
			num ^= Verification.GetHashCode();
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
		if (Port != 0)
		{
			output.WriteRawTag(8);
			output.WriteUInt32(Port);
		}
		if (Timestamp != 0)
		{
			output.WriteRawTag(16);
			output.WriteUInt32(Timestamp);
		}
		if (Verification.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Verification);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Port != 0)
		{
			num += 1 + CodedOutputStream.ComputeUInt32Size(Port);
		}
		if (Timestamp != 0)
		{
			num += 1 + CodedOutputStream.ComputeUInt32Size(Timestamp);
		}
		if (Verification.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Verification);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2G_ConnectRequest other)
	{
		if (other != null)
		{
			if (other.Port != 0)
			{
				Port = other.Port;
			}
			if (other.Timestamp != 0)
			{
				Timestamp = other.Timestamp;
			}
			if (other.Verification.Length != 0)
			{
				Verification = other.Verification;
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
				Port = input.ReadUInt32();
				break;
			case 16u:
				Timestamp = input.ReadUInt32();
				break;
			case 26u:
				Verification = input.ReadString();
				break;
			}
		}
	}
}
