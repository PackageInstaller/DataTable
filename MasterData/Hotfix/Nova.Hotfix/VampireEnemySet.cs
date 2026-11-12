using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireEnemySet : IMessage<VampireEnemySet>, IMessage, IEquatable<VampireEnemySet>, IDeepCloneable<VampireEnemySet>
{
	private static readonly MessageParser<VampireEnemySet> _parser = new MessageParser<VampireEnemySet>(() => new VampireEnemySet());

	private UnknownFieldSet _unknownFields;

	public const int SetIdFieldNumber = 1;

	private int setId_;

	public const int GroupNumFieldNumber = 2;

	private int groupNum_;

	public const int MonsterIdFieldNumber = 3;

	private int monsterId_;

	public const int LevelChangeFieldNumber = 4;

	private int levelChange_;

	public const int DelayTimeFieldNumber = 5;

	private int delayTime_;

	public const int MaxNumFieldNumber = 6;

	private int maxNum_;

	public const int AddDataFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_addData_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> addData_ = new RepeatedField<int>();

	public const int MaxNumImproveDataFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_maxNumImproveData_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> maxNumImproveData_ = new RepeatedField<int>();

	public const int MonsterSpawnTypeFieldNumber = 9;

	private int monsterSpawnType_;

	public const int MonsterPointFieldNumber = 10;

	private int monsterPoint_;

	public const int DropExpFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_dropExp_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> dropExp_ = new RepeatedField<int>();

	public const int DropChestFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_dropChest_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> dropChest_ = new RepeatedField<int>();

	public const int DropHpFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_dropHp_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> dropHp_ = new RepeatedField<int>();

	public const int DropMpFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_dropMp_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> dropMp_ = new RepeatedField<int>();

	public const int DropAtkFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_dropAtk_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> dropAtk_ = new RepeatedField<int>();

	public const int DropGetFieldNumber = 16;

	private static readonly FieldCodec<int> _repeated_dropGet_codec = FieldCodec.ForInt32(130u);

	private readonly RepeatedField<int> dropGet_ = new RepeatedField<int>();

	public const int DropClearFieldNumber = 17;

	private static readonly FieldCodec<int> _repeated_dropClear_codec = FieldCodec.ForInt32(138u);

	private readonly RepeatedField<int> dropClear_ = new RepeatedField<int>();

	public const int MonsterWarningFieldNumber = 18;

	private int monsterWarning_;

	[DebuggerNonUserCode]
	public static MessageParser<VampireEnemySet> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1050);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int SetId
	{
		get
		{
			return setId_;
		}
		set
		{
			setId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GroupNum
	{
		get
		{
			return groupNum_;
		}
		set
		{
			groupNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MonsterId
	{
		get
		{
			return monsterId_;
		}
		set
		{
			monsterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelChange
	{
		get
		{
			return levelChange_;
		}
		set
		{
			levelChange_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DelayTime
	{
		get
		{
			return delayTime_;
		}
		set
		{
			delayTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxNum
	{
		get
		{
			return maxNum_;
		}
		set
		{
			maxNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> AddData => addData_;

	[DebuggerNonUserCode]
	public RepeatedField<int> MaxNumImproveData => maxNumImproveData_;

	[DebuggerNonUserCode]
	public int MonsterSpawnType
	{
		get
		{
			return monsterSpawnType_;
		}
		set
		{
			monsterSpawnType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MonsterPoint
	{
		get
		{
			return monsterPoint_;
		}
		set
		{
			monsterPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> DropExp => dropExp_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DropChest => dropChest_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DropHp => dropHp_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DropMp => dropMp_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DropAtk => dropAtk_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DropGet => dropGet_;

	[DebuggerNonUserCode]
	public RepeatedField<int> DropClear => dropClear_;

	[DebuggerNonUserCode]
	public int MonsterWarning
	{
		get
		{
			return monsterWarning_;
		}
		set
		{
			monsterWarning_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VampireEnemySet()
	{
	}

	[DebuggerNonUserCode]
	public VampireEnemySet(VampireEnemySet other)
		: this()
	{
		setId_ = other.setId_;
		groupNum_ = other.groupNum_;
		monsterId_ = other.monsterId_;
		levelChange_ = other.levelChange_;
		delayTime_ = other.delayTime_;
		maxNum_ = other.maxNum_;
		addData_ = other.addData_.Clone();
		maxNumImproveData_ = other.maxNumImproveData_.Clone();
		monsterSpawnType_ = other.monsterSpawnType_;
		monsterPoint_ = other.monsterPoint_;
		dropExp_ = other.dropExp_.Clone();
		dropChest_ = other.dropChest_.Clone();
		dropHp_ = other.dropHp_.Clone();
		dropMp_ = other.dropMp_.Clone();
		dropAtk_ = other.dropAtk_.Clone();
		dropGet_ = other.dropGet_.Clone();
		dropClear_ = other.dropClear_.Clone();
		monsterWarning_ = other.monsterWarning_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireEnemySet Clone()
	{
		return new VampireEnemySet(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireEnemySet);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireEnemySet other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (SetId != other.SetId)
		{
			return false;
		}
		if (GroupNum != other.GroupNum)
		{
			return false;
		}
		if (MonsterId != other.MonsterId)
		{
			return false;
		}
		if (LevelChange != other.LevelChange)
		{
			return false;
		}
		if (DelayTime != other.DelayTime)
		{
			return false;
		}
		if (MaxNum != other.MaxNum)
		{
			return false;
		}
		if (!addData_.Equals(other.addData_))
		{
			return false;
		}
		if (!maxNumImproveData_.Equals(other.maxNumImproveData_))
		{
			return false;
		}
		if (MonsterSpawnType != other.MonsterSpawnType)
		{
			return false;
		}
		if (MonsterPoint != other.MonsterPoint)
		{
			return false;
		}
		if (!dropExp_.Equals(other.dropExp_))
		{
			return false;
		}
		if (!dropChest_.Equals(other.dropChest_))
		{
			return false;
		}
		if (!dropHp_.Equals(other.dropHp_))
		{
			return false;
		}
		if (!dropMp_.Equals(other.dropMp_))
		{
			return false;
		}
		if (!dropAtk_.Equals(other.dropAtk_))
		{
			return false;
		}
		if (!dropGet_.Equals(other.dropGet_))
		{
			return false;
		}
		if (!dropClear_.Equals(other.dropClear_))
		{
			return false;
		}
		if (MonsterWarning != other.MonsterWarning)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (SetId != 0)
		{
			num ^= SetId.GetHashCode();
		}
		if (GroupNum != 0)
		{
			num ^= GroupNum.GetHashCode();
		}
		if (MonsterId != 0)
		{
			num ^= MonsterId.GetHashCode();
		}
		if (LevelChange != 0)
		{
			num ^= LevelChange.GetHashCode();
		}
		if (DelayTime != 0)
		{
			num ^= DelayTime.GetHashCode();
		}
		if (MaxNum != 0)
		{
			num ^= MaxNum.GetHashCode();
		}
		num ^= addData_.GetHashCode();
		num ^= maxNumImproveData_.GetHashCode();
		if (MonsterSpawnType != 0)
		{
			num ^= MonsterSpawnType.GetHashCode();
		}
		if (MonsterPoint != 0)
		{
			num ^= MonsterPoint.GetHashCode();
		}
		num ^= dropExp_.GetHashCode();
		num ^= dropChest_.GetHashCode();
		num ^= dropHp_.GetHashCode();
		num ^= dropMp_.GetHashCode();
		num ^= dropAtk_.GetHashCode();
		num ^= dropGet_.GetHashCode();
		num ^= dropClear_.GetHashCode();
		if (MonsterWarning != 0)
		{
			num ^= MonsterWarning.GetHashCode();
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
		if (SetId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(SetId);
		}
		if (GroupNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupNum);
		}
		if (MonsterId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MonsterId);
		}
		if (LevelChange != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LevelChange);
		}
		if (DelayTime != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(DelayTime);
		}
		if (MaxNum != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(MaxNum);
		}
		addData_.WriteTo(output, _repeated_addData_codec);
		maxNumImproveData_.WriteTo(output, _repeated_maxNumImproveData_codec);
		if (MonsterSpawnType != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(MonsterSpawnType);
		}
		if (MonsterPoint != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(MonsterPoint);
		}
		dropExp_.WriteTo(output, _repeated_dropExp_codec);
		dropChest_.WriteTo(output, _repeated_dropChest_codec);
		dropHp_.WriteTo(output, _repeated_dropHp_codec);
		dropMp_.WriteTo(output, _repeated_dropMp_codec);
		dropAtk_.WriteTo(output, _repeated_dropAtk_codec);
		dropGet_.WriteTo(output, _repeated_dropGet_codec);
		dropClear_.WriteTo(output, _repeated_dropClear_codec);
		if (MonsterWarning != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(MonsterWarning);
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
		if (SetId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SetId);
		}
		if (GroupNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupNum);
		}
		if (MonsterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterId);
		}
		if (LevelChange != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelChange);
		}
		if (DelayTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DelayTime);
		}
		if (MaxNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxNum);
		}
		num += addData_.CalculateSize(_repeated_addData_codec);
		num += maxNumImproveData_.CalculateSize(_repeated_maxNumImproveData_codec);
		if (MonsterSpawnType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterSpawnType);
		}
		if (MonsterPoint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterPoint);
		}
		num += dropExp_.CalculateSize(_repeated_dropExp_codec);
		num += dropChest_.CalculateSize(_repeated_dropChest_codec);
		num += dropHp_.CalculateSize(_repeated_dropHp_codec);
		num += dropMp_.CalculateSize(_repeated_dropMp_codec);
		num += dropAtk_.CalculateSize(_repeated_dropAtk_codec);
		num += dropGet_.CalculateSize(_repeated_dropGet_codec);
		num += dropClear_.CalculateSize(_repeated_dropClear_codec);
		if (MonsterWarning != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MonsterWarning);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireEnemySet other)
	{
		if (other != null)
		{
			if (other.SetId != 0)
			{
				SetId = other.SetId;
			}
			if (other.GroupNum != 0)
			{
				GroupNum = other.GroupNum;
			}
			if (other.MonsterId != 0)
			{
				MonsterId = other.MonsterId;
			}
			if (other.LevelChange != 0)
			{
				LevelChange = other.LevelChange;
			}
			if (other.DelayTime != 0)
			{
				DelayTime = other.DelayTime;
			}
			if (other.MaxNum != 0)
			{
				MaxNum = other.MaxNum;
			}
			addData_.Add(other.addData_);
			maxNumImproveData_.Add(other.maxNumImproveData_);
			if (other.MonsterSpawnType != 0)
			{
				MonsterSpawnType = other.MonsterSpawnType;
			}
			if (other.MonsterPoint != 0)
			{
				MonsterPoint = other.MonsterPoint;
			}
			dropExp_.Add(other.dropExp_);
			dropChest_.Add(other.dropChest_);
			dropHp_.Add(other.dropHp_);
			dropMp_.Add(other.dropMp_);
			dropAtk_.Add(other.dropAtk_);
			dropGet_.Add(other.dropGet_);
			dropClear_.Add(other.dropClear_);
			if (other.MonsterWarning != 0)
			{
				MonsterWarning = other.MonsterWarning;
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
				SetId = input.ReadInt32();
				break;
			case 16u:
				GroupNum = input.ReadInt32();
				break;
			case 24u:
				MonsterId = input.ReadInt32();
				break;
			case 32u:
				LevelChange = input.ReadInt32();
				break;
			case 40u:
				DelayTime = input.ReadInt32();
				break;
			case 48u:
				MaxNum = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				addData_.AddEntriesFrom(input, _repeated_addData_codec);
				break;
			case 64u:
			case 66u:
				maxNumImproveData_.AddEntriesFrom(input, _repeated_maxNumImproveData_codec);
				break;
			case 72u:
				MonsterSpawnType = input.ReadInt32();
				break;
			case 80u:
				MonsterPoint = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				dropExp_.AddEntriesFrom(input, _repeated_dropExp_codec);
				break;
			case 96u:
			case 98u:
				dropChest_.AddEntriesFrom(input, _repeated_dropChest_codec);
				break;
			case 104u:
			case 106u:
				dropHp_.AddEntriesFrom(input, _repeated_dropHp_codec);
				break;
			case 112u:
			case 114u:
				dropMp_.AddEntriesFrom(input, _repeated_dropMp_codec);
				break;
			case 120u:
			case 122u:
				dropAtk_.AddEntriesFrom(input, _repeated_dropAtk_codec);
				break;
			case 128u:
			case 130u:
				dropGet_.AddEntriesFrom(input, _repeated_dropGet_codec);
				break;
			case 136u:
			case 138u:
				dropClear_.AddEntriesFrom(input, _repeated_dropClear_codec);
				break;
			case 144u:
				MonsterWarning = input.ReadInt32();
				break;
			}
		}
	}
}
