using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTowerDifficulty : IMessage<InfinityTowerDifficulty>, IMessage, IEquatable<InfinityTowerDifficulty>, IDeepCloneable<InfinityTowerDifficulty>
{
	private static readonly MessageParser<InfinityTowerDifficulty> _parser = new MessageParser<InfinityTowerDifficulty>(() => new InfinityTowerDifficulty());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int TowerIdFieldNumber = 3;

	private int towerId_;

	public const int UnlockWorldClassFieldNumber = 4;

	private int unlockWorldClass_;

	public const int UnlockTipsFieldNumber = 5;

	private string unlockTips_ = "";

	public const int IsChallengeFieldNumber = 6;

	private bool isChallenge_;

	public const int RecommendLevelFieldNumber = 7;

	private int recommendLevel_;

	public const int RecommendBuildRankFieldNumber = 8;

	private int recommendBuildRank_;

	public const int SortFieldNumber = 9;

	private int sort_;

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTowerDifficulty> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(450);

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
	public int TowerId
	{
		get
		{
			return towerId_;
		}
		set
		{
			towerId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockWorldClass
	{
		get
		{
			return unlockWorldClass_;
		}
		set
		{
			unlockWorldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string UnlockTips
	{
		get
		{
			return unlockTips_;
		}
		set
		{
			unlockTips_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsChallenge
	{
		get
		{
			return isChallenge_;
		}
		set
		{
			isChallenge_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecommendLevel
	{
		get
		{
			return recommendLevel_;
		}
		set
		{
			recommendLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecommendBuildRank
	{
		get
		{
			return recommendBuildRank_;
		}
		set
		{
			recommendBuildRank_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public InfinityTowerDifficulty()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTowerDifficulty(InfinityTowerDifficulty other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		towerId_ = other.towerId_;
		unlockWorldClass_ = other.unlockWorldClass_;
		unlockTips_ = other.unlockTips_;
		isChallenge_ = other.isChallenge_;
		recommendLevel_ = other.recommendLevel_;
		recommendBuildRank_ = other.recommendBuildRank_;
		sort_ = other.sort_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTowerDifficulty Clone()
	{
		return new InfinityTowerDifficulty(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTowerDifficulty);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTowerDifficulty other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (TowerId != other.TowerId)
		{
			return false;
		}
		if (UnlockWorldClass != other.UnlockWorldClass)
		{
			return false;
		}
		if (UnlockTips != other.UnlockTips)
		{
			return false;
		}
		if (IsChallenge != other.IsChallenge)
		{
			return false;
		}
		if (RecommendLevel != other.RecommendLevel)
		{
			return false;
		}
		if (RecommendBuildRank != other.RecommendBuildRank)
		{
			return false;
		}
		if (Sort != other.Sort)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (TowerId != 0)
		{
			num ^= TowerId.GetHashCode();
		}
		if (UnlockWorldClass != 0)
		{
			num ^= UnlockWorldClass.GetHashCode();
		}
		if (UnlockTips.Length != 0)
		{
			num ^= UnlockTips.GetHashCode();
		}
		if (IsChallenge)
		{
			num ^= IsChallenge.GetHashCode();
		}
		if (RecommendLevel != 0)
		{
			num ^= RecommendLevel.GetHashCode();
		}
		if (RecommendBuildRank != 0)
		{
			num ^= RecommendBuildRank.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (TowerId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TowerId);
		}
		if (UnlockWorldClass != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(UnlockWorldClass);
		}
		if (UnlockTips.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(UnlockTips);
		}
		if (IsChallenge)
		{
			output.WriteRawTag(48);
			output.WriteBool(IsChallenge);
		}
		if (RecommendLevel != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RecommendLevel);
		}
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(RecommendBuildRank);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Sort);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (TowerId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TowerId);
		}
		if (UnlockWorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockWorldClass);
		}
		if (UnlockTips.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UnlockTips);
		}
		if (IsChallenge)
		{
			num += 2;
		}
		if (RecommendLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendLevel);
		}
		if (RecommendBuildRank != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendBuildRank);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InfinityTowerDifficulty other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.TowerId != 0)
			{
				TowerId = other.TowerId;
			}
			if (other.UnlockWorldClass != 0)
			{
				UnlockWorldClass = other.UnlockWorldClass;
			}
			if (other.UnlockTips.Length != 0)
			{
				UnlockTips = other.UnlockTips;
			}
			if (other.IsChallenge)
			{
				IsChallenge = other.IsChallenge;
			}
			if (other.RecommendLevel != 0)
			{
				RecommendLevel = other.RecommendLevel;
			}
			if (other.RecommendBuildRank != 0)
			{
				RecommendBuildRank = other.RecommendBuildRank;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
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
				Name = input.ReadString();
				break;
			case 24u:
				TowerId = input.ReadInt32();
				break;
			case 32u:
				UnlockWorldClass = input.ReadInt32();
				break;
			case 42u:
				UnlockTips = input.ReadString();
				break;
			case 48u:
				IsChallenge = input.ReadBool();
				break;
			case 56u:
				RecommendLevel = input.ReadInt32();
				break;
			case 64u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 72u:
				Sort = input.ReadInt32();
				break;
			}
		}
	}
}
