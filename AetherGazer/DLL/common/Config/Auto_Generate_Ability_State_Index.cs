using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class Auto_Generate_Ability_State_Index : IMessage<Auto_Generate_Ability_State_Index>, IMessage, IEquatable<Auto_Generate_Ability_State_Index>, IDeepCloneable<Auto_Generate_Ability_State_Index>
{
	private static readonly MessageParser<Auto_Generate_Ability_State_Index> _parser = new MessageParser<Auto_Generate_Ability_State_Index>(() => new Auto_Generate_Ability_State_Index());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int GroupIndexFieldNumber = 2;

	private int groupIndex_;

	public const int DescribeFieldNumber = 3;

	private string describe_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<Auto_Generate_Ability_State_Index> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[13];

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
	public int GroupIndex
	{
		get
		{
			return groupIndex_;
		}
		set
		{
			groupIndex_ = value;
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
	public Auto_Generate_Ability_State_Index()
	{
	}

	[DebuggerNonUserCode]
	public Auto_Generate_Ability_State_Index(Auto_Generate_Ability_State_Index other)
		: this()
	{
		iD_ = other.iD_;
		groupIndex_ = other.groupIndex_;
		describe_ = other.describe_;
	}

	[DebuggerNonUserCode]
	public Auto_Generate_Ability_State_Index Clone()
	{
		return new Auto_Generate_Ability_State_Index(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Auto_Generate_Ability_State_Index);
	}

	[DebuggerNonUserCode]
	public bool Equals(Auto_Generate_Ability_State_Index other)
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
		if (GroupIndex != other.GroupIndex)
		{
			return false;
		}
		if (Describe != other.Describe)
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
		if (GroupIndex != 0)
		{
			num ^= GroupIndex.GetHashCode();
		}
		if (Describe.Length != 0)
		{
			num ^= Describe.GetHashCode();
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
		if (GroupIndex != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupIndex);
		}
		if (Describe.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Describe);
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
		if (GroupIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupIndex);
		}
		if (Describe.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Describe);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Auto_Generate_Ability_State_Index other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.GroupIndex != 0)
			{
				GroupIndex = other.GroupIndex;
			}
			if (other.Describe.Length != 0)
			{
				Describe = other.Describe;
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
				GroupIndex = input.ReadInt32();
				break;
			case 26u:
				Describe = input.ReadString();
				break;
			}
		}
	}
}
