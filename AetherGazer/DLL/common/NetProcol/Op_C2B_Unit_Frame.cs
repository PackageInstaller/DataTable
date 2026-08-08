using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(123)]
public sealed class Op_C2B_Unit_Frame : IMessage<Op_C2B_Unit_Frame>, IMessage, IEquatable<Op_C2B_Unit_Frame>, IDeepCloneable<Op_C2B_Unit_Frame>
{
	private static readonly MessageParser<Op_C2B_Unit_Frame> _parser = new MessageParser<Op_C2B_Unit_Frame>(() => new Op_C2B_Unit_Frame());

	public const int UnitIdFieldNumber = 1;

	private long unitId_;

	public const int OpcodeFieldNumber = 2;

	private long opcode_;

	public const int IcmfFieldNumber = 3;

	private long icmf_;

	public const int FrameFieldNumber = 4;

	private ByteString frame_ = ByteString.Empty;

	[DebuggerNonUserCode]
	public static MessageParser<Op_C2B_Unit_Frame> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[27];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long UnitId
	{
		get
		{
			return unitId_;
		}
		set
		{
			unitId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long Opcode
	{
		get
		{
			return opcode_;
		}
		set
		{
			opcode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long Icmf
	{
		get
		{
			return icmf_;
		}
		set
		{
			icmf_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ByteString Frame
	{
		get
		{
			return frame_;
		}
		set
		{
			frame_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public Op_C2B_Unit_Frame()
	{
	}

	[DebuggerNonUserCode]
	public Op_C2B_Unit_Frame(Op_C2B_Unit_Frame other)
		: this()
	{
		unitId_ = other.unitId_;
		opcode_ = other.opcode_;
		icmf_ = other.icmf_;
		frame_ = other.frame_;
	}

	[DebuggerNonUserCode]
	public Op_C2B_Unit_Frame Clone()
	{
		return new Op_C2B_Unit_Frame(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_C2B_Unit_Frame);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_C2B_Unit_Frame other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (UnitId != other.UnitId)
		{
			return false;
		}
		if (Opcode != other.Opcode)
		{
			return false;
		}
		if (Icmf != other.Icmf)
		{
			return false;
		}
		if (Frame != other.Frame)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (UnitId != 0L)
		{
			num ^= UnitId.GetHashCode();
		}
		if (Opcode != 0L)
		{
			num ^= Opcode.GetHashCode();
		}
		if (Icmf != 0L)
		{
			num ^= Icmf.GetHashCode();
		}
		if (Frame.Length != 0)
		{
			num ^= Frame.GetHashCode();
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
		if (UnitId != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(UnitId);
		}
		if (Opcode != 0L)
		{
			output.WriteRawTag(16);
			output.WriteInt64(Opcode);
		}
		if (Icmf != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(Icmf);
		}
		if (Frame.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteBytes(Frame);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (UnitId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(UnitId);
		}
		if (Opcode != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Opcode);
		}
		if (Icmf != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Icmf);
		}
		if (Frame.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeBytesSize(Frame);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_C2B_Unit_Frame other)
	{
		if (other != null)
		{
			if (other.UnitId != 0L)
			{
				UnitId = other.UnitId;
			}
			if (other.Opcode != 0L)
			{
				Opcode = other.Opcode;
			}
			if (other.Icmf != 0L)
			{
				Icmf = other.Icmf;
			}
			if (other.Frame.Length != 0)
			{
				Frame = other.Frame;
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
				UnitId = input.ReadInt64();
				break;
			case 16u:
				Opcode = input.ReadInt64();
				break;
			case 24u:
				Icmf = input.ReadInt64();
				break;
			case 34u:
				Frame = input.ReadBytes();
				break;
			}
		}
	}
}
