using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using ACT.Config;
using ACT.Core;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

[Obsolete]
public sealed class Weapon : IMessage<Weapon>, IMessage, IEquatable<Weapon>, IDeepCloneable<Weapon>, IBufferMessage, IMargeFrom<Weapon>, IBagItem
{
	private static readonly MessageParser<Weapon> _parser = new MessageParser<Weapon>(() => new Weapon());

	private UnknownFieldSet _unknownFields;

	public const int UidFieldNumber = 1;

	private int uid_;

	public const int WeaponIdFieldNumber = 2;

	private int weaponId_;

	public const int LevelFieldNumber = 3;

	private int level_;

	public const int ExpFieldNumber = 4;

	private int exp_;

	public const int RefineFieldNumber = 5;

	private int refine_;

	public const int StageFieldNumber = 6;

	private int stage_;

	public const int LockFieldNumber = 7;

	private bool lock_;

	public const int SourceFieldNumber = 8;

	private ItemsWays source_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Weapon> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[48];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Uid
	{
		get
		{
			return uid_;
		}
		set
		{
			uid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int WeaponId
	{
		get
		{
			return weaponId_;
		}
		set
		{
			weaponId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public int Exp
	{
		get
		{
			return exp_;
		}
		set
		{
			exp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Refine
	{
		get
		{
			return refine_;
		}
		set
		{
			refine_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Stage
	{
		get
		{
			return stage_;
		}
		set
		{
			stage_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Lock
	{
		get
		{
			return lock_;
		}
		set
		{
			lock_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ItemsWays Source
	{
		get
		{
			return source_;
		}
		set
		{
			source_ = value;
		}
	}

	public PropertySource GetWeaponSource => PropertySource.Weapon;

	private ItemWeaponData ItemWeaponData => CoreUtils.GetData(GetId(), RuntimeConfigs.data.itemWeaponDatas);

	public int WeaponSubPropertyId => ItemWeaponData.weaponSubProperty;

	public int BreakType => ItemWeaponData.weaponBreakType;

	public int WeaponStars => ItemWeaponData.weaponStars;

	public int CurrentStageMaxLevel => CoreUtils.GetData(TableRule.GetWeaponBreakId(WeaponId, Stage), RuntimeConfigs.data.itemWeaponBreakthroughs).maxLevel;

	public int NextStageMaxLevel => CoreUtils.GetData(TableRule.GetWeaponBreakId(WeaponId, Stage + 1), RuntimeConfigs.data.itemWeaponBreakthroughs).maxLevel;

	public int[] SkillTotalIds => CoreUtils.GetData(ItemWeaponData.weaponSkill, RuntimeConfigs.data.skillGroupDatas).skillTotalIds;

	public bool ReachRefineMax => Refine == ItemWeaponData.maxWeaponRefine;

	public int MaxRefineLevel => ItemWeaponData.maxWeaponRefine;

	public int NameTextId => CoreUtils.GetData(WeaponId, RuntimeConfigs.data.itemDatas).nameLocal;

	public int TypeTextId => CoreUtils.GetData(ItemWeaponData.weaponType, RuntimeConfigs.data.itemWeaponTypes).nameLocal;

	public int SkillBriefTextId => CoreUtils.GetData(CoreUtils.GetData(ItemWeaponData.weaponSkill, RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas).briefDescLocal;

	public int SkillNameTextId => CoreUtils.GetData(CoreUtils.GetData(ItemWeaponData.weaponSkill, RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas).nameLocal;

	public int DescLocalTextId => CoreUtils.GetData(WeaponId, RuntimeConfigs.data.itemDatas).descLocal;

	public bool ReachStageMaxLevel => CurrentStageMaxLevel == level_;

	public bool ReachMaxLevel => level_ == ItemWeaponData.maxWeaponLevel;

	public int TotalExp => CoreUtils.GetData(TableRule.GetWeaponUpGradeId(UpGradeType, Level), RuntimeConfigs.data.itemWeaponUpgrades).totalEXPRequired;

	public int XpEachLv => CoreUtils.GetData(TableRule.GetWeaponUpGradeId(UpGradeType, Level), RuntimeConfigs.data.itemWeaponUpgrades).xpEachLv;

	public int UpGradeType => ItemWeaponData.upgradeType;

	public int LackExp => CoreUtils.GetData(TableRule.GetWeaponUpGradeId(UpGradeType, CurrentStageMaxLevel), RuntimeConfigs.data.itemWeaponUpgrades).totalEXPRequired - TotalExp;

	public int Type => ItemWeaponData.weaponType;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Weapon()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Weapon(Weapon other)
		: this()
	{
		uid_ = other.uid_;
		weaponId_ = other.weaponId_;
		level_ = other.level_;
		exp_ = other.exp_;
		refine_ = other.refine_;
		stage_ = other.stage_;
		lock_ = other.lock_;
		source_ = other.source_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Weapon Clone()
	{
		return new Weapon(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Weapon);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Weapon other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Uid != other.Uid)
		{
			return false;
		}
		if (WeaponId != other.WeaponId)
		{
			return false;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Exp != other.Exp)
		{
			return false;
		}
		if (Refine != other.Refine)
		{
			return false;
		}
		if (Stage != other.Stage)
		{
			return false;
		}
		if (Lock != other.Lock)
		{
			return false;
		}
		if (Source != other.Source)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Uid != 0)
		{
			num ^= Uid.GetHashCode();
		}
		if (WeaponId != 0)
		{
			num ^= WeaponId.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (Refine != 0)
		{
			num ^= Refine.GetHashCode();
		}
		if (Stage != 0)
		{
			num ^= Stage.GetHashCode();
		}
		if (Lock)
		{
			num ^= Lock.GetHashCode();
		}
		if (Source != ItemsWays.ItemswayEntergame)
		{
			num ^= Source.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Uid != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Uid);
		}
		if (WeaponId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(WeaponId);
		}
		if (Level != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Level);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Exp);
		}
		if (Refine != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Refine);
		}
		if (Stage != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Stage);
		}
		if (Lock)
		{
			output.WriteRawTag(56);
			output.WriteBool(Lock);
		}
		if (Source != ItemsWays.ItemswayEntergame)
		{
			output.WriteRawTag(64);
			output.WriteEnum((int)Source);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (Uid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Uid);
		}
		if (WeaponId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WeaponId);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (Refine != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Refine);
		}
		if (Stage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stage);
		}
		if (Lock)
		{
			num += 2;
		}
		if (Source != ItemsWays.ItemswayEntergame)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)Source);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Weapon other)
	{
		if (other != null)
		{
			if (other.Uid != 0)
			{
				Uid = other.Uid;
			}
			if (other.WeaponId != 0)
			{
				WeaponId = other.WeaponId;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Exp != 0)
			{
				Exp = other.Exp;
			}
			if (other.Refine != 0)
			{
				Refine = other.Refine;
			}
			if (other.Stage != 0)
			{
				Stage = other.Stage;
			}
			if (other.Lock)
			{
				Lock = other.Lock;
			}
			if (other.Source != ItemsWays.ItemswayEntergame)
			{
				Source = other.Source;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Uid = input.ReadInt32();
				break;
			case 16u:
				WeaponId = input.ReadInt32();
				break;
			case 24u:
				Level = input.ReadInt32();
				break;
			case 32u:
				Exp = input.ReadInt32();
				break;
			case 40u:
				Refine = input.ReadInt32();
				break;
			case 48u:
				Stage = input.ReadInt32();
				break;
			case 56u:
				Lock = input.ReadBool();
				break;
			case 64u:
				Source = (ItemsWays)input.ReadEnum();
				break;
			}
		}
	}

	public (float v1, float v2) GetWeaponBaseProperty()
	{
		Dictionary<int, float> weaponProperties = CoreUtils.GetWeaponProperties(WeaponId, Level, Stage);
		weaponProperties.TryGetValue(200, out var value);
		weaponProperties.TryGetValue(WeaponSubPropertyId, out var value2);
		return (v1: value, v2: value2);
	}

	public int WeaponTotalRequiredCoin(int level)
	{
		return CoreUtils.GetData(TableRule.GetWeaponUpGradeId(UpGradeType, level), RuntimeConfigs.data.itemWeaponUpgrades).totalCoinRequired;
	}

	public void MargeFrom(Weapon other)
	{
		weaponId_ = other.weaponId_;
		level_ = other.level_;
		exp_ = other.exp_;
		refine_ = other.refine_;
		stage_ = other.stage_;
		lock_ = other.lock_;
	}

	public void Refresh()
	{
	}

	public int GetId()
	{
		return weaponId_;
	}

	public int GetUid()
	{
		return Uid;
	}

	public int GetCount()
	{
		return 1;
	}

	public int GetQuality()
	{
		return 0;
	}

	public int GetLocalizationName()
	{
		throw new NotImplementedException();
	}
}
