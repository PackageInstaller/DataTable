using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class AbyssStage : IMessage<AbyssStage>, IMessage, IEquatable<AbyssStage>, IDeepCloneable<AbyssStage>, IBufferMessage
{
	private static readonly MessageParser<AbyssStage> _parser = new MessageParser<AbyssStage>(() => new AbyssStage());

	private UnknownFieldSet _unknownFields;

	public const int IndexFieldNumber = 1;

	private int index_;

	public const int IsUnlockFieldNumber = 2;

	private bool isUnlock_;

	public const int TeamsFieldNumber = 3;

	private static readonly FieldCodec<AbyssTeamInfo> _repeated_teams_codec = FieldCodec.ForMessage(26u, AbyssTeamInfo.Parser);

	private readonly RepeatedField<AbyssTeamInfo> teams_ = new RepeatedField<AbyssTeamInfo>();

	public const int CompletedTargetsNumFieldNumber = 4;

	private int completedTargetsNum_;

	public const int CompletedNumFieldNumber = 5;

	private int completedNum_;

	public const int CurChallengeSubStageFieldNumber = 6;

	private int curChallengeSubStage_;

	public const int LatestUseSecondsFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_latestUseSeconds_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> latestUseSeconds_ = new RepeatedField<int>();

	public const int EntryWorldIdFieldNumber = 8;

	private int entryWorldId_;

	public const int EnterSubStageTsFieldNumber = 9;

	private int enterSubStageTs_;

	public const int SubStageRestartCountFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_subStageRestartCount_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> subStageRestartCount_ = new RepeatedField<int>();

	public const int StageRestartCountFieldNumber = 12;

	private int stageRestartCount_;

	public const int SubStageTransNoFieldNumber = 13;

	private static readonly FieldCodec<string> _repeated_subStageTransNo_codec = FieldCodec.ForString(106u);

	private readonly RepeatedField<string> subStageTransNo_ = new RepeatedField<string>();

	public const int EvaluationClaimStateFieldNumber = 14;

	private static readonly MapField<int, bool>.Codec _map_evaluationClaimState_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 114u);

	private readonly MapField<int, bool> evaluationClaimState_ = new MapField<int, bool>();

	public const int SubStageMinimumSecsFieldNumber = 15;

	private static readonly MapField<int, int>.Codec _map_subStageMinimumSecs_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 122u);

	private readonly MapField<int, int> subStageMinimumSecs_ = new MapField<int, int>();

	public const int StateFieldNumber = 16;

	private StageStateEnum state_;

	public const int SubStageBattleReportsFieldNumber = 17;

	private static readonly FieldCodec<AbyssBattleReport> _repeated_subStageBattleReports_codec = FieldCodec.ForMessage(138u, AbyssBattleReport.Parser);

	private readonly RepeatedField<AbyssBattleReport> subStageBattleReports_ = new RepeatedField<AbyssBattleReport>();

	public const int StageBattleReportFieldNumber = 18;

	private AbyssBattleReport stageBattleReport_;

	public const int StageMinimumSecsFieldNumber = 19;

	private int stageMinimumSecs_;

	public const int TargetFieldNumber = 20;

	private StageChallengeTarget target_;

	public const int AggregateSettleInfoFieldNumber = 21;

	private StageSettleInfo aggregateSettleInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<AbyssStage> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[135];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool IsUnlock
	{
		get
		{
			return isUnlock_;
		}
		set
		{
			isUnlock_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<AbyssTeamInfo> Teams => teams_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CompletedTargetsNum
	{
		get
		{
			return completedTargetsNum_;
		}
		set
		{
			completedTargetsNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CompletedNum
	{
		get
		{
			return completedNum_;
		}
		set
		{
			completedNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CurChallengeSubStage
	{
		get
		{
			return curChallengeSubStage_;
		}
		set
		{
			curChallengeSubStage_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> LatestUseSeconds => latestUseSeconds_;

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
	public int EnterSubStageTs
	{
		get
		{
			return enterSubStageTs_;
		}
		set
		{
			enterSubStageTs_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> SubStageRestartCount => subStageRestartCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StageRestartCount
	{
		get
		{
			return stageRestartCount_;
		}
		set
		{
			stageRestartCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<string> SubStageTransNo => subStageTransNo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> EvaluationClaimState => evaluationClaimState_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> SubStageMinimumSecs => subStageMinimumSecs_;

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
	public RepeatedField<AbyssBattleReport> SubStageBattleReports => subStageBattleReports_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssBattleReport StageBattleReport
	{
		get
		{
			return stageBattleReport_;
		}
		set
		{
			stageBattleReport_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int StageMinimumSecs
	{
		get
		{
			return stageMinimumSecs_;
		}
		set
		{
			stageMinimumSecs_ = value;
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
	public StageSettleInfo AggregateSettleInfo
	{
		get
		{
			return aggregateSettleInfo_;
		}
		set
		{
			aggregateSettleInfo_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssStage()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssStage(AbyssStage other)
		: this()
	{
		index_ = other.index_;
		isUnlock_ = other.isUnlock_;
		teams_ = other.teams_.Clone();
		completedTargetsNum_ = other.completedTargetsNum_;
		completedNum_ = other.completedNum_;
		curChallengeSubStage_ = other.curChallengeSubStage_;
		latestUseSeconds_ = other.latestUseSeconds_.Clone();
		entryWorldId_ = other.entryWorldId_;
		enterSubStageTs_ = other.enterSubStageTs_;
		subStageRestartCount_ = other.subStageRestartCount_.Clone();
		stageRestartCount_ = other.stageRestartCount_;
		subStageTransNo_ = other.subStageTransNo_.Clone();
		evaluationClaimState_ = other.evaluationClaimState_.Clone();
		subStageMinimumSecs_ = other.subStageMinimumSecs_.Clone();
		state_ = other.state_;
		subStageBattleReports_ = other.subStageBattleReports_.Clone();
		stageBattleReport_ = ((other.stageBattleReport_ != null) ? other.stageBattleReport_.Clone() : null);
		stageMinimumSecs_ = other.stageMinimumSecs_;
		target_ = ((other.target_ != null) ? other.target_.Clone() : null);
		aggregateSettleInfo_ = ((other.aggregateSettleInfo_ != null) ? other.aggregateSettleInfo_.Clone() : null);
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public AbyssStage Clone()
	{
		return new AbyssStage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as AbyssStage);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(AbyssStage other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (IsUnlock != other.IsUnlock)
		{
			return false;
		}
		if (!teams_.Equals(other.teams_))
		{
			return false;
		}
		if (CompletedTargetsNum != other.CompletedTargetsNum)
		{
			return false;
		}
		if (CompletedNum != other.CompletedNum)
		{
			return false;
		}
		if (CurChallengeSubStage != other.CurChallengeSubStage)
		{
			return false;
		}
		if (!latestUseSeconds_.Equals(other.latestUseSeconds_))
		{
			return false;
		}
		if (EntryWorldId != other.EntryWorldId)
		{
			return false;
		}
		if (EnterSubStageTs != other.EnterSubStageTs)
		{
			return false;
		}
		if (!subStageRestartCount_.Equals(other.subStageRestartCount_))
		{
			return false;
		}
		if (StageRestartCount != other.StageRestartCount)
		{
			return false;
		}
		if (!subStageTransNo_.Equals(other.subStageTransNo_))
		{
			return false;
		}
		if (!EvaluationClaimState.Equals(other.EvaluationClaimState))
		{
			return false;
		}
		if (!SubStageMinimumSecs.Equals(other.SubStageMinimumSecs))
		{
			return false;
		}
		if (State != other.State)
		{
			return false;
		}
		if (!subStageBattleReports_.Equals(other.subStageBattleReports_))
		{
			return false;
		}
		if (!object.Equals(StageBattleReport, other.StageBattleReport))
		{
			return false;
		}
		if (StageMinimumSecs != other.StageMinimumSecs)
		{
			return false;
		}
		if (!object.Equals(Target, other.Target))
		{
			return false;
		}
		if (!object.Equals(AggregateSettleInfo, other.AggregateSettleInfo))
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
		if (Index != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (IsUnlock)
		{
			num ^= IsUnlock.GetHashCode();
		}
		num ^= teams_.GetHashCode();
		if (CompletedTargetsNum != 0)
		{
			num ^= CompletedTargetsNum.GetHashCode();
		}
		if (CompletedNum != 0)
		{
			num ^= CompletedNum.GetHashCode();
		}
		if (CurChallengeSubStage != 0)
		{
			num ^= CurChallengeSubStage.GetHashCode();
		}
		num ^= latestUseSeconds_.GetHashCode();
		if (EntryWorldId != 0)
		{
			num ^= EntryWorldId.GetHashCode();
		}
		if (EnterSubStageTs != 0)
		{
			num ^= EnterSubStageTs.GetHashCode();
		}
		num ^= subStageRestartCount_.GetHashCode();
		if (StageRestartCount != 0)
		{
			num ^= StageRestartCount.GetHashCode();
		}
		num ^= subStageTransNo_.GetHashCode();
		num ^= EvaluationClaimState.GetHashCode();
		num ^= SubStageMinimumSecs.GetHashCode();
		if (State != StageStateEnum.StageStateOut)
		{
			num ^= State.GetHashCode();
		}
		num ^= subStageBattleReports_.GetHashCode();
		if (stageBattleReport_ != null)
		{
			num ^= StageBattleReport.GetHashCode();
		}
		if (StageMinimumSecs != 0)
		{
			num ^= StageMinimumSecs.GetHashCode();
		}
		if (target_ != null)
		{
			num ^= Target.GetHashCode();
		}
		if (aggregateSettleInfo_ != null)
		{
			num ^= AggregateSettleInfo.GetHashCode();
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
		if (Index != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Index);
		}
		if (IsUnlock)
		{
			output.WriteRawTag(16);
			output.WriteBool(IsUnlock);
		}
		teams_.WriteTo(ref output, _repeated_teams_codec);
		if (CompletedTargetsNum != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CompletedTargetsNum);
		}
		if (CompletedNum != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(CompletedNum);
		}
		if (CurChallengeSubStage != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(CurChallengeSubStage);
		}
		latestUseSeconds_.WriteTo(ref output, _repeated_latestUseSeconds_codec);
		if (EntryWorldId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(EntryWorldId);
		}
		if (EnterSubStageTs != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(EnterSubStageTs);
		}
		subStageRestartCount_.WriteTo(ref output, _repeated_subStageRestartCount_codec);
		if (StageRestartCount != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(StageRestartCount);
		}
		subStageTransNo_.WriteTo(ref output, _repeated_subStageTransNo_codec);
		evaluationClaimState_.WriteTo(ref output, _map_evaluationClaimState_codec);
		subStageMinimumSecs_.WriteTo(ref output, _map_subStageMinimumSecs_codec);
		if (State != StageStateEnum.StageStateOut)
		{
			output.WriteRawTag(128, 1);
			output.WriteEnum((int)State);
		}
		subStageBattleReports_.WriteTo(ref output, _repeated_subStageBattleReports_codec);
		if (stageBattleReport_ != null)
		{
			output.WriteRawTag(146, 1);
			output.WriteMessage(StageBattleReport);
		}
		if (StageMinimumSecs != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(StageMinimumSecs);
		}
		if (target_ != null)
		{
			output.WriteRawTag(162, 1);
			output.WriteMessage(Target);
		}
		if (aggregateSettleInfo_ != null)
		{
			output.WriteRawTag(170, 1);
			output.WriteMessage(AggregateSettleInfo);
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
		if (Index != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Index);
		}
		if (IsUnlock)
		{
			num += 2;
		}
		num += teams_.CalculateSize(_repeated_teams_codec);
		if (CompletedTargetsNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompletedTargetsNum);
		}
		if (CompletedNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CompletedNum);
		}
		if (CurChallengeSubStage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurChallengeSubStage);
		}
		num += latestUseSeconds_.CalculateSize(_repeated_latestUseSeconds_codec);
		if (EntryWorldId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EntryWorldId);
		}
		if (EnterSubStageTs != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnterSubStageTs);
		}
		num += subStageRestartCount_.CalculateSize(_repeated_subStageRestartCount_codec);
		if (StageRestartCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StageRestartCount);
		}
		num += subStageTransNo_.CalculateSize(_repeated_subStageTransNo_codec);
		num += evaluationClaimState_.CalculateSize(_map_evaluationClaimState_codec);
		num += subStageMinimumSecs_.CalculateSize(_map_subStageMinimumSecs_codec);
		if (State != StageStateEnum.StageStateOut)
		{
			num += 2 + CodedOutputStream.ComputeEnumSize((int)State);
		}
		num += subStageBattleReports_.CalculateSize(_repeated_subStageBattleReports_codec);
		if (stageBattleReport_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(StageBattleReport);
		}
		if (StageMinimumSecs != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(StageMinimumSecs);
		}
		if (target_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(Target);
		}
		if (aggregateSettleInfo_ != null)
		{
			num += 2 + CodedOutputStream.ComputeMessageSize(AggregateSettleInfo);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(AbyssStage other)
	{
		if (other == null)
		{
			return;
		}
		if (other.Index != 0)
		{
			Index = other.Index;
		}
		if (other.IsUnlock)
		{
			IsUnlock = other.IsUnlock;
		}
		teams_.Add(other.teams_);
		if (other.CompletedTargetsNum != 0)
		{
			CompletedTargetsNum = other.CompletedTargetsNum;
		}
		if (other.CompletedNum != 0)
		{
			CompletedNum = other.CompletedNum;
		}
		if (other.CurChallengeSubStage != 0)
		{
			CurChallengeSubStage = other.CurChallengeSubStage;
		}
		latestUseSeconds_.Add(other.latestUseSeconds_);
		if (other.EntryWorldId != 0)
		{
			EntryWorldId = other.EntryWorldId;
		}
		if (other.EnterSubStageTs != 0)
		{
			EnterSubStageTs = other.EnterSubStageTs;
		}
		subStageRestartCount_.Add(other.subStageRestartCount_);
		if (other.StageRestartCount != 0)
		{
			StageRestartCount = other.StageRestartCount;
		}
		subStageTransNo_.Add(other.subStageTransNo_);
		evaluationClaimState_.Add(other.evaluationClaimState_);
		subStageMinimumSecs_.Add(other.subStageMinimumSecs_);
		if (other.State != StageStateEnum.StageStateOut)
		{
			State = other.State;
		}
		subStageBattleReports_.Add(other.subStageBattleReports_);
		if (other.stageBattleReport_ != null)
		{
			if (stageBattleReport_ == null)
			{
				StageBattleReport = new AbyssBattleReport();
			}
			StageBattleReport.MergeFrom(other.StageBattleReport);
		}
		if (other.StageMinimumSecs != 0)
		{
			StageMinimumSecs = other.StageMinimumSecs;
		}
		if (other.target_ != null)
		{
			if (target_ == null)
			{
				Target = new StageChallengeTarget();
			}
			Target.MergeFrom(other.Target);
		}
		if (other.aggregateSettleInfo_ != null)
		{
			if (aggregateSettleInfo_ == null)
			{
				AggregateSettleInfo = new StageSettleInfo();
			}
			AggregateSettleInfo.MergeFrom(other.AggregateSettleInfo);
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
				Index = input.ReadInt32();
				break;
			case 16u:
				IsUnlock = input.ReadBool();
				break;
			case 26u:
				teams_.AddEntriesFrom(ref input, _repeated_teams_codec);
				break;
			case 32u:
				CompletedTargetsNum = input.ReadInt32();
				break;
			case 40u:
				CompletedNum = input.ReadInt32();
				break;
			case 48u:
				CurChallengeSubStage = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				latestUseSeconds_.AddEntriesFrom(ref input, _repeated_latestUseSeconds_codec);
				break;
			case 64u:
				EntryWorldId = input.ReadInt32();
				break;
			case 72u:
				EnterSubStageTs = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				subStageRestartCount_.AddEntriesFrom(ref input, _repeated_subStageRestartCount_codec);
				break;
			case 96u:
				StageRestartCount = input.ReadInt32();
				break;
			case 106u:
				subStageTransNo_.AddEntriesFrom(ref input, _repeated_subStageTransNo_codec);
				break;
			case 114u:
				evaluationClaimState_.AddEntriesFrom(ref input, _map_evaluationClaimState_codec);
				break;
			case 122u:
				subStageMinimumSecs_.AddEntriesFrom(ref input, _map_subStageMinimumSecs_codec);
				break;
			case 128u:
				State = (StageStateEnum)input.ReadEnum();
				break;
			case 138u:
				subStageBattleReports_.AddEntriesFrom(ref input, _repeated_subStageBattleReports_codec);
				break;
			case 146u:
				if (stageBattleReport_ == null)
				{
					StageBattleReport = new AbyssBattleReport();
				}
				input.ReadMessage(StageBattleReport);
				break;
			case 152u:
				StageMinimumSecs = input.ReadInt32();
				break;
			case 162u:
				if (target_ == null)
				{
					Target = new StageChallengeTarget();
				}
				input.ReadMessage(Target);
				break;
			case 170u:
				if (aggregateSettleInfo_ == null)
				{
					AggregateSettleInfo = new StageSettleInfo();
				}
				input.ReadMessage(AggregateSettleInfo);
				break;
			}
		}
	}
}
