using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

public sealed class ProtoInt3 : IMessage<ProtoInt3>, IMessage, IEquatable<ProtoInt3>, IDeepCloneable<ProtoInt3>
{
	private static readonly MessageParser<ProtoInt3> _parser = new MessageParser<ProtoInt3>(() => new ProtoInt3());

	public const int XFieldNumber = 1;

	private int x_;

	public const int YFieldNumber = 2;

	private int y_;

	public const int ZFieldNumber = 3;

	private int z_;

	[DebuggerNonUserCode]
	public static MessageParser<ProtoInt3> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => BlackboardReflection.Descriptor.MessageTypes[9];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

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
	public ProtoInt3()
	{
	}

	[DebuggerNonUserCode]
	public ProtoInt3(ProtoInt3 other)
		: this()
	{
		x_ = other.x_;
		y_ = other.y_;
		z_ = other.z_;
	}

	[DebuggerNonUserCode]
	public ProtoInt3 Clone()
	{
		return new ProtoInt3(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ProtoInt3);
	}

	[DebuggerNonUserCode]
	public bool Equals(ProtoInt3 other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
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
		if (X != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(X);
		}
		if (Y != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Y);
		}
		if (Z != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Z);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
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
	public void MergeFrom(ProtoInt3 other)
	{
		if (other != null)
		{
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
				X = input.ReadInt32();
				break;
			case 16u:
				Y = input.ReadInt32();
				break;
			case 24u:
				Z = input.ReadInt32();
				break;
			}
		}
	}
}
