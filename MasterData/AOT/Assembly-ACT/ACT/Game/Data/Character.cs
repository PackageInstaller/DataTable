using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using ACT.Battle;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.MultiPlayer;
using Bamboo.Collections;
using Fundamental;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;
using UnityEngine;

namespace ACT.Game.Data;

public sealed class Character : IMessage<Character>, IMessage, IEquatable<Character>, IDeepCloneable<Character>, IBufferMessage, IMargeFrom<Character>, IBagItem, IFeature, ICharacterSource
{
	private static readonly MessageParser<Character> _parser = new MessageParser<Character>(() => new Character());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelFieldNumber = 2;

	private int level_;

	public const int ExpFieldNumber = 3;

	private int exp_;

	public const int StageFieldNumber = 4;

	private int stage_;

	public const int WeaponUidFieldNumber = 6;

	private int weaponUid_;

	public const int SkillsFieldNumber = 7;

	private static readonly MapField<int, Skill>.Codec _map_skills_codec = new MapField<int, Skill>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, Skill.Parser), 58u);

	private readonly MapField<int, Skill> skills_ = new MapField<int, Skill>();

	public const int StageRewardsFieldNumber = 8;

	private static readonly MapField<int, bool>.Codec _map_stageRewards_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 66u);

	private readonly MapField<int, bool> stageRewards_ = new MapField<int, bool>();

	public const int StatusFieldNumber = 9;

	private CharacterStatus status_;

	public const int SkillGroupLevelsFieldNumber = 10;

	private static readonly MapField<int, int>.Codec _map_skillGroupLevels_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 82u);

	private readonly MapField<int, int> skillGroupLevels_ = new MapField<int, int>();

	public const int ConstellationFieldNumber = 11;

	private int constellation_;

	public const int ConstellationEnabledStatusFieldNumber = 12;

	private static readonly MapField<int, bool>.Codec _map_constellationEnabledStatus_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 98u);

	private readonly MapField<int, bool> constellationEnabledStatus_ = new MapField<int, bool>();

	public const int SkillPointFieldNumber = 13;

	private int skillPoint_;

	public const int ChipSlotFieldNumber = 14;

	private ChipSlot chipSlot_;

	public const int EquipsFieldNumber = 15;

	private static readonly MapField<int, int>.Codec _map_equips_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 122u);

	private readonly MapField<int, int> equips_ = new MapField<int, int>();

	public const int EliteInfoFieldNumber = 16;

	private CharacterEliteInfo eliteInfo_;

	public const int LikeabilityExpFieldNumber = 17;

	private int likeabilityExp_;

	public const int LikeabilityLevelFieldNumber = 18;

	private int likeabilityLevel_;

	public const int SkinIdFieldNumber = 19;

	private int skinId_;

	public const int GotTimeFieldNumber = 20;

	private long gotTime_;

	public const int EffectDressIdFieldNumber = 22;

	private int effectDressId_;

	public Element element;

	private Dictionary<int, int> _tempSkillGroupLevels = new Dictionary<int, int>();

	internal Dictionary<int, List<FeatureData>> m_AllFeatures = new Dictionary<int, List<FeatureData>>();

	public RuntimeCharacterProperty systemProperty;

	private bool _hasInitializedSystemProperties;

	private ICharacterSource _characterSourceImplementation;

	private CharacterDependSnapshot _snapshot;

	private CharacterIdentify _characterIdentify = CharacterIdentify.Default;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Character> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[47];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = value;
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
	public int WeaponUid
	{
		get
		{
			return weaponUid_;
		}
		set
		{
			weaponUid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, Skill> Skills => skills_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> StageRewards => stageRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterStatus Status
	{
		get
		{
			return status_;
		}
		set
		{
			status_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> SkillGroupLevels => skillGroupLevels_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Constellation
	{
		get
		{
			return constellation_;
		}
		set
		{
			constellation_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ConstellationEnabledStatus => constellationEnabledStatus_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SkillPoint
	{
		get
		{
			return skillPoint_;
		}
		set
		{
			skillPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public ChipSlot ChipSlot
	{
		get
		{
			return chipSlot_;
		}
		set
		{
			chipSlot_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> Equips => equips_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public CharacterEliteInfo EliteInfo
	{
		get
		{
			return eliteInfo_;
		}
		set
		{
			eliteInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LikeabilityExp
	{
		get
		{
			return likeabilityExp_;
		}
		set
		{
			likeabilityExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int LikeabilityLevel
	{
		get
		{
			return likeabilityLevel_;
		}
		set
		{
			likeabilityLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int SkinId
	{
		get
		{
			return skinId_;
		}
		set
		{
			skinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long GotTime
	{
		get
		{
			return gotTime_;
		}
		set
		{
			gotTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EffectDressId
	{
		get
		{
			return effectDressId_;
		}
		set
		{
			effectDressId_ = value;
		}
	}

	public int MannerID => CoreUtils.GetData(Id, RuntimeConfigs.data.entityCharacterDatas).mannerType;

	internal bool HasInitializedSystemProperties => _hasInitializedSystemProperties;

	public PropertySource GetCharacterSource => PropertySource.Character;

	public Dictionary<int, float> GetProperty
	{
		get
		{
			EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[Id];
			CoreUtils.StartPropertyCal();
			CoreUtils.AddProperties(entityCharacterData.characterPorpertyBase);
			foreach (KeyValuePair<int, float> property in systemProperty.properties)
			{
				CoreUtils.AddPropertyCal(property.Key, property.Value);
			}
			return CoreUtils.s_PropertyCal;
		}
	}

	public int Atk
	{
		get
		{
			int result = 0;
			if (systemProperty != null && systemProperty.properties.TryGetValue(200, out var value))
			{
				result = (int)value;
			}
			return result;
		}
	}

	public int Define
	{
		get
		{
			int result = 0;
			if (systemProperty != null && systemProperty.properties.TryGetValue(900, out var value))
			{
				result = (int)value;
			}
			return result;
		}
	}

	public int Hp
	{
		get
		{
			int result = 0;
			if (systemProperty != null && systemProperty.properties.TryGetValue(100, out var value))
			{
				result = (int)value;
			}
			return result;
		}
	}

	internal int TrialProbationId { get; private set; }

	public CharacterUID UID => new CharacterUID(IsTrailCharacter ? TrialProbationId : Id, IsTrailCharacter);

	public bool IsTrailCharacter => _characterIdentify.IsTrailCharacter;

	public bool IsSubWorld => _characterIdentify.SceneStatusIndex != 0;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Character()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Character(Character other)
		: this()
	{
		id_ = other.id_;
		level_ = other.level_;
		exp_ = other.exp_;
		stage_ = other.stage_;
		weaponUid_ = other.weaponUid_;
		skills_ = other.skills_.Clone();
		stageRewards_ = other.stageRewards_.Clone();
		status_ = ((other.status_ != null) ? other.status_.Clone() : null);
		skillGroupLevels_ = other.skillGroupLevels_.Clone();
		constellation_ = other.constellation_;
		constellationEnabledStatus_ = other.constellationEnabledStatus_.Clone();
		skillPoint_ = other.skillPoint_;
		chipSlot_ = ((other.chipSlot_ != null) ? other.chipSlot_.Clone() : null);
		equips_ = other.equips_.Clone();
		eliteInfo_ = ((other.eliteInfo_ != null) ? other.eliteInfo_.Clone() : null);
		likeabilityExp_ = other.likeabilityExp_;
		likeabilityLevel_ = other.likeabilityLevel_;
		skinId_ = other.skinId_;
		gotTime_ = other.gotTime_;
		effectDressId_ = other.effectDressId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Character Clone()
	{
		return new Character(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Character);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Character other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Id != other.Id)
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
		if (Stage != other.Stage)
		{
			return false;
		}
		if (WeaponUid != other.WeaponUid)
		{
			return false;
		}
		if (!Skills.Equals(other.Skills))
		{
			return false;
		}
		if (!StageRewards.Equals(other.StageRewards))
		{
			return false;
		}
		if (!object.Equals(Status, other.Status))
		{
			return false;
		}
		if (!SkillGroupLevels.Equals(other.SkillGroupLevels))
		{
			return false;
		}
		if (Constellation != other.Constellation)
		{
			return false;
		}
		if (!ConstellationEnabledStatus.Equals(other.ConstellationEnabledStatus))
		{
			return false;
		}
		if (SkillPoint != other.SkillPoint)
		{
			return false;
		}
		if (!object.Equals(ChipSlot, other.ChipSlot))
		{
			return false;
		}
		if (!Equips.Equals(other.Equips))
		{
			return false;
		}
		if (!object.Equals(EliteInfo, other.EliteInfo))
		{
			return false;
		}
		if (LikeabilityExp != other.LikeabilityExp)
		{
			return false;
		}
		if (LikeabilityLevel != other.LikeabilityLevel)
		{
			return false;
		}
		if (SkinId != other.SkinId)
		{
			return false;
		}
		if (GotTime != other.GotTime)
		{
			return false;
		}
		if (EffectDressId != other.EffectDressId)
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
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (Stage != 0)
		{
			num ^= Stage.GetHashCode();
		}
		if (WeaponUid != 0)
		{
			num ^= WeaponUid.GetHashCode();
		}
		num ^= Skills.GetHashCode();
		num ^= StageRewards.GetHashCode();
		if (status_ != null)
		{
			num ^= Status.GetHashCode();
		}
		num ^= SkillGroupLevels.GetHashCode();
		if (Constellation != 0)
		{
			num ^= Constellation.GetHashCode();
		}
		num ^= ConstellationEnabledStatus.GetHashCode();
		if (SkillPoint != 0)
		{
			num ^= SkillPoint.GetHashCode();
		}
		if (chipSlot_ != null)
		{
			num ^= ChipSlot.GetHashCode();
		}
		num ^= Equips.GetHashCode();
		if (eliteInfo_ != null)
		{
			num ^= EliteInfo.GetHashCode();
		}
		if (LikeabilityExp != 0)
		{
			num ^= LikeabilityExp.GetHashCode();
		}
		if (LikeabilityLevel != 0)
		{
			num ^= LikeabilityLevel.GetHashCode();
		}
		if (SkinId != 0)
		{
			num ^= SkinId.GetHashCode();
		}
		if (GotTime != 0L)
		{
			num ^= GotTime.GetHashCode();
		}
		if (EffectDressId != 0)
		{
			num ^= EffectDressId.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Level != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Level);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Exp);
		}
		if (Stage != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Stage);
		}
		if (WeaponUid != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(WeaponUid);
		}
		skills_.WriteTo(ref output, _map_skills_codec);
		stageRewards_.WriteTo(ref output, _map_stageRewards_codec);
		if (status_ != null)
		{
			output.WriteRawTag(74);
			output.WriteMessage(Status);
		}
		skillGroupLevels_.WriteTo(ref output, _map_skillGroupLevels_codec);
		if (Constellation != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(Constellation);
		}
		constellationEnabledStatus_.WriteTo(ref output, _map_constellationEnabledStatus_codec);
		if (SkillPoint != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(SkillPoint);
		}
		if (chipSlot_ != null)
		{
			output.WriteRawTag(114);
			output.WriteMessage(ChipSlot);
		}
		equips_.WriteTo(ref output, _map_equips_codec);
		if (eliteInfo_ != null)
		{
			output.WriteRawTag(130, 1);
			output.WriteMessage(EliteInfo);
		}
		if (LikeabilityExp != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(LikeabilityExp);
		}
		if (LikeabilityLevel != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(LikeabilityLevel);
		}
		if (SkinId != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(SkinId);
		}
		if (GotTime != 0L)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt64(GotTime);
		}
		if (EffectDressId != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(EffectDressId);
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
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (Stage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Stage);
		}
		if (WeaponUid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WeaponUid);
		}
		num += skills_.CalculateSize(_map_skills_codec);
		num += stageRewards_.CalculateSize(_map_stageRewards_codec);
		if (status_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(Status);
		}
		num += skillGroupLevels_.CalculateSize(_map_skillGroupLevels_codec);
		if (Constellation != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Constellation);
		}
		num += constellationEnabledStatus_.CalculateSize(_map_constellationEnabledStatus_codec);
		if (SkillPoint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillPoint);
		}
		if (chipSlot_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(ChipSlot);
		}
		num += equips_.CalculateSize(_map_equips_codec);
		if (eliteInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(EliteInfo);
		}
		if (LikeabilityExp != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LikeabilityExp);
		}
		if (LikeabilityLevel != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LikeabilityLevel);
		}
		if (SkinId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkinId);
		}
		if (GotTime != 0L)
		{
			num += 2 + CodedOutputStream.ComputeInt64Size(GotTime);
		}
		if (EffectDressId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EffectDressId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Character other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0)
		{
			Id = other.Id;
		}
		if (other.Level != 0)
		{
			Level = other.Level;
		}
		if (other.Exp != 0)
		{
			Exp = other.Exp;
		}
		if (other.Stage != 0)
		{
			Stage = other.Stage;
		}
		if (other.WeaponUid != 0)
		{
			WeaponUid = other.WeaponUid;
		}
		skills_.Add(other.skills_);
		stageRewards_.Add(other.stageRewards_);
		if (other.status_ != null)
		{
			if (status_ == null)
			{
				Status = new CharacterStatus();
			}
			Status.MergeFrom(other.Status);
		}
		skillGroupLevels_.Add(other.skillGroupLevels_);
		if (other.Constellation != 0)
		{
			Constellation = other.Constellation;
		}
		constellationEnabledStatus_.Add(other.constellationEnabledStatus_);
		if (other.SkillPoint != 0)
		{
			SkillPoint = other.SkillPoint;
		}
		if (other.chipSlot_ != null)
		{
			if (chipSlot_ == null)
			{
				ChipSlot = new ChipSlot();
			}
			ChipSlot.MergeFrom(other.ChipSlot);
		}
		equips_.Add(other.equips_);
		if (other.eliteInfo_ != null)
		{
			if (eliteInfo_ == null)
			{
				EliteInfo = new CharacterEliteInfo();
			}
			EliteInfo.MergeFrom(other.EliteInfo);
		}
		if (other.LikeabilityExp != 0)
		{
			LikeabilityExp = other.LikeabilityExp;
		}
		if (other.LikeabilityLevel != 0)
		{
			LikeabilityLevel = other.LikeabilityLevel;
		}
		if (other.SkinId != 0)
		{
			SkinId = other.SkinId;
		}
		if (other.GotTime != 0L)
		{
			GotTime = other.GotTime;
		}
		if (other.EffectDressId != 0)
		{
			EffectDressId = other.EffectDressId;
		}
		_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				Id = input.ReadInt32();
				break;
			case 16u:
				Level = input.ReadInt32();
				break;
			case 24u:
				Exp = input.ReadInt32();
				break;
			case 32u:
				Stage = input.ReadInt32();
				break;
			case 48u:
				WeaponUid = input.ReadInt32();
				break;
			case 58u:
				skills_.AddEntriesFrom(ref input, _map_skills_codec);
				break;
			case 66u:
				stageRewards_.AddEntriesFrom(ref input, _map_stageRewards_codec);
				break;
			case 74u:
				if (status_ == null)
				{
					Status = new CharacterStatus();
				}
				input.ReadMessage(Status);
				break;
			case 82u:
				skillGroupLevels_.AddEntriesFrom(ref input, _map_skillGroupLevels_codec);
				break;
			case 88u:
				Constellation = input.ReadInt32();
				break;
			case 98u:
				constellationEnabledStatus_.AddEntriesFrom(ref input, _map_constellationEnabledStatus_codec);
				break;
			case 104u:
				SkillPoint = input.ReadInt32();
				break;
			case 114u:
				if (chipSlot_ == null)
				{
					ChipSlot = new ChipSlot();
				}
				input.ReadMessage(ChipSlot);
				break;
			case 122u:
				equips_.AddEntriesFrom(ref input, _map_equips_codec);
				break;
			case 130u:
				if (eliteInfo_ == null)
				{
					EliteInfo = new CharacterEliteInfo();
				}
				input.ReadMessage(EliteInfo);
				break;
			case 136u:
				LikeabilityExp = input.ReadInt32();
				break;
			case 144u:
				LikeabilityLevel = input.ReadInt32();
				break;
			case 152u:
				SkinId = input.ReadInt32();
				break;
			case 160u:
				GotTime = input.ReadInt64();
				break;
			case 176u:
				EffectDressId = input.ReadInt32();
				break;
			}
		}
	}

	internal void MarkSystemPropertiesInitialized()
	{
		_hasInitializedSystemProperties = true;
	}

	public void MargeFrom(Character other)
	{
		if (this != other && other != null)
		{
			status_ = other.status_?.Clone();
			level_ = other.level_;
			exp_ = other.exp_;
			stage_ = other.stage_;
			equips_.CopyValueFrom(other.equips_);
			weaponUid_ = other.weaponUid_;
			CalculateSkillGroupLevels(other.skillGroupLevels_);
			skillPoint_ = other.skillPoint_;
			constellation_ = other.constellation_;
			CalculateConstellationChange(other.constellationEnabledStatus_);
			CalculateEliteProperty(other);
			likeabilityExp_ = other.likeabilityExp_;
			likeabilityLevel_ = other.likeabilityLevel_;
			skinId_ = other.SkinId;
			CalculateFeatureData();
		}
	}

	public void Refresh()
	{
		if (systemProperty == null)
		{
			systemProperty = new RuntimeCharacterProperty(this);
		}
		CalculateFeatureData();
		RefreshConstellationChange();
	}

	public void RefreshWithoutEquip()
	{
		if (systemProperty == null)
		{
			systemProperty = new RuntimeCharacterProperty(this);
		}
		RefreshConstellationChange();
	}

	public int GetId()
	{
		return id_;
	}

	public int GetUid()
	{
		return 0;
	}

	public int GetCount()
	{
		return 1;
	}

	public int GetQuality()
	{
		return CoreUtils.GetData(Id, RuntimeConfigs.data.entityCharacterDatas).stars;
	}

	public int GetLocalizationName()
	{
		return CoreUtils.GetData(Id, RuntimeConfigs.data.entityDatas).nameLocal;
	}

	public int GetFeatureData(int featureID, bool clamp = true)
	{
		int num = 0;
		if (!m_AllFeatures.TryGetValue(featureID, out var value))
		{
			return num;
		}
		foreach (FeatureData item in value)
		{
			num += item.Data;
		}
		if (!clamp)
		{
			return num;
		}
		EquipFeatureData data = CoreUtils.GetData(featureID, RuntimeConfigs.data.equipFeatureDatas);
		if (data != null)
		{
			num = Mathf.Clamp(num, 0, data.maxLv);
		}
		return num;
	}

	public int GetFeatureData(int featureID, FeatureData.FeatureSourceType sourceType, bool clamp = true)
	{
		int num = 0;
		if (!m_AllFeatures.TryGetValue(featureID, out var value))
		{
			return num;
		}
		foreach (FeatureData item in value)
		{
			if ((item.FeatureSource & sourceType) > (FeatureData.FeatureSourceType)0)
			{
				num += item.Data;
			}
		}
		if (!clamp)
		{
			return num;
		}
		EquipFeatureData data = CoreUtils.GetData(featureID, RuntimeConfigs.data.equipFeatureDatas);
		if (data != null)
		{
			num = Mathf.Clamp(num, 0, data.maxLv);
		}
		return num;
	}

	public void GetAllFeatureIDs(List<int> output)
	{
		foreach (KeyValuePair<int, List<FeatureData>> allFeature in m_AllFeatures)
		{
			if (!output.Contains(allFeature.Key))
			{
				output.Add(allFeature.Key);
			}
		}
	}

	private void CalculateFeatureData()
	{
		try
		{
			m_AllFeatures.Clear();
			if (equips_ == null)
			{
				if (LuminApplication.LogEnabled && Singleton<GameState>.instance.RunningState == GameRunningState.Playing)
				{
					Debug.LogError($"Character[{Id}]计算特性数据时所依赖的equips_数据为空");
				}
				return;
			}
			foreach (KeyValuePair<int, int> item in equips_)
			{
				Equip equip = GetEquip(item.Value);
				if (equip == null)
				{
					if (LuminApplication.LogEnabled && Singleton<GameState>.instance.RunningState == GameRunningState.Playing)
					{
						Debug.LogError($"Character[{Id}]计算特性时Equip[{item.Value}]数据为空");
					}
					continue;
				}
				Dictionary<int, List<FeatureData>> allFeatures = equip.m_AllFeatures;
				if (allFeatures == null)
				{
					if (LuminApplication.LogEnabled && Singleton<GameState>.instance.RunningState == GameRunningState.Playing)
					{
						Debug.LogError($"Character[{Id}]计算特性时Equip[{item.Value}]的m_AllFeatures数据为空");
					}
					continue;
				}
				foreach (KeyValuePair<int, List<FeatureData>> item2 in allFeatures)
				{
					if (!m_AllFeatures.TryGetValue(item2.Key, out var value))
					{
						value = new List<FeatureData>();
						m_AllFeatures.TryAdd(item2.Key, value);
					}
					value.AddRange(item2.Value);
				}
			}
		}
		catch (Exception ex)
		{
			if (LuminApplication.LogEnabled && Singleton<GameState>.instance.RunningState == GameRunningState.Playing)
			{
				Debug.LogError("更新角色特性数据失败\n" + ex);
			}
		}
	}

	private void CalculateSkillGroupLevels(MapField<int, int> newSkillGroupLevels)
	{
		foreach (KeyValuePair<int, int> newSkillGroupLevel in newSkillGroupLevels)
		{
			int key = newSkillGroupLevel.Key;
			int value = newSkillGroupLevel.Value;
			int before = 0;
			if (!skillGroupLevels_.TryGetValue(key, out var value2))
			{
				skillGroupLevels_[key] = value;
				DispatchSkillGroupEvent(key, before, GetSkillGroupEventualLevel(key));
			}
			if (value2 != newSkillGroupLevel.Value)
			{
				before = GetSkillGroupEventualLevel(key);
				skillGroupLevels_[key] = value;
				UpdateSkillLevels(key);
				DispatchSkillGroupEvent(key, before, GetSkillGroupEventualLevel(key));
			}
		}
	}

	private void CalculateEliteProperty(Character character)
	{
		CharacterEliteInfo characterEliteInfo = character.eliteInfo_;
		if (eliteInfo_ != null && characterEliteInfo != null && eliteInfo_.Levels.Count == characterEliteInfo.Levels.Count)
		{
			bool flag = true;
			foreach (KeyValuePair<int, int> level in characterEliteInfo.Levels)
			{
				if (!eliteInfo_.Levels.TryGetValue(level.Key, out var value) || value != level.Value)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				return;
			}
		}
		CharacterRefresh evt = Singleton<EventManager>.instance.GetEvt<CharacterRefresh>();
		CharacterEliteLevelChange evt2 = Singleton<EventManager>.instance.GetEvt<CharacterEliteLevelChange>();
		evt.character = this;
		evt2.character = this;
		evt2.beforeLevel = GetEliteActiveLevel();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_RemoveElite, evt);
		eliteInfo_ = character.eliteInfo_?.Clone();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_AddElite, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		evt2.afterLevel = character.GetEliteActiveLevel();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Character_EliteLevelChange, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
	}

	private void DispatchSkillGroupEvent(int groupId, int before, int after)
	{
		SkillGroupLevelUpEvt evt = Singleton<EventManager>.instance.GetEvt<SkillGroupLevelUpEvt>();
		evt.skillGrouID = groupId;
		evt.character = this;
		evt.newLevel = after;
		evt.rawLevel = before;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Skill_Change, evt);
	}

	private void UpdateSkillLevels(int groupId)
	{
		SkillGroupData data = CoreUtils.GetData(groupId, RuntimeConfigs.data.skillGroupDatas);
		if (data == null)
		{
			return;
		}
		int[] skillTotalIds = data.skillTotalIds;
		foreach (int num in skillTotalIds)
		{
			byte skillGroupLevel = GetSkillGroupLevel(groupId);
			if (skills_.TryGetValue(num, out var value))
			{
				value.Level = skillGroupLevel;
				continue;
			}
			skills_.Add(num, new Skill
			{
				Id = num,
				Level = skillGroupLevel
			});
		}
	}

	private void CalculateConstellationChange(MapField<int, bool> enableStatus)
	{
		BMap<int, bool> bMap = BMapPool<int, bool>.Default.Get();
		foreach (KeyValuePair<int, bool> item in constellationEnabledStatus_)
		{
			bMap[item.Key] = item.Value;
		}
		foreach (KeyValuePair<int, bool> item2 in bMap)
		{
			if (!enableStatus.ContainsKey(item2.Key))
			{
				constellationEnabledStatus_.Remove(item2.Key);
				ConstellationActive(item2.Key, value: false);
			}
		}
		foreach (KeyValuePair<int, bool> item3 in enableStatus)
		{
			if (!bMap.ContainsKey(item3.Key))
			{
				constellationEnabledStatus_[item3.Key] = item3.Value;
				ConstellationActive(item3.Key, value: true);
			}
		}
		BMapPool<int, bool>.Default.Recycle(bMap);
	}

	private void RefreshConstellationChange()
	{
		_tempSkillGroupLevels.Clear();
		Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
		MapField<int, bool> mapField = constellationEnabledStatus_;
		if (mapField != null && mapField.Count > 0)
		{
			foreach (KeyValuePair<int, bool> item in constellationEnabledStatus_)
			{
				if (item.Value)
				{
					ConstellationActive(item.Key, value: true, dictionary);
				}
			}
		}
		if (systemProperty != null && RuntimeConfigs.data.propertyDatas != null)
		{
			foreach (int key in RuntimeConfigs.data.propertyDatas.Keys)
			{
				dictionary.TryGetValue(key, out var value);
				dictionary[key] = value;
				systemProperty.ReplaceSystemProperty(key, value, SystemPropertySource.Constellation);
			}
			if (dictionary.Count > 0)
			{
				DisPatchSystemPropertiesChange(this, dictionary, 5);
			}
		}
		DictionaryPool<int, float>.Release(dictionary);
	}

	private void ConstellationActive(int constellationId, bool value, Dictionary<int, float> snapshot = null)
	{
		if (!RuntimeConfigs.data.characterConstellationDatas.TryGetValue(constellationId, out var value2))
		{
			return;
		}
		foreach (ItemKv item in value2.upgradeSkillGroup)
		{
			int id = item.id;
			int num = (value ? item.count : (-item.count));
			if (RuntimeConfigs.data.skillGroupDatas.ContainsKey(id))
			{
				byte skillGroupEventualLevel = GetSkillGroupEventualLevel(id);
				if (!_tempSkillGroupLevels.TryAdd(id, num))
				{
					_tempSkillGroupLevels[id] += num;
				}
				UpdateSkillLevels(id);
				DispatchSkillGroupEvent(id, skillGroupEventualLevel, GetSkillGroupEventualLevel(id));
			}
		}
		int unlockSkill = value2.unlockSkill;
		if (unlockSkill == 0 || !RuntimeConfigs.data.skillGroupDatas.ContainsKey(unlockSkill))
		{
			return;
		}
		List<Properties> skillProperty = TableRule.GetSkillGroupLevelData(unlockSkill, 1).skillProperty;
		Dictionary<int, float> dictionary = DictionaryPool<int, float>.Get();
		foreach (Properties item2 in skillProperty)
		{
			dictionary[item2.property] = item2.value;
		}
		if (snapshot != null)
		{
			foreach (KeyValuePair<int, float> item3 in dictionary)
			{
				if (!snapshot.TryAdd(item3.Key, value ? item3.Value : (0f - item3.Value)))
				{
					snapshot[item3.Key] += (value ? item3.Value : (0f - item3.Value));
				}
			}
		}
		else
		{
			systemProperty.CalSystemProperties(dictionary, 5, !value);
			if (dictionary.Count > 0)
			{
				DisPatchSystemPropertiesChange(this, dictionary, 5, !value);
			}
		}
		DictionaryPool<int, float>.Release(dictionary);
	}

	public void CalculateTrialEquipFeatureData()
	{
		if (equips_ == null)
		{
			return;
		}
		foreach (int value in equips_.Values)
		{
			GetEquip(value)?.Refresh();
		}
		CalculateFeatureData();
	}

	public void DisPatchSystemPropertiesChange(Character character, Dictionary<int, float> chagnes, int uid, bool isRemove = false)
	{
		SyncSystemPropertiesToBattle evt = Singleton<EventManager>.instance.GetEvt<SyncSystemPropertiesToBattle>();
		evt.traget = character;
		evt.properties = chagnes;
		evt.isRemove = isRemove;
		evt.propertySourceUid = uid;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.SyncSystemPropertiesChangeToBattle, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void SetCharacterElement()
	{
		int num = RuntimeConfigs.data.entityDatas[Id].element;
		element = (Element)num;
	}

	public int GetEquipId(int index)
	{
		return equips_.GetValueOrDefault(index, 0);
	}

	CharacterUID ICharacterSource.GetUID()
	{
		return UID;
	}

	int ICharacterSource.Id()
	{
		return id_;
	}

	int ICharacterSource.Level()
	{
		return level_;
	}

	int ICharacterSource.Stage()
	{
		return stage_;
	}

	public int GetTotalSkillPoint()
	{
		int num = 0;
		for (int i = 1; i <= level_; i++)
		{
			num += CoreUtils.GetData(1000 + i, RuntimeConfigs.data.entityCharacterXPDatas).getSkillPoint;
		}
		return num;
	}

	public int GetUsedSkillPoint()
	{
		return GetTotalSkillPoint() - skillPoint_;
	}

	public bool GetDestinyActive(int destinyId)
	{
		if (constellationEnabledStatus_ != null)
		{
			return constellationEnabledStatus_.GetValueOrDefault(destinyId, defaultValue: false);
		}
		return false;
	}

	public int GetActiveDestinyCount()
	{
		MapField<int, bool> mapField = constellationEnabledStatus_;
		if (mapField == null || mapField.Count <= 0)
		{
			return 0;
		}
		return RuntimeConfigs.data.characterConstellationDatas.Where((KeyValuePair<int, CharacterConstellationData> x) => x.Value.characterId == Id && constellationEnabledStatus_.ContainsKey(x.Key)).Count((KeyValuePair<int, CharacterConstellationData> x) => x.Value.constellationType != 2);
	}

	public MapField<int, bool> GetDestinyEnableMap()
	{
		return constellationEnabledStatus_;
	}

	public int GetElitePointLevel(int elitePointId)
	{
		if (eliteInfo_ == null)
		{
			return -1;
		}
		if (!eliteInfo_.Levels.TryGetValue(elitePointId, out var value))
		{
			return 0;
		}
		return value;
	}

	public void GetActiveElitePointIds(ref BList<int> ids)
	{
		ids.Clear();
		foreach (var (item, num3) in eliteInfo_.Levels)
		{
			if (num3 > 0)
			{
				ids.Add(item);
			}
		}
	}

	public int GetAllElitePointCost()
	{
		int num = 0;
		int num2 = 0;
		int key = GetQuality();
		int[] array = key switch
		{
			4 => RuntimeConfigs.data.game.elite4StarStageTokenNum, 
			5 => RuntimeConfigs.data.game.elite5StarStageTokenNum, 
			6 => RuntimeConfigs.data.game.elite5StarStageTokenNum, 
		};
		foreach (KeyValuePair<int, int> level in eliteInfo_.Levels)
		{
			level.Deconstruct(out key, out var value);
			int num3 = value;
			if (num3 > 0)
			{
				for (int i = 0; i < num3; i++)
				{
					num++;
				}
			}
		}
		int num4 = RuntimeConfigs.data.game.eliteSkill1Num * array[0];
		int num5 = (RuntimeConfigs.data.game.eliteSkill2Num - RuntimeConfigs.data.game.eliteSkill1Num) * array[1];
		if (num <= RuntimeConfigs.data.game.eliteSkill1Num)
		{
			return num * array[0];
		}
		if (num <= RuntimeConfigs.data.game.eliteSkill2Num)
		{
			return num4 + (num - RuntimeConfigs.data.game.eliteSkill1Num) * array[1];
		}
		return num4 + num5 + (num - RuntimeConfigs.data.game.eliteSkill2Num) * array[2];
	}

	public int[] GetCostTokenNumPerLevel()
	{
		return GetQuality() switch
		{
			4 => RuntimeConfigs.data.game.elite4StarTokenNum, 
			5 => RuntimeConfigs.data.game.elite5StarTokenNum, 
			6 => RuntimeConfigs.data.game.elite5StarTokenNum, 
			_ => throw new ArgumentOutOfRangeException($"Unsupported character quality: {GetQuality()}"), 
		};
	}

	public int GetEliteActiveLevel()
	{
		if (eliteInfo_ == null)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<int, int> level in eliteInfo_.Levels)
		{
			num += level.Value;
		}
		return num;
	}

	public int GetRemainEliteToken()
	{
		if (eliteInfo_ == null)
		{
			return 0;
		}
		return eliteInfo_.Point;
	}

	public int GetSKillGroupUnlockStage(int skillId)
	{
		Dictionary<int, EntityCharacterLevelData> entityCharacterLevelDatas = RuntimeConfigs.data.entityCharacterLevelDatas;
		int i = stage_;
		EntityCharacterLevelData value;
		for (int num = 10; entityCharacterLevelDatas.TryGetValue(id_ * 100 + i, out value) && i < num; i++)
		{
			if (value.newSkill.Contains(skillId))
			{
				return i;
			}
		}
		return -1;
	}

	public void GetConstellationStates(List<int> states)
	{
		foreach (var (item, flag2) in constellationEnabledStatus_)
		{
			if (flag2)
			{
				states.Add(item);
			}
		}
	}

	[Obsolete("没用了")]
	public MPSkill GetUpgradeSkill(int skillid)
	{
		if (!skills_.TryGetValue(skillid, out var value) && LuminApplication.LogEnabled)
		{
			Debug.LogError($"id为{id_}的角色技能表配置错误,{skillid}在LocalSave中配置没配");
		}
		return new MPSkill
		{
			id = value.Id,
			level = (byte)value.Level
		};
	}

	public byte GetSkillGroupEventualLevel(int groupId, List<int> addSources = null)
	{
		byte skillGroupLevel = GetSkillGroupLevel(groupId);
		if (_tempSkillGroupLevels.TryGetValue(groupId, out var value))
		{
			addSources?.Add(value);
			return (byte)(skillGroupLevel + value);
		}
		return skillGroupLevel;
	}

	public int GetCharacterSkinId()
	{
		if (SkinId != 0)
		{
			return SkinId;
		}
		return Id;
	}

	public int ColorId()
	{
		return 0;
	}

	public void SetSkin(int skinId, int colorId)
	{
		SkinId = skinId;
	}

	public byte GetSkillGroupLevel(int groupId)
	{
		if (!skillGroupLevels_.TryGetValue(groupId, out var value))
		{
			return 0;
		}
		return (byte)value;
	}

	public int GetCharacterMannerType()
	{
		return RuntimeConfigs.data.entityCharacterDatas[Id].mannerType;
	}

	public int GetCharacterDamageType()
	{
		return RuntimeConfigs.data.entityCharacterDatas[Id].characterDamageType;
	}

	public int GetCharacterEliteItem()
	{
		return RuntimeConfigs.data.entityCharacterDatas[Id].eliteCharacterItem;
	}

	public int GetGenericCharacterEliteItem()
	{
		return RuntimeConfigs.data.entityCharacterDatas[Id].eliteElementItem;
	}

	public int GetEliteActiveNum()
	{
		int eliteActiveLevel = GetEliteActiveLevel();
		BArray<int> bArray = BArrayPool<int>.Default.Get(3);
		bArray[0] = RuntimeConfigs.data.game.eliteSkill1Num;
		bArray[1] = RuntimeConfigs.data.game.eliteSkill2Num;
		bArray[2] = RuntimeConfigs.data.game.eliteSkill3Num;
		if (eliteActiveLevel >= bArray[2])
		{
			return 3;
		}
		if (eliteActiveLevel >= bArray[1])
		{
			return 2;
		}
		if (eliteActiveLevel >= bArray[0])
		{
			return 1;
		}
		return 0;
	}

	public CharacterIdentify GetCharacterIndentify()
	{
		return _characterIdentify;
	}

	internal void SetCharacterTeamInfo(CharacterIdentify identify)
	{
		_characterIdentify = identify;
		CharacterRepository characterRepository = CharacterDataHelper.GetCharacterRepository(identify.SceneStatusIndex);
		_snapshot = (identify.IsTrailCharacter ? characterRepository.ExtraCharacterDependSnapshot : characterRepository.CharacterDependSnapshot);
	}

	internal void SetCharacterDependSnapshot(CharacterDependSnapshot snapshot)
	{
		_snapshot = snapshot;
	}

	internal void SetTrialProbationId(int probationId)
	{
		TrialProbationId = probationId;
	}

	public Equip GetEquipInSlot(int slotIndex)
	{
		if (Equips.TryGetValue(slotIndex, out var value))
		{
			return GetEquip(value);
		}
		return null;
	}

	public Equip GetEquip(int equipId)
	{
		if (_snapshot != null)
		{
			if (_snapshot.EquipSnapshot.TryGetValue(equipId, out var value))
			{
				value.SetSnapshot(_snapshot);
				return value;
			}
			return null;
		}
		return G.localPlayer.Inventory.GetEquip(equipId);
	}

	public bool TryGetEquip(int equipId, out Equip equip)
	{
		equip = GetEquip(equipId);
		return equip != null;
	}

	public Gem GetGem(int gemId)
	{
		if (_snapshot != null)
		{
			if (_snapshot.GemSnapshot.TryGetValue(gemId, out var value))
			{
				return value;
			}
			return null;
		}
		return G.localPlayer.Inventory.GetGem(gemId);
	}

	public bool TryGetEem(int gemId, out Gem gem)
	{
		gem = GetGem(gemId);
		return gem != null;
	}
}
