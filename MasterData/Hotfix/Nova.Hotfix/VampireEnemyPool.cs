using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireEnemyPool : IMessage<VampireEnemyPool>, IMessage, IEquatable<VampireEnemyPool>, IDeepCloneable<VampireEnemyPool>
{
	private static readonly MessageParser<VampireEnemyPool> _parser = new MessageParser<VampireEnemyPool>(() => new VampireEnemyPool());

	private UnknownFieldSet _unknownFields;

	public const int PoolIdFieldNumber = 1;

	private int poolId_;

	public const int WaveNumFieldNumber = 2;

	private int waveNum_;

	public const int MonsterLevelFieldNumber = 3;

	private int monsterLevel_;

	public const int EnemySetIDFieldNumber = 4;

	private int enemySetID_;

	public const int WaveKeepTimeFieldNumber = 5;

	private int waveKeepTime_;

	public const int PoolTypeFieldNumber = 6;

	private int poolType_;

	[DebuggerNonUserCode]
	public static MessageParser<VampireEnemyPool> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1048);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int PoolId
	{
		get
		{
			return poolId_;
		}
		set
		{
			poolId_ = value;
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
	public int MonsterLevel
	{
		get
		{
			return monsterLevel_;
		}
		set
		{
			monsterLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EnemySetID
	{
		get
		{
			return enemySetID_;
		}
		set
		{
			enemySetID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WaveKeepTime
	{
		get
		{
			return waveKeepTime_;
		}
		set
		{
			waveKeepTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PoolType
	{
		get
		{
			return poolType_;
		}
		set
		{
			poolType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VampireEnemyPool()
	{
	}

	[DebuggerNonUserCode]
	public VampireEnemyPool(VampireEnemyPool other)
		: this()
	{
		poolId_ = other.poolId_;
		waveNum_ = other.waveNum_;
		monsterLevel_ = other.monsterLevel_;
		enemySetID_ = other.enemySetID_;
		waveKeepTime_ = other.waveKeepTime_;
		poolType_ = other.poolType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireEnemyPool Clone()
	{
		return new VampireEnemyPool(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireEnemyPool);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireEnemyPool other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (PoolId != other.PoolId)
		{
			return false;
		}
		if (WaveNum != other.WaveNum)
		{
			return false;
		}
		if (MonsterLevel != other.MonsterLevel)
		{
			return false;
		}
		if (EnemySetID != other.EnemySetID)
		{
			return false;
		}
		if (WaveKeepTime != other.WaveKeepTime)
		{
			return false;
		}
		if (PoolType != other.PoolType)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (PoolId != 0)
		{
			num ^= PoolId.GetHashCode();
		}
		if (WaveNum != 0)
		{
			num ^= WaveNum.GetHashCode();
		}
		if (MonsterLevel != 0)
		{
			num ^= MonsterLevel.GetHashCode();
		}
		if (EnemySetID != 0)
		{
			num ^= EnemySetID.GetHashCode();
		}
		if (WaveKeepTime != 0)
		{
			num ^= WaveKeepTime.GetHashCode();
		}
		if (PoolType != 0)
		{
			num ^= PoolType.GetHashCode();
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
		if (PoolId != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(PoolId);
		}
		if (WaveNum != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(WaveNum);
		}
		if (MonsterLevel != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MonsterLevel);
		}
		if (EnemySetID != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(EnemySetID);
		}
		if (WaveKeepTime != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(WaveKeepTime);
		}
		if (PoolType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PoolType);
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
		if (PoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PoolId);
		}
		if (WaveNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WaveNum);
		}
		if (MonsterLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterLevel);
		}
		if (EnemySetID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnemySetID);
		}
		if (WaveKeepTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WaveKeepTime);
		}
		if (PoolType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PoolType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireEnemyPool other)
	{
		if (other != null)
		{
			if (other.PoolId != 0)
			{
				PoolId = other.PoolId;
			}
			if (other.WaveNum != 0)
			{
				WaveNum = other.WaveNum;
			}
			if (other.MonsterLevel != 0)
			{
				MonsterLevel = other.MonsterLevel;
			}
			if (other.EnemySetID != 0)
			{
				EnemySetID = other.EnemySetID;
			}
			if (other.WaveKeepTime != 0)
			{
				WaveKeepTime = other.WaveKeepTime;
			}
			if (other.PoolType != 0)
			{
				PoolType = other.PoolType;
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
				PoolId = input.ReadInt32();
				break;
			case 16u:
				WaveNum = input.ReadInt32();
				break;
			case 24u:
				MonsterLevel = input.ReadInt32();
				break;
			case 32u:
				EnemySetID = input.ReadInt32();
				break;
			case 40u:
				WaveKeepTime = input.ReadInt32();
				break;
			case 48u:
				PoolType = input.ReadInt32();
				break;
			}
		}
	}
}
