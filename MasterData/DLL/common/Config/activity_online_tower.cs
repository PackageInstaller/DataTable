using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class activity_online_tower : IMessage<activity_online_tower>, IMessage, IEquatable<activity_online_tower>, IDeepCloneable<activity_online_tower>
{
	private static readonly MessageParser<activity_online_tower> _parser = new MessageParser<activity_online_tower>(() => new activity_online_tower());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int RareFieldNumber = 3;

	private int rare_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int IconBattleFieldNumber = 5;

	private string iconBattle_ = "";

	public const int DescBattleFieldNumber = 6;

	private string descBattle_ = "";

	public const int CostFieldNumber = 7;

	private int cost_;

	public const int BuffConfigIdFieldNumber = 8;

	private int buffConfigId_;

	public const int AddTypeFieldNumber = 9;

	private int addType_;

	[DebuggerNonUserCode]
	public static MessageParser<activity_online_tower> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[72];

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rare
	{
		get
		{
			return rare_;
		}
		set
		{
			rare_ = value;
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
	public string IconBattle
	{
		get
		{
			return iconBattle_;
		}
		set
		{
			iconBattle_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string DescBattle
	{
		get
		{
			return descBattle_;
		}
		set
		{
			descBattle_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Cost
	{
		get
		{
			return cost_;
		}
		set
		{
			cost_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffConfigId
	{
		get
		{
			return buffConfigId_;
		}
		set
		{
			buffConfigId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AddType
	{
		get
		{
			return addType_;
		}
		set
		{
			addType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public activity_online_tower()
	{
	}

	[DebuggerNonUserCode]
	public activity_online_tower(activity_online_tower other)
		: this()
	{
		iD_ = other.iD_;
		type_ = other.type_;
		rare_ = other.rare_;
		name_ = other.name_;
		iconBattle_ = other.iconBattle_;
		descBattle_ = other.descBattle_;
		cost_ = other.cost_;
		buffConfigId_ = other.buffConfigId_;
		addType_ = other.addType_;
	}

	[DebuggerNonUserCode]
	public activity_online_tower Clone()
	{
		return new activity_online_tower(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as activity_online_tower);
	}

	[DebuggerNonUserCode]
	public bool Equals(activity_online_tower other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (Rare != other.Rare)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (IconBattle != other.IconBattle)
		{
			return false;
		}
		if (DescBattle != other.DescBattle)
		{
			return false;
		}
		if (Cost != other.Cost)
		{
			return false;
		}
		if (BuffConfigId != other.BuffConfigId)
		{
			return false;
		}
		if (AddType != other.AddType)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Rare != 0)
		{
			num ^= Rare.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (IconBattle.Length != 0)
		{
			num ^= IconBattle.GetHashCode();
		}
		if (DescBattle.Length != 0)
		{
			num ^= DescBattle.GetHashCode();
		}
		if (Cost != 0)
		{
			num ^= Cost.GetHashCode();
		}
		if (BuffConfigId != 0)
		{
			num ^= BuffConfigId.GetHashCode();
		}
		if (AddType != 0)
		{
			num ^= AddType.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (Rare != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Rare);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (IconBattle.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(IconBattle);
		}
		if (DescBattle.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(DescBattle);
		}
		if (Cost != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Cost);
		}
		if (BuffConfigId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(BuffConfigId);
		}
		if (AddType != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AddType);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Rare != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rare);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (IconBattle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconBattle);
		}
		if (DescBattle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescBattle);
		}
		if (Cost != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cost);
		}
		if (BuffConfigId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffConfigId);
		}
		if (AddType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddType);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(activity_online_tower other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Rare != 0)
			{
				Rare = other.Rare;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.IconBattle.Length != 0)
			{
				IconBattle = other.IconBattle;
			}
			if (other.DescBattle.Length != 0)
			{
				DescBattle = other.DescBattle;
			}
			if (other.Cost != 0)
			{
				Cost = other.Cost;
			}
			if (other.BuffConfigId != 0)
			{
				BuffConfigId = other.BuffConfigId;
			}
			if (other.AddType != 0)
			{
				AddType = other.AddType;
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
				Type = input.ReadInt32();
				break;
			case 24u:
				Rare = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				IconBattle = input.ReadString();
				break;
			case 50u:
				DescBattle = input.ReadString();
				break;
			case 56u:
				Cost = input.ReadInt32();
				break;
			case 64u:
				BuffConfigId = input.ReadInt32();
				break;
			case 72u:
				AddType = input.ReadInt32();
				break;
			}
		}
	}
}
