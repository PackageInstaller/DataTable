using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class HitFeedback : IMessage<HitFeedback>, IMessage, IEquatable<HitFeedback>, IDeepCloneable<HitFeedback>
{
	private static readonly MessageParser<HitFeedback> _parser = new MessageParser<HitFeedback>(() => new HitFeedback());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DefaultAnimationNameFieldNumber = 2;

	private string defaultAnimationName_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<HitFeedback> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[30];

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
	public string DefaultAnimationName
	{
		get
		{
			return defaultAnimationName_;
		}
		set
		{
			defaultAnimationName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public HitFeedback()
	{
	}

	[DebuggerNonUserCode]
	public HitFeedback(HitFeedback other)
		: this()
	{
		iD_ = other.iD_;
		defaultAnimationName_ = other.defaultAnimationName_;
	}

	[DebuggerNonUserCode]
	public HitFeedback Clone()
	{
		return new HitFeedback(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as HitFeedback);
	}

	[DebuggerNonUserCode]
	public bool Equals(HitFeedback other)
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
		if (DefaultAnimationName != other.DefaultAnimationName)
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
		if (DefaultAnimationName.Length != 0)
		{
			num ^= DefaultAnimationName.GetHashCode();
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
		if (DefaultAnimationName.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(DefaultAnimationName);
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
		if (DefaultAnimationName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DefaultAnimationName);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(HitFeedback other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.DefaultAnimationName.Length != 0)
			{
				DefaultAnimationName = other.DefaultAnimationName;
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
				DefaultAnimationName = input.ReadString();
				break;
			}
		}
	}
}
