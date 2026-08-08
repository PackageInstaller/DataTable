using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Int3 : IMessage<Int3>, IMessage, IEquatable<Int3>, IDeepCloneable<Int3>
{
	private static readonly MessageParser<Int3> _parser = new MessageParser<Int3>(() => new Int3());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int XFieldNumber = 2;

	private int x_;

	public const int YFieldNumber = 3;

	private int y_;

	public const int ZFieldNumber = 4;

	private int z_;

	[DebuggerNonUserCode]
	public static MessageParser<Int3> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[33];

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
	public int X
	{
		get
		{
			return x_;
		}
		set
		{
			x_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Y
	{
		get
		{
			return y_;
		}
		set
		{
			y_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Z
	{
		get
		{
			return z_;
		}
		set
		{
			z_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Int3()
	{
	}

	[DebuggerNonUserCode]
	public Int3(Int3 other)
		: this()
	{
		iD_ = other.iD_;
		x_ = other.x_;
		y_ = other.y_;
		z_ = other.z_;
	}

	[DebuggerNonUserCode]
	public Int3 Clone()
	{
		return new Int3(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Int3);
	}

	[DebuggerNonUserCode]
	public bool Equals(Int3 other)
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
		if (X != other.X)
		{
			return false;
		}
		if (Y != other.Y)
		{
			return false;
		}
		if (Z != other.Z)
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
		if (X != 0)
		{
			num ^= X.GetHashCode();
		}
		if (Y != 0)
		{
			num ^= Y.GetHashCode();
		}
		if (Z != 0)
		{
			num ^= Z.GetHashCode();
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
		if (X != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(X);
		}
		if (Y != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Y);
		}
		if (Z != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Z);
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
		if (X != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(X);
		}
		if (Y != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Y);
		}
		if (Z != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Z);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Int3 other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.X != 0)
			{
				X = other.X;
			}
			if (other.Y != 0)
			{
				Y = other.Y;
			}
			if (other.Z != 0)
			{
				Z = other.Z;
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
				X = input.ReadInt32();
				break;
			case 24u:
				Y = input.ReadInt32();
				break;
			case 32u:
				Z = input.ReadInt32();
				break;
			}
		}
	}
}
