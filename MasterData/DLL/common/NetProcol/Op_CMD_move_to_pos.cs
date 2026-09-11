using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace NetProcol;

[Message(141)]
public sealed class Op_CMD_move_to_pos : IMessage<Op_CMD_move_to_pos>, IMessage, IEquatable<Op_CMD_move_to_pos>, IDeepCloneable<Op_CMD_move_to_pos>
{
	private static readonly MessageParser<Op_CMD_move_to_pos> _parser = new MessageParser<Op_CMD_move_to_pos>(() => new Op_CMD_move_to_pos());

	public const int PosXFieldNumber = 1;

	private int posX_;

	public const int PosYFieldNumber = 2;

	private int posY_;

	public const int PosZFieldNumber = 3;

	private int posZ_;

	[DebuggerNonUserCode]
	public static MessageParser<Op_CMD_move_to_pos> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[46];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int PosX
	{
		get
		{
			return posX_;
		}
		set
		{
			posX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PosY
	{
		get
		{
			return posY_;
		}
		set
		{
			posY_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PosZ
	{
		get
		{
			return posZ_;
		}
		set
		{
			posZ_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Op_CMD_move_to_pos()
	{
	}

	[DebuggerNonUserCode]
	public Op_CMD_move_to_pos(Op_CMD_move_to_pos other)
		: this()
	{
		posX_ = other.posX_;
		posY_ = other.posY_;
		posZ_ = other.posZ_;
	}

	[DebuggerNonUserCode]
	public Op_CMD_move_to_pos Clone()
	{
		return new Op_CMD_move_to_pos(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Op_CMD_move_to_pos);
	}

	[DebuggerNonUserCode]
	public bool Equals(Op_CMD_move_to_pos other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PosX != other.PosX)
		{
			return false;
		}
		if (PosY != other.PosY)
		{
			return false;
		}
		if (PosZ != other.PosZ)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (PosX != 0)
		{
			num ^= PosX.GetHashCode();
		}
		if (PosY != 0)
		{
			num ^= PosY.GetHashCode();
		}
		if (PosZ != 0)
		{
			num ^= PosZ.GetHashCode();
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
		if (PosX != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PosX);
		}
		if (PosY != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PosY);
		}
		if (PosZ != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PosZ);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (PosX != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PosX);
		}
		if (PosY != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PosY);
		}
		if (PosZ != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PosZ);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Op_CMD_move_to_pos other)
	{
		if (other != null)
		{
			if (other.PosX != 0)
			{
				PosX = other.PosX;
			}
			if (other.PosY != 0)
			{
				PosY = other.PosY;
			}
			if (other.PosZ != 0)
			{
				PosZ = other.PosZ;
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
				PosX = input.ReadInt32();
				break;
			case 16u:
				PosY = input.ReadInt32();
				break;
			case 24u:
				PosZ = input.ReadInt32();
				break;
			}
		}
	}
}
