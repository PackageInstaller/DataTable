using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class Raid : IMessage<Raid>, IMessage, IEquatable<Raid>, IDeepCloneable<Raid>, IBufferMessage
{
	private static readonly MessageParser<Raid> _parser = new MessageParser<Raid>(() => new Raid());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CleanNumFieldNumber = 3;

	private int cleanNum_;

	public const int RateFieldNumber = 4;

	private int rate_;

	public const int EntryWorldIdFieldNumber = 6;

	private int entryWorldId_;

	public const int EnterTsFieldNumber = 7;

	private int enterTs_;

	public const int InstIdFieldNumber = 9;

	private long instId_;

	public const int TakeRewardCountFieldNumber = 10;

	private int takeRewardCount_;

	public const int PlayerDeathCountFieldNumber = 12;

	private int playerDeathCount_;

	public const int MaximumScoreFieldNumber = 13;

	private int maximumScore_;

	public const int BoosRaidFieldNumber = 14;

	private BossRaid boosRaid_;

	public const int FirstRewardDoneFieldNumber = 15;

	private bool firstRewardDone_;

	public const int FastestClearTimeFieldNumber = 17;

	private int fastestClearTime_;

	public const int StateFieldNumber = 18;

	private StageStateEnum state_;

	public const int TargetFieldNumber = 21;

	private StageChallengeTarget target_;

	public const int EnterByGMFieldNumber = 22;

	private bool enterByGM_;

	public long raidStartStamp;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<Raid> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[207];

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
	public int CleanNum
	{
		get
		{
			return cleanNum_;
		}
		set
		{
			cleanNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Rate
	{
		get
		{
			return rate_;
		}
		set
		{
			rate_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EntryWorldId
	{
		get
		{
			return entryWorldId_;
		}
		set
		{
			entryWorldId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int EnterTs
	{
		get
		{
			return enterTs_;
		}
		set
		{
			enterTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long InstId
	{
		get
		{
			return instId_;
		}
		set
		{
			instId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TakeRewardCount
	{
		get
		{
			return takeRewardCount_;
		}
		set
		{
			takeRewardCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PlayerDeathCount
	{
		get
		{
			return playerDeathCount_;
		}
		set
		{
			playerDeathCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int MaximumScore
	{
		get
		{
			return maximumScore_;
		}
		set
		{
			maximumScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BossRaid BoosRaid
	{
		get
		{
			return boosRaid_;
		}
		set
		{
			boosRaid_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool FirstRewardDone
	{
		get
		{
			return firstRewardDone_;
		}
		set
		{
			firstRewardDone_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int FastestClearTime
	{
		get
		{
			return fastestClearTime_;
		}
		set
		{
			fastestClearTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageStateEnum State
	{
		get
		{
			return state_;
		}
		set
		{
			state_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageChallengeTarget Target
	{
		get
		{
			return target_;
		}
		set
		{
			target_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool EnterByGM
	{
		get
		{
			return enterByGM_;
		}
		set
		{
			enterByGM_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raid()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raid(Raid other)
		: this()
	{
		id_ = other.id_;
		cleanNum_ = other.cleanNum_;
		rate_ = other.rate_;
		entryWorldId_ = other.entryWorldId_;
		enterTs_ = other.enterTs_;
		instId_ = other.instId_;
		takeRewardCount_ = other.takeRewardCount_;
		playerDeathCount_ = other.playerDeathCount_;
		maximumScore_ = other.maximumScore_;
		boosRaid_ = ((other.boosRaid_ != null) ? other.boosRaid_.Clone() : null);
		firstRewardDone_ = other.firstRewardDone_;
		fastestClearTime_ = other.fastestClearTime_;
		state_ = other.state_;
		target_ = ((other.target_ != null) ? other.target_.Clone() : null);
		enterByGM_ = other.enterByGM_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public Raid Clone()
	{
		return new Raid(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as Raid);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(Raid other)
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
		if (CleanNum != other.CleanNum)
		{
			return false;
		}
		if (Rate != other.Rate)
		{
			return false;
		}
		if (EntryWorldId != other.EntryWorldId)
		{
			return false;
		}
		if (EnterTs != other.EnterTs)
		{
			return false;
		}
		if (InstId != other.InstId)
		{
			return false;
		}
		if (TakeRewardCount != other.TakeRewardCount)
		{
			return false;
		}
		if (PlayerDeathCount != other.PlayerDeathCount)
		{
			return false;
		}
		if (MaximumScore != other.MaximumScore)
		{
			return false;
		}
		if (!object.Equals(BoosRaid, other.BoosRaid))
		{
			return false;
		}
		if (FirstRewardDone != other.FirstRewardDone)
		{
			return false;
		}
		if (FastestClearTime != other.FastestClearTime)
		{
			return false;
		}
		if (State != other.State)
		{
			return false;
		}
		if (!object.Equals(Target, other.Target))
		{
			return false;
		}
		if (EnterByGM != other.EnterByGM)
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
		if (CleanNum != 0)
		{
			num ^= CleanNum.GetHashCode();
		}
		if (Rate != 0)
		{
			num ^= Rate.GetHashCode();
		}
		if (EntryWorldId != 0)
		{
			num ^= EntryWorldId.GetHashCode();
		}
		if (EnterTs != 0)
		{
			num ^= EnterTs.GetHashCode();
		}
		if (InstId != 0L)
		{
			num ^= InstId.GetHashCode();
		}
		if (TakeRewardCount != 0)
		{
			num ^= TakeRewardCount.GetHashCode();
		}
		if (PlayerDeathCount != 0)
		{
			num ^= PlayerDeathCount.GetHashCode();
		}
		if (MaximumScore != 0)
		{
			num ^= MaximumScore.GetHashCode();
		}
		if (boosRaid_ != null)
		{
			num ^= BoosRaid.GetHashCode();
		}
		if (FirstRewardDone)
		{
			num ^= FirstRewardDone.GetHashCode();
		}
		if (FastestClearTime != 0)
		{
			num ^= FastestClearTime.GetHashCode();
		}
		if (State != StageStateEnum.StageStateOut)
		{
			num ^= State.GetHashCode();
		}
		if (target_ != null)
		{
			num ^= Target.GetHashCode();
		}
		if (EnterByGM)
		{
			num ^= EnterByGM.GetHashCode();
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
		if (CleanNum != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CleanNum);
		}
		if (Rate != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Rate);
		}
		if (EntryWorldId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(EntryWorldId);
		}
		if (EnterTs != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(EnterTs);
		}
		if (InstId != 0L)
		{
			output.WriteRawTag(72);
			output.WriteInt64(InstId);
		}
		if (TakeRewardCount != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(TakeRewardCount);
		}
		if (PlayerDeathCount != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(PlayerDeathCount);
		}
		if (MaximumScore != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(MaximumScore);
		}
		if (boosRaid_ != null)
		{
			output.WriteRawTag(114);
			output.WriteMessage(BoosRaid);
		}
		if (FirstRewardDone)
		{
			output.WriteRawTag(120);
			output.WriteBool(FirstRewardDone);
		}
		if (FastestClearTime != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(FastestClearTime);
		}
		if (State != StageStateEnum.StageStateOut)
		{
			output.WriteRawTag(144, 1);
			output.WriteEnum((int)State);
		}
		if (target_ != null)
		{
			output.WriteRawTag(170, 1);
			output.WriteMessage(Target);
		}
		if (EnterByGM)
		{
			output.WriteRawTag(176, 1);
			output.WriteBool(EnterByGM);
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
		if (CleanNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CleanNum);
		}
		if (Rate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Rate);
		}
		if (EntryWorldId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EntryWorldId);
		}
		if (EnterTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnterTs);
		}
		if (InstId != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(InstId);
		}
		if (TakeRewardCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TakeRewardCount);
		}
		if (PlayerDeathCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlayerDeathCount);
		}
		if (MaximumScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaximumScore);
		}
		if (boosRaid_ != null)
		{
			num += 1 + CodedOutputStream.ComputeMessageSize(BoosRaid);
		}
		if (FirstRewardDone)
		{
			num += 2;
		}
		if (FastestClearTime != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FastestClearTime);
		}
		if (State != StageStateEnum.StageStateOut)
		{
			num += 2 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		if (target_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Target);
		}
		if (EnterByGM)
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
	[GeneratedCode("protoc", null)]
	public void MergeFrom(Raid other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Id != 0)
		{
			Id = other.Id;
		}
		if (other.CleanNum != 0)
		{
			CleanNum = other.CleanNum;
		}
		if (other.Rate != 0)
		{
			Rate = other.Rate;
		}
		if (other.EntryWorldId != 0)
		{
			EntryWorldId = other.EntryWorldId;
		}
		if (other.EnterTs != 0)
		{
			EnterTs = other.EnterTs;
		}
		if (other.InstId != 0L)
		{
			InstId = other.InstId;
		}
		if (other.TakeRewardCount != 0)
		{
			TakeRewardCount = other.TakeRewardCount;
		}
		if (other.PlayerDeathCount != 0)
		{
			PlayerDeathCount = other.PlayerDeathCount;
		}
		if (other.MaximumScore != 0)
		{
			MaximumScore = other.MaximumScore;
		}
		if (other.boosRaid_ != null)
		{
			if (boosRaid_ == null)
			{
				BoosRaid = new BossRaid();
			}
			BoosRaid.MergeFrom(other.BoosRaid);
		}
		if (other.FirstRewardDone)
		{
			FirstRewardDone = other.FirstRewardDone;
		}
		if (other.FastestClearTime != 0)
		{
			FastestClearTime = other.FastestClearTime;
		}
		if (other.State != StageStateEnum.StageStateOut)
		{
			State = other.State;
		}
		if (other.target_ != null)
		{
			if (target_ == null)
			{
				Target = new StageChallengeTarget();
			}
			Target.MergeFrom(other.Target);
		}
		if (other.EnterByGM)
		{
			EnterByGM = other.EnterByGM;
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
			case 24u:
				CleanNum = input.ReadInt32();
				break;
			case 32u:
				Rate = input.ReadInt32();
				break;
			case 48u:
				EntryWorldId = input.ReadInt32();
				break;
			case 56u:
				EnterTs = input.ReadInt32();
				break;
			case 72u:
				InstId = input.ReadInt64();
				break;
			case 80u:
				TakeRewardCount = input.ReadInt32();
				break;
			case 96u:
				PlayerDeathCount = input.ReadInt32();
				break;
			case 104u:
				MaximumScore = input.ReadInt32();
				break;
			case 114u:
				if (boosRaid_ == null)
				{
					BoosRaid = new BossRaid();
				}
				input.ReadMessage(BoosRaid);
				break;
			case 120u:
				FirstRewardDone = input.ReadBool();
				break;
			case 136u:
				FastestClearTime = input.ReadInt32();
				break;
			case 144u:
				State = (StageStateEnum)input.ReadEnum();
				break;
			case 170u:
				if (target_ == null)
				{
					Target = new StageChallengeTarget();
				}
				input.ReadMessage(Target);
				break;
			case 176u:
				EnterByGM = input.ReadBool();
				break;
			}
		}
	}
}
