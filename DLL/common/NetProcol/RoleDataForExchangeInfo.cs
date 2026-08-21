using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace NetProcol;

public sealed class RoleDataForExchangeInfo : IMessage<RoleDataForExchangeInfo>, IMessage, IEquatable<RoleDataForExchangeInfo>, IDeepCloneable<RoleDataForExchangeInfo>
{
	private static readonly MessageParser<RoleDataForExchangeInfo> _parser = new MessageParser<RoleDataForExchangeInfo>(() => new RoleDataForExchangeInfo());

	public const int PlayerLevelFieldNumber = 1;

	private int playerLevel_;

	public const int IDFieldNumber = 2;

	private int iD_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int AttributeIDFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_attributeID_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> attributeID_ = new RepeatedField<int>();

	public const int AttributeValueFieldNumber = 5;

	private static readonly FieldCodec<long> _repeated_attributeValue_codec = FieldCodec.ForInt64(42u);

	private readonly RepeatedField<long> attributeValue_ = new RepeatedField<long>();

	public const int SkillLevelFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_skillLevel_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> skillLevel_ = new RepeatedField<int>();

	public const int AstrolabeFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_astrolabe_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> astrolabe_ = new RepeatedField<int>();

	public const int EquipmentFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_equipment_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> equipment_ = new RepeatedField<int>();

	public const int WeaponEffectIDFieldNumber = 9;

	private int weaponEffectID_;

	public const int WeaponEffectLevelFieldNumber = 10;

	private int weaponEffectLevel_;

	public const int AIChipFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_aIChip_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> aIChip_ = new RepeatedField<int>();

	public const int EquipmentSkillFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_equipmentSkill_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> equipmentSkill_ = new RepeatedField<int>();

	public const int EquipmentSkillLvFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_equipmentSkillLv_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> equipmentSkillLv_ = new RepeatedField<int>();

	public const int IsVowFieldNumber = 14;

	private bool isVow_;

	[DebuggerNonUserCode]
	public static MessageParser<RoleDataForExchangeInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[17];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int PlayerLevel
	{
		get
		{
			return playerLevel_;
		}
		set
		{
			playerLevel_ = value;
		}
	}

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
	public RepeatedField<int> AttributeID => attributeID_;

	[DebuggerNonUserCode]
	public RepeatedField<long> AttributeValue => attributeValue_;

	[DebuggerNonUserCode]
	public RepeatedField<int> SkillLevel => skillLevel_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Astrolabe => astrolabe_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Equipment => equipment_;

	[DebuggerNonUserCode]
	public int WeaponEffectID
	{
		get
		{
			return weaponEffectID_;
		}
		set
		{
			weaponEffectID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WeaponEffectLevel
	{
		get
		{
			return weaponEffectLevel_;
		}
		set
		{
			weaponEffectLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AIChip => aIChip_;

	[DebuggerNonUserCode]
	public RepeatedField<int> EquipmentSkill => equipmentSkill_;

	[DebuggerNonUserCode]
	public RepeatedField<int> EquipmentSkillLv => equipmentSkillLv_;

	[DebuggerNonUserCode]
	public bool IsVow
	{
		get
		{
			return isVow_;
		}
		set
		{
			isVow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RoleDataForExchangeInfo()
	{
	}

	[DebuggerNonUserCode]
	public RoleDataForExchangeInfo(RoleDataForExchangeInfo other)
		: this()
	{
		playerLevel_ = other.playerLevel_;
		iD_ = other.iD_;
		level_ = other.level_;
		attributeID_ = other.attributeID_.Clone();
		attributeValue_ = other.attributeValue_.Clone();
		skillLevel_ = other.skillLevel_.Clone();
		astrolabe_ = other.astrolabe_.Clone();
		equipment_ = other.equipment_.Clone();
		weaponEffectID_ = other.weaponEffectID_;
		weaponEffectLevel_ = other.weaponEffectLevel_;
		aIChip_ = other.aIChip_.Clone();
		equipmentSkill_ = other.equipmentSkill_.Clone();
		equipmentSkillLv_ = other.equipmentSkillLv_.Clone();
		isVow_ = other.isVow_;
	}

	[DebuggerNonUserCode]
	public RoleDataForExchangeInfo Clone()
	{
		return new RoleDataForExchangeInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as RoleDataForExchangeInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(RoleDataForExchangeInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PlayerLevel != other.PlayerLevel)
		{
			return false;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (!attributeID_.Equals(other.attributeID_))
		{
			return false;
		}
		if (!attributeValue_.Equals(other.attributeValue_))
		{
			return false;
		}
		if (!skillLevel_.Equals(other.skillLevel_))
		{
			return false;
		}
		if (!astrolabe_.Equals(other.astrolabe_))
		{
			return false;
		}
		if (!equipment_.Equals(other.equipment_))
		{
			return false;
		}
		if (WeaponEffectID != other.WeaponEffectID)
		{
			return false;
		}
		if (WeaponEffectLevel != other.WeaponEffectLevel)
		{
			return false;
		}
		if (!aIChip_.Equals(other.aIChip_))
		{
			return false;
		}
		if (!equipmentSkill_.Equals(other.equipmentSkill_))
		{
			return false;
		}
		if (!equipmentSkillLv_.Equals(other.equipmentSkillLv_))
		{
			return false;
		}
		if (IsVow != other.IsVow)
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (PlayerLevel != 0)
		{
			num ^= PlayerLevel.GetHashCode();
		}
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		num ^= attributeID_.GetHashCode();
		num ^= attributeValue_.GetHashCode();
		num ^= skillLevel_.GetHashCode();
		num ^= astrolabe_.GetHashCode();
		num ^= equipment_.GetHashCode();
		if (WeaponEffectID != 0)
		{
			num ^= WeaponEffectID.GetHashCode();
		}
		if (WeaponEffectLevel != 0)
		{
			num ^= WeaponEffectLevel.GetHashCode();
		}
		num ^= aIChip_.GetHashCode();
		num ^= equipmentSkill_.GetHashCode();
		num ^= equipmentSkillLv_.GetHashCode();
		if (IsVow)
		{
			num ^= IsVow.GetHashCode();
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
		if (PlayerLevel != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PlayerLevel);
		}
		if (ID != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ID);
		}
		if (Level != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Level);
		}
		attributeID_.WriteTo(output, _repeated_attributeID_codec);
		attributeValue_.WriteTo(output, _repeated_attributeValue_codec);
		skillLevel_.WriteTo(output, _repeated_skillLevel_codec);
		astrolabe_.WriteTo(output, _repeated_astrolabe_codec);
		equipment_.WriteTo(output, _repeated_equipment_codec);
		if (WeaponEffectID != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(WeaponEffectID);
		}
		if (WeaponEffectLevel != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(WeaponEffectLevel);
		}
		aIChip_.WriteTo(output, _repeated_aIChip_codec);
		equipmentSkill_.WriteTo(output, _repeated_equipmentSkill_codec);
		equipmentSkillLv_.WriteTo(output, _repeated_equipmentSkillLv_codec);
		if (IsVow)
		{
			output.WriteRawTag(112);
			output.WriteBool(IsVow);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (PlayerLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayerLevel);
		}
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		num += attributeID_.CalculateSize(_repeated_attributeID_codec);
		num += attributeValue_.CalculateSize(_repeated_attributeValue_codec);
		num += skillLevel_.CalculateSize(_repeated_skillLevel_codec);
		num += astrolabe_.CalculateSize(_repeated_astrolabe_codec);
		num += equipment_.CalculateSize(_repeated_equipment_codec);
		if (WeaponEffectID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WeaponEffectID);
		}
		if (WeaponEffectLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WeaponEffectLevel);
		}
		num += aIChip_.CalculateSize(_repeated_aIChip_codec);
		num += equipmentSkill_.CalculateSize(_repeated_equipmentSkill_codec);
		num += equipmentSkillLv_.CalculateSize(_repeated_equipmentSkillLv_codec);
		if (IsVow)
		{
			num += 2;
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(RoleDataForExchangeInfo other)
	{
		if (other != null)
		{
			if (other.PlayerLevel != 0)
			{
				PlayerLevel = other.PlayerLevel;
			}
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			attributeID_.Add(other.attributeID_);
			attributeValue_.Add(other.attributeValue_);
			skillLevel_.Add(other.skillLevel_);
			astrolabe_.Add(other.astrolabe_);
			equipment_.Add(other.equipment_);
			if (other.WeaponEffectID != 0)
			{
				WeaponEffectID = other.WeaponEffectID;
			}
			if (other.WeaponEffectLevel != 0)
			{
				WeaponEffectLevel = other.WeaponEffectLevel;
			}
			aIChip_.Add(other.aIChip_);
			equipmentSkill_.Add(other.equipmentSkill_);
			equipmentSkillLv_.Add(other.equipmentSkillLv_);
			if (other.IsVow)
			{
				IsVow = other.IsVow;
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
				PlayerLevel = input.ReadInt32();
				break;
			case 16u:
				ID = input.ReadInt32();
				break;
			case 24u:
				Level = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				attributeID_.AddEntriesFrom(input, _repeated_attributeID_codec);
				break;
			case 40u:
			case 42u:
				attributeValue_.AddEntriesFrom(input, _repeated_attributeValue_codec);
				break;
			case 48u:
			case 50u:
				skillLevel_.AddEntriesFrom(input, _repeated_skillLevel_codec);
				break;
			case 56u:
			case 58u:
				astrolabe_.AddEntriesFrom(input, _repeated_astrolabe_codec);
				break;
			case 64u:
			case 66u:
				equipment_.AddEntriesFrom(input, _repeated_equipment_codec);
				break;
			case 72u:
				WeaponEffectID = input.ReadInt32();
				break;
			case 80u:
				WeaponEffectLevel = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				aIChip_.AddEntriesFrom(input, _repeated_aIChip_codec);
				break;
			case 96u:
			case 98u:
				equipmentSkill_.AddEntriesFrom(input, _repeated_equipmentSkill_codec);
				break;
			case 104u:
			case 106u:
				equipmentSkillLv_.AddEntriesFrom(input, _repeated_equipmentSkillLv_codec);
				break;
			case 112u:
				IsVow = input.ReadBool();
				break;
			}
		}
	}
}
