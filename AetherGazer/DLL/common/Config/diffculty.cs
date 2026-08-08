using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class diffculty : IMessage<diffculty>, IMessage, IEquatable<diffculty>, IDeepCloneable<diffculty>
{
	private static readonly MessageParser<diffculty> _parser = new MessageParser<diffculty>(() => new diffculty());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int A1FieldNumber = 2;

	private int a1_;

	public const int A2FieldNumber = 3;

	private int a2_;

	public const int B1FieldNumber = 4;

	private int b1_;

	public const int B2FieldNumber = 5;

	private int b2_;

	public const int B3FieldNumber = 6;

	private int b3_;

	public const int D1FieldNumber = 7;

	private int d1_;

	public const int D2FieldNumber = 8;

	private int d2_;

	[DebuggerNonUserCode]
	public static MessageParser<diffculty> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[83];

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
	public int A1
	{
		get
		{
			return a1_;
		}
		set
		{
			a1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int A2
	{
		get
		{
			return a2_;
		}
		set
		{
			a2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int B1
	{
		get
		{
			return b1_;
		}
		set
		{
			b1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int B2
	{
		get
		{
			return b2_;
		}
		set
		{
			b2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int B3
	{
		get
		{
			return b3_;
		}
		set
		{
			b3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int D1
	{
		get
		{
			return d1_;
		}
		set
		{
			d1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int D2
	{
		get
		{
			return d2_;
		}
		set
		{
			d2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public diffculty()
	{
	}

	[DebuggerNonUserCode]
	public diffculty(diffculty other)
		: this()
	{
		iD_ = other.iD_;
		a1_ = other.a1_;
		a2_ = other.a2_;
		b1_ = other.b1_;
		b2_ = other.b2_;
		b3_ = other.b3_;
		d1_ = other.d1_;
		d2_ = other.d2_;
	}

	[DebuggerNonUserCode]
	public diffculty Clone()
	{
		return new diffculty(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as diffculty);
	}

	[DebuggerNonUserCode]
	public bool Equals(diffculty other)
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
		if (A1 != other.A1)
		{
			return false;
		}
		if (A2 != other.A2)
		{
			return false;
		}
		if (B1 != other.B1)
		{
			return false;
		}
		if (B2 != other.B2)
		{
			return false;
		}
		if (B3 != other.B3)
		{
			return false;
		}
		if (D1 != other.D1)
		{
			return false;
		}
		if (D2 != other.D2)
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
		if (A1 != 0)
		{
			num ^= A1.GetHashCode();
		}
		if (A2 != 0)
		{
			num ^= A2.GetHashCode();
		}
		if (B1 != 0)
		{
			num ^= B1.GetHashCode();
		}
		if (B2 != 0)
		{
			num ^= B2.GetHashCode();
		}
		if (B3 != 0)
		{
			num ^= B3.GetHashCode();
		}
		if (D1 != 0)
		{
			num ^= D1.GetHashCode();
		}
		if (D2 != 0)
		{
			num ^= D2.GetHashCode();
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
		if (A1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(A1);
		}
		if (A2 != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(A2);
		}
		if (B1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(B1);
		}
		if (B2 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(B2);
		}
		if (B3 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(B3);
		}
		if (D1 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(D1);
		}
		if (D2 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(D2);
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
		if (A1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(A1);
		}
		if (A2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(A2);
		}
		if (B1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(B1);
		}
		if (B2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(B2);
		}
		if (B3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(B3);
		}
		if (D1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(D1);
		}
		if (D2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(D2);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(diffculty other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.A1 != 0)
			{
				A1 = other.A1;
			}
			if (other.A2 != 0)
			{
				A2 = other.A2;
			}
			if (other.B1 != 0)
			{
				B1 = other.B1;
			}
			if (other.B2 != 0)
			{
				B2 = other.B2;
			}
			if (other.B3 != 0)
			{
				B3 = other.B3;
			}
			if (other.D1 != 0)
			{
				D1 = other.D1;
			}
			if (other.D2 != 0)
			{
				D2 = other.D2;
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
				A1 = input.ReadInt32();
				break;
			case 24u:
				A2 = input.ReadInt32();
				break;
			case 32u:
				B1 = input.ReadInt32();
				break;
			case 40u:
				B2 = input.ReadInt32();
				break;
			case 48u:
				B3 = input.ReadInt32();
				break;
			case 56u:
				D1 = input.ReadInt32();
				break;
			case 64u:
				D2 = input.ReadInt32();
				break;
			}
		}
	}
}
