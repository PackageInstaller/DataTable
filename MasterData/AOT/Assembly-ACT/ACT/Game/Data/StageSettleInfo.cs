using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class StageSettleInfo : IMessage<StageSettleInfo>, IMessage, IEquatable<StageSettleInfo>, IDeepCloneable<StageSettleInfo>, IBufferMessage
{
	private static readonly MessageParser<StageSettleInfo> _parser = new MessageParser<StageSettleInfo>(() => new StageSettleInfo());

	private UnknownFieldSet _unknownFields;

	public const int CharacterInfoFieldNumber = 1;

	private static readonly FieldCodec<StageSettleCharacterInfo> _repeated_characterInfo_codec = FieldCodec.ForMessage(10u, StageSettleCharacterInfo.Parser);

	private readonly RepeatedField<StageSettleCharacterInfo> characterInfo_ = new RepeatedField<StageSettleCharacterInfo>();

	public const int DurationFieldNumber = 2;

	private float duration_;

	public const int DieCountFieldNumber = 3;

	private int dieCount_;

	public const int TrapCountFieldNumber = 4;

	private int trapCount_;

	public const int PointCountFieldNumber = 5;

	private int pointCount_;

	public const int AssistSkillCountFieldNumber = 6;

	private int assistSkillCount_;

	public const int KillDiffTypeMonsterByAssistSkillCountFieldNumber = 7;

	private static readonly MapField<int, int>.Codec _map_killDiffTypeMonsterByAssistSkillCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 58u);

	private readonly MapField<int, int> killDiffTypeMonsterByAssistSkillCount_ = new MapField<int, int>();

	public const int TriggeredTrapCountFieldNumber = 8;

	private int triggeredTrapCount_;

	public const int CompletedChallengeTargetFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_completedChallengeTarget_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> completedChallengeTarget_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<StageSettleInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[204];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<StageSettleCharacterInfo> CharacterInfo => characterInfo_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int DieCount
	{
		get
		{
			return dieCount_;
		}
		set
		{
			dieCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TrapCount
	{
		get
		{
			return trapCount_;
		}
		set
		{
			trapCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PointCount
	{
		get
		{
			return pointCount_;
		}
		set
		{
			pointCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int AssistSkillCount
	{
		get
		{
			return assistSkillCount_;
		}
		set
		{
			assistSkillCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> KillDiffTypeMonsterByAssistSkillCount => killDiffTypeMonsterByAssistSkillCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TriggeredTrapCount
	{
		get
		{
			return triggeredTrapCount_;
		}
		set
		{
			triggeredTrapCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public RepeatedField<int> CompletedChallengeTarget => completedChallengeTarget_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleInfo(StageSettleInfo other)
		: this()
	{
		characterInfo_ = other.characterInfo_.Clone();
		duration_ = other.duration_;
		dieCount_ = other.dieCount_;
		trapCount_ = other.trapCount_;
		pointCount_ = other.pointCount_;
		assistSkillCount_ = other.assistSkillCount_;
		killDiffTypeMonsterByAssistSkillCount_ = other.killDiffTypeMonsterByAssistSkillCount_.Clone();
		triggeredTrapCount_ = other.triggeredTrapCount_;
		completedChallengeTarget_ = other.completedChallengeTarget_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleInfo Clone()
	{
		return new StageSettleInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as StageSettleInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(StageSettleInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (!characterInfo_.Equals(other.characterInfo_))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Duration, other.Duration))
		{
			return false;
		}
		if (DieCount != other.DieCount)
		{
			return false;
		}
		if (TrapCount != other.TrapCount)
		{
			return false;
		}
		if (PointCount != other.PointCount)
		{
			return false;
		}
		if (AssistSkillCount != other.AssistSkillCount)
		{
			return false;
		}
		if (!KillDiffTypeMonsterByAssistSkillCount.Equals(other.KillDiffTypeMonsterByAssistSkillCount))
		{
			return false;
		}
		if (TriggeredTrapCount != other.TriggeredTrapCount)
		{
			return false;
		}
		if (!completedChallengeTarget_.Equals(other.completedChallengeTarget_))
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
		num ^= characterInfo_.GetHashCode();
		if (Duration != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Duration);
		}
		if (DieCount != 0)
		{
			num ^= DieCount.GetHashCode();
		}
		if (TrapCount != 0)
		{
			num ^= TrapCount.GetHashCode();
		}
		if (PointCount != 0)
		{
			num ^= PointCount.GetHashCode();
		}
		if (AssistSkillCount != 0)
		{
			num ^= AssistSkillCount.GetHashCode();
		}
		num ^= KillDiffTypeMonsterByAssistSkillCount.GetHashCode();
		if (TriggeredTrapCount != 0)
		{
			num ^= TriggeredTrapCount.GetHashCode();
		}
		num ^= completedChallengeTarget_.GetHashCode();
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
		characterInfo_.WriteTo(ref output, _repeated_characterInfo_codec);
		if (Duration != 0f)
		{
			output.WriteRawTag(21);
			output.WriteFloat(Duration);
		}
		if (DieCount != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DieCount);
		}
		if (TrapCount != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TrapCount);
		}
		if (PointCount != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PointCount);
		}
		if (AssistSkillCount != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AssistSkillCount);
		}
		killDiffTypeMonsterByAssistSkillCount_.WriteTo(ref output, _map_killDiffTypeMonsterByAssistSkillCount_codec);
		if (TriggeredTrapCount != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(TriggeredTrapCount);
		}
		completedChallengeTarget_.WriteTo(ref output, _repeated_completedChallengeTarget_codec);
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
		num += characterInfo_.CalculateSize(_repeated_characterInfo_codec);
		if (Duration != 0f)
		{
			num += 5;
		}
		if (DieCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DieCount);
		}
		if (TrapCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrapCount);
		}
		if (PointCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PointCount);
		}
		if (AssistSkillCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AssistSkillCount);
		}
		num += killDiffTypeMonsterByAssistSkillCount_.CalculateSize(_map_killDiffTypeMonsterByAssistSkillCount_codec);
		if (TriggeredTrapCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggeredTrapCount);
		}
		num += completedChallengeTarget_.CalculateSize(_repeated_completedChallengeTarget_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(StageSettleInfo other)
	{
		if (other != null)
		{
			characterInfo_.Add(other.characterInfo_);
			if (other.Duration != 0f)
			{
				Duration = other.Duration;
			}
			if (other.DieCount != 0)
			{
				DieCount = other.DieCount;
			}
			if (other.TrapCount != 0)
			{
				TrapCount = other.TrapCount;
			}
			if (other.PointCount != 0)
			{
				PointCount = other.PointCount;
			}
			if (other.AssistSkillCount != 0)
			{
				AssistSkillCount = other.AssistSkillCount;
			}
			killDiffTypeMonsterByAssistSkillCount_.Add(other.killDiffTypeMonsterByAssistSkillCount_);
			if (other.TriggeredTrapCount != 0)
			{
				TriggeredTrapCount = other.TriggeredTrapCount;
			}
			completedChallengeTarget_.Add(other.completedChallengeTarget_);
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
			case 10u:
				characterInfo_.AddEntriesFrom(ref input, _repeated_characterInfo_codec);
				break;
			case 21u:
				Duration = input.ReadFloat();
				break;
			case 24u:
				DieCount = input.ReadInt32();
				break;
			case 32u:
				TrapCount = input.ReadInt32();
				break;
			case 40u:
				PointCount = input.ReadInt32();
				break;
			case 48u:
				AssistSkillCount = input.ReadInt32();
				break;
			case 58u:
				killDiffTypeMonsterByAssistSkillCount_.AddEntriesFrom(ref input, _map_killDiffTypeMonsterByAssistSkillCount_codec);
				break;
			case 64u:
				TriggeredTrapCount = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				completedChallengeTarget_.AddEntriesFrom(ref input, _repeated_completedChallengeTarget_codec);
				break;
			}
		}
	}
}
