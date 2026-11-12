using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DailyInstance : IMessage<DailyInstance>, IMessage, IEquatable<DailyInstance>, IDeepCloneable<DailyInstance>
{
	private static readonly MessageParser<DailyInstance> _parser = new MessageParser<DailyInstance>(() => new DailyInstance());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int DailyTypeFieldNumber = 2;

	private int dailyType_;

	public const int DifficultyFieldNumber = 3;

	private int difficulty_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int DescFieldNumber = 5;

	private string desc_ = "";

	public const int SuggestedPowerFieldNumber = 6;

	private int suggestedPower_;

	public const int RecommendBuildRankFieldNumber = 7;

	private int recommendBuildRank_;

	public const int PreLevelIdFieldNumber = 8;

	private int preLevelId_;

	public const int PreLevelStarFieldNumber = 9;

	private int preLevelStar_;

	public const int NeedWorldClassFieldNumber = 10;

	private int needWorldClass_;

	public const int FloorIdFieldNumber = 11;

	private int floorId_;

	public const int OneStarDescFieldNumber = 12;

	private string oneStarDesc_ = "";

	public const int TwoStarDescFieldNumber = 13;

	private string twoStarDesc_ = "";

	public const int ThreeStarDescFieldNumber = 14;

	private string threeStarDesc_ = "";

	public const int OneStarEnergyConsumeFieldNumber = 15;

	private int oneStarEnergyConsume_;

	public const int TwoStarEnergyConsumeFieldNumber = 16;

	private int twoStarEnergyConsume_;

	public const int ThreeStarEnergyConsumeFieldNumber = 17;

	private int threeStarEnergyConsume_;

	public const int AwardDropIdFieldNumber = 18;

	private int awardDropId_;

	public const int PreviewMonsterGroupIdFieldNumber = 19;

	private int previewMonsterGroupId_;

	public const int IconFieldNumber = 20;

	private string icon_ = "";

	public const int FirstRewardPreviewFieldNumber = 21;

	private static readonly FieldCodec<int> _repeated_firstRewardPreview_codec = FieldCodec.ForInt32(170u);

	private readonly RepeatedField<int> firstRewardPreview_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<DailyInstance> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(228);

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
	public int DailyType
	{
		get
		{
			return dailyType_;
		}
		set
		{
			dailyType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Difficulty
	{
		get
		{
			return difficulty_;
		}
		set
		{
			difficulty_ = value;
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
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SuggestedPower
	{
		get
		{
			return suggestedPower_;
		}
		set
		{
			suggestedPower_ = value;
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
	public int PreLevelStar
	{
		get
		{
			return preLevelStar_;
		}
		set
		{
			preLevelStar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedWorldClass
	{
		get
		{
			return needWorldClass_;
		}
		set
		{
			needWorldClass_ = value;
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
	public string OneStarDesc
	{
		get
		{
			return oneStarDesc_;
		}
		set
		{
			oneStarDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string TwoStarDesc
	{
		get
		{
			return twoStarDesc_;
		}
		set
		{
			twoStarDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ThreeStarDesc
	{
		get
		{
			return threeStarDesc_;
		}
		set
		{
			threeStarDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int OneStarEnergyConsume
	{
		get
		{
			return oneStarEnergyConsume_;
		}
		set
		{
			oneStarEnergyConsume_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TwoStarEnergyConsume
	{
		get
		{
			return twoStarEnergyConsume_;
		}
		set
		{
			twoStarEnergyConsume_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ThreeStarEnergyConsume
	{
		get
		{
			return threeStarEnergyConsume_;
		}
		set
		{
			threeStarEnergyConsume_ = value;
		}
	}

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
	public int PreviewMonsterGroupId
	{
		get
		{
			return previewMonsterGroupId_;
		}
		set
		{
			previewMonsterGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> FirstRewardPreview => firstRewardPreview_;

	[DebuggerNonUserCode]
	public DailyInstance()
	{
	}

	[DebuggerNonUserCode]
	public DailyInstance(DailyInstance other)
		: this()
	{
		id_ = other.id_;
		dailyType_ = other.dailyType_;
		difficulty_ = other.difficulty_;
		name_ = other.name_;
		desc_ = other.desc_;
		suggestedPower_ = other.suggestedPower_;
		recommendBuildRank_ = other.recommendBuildRank_;
		preLevelId_ = other.preLevelId_;
		preLevelStar_ = other.preLevelStar_;
		needWorldClass_ = other.needWorldClass_;
		floorId_ = other.floorId_;
		oneStarDesc_ = other.oneStarDesc_;
		twoStarDesc_ = other.twoStarDesc_;
		threeStarDesc_ = other.threeStarDesc_;
		oneStarEnergyConsume_ = other.oneStarEnergyConsume_;
		twoStarEnergyConsume_ = other.twoStarEnergyConsume_;
		threeStarEnergyConsume_ = other.threeStarEnergyConsume_;
		awardDropId_ = other.awardDropId_;
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		icon_ = other.icon_;
		firstRewardPreview_ = other.firstRewardPreview_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DailyInstance Clone()
	{
		return new DailyInstance(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DailyInstance);
	}

	[DebuggerNonUserCode]
	public bool Equals(DailyInstance other)
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
		if (DailyType != other.DailyType)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (SuggestedPower != other.SuggestedPower)
		{
			return false;
		}
		if (RecommendBuildRank != other.RecommendBuildRank)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (PreLevelStar != other.PreLevelStar)
		{
			return false;
		}
		if (NeedWorldClass != other.NeedWorldClass)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (OneStarDesc != other.OneStarDesc)
		{
			return false;
		}
		if (TwoStarDesc != other.TwoStarDesc)
		{
			return false;
		}
		if (ThreeStarDesc != other.ThreeStarDesc)
		{
			return false;
		}
		if (OneStarEnergyConsume != other.OneStarEnergyConsume)
		{
			return false;
		}
		if (TwoStarEnergyConsume != other.TwoStarEnergyConsume)
		{
			return false;
		}
		if (ThreeStarEnergyConsume != other.ThreeStarEnergyConsume)
		{
			return false;
		}
		if (AwardDropId != other.AwardDropId)
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (!firstRewardPreview_.Equals(other.firstRewardPreview_))
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
		if (DailyType != 0)
		{
			num ^= DailyType.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (SuggestedPower != 0)
		{
			num ^= SuggestedPower.GetHashCode();
		}
		if (RecommendBuildRank != 0)
		{
			num ^= RecommendBuildRank.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (PreLevelStar != 0)
		{
			num ^= PreLevelStar.GetHashCode();
		}
		if (NeedWorldClass != 0)
		{
			num ^= NeedWorldClass.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (OneStarDesc.Length != 0)
		{
			num ^= OneStarDesc.GetHashCode();
		}
		if (TwoStarDesc.Length != 0)
		{
			num ^= TwoStarDesc.GetHashCode();
		}
		if (ThreeStarDesc.Length != 0)
		{
			num ^= ThreeStarDesc.GetHashCode();
		}
		if (OneStarEnergyConsume != 0)
		{
			num ^= OneStarEnergyConsume.GetHashCode();
		}
		if (TwoStarEnergyConsume != 0)
		{
			num ^= TwoStarEnergyConsume.GetHashCode();
		}
		if (ThreeStarEnergyConsume != 0)
		{
			num ^= ThreeStarEnergyConsume.GetHashCode();
		}
		if (AwardDropId != 0)
		{
			num ^= AwardDropId.GetHashCode();
		}
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		num ^= firstRewardPreview_.GetHashCode();
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
		if (DailyType != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(DailyType);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Difficulty);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Desc);
		}
		if (SuggestedPower != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(SuggestedPower);
		}
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(RecommendBuildRank);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PreLevelId);
		}
		if (PreLevelStar != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PreLevelStar);
		}
		if (NeedWorldClass != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(NeedWorldClass);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(FloorId);
		}
		if (OneStarDesc.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(OneStarDesc);
		}
		if (TwoStarDesc.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(TwoStarDesc);
		}
		if (ThreeStarDesc.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(ThreeStarDesc);
		}
		if (OneStarEnergyConsume != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(OneStarEnergyConsume);
		}
		if (TwoStarEnergyConsume != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(TwoStarEnergyConsume);
		}
		if (ThreeStarEnergyConsume != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ThreeStarEnergyConsume);
		}
		if (AwardDropId != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(AwardDropId);
		}
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Icon);
		}
		firstRewardPreview_.WriteTo(output, _repeated_firstRewardPreview_codec);
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
		if (DailyType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DailyType);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (SuggestedPower != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuggestedPower);
		}
		if (RecommendBuildRank != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendBuildRank);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (PreLevelStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelStar);
		}
		if (NeedWorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedWorldClass);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (OneStarDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OneStarDesc);
		}
		if (TwoStarDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TwoStarDesc);
		}
		if (ThreeStarDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ThreeStarDesc);
		}
		if (OneStarEnergyConsume != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OneStarEnergyConsume);
		}
		if (TwoStarEnergyConsume != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TwoStarEnergyConsume);
		}
		if (ThreeStarEnergyConsume != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ThreeStarEnergyConsume);
		}
		if (AwardDropId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AwardDropId);
		}
		if (PreviewMonsterGroupId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		num += firstRewardPreview_.CalculateSize(_repeated_firstRewardPreview_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DailyInstance other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.DailyType != 0)
			{
				DailyType = other.DailyType;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.SuggestedPower != 0)
			{
				SuggestedPower = other.SuggestedPower;
			}
			if (other.RecommendBuildRank != 0)
			{
				RecommendBuildRank = other.RecommendBuildRank;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.PreLevelStar != 0)
			{
				PreLevelStar = other.PreLevelStar;
			}
			if (other.NeedWorldClass != 0)
			{
				NeedWorldClass = other.NeedWorldClass;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.OneStarDesc.Length != 0)
			{
				OneStarDesc = other.OneStarDesc;
			}
			if (other.TwoStarDesc.Length != 0)
			{
				TwoStarDesc = other.TwoStarDesc;
			}
			if (other.ThreeStarDesc.Length != 0)
			{
				ThreeStarDesc = other.ThreeStarDesc;
			}
			if (other.OneStarEnergyConsume != 0)
			{
				OneStarEnergyConsume = other.OneStarEnergyConsume;
			}
			if (other.TwoStarEnergyConsume != 0)
			{
				TwoStarEnergyConsume = other.TwoStarEnergyConsume;
			}
			if (other.ThreeStarEnergyConsume != 0)
			{
				ThreeStarEnergyConsume = other.ThreeStarEnergyConsume;
			}
			if (other.AwardDropId != 0)
			{
				AwardDropId = other.AwardDropId;
			}
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			firstRewardPreview_.Add(other.firstRewardPreview_);
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
				DailyType = input.ReadInt32();
				break;
			case 24u:
				Difficulty = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				Desc = input.ReadString();
				break;
			case 48u:
				SuggestedPower = input.ReadInt32();
				break;
			case 56u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 64u:
				PreLevelId = input.ReadInt32();
				break;
			case 72u:
				PreLevelStar = input.ReadInt32();
				break;
			case 80u:
				NeedWorldClass = input.ReadInt32();
				break;
			case 88u:
				FloorId = input.ReadInt32();
				break;
			case 98u:
				OneStarDesc = input.ReadString();
				break;
			case 106u:
				TwoStarDesc = input.ReadString();
				break;
			case 114u:
				ThreeStarDesc = input.ReadString();
				break;
			case 120u:
				OneStarEnergyConsume = input.ReadInt32();
				break;
			case 128u:
				TwoStarEnergyConsume = input.ReadInt32();
				break;
			case 136u:
				ThreeStarEnergyConsume = input.ReadInt32();
				break;
			case 144u:
				AwardDropId = input.ReadInt32();
				break;
			case 152u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 162u:
				Icon = input.ReadString();
				break;
			case 168u:
			case 170u:
				firstRewardPreview_.AddEntriesFrom(input, _repeated_firstRewardPreview_codec);
				break;
			}
		}
	}
}
