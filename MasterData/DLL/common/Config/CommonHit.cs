using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class CommonHit : IMessage<CommonHit>, IMessage, IEquatable<CommonHit>, IDeepCloneable<CommonHit>
{
	private static readonly MessageParser<CommonHit> _parser = new MessageParser<CommonHit>(() => new CommonHit());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int WeaponCategoryFieldNumber = 2;

	private WeaponCategory weaponCategory_;

	public const int AttackActionCategoryFieldNumber = 3;

	private AttackActionCategory attackActionCategory_;

	public const int SkillDamageTypeFieldNumber = 4;

	private SkillDamageType skillDamageType_;

	public const int ArmourCategoryFieldNumber = 5;

	private ArmourCategory armourCategory_;

	public const int AudioIDFieldNumber = 6;

	private int audioID_;

	public const int EffectPathIDFieldNumber = 7;

	private int effectPathID_;

	[DebuggerNonUserCode]
	public static MessageParser<CommonHit> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[26];

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
	public WeaponCategory WeaponCategory
	{
		get
		{
			return weaponCategory_;
		}
		set
		{
			weaponCategory_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AttackActionCategory AttackActionCategory
	{
		get
		{
			return attackActionCategory_;
		}
		set
		{
			attackActionCategory_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SkillDamageType SkillDamageType
	{
		get
		{
			return skillDamageType_;
		}
		set
		{
			skillDamageType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ArmourCategory ArmourCategory
	{
		get
		{
			return armourCategory_;
		}
		set
		{
			armourCategory_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AudioID
	{
		get
		{
			return audioID_;
		}
		set
		{
			audioID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EffectPathID
	{
		get
		{
			return effectPathID_;
		}
		set
		{
			effectPathID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CommonHit()
	{
	}

	[DebuggerNonUserCode]
	public CommonHit(CommonHit other)
		: this()
	{
		iD_ = other.iD_;
		weaponCategory_ = other.weaponCategory_;
		attackActionCategory_ = other.attackActionCategory_;
		skillDamageType_ = other.skillDamageType_;
		armourCategory_ = other.armourCategory_;
		audioID_ = other.audioID_;
		effectPathID_ = other.effectPathID_;
	}

	[DebuggerNonUserCode]
	public CommonHit Clone()
	{
		return new CommonHit(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CommonHit);
	}

	[DebuggerNonUserCode]
	public bool Equals(CommonHit other)
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
		if (WeaponCategory != other.WeaponCategory)
		{
			return false;
		}
		if (AttackActionCategory != other.AttackActionCategory)
		{
			return false;
		}
		if (SkillDamageType != other.SkillDamageType)
		{
			return false;
		}
		if (ArmourCategory != other.ArmourCategory)
		{
			return false;
		}
		if (AudioID != other.AudioID)
		{
			return false;
		}
		if (EffectPathID != other.EffectPathID)
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
		if (WeaponCategory != WeaponCategory.None)
		{
			num ^= WeaponCategory.GetHashCode();
		}
		if (AttackActionCategory != AttackActionCategory.None)
		{
			num ^= AttackActionCategory.GetHashCode();
		}
		if (SkillDamageType != SkillDamageType.Physics)
		{
			num ^= SkillDamageType.GetHashCode();
		}
		if (ArmourCategory != ArmourCategory.None)
		{
			num ^= ArmourCategory.GetHashCode();
		}
		if (AudioID != 0)
		{
			num ^= AudioID.GetHashCode();
		}
		if (EffectPathID != 0)
		{
			num ^= EffectPathID.GetHashCode();
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
		if (WeaponCategory != WeaponCategory.None)
		{
			output.WriteRawTag(16);
			output.WriteEnum((int)WeaponCategory);
		}
		if (AttackActionCategory != AttackActionCategory.None)
		{
			output.WriteRawTag(24);
			output.WriteEnum((int)AttackActionCategory);
		}
		if (SkillDamageType != SkillDamageType.Physics)
		{
			output.WriteRawTag(32);
			output.WriteEnum((int)SkillDamageType);
		}
		if (ArmourCategory != ArmourCategory.None)
		{
			output.WriteRawTag(40);
			output.WriteEnum((int)ArmourCategory);
		}
		if (AudioID != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AudioID);
		}
		if (EffectPathID != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(EffectPathID);
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
		if (WeaponCategory != WeaponCategory.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)WeaponCategory);
		}
		if (AttackActionCategory != AttackActionCategory.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)AttackActionCategory);
		}
		if (SkillDamageType != SkillDamageType.Physics)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)SkillDamageType);
		}
		if (ArmourCategory != ArmourCategory.None)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)ArmourCategory);
		}
		if (AudioID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AudioID);
		}
		if (EffectPathID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectPathID);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CommonHit other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.WeaponCategory != WeaponCategory.None)
			{
				WeaponCategory = other.WeaponCategory;
			}
			if (other.AttackActionCategory != AttackActionCategory.None)
			{
				AttackActionCategory = other.AttackActionCategory;
			}
			if (other.SkillDamageType != SkillDamageType.Physics)
			{
				SkillDamageType = other.SkillDamageType;
			}
			if (other.ArmourCategory != ArmourCategory.None)
			{
				ArmourCategory = other.ArmourCategory;
			}
			if (other.AudioID != 0)
			{
				AudioID = other.AudioID;
			}
			if (other.EffectPathID != 0)
			{
				EffectPathID = other.EffectPathID;
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
				weaponCategory_ = (WeaponCategory)input.ReadEnum();
				break;
			case 24u:
				attackActionCategory_ = (AttackActionCategory)input.ReadEnum();
				break;
			case 32u:
				skillDamageType_ = (SkillDamageType)input.ReadEnum();
				break;
			case 40u:
				armourCategory_ = (ArmourCategory)input.ReadEnum();
				break;
			case 48u:
				AudioID = input.ReadInt32();
				break;
			case 56u:
				EffectPathID = input.ReadInt32();
				break;
			}
		}
	}
}
