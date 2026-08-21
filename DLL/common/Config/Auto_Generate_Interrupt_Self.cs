using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Auto_Generate_Interrupt_Self : IMessage<Auto_Generate_Interrupt_Self>, IMessage, IEquatable<Auto_Generate_Interrupt_Self>, IDeepCloneable<Auto_Generate_Interrupt_Self>
{
	private static readonly MessageParser<Auto_Generate_Interrupt_Self> _parser = new MessageParser<Auto_Generate_Interrupt_Self>(() => new Auto_Generate_Interrupt_Self());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int CanInterruptFieldNumber = 2;

	private bool canInterrupt_;

	[DebuggerNonUserCode]
	public static MessageParser<Auto_Generate_Interrupt_Self> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[15];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CanInterrupt
	{
		get
		{
			return canInterrupt_;
		}
		set
		{
			canInterrupt_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Auto_Generate_Interrupt_Self()
	{
	}

	[DebuggerNonUserCode]
	public Auto_Generate_Interrupt_Self(Auto_Generate_Interrupt_Self other)
		: this()
	{
		iD_ = other.iD_;
		canInterrupt_ = other.canInterrupt_;
	}

	[DebuggerNonUserCode]
	public Auto_Generate_Interrupt_Self Clone()
	{
		return new Auto_Generate_Interrupt_Self(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Auto_Generate_Interrupt_Self);
	}

	[DebuggerNonUserCode]
	public bool Equals(Auto_Generate_Interrupt_Self other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (CanInterrupt != other.CanInterrupt)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (CanInterrupt)
		{
			num ^= CanInterrupt.GetHashCode();
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
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (CanInterrupt)
		{
			output.WriteRawTag(16);
			output.WriteBool(CanInterrupt);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (CanInterrupt)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Auto_Generate_Interrupt_Self other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.CanInterrupt)
			{
				CanInterrupt = other.CanInterrupt;
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
				ID = input.ReadInt32();
				break;
			case 16u:
				CanInterrupt = input.ReadBool();
				break;
			}
		}
	}
}
