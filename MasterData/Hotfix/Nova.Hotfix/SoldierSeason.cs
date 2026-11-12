using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierSeason : IMessage<SoldierSeason>, IMessage, IEquatable<SoldierSeason>, IDeepCloneable<SoldierSeason>
{
	private static readonly MessageParser<SoldierSeason> _parser = new MessageParser<SoldierSeason>(() => new SoldierSeason());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SeasonFieldNumber = 2;

	private int season_;

	public const int StrategyGroupIdFieldNumber = 3;

	private int strategyGroupId_;

	public const int ShopPoolGroupIdFieldNumber = 4;

	private int shopPoolGroupId_;

	public const int ChessGroupIdFieldNumber = 5;

	private int chessGroupId_;

	public const int RewardGroupIdFieldNumber = 6;

	private int rewardGroupId_;

	public const int TechPointTidFieldNumber = 7;

	private int techPointTid_;

	public const int StartTimeFieldNumber = 8;

	private string startTime_ = "";

	public const int DictionaryIdFieldNumber = 9;

	private int dictionaryId_;

	[DebuggerNonUserCode]
	public static MessageParser<SoldierSeason> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(790);

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
	public int Season
	{
		get
		{
			return season_;
		}
		set
		{
			season_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StrategyGroupId
	{
		get
		{
			return strategyGroupId_;
		}
		set
		{
			strategyGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ShopPoolGroupId
	{
		get
		{
			return shopPoolGroupId_;
		}
		set
		{
			shopPoolGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ChessGroupId
	{
		get
		{
			return chessGroupId_;
		}
		set
		{
			chessGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardGroupId
	{
		get
		{
			return rewardGroupId_;
		}
		set
		{
			rewardGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TechPointTid
	{
		get
		{
			return techPointTid_;
		}
		set
		{
			techPointTid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string StartTime
	{
		get
		{
			return startTime_;
		}
		set
		{
			startTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int DictionaryId
	{
		get
		{
			return dictionaryId_;
		}
		set
		{
			dictionaryId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public SoldierSeason()
	{
	}

	[DebuggerNonUserCode]
	public SoldierSeason(SoldierSeason other)
		: this()
	{
		id_ = other.id_;
		season_ = other.season_;
		strategyGroupId_ = other.strategyGroupId_;
		shopPoolGroupId_ = other.shopPoolGroupId_;
		chessGroupId_ = other.chessGroupId_;
		rewardGroupId_ = other.rewardGroupId_;
		techPointTid_ = other.techPointTid_;
		startTime_ = other.startTime_;
		dictionaryId_ = other.dictionaryId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierSeason Clone()
	{
		return new SoldierSeason(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierSeason);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierSeason other)
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
		if (Season != other.Season)
		{
			return false;
		}
		if (StrategyGroupId != other.StrategyGroupId)
		{
			return false;
		}
		if (ShopPoolGroupId != other.ShopPoolGroupId)
		{
			return false;
		}
		if (ChessGroupId != other.ChessGroupId)
		{
			return false;
		}
		if (RewardGroupId != other.RewardGroupId)
		{
			return false;
		}
		if (TechPointTid != other.TechPointTid)
		{
			return false;
		}
		if (StartTime != other.StartTime)
		{
			return false;
		}
		if (DictionaryId != other.DictionaryId)
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
		if (Season != 0)
		{
			num ^= Season.GetHashCode();
		}
		if (StrategyGroupId != 0)
		{
			num ^= StrategyGroupId.GetHashCode();
		}
		if (ShopPoolGroupId != 0)
		{
			num ^= ShopPoolGroupId.GetHashCode();
		}
		if (ChessGroupId != 0)
		{
			num ^= ChessGroupId.GetHashCode();
		}
		if (RewardGroupId != 0)
		{
			num ^= RewardGroupId.GetHashCode();
		}
		if (TechPointTid != 0)
		{
			num ^= TechPointTid.GetHashCode();
		}
		if (StartTime.Length != 0)
		{
			num ^= StartTime.GetHashCode();
		}
		if (DictionaryId != 0)
		{
			num ^= DictionaryId.GetHashCode();
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
		if (Season != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Season);
		}
		if (StrategyGroupId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(StrategyGroupId);
		}
		if (ShopPoolGroupId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ShopPoolGroupId);
		}
		if (ChessGroupId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ChessGroupId);
		}
		if (RewardGroupId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RewardGroupId);
		}
		if (TechPointTid != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(TechPointTid);
		}
		if (StartTime.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(StartTime);
		}
		if (DictionaryId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(DictionaryId);
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
		if (Season != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Season);
		}
		if (StrategyGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StrategyGroupId);
		}
		if (ShopPoolGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ShopPoolGroupId);
		}
		if (ChessGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChessGroupId);
		}
		if (RewardGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardGroupId);
		}
		if (TechPointTid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TechPointTid);
		}
		if (StartTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StartTime);
		}
		if (DictionaryId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DictionaryId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierSeason other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Season != 0)
			{
				Season = other.Season;
			}
			if (other.StrategyGroupId != 0)
			{
				StrategyGroupId = other.StrategyGroupId;
			}
			if (other.ShopPoolGroupId != 0)
			{
				ShopPoolGroupId = other.ShopPoolGroupId;
			}
			if (other.ChessGroupId != 0)
			{
				ChessGroupId = other.ChessGroupId;
			}
			if (other.RewardGroupId != 0)
			{
				RewardGroupId = other.RewardGroupId;
			}
			if (other.TechPointTid != 0)
			{
				TechPointTid = other.TechPointTid;
			}
			if (other.StartTime.Length != 0)
			{
				StartTime = other.StartTime;
			}
			if (other.DictionaryId != 0)
			{
				DictionaryId = other.DictionaryId;
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
				Season = input.ReadInt32();
				break;
			case 24u:
				StrategyGroupId = input.ReadInt32();
				break;
			case 32u:
				ShopPoolGroupId = input.ReadInt32();
				break;
			case 40u:
				ChessGroupId = input.ReadInt32();
				break;
			case 48u:
				RewardGroupId = input.ReadInt32();
				break;
			case 56u:
				TechPointTid = input.ReadInt32();
				break;
			case 66u:
				StartTime = input.ReadString();
				break;
			case 72u:
				DictionaryId = input.ReadInt32();
				break;
			}
		}
	}
}
