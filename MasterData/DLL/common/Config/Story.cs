using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Story : IMessage<Story>, IMessage, IEquatable<Story>, IDeepCloneable<Story>
{
	private static readonly MessageParser<Story> _parser = new MessageParser<Story>(() => new Story());

	public const int IDFieldNumber = 1;

	private int iD_;

	[DebuggerNonUserCode]
	public static MessageParser<Story> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[59];

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
	public Story()
	{
	}

	[DebuggerNonUserCode]
	public Story(Story other)
		: this()
	{
		iD_ = other.iD_;
	}

	[DebuggerNonUserCode]
	public Story Clone()
	{
		return new Story(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Story);
	}

	[DebuggerNonUserCode]
	public bool Equals(Story other)
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
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Story other)
	{
		if (other != null && other.ID != 0)
		{
			ID = other.ID;
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
				ID = input.ReadInt32();
			}
		}
	}
}
