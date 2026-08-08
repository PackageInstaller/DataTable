using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class activity_tower_defense_tower : IMessage<activity_tower_defense_tower>, IMessage, IEquatable<activity_tower_defense_tower>, IDeepCloneable<activity_tower_defense_tower>
{
	private static readonly MessageParser<activity_tower_defense_tower> _parser = new MessageParser<activity_tower_defense_tower>(() => new activity_tower_defense_tower());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int TypeFieldNumber = 3;

	private int type_;

	public const int IconFieldNumber = 4;

	private string icon_ = "";

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int ConditionFieldNumber = 7;

	private int condition_;

	public const int IconBattleFieldNumber = 8;

	private string iconBattle_ = "";

	public const int DescBattleFieldNumber = 9;

	private static readonly FieldCodec<string> _repeated_descBattle_codec = FieldCodec.ForString(74u);

	private readonly RepeatedField<string> descBattle_ = new RepeatedField<string>();

	public const int UpgradeCostFieldNumber = 10;

	private int upgradeCost_;

	public const int DismantleReturnFieldNumber = 11;

	private int dismantleReturn_;

	public const int SubTypeFieldNumber = 12;

	private int subType_;

	public const int MiniTipFieldNumber = 13;

	private string miniTip_ = "";

	public const int SubArrayFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_subArray_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> subArray_ = new RepeatedField<int>();

	public const int TitleFieldNumber = 15;

	private string title_ = "";

	public const int RoleIdFieldNumber = 16;

	private int roleId_;

	public const int BuffConfigIdFieldNumber = 17;

	private int buffConfigId_;

	public const int UpgradeCountLimitFieldNumber = 18;

	private int upgradeCountLimit_;

	public const int AttackRangeFieldNumber = 19;

	private int attackRange_;

	[DebuggerNonUserCode]
	public static MessageParser<activity_tower_defense_tower> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[75];

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
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
	public int Condition
	{
		get
		{
			return condition_;
		}
		set
		{
			condition_ = value;
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
	public RepeatedField<string> DescBattle => descBattle_;

	[DebuggerNonUserCode]
	public int UpgradeCost
	{
		get
		{
			return upgradeCost_;
		}
		set
		{
			upgradeCost_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DismantleReturn
	{
		get
		{
			return dismantleReturn_;
		}
		set
		{
			dismantleReturn_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubType
	{
		get
		{
			return subType_;
		}
		set
		{
			subType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string MiniTip
	{
		get
		{
			return miniTip_;
		}
		set
		{
			miniTip_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SubArray => subArray_;

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int RoleId
	{
		get
		{
			return roleId_;
		}
		set
		{
			roleId_ = value;
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
	public int UpgradeCountLimit
	{
		get
		{
			return upgradeCountLimit_;
		}
		set
		{
			upgradeCountLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttackRange
	{
		get
		{
			return attackRange_;
		}
		set
		{
			attackRange_ = value;
		}
	}

	[DebuggerNonUserCode]
	public activity_tower_defense_tower()
	{
	}

	[DebuggerNonUserCode]
	public activity_tower_defense_tower(activity_tower_defense_tower other)
		: this()
	{
		iD_ = other.iD_;
		activityId_ = other.activityId_;
		type_ = other.type_;
		icon_ = other.icon_;
		name_ = other.name_;
		desc_ = other.desc_;
		condition_ = other.condition_;
		iconBattle_ = other.iconBattle_;
		descBattle_ = other.descBattle_.Clone();
		upgradeCost_ = other.upgradeCost_;
		dismantleReturn_ = other.dismantleReturn_;
		subType_ = other.subType_;
		miniTip_ = other.miniTip_;
		subArray_ = other.subArray_.Clone();
		title_ = other.title_;
		roleId_ = other.roleId_;
		buffConfigId_ = other.buffConfigId_;
		upgradeCountLimit_ = other.upgradeCountLimit_;
		attackRange_ = other.attackRange_;
	}

	[DebuggerNonUserCode]
	public activity_tower_defense_tower Clone()
	{
		return new activity_tower_defense_tower(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as activity_tower_defense_tower);
	}

	[DebuggerNonUserCode]
	public bool Equals(activity_tower_defense_tower other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (Condition != other.Condition)
		{
			return false;
		}
		if (IconBattle != other.IconBattle)
		{
			return false;
		}
		if (!descBattle_.Equals(other.descBattle_))
		{
			return false;
		}
		if (UpgradeCost != other.UpgradeCost)
		{
			return false;
		}
		if (DismantleReturn != other.DismantleReturn)
		{
			return false;
		}
		if (SubType != other.SubType)
		{
			return false;
		}
		if (MiniTip != other.MiniTip)
		{
			return false;
		}
		if (!subArray_.Equals(other.subArray_))
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (RoleId != other.RoleId)
		{
			return false;
		}
		if (BuffConfigId != other.BuffConfigId)
		{
			return false;
		}
		if (UpgradeCountLimit != other.UpgradeCountLimit)
		{
			return false;
		}
		if (AttackRange != other.AttackRange)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Condition != 0)
		{
			num ^= Condition.GetHashCode();
		}
		if (IconBattle.Length != 0)
		{
			num ^= IconBattle.GetHashCode();
		}
		num ^= descBattle_.GetHashCode();
		if (UpgradeCost != 0)
		{
			num ^= UpgradeCost.GetHashCode();
		}
		if (DismantleReturn != 0)
		{
			num ^= DismantleReturn.GetHashCode();
		}
		if (SubType != 0)
		{
			num ^= SubType.GetHashCode();
		}
		if (MiniTip.Length != 0)
		{
			num ^= MiniTip.GetHashCode();
		}
		num ^= subArray_.GetHashCode();
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (RoleId != 0)
		{
			num ^= RoleId.GetHashCode();
		}
		if (BuffConfigId != 0)
		{
			num ^= BuffConfigId.GetHashCode();
		}
		if (UpgradeCountLimit != 0)
		{
			num ^= UpgradeCountLimit.GetHashCode();
		}
		if (AttackRange != 0)
		{
			num ^= AttackRange.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (Type != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Type);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Icon);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (Condition != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Condition);
		}
		if (IconBattle.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(IconBattle);
		}
		descBattle_.WriteTo(output, _repeated_descBattle_codec);
		if (UpgradeCost != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(UpgradeCost);
		}
		if (DismantleReturn != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(DismantleReturn);
		}
		if (SubType != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(SubType);
		}
		if (MiniTip.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(MiniTip);
		}
		subArray_.WriteTo(output, _repeated_subArray_codec);
		if (Title.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(Title);
		}
		if (RoleId != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(RoleId);
		}
		if (BuffConfigId != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(BuffConfigId);
		}
		if (UpgradeCountLimit != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(UpgradeCountLimit);
		}
		if (AttackRange != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(AttackRange);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Condition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Condition);
		}
		if (IconBattle.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconBattle);
		}
		num += descBattle_.CalculateSize(_repeated_descBattle_codec);
		if (UpgradeCost != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UpgradeCost);
		}
		if (DismantleReturn != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DismantleReturn);
		}
		if (SubType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubType);
		}
		if (MiniTip.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(MiniTip);
		}
		num += subArray_.CalculateSize(_repeated_subArray_codec);
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (RoleId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RoleId);
		}
		if (BuffConfigId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BuffConfigId);
		}
		if (UpgradeCountLimit != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(UpgradeCountLimit);
		}
		if (AttackRange != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AttackRange);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(activity_tower_defense_tower other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Condition != 0)
			{
				Condition = other.Condition;
			}
			if (other.IconBattle.Length != 0)
			{
				IconBattle = other.IconBattle;
			}
			descBattle_.Add(other.descBattle_);
			if (other.UpgradeCost != 0)
			{
				UpgradeCost = other.UpgradeCost;
			}
			if (other.DismantleReturn != 0)
			{
				DismantleReturn = other.DismantleReturn;
			}
			if (other.SubType != 0)
			{
				SubType = other.SubType;
			}
			if (other.MiniTip.Length != 0)
			{
				MiniTip = other.MiniTip;
			}
			subArray_.Add(other.subArray_);
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.RoleId != 0)
			{
				RoleId = other.RoleId;
			}
			if (other.BuffConfigId != 0)
			{
				BuffConfigId = other.BuffConfigId;
			}
			if (other.UpgradeCountLimit != 0)
			{
				UpgradeCountLimit = other.UpgradeCountLimit;
			}
			if (other.AttackRange != 0)
			{
				AttackRange = other.AttackRange;
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
				ActivityId = input.ReadInt32();
				break;
			case 24u:
				Type = input.ReadInt32();
				break;
			case 34u:
				Icon = input.ReadString();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 56u:
				Condition = input.ReadInt32();
				break;
			case 66u:
				IconBattle = input.ReadString();
				break;
			case 74u:
				descBattle_.AddEntriesFrom(input, _repeated_descBattle_codec);
				break;
			case 80u:
				UpgradeCost = input.ReadInt32();
				break;
			case 88u:
				DismantleReturn = input.ReadInt32();
				break;
			case 96u:
				SubType = input.ReadInt32();
				break;
			case 106u:
				MiniTip = input.ReadString();
				break;
			case 112u:
			case 114u:
				subArray_.AddEntriesFrom(input, _repeated_subArray_codec);
				break;
			case 122u:
				Title = input.ReadString();
				break;
			case 128u:
				RoleId = input.ReadInt32();
				break;
			case 136u:
				BuffConfigId = input.ReadInt32();
				break;
			case 144u:
				UpgradeCountLimit = input.ReadInt32();
				break;
			case 152u:
				AttackRange = input.ReadInt32();
				break;
			}
		}
	}
}
