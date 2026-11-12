using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTowerLevel : IMessage<InfinityTowerLevel>, IMessage, IEquatable<InfinityTowerLevel>, IDeepCloneable<InfinityTowerLevel>
{
	private static readonly MessageParser<InfinityTowerLevel> _parser = new MessageParser<InfinityTowerLevel>(() => new InfinityTowerLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DifficultyIdFieldNumber = 3;

	private int difficultyId_;

	public const int LevelTypeFieldNumber = 4;

	private int levelType_;

	public const int FloorFieldNumber = 5;

	private int floor_;

	public const int FloorIdFieldNumber = 6;

	private int floorId_;

	public const int PreLevelIdFieldNumber = 7;

	private int preLevelId_;

	public const int EntryCondFieldNumber = 8;

	private int entryCond_;

	public const int EntryCondParamFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_entryCondParam_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> entryCondParam_ = new RepeatedField<int>();

	public const int AwardDropIdFieldNumber = 10;

	private int awardDropId_;

	public const int RecommendLvFieldNumber = 11;

	private int recommendLv_;

	public const int RecommendBuildRankFieldNumber = 12;

	private int recommendBuildRank_;

	public const int BaseAwardPreviewFieldNumber = 13;

	private string baseAwardPreview_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTowerLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(456);

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
	public int DifficultyId
	{
		get
		{
			return difficultyId_;
		}
		set
		{
			difficultyId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelType
	{
		get
		{
			return levelType_;
		}
		set
		{
			levelType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Floor
	{
		get
		{
			return floor_;
		}
		set
		{
			floor_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelId
	{
		get
		{
			return preLevelId_;
		}
		set
		{
			preLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EntryCond
	{
		get
		{
			return entryCond_;
		}
		set
		{
			entryCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EntryCondParam => entryCondParam_;

	[DebuggerNonUserCode]
	public int AwardDropId
	{
		get
		{
			return awardDropId_;
		}
		set
		{
			awardDropId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RecommendLv
	{
		get
		{
			return recommendLv_;
		}
		set
		{
			recommendLv_ = value;
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
	public string BaseAwardPreview
	{
		get
		{
			return baseAwardPreview_;
		}
		set
		{
			baseAwardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public InfinityTowerLevel()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTowerLevel(InfinityTowerLevel other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		difficultyId_ = other.difficultyId_;
		levelType_ = other.levelType_;
		floor_ = other.floor_;
		floorId_ = other.floorId_;
		preLevelId_ = other.preLevelId_;
		entryCond_ = other.entryCond_;
		entryCondParam_ = other.entryCondParam_.Clone();
		awardDropId_ = other.awardDropId_;
		recommendLv_ = other.recommendLv_;
		recommendBuildRank_ = other.recommendBuildRank_;
		baseAwardPreview_ = other.baseAwardPreview_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTowerLevel Clone()
	{
		return new InfinityTowerLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTowerLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTowerLevel other)
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
		if (DifficultyId != other.DifficultyId)
		{
			return false;
		}
		if (LevelType != other.LevelType)
		{
			return false;
		}
		if (Floor != other.Floor)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (EntryCond != other.EntryCond)
		{
			return false;
		}
		if (!entryCondParam_.Equals(other.entryCondParam_))
		{
			return false;
		}
		if (AwardDropId != other.AwardDropId)
		{
			return false;
		}
		if (RecommendLv != other.RecommendLv)
		{
			return false;
		}
		if (RecommendBuildRank != other.RecommendBuildRank)
		{
			return false;
		}
		if (BaseAwardPreview != other.BaseAwardPreview)
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
		if (DifficultyId != 0)
		{
			num ^= DifficultyId.GetHashCode();
		}
		if (LevelType != 0)
		{
			num ^= LevelType.GetHashCode();
		}
		if (Floor != 0)
		{
			num ^= Floor.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (EntryCond != 0)
		{
			num ^= EntryCond.GetHashCode();
		}
		num ^= entryCondParam_.GetHashCode();
		if (AwardDropId != 0)
		{
			num ^= AwardDropId.GetHashCode();
		}
		if (RecommendLv != 0)
		{
			num ^= RecommendLv.GetHashCode();
		}
		if (RecommendBuildRank != 0)
		{
			num ^= RecommendBuildRank.GetHashCode();
		}
		if (BaseAwardPreview.Length != 0)
		{
			num ^= BaseAwardPreview.GetHashCode();
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
		if (DifficultyId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DifficultyId);
		}
		if (LevelType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(LevelType);
		}
		if (Floor != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Floor);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(FloorId);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(PreLevelId);
		}
		if (EntryCond != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(EntryCond);
		}
		entryCondParam_.WriteTo(output, _repeated_entryCondParam_codec);
		if (AwardDropId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(AwardDropId);
		}
		if (RecommendLv != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(RecommendLv);
		}
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(RecommendBuildRank);
		}
		if (BaseAwardPreview.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(BaseAwardPreview);
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
		if (DifficultyId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DifficultyId);
		}
		if (LevelType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelType);
		}
		if (Floor != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Floor);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (EntryCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EntryCond);
		}
		num += entryCondParam_.CalculateSize(_repeated_entryCondParam_codec);
		if (AwardDropId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardDropId);
		}
		if (RecommendLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendLv);
		}
		if (RecommendBuildRank != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendBuildRank);
		}
		if (BaseAwardPreview.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BaseAwardPreview);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InfinityTowerLevel other)
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
			if (other.DifficultyId != 0)
			{
				DifficultyId = other.DifficultyId;
			}
			if (other.LevelType != 0)
			{
				LevelType = other.LevelType;
			}
			if (other.Floor != 0)
			{
				Floor = other.Floor;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.EntryCond != 0)
			{
				EntryCond = other.EntryCond;
			}
			entryCondParam_.Add(other.entryCondParam_);
			if (other.AwardDropId != 0)
			{
				AwardDropId = other.AwardDropId;
			}
			if (other.RecommendLv != 0)
			{
				RecommendLv = other.RecommendLv;
			}
			if (other.RecommendBuildRank != 0)
			{
				RecommendBuildRank = other.RecommendBuildRank;
			}
			if (other.BaseAwardPreview.Length != 0)
			{
				BaseAwardPreview = other.BaseAwardPreview;
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
				DifficultyId = input.ReadInt32();
				break;
			case 32u:
				LevelType = input.ReadInt32();
				break;
			case 40u:
				Floor = input.ReadInt32();
				break;
			case 48u:
				FloorId = input.ReadInt32();
				break;
			case 56u:
				PreLevelId = input.ReadInt32();
				break;
			case 64u:
				EntryCond = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				entryCondParam_.AddEntriesFrom(input, _repeated_entryCondParam_codec);
				break;
			case 80u:
				AwardDropId = input.ReadInt32();
				break;
			case 88u:
				RecommendLv = input.ReadInt32();
				break;
			case 96u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 106u:
				BaseAwardPreview = input.ReadString();
				break;
			}
		}
	}
}
