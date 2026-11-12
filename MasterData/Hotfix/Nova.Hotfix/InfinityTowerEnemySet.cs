using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTowerEnemySet : IMessage<InfinityTowerEnemySet>, IMessage, IEquatable<InfinityTowerEnemySet>, IDeepCloneable<InfinityTowerEnemySet>
{
	private static readonly MessageParser<InfinityTowerEnemySet> _parser = new MessageParser<InfinityTowerEnemySet>(() => new InfinityTowerEnemySet());

	private UnknownFieldSet _unknownFields;

	public const int SetIdFieldNumber = 1;

	private int setId_;

	public const int WaveNumFieldNumber = 2;

	private int waveNum_;

	public const int GroupNumFieldNumber = 3;

	private int groupNum_;

	public const int MaxNumFieldNumber = 4;

	private int maxNum_;

	public const int MaxNumPerWaveFieldNumber = 5;

	private int maxNumPerWave_;

	public const int MonsterIdFieldNumber = 6;

	private int monsterId_;

	public const int LevelChangeFieldNumber = 7;

	private int levelChange_;

	public const int CommonGameplayTypeFieldNumber = 8;

	private int commonGameplayType_;

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTowerEnemySet> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(452);

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
	public int WaveNum
	{
		get
		{
			return waveNum_;
		}
		set
		{
			waveNum_ = value;
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
	public int MaxNumPerWave
	{
		get
		{
			return maxNumPerWave_;
		}
		set
		{
			maxNumPerWave_ = value;
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
	public int CommonGameplayType
	{
		get
		{
			return commonGameplayType_;
		}
		set
		{
			commonGameplayType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public InfinityTowerEnemySet()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTowerEnemySet(InfinityTowerEnemySet other)
		: this()
	{
		setId_ = other.setId_;
		waveNum_ = other.waveNum_;
		groupNum_ = other.groupNum_;
		maxNum_ = other.maxNum_;
		maxNumPerWave_ = other.maxNumPerWave_;
		monsterId_ = other.monsterId_;
		levelChange_ = other.levelChange_;
		commonGameplayType_ = other.commonGameplayType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTowerEnemySet Clone()
	{
		return new InfinityTowerEnemySet(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTowerEnemySet);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTowerEnemySet other)
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
		if (WaveNum != other.WaveNum)
		{
			return false;
		}
		if (GroupNum != other.GroupNum)
		{
			return false;
		}
		if (MaxNum != other.MaxNum)
		{
			return false;
		}
		if (MaxNumPerWave != other.MaxNumPerWave)
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
		if (CommonGameplayType != other.CommonGameplayType)
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
		if (WaveNum != 0)
		{
			num ^= WaveNum.GetHashCode();
		}
		if (GroupNum != 0)
		{
			num ^= GroupNum.GetHashCode();
		}
		if (MaxNum != 0)
		{
			num ^= MaxNum.GetHashCode();
		}
		if (MaxNumPerWave != 0)
		{
			num ^= MaxNumPerWave.GetHashCode();
		}
		if (MonsterId != 0)
		{
			num ^= MonsterId.GetHashCode();
		}
		if (LevelChange != 0)
		{
			num ^= LevelChange.GetHashCode();
		}
		if (CommonGameplayType != 0)
		{
			num ^= CommonGameplayType.GetHashCode();
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
		if (WaveNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(WaveNum);
		}
		if (GroupNum != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GroupNum);
		}
		if (MaxNum != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MaxNum);
		}
		if (MaxNumPerWave != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(MaxNumPerWave);
		}
		if (MonsterId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(MonsterId);
		}
		if (LevelChange != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(LevelChange);
		}
		if (CommonGameplayType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(CommonGameplayType);
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
		if (WaveNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WaveNum);
		}
		if (GroupNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupNum);
		}
		if (MaxNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxNum);
		}
		if (MaxNumPerWave != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxNumPerWave);
		}
		if (MonsterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterId);
		}
		if (LevelChange != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelChange);
		}
		if (CommonGameplayType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CommonGameplayType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InfinityTowerEnemySet other)
	{
		if (other != null)
		{
			if (other.SetId != 0)
			{
				SetId = other.SetId;
			}
			if (other.WaveNum != 0)
			{
				WaveNum = other.WaveNum;
			}
			if (other.GroupNum != 0)
			{
				GroupNum = other.GroupNum;
			}
			if (other.MaxNum != 0)
			{
				MaxNum = other.MaxNum;
			}
			if (other.MaxNumPerWave != 0)
			{
				MaxNumPerWave = other.MaxNumPerWave;
			}
			if (other.MonsterId != 0)
			{
				MonsterId = other.MonsterId;
			}
			if (other.LevelChange != 0)
			{
				LevelChange = other.LevelChange;
			}
			if (other.CommonGameplayType != 0)
			{
				CommonGameplayType = other.CommonGameplayType;
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
				WaveNum = input.ReadInt32();
				break;
			case 24u:
				GroupNum = input.ReadInt32();
				break;
			case 32u:
				MaxNum = input.ReadInt32();
				break;
			case 40u:
				MaxNumPerWave = input.ReadInt32();
				break;
			case 48u:
				MonsterId = input.ReadInt32();
				break;
			case 56u:
				LevelChange = input.ReadInt32();
				break;
			case 64u:
				CommonGameplayType = input.ReadInt32();
				break;
			}
		}
	}
}
