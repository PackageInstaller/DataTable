using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterAI : IMessage<MonsterAI>, IMessage, IEquatable<MonsterAI>, IDeepCloneable<MonsterAI>
{
	private static readonly MessageParser<MonsterAI> _parser = new MessageParser<MonsterAI>(() => new MonsterAI());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ComboGroupPathFieldNumber = 2;

	private string comboGroupPath_ = "";

	public const int SpawnShowSkillIdFieldNumber = 3;

	private int spawnShowSkillId_;

	public const int IdleShowSkillIdFieldNumber = 4;

	private int idleShowSkillId_;

	public const int DieSkillIdFieldNumber = 5;

	private int dieSkillId_;

	public const int ActionAIPathFieldNumber = 6;

	private string actionAIPath_ = "";

	public const int ActionBranchIdsFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_actionBranchIds_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> actionBranchIds_ = new RepeatedField<int>();

	public const int ThinkIntervalFieldNumber = 8;

	private int thinkInterval_;

	public const int IdleAIPathFieldNumber = 9;

	private string idleAIPath_ = "";

	public const int SpawnAIPathFieldNumber = 10;

	private string spawnAIPath_ = "";

	public const int ParallelAIPathFieldNumber = 11;

	private string parallelAIPath_ = "";

	public const int CheckAchievementFieldNumber = 12;

	private bool checkAchievement_;

	public const int WanderRangeFieldNumber = 13;

	private int wanderRange_;

	public const int WanderIntervalFieldNumber = 14;

	private int wanderInterval_;

	public const int WanderRateFieldNumber = 15;

	private int wanderRate_;

	[DebuggerNonUserCode]
	public static MessageParser<MonsterAI> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(570);

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
	public string ComboGroupPath
	{
		get
		{
			return comboGroupPath_;
		}
		set
		{
			comboGroupPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SpawnShowSkillId
	{
		get
		{
			return spawnShowSkillId_;
		}
		set
		{
			spawnShowSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int IdleShowSkillId
	{
		get
		{
			return idleShowSkillId_;
		}
		set
		{
			idleShowSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DieSkillId
	{
		get
		{
			return dieSkillId_;
		}
		set
		{
			dieSkillId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ActionAIPath
	{
		get
		{
			return actionAIPath_;
		}
		set
		{
			actionAIPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ActionBranchIds => actionBranchIds_;

	[DebuggerNonUserCode]
	public int ThinkInterval
	{
		get
		{
			return thinkInterval_;
		}
		set
		{
			thinkInterval_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string IdleAIPath
	{
		get
		{
			return idleAIPath_;
		}
		set
		{
			idleAIPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SpawnAIPath
	{
		get
		{
			return spawnAIPath_;
		}
		set
		{
			spawnAIPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ParallelAIPath
	{
		get
		{
			return parallelAIPath_;
		}
		set
		{
			parallelAIPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool CheckAchievement
	{
		get
		{
			return checkAchievement_;
		}
		set
		{
			checkAchievement_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WanderRange
	{
		get
		{
			return wanderRange_;
		}
		set
		{
			wanderRange_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WanderInterval
	{
		get
		{
			return wanderInterval_;
		}
		set
		{
			wanderInterval_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WanderRate
	{
		get
		{
			return wanderRate_;
		}
		set
		{
			wanderRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MonsterAI()
	{
	}

	[DebuggerNonUserCode]
	public MonsterAI(MonsterAI other)
		: this()
	{
		id_ = other.id_;
		comboGroupPath_ = other.comboGroupPath_;
		spawnShowSkillId_ = other.spawnShowSkillId_;
		idleShowSkillId_ = other.idleShowSkillId_;
		dieSkillId_ = other.dieSkillId_;
		actionAIPath_ = other.actionAIPath_;
		actionBranchIds_ = other.actionBranchIds_.Clone();
		thinkInterval_ = other.thinkInterval_;
		idleAIPath_ = other.idleAIPath_;
		spawnAIPath_ = other.spawnAIPath_;
		parallelAIPath_ = other.parallelAIPath_;
		checkAchievement_ = other.checkAchievement_;
		wanderRange_ = other.wanderRange_;
		wanderInterval_ = other.wanderInterval_;
		wanderRate_ = other.wanderRate_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterAI Clone()
	{
		return new MonsterAI(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterAI);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterAI other)
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
		if (ComboGroupPath != other.ComboGroupPath)
		{
			return false;
		}
		if (SpawnShowSkillId != other.SpawnShowSkillId)
		{
			return false;
		}
		if (IdleShowSkillId != other.IdleShowSkillId)
		{
			return false;
		}
		if (DieSkillId != other.DieSkillId)
		{
			return false;
		}
		if (ActionAIPath != other.ActionAIPath)
		{
			return false;
		}
		if (!actionBranchIds_.Equals(other.actionBranchIds_))
		{
			return false;
		}
		if (ThinkInterval != other.ThinkInterval)
		{
			return false;
		}
		if (IdleAIPath != other.IdleAIPath)
		{
			return false;
		}
		if (SpawnAIPath != other.SpawnAIPath)
		{
			return false;
		}
		if (ParallelAIPath != other.ParallelAIPath)
		{
			return false;
		}
		if (CheckAchievement != other.CheckAchievement)
		{
			return false;
		}
		if (WanderRange != other.WanderRange)
		{
			return false;
		}
		if (WanderInterval != other.WanderInterval)
		{
			return false;
		}
		if (WanderRate != other.WanderRate)
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
		if (ComboGroupPath.Length != 0)
		{
			num ^= ComboGroupPath.GetHashCode();
		}
		if (SpawnShowSkillId != 0)
		{
			num ^= SpawnShowSkillId.GetHashCode();
		}
		if (IdleShowSkillId != 0)
		{
			num ^= IdleShowSkillId.GetHashCode();
		}
		if (DieSkillId != 0)
		{
			num ^= DieSkillId.GetHashCode();
		}
		if (ActionAIPath.Length != 0)
		{
			num ^= ActionAIPath.GetHashCode();
		}
		num ^= actionBranchIds_.GetHashCode();
		if (ThinkInterval != 0)
		{
			num ^= ThinkInterval.GetHashCode();
		}
		if (IdleAIPath.Length != 0)
		{
			num ^= IdleAIPath.GetHashCode();
		}
		if (SpawnAIPath.Length != 0)
		{
			num ^= SpawnAIPath.GetHashCode();
		}
		if (ParallelAIPath.Length != 0)
		{
			num ^= ParallelAIPath.GetHashCode();
		}
		if (CheckAchievement)
		{
			num ^= CheckAchievement.GetHashCode();
		}
		if (WanderRange != 0)
		{
			num ^= WanderRange.GetHashCode();
		}
		if (WanderInterval != 0)
		{
			num ^= WanderInterval.GetHashCode();
		}
		if (WanderRate != 0)
		{
			num ^= WanderRate.GetHashCode();
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
		if (ComboGroupPath.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(ComboGroupPath);
		}
		if (SpawnShowSkillId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SpawnShowSkillId);
		}
		if (IdleShowSkillId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(IdleShowSkillId);
		}
		if (DieSkillId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(DieSkillId);
		}
		if (ActionAIPath.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(ActionAIPath);
		}
		actionBranchIds_.WriteTo(output, _repeated_actionBranchIds_codec);
		if (ThinkInterval != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ThinkInterval);
		}
		if (IdleAIPath.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(IdleAIPath);
		}
		if (SpawnAIPath.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(SpawnAIPath);
		}
		if (ParallelAIPath.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(ParallelAIPath);
		}
		if (CheckAchievement)
		{
			output.WriteRawTag(96);
			output.WriteBool(CheckAchievement);
		}
		if (WanderRange != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(WanderRange);
		}
		if (WanderInterval != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(WanderInterval);
		}
		if (WanderRate != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(WanderRate);
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
		if (ComboGroupPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ComboGroupPath);
		}
		if (SpawnShowSkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnShowSkillId);
		}
		if (IdleShowSkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(IdleShowSkillId);
		}
		if (DieSkillId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DieSkillId);
		}
		if (ActionAIPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ActionAIPath);
		}
		num += actionBranchIds_.CalculateSize(_repeated_actionBranchIds_codec);
		if (ThinkInterval != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ThinkInterval);
		}
		if (IdleAIPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IdleAIPath);
		}
		if (SpawnAIPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SpawnAIPath);
		}
		if (ParallelAIPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ParallelAIPath);
		}
		if (CheckAchievement)
		{
			num += 2;
		}
		if (WanderRange != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WanderRange);
		}
		if (WanderInterval != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WanderInterval);
		}
		if (WanderRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WanderRate);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterAI other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ComboGroupPath.Length != 0)
			{
				ComboGroupPath = other.ComboGroupPath;
			}
			if (other.SpawnShowSkillId != 0)
			{
				SpawnShowSkillId = other.SpawnShowSkillId;
			}
			if (other.IdleShowSkillId != 0)
			{
				IdleShowSkillId = other.IdleShowSkillId;
			}
			if (other.DieSkillId != 0)
			{
				DieSkillId = other.DieSkillId;
			}
			if (other.ActionAIPath.Length != 0)
			{
				ActionAIPath = other.ActionAIPath;
			}
			actionBranchIds_.Add(other.actionBranchIds_);
			if (other.ThinkInterval != 0)
			{
				ThinkInterval = other.ThinkInterval;
			}
			if (other.IdleAIPath.Length != 0)
			{
				IdleAIPath = other.IdleAIPath;
			}
			if (other.SpawnAIPath.Length != 0)
			{
				SpawnAIPath = other.SpawnAIPath;
			}
			if (other.ParallelAIPath.Length != 0)
			{
				ParallelAIPath = other.ParallelAIPath;
			}
			if (other.CheckAchievement)
			{
				CheckAchievement = other.CheckAchievement;
			}
			if (other.WanderRange != 0)
			{
				WanderRange = other.WanderRange;
			}
			if (other.WanderInterval != 0)
			{
				WanderInterval = other.WanderInterval;
			}
			if (other.WanderRate != 0)
			{
				WanderRate = other.WanderRate;
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
				ComboGroupPath = input.ReadString();
				break;
			case 24u:
				SpawnShowSkillId = input.ReadInt32();
				break;
			case 32u:
				IdleShowSkillId = input.ReadInt32();
				break;
			case 40u:
				DieSkillId = input.ReadInt32();
				break;
			case 50u:
				ActionAIPath = input.ReadString();
				break;
			case 56u:
			case 58u:
				actionBranchIds_.AddEntriesFrom(input, _repeated_actionBranchIds_codec);
				break;
			case 64u:
				ThinkInterval = input.ReadInt32();
				break;
			case 74u:
				IdleAIPath = input.ReadString();
				break;
			case 82u:
				SpawnAIPath = input.ReadString();
				break;
			case 90u:
				ParallelAIPath = input.ReadString();
				break;
			case 96u:
				CheckAchievement = input.ReadBool();
				break;
			case 104u:
				WanderRange = input.ReadInt32();
				break;
			case 112u:
				WanderInterval = input.ReadInt32();
				break;
			case 120u:
				WanderRate = input.ReadInt32();
				break;
			}
		}
	}
}
