using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierEventBattlePool : IMessage<SoldierEventBattlePool>, IMessage, IEquatable<SoldierEventBattlePool>, IDeepCloneable<SoldierEventBattlePool>
{
	private static readonly MessageParser<SoldierEventBattlePool> _parser = new MessageParser<SoldierEventBattlePool>(() => new SoldierEventBattlePool());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int PoolIdFieldNumber = 2;

	private int poolId_;

	public const int LevelNameFieldNumber = 3;

	private int levelName_;

	public const int TitleFieldNumber = 4;

	private string title_ = "";

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int AddDifficultFieldNumber = 6;

	private int addDifficult_;

	public const int WeightFieldNumber = 7;

	private int weight_;

	public const int FloorGroupFieldNumber = 8;

	private int floorGroup_;

	public const int CoinFieldNumber = 9;

	private int coin_;

	public const int CharacterCountFieldNumber = 10;

	private int characterCount_;

	public const int StrategyCardCountFieldNumber = 11;

	private int strategyCardCount_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierEventBattlePool> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(758);

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
	public int LevelName
	{
		get
		{
			return levelName_;
		}
		set
		{
			levelName_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Name
	{
		get
		{
			return name_;
		}
		set
		{
			name_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int AddDifficult
	{
		get
		{
			return addDifficult_;
		}
		set
		{
			addDifficult_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorGroup
	{
		get
		{
			return floorGroup_;
		}
		set
		{
			floorGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Coin
	{
		get
		{
			return coin_;
		}
		set
		{
			coin_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharacterCount
	{
		get
		{
			return characterCount_;
		}
		set
		{
			characterCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StrategyCardCount
	{
		get
		{
			return strategyCardCount_;
		}
		set
		{
			strategyCardCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierEventBattlePool()
	{
	}

	[DebuggerNonUserCode]
	public SoldierEventBattlePool(SoldierEventBattlePool other)
		: this()
	{
		id_ = other.id_;
		poolId_ = other.poolId_;
		levelName_ = other.levelName_;
		title_ = other.title_;
		name_ = other.name_;
		addDifficult_ = other.addDifficult_;
		weight_ = other.weight_;
		floorGroup_ = other.floorGroup_;
		coin_ = other.coin_;
		characterCount_ = other.characterCount_;
		strategyCardCount_ = other.strategyCardCount_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierEventBattlePool Clone()
	{
		return new SoldierEventBattlePool(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierEventBattlePool);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierEventBattlePool other)
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
		if (PoolId != other.PoolId)
		{
			return false;
		}
		if (LevelName != other.LevelName)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (AddDifficult != other.AddDifficult)
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (FloorGroup != other.FloorGroup)
		{
			return false;
		}
		if (Coin != other.Coin)
		{
			return false;
		}
		if (CharacterCount != other.CharacterCount)
		{
			return false;
		}
		if (StrategyCardCount != other.StrategyCardCount)
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
		if (PoolId != 0)
		{
			num ^= PoolId.GetHashCode();
		}
		if (LevelName != 0)
		{
			num ^= LevelName.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (AddDifficult != 0)
		{
			num ^= AddDifficult.GetHashCode();
		}
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		if (FloorGroup != 0)
		{
			num ^= FloorGroup.GetHashCode();
		}
		if (Coin != 0)
		{
			num ^= Coin.GetHashCode();
		}
		if (CharacterCount != 0)
		{
			num ^= CharacterCount.GetHashCode();
		}
		if (StrategyCardCount != 0)
		{
			num ^= StrategyCardCount.GetHashCode();
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
		if (PoolId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(PoolId);
		}
		if (LevelName != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(LevelName);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Title);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (AddDifficult != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AddDifficult);
		}
		if (Weight != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Weight);
		}
		if (FloorGroup != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(FloorGroup);
		}
		if (Coin != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Coin);
		}
		if (CharacterCount != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(CharacterCount);
		}
		if (StrategyCardCount != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(StrategyCardCount);
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
		if (PoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PoolId);
		}
		if (LevelName != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelName);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (AddDifficult != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AddDifficult);
		}
		if (Weight != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		if (FloorGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorGroup);
		}
		if (Coin != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Coin);
		}
		if (CharacterCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterCount);
		}
		if (StrategyCardCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StrategyCardCount);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierEventBattlePool other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.PoolId != 0)
			{
				PoolId = other.PoolId;
			}
			if (other.LevelName != 0)
			{
				LevelName = other.LevelName;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.AddDifficult != 0)
			{
				AddDifficult = other.AddDifficult;
			}
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			if (other.FloorGroup != 0)
			{
				FloorGroup = other.FloorGroup;
			}
			if (other.Coin != 0)
			{
				Coin = other.Coin;
			}
			if (other.CharacterCount != 0)
			{
				CharacterCount = other.CharacterCount;
			}
			if (other.StrategyCardCount != 0)
			{
				StrategyCardCount = other.StrategyCardCount;
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
				PoolId = input.ReadInt32();
				break;
			case 24u:
				LevelName = input.ReadInt32();
				break;
			case 34u:
				Title = input.ReadString();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 48u:
				AddDifficult = input.ReadInt32();
				break;
			case 56u:
				Weight = input.ReadInt32();
				break;
			case 64u:
				FloorGroup = input.ReadInt32();
				break;
			case 72u:
				Coin = input.ReadInt32();
				break;
			case 80u:
				CharacterCount = input.ReadInt32();
				break;
			case 88u:
				StrategyCardCount = input.ReadInt32();
				break;
			}
		}
	}
}
