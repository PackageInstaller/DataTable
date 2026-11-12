using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class JointDrillLevel : IMessage<JointDrillLevel>, IMessage, IEquatable<JointDrillLevel>, IDeepCloneable<JointDrillLevel>
{
	private static readonly MessageParser<JointDrillLevel> _parser = new MessageParser<JointDrillLevel>(() => new JointDrillLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DifficultyFieldNumber = 2;

	private int difficulty_;

	public const int DrillLevelGroupIdFieldNumber = 3;

	private int drillLevelGroupId_;

	public const int PreLevelIdFieldNumber = 4;

	private int preLevelId_;

	public const int MaxBattleNumFieldNumber = 5;

	private int maxBattleNum_;

	public const int FloorIdFieldNumber = 6;

	private int floorId_;

	public const int BattleTimeFieldNumber = 7;

	private int battleTime_;

	public const int HpBarNumFieldNumber = 8;

	private int hpBarNum_;

	public const int BossIdFieldNumber = 9;

	private int bossId_;

	public const int FirstRRDropIdFieldNumber = 10;

	private int firstRRDropId_;

	public const int RewardPreviewFieldNumber = 11;

	private string rewardPreview_ = "";

	public const int TimeScoreFieldNumber = 12;

	private int timeScore_;

	public const int ScorePerSecFieldNumber = 13;

	private int scorePerSec_;

	public const int LevelScoreFieldNumber = 14;

	private int levelScore_;

	public const int BaseHpScoreFieldNumber = 15;

	private int baseHpScore_;

	public const int LevelImageFieldNumber = 16;

	private string levelImage_ = "";

	public const int LevelImageGoingFieldNumber = 17;

	private string levelImageGoing_ = "";

	public const int BossAffixFieldNumber = 18;

	private static readonly FieldCodec<int> _repeated_bossAffix_codec = FieldCodec.ForInt32(146u);

	private readonly RepeatedField<int> bossAffix_ = new RepeatedField<int>();

	public const int RecommendBuildRankFieldNumber = 19;

	private int recommendBuildRank_;

	public const int RecommendLvFieldNumber = 20;

	private int recommendLv_;

	public const int SubNameFieldNumber = 21;

	private string subName_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<JointDrillLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(478);

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
	public int DrillLevelGroupId
	{
		get
		{
			return drillLevelGroupId_;
		}
		set
		{
			drillLevelGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelId
	{
		get
		{
			return preLevelId_;
		}
		set
		{
			preLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxBattleNum
	{
		get
		{
			return maxBattleNum_;
		}
		set
		{
			maxBattleNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleTime
	{
		get
		{
			return battleTime_;
		}
		set
		{
			battleTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HpBarNum
	{
		get
		{
			return hpBarNum_;
		}
		set
		{
			hpBarNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BossId
	{
		get
		{
			return bossId_;
		}
		set
		{
			bossId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstRRDropId
	{
		get
		{
			return firstRRDropId_;
		}
		set
		{
			firstRRDropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardPreview
	{
		get
		{
			return rewardPreview_;
		}
		set
		{
			rewardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TimeScore
	{
		get
		{
			return timeScore_;
		}
		set
		{
			timeScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ScorePerSec
	{
		get
		{
			return scorePerSec_;
		}
		set
		{
			scorePerSec_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelScore
	{
		get
		{
			return levelScore_;
		}
		set
		{
			levelScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BaseHpScore
	{
		get
		{
			return baseHpScore_;
		}
		set
		{
			baseHpScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string LevelImage
	{
		get
		{
			return levelImage_;
		}
		set
		{
			levelImage_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LevelImageGoing
	{
		get
		{
			return levelImageGoing_;
		}
		set
		{
			levelImageGoing_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BossAffix => bossAffix_;

	[DebuggerNonUserCode]
	public int RecommendBuildRank
	{
		get
		{
			return recommendBuildRank_;
		}
		set
		{
			recommendBuildRank_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecommendLv
	{
		get
		{
			return recommendLv_;
		}
		set
		{
			recommendLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SubName
	{
		get
		{
			return subName_;
		}
		set
		{
			subName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public JointDrillLevel()
	{
	}

	[DebuggerNonUserCode]
	public JointDrillLevel(JointDrillLevel other)
		: this()
	{
		id_ = other.id_;
		difficulty_ = other.difficulty_;
		drillLevelGroupId_ = other.drillLevelGroupId_;
		preLevelId_ = other.preLevelId_;
		maxBattleNum_ = other.maxBattleNum_;
		floorId_ = other.floorId_;
		battleTime_ = other.battleTime_;
		hpBarNum_ = other.hpBarNum_;
		bossId_ = other.bossId_;
		firstRRDropId_ = other.firstRRDropId_;
		rewardPreview_ = other.rewardPreview_;
		timeScore_ = other.timeScore_;
		scorePerSec_ = other.scorePerSec_;
		levelScore_ = other.levelScore_;
		baseHpScore_ = other.baseHpScore_;
		levelImage_ = other.levelImage_;
		levelImageGoing_ = other.levelImageGoing_;
		bossAffix_ = other.bossAffix_.Clone();
		recommendBuildRank_ = other.recommendBuildRank_;
		recommendLv_ = other.recommendLv_;
		subName_ = other.subName_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public JointDrillLevel Clone()
	{
		return new JointDrillLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as JointDrillLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(JointDrillLevel other)
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
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (DrillLevelGroupId != other.DrillLevelGroupId)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (MaxBattleNum != other.MaxBattleNum)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (BattleTime != other.BattleTime)
		{
			return false;
		}
		if (HpBarNum != other.HpBarNum)
		{
			return false;
		}
		if (BossId != other.BossId)
		{
			return false;
		}
		if (FirstRRDropId != other.FirstRRDropId)
		{
			return false;
		}
		if (RewardPreview != other.RewardPreview)
		{
			return false;
		}
		if (TimeScore != other.TimeScore)
		{
			return false;
		}
		if (ScorePerSec != other.ScorePerSec)
		{
			return false;
		}
		if (LevelScore != other.LevelScore)
		{
			return false;
		}
		if (BaseHpScore != other.BaseHpScore)
		{
			return false;
		}
		if (LevelImage != other.LevelImage)
		{
			return false;
		}
		if (LevelImageGoing != other.LevelImageGoing)
		{
			return false;
		}
		if (!bossAffix_.Equals(other.bossAffix_))
		{
			return false;
		}
		if (RecommendBuildRank != other.RecommendBuildRank)
		{
			return false;
		}
		if (RecommendLv != other.RecommendLv)
		{
			return false;
		}
		if (SubName != other.SubName)
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
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (DrillLevelGroupId != 0)
		{
			num ^= DrillLevelGroupId.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (MaxBattleNum != 0)
		{
			num ^= MaxBattleNum.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (BattleTime != 0)
		{
			num ^= BattleTime.GetHashCode();
		}
		if (HpBarNum != 0)
		{
			num ^= HpBarNum.GetHashCode();
		}
		if (BossId != 0)
		{
			num ^= BossId.GetHashCode();
		}
		if (FirstRRDropId != 0)
		{
			num ^= FirstRRDropId.GetHashCode();
		}
		if (RewardPreview.Length != 0)
		{
			num ^= RewardPreview.GetHashCode();
		}
		if (TimeScore != 0)
		{
			num ^= TimeScore.GetHashCode();
		}
		if (ScorePerSec != 0)
		{
			num ^= ScorePerSec.GetHashCode();
		}
		if (LevelScore != 0)
		{
			num ^= LevelScore.GetHashCode();
		}
		if (BaseHpScore != 0)
		{
			num ^= BaseHpScore.GetHashCode();
		}
		if (LevelImage.Length != 0)
		{
			num ^= LevelImage.GetHashCode();
		}
		if (LevelImageGoing.Length != 0)
		{
			num ^= LevelImageGoing.GetHashCode();
		}
		num ^= bossAffix_.GetHashCode();
		if (RecommendBuildRank != 0)
		{
			num ^= RecommendBuildRank.GetHashCode();
		}
		if (RecommendLv != 0)
		{
			num ^= RecommendLv.GetHashCode();
		}
		if (SubName.Length != 0)
		{
			num ^= SubName.GetHashCode();
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
		if (Difficulty != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Difficulty);
		}
		if (DrillLevelGroupId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DrillLevelGroupId);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PreLevelId);
		}
		if (MaxBattleNum != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MaxBattleNum);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(FloorId);
		}
		if (BattleTime != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(BattleTime);
		}
		if (HpBarNum != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(HpBarNum);
		}
		if (BossId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(BossId);
		}
		if (FirstRRDropId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(FirstRRDropId);
		}
		if (RewardPreview.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(RewardPreview);
		}
		if (TimeScore != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(TimeScore);
		}
		if (ScorePerSec != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(ScorePerSec);
		}
		if (LevelScore != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(LevelScore);
		}
		if (BaseHpScore != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(BaseHpScore);
		}
		if (LevelImage.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(LevelImage);
		}
		if (LevelImageGoing.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(LevelImageGoing);
		}
		bossAffix_.WriteTo(output, _repeated_bossAffix_codec);
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(RecommendBuildRank);
		}
		if (RecommendLv != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(RecommendLv);
		}
		if (SubName.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(SubName);
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
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (DrillLevelGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DrillLevelGroupId);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (MaxBattleNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxBattleNum);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (BattleTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleTime);
		}
		if (HpBarNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HpBarNum);
		}
		if (BossId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossId);
		}
		if (FirstRRDropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstRRDropId);
		}
		if (RewardPreview.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardPreview);
		}
		if (TimeScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimeScore);
		}
		if (ScorePerSec != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScorePerSec);
		}
		if (LevelScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelScore);
		}
		if (BaseHpScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BaseHpScore);
		}
		if (LevelImage.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(LevelImage);
		}
		if (LevelImageGoing.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(LevelImageGoing);
		}
		num += bossAffix_.CalculateSize(_repeated_bossAffix_codec);
		if (RecommendBuildRank != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RecommendBuildRank);
		}
		if (RecommendLv != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RecommendLv);
		}
		if (SubName.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SubName);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(JointDrillLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.DrillLevelGroupId != 0)
			{
				DrillLevelGroupId = other.DrillLevelGroupId;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.MaxBattleNum != 0)
			{
				MaxBattleNum = other.MaxBattleNum;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.BattleTime != 0)
			{
				BattleTime = other.BattleTime;
			}
			if (other.HpBarNum != 0)
			{
				HpBarNum = other.HpBarNum;
			}
			if (other.BossId != 0)
			{
				BossId = other.BossId;
			}
			if (other.FirstRRDropId != 0)
			{
				FirstRRDropId = other.FirstRRDropId;
			}
			if (other.RewardPreview.Length != 0)
			{
				RewardPreview = other.RewardPreview;
			}
			if (other.TimeScore != 0)
			{
				TimeScore = other.TimeScore;
			}
			if (other.ScorePerSec != 0)
			{
				ScorePerSec = other.ScorePerSec;
			}
			if (other.LevelScore != 0)
			{
				LevelScore = other.LevelScore;
			}
			if (other.BaseHpScore != 0)
			{
				BaseHpScore = other.BaseHpScore;
			}
			if (other.LevelImage.Length != 0)
			{
				LevelImage = other.LevelImage;
			}
			if (other.LevelImageGoing.Length != 0)
			{
				LevelImageGoing = other.LevelImageGoing;
			}
			bossAffix_.Add(other.bossAffix_);
			if (other.RecommendBuildRank != 0)
			{
				RecommendBuildRank = other.RecommendBuildRank;
			}
			if (other.RecommendLv != 0)
			{
				RecommendLv = other.RecommendLv;
			}
			if (other.SubName.Length != 0)
			{
				SubName = other.SubName;
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
			case 16u:
				Difficulty = input.ReadInt32();
				break;
			case 24u:
				DrillLevelGroupId = input.ReadInt32();
				break;
			case 32u:
				PreLevelId = input.ReadInt32();
				break;
			case 40u:
				MaxBattleNum = input.ReadInt32();
				break;
			case 48u:
				FloorId = input.ReadInt32();
				break;
			case 56u:
				BattleTime = input.ReadInt32();
				break;
			case 64u:
				HpBarNum = input.ReadInt32();
				break;
			case 72u:
				BossId = input.ReadInt32();
				break;
			case 80u:
				FirstRRDropId = input.ReadInt32();
				break;
			case 90u:
				RewardPreview = input.ReadString();
				break;
			case 96u:
				TimeScore = input.ReadInt32();
				break;
			case 104u:
				ScorePerSec = input.ReadInt32();
				break;
			case 112u:
				LevelScore = input.ReadInt32();
				break;
			case 120u:
				BaseHpScore = input.ReadInt32();
				break;
			case 130u:
				LevelImage = input.ReadString();
				break;
			case 138u:
				LevelImageGoing = input.ReadString();
				break;
			case 144u:
			case 146u:
				bossAffix_.AddEntriesFrom(input, _repeated_bossAffix_codec);
				break;
			case 152u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 160u:
				RecommendLv = input.ReadInt32();
				break;
			case 170u:
				SubName = input.ReadString();
				break;
			}
		}
	}
}
