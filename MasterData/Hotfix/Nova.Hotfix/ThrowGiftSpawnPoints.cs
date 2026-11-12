using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ThrowGiftSpawnPoints : IMessage<ThrowGiftSpawnPoints>, IMessage, IEquatable<ThrowGiftSpawnPoints>, IDeepCloneable<ThrowGiftSpawnPoints>
{
	private static readonly MessageParser<ThrowGiftSpawnPoints> _parser = new MessageParser<ThrowGiftSpawnPoints>(() => new ThrowGiftSpawnPoints());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int IsRandomFieldNumber = 3;

	private bool isRandom_;

	public const int GoalTypeFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_goalType_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> goalType_ = new RepeatedField<int>();

	public const int SpawnRangeTypeXFieldNumber = 5;

	private int spawnRangeTypeX_;

	public const int SpawnRangeTypeYFieldNumber = 6;

	private int spawnRangeTypeY_;

	public const int InitShowFieldNumber = 7;

	private bool initShow_;

	public const int MoveXFieldNumber = 8;

	private int moveX_;

	public const int MoveYFieldNumber = 9;

	private int moveY_;

	public const int PoolTypeFieldNumber = 10;

	private bool poolType_;

	public const int ItemPoolFieldNumber = 11;

	private int itemPool_;

	public const int ActiveCondFieldNumber = 12;

	private int activeCond_;

	public const int SpawnParamFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_spawnParam_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> spawnParam_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<ThrowGiftSpawnPoints> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(936);

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
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsRandom
	{
		get
		{
			return isRandom_;
		}
		set
		{
			isRandom_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> GoalType => goalType_;

	[DebuggerNonUserCode]
	public int SpawnRangeTypeX
	{
		get
		{
			return spawnRangeTypeX_;
		}
		set
		{
			spawnRangeTypeX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SpawnRangeTypeY
	{
		get
		{
			return spawnRangeTypeY_;
		}
		set
		{
			spawnRangeTypeY_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool InitShow
	{
		get
		{
			return initShow_;
		}
		set
		{
			initShow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MoveX
	{
		get
		{
			return moveX_;
		}
		set
		{
			moveX_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MoveY
	{
		get
		{
			return moveY_;
		}
		set
		{
			moveY_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool PoolType
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
	public int ItemPool
	{
		get
		{
			return itemPool_;
		}
		set
		{
			itemPool_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActiveCond
	{
		get
		{
			return activeCond_;
		}
		set
		{
			activeCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> SpawnParam => spawnParam_;

	[DebuggerNonUserCode]
	public ThrowGiftSpawnPoints()
	{
	}

	[DebuggerNonUserCode]
	public ThrowGiftSpawnPoints(ThrowGiftSpawnPoints other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		isRandom_ = other.isRandom_;
		goalType_ = other.goalType_.Clone();
		spawnRangeTypeX_ = other.spawnRangeTypeX_;
		spawnRangeTypeY_ = other.spawnRangeTypeY_;
		initShow_ = other.initShow_;
		moveX_ = other.moveX_;
		moveY_ = other.moveY_;
		poolType_ = other.poolType_;
		itemPool_ = other.itemPool_;
		activeCond_ = other.activeCond_;
		spawnParam_ = other.spawnParam_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ThrowGiftSpawnPoints Clone()
	{
		return new ThrowGiftSpawnPoints(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ThrowGiftSpawnPoints);
	}

	[DebuggerNonUserCode]
	public bool Equals(ThrowGiftSpawnPoints other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (IsRandom != other.IsRandom)
		{
			return false;
		}
		if (!goalType_.Equals(other.goalType_))
		{
			return false;
		}
		if (SpawnRangeTypeX != other.SpawnRangeTypeX)
		{
			return false;
		}
		if (SpawnRangeTypeY != other.SpawnRangeTypeY)
		{
			return false;
		}
		if (InitShow != other.InitShow)
		{
			return false;
		}
		if (MoveX != other.MoveX)
		{
			return false;
		}
		if (MoveY != other.MoveY)
		{
			return false;
		}
		if (PoolType != other.PoolType)
		{
			return false;
		}
		if (ItemPool != other.ItemPool)
		{
			return false;
		}
		if (ActiveCond != other.ActiveCond)
		{
			return false;
		}
		if (!spawnParam_.Equals(other.spawnParam_))
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (IsRandom)
		{
			num ^= IsRandom.GetHashCode();
		}
		num ^= goalType_.GetHashCode();
		if (SpawnRangeTypeX != 0)
		{
			num ^= SpawnRangeTypeX.GetHashCode();
		}
		if (SpawnRangeTypeY != 0)
		{
			num ^= SpawnRangeTypeY.GetHashCode();
		}
		if (InitShow)
		{
			num ^= InitShow.GetHashCode();
		}
		if (MoveX != 0)
		{
			num ^= MoveX.GetHashCode();
		}
		if (MoveY != 0)
		{
			num ^= MoveY.GetHashCode();
		}
		if (PoolType)
		{
			num ^= PoolType.GetHashCode();
		}
		if (ItemPool != 0)
		{
			num ^= ItemPool.GetHashCode();
		}
		if (ActiveCond != 0)
		{
			num ^= ActiveCond.GetHashCode();
		}
		num ^= spawnParam_.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (IsRandom)
		{
			output.WriteRawTag(24);
			output.WriteBool(IsRandom);
		}
		goalType_.WriteTo(output, _repeated_goalType_codec);
		if (SpawnRangeTypeX != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SpawnRangeTypeX);
		}
		if (SpawnRangeTypeY != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SpawnRangeTypeY);
		}
		if (InitShow)
		{
			output.WriteRawTag(56);
			output.WriteBool(InitShow);
		}
		if (MoveX != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(MoveX);
		}
		if (MoveY != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(MoveY);
		}
		if (PoolType)
		{
			output.WriteRawTag(80);
			output.WriteBool(PoolType);
		}
		if (ItemPool != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ItemPool);
		}
		if (ActiveCond != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ActiveCond);
		}
		spawnParam_.WriteTo(output, _repeated_spawnParam_codec);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (IsRandom)
		{
			num += 2;
		}
		num += goalType_.CalculateSize(_repeated_goalType_codec);
		if (SpawnRangeTypeX != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnRangeTypeX);
		}
		if (SpawnRangeTypeY != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SpawnRangeTypeY);
		}
		if (InitShow)
		{
			num += 2;
		}
		if (MoveX != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MoveX);
		}
		if (MoveY != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MoveY);
		}
		if (PoolType)
		{
			num += 2;
		}
		if (ItemPool != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ItemPool);
		}
		if (ActiveCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActiveCond);
		}
		num += spawnParam_.CalculateSize(_repeated_spawnParam_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ThrowGiftSpawnPoints other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.IsRandom)
			{
				IsRandom = other.IsRandom;
			}
			goalType_.Add(other.goalType_);
			if (other.SpawnRangeTypeX != 0)
			{
				SpawnRangeTypeX = other.SpawnRangeTypeX;
			}
			if (other.SpawnRangeTypeY != 0)
			{
				SpawnRangeTypeY = other.SpawnRangeTypeY;
			}
			if (other.InitShow)
			{
				InitShow = other.InitShow;
			}
			if (other.MoveX != 0)
			{
				MoveX = other.MoveX;
			}
			if (other.MoveY != 0)
			{
				MoveY = other.MoveY;
			}
			if (other.PoolType)
			{
				PoolType = other.PoolType;
			}
			if (other.ItemPool != 0)
			{
				ItemPool = other.ItemPool;
			}
			if (other.ActiveCond != 0)
			{
				ActiveCond = other.ActiveCond;
			}
			spawnParam_.Add(other.spawnParam_);
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
				Type = input.ReadInt32();
				break;
			case 24u:
				IsRandom = input.ReadBool();
				break;
			case 32u:
			case 34u:
				goalType_.AddEntriesFrom(input, _repeated_goalType_codec);
				break;
			case 40u:
				SpawnRangeTypeX = input.ReadInt32();
				break;
			case 48u:
				SpawnRangeTypeY = input.ReadInt32();
				break;
			case 56u:
				InitShow = input.ReadBool();
				break;
			case 64u:
				MoveX = input.ReadInt32();
				break;
			case 72u:
				MoveY = input.ReadInt32();
				break;
			case 80u:
				PoolType = input.ReadBool();
				break;
			case 88u:
				ItemPool = input.ReadInt32();
				break;
			case 96u:
				ActiveCond = input.ReadInt32();
				break;
			case 104u:
			case 106u:
				spawnParam_.AddEntriesFrom(input, _repeated_spawnParam_codec);
				break;
			}
		}
	}
}
