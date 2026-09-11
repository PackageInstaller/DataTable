using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Item : IMessage<Item>, IMessage, IEquatable<Item>, IDeepCloneable<Item>
{
	private static readonly MessageParser<Item> _parser = new MessageParser<Item>(() => new Item());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int DescribeFieldNumber = 2;

	private string describe_ = "";

	public const int SystemIdFieldNumber = 3;

	private int systemId_;

	[DebuggerNonUserCode]
	public static MessageParser<Item> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[35];

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
	public int SystemId
	{
		get
		{
			return systemId_;
		}
		set
		{
			systemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Item()
	{
	}

	[DebuggerNonUserCode]
	public Item(Item other)
		: this()
	{
		iD_ = other.iD_;
		describe_ = other.describe_;
		systemId_ = other.systemId_;
	}

	[DebuggerNonUserCode]
	public Item Clone()
	{
		return new Item(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Item);
	}

	[DebuggerNonUserCode]
	public bool Equals(Item other)
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
		if (SystemId != other.SystemId)
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
		if (SystemId != 0)
		{
			num ^= SystemId.GetHashCode();
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
		if (SystemId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SystemId);
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
		if (SystemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SystemId);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Item other)
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
			if (other.SystemId != 0)
			{
				SystemId = other.SystemId;
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
				SystemId = input.ReadInt32();
				break;
			}
		}
	}
}
