using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class battle_record_data_type : IMessage<battle_record_data_type>, IMessage, IEquatable<battle_record_data_type>, IDeepCloneable<battle_record_data_type>
{
	private static readonly MessageParser<battle_record_data_type> _parser = new MessageParser<battle_record_data_type>(() => new battle_record_data_type());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int TypeIdFieldNumber = 2;

	private int typeId_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<battle_record_data_type> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[79];

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
	public int TypeId
	{
		get
		{
			return typeId_;
		}
		set
		{
			typeId_ = value;
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
	public battle_record_data_type()
	{
	}

	[DebuggerNonUserCode]
	public battle_record_data_type(battle_record_data_type other)
		: this()
	{
		iD_ = other.iD_;
		typeId_ = other.typeId_;
		name_ = other.name_;
	}

	[DebuggerNonUserCode]
	public battle_record_data_type Clone()
	{
		return new battle_record_data_type(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as battle_record_data_type);
	}

	[DebuggerNonUserCode]
	public bool Equals(battle_record_data_type other)
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
		if (TypeId != other.TypeId)
		{
			return false;
		}
		if (Name != other.Name)
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
		if (TypeId != 0)
		{
			num ^= TypeId.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
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
		if (TypeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TypeId);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
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
		if (TypeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TypeId);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(battle_record_data_type other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.TypeId != 0)
			{
				TypeId = other.TypeId;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
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
				TypeId = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			}
		}
	}
}
