using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class battle_achievement : IMessage<battle_achievement>, IMessage, IEquatable<battle_achievement>, IDeepCloneable<battle_achievement>
{
	private static readonly MessageParser<battle_achievement> _parser = new MessageParser<battle_achievement>(() => new battle_achievement());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int RewardFieldNumber = 4;

	private int reward_;

	public const int PriorityFieldNumber = 5;

	private int priority_;

	public const int LevelFieldNumber = 6;

	private int level_;

	[DebuggerNonUserCode]
	public static MessageParser<battle_achievement> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[78];

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
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Reward
	{
		get
		{
			return reward_;
		}
		set
		{
			reward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Priority
	{
		get
		{
			return priority_;
		}
		set
		{
			priority_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public battle_achievement()
	{
	}

	[DebuggerNonUserCode]
	public battle_achievement(battle_achievement other)
		: this()
	{
		iD_ = other.iD_;
		name_ = other.name_;
		desc_ = other.desc_;
		reward_ = other.reward_;
		priority_ = other.priority_;
		level_ = other.level_;
	}

	[DebuggerNonUserCode]
	public battle_achievement Clone()
	{
		return new battle_achievement(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as battle_achievement);
	}

	[DebuggerNonUserCode]
	public bool Equals(battle_achievement other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Reward != other.Reward)
		{
			return false;
		}
		if (Priority != other.Priority)
		{
			return false;
		}
		if (Level != other.Level)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Reward != 0)
		{
			num ^= Reward.GetHashCode();
		}
		if (Priority != 0)
		{
			num ^= Priority.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (Reward != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Reward);
		}
		if (Priority != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Priority);
		}
		if (Level != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Level);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Reward != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward);
		}
		if (Priority != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Priority);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(battle_achievement other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Reward != 0)
			{
				Reward = other.Reward;
			}
			if (other.Priority != 0)
			{
				Priority = other.Priority;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
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
				Desc = input.ReadString();
				break;
			case 32u:
				Reward = input.ReadInt32();
				break;
			case 40u:
				Priority = input.ReadInt32();
				break;
			case 48u:
				Level = input.ReadInt32();
				break;
			}
		}
	}
}
