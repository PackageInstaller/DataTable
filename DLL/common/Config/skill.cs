using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class skill : IMessage<skill>, IMessage, IEquatable<skill>, IDeepCloneable<skill>
{
	private static readonly MessageParser<skill> _parser = new MessageParser<skill>(() => new skill());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int SimpleDescFieldNumber = 3;

	private string simpleDesc_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<skill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[92];

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
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SimpleDesc
	{
		get
		{
			return simpleDesc_;
		}
		set
		{
			simpleDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public skill()
	{
	}

	[DebuggerNonUserCode]
	public skill(skill other)
		: this()
	{
		iD_ = other.iD_;
		name_ = other.name_;
		simpleDesc_ = other.simpleDesc_;
	}

	[DebuggerNonUserCode]
	public skill Clone()
	{
		return new skill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as skill);
	}

	[DebuggerNonUserCode]
	public bool Equals(skill other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (SimpleDesc != other.SimpleDesc)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (SimpleDesc.Length != 0)
		{
			num ^= SimpleDesc.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (SimpleDesc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(SimpleDesc);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (SimpleDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SimpleDesc);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(skill other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.SimpleDesc.Length != 0)
			{
				SimpleDesc = other.SimpleDesc;
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
				Name = input.ReadString();
				break;
			case 26u:
				SimpleDesc = input.ReadString();
				break;
			}
		}
	}
}
