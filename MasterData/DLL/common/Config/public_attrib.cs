using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class public_attrib : IMessage<public_attrib>, IMessage, IEquatable<public_attrib>, IDeepCloneable<public_attrib>
{
	private static readonly MessageParser<public_attrib> _parser = new MessageParser<public_attrib>(() => new public_attrib());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int PercentFieldNumber = 2;

	private int percent_;

	public const int LimitFieldNumber = 3;

	private int limit_;

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<public_attrib> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[87];

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
	public int Percent
	{
		get
		{
			return percent_;
		}
		set
		{
			percent_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Limit
	{
		get
		{
			return limit_;
		}
		set
		{
			limit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public public_attrib()
	{
	}

	[DebuggerNonUserCode]
	public public_attrib(public_attrib other)
		: this()
	{
		iD_ = other.iD_;
		percent_ = other.percent_;
		limit_ = other.limit_;
		icon_ = other.icon_;
	}

	[DebuggerNonUserCode]
	public public_attrib Clone()
	{
		return new public_attrib(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as public_attrib);
	}

	[DebuggerNonUserCode]
	public bool Equals(public_attrib other)
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
		if (Percent != other.Percent)
		{
			return false;
		}
		if (Limit != other.Limit)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (Percent != 0)
		{
			num ^= Percent.GetHashCode();
		}
		if (Limit != 0)
		{
			num ^= Limit.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (Percent != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Percent);
		}
		if (Limit != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Limit);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
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
		if (Percent != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Percent);
		}
		if (Limit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Limit);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(public_attrib other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Percent != 0)
			{
				Percent = other.Percent;
			}
			if (other.Limit != 0)
			{
				Limit = other.Limit;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				Percent = input.ReadInt32();
				break;
			case 24u:
				Limit = input.ReadInt32();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
