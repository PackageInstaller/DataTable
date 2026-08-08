using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Race : IMessage<Race>, IMessage, IEquatable<Race>, IDeepCloneable<Race>
{
	private static readonly MessageParser<Race> _parser = new MessageParser<Race>(() => new Race());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DescribeFieldNumber = 2;

	private string describe_ = "";

	public const int SoueceSpaceIdFieldNumber = 3;

	private int soueceSpaceId_;

	[DebuggerNonUserCode]
	public static MessageParser<Race> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[47];

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
	public string Describe
	{
		get
		{
			return describe_;
		}
		set
		{
			describe_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SoueceSpaceId
	{
		get
		{
			return soueceSpaceId_;
		}
		set
		{
			soueceSpaceId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Race()
	{
	}

	[DebuggerNonUserCode]
	public Race(Race other)
		: this()
	{
		iD_ = other.iD_;
		describe_ = other.describe_;
		soueceSpaceId_ = other.soueceSpaceId_;
	}

	[DebuggerNonUserCode]
	public Race Clone()
	{
		return new Race(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Race);
	}

	[DebuggerNonUserCode]
	public bool Equals(Race other)
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
		if (Describe != other.Describe)
		{
			return false;
		}
		if (SoueceSpaceId != other.SoueceSpaceId)
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
		if (Describe.Length != 0)
		{
			num ^= Describe.GetHashCode();
		}
		if (SoueceSpaceId != 0)
		{
			num ^= SoueceSpaceId.GetHashCode();
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
		if (Describe.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Describe);
		}
		if (SoueceSpaceId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SoueceSpaceId);
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
		if (Describe.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Describe);
		}
		if (SoueceSpaceId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SoueceSpaceId);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Race other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Describe.Length != 0)
			{
				Describe = other.Describe;
			}
			if (other.SoueceSpaceId != 0)
			{
				SoueceSpaceId = other.SoueceSpaceId;
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
			case 18u:
				Describe = input.ReadString();
				break;
			case 24u:
				SoueceSpaceId = input.ReadInt32();
				break;
			}
		}
	}
}
