using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Monster : IMessage<Monster>, IMessage, IEquatable<Monster>, IDeepCloneable<Monster>
{
	private static readonly MessageParser<Monster> _parser = new MessageParser<Monster>(() => new Monster());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int EpicLvFieldNumber = 3;

	private int epicLv_;

	public const int SubBossTypeFieldNumber = 4;

	private int subBossType_;

	public const int MonsterPositionFieldNumber = 5;

	private int monsterPosition_;

	public const int BloodTypeFieldNumber = 6;

	private int bloodType_;

	public const int ForceFieldNumber = 7;

	private string force_ = "";

	public const int FCIdFieldNumber = 8;

	private int fCId_;

	public const int FAIdFieldNumber = 9;

	private int fAId_;

	public const int MovTypeFieldNumber = 10;

	private int movType_;

	public const int RunSpdFieldNumber = 11;

	private int runSpd_;

	public const int TransSpdScaleFieldNumber = 12;

	private int transSpdScale_;

	public const int WalkSpdFieldNumber = 13;

	private int walkSpd_;

	public const int MovAccFieldNumber = 14;

	private int movAcc_;

	public const int VisionRngFieldNumber = 15;

	private int visionRng_;

	public const int VisionDegFieldNumber = 16;

	private int visionDeg_;

	public const int HearRngFieldNumber = 17;

	private int hearRng_;

	public const int RefRngFieldNumber = 18;

	private int refRng_;

	public const int ActRngFieldNumber = 19;

	private int actRng_;

	public const int DisActRngFieldNumber = 20;

	private int disActRng_;

	public const int SearchRngFieldNumber = 21;

	private int searchRng_;

	public const int RotSpdFieldNumber = 22;

	private int rotSpd_;

	public const int RotSpdInSkillFieldNumber = 23;

	private int rotSpdInSkill_;

	public const int TempleteFieldNumber = 24;

	private int templete_;

	public const int BuffIdsFieldNumber = 25;

	private static readonly FieldCodec<int> _repeated_buffIds_codec = FieldCodec.ForInt32(202u);

	private readonly RepeatedField<int> buffIds_ = new RepeatedField<int>();

	public const int SubTypeFieldNumber = 26;

	private int subType_;

	public const int FactionFieldNumber = 27;

	private int faction_;

	public const int TrapTagIdsFieldNumber = 28;

	private static readonly FieldCodec<int> _repeated_trapTagIds_codec = FieldCodec.ForInt32(226u);

	private readonly RepeatedField<int> trapTagIds_ = new RepeatedField<int>();

	public const int SupChargeFieldNumber = 29;

	private int supCharge_;

	public const int IsShowRngFieldNumber = 30;

	private bool isShowRng_;

	public const int WeightFieldNumber = 31;

	private int weight_;

	public const int ToughnessBrokenTimeFieldNumber = 32;

	private int toughnessBrokenTime_;

	public const int IsToughnessRecorverFieldNumber = 33;

	private bool isToughnessRecorver_;

	public const int Tag1FieldNumber = 34;

	private string tag1_ = "";

	public const int Tag2FieldNumber = 35;

	private string tag2_ = "";

	public const int Tag3FieldNumber = 36;

	private string tag3_ = "";

	public const int Tag4FieldNumber = 37;

	private string tag4_ = "";

	public const int Tag5FieldNumber = 38;

	private string tag5_ = "";

	public const int AttackHintTypeFieldNumber = 39;

	private int attackHintType_;

	public const int BlockPriorityFieldNumber = 40;

	private int blockPriority_;

	public const int MonsterTeamIdFieldNumber = 41;

	private int monsterTeamId_;

	[DebuggerNonUserCode]
	public static MessageParser<Monster> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(566);

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
	public int EpicLv
	{
		get
		{
			return epicLv_;
		}
		set
		{
			epicLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubBossType
	{
		get
		{
			return subBossType_;
		}
		set
		{
			subBossType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MonsterPosition
	{
		get
		{
			return monsterPosition_;
		}
		set
		{
			monsterPosition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BloodType
	{
		get
		{
			return bloodType_;
		}
		set
		{
			bloodType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Force
	{
		get
		{
			return force_;
		}
		set
		{
			force_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int FCId
	{
		get
		{
			return fCId_;
		}
		set
		{
			fCId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FAId
	{
		get
		{
			return fAId_;
		}
		set
		{
			fAId_ = value;
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
	public int TransSpdScale
	{
		get
		{
			return transSpdScale_;
		}
		set
		{
			transSpdScale_ = value;
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
	public int VisionRng
	{
		get
		{
			return visionRng_;
		}
		set
		{
			visionRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VisionDeg
	{
		get
		{
			return visionDeg_;
		}
		set
		{
			visionDeg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HearRng
	{
		get
		{
			return hearRng_;
		}
		set
		{
			hearRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RefRng
	{
		get
		{
			return refRng_;
		}
		set
		{
			refRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActRng
	{
		get
		{
			return actRng_;
		}
		set
		{
			actRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DisActRng
	{
		get
		{
			return disActRng_;
		}
		set
		{
			disActRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SearchRng
	{
		get
		{
			return searchRng_;
		}
		set
		{
			searchRng_ = value;
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
	public int RotSpdInSkill
	{
		get
		{
			return rotSpdInSkill_;
		}
		set
		{
			rotSpdInSkill_ = value;
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
	public RepeatedField<int> BuffIds => buffIds_;

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
	public RepeatedField<int> TrapTagIds => trapTagIds_;

	[DebuggerNonUserCode]
	public int SupCharge
	{
		get
		{
			return supCharge_;
		}
		set
		{
			supCharge_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsShowRng
	{
		get
		{
			return isShowRng_;
		}
		set
		{
			isShowRng_ = value;
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
	public int ToughnessBrokenTime
	{
		get
		{
			return toughnessBrokenTime_;
		}
		set
		{
			toughnessBrokenTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsToughnessRecorver
	{
		get
		{
			return isToughnessRecorver_;
		}
		set
		{
			isToughnessRecorver_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Tag1
	{
		get
		{
			return tag1_;
		}
		set
		{
			tag1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag2
	{
		get
		{
			return tag2_;
		}
		set
		{
			tag2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag3
	{
		get
		{
			return tag3_;
		}
		set
		{
			tag3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag4
	{
		get
		{
			return tag4_;
		}
		set
		{
			tag4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag5
	{
		get
		{
			return tag5_;
		}
		set
		{
			tag5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int AttackHintType
	{
		get
		{
			return attackHintType_;
		}
		set
		{
			attackHintType_ = value;
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
	public int MonsterTeamId
	{
		get
		{
			return monsterTeamId_;
		}
		set
		{
			monsterTeamId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Monster()
	{
	}

	[DebuggerNonUserCode]
	public Monster(Monster other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		epicLv_ = other.epicLv_;
		subBossType_ = other.subBossType_;
		monsterPosition_ = other.monsterPosition_;
		bloodType_ = other.bloodType_;
		force_ = other.force_;
		fCId_ = other.fCId_;
		fAId_ = other.fAId_;
		movType_ = other.movType_;
		runSpd_ = other.runSpd_;
		transSpdScale_ = other.transSpdScale_;
		walkSpd_ = other.walkSpd_;
		movAcc_ = other.movAcc_;
		visionRng_ = other.visionRng_;
		visionDeg_ = other.visionDeg_;
		hearRng_ = other.hearRng_;
		refRng_ = other.refRng_;
		actRng_ = other.actRng_;
		disActRng_ = other.disActRng_;
		searchRng_ = other.searchRng_;
		rotSpd_ = other.rotSpd_;
		rotSpdInSkill_ = other.rotSpdInSkill_;
		templete_ = other.templete_;
		buffIds_ = other.buffIds_.Clone();
		subType_ = other.subType_;
		faction_ = other.faction_;
		trapTagIds_ = other.trapTagIds_.Clone();
		supCharge_ = other.supCharge_;
		isShowRng_ = other.isShowRng_;
		weight_ = other.weight_;
		toughnessBrokenTime_ = other.toughnessBrokenTime_;
		isToughnessRecorver_ = other.isToughnessRecorver_;
		tag1_ = other.tag1_;
		tag2_ = other.tag2_;
		tag3_ = other.tag3_;
		tag4_ = other.tag4_;
		tag5_ = other.tag5_;
		attackHintType_ = other.attackHintType_;
		blockPriority_ = other.blockPriority_;
		monsterTeamId_ = other.monsterTeamId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Monster Clone()
	{
		return new Monster(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Monster);
	}

	[DebuggerNonUserCode]
	public bool Equals(Monster other)
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
		if (EpicLv != other.EpicLv)
		{
			return false;
		}
		if (SubBossType != other.SubBossType)
		{
			return false;
		}
		if (MonsterPosition != other.MonsterPosition)
		{
			return false;
		}
		if (BloodType != other.BloodType)
		{
			return false;
		}
		if (Force != other.Force)
		{
			return false;
		}
		if (FCId != other.FCId)
		{
			return false;
		}
		if (FAId != other.FAId)
		{
			return false;
		}
		if (MovType != other.MovType)
		{
			return false;
		}
		if (RunSpd != other.RunSpd)
		{
			return false;
		}
		if (TransSpdScale != other.TransSpdScale)
		{
			return false;
		}
		if (WalkSpd != other.WalkSpd)
		{
			return false;
		}
		if (MovAcc != other.MovAcc)
		{
			return false;
		}
		if (VisionRng != other.VisionRng)
		{
			return false;
		}
		if (VisionDeg != other.VisionDeg)
		{
			return false;
		}
		if (HearRng != other.HearRng)
		{
			return false;
		}
		if (RefRng != other.RefRng)
		{
			return false;
		}
		if (ActRng != other.ActRng)
		{
			return false;
		}
		if (DisActRng != other.DisActRng)
		{
			return false;
		}
		if (SearchRng != other.SearchRng)
		{
			return false;
		}
		if (RotSpd != other.RotSpd)
		{
			return false;
		}
		if (RotSpdInSkill != other.RotSpdInSkill)
		{
			return false;
		}
		if (Templete != other.Templete)
		{
			return false;
		}
		if (!buffIds_.Equals(other.buffIds_))
		{
			return false;
		}
		if (SubType != other.SubType)
		{
			return false;
		}
		if (Faction != other.Faction)
		{
			return false;
		}
		if (!trapTagIds_.Equals(other.trapTagIds_))
		{
			return false;
		}
		if (SupCharge != other.SupCharge)
		{
			return false;
		}
		if (IsShowRng != other.IsShowRng)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (ToughnessBrokenTime != other.ToughnessBrokenTime)
		{
			return false;
		}
		if (IsToughnessRecorver != other.IsToughnessRecorver)
		{
			return false;
		}
		if (Tag1 != other.Tag1)
		{
			return false;
		}
		if (Tag2 != other.Tag2)
		{
			return false;
		}
		if (Tag3 != other.Tag3)
		{
			return false;
		}
		if (Tag4 != other.Tag4)
		{
			return false;
		}
		if (Tag5 != other.Tag5)
		{
			return false;
		}
		if (AttackHintType != other.AttackHintType)
		{
			return false;
		}
		if (BlockPriority != other.BlockPriority)
		{
			return false;
		}
		if (MonsterTeamId != other.MonsterTeamId)
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
		if (EpicLv != 0)
		{
			num ^= EpicLv.GetHashCode();
		}
		if (SubBossType != 0)
		{
			num ^= SubBossType.GetHashCode();
		}
		if (MonsterPosition != 0)
		{
			num ^= MonsterPosition.GetHashCode();
		}
		if (BloodType != 0)
		{
			num ^= BloodType.GetHashCode();
		}
		if (Force.Length != 0)
		{
			num ^= Force.GetHashCode();
		}
		if (FCId != 0)
		{
			num ^= FCId.GetHashCode();
		}
		if (FAId != 0)
		{
			num ^= FAId.GetHashCode();
		}
		if (MovType != 0)
		{
			num ^= MovType.GetHashCode();
		}
		if (RunSpd != 0)
		{
			num ^= RunSpd.GetHashCode();
		}
		if (TransSpdScale != 0)
		{
			num ^= TransSpdScale.GetHashCode();
		}
		if (WalkSpd != 0)
		{
			num ^= WalkSpd.GetHashCode();
		}
		if (MovAcc != 0)
		{
			num ^= MovAcc.GetHashCode();
		}
		if (VisionRng != 0)
		{
			num ^= VisionRng.GetHashCode();
		}
		if (VisionDeg != 0)
		{
			num ^= VisionDeg.GetHashCode();
		}
		if (HearRng != 0)
		{
			num ^= HearRng.GetHashCode();
		}
		if (RefRng != 0)
		{
			num ^= RefRng.GetHashCode();
		}
		if (ActRng != 0)
		{
			num ^= ActRng.GetHashCode();
		}
		if (DisActRng != 0)
		{
			num ^= DisActRng.GetHashCode();
		}
		if (SearchRng != 0)
		{
			num ^= SearchRng.GetHashCode();
		}
		if (RotSpd != 0)
		{
			num ^= RotSpd.GetHashCode();
		}
		if (RotSpdInSkill != 0)
		{
			num ^= RotSpdInSkill.GetHashCode();
		}
		if (Templete != 0)
		{
			num ^= Templete.GetHashCode();
		}
		num ^= buffIds_.GetHashCode();
		if (SubType != 0)
		{
			num ^= SubType.GetHashCode();
		}
		if (Faction != 0)
		{
			num ^= Faction.GetHashCode();
		}
		num ^= trapTagIds_.GetHashCode();
		if (SupCharge != 0)
		{
			num ^= SupCharge.GetHashCode();
		}
		if (IsShowRng)
		{
			num ^= IsShowRng.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (ToughnessBrokenTime != 0)
		{
			num ^= ToughnessBrokenTime.GetHashCode();
		}
		if (IsToughnessRecorver)
		{
			num ^= IsToughnessRecorver.GetHashCode();
		}
		if (Tag1.Length != 0)
		{
			num ^= Tag1.GetHashCode();
		}
		if (Tag2.Length != 0)
		{
			num ^= Tag2.GetHashCode();
		}
		if (Tag3.Length != 0)
		{
			num ^= Tag3.GetHashCode();
		}
		if (Tag4.Length != 0)
		{
			num ^= Tag4.GetHashCode();
		}
		if (Tag5.Length != 0)
		{
			num ^= Tag5.GetHashCode();
		}
		if (AttackHintType != 0)
		{
			num ^= AttackHintType.GetHashCode();
		}
		if (BlockPriority != 0)
		{
			num ^= BlockPriority.GetHashCode();
		}
		if (MonsterTeamId != 0)
		{
			num ^= MonsterTeamId.GetHashCode();
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
		if (EpicLv != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EpicLv);
		}
		if (SubBossType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(SubBossType);
		}
		if (MonsterPosition != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MonsterPosition);
		}
		if (BloodType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(BloodType);
		}
		if (Force.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Force);
		}
		if (FCId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(FCId);
		}
		if (FAId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(FAId);
		}
		if (MovType != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(MovType);
		}
		if (RunSpd != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(RunSpd);
		}
		if (TransSpdScale != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(TransSpdScale);
		}
		if (WalkSpd != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(WalkSpd);
		}
		if (MovAcc != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(MovAcc);
		}
		if (VisionRng != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(VisionRng);
		}
		if (VisionDeg != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(VisionDeg);
		}
		if (HearRng != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(HearRng);
		}
		if (RefRng != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(RefRng);
		}
		if (ActRng != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(ActRng);
		}
		if (DisActRng != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(DisActRng);
		}
		if (SearchRng != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(SearchRng);
		}
		if (RotSpd != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(RotSpd);
		}
		if (RotSpdInSkill != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(RotSpdInSkill);
		}
		if (Templete != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(Templete);
		}
		buffIds_.WriteTo(output, _repeated_buffIds_codec);
		if (SubType != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(SubType);
		}
		if (Faction != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(Faction);
		}
		trapTagIds_.WriteTo(output, _repeated_trapTagIds_codec);
		if (SupCharge != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(SupCharge);
		}
		if (IsShowRng)
		{
			output.WriteRawTag(240, 1);
			output.WriteBool(IsShowRng);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(Weight);
		}
		if (ToughnessBrokenTime != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(ToughnessBrokenTime);
		}
		if (IsToughnessRecorver)
		{
			output.WriteRawTag(136, 2);
			output.WriteBool(IsToughnessRecorver);
		}
		if (Tag1.Length != 0)
		{
			output.WriteRawTag(146, 2);
			output.WriteString(Tag1);
		}
		if (Tag2.Length != 0)
		{
			output.WriteRawTag(154, 2);
			output.WriteString(Tag2);
		}
		if (Tag3.Length != 0)
		{
			output.WriteRawTag(162, 2);
			output.WriteString(Tag3);
		}
		if (Tag4.Length != 0)
		{
			output.WriteRawTag(170, 2);
			output.WriteString(Tag4);
		}
		if (Tag5.Length != 0)
		{
			output.WriteRawTag(178, 2);
			output.WriteString(Tag5);
		}
		if (AttackHintType != 0)
		{
			output.WriteRawTag(184, 2);
			output.WriteInt32(AttackHintType);
		}
		if (BlockPriority != 0)
		{
			output.WriteRawTag(192, 2);
			output.WriteInt32(BlockPriority);
		}
		if (MonsterTeamId != 0)
		{
			output.WriteRawTag(200, 2);
			output.WriteInt32(MonsterTeamId);
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
		if (EpicLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EpicLv);
		}
		if (SubBossType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubBossType);
		}
		if (MonsterPosition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterPosition);
		}
		if (BloodType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BloodType);
		}
		if (Force.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Force);
		}
		if (FCId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FCId);
		}
		if (FAId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FAId);
		}
		if (MovType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MovType);
		}
		if (RunSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RunSpd);
		}
		if (TransSpdScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TransSpdScale);
		}
		if (WalkSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WalkSpd);
		}
		if (MovAcc != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MovAcc);
		}
		if (VisionRng != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(VisionRng);
		}
		if (VisionDeg != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(VisionDeg);
		}
		if (HearRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HearRng);
		}
		if (RefRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RefRng);
		}
		if (ActRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ActRng);
		}
		if (DisActRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DisActRng);
		}
		if (SearchRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SearchRng);
		}
		if (RotSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotSpd);
		}
		if (RotSpdInSkill != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotSpdInSkill);
		}
		if (Templete != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Templete);
		}
		num += buffIds_.CalculateSize(_repeated_buffIds_codec);
		if (SubType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SubType);
		}
		if (Faction != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Faction);
		}
		num += trapTagIds_.CalculateSize(_repeated_trapTagIds_codec);
		if (SupCharge != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SupCharge);
		}
		if (IsShowRng)
		{
			num += 3;
		}
		if (Weight != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (ToughnessBrokenTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ToughnessBrokenTime);
		}
		if (IsToughnessRecorver)
		{
			num += 3;
		}
		if (Tag1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag1);
		}
		if (Tag2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag2);
		}
		if (Tag3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag3);
		}
		if (Tag4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag4);
		}
		if (Tag5.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag5);
		}
		if (AttackHintType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AttackHintType);
		}
		if (BlockPriority != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BlockPriority);
		}
		if (MonsterTeamId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MonsterTeamId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Monster other)
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
			if (other.EpicLv != 0)
			{
				EpicLv = other.EpicLv;
			}
			if (other.SubBossType != 0)
			{
				SubBossType = other.SubBossType;
			}
			if (other.MonsterPosition != 0)
			{
				MonsterPosition = other.MonsterPosition;
			}
			if (other.BloodType != 0)
			{
				BloodType = other.BloodType;
			}
			if (other.Force.Length != 0)
			{
				Force = other.Force;
			}
			if (other.FCId != 0)
			{
				FCId = other.FCId;
			}
			if (other.FAId != 0)
			{
				FAId = other.FAId;
			}
			if (other.MovType != 0)
			{
				MovType = other.MovType;
			}
			if (other.RunSpd != 0)
			{
				RunSpd = other.RunSpd;
			}
			if (other.TransSpdScale != 0)
			{
				TransSpdScale = other.TransSpdScale;
			}
			if (other.WalkSpd != 0)
			{
				WalkSpd = other.WalkSpd;
			}
			if (other.MovAcc != 0)
			{
				MovAcc = other.MovAcc;
			}
			if (other.VisionRng != 0)
			{
				VisionRng = other.VisionRng;
			}
			if (other.VisionDeg != 0)
			{
				VisionDeg = other.VisionDeg;
			}
			if (other.HearRng != 0)
			{
				HearRng = other.HearRng;
			}
			if (other.RefRng != 0)
			{
				RefRng = other.RefRng;
			}
			if (other.ActRng != 0)
			{
				ActRng = other.ActRng;
			}
			if (other.DisActRng != 0)
			{
				DisActRng = other.DisActRng;
			}
			if (other.SearchRng != 0)
			{
				SearchRng = other.SearchRng;
			}
			if (other.RotSpd != 0)
			{
				RotSpd = other.RotSpd;
			}
			if (other.RotSpdInSkill != 0)
			{
				RotSpdInSkill = other.RotSpdInSkill;
			}
			if (other.Templete != 0)
			{
				Templete = other.Templete;
			}
			buffIds_.Add(other.buffIds_);
			if (other.SubType != 0)
			{
				SubType = other.SubType;
			}
			if (other.Faction != 0)
			{
				Faction = other.Faction;
			}
			trapTagIds_.Add(other.trapTagIds_);
			if (other.SupCharge != 0)
			{
				SupCharge = other.SupCharge;
			}
			if (other.IsShowRng)
			{
				IsShowRng = other.IsShowRng;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.ToughnessBrokenTime != 0)
			{
				ToughnessBrokenTime = other.ToughnessBrokenTime;
			}
			if (other.IsToughnessRecorver)
			{
				IsToughnessRecorver = other.IsToughnessRecorver;
			}
			if (other.Tag1.Length != 0)
			{
				Tag1 = other.Tag1;
			}
			if (other.Tag2.Length != 0)
			{
				Tag2 = other.Tag2;
			}
			if (other.Tag3.Length != 0)
			{
				Tag3 = other.Tag3;
			}
			if (other.Tag4.Length != 0)
			{
				Tag4 = other.Tag4;
			}
			if (other.Tag5.Length != 0)
			{
				Tag5 = other.Tag5;
			}
			if (other.AttackHintType != 0)
			{
				AttackHintType = other.AttackHintType;
			}
			if (other.BlockPriority != 0)
			{
				BlockPriority = other.BlockPriority;
			}
			if (other.MonsterTeamId != 0)
			{
				MonsterTeamId = other.MonsterTeamId;
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
				EpicLv = input.ReadInt32();
				break;
			case 32u:
				SubBossType = input.ReadInt32();
				break;
			case 40u:
				MonsterPosition = input.ReadInt32();
				break;
			case 48u:
				BloodType = input.ReadInt32();
				break;
			case 58u:
				Force = input.ReadString();
				break;
			case 64u:
				FCId = input.ReadInt32();
				break;
			case 72u:
				FAId = input.ReadInt32();
				break;
			case 80u:
				MovType = input.ReadInt32();
				break;
			case 88u:
				RunSpd = input.ReadInt32();
				break;
			case 96u:
				TransSpdScale = input.ReadInt32();
				break;
			case 104u:
				WalkSpd = input.ReadInt32();
				break;
			case 112u:
				MovAcc = input.ReadInt32();
				break;
			case 120u:
				VisionRng = input.ReadInt32();
				break;
			case 128u:
				VisionDeg = input.ReadInt32();
				break;
			case 136u:
				HearRng = input.ReadInt32();
				break;
			case 144u:
				RefRng = input.ReadInt32();
				break;
			case 152u:
				ActRng = input.ReadInt32();
				break;
			case 160u:
				DisActRng = input.ReadInt32();
				break;
			case 168u:
				SearchRng = input.ReadInt32();
				break;
			case 176u:
				RotSpd = input.ReadInt32();
				break;
			case 184u:
				RotSpdInSkill = input.ReadInt32();
				break;
			case 192u:
				Templete = input.ReadInt32();
				break;
			case 200u:
			case 202u:
				buffIds_.AddEntriesFrom(input, _repeated_buffIds_codec);
				break;
			case 208u:
				SubType = input.ReadInt32();
				break;
			case 216u:
				Faction = input.ReadInt32();
				break;
			case 224u:
			case 226u:
				trapTagIds_.AddEntriesFrom(input, _repeated_trapTagIds_codec);
				break;
			case 232u:
				SupCharge = input.ReadInt32();
				break;
			case 240u:
				IsShowRng = input.ReadBool();
				break;
			case 248u:
				Weight = input.ReadInt32();
				break;
			case 256u:
				ToughnessBrokenTime = input.ReadInt32();
				break;
			case 264u:
				IsToughnessRecorver = input.ReadBool();
				break;
			case 274u:
				Tag1 = input.ReadString();
				break;
			case 282u:
				Tag2 = input.ReadString();
				break;
			case 290u:
				Tag3 = input.ReadString();
				break;
			case 298u:
				Tag4 = input.ReadString();
				break;
			case 306u:
				Tag5 = input.ReadString();
				break;
			case 312u:
				AttackHintType = input.ReadInt32();
				break;
			case 320u:
				BlockPriority = input.ReadInt32();
				break;
			case 328u:
				MonsterTeamId = input.ReadInt32();
				break;
			}
		}
	}
}
