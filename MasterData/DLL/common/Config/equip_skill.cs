using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class equip_skill : IMessage<equip_skill>, IMessage, IEquatable<equip_skill>, IDeepCloneable<equip_skill>
{
	private static readonly MessageParser<equip_skill> _parser = new MessageParser<equip_skill>(() => new equip_skill());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int DescSpecValueFieldNumber = 4;

	private string descSpecValue_ = "";

	public const int EquipEffectIdFieldNumber = 5;

	private int equipEffectId_;

	public const int AttributeFieldNumber = 6;

	private int attribute_;

	public const int UpgradeFieldNumber = 7;

	private int upgrade_;

	public const int LvmaxFieldNumber = 8;

	private int lvmax_;

	public const int PercentFieldNumber = 9;

	private int percent_;

	public const int IconFieldNumber = 10;

	private string icon_ = "";

	public const int TypeFieldNumber = 11;

	private int type_;

	public const int TypeInnerFieldNumber = 12;

	private int typeInner_;

	public const int SkillTypeFieldNumber = 13;

	private int skillType_;

	[DebuggerNonUserCode]
	public static MessageParser<equip_skill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[85];

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
	public string DescSpecValue
	{
		get
		{
			return descSpecValue_;
		}
		set
		{
			descSpecValue_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EquipEffectId
	{
		get
		{
			return equipEffectId_;
		}
		set
		{
			equipEffectId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Attribute
	{
		get
		{
			return attribute_;
		}
		set
		{
			attribute_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Upgrade
	{
		get
		{
			return upgrade_;
		}
		set
		{
			upgrade_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Lvmax
	{
		get
		{
			return lvmax_;
		}
		set
		{
			lvmax_ = value;
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
	public int TypeInner
	{
		get
		{
			return typeInner_;
		}
		set
		{
			typeInner_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillType
	{
		get
		{
			return skillType_;
		}
		set
		{
			skillType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public equip_skill()
	{
	}

	[DebuggerNonUserCode]
	public equip_skill(equip_skill other)
		: this()
	{
		iD_ = other.iD_;
		name_ = other.name_;
		desc_ = other.desc_;
		descSpecValue_ = other.descSpecValue_;
		equipEffectId_ = other.equipEffectId_;
		attribute_ = other.attribute_;
		upgrade_ = other.upgrade_;
		lvmax_ = other.lvmax_;
		percent_ = other.percent_;
		icon_ = other.icon_;
		type_ = other.type_;
		typeInner_ = other.typeInner_;
		skillType_ = other.skillType_;
	}

	[DebuggerNonUserCode]
	public equip_skill Clone()
	{
		return new equip_skill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as equip_skill);
	}

	[DebuggerNonUserCode]
	public bool Equals(equip_skill other)
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
		if (DescSpecValue != other.DescSpecValue)
		{
			return false;
		}
		if (EquipEffectId != other.EquipEffectId)
		{
			return false;
		}
		if (Attribute != other.Attribute)
		{
			return false;
		}
		if (Upgrade != other.Upgrade)
		{
			return false;
		}
		if (Lvmax != other.Lvmax)
		{
			return false;
		}
		if (Percent != other.Percent)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (TypeInner != other.TypeInner)
		{
			return false;
		}
		if (SkillType != other.SkillType)
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
		if (DescSpecValue.Length != 0)
		{
			num ^= DescSpecValue.GetHashCode();
		}
		if (EquipEffectId != 0)
		{
			num ^= EquipEffectId.GetHashCode();
		}
		if (Attribute != 0)
		{
			num ^= Attribute.GetHashCode();
		}
		if (Upgrade != 0)
		{
			num ^= Upgrade.GetHashCode();
		}
		if (Lvmax != 0)
		{
			num ^= Lvmax.GetHashCode();
		}
		if (Percent != 0)
		{
			num ^= Percent.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (TypeInner != 0)
		{
			num ^= TypeInner.GetHashCode();
		}
		if (SkillType != 0)
		{
			num ^= SkillType.GetHashCode();
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
		if (DescSpecValue.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(DescSpecValue);
		}
		if (EquipEffectId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(EquipEffectId);
		}
		if (Attribute != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Attribute);
		}
		if (Upgrade != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Upgrade);
		}
		if (Lvmax != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Lvmax);
		}
		if (Percent != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Percent);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(Icon);
		}
		if (Type != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Type);
		}
		if (TypeInner != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(TypeInner);
		}
		if (SkillType != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(SkillType);
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
		if (DescSpecValue.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DescSpecValue);
		}
		if (EquipEffectId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EquipEffectId);
		}
		if (Attribute != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Attribute);
		}
		if (Upgrade != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Upgrade);
		}
		if (Lvmax != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Lvmax);
		}
		if (Percent != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Percent);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (TypeInner != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TypeInner);
		}
		if (SkillType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillType);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(equip_skill other)
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
			if (other.DescSpecValue.Length != 0)
			{
				DescSpecValue = other.DescSpecValue;
			}
			if (other.EquipEffectId != 0)
			{
				EquipEffectId = other.EquipEffectId;
			}
			if (other.Attribute != 0)
			{
				Attribute = other.Attribute;
			}
			if (other.Upgrade != 0)
			{
				Upgrade = other.Upgrade;
			}
			if (other.Lvmax != 0)
			{
				Lvmax = other.Lvmax;
			}
			if (other.Percent != 0)
			{
				Percent = other.Percent;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.TypeInner != 0)
			{
				TypeInner = other.TypeInner;
			}
			if (other.SkillType != 0)
			{
				SkillType = other.SkillType;
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
			case 34u:
				DescSpecValue = input.ReadString();
				break;
			case 40u:
				EquipEffectId = input.ReadInt32();
				break;
			case 48u:
				Attribute = input.ReadInt32();
				break;
			case 56u:
				Upgrade = input.ReadInt32();
				break;
			case 64u:
				Lvmax = input.ReadInt32();
				break;
			case 72u:
				Percent = input.ReadInt32();
				break;
			case 82u:
				Icon = input.ReadString();
				break;
			case 88u:
				Type = input.ReadInt32();
				break;
			case 96u:
				TypeInner = input.ReadInt32();
				break;
			case 104u:
				SkillType = input.ReadInt32();
				break;
			}
		}
	}
}
