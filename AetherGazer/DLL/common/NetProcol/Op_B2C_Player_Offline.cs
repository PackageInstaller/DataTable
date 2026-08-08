using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(145)]
public sealed class Op_B2C_Player_Offline : IMessage<Op_B2C_Player_Offline>, IMessage, IEquatable<Op_B2C_Player_Offline>, IDeepCloneable<Op_B2C_Player_Offline>
{
	private static readonly MessageParser<Op_B2C_Player_Offline> _parser = new MessageParser<Op_B2C_Player_Offline>(() => new Op_B2C_Player_Offline());

	public const int OfflineMemberFieldNumber = 1;

	private int offlineMember_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_B2C_Player_Offline> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[50];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int OfflineMember
	{
		get
		{
			return offlineMember_;
		}
		set
		{
			offlineMember_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_B2C_Player_Offline()
	{
	}

	[DebuggerNonUserCode]
	public Op_B2C_Player_Offline(Op_B2C_Player_Offline other)
		: this()
	{
		offlineMember_ = other.offlineMember_;
	}

	[DebuggerNonUserCode]
	public Op_B2C_Player_Offline Clone()
	{
		return new Op_B2C_Player_Offline(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_B2C_Player_Offline);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_B2C_Player_Offline other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (OfflineMember != other.OfflineMember)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (OfflineMember != 0)
		{
			num ^= OfflineMember.GetHashCode();
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
		if (OfflineMember != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(OfflineMember);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (OfflineMember != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OfflineMember);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_B2C_Player_Offline other)
	{
		if (other != null && other.OfflineMember != 0)
		{
			OfflineMember = other.OfflineMember;
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
				OfflineMember = input.ReadInt32();
			}
		}
	}
}
