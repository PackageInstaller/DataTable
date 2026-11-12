using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierCharacter : IMessage<SoldierCharacter>, IMessage, IEquatable<SoldierCharacter>, IDeepCloneable<SoldierCharacter>
{
	private static readonly MessageParser<SoldierCharacter> _parser = new MessageParser<SoldierCharacter>(() => new SoldierCharacter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int GroupIdFieldNumber = 3;

	private int groupId_;

	public const int RarityFieldNumber = 4;

	private int rarity_;

	public const int CostFieldNumber = 5;

	private int cost_;

	public const int MaxStarFieldNumber = 6;

	private int maxStar_;

	public const int FactionFieldNumber = 7;

	private int faction_;

	public const int CharacterTypeFieldNumber = 8;

	private int characterType_;

	public const int CharacterIdFieldNumber = 9;

	private int characterId_;

	public const int SkinFieldNumber = 10;

	private int skin_;

	public const int AIIDFieldNumber = 11;

	private int aIID_;

	public const int EnergyFieldNumber = 12;

	private int energy_;

	public const int InitialEnergyFieldNumber = 13;

	private int initialEnergy_;

	public const int RecoveryFieldNumber = 14;

	private float recovery_;

	public const int SkillEndStartRecoverFieldNumber = 15;

	private bool skillEndStartRecover_;

	public const int TempleteFieldNumber = 16;

	private int templete_;

	public const int AssistSkillOnStageTypeFieldNumber = 17;

	private int assistSkillOnStageType_;

	public const int AssistSkillAngleFieldNumber = 18;

	private int assistSkillAngle_;

	public const int AssistSkillRadiusFieldNumber = 19;

	private int assistSkillRadius_;

	public const int AssistSkillOnStageOrientationFieldNumber = 20;

	private int assistSkillOnStageOrientation_;

	public const int Potential1FieldNumber = 21;

	private static readonly FieldCodec<int> _repeated_potential1_codec = FieldCodec.ForInt32(170u);

	private readonly RepeatedField<int> potential1_ = new RepeatedField<int>();

	public const int Potential2FieldNumber = 22;

	private static readonly FieldCodec<int> _repeated_potential2_codec = FieldCodec.ForInt32(178u);

	private readonly RepeatedField<int> potential2_ = new RepeatedField<int>();

	public const int Potential3FieldNumber = 23;

	private static readonly FieldCodec<int> _repeated_potential3_codec = FieldCodec.ForInt32(186u);

	private readonly RepeatedField<int> potential3_ = new RepeatedField<int>();

	public const int Potential4FieldNumber = 24;

	private static readonly FieldCodec<int> _repeated_potential4_codec = FieldCodec.ForInt32(194u);

	private readonly RepeatedField<int> potential4_ = new RepeatedField<int>();

	public const int StopNormalAttackFieldNumber = 25;

	private bool stopNormalAttack_;

	public const int SearchRadiusFieldNumber = 26;

	private int searchRadius_;

	public const int NormalAttackRadiusFieldNumber = 27;

	private int normalAttackRadius_;

	public const int SkillRadiusFieldNumber = 28;

	private int skillRadius_;

	public const int NormalFieldNumber = 29;

	private int normal_;

	public const int SkillFieldNumber = 30;

	private int skill_;

	public const int SupportFieldNumber = 31;

	private int support_;

	public const int TypeFieldNumber = 32;

	private int type_;

	public const int PartnerTypeFieldNumber = 33;

	private static readonly FieldCodec<int> _repeated_partnerType_codec = FieldCodec.ForInt32(266u);

	private readonly RepeatedField<int> partnerType_ = new RepeatedField<int>();

	public const int ATKSPDPFieldNumber = 34;

	private int aTKSPDP_;

	public const int MovTypeFieldNumber = 35;

	private int movType_;

	public const int WalkSpdFieldNumber = 36;

	private int walkSpd_;

	public const int RunSpdFieldNumber = 37;

	private int runSpd_;

	public const int SpRunSpdFieldNumber = 38;

	private int spRunSpd_;

	public const int TransSpdFieldNumber = 39;

	private int transSpd_;

	public const int WalkToRunDurationFieldNumber = 40;

	private int walkToRunDuration_;

	public const int MovAccFieldNumber = 41;

	private int movAcc_;

	public const int RotSpdFieldNumber = 42;

	private int rotSpd_;

	public const int RotAccFieldNumber = 43;

	private int rotAcc_;

	public const int WeightFieldNumber = 44;

	private int weight_;

	public const int BlockPriorityFieldNumber = 45;

	private int blockPriority_;

	public const int AimAtTargetFieldNumber = 46;

	private bool aimAtTarget_;

	public const int HideBloodFieldNumber = 47;

	private bool hideBlood_;

	public const int BoardChessFieldNumber = 48;

	private bool boardChess_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierCharacter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(738);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Rarity
	{
		get
		{
			return rarity_;
		}
		set
		{
			rarity_ = value;
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
	public int MaxStar
	{
		get
		{
			return maxStar_;
		}
		set
		{
			maxStar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Faction
	{
		get
		{
			return faction_;
		}
		set
		{
			faction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharacterType
	{
		get
		{
			return characterType_;
		}
		set
		{
			characterType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharacterId
	{
		get
		{
			return characterId_;
		}
		set
		{
			characterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Skin
	{
		get
		{
			return skin_;
		}
		set
		{
			skin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AIID
	{
		get
		{
			return aIID_;
		}
		set
		{
			aIID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Energy
	{
		get
		{
			return energy_;
		}
		set
		{
			energy_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int InitialEnergy
	{
		get
		{
			return initialEnergy_;
		}
		set
		{
			initialEnergy_ = value;
		}
	}

	[DebuggerNonUserCode]
	public float Recovery
	{
		get
		{
			return recovery_;
		}
		set
		{
			recovery_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool SkillEndStartRecover
	{
		get
		{
			return skillEndStartRecover_;
		}
		set
		{
			skillEndStartRecover_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Templete
	{
		get
		{
			return templete_;
		}
		set
		{
			templete_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillOnStageType
	{
		get
		{
			return assistSkillOnStageType_;
		}
		set
		{
			assistSkillOnStageType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillAngle
	{
		get
		{
			return assistSkillAngle_;
		}
		set
		{
			assistSkillAngle_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillRadius
	{
		get
		{
			return assistSkillRadius_;
		}
		set
		{
			assistSkillRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AssistSkillOnStageOrientation
	{
		get
		{
			return assistSkillOnStageOrientation_;
		}
		set
		{
			assistSkillOnStageOrientation_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Potential1 => potential1_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Potential2 => potential2_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Potential3 => potential3_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Potential4 => potential4_;

	[DebuggerNonUserCode]
	public bool StopNormalAttack
	{
		get
		{
			return stopNormalAttack_;
		}
		set
		{
			stopNormalAttack_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SearchRadius
	{
		get
		{
			return searchRadius_;
		}
		set
		{
			searchRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NormalAttackRadius
	{
		get
		{
			return normalAttackRadius_;
		}
		set
		{
			normalAttackRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillRadius
	{
		get
		{
			return skillRadius_;
		}
		set
		{
			skillRadius_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Normal
	{
		get
		{
			return normal_;
		}
		set
		{
			normal_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Skill
	{
		get
		{
			return skill_;
		}
		set
		{
			skill_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Support
	{
		get
		{
			return support_;
		}
		set
		{
			support_ = value;
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
	public RepeatedField<int> PartnerType => partnerType_;

	[DebuggerNonUserCode]
	public int ATKSPDP
	{
		get
		{
			return aTKSPDP_;
		}
		set
		{
			aTKSPDP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MovType
	{
		get
		{
			return movType_;
		}
		set
		{
			movType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WalkSpd
	{
		get
		{
			return walkSpd_;
		}
		set
		{
			walkSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RunSpd
	{
		get
		{
			return runSpd_;
		}
		set
		{
			runSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpRunSpd
	{
		get
		{
			return spRunSpd_;
		}
		set
		{
			spRunSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TransSpd
	{
		get
		{
			return transSpd_;
		}
		set
		{
			transSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WalkToRunDuration
	{
		get
		{
			return walkToRunDuration_;
		}
		set
		{
			walkToRunDuration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MovAcc
	{
		get
		{
			return movAcc_;
		}
		set
		{
			movAcc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RotSpd
	{
		get
		{
			return rotSpd_;
		}
		set
		{
			rotSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RotAcc
	{
		get
		{
			return rotAcc_;
		}
		set
		{
			rotAcc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BlockPriority
	{
		get
		{
			return blockPriority_;
		}
		set
		{
			blockPriority_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool AimAtTarget
	{
		get
		{
			return aimAtTarget_;
		}
		set
		{
			aimAtTarget_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool HideBlood
	{
		get
		{
			return hideBlood_;
		}
		set
		{
			hideBlood_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool BoardChess
	{
		get
		{
			return boardChess_;
		}
		set
		{
			boardChess_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierCharacter()
	{
	}

	[DebuggerNonUserCode]
	public SoldierCharacter(SoldierCharacter other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		groupId_ = other.groupId_;
		rarity_ = other.rarity_;
		cost_ = other.cost_;
		maxStar_ = other.maxStar_;
		faction_ = other.faction_;
		characterType_ = other.characterType_;
		characterId_ = other.characterId_;
		skin_ = other.skin_;
		aIID_ = other.aIID_;
		energy_ = other.energy_;
		initialEnergy_ = other.initialEnergy_;
		recovery_ = other.recovery_;
		skillEndStartRecover_ = other.skillEndStartRecover_;
		templete_ = other.templete_;
		assistSkillOnStageType_ = other.assistSkillOnStageType_;
		assistSkillAngle_ = other.assistSkillAngle_;
		assistSkillRadius_ = other.assistSkillRadius_;
		assistSkillOnStageOrientation_ = other.assistSkillOnStageOrientation_;
		potential1_ = other.potential1_.Clone();
		potential2_ = other.potential2_.Clone();
		potential3_ = other.potential3_.Clone();
		potential4_ = other.potential4_.Clone();
		stopNormalAttack_ = other.stopNormalAttack_;
		searchRadius_ = other.searchRadius_;
		normalAttackRadius_ = other.normalAttackRadius_;
		skillRadius_ = other.skillRadius_;
		normal_ = other.normal_;
		skill_ = other.skill_;
		support_ = other.support_;
		type_ = other.type_;
		partnerType_ = other.partnerType_.Clone();
		aTKSPDP_ = other.aTKSPDP_;
		movType_ = other.movType_;
		walkSpd_ = other.walkSpd_;
		runSpd_ = other.runSpd_;
		spRunSpd_ = other.spRunSpd_;
		transSpd_ = other.transSpd_;
		walkToRunDuration_ = other.walkToRunDuration_;
		movAcc_ = other.movAcc_;
		rotSpd_ = other.rotSpd_;
		rotAcc_ = other.rotAcc_;
		weight_ = other.weight_;
		blockPriority_ = other.blockPriority_;
		aimAtTarget_ = other.aimAtTarget_;
		hideBlood_ = other.hideBlood_;
		boardChess_ = other.boardChess_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierCharacter Clone()
	{
		return new SoldierCharacter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierCharacter);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierCharacter other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Rarity != other.Rarity)
		{
			return false;
		}
		if (Cost != other.Cost)
		{
			return false;
		}
		if (MaxStar != other.MaxStar)
		{
			return false;
		}
		if (Faction != other.Faction)
		{
			return false;
		}
		if (CharacterType != other.CharacterType)
		{
			return false;
		}
		if (CharacterId != other.CharacterId)
		{
			return false;
		}
		if (Skin != other.Skin)
		{
			return false;
		}
		if (AIID != other.AIID)
		{
			return false;
		}
		if (Energy != other.Energy)
		{
			return false;
		}
		if (InitialEnergy != other.InitialEnergy)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Recovery, other.Recovery))
		{
			return false;
		}
		if (SkillEndStartRecover != other.SkillEndStartRecover)
		{
			return false;
		}
		if (Templete != other.Templete)
		{
			return false;
		}
		if (AssistSkillOnStageType != other.AssistSkillOnStageType)
		{
			return false;
		}
		if (AssistSkillAngle != other.AssistSkillAngle)
		{
			return false;
		}
		if (AssistSkillRadius != other.AssistSkillRadius)
		{
			return false;
		}
		if (AssistSkillOnStageOrientation != other.AssistSkillOnStageOrientation)
		{
			return false;
		}
		if (!potential1_.Equals(other.potential1_))
		{
			return false;
		}
		if (!potential2_.Equals(other.potential2_))
		{
			return false;
		}
		if (!potential3_.Equals(other.potential3_))
		{
			return false;
		}
		if (!potential4_.Equals(other.potential4_))
		{
			return false;
		}
		if (StopNormalAttack != other.StopNormalAttack)
		{
			return false;
		}
		if (SearchRadius != other.SearchRadius)
		{
			return false;
		}
		if (NormalAttackRadius != other.NormalAttackRadius)
		{
			return false;
		}
		if (SkillRadius != other.SkillRadius)
		{
			return false;
		}
		if (Normal != other.Normal)
		{
			return false;
		}
		if (Skill != other.Skill)
		{
			return false;
		}
		if (Support != other.Support)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (!partnerType_.Equals(other.partnerType_))
		{
			return false;
		}
		if (ATKSPDP != other.ATKSPDP)
		{
			return false;
		}
		if (MovType != other.MovType)
		{
			return false;
		}
		if (WalkSpd != other.WalkSpd)
		{
			return false;
		}
		if (RunSpd != other.RunSpd)
		{
			return false;
		}
		if (SpRunSpd != other.SpRunSpd)
		{
			return false;
		}
		if (TransSpd != other.TransSpd)
		{
			return false;
		}
		if (WalkToRunDuration != other.WalkToRunDuration)
		{
			return false;
		}
		if (MovAcc != other.MovAcc)
		{
			return false;
		}
		if (RotSpd != other.RotSpd)
		{
			return false;
		}
		if (RotAcc != other.RotAcc)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (BlockPriority != other.BlockPriority)
		{
			return false;
		}
		if (AimAtTarget != other.AimAtTarget)
		{
			return false;
		}
		if (HideBlood != other.HideBlood)
		{
			return false;
		}
		if (BoardChess != other.BoardChess)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Rarity != 0)
		{
			num ^= Rarity.GetHashCode();
		}
		if (Cost != 0)
		{
			num ^= Cost.GetHashCode();
		}
		if (MaxStar != 0)
		{
			num ^= MaxStar.GetHashCode();
		}
		if (Faction != 0)
		{
			num ^= Faction.GetHashCode();
		}
		if (CharacterType != 0)
		{
			num ^= CharacterType.GetHashCode();
		}
		if (CharacterId != 0)
		{
			num ^= CharacterId.GetHashCode();
		}
		if (Skin != 0)
		{
			num ^= Skin.GetHashCode();
		}
		if (AIID != 0)
		{
			num ^= AIID.GetHashCode();
		}
		if (Energy != 0)
		{
			num ^= Energy.GetHashCode();
		}
		if (InitialEnergy != 0)
		{
			num ^= InitialEnergy.GetHashCode();
		}
		if (Recovery != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Recovery);
		}
		if (SkillEndStartRecover)
		{
			num ^= SkillEndStartRecover.GetHashCode();
		}
		if (Templete != 0)
		{
			num ^= Templete.GetHashCode();
		}
		if (AssistSkillOnStageType != 0)
		{
			num ^= AssistSkillOnStageType.GetHashCode();
		}
		if (AssistSkillAngle != 0)
		{
			num ^= AssistSkillAngle.GetHashCode();
		}
		if (AssistSkillRadius != 0)
		{
			num ^= AssistSkillRadius.GetHashCode();
		}
		if (AssistSkillOnStageOrientation != 0)
		{
			num ^= AssistSkillOnStageOrientation.GetHashCode();
		}
		num ^= potential1_.GetHashCode();
		num ^= potential2_.GetHashCode();
		num ^= potential3_.GetHashCode();
		num ^= potential4_.GetHashCode();
		if (StopNormalAttack)
		{
			num ^= StopNormalAttack.GetHashCode();
		}
		if (SearchRadius != 0)
		{
			num ^= SearchRadius.GetHashCode();
		}
		if (NormalAttackRadius != 0)
		{
			num ^= NormalAttackRadius.GetHashCode();
		}
		if (SkillRadius != 0)
		{
			num ^= SkillRadius.GetHashCode();
		}
		if (Normal != 0)
		{
			num ^= Normal.GetHashCode();
		}
		if (Skill != 0)
		{
			num ^= Skill.GetHashCode();
		}
		if (Support != 0)
		{
			num ^= Support.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		num ^= partnerType_.GetHashCode();
		if (ATKSPDP != 0)
		{
			num ^= ATKSPDP.GetHashCode();
		}
		if (MovType != 0)
		{
			num ^= MovType.GetHashCode();
		}
		if (WalkSpd != 0)
		{
			num ^= WalkSpd.GetHashCode();
		}
		if (RunSpd != 0)
		{
			num ^= RunSpd.GetHashCode();
		}
		if (SpRunSpd != 0)
		{
			num ^= SpRunSpd.GetHashCode();
		}
		if (TransSpd != 0)
		{
			num ^= TransSpd.GetHashCode();
		}
		if (WalkToRunDuration != 0)
		{
			num ^= WalkToRunDuration.GetHashCode();
		}
		if (MovAcc != 0)
		{
			num ^= MovAcc.GetHashCode();
		}
		if (RotSpd != 0)
		{
			num ^= RotSpd.GetHashCode();
		}
		if (RotAcc != 0)
		{
			num ^= RotAcc.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (BlockPriority != 0)
		{
			num ^= BlockPriority.GetHashCode();
		}
		if (AimAtTarget)
		{
			num ^= AimAtTarget.GetHashCode();
		}
		if (HideBlood)
		{
			num ^= HideBlood.GetHashCode();
		}
		if (BoardChess)
		{
			num ^= BoardChess.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
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
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GroupId);
		}
		if (Rarity != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Rarity);
		}
		if (Cost != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Cost);
		}
		if (MaxStar != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(MaxStar);
		}
		if (Faction != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Faction);
		}
		if (CharacterType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(CharacterType);
		}
		if (CharacterId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CharacterId);
		}
		if (Skin != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Skin);
		}
		if (AIID != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(AIID);
		}
		if (Energy != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Energy);
		}
		if (InitialEnergy != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(InitialEnergy);
		}
		if (Recovery != 0f)
		{
			output.WriteRawTag(117);
			output.WriteFloat(Recovery);
		}
		if (SkillEndStartRecover)
		{
			output.WriteRawTag(120);
			output.WriteBool(SkillEndStartRecover);
		}
		if (Templete != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(Templete);
		}
		if (AssistSkillOnStageType != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(AssistSkillOnStageType);
		}
		if (AssistSkillAngle != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(AssistSkillAngle);
		}
		if (AssistSkillRadius != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(AssistSkillRadius);
		}
		if (AssistSkillOnStageOrientation != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(AssistSkillOnStageOrientation);
		}
		potential1_.WriteTo(output, _repeated_potential1_codec);
		potential2_.WriteTo(output, _repeated_potential2_codec);
		potential3_.WriteTo(output, _repeated_potential3_codec);
		potential4_.WriteTo(output, _repeated_potential4_codec);
		if (StopNormalAttack)
		{
			output.WriteRawTag(200, 1);
			output.WriteBool(StopNormalAttack);
		}
		if (SearchRadius != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(SearchRadius);
		}
		if (NormalAttackRadius != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(NormalAttackRadius);
		}
		if (SkillRadius != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(SkillRadius);
		}
		if (Normal != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(Normal);
		}
		if (Skill != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(Skill);
		}
		if (Support != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(Support);
		}
		if (Type != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(Type);
		}
		partnerType_.WriteTo(output, _repeated_partnerType_codec);
		if (ATKSPDP != 0)
		{
			output.WriteRawTag(144, 2);
			output.WriteInt32(ATKSPDP);
		}
		if (MovType != 0)
		{
			output.WriteRawTag(152, 2);
			output.WriteInt32(MovType);
		}
		if (WalkSpd != 0)
		{
			output.WriteRawTag(160, 2);
			output.WriteInt32(WalkSpd);
		}
		if (RunSpd != 0)
		{
			output.WriteRawTag(168, 2);
			output.WriteInt32(RunSpd);
		}
		if (SpRunSpd != 0)
		{
			output.WriteRawTag(176, 2);
			output.WriteInt32(SpRunSpd);
		}
		if (TransSpd != 0)
		{
			output.WriteRawTag(184, 2);
			output.WriteInt32(TransSpd);
		}
		if (WalkToRunDuration != 0)
		{
			output.WriteRawTag(192, 2);
			output.WriteInt32(WalkToRunDuration);
		}
		if (MovAcc != 0)
		{
			output.WriteRawTag(200, 2);
			output.WriteInt32(MovAcc);
		}
		if (RotSpd != 0)
		{
			output.WriteRawTag(208, 2);
			output.WriteInt32(RotSpd);
		}
		if (RotAcc != 0)
		{
			output.WriteRawTag(216, 2);
			output.WriteInt32(RotAcc);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(224, 2);
			output.WriteInt32(Weight);
		}
		if (BlockPriority != 0)
		{
			output.WriteRawTag(232, 2);
			output.WriteInt32(BlockPriority);
		}
		if (AimAtTarget)
		{
			output.WriteRawTag(240, 2);
			output.WriteBool(AimAtTarget);
		}
		if (HideBlood)
		{
			output.WriteRawTag(248, 2);
			output.WriteBool(HideBlood);
		}
		if (BoardChess)
		{
			output.WriteRawTag(128, 3);
			output.WriteBool(BoardChess);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(output);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Rarity != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rarity);
		}
		if (Cost != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cost);
		}
		if (MaxStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxStar);
		}
		if (Faction != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Faction);
		}
		if (CharacterType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterType);
		}
		if (CharacterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterId);
		}
		if (Skin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Skin);
		}
		if (AIID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AIID);
		}
		if (Energy != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Energy);
		}
		if (InitialEnergy != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(InitialEnergy);
		}
		if (Recovery != 0f)
		{
			num += 5;
		}
		if (SkillEndStartRecover)
		{
			num += 2;
		}
		if (Templete != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Templete);
		}
		if (AssistSkillOnStageType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillOnStageType);
		}
		if (AssistSkillAngle != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillAngle);
		}
		if (AssistSkillRadius != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillRadius);
		}
		if (AssistSkillOnStageOrientation != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AssistSkillOnStageOrientation);
		}
		num += potential1_.CalculateSize(_repeated_potential1_codec);
		num += potential2_.CalculateSize(_repeated_potential2_codec);
		num += potential3_.CalculateSize(_repeated_potential3_codec);
		num += potential4_.CalculateSize(_repeated_potential4_codec);
		if (StopNormalAttack)
		{
			num += 3;
		}
		if (SearchRadius != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SearchRadius);
		}
		if (NormalAttackRadius != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NormalAttackRadius);
		}
		if (SkillRadius != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillRadius);
		}
		if (Normal != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Normal);
		}
		if (Skill != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Skill);
		}
		if (Support != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Support);
		}
		if (Type != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Type);
		}
		num += partnerType_.CalculateSize(_repeated_partnerType_codec);
		if (ATKSPDP != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ATKSPDP);
		}
		if (MovType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MovType);
		}
		if (WalkSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WalkSpd);
		}
		if (RunSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RunSpd);
		}
		if (SpRunSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SpRunSpd);
		}
		if (TransSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TransSpd);
		}
		if (WalkToRunDuration != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WalkToRunDuration);
		}
		if (MovAcc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MovAcc);
		}
		if (RotSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotSpd);
		}
		if (RotAcc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotAcc);
		}
		if (Weight != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (BlockPriority != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BlockPriority);
		}
		if (AimAtTarget)
		{
			num += 3;
		}
		if (HideBlood)
		{
			num += 3;
		}
		if (BoardChess)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierCharacter other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Rarity != 0)
			{
				Rarity = other.Rarity;
			}
			if (other.Cost != 0)
			{
				Cost = other.Cost;
			}
			if (other.MaxStar != 0)
			{
				MaxStar = other.MaxStar;
			}
			if (other.Faction != 0)
			{
				Faction = other.Faction;
			}
			if (other.CharacterType != 0)
			{
				CharacterType = other.CharacterType;
			}
			if (other.CharacterId != 0)
			{
				CharacterId = other.CharacterId;
			}
			if (other.Skin != 0)
			{
				Skin = other.Skin;
			}
			if (other.AIID != 0)
			{
				AIID = other.AIID;
			}
			if (other.Energy != 0)
			{
				Energy = other.Energy;
			}
			if (other.InitialEnergy != 0)
			{
				InitialEnergy = other.InitialEnergy;
			}
			if (other.Recovery != 0f)
			{
				Recovery = other.Recovery;
			}
			if (other.SkillEndStartRecover)
			{
				SkillEndStartRecover = other.SkillEndStartRecover;
			}
			if (other.Templete != 0)
			{
				Templete = other.Templete;
			}
			if (other.AssistSkillOnStageType != 0)
			{
				AssistSkillOnStageType = other.AssistSkillOnStageType;
			}
			if (other.AssistSkillAngle != 0)
			{
				AssistSkillAngle = other.AssistSkillAngle;
			}
			if (other.AssistSkillRadius != 0)
			{
				AssistSkillRadius = other.AssistSkillRadius;
			}
			if (other.AssistSkillOnStageOrientation != 0)
			{
				AssistSkillOnStageOrientation = other.AssistSkillOnStageOrientation;
			}
			potential1_.Add(other.potential1_);
			potential2_.Add(other.potential2_);
			potential3_.Add(other.potential3_);
			potential4_.Add(other.potential4_);
			if (other.StopNormalAttack)
			{
				StopNormalAttack = other.StopNormalAttack;
			}
			if (other.SearchRadius != 0)
			{
				SearchRadius = other.SearchRadius;
			}
			if (other.NormalAttackRadius != 0)
			{
				NormalAttackRadius = other.NormalAttackRadius;
			}
			if (other.SkillRadius != 0)
			{
				SkillRadius = other.SkillRadius;
			}
			if (other.Normal != 0)
			{
				Normal = other.Normal;
			}
			if (other.Skill != 0)
			{
				Skill = other.Skill;
			}
			if (other.Support != 0)
			{
				Support = other.Support;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			partnerType_.Add(other.partnerType_);
			if (other.ATKSPDP != 0)
			{
				ATKSPDP = other.ATKSPDP;
			}
			if (other.MovType != 0)
			{
				MovType = other.MovType;
			}
			if (other.WalkSpd != 0)
			{
				WalkSpd = other.WalkSpd;
			}
			if (other.RunSpd != 0)
			{
				RunSpd = other.RunSpd;
			}
			if (other.SpRunSpd != 0)
			{
				SpRunSpd = other.SpRunSpd;
			}
			if (other.TransSpd != 0)
			{
				TransSpd = other.TransSpd;
			}
			if (other.WalkToRunDuration != 0)
			{
				WalkToRunDuration = other.WalkToRunDuration;
			}
			if (other.MovAcc != 0)
			{
				MovAcc = other.MovAcc;
			}
			if (other.RotSpd != 0)
			{
				RotSpd = other.RotSpd;
			}
			if (other.RotAcc != 0)
			{
				RotAcc = other.RotAcc;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.BlockPriority != 0)
			{
				BlockPriority = other.BlockPriority;
			}
			if (other.AimAtTarget)
			{
				AimAtTarget = other.AimAtTarget;
			}
			if (other.HideBlood)
			{
				HideBlood = other.HideBlood;
			}
			if (other.BoardChess)
			{
				BoardChess = other.BoardChess;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
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
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				GroupId = input.ReadInt32();
				break;
			case 32u:
				Rarity = input.ReadInt32();
				break;
			case 40u:
				Cost = input.ReadInt32();
				break;
			case 48u:
				MaxStar = input.ReadInt32();
				break;
			case 56u:
				Faction = input.ReadInt32();
				break;
			case 64u:
				CharacterType = input.ReadInt32();
				break;
			case 72u:
				CharacterId = input.ReadInt32();
				break;
			case 80u:
				Skin = input.ReadInt32();
				break;
			case 88u:
				AIID = input.ReadInt32();
				break;
			case 96u:
				Energy = input.ReadInt32();
				break;
			case 104u:
				InitialEnergy = input.ReadInt32();
				break;
			case 117u:
				Recovery = input.ReadFloat();
				break;
			case 120u:
				SkillEndStartRecover = input.ReadBool();
				break;
			case 128u:
				Templete = input.ReadInt32();
				break;
			case 136u:
				AssistSkillOnStageType = input.ReadInt32();
				break;
			case 144u:
				AssistSkillAngle = input.ReadInt32();
				break;
			case 152u:
				AssistSkillRadius = input.ReadInt32();
				break;
			case 160u:
				AssistSkillOnStageOrientation = input.ReadInt32();
				break;
			case 168u:
			case 170u:
				potential1_.AddEntriesFrom(input, _repeated_potential1_codec);
				break;
			case 176u:
			case 178u:
				potential2_.AddEntriesFrom(input, _repeated_potential2_codec);
				break;
			case 184u:
			case 186u:
				potential3_.AddEntriesFrom(input, _repeated_potential3_codec);
				break;
			case 192u:
			case 194u:
				potential4_.AddEntriesFrom(input, _repeated_potential4_codec);
				break;
			case 200u:
				StopNormalAttack = input.ReadBool();
				break;
			case 208u:
				SearchRadius = input.ReadInt32();
				break;
			case 216u:
				NormalAttackRadius = input.ReadInt32();
				break;
			case 224u:
				SkillRadius = input.ReadInt32();
				break;
			case 232u:
				Normal = input.ReadInt32();
				break;
			case 240u:
				Skill = input.ReadInt32();
				break;
			case 248u:
				Support = input.ReadInt32();
				break;
			case 256u:
				Type = input.ReadInt32();
				break;
			case 264u:
			case 266u:
				partnerType_.AddEntriesFrom(input, _repeated_partnerType_codec);
				break;
			case 272u:
				ATKSPDP = input.ReadInt32();
				break;
			case 280u:
				MovType = input.ReadInt32();
				break;
			case 288u:
				WalkSpd = input.ReadInt32();
				break;
			case 296u:
				RunSpd = input.ReadInt32();
				break;
			case 304u:
				SpRunSpd = input.ReadInt32();
				break;
			case 312u:
				TransSpd = input.ReadInt32();
				break;
			case 320u:
				WalkToRunDuration = input.ReadInt32();
				break;
			case 328u:
				MovAcc = input.ReadInt32();
				break;
			case 336u:
				RotSpd = input.ReadInt32();
				break;
			case 344u:
				RotAcc = input.ReadInt32();
				break;
			case 352u:
				Weight = input.ReadInt32();
				break;
			case 360u:
				BlockPriority = input.ReadInt32();
				break;
			case 368u:
				AimAtTarget = input.ReadBool();
				break;
			case 376u:
				HideBlood = input.ReadBool();
				break;
			case 384u:
				BoardChess = input.ReadBool();
				break;
			}
		}
	}
}
