using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace NetProcol;

public sealed class SceneDataForExcehangeInfo : IMessage<SceneDataForExcehangeInfo>, IMessage, IEquatable<SceneDataForExcehangeInfo>, IDeepCloneable<SceneDataForExcehangeInfo>
{
	private static readonly MessageParser<SceneDataForExcehangeInfo> _parser = new MessageParser<SceneDataForExcehangeInfo>(() => new SceneDataForExcehangeInfo());

	public const int MSceneIDFieldNumber = 1;

	private int mSceneID_;

	public const int MMissionClearTimesFieldNumber = 2;

	private int mMissionClearTimes_;

	public const int TypeIDListAffixFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_typeIDListAffix_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> typeIDListAffix_ = new RepeatedField<int>();

	public const int LevelListFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_levelList_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> levelList_ = new RepeatedField<int>();

	public const int EnemyTypesFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_enemyTypes_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> enemyTypes_ = new RepeatedField<int>();

	public const int RoleDataInLuaFieldNumber = 6;

	private static readonly FieldCodec<RoleDataForExchangeInfo> _repeated_roleDataInLua_codec = FieldCodec.ForMessage(50u, RoleDataForExchangeInfo.Parser);

	private readonly RepeatedField<RoleDataForExchangeInfo> roleDataInLua_ = new RepeatedField<RoleDataForExchangeInfo>();

	public const int ChallengeFactorFieldNumber = 7;

	private int challengeFactor_;

	public const int AdaptiveEnemyLevelFieldNumber = 8;

	private int adaptiveEnemyLevel_;

	public const int DifficultyFieldNumber = 9;

	private int difficulty_;

	public const int NeedResurrectFieldNumber = 10;

	private bool needResurrect_;

	public const int CoinNumberFieldNumber = 11;

	private long coinNumber_;

	public const int CoinConsumeFieldNumber = 12;

	private long coinConsume_;

	public const int CooperateUniqueSkillIDFieldNumber = 13;

	private int cooperateUniqueSkillID_;

	public const int AttributeFactorXFieldNumber = 14;

	private int attributeFactorX_;

	public const int AttributeFactorYFieldNumber = 15;

	private int attributeFactorY_;

	public const int AttributeFactorZFieldNumber = 16;

	private int attributeFactorZ_;

	public const int IndexOfMaxCountRaceFieldNumber = 17;

	private int indexOfMaxCountRace_;

	public const int NumOfMaxCountRaceFieldNumber = 18;

	private int numOfMaxCountRace_;

	public const int LeftTimeFieldNumber = 19;

	private int leftTime_;

	public const int TargetEnemyIDFieldNumber = 20;

	private int targetEnemyID_;

	public const int ResurrectHPFieldNumber = 21;

	private int resurrectHP_;

	public const int CooperateUniqueSkillLevelFieldNumber = 22;

	private int cooperateUniqueSkillLevel_;

	public const int VHLSkillIDFieldNumber = 23;

	private static readonly FieldCodec<int> _repeated_vHLSkillID_codec = FieldCodec.ForInt32(186u);

	private readonly RepeatedField<int> vHLSkillID_ = new RepeatedField<int>();

	public const int VHLResultFieldNumber = 24;

	private int vHLResult_;

	public const int MasterSkillFieldNumber = 25;

	private RoleDataForExchangeInfo masterSkill_;

	[DebuggerNonUserCode]
	public static MessageParser<SceneDataForExcehangeInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[16];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int MSceneID
	{
		get
		{
			return mSceneID_;
		}
		set
		{
			mSceneID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MMissionClearTimes
	{
		get
		{
			return mMissionClearTimes_;
		}
		set
		{
			mMissionClearTimes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TypeIDListAffix => typeIDListAffix_;

	[DebuggerNonUserCode]
	public RepeatedField<int> LevelList => levelList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> EnemyTypes => enemyTypes_;

	[DebuggerNonUserCode]
	public RepeatedField<RoleDataForExchangeInfo> RoleDataInLua => roleDataInLua_;

	[DebuggerNonUserCode]
	public int ChallengeFactor
	{
		get
		{
			return challengeFactor_;
		}
		set
		{
			challengeFactor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AdaptiveEnemyLevel
	{
		get
		{
			return adaptiveEnemyLevel_;
		}
		set
		{
			adaptiveEnemyLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Difficulty
	{
		get
		{
			return difficulty_;
		}
		set
		{
			difficulty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool NeedResurrect
	{
		get
		{
			return needResurrect_;
		}
		set
		{
			needResurrect_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long CoinNumber
	{
		get
		{
			return coinNumber_;
		}
		set
		{
			coinNumber_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long CoinConsume
	{
		get
		{
			return coinConsume_;
		}
		set
		{
			coinConsume_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CooperateUniqueSkillID
	{
		get
		{
			return cooperateUniqueSkillID_;
		}
		set
		{
			cooperateUniqueSkillID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttributeFactorX
	{
		get
		{
			return attributeFactorX_;
		}
		set
		{
			attributeFactorX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttributeFactorY
	{
		get
		{
			return attributeFactorY_;
		}
		set
		{
			attributeFactorY_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AttributeFactorZ
	{
		get
		{
			return attributeFactorZ_;
		}
		set
		{
			attributeFactorZ_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int IndexOfMaxCountRace
	{
		get
		{
			return indexOfMaxCountRace_;
		}
		set
		{
			indexOfMaxCountRace_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NumOfMaxCountRace
	{
		get
		{
			return numOfMaxCountRace_;
		}
		set
		{
			numOfMaxCountRace_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LeftTime
	{
		get
		{
			return leftTime_;
		}
		set
		{
			leftTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TargetEnemyID
	{
		get
		{
			return targetEnemyID_;
		}
		set
		{
			targetEnemyID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ResurrectHP
	{
		get
		{
			return resurrectHP_;
		}
		set
		{
			resurrectHP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CooperateUniqueSkillLevel
	{
		get
		{
			return cooperateUniqueSkillLevel_;
		}
		set
		{
			cooperateUniqueSkillLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> VHLSkillID => vHLSkillID_;

	[DebuggerNonUserCode]
	public int VHLResult
	{
		get
		{
			return vHLResult_;
		}
		set
		{
			vHLResult_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RoleDataForExchangeInfo MasterSkill
	{
		get
		{
			return masterSkill_;
		}
		set
		{
			masterSkill_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SceneDataForExcehangeInfo()
	{
	}

	[DebuggerNonUserCode]
	public SceneDataForExcehangeInfo(SceneDataForExcehangeInfo other)
		: this()
	{
		mSceneID_ = other.mSceneID_;
		mMissionClearTimes_ = other.mMissionClearTimes_;
		typeIDListAffix_ = other.typeIDListAffix_.Clone();
		levelList_ = other.levelList_.Clone();
		enemyTypes_ = other.enemyTypes_.Clone();
		roleDataInLua_ = other.roleDataInLua_.Clone();
		challengeFactor_ = other.challengeFactor_;
		adaptiveEnemyLevel_ = other.adaptiveEnemyLevel_;
		difficulty_ = other.difficulty_;
		needResurrect_ = other.needResurrect_;
		coinNumber_ = other.coinNumber_;
		coinConsume_ = other.coinConsume_;
		cooperateUniqueSkillID_ = other.cooperateUniqueSkillID_;
		attributeFactorX_ = other.attributeFactorX_;
		attributeFactorY_ = other.attributeFactorY_;
		attributeFactorZ_ = other.attributeFactorZ_;
		indexOfMaxCountRace_ = other.indexOfMaxCountRace_;
		numOfMaxCountRace_ = other.numOfMaxCountRace_;
		leftTime_ = other.leftTime_;
		targetEnemyID_ = other.targetEnemyID_;
		resurrectHP_ = other.resurrectHP_;
		cooperateUniqueSkillLevel_ = other.cooperateUniqueSkillLevel_;
		vHLSkillID_ = other.vHLSkillID_.Clone();
		vHLResult_ = other.vHLResult_;
		MasterSkill = ((other.masterSkill_ != null) ? other.MasterSkill.Clone() : null);
	}

	[DebuggerNonUserCode]
	public SceneDataForExcehangeInfo Clone()
	{
		return new SceneDataForExcehangeInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SceneDataForExcehangeInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(SceneDataForExcehangeInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (MSceneID != other.MSceneID)
		{
			return false;
		}
		if (MMissionClearTimes != other.MMissionClearTimes)
		{
			return false;
		}
		if (!typeIDListAffix_.Equals(other.typeIDListAffix_))
		{
			return false;
		}
		if (!levelList_.Equals(other.levelList_))
		{
			return false;
		}
		if (!enemyTypes_.Equals(other.enemyTypes_))
		{
			return false;
		}
		if (!roleDataInLua_.Equals(other.roleDataInLua_))
		{
			return false;
		}
		if (ChallengeFactor != other.ChallengeFactor)
		{
			return false;
		}
		if (AdaptiveEnemyLevel != other.AdaptiveEnemyLevel)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (NeedResurrect != other.NeedResurrect)
		{
			return false;
		}
		if (CoinNumber != other.CoinNumber)
		{
			return false;
		}
		if (CoinConsume != other.CoinConsume)
		{
			return false;
		}
		if (CooperateUniqueSkillID != other.CooperateUniqueSkillID)
		{
			return false;
		}
		if (AttributeFactorX != other.AttributeFactorX)
		{
			return false;
		}
		if (AttributeFactorY != other.AttributeFactorY)
		{
			return false;
		}
		if (AttributeFactorZ != other.AttributeFactorZ)
		{
			return false;
		}
		if (IndexOfMaxCountRace != other.IndexOfMaxCountRace)
		{
			return false;
		}
		if (NumOfMaxCountRace != other.NumOfMaxCountRace)
		{
			return false;
		}
		if (LeftTime != other.LeftTime)
		{
			return false;
		}
		if (TargetEnemyID != other.TargetEnemyID)
		{
			return false;
		}
		if (ResurrectHP != other.ResurrectHP)
		{
			return false;
		}
		if (CooperateUniqueSkillLevel != other.CooperateUniqueSkillLevel)
		{
			return false;
		}
		if (!vHLSkillID_.Equals(other.vHLSkillID_))
		{
			return false;
		}
		if (VHLResult != other.VHLResult)
		{
			return false;
		}
		if (!object.Equals(MasterSkill, other.MasterSkill))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (MSceneID != 0)
		{
			num ^= MSceneID.GetHashCode();
		}
		if (MMissionClearTimes != 0)
		{
			num ^= MMissionClearTimes.GetHashCode();
		}
		num ^= typeIDListAffix_.GetHashCode();
		num ^= levelList_.GetHashCode();
		num ^= enemyTypes_.GetHashCode();
		num ^= roleDataInLua_.GetHashCode();
		if (ChallengeFactor != 0)
		{
			num ^= ChallengeFactor.GetHashCode();
		}
		if (AdaptiveEnemyLevel != 0)
		{
			num ^= AdaptiveEnemyLevel.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (NeedResurrect)
		{
			num ^= NeedResurrect.GetHashCode();
		}
		if (CoinNumber != 0L)
		{
			num ^= CoinNumber.GetHashCode();
		}
		if (CoinConsume != 0L)
		{
			num ^= CoinConsume.GetHashCode();
		}
		if (CooperateUniqueSkillID != 0)
		{
			num ^= CooperateUniqueSkillID.GetHashCode();
		}
		if (AttributeFactorX != 0)
		{
			num ^= AttributeFactorX.GetHashCode();
		}
		if (AttributeFactorY != 0)
		{
			num ^= AttributeFactorY.GetHashCode();
		}
		if (AttributeFactorZ != 0)
		{
			num ^= AttributeFactorZ.GetHashCode();
		}
		if (IndexOfMaxCountRace != 0)
		{
			num ^= IndexOfMaxCountRace.GetHashCode();
		}
		if (NumOfMaxCountRace != 0)
		{
			num ^= NumOfMaxCountRace.GetHashCode();
		}
		if (LeftTime != 0)
		{
			num ^= LeftTime.GetHashCode();
		}
		if (TargetEnemyID != 0)
		{
			num ^= TargetEnemyID.GetHashCode();
		}
		if (ResurrectHP != 0)
		{
			num ^= ResurrectHP.GetHashCode();
		}
		if (CooperateUniqueSkillLevel != 0)
		{
			num ^= CooperateUniqueSkillLevel.GetHashCode();
		}
		num ^= vHLSkillID_.GetHashCode();
		if (VHLResult != 0)
		{
			num ^= VHLResult.GetHashCode();
		}
		if (masterSkill_ != null)
		{
			num ^= MasterSkill.GetHashCode();
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
		if (MSceneID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(MSceneID);
		}
		if (MMissionClearTimes != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MMissionClearTimes);
		}
		typeIDListAffix_.WriteTo(output, _repeated_typeIDListAffix_codec);
		levelList_.WriteTo(output, _repeated_levelList_codec);
		enemyTypes_.WriteTo(output, _repeated_enemyTypes_codec);
		roleDataInLua_.WriteTo(output, _repeated_roleDataInLua_codec);
		if (ChallengeFactor != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ChallengeFactor);
		}
		if (AdaptiveEnemyLevel != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AdaptiveEnemyLevel);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Difficulty);
		}
		if (NeedResurrect)
		{
			output.WriteRawTag(80);
			output.WriteBool(NeedResurrect);
		}
		if (CoinNumber != 0L)
		{
			output.WriteRawTag(88);
			output.WriteInt64(CoinNumber);
		}
		if (CoinConsume != 0L)
		{
			output.WriteRawTag(96);
			output.WriteInt64(CoinConsume);
		}
		if (CooperateUniqueSkillID != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(CooperateUniqueSkillID);
		}
		if (AttributeFactorX != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(AttributeFactorX);
		}
		if (AttributeFactorY != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(AttributeFactorY);
		}
		if (AttributeFactorZ != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(AttributeFactorZ);
		}
		if (IndexOfMaxCountRace != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(IndexOfMaxCountRace);
		}
		if (NumOfMaxCountRace != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(NumOfMaxCountRace);
		}
		if (LeftTime != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(LeftTime);
		}
		if (TargetEnemyID != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(TargetEnemyID);
		}
		if (ResurrectHP != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(ResurrectHP);
		}
		if (CooperateUniqueSkillLevel != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(CooperateUniqueSkillLevel);
		}
		vHLSkillID_.WriteTo(output, _repeated_vHLSkillID_codec);
		if (VHLResult != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(VHLResult);
		}
		if (masterSkill_ != null)
		{
			output.WriteRawTag(202, 1);
			output.WriteMessage(MasterSkill);
		}
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (MSceneID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MSceneID);
		}
		if (MMissionClearTimes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MMissionClearTimes);
		}
		num += typeIDListAffix_.CalculateSize(_repeated_typeIDListAffix_codec);
		num += levelList_.CalculateSize(_repeated_levelList_codec);
		num += enemyTypes_.CalculateSize(_repeated_enemyTypes_codec);
		num += roleDataInLua_.CalculateSize(_repeated_roleDataInLua_codec);
		if (ChallengeFactor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChallengeFactor);
		}
		if (AdaptiveEnemyLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AdaptiveEnemyLevel);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (NeedResurrect)
		{
			num += 2;
		}
		if (CoinNumber != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(CoinNumber);
		}
		if (CoinConsume != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(CoinConsume);
		}
		if (CooperateUniqueSkillID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CooperateUniqueSkillID);
		}
		if (AttributeFactorX != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttributeFactorX);
		}
		if (AttributeFactorY != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AttributeFactorY);
		}
		if (AttributeFactorZ != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AttributeFactorZ);
		}
		if (IndexOfMaxCountRace != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(IndexOfMaxCountRace);
		}
		if (NumOfMaxCountRace != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NumOfMaxCountRace);
		}
		if (LeftTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LeftTime);
		}
		if (TargetEnemyID != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TargetEnemyID);
		}
		if (ResurrectHP != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ResurrectHP);
		}
		if (CooperateUniqueSkillLevel != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CooperateUniqueSkillLevel);
		}
		num += vHLSkillID_.CalculateSize(_repeated_vHLSkillID_codec);
		if (VHLResult != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(VHLResult);
		}
		if (masterSkill_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(MasterSkill);
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SceneDataForExcehangeInfo other)
	{
		if (other == null)
		{
			return;
		}
		if (other.MSceneID != 0)
		{
			MSceneID = other.MSceneID;
		}
		if (other.MMissionClearTimes != 0)
		{
			MMissionClearTimes = other.MMissionClearTimes;
		}
		typeIDListAffix_.Add(other.typeIDListAffix_);
		levelList_.Add(other.levelList_);
		enemyTypes_.Add(other.enemyTypes_);
		roleDataInLua_.Add(other.roleDataInLua_);
		if (other.ChallengeFactor != 0)
		{
			ChallengeFactor = other.ChallengeFactor;
		}
		if (other.AdaptiveEnemyLevel != 0)
		{
			AdaptiveEnemyLevel = other.AdaptiveEnemyLevel;
		}
		if (other.Difficulty != 0)
		{
			Difficulty = other.Difficulty;
		}
		if (other.NeedResurrect)
		{
			NeedResurrect = other.NeedResurrect;
		}
		if (other.CoinNumber != 0L)
		{
			CoinNumber = other.CoinNumber;
		}
		if (other.CoinConsume != 0L)
		{
			CoinConsume = other.CoinConsume;
		}
		if (other.CooperateUniqueSkillID != 0)
		{
			CooperateUniqueSkillID = other.CooperateUniqueSkillID;
		}
		if (other.AttributeFactorX != 0)
		{
			AttributeFactorX = other.AttributeFactorX;
		}
		if (other.AttributeFactorY != 0)
		{
			AttributeFactorY = other.AttributeFactorY;
		}
		if (other.AttributeFactorZ != 0)
		{
			AttributeFactorZ = other.AttributeFactorZ;
		}
		if (other.IndexOfMaxCountRace != 0)
		{
			IndexOfMaxCountRace = other.IndexOfMaxCountRace;
		}
		if (other.NumOfMaxCountRace != 0)
		{
			NumOfMaxCountRace = other.NumOfMaxCountRace;
		}
		if (other.LeftTime != 0)
		{
			LeftTime = other.LeftTime;
		}
		if (other.TargetEnemyID != 0)
		{
			TargetEnemyID = other.TargetEnemyID;
		}
		if (other.ResurrectHP != 0)
		{
			ResurrectHP = other.ResurrectHP;
		}
		if (other.CooperateUniqueSkillLevel != 0)
		{
			CooperateUniqueSkillLevel = other.CooperateUniqueSkillLevel;
		}
		vHLSkillID_.Add(other.vHLSkillID_);
		if (other.VHLResult != 0)
		{
			VHLResult = other.VHLResult;
		}
		if (other.masterSkill_ != null)
		{
			if (masterSkill_ == null)
			{
				masterSkill_ = new RoleDataForExchangeInfo();
			}
			MasterSkill.MergeFrom(other.MasterSkill);
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
				MSceneID = input.ReadInt32();
				break;
			case 16u:
				MMissionClearTimes = input.ReadInt32();
				break;
			case 24u:
			case 26u:
				typeIDListAffix_.AddEntriesFrom(input, _repeated_typeIDListAffix_codec);
				break;
			case 32u:
			case 34u:
				levelList_.AddEntriesFrom(input, _repeated_levelList_codec);
				break;
			case 40u:
			case 42u:
				enemyTypes_.AddEntriesFrom(input, _repeated_enemyTypes_codec);
				break;
			case 50u:
				roleDataInLua_.AddEntriesFrom(input, _repeated_roleDataInLua_codec);
				break;
			case 56u:
				ChallengeFactor = input.ReadInt32();
				break;
			case 64u:
				AdaptiveEnemyLevel = input.ReadInt32();
				break;
			case 72u:
				Difficulty = input.ReadInt32();
				break;
			case 80u:
				NeedResurrect = input.ReadBool();
				break;
			case 88u:
				CoinNumber = input.ReadInt64();
				break;
			case 96u:
				CoinConsume = input.ReadInt64();
				break;
			case 104u:
				CooperateUniqueSkillID = input.ReadInt32();
				break;
			case 112u:
				AttributeFactorX = input.ReadInt32();
				break;
			case 120u:
				AttributeFactorY = input.ReadInt32();
				break;
			case 128u:
				AttributeFactorZ = input.ReadInt32();
				break;
			case 136u:
				IndexOfMaxCountRace = input.ReadInt32();
				break;
			case 144u:
				NumOfMaxCountRace = input.ReadInt32();
				break;
			case 152u:
				LeftTime = input.ReadInt32();
				break;
			case 160u:
				TargetEnemyID = input.ReadInt32();
				break;
			case 168u:
				ResurrectHP = input.ReadInt32();
				break;
			case 176u:
				CooperateUniqueSkillLevel = input.ReadInt32();
				break;
			case 184u:
			case 186u:
				vHLSkillID_.AddEntriesFrom(input, _repeated_vHLSkillID_codec);
				break;
			case 192u:
				VHLResult = input.ReadInt32();
				break;
			case 202u:
				if (masterSkill_ == null)
				{
					masterSkill_ = new RoleDataForExchangeInfo();
				}
				input.ReadMessage(masterSkill_);
				break;
			}
		}
	}
}
