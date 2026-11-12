using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityLevelsLevel : IMessage<ActivityLevelsLevel>, IMessage, IEquatable<ActivityLevelsLevel>, IDeepCloneable<ActivityLevelsLevel>
{
	private static readonly MessageParser<ActivityLevelsLevel> _parser = new MessageParser<ActivityLevelsLevel>(() => new ActivityLevelsLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int DayOpenFieldNumber = 3;

	private int dayOpen_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int IconResFieldNumber = 5;

	private string iconRes_ = "";

	public const int TypeFieldNumber = 6;

	private int type_;

	public const int DifficultyFieldNumber = 7;

	private int difficulty_;

	public const int EnergyConsumeFieldNumber = 8;

	private int energyConsume_;

	public const int EnergyConsumeOnRetryFieldNumber = 9;

	private bool energyConsumeOnRetry_;

	public const int PreLevelIdFieldNumber = 10;

	private int preLevelId_;

	public const int PreLevelStarFieldNumber = 11;

	private int preLevelStar_;

	public const int PreActivityStoryFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_preActivityStory_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> preActivityStory_ = new RepeatedField<int>();

	public const int FloorIdFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_floorId_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> floorId_ = new RepeatedField<int>();

	public const int PreviewMonsterGroupIdFieldNumber = 14;

	private int previewMonsterGroupId_;

	public const int EETFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	public const int RecommendBuildRankFieldNumber = 16;

	private int recommendBuildRank_;

	public const int SuggestedPowerFieldNumber = 17;

	private int suggestedPower_;

	public const int StarConditionTypeFieldNumber = 18;

	private int starConditionType_;

	public const int OneStarConditionFieldNumber = 19;

	private static readonly FieldCodec<int> _repeated_oneStarCondition_codec = FieldCodec.ForInt32(154u);

	private readonly RepeatedField<int> oneStarCondition_ = new RepeatedField<int>();

	public const int TwoStarConditionFieldNumber = 20;

	private static readonly FieldCodec<int> _repeated_twoStarCondition_codec = FieldCodec.ForInt32(162u);

	private readonly RepeatedField<int> twoStarCondition_ = new RepeatedField<int>();

	public const int ThreeStarConditionFieldNumber = 21;

	private static readonly FieldCodec<int> _repeated_threeStarCondition_codec = FieldCodec.ForInt32(170u);

	private readonly RepeatedField<int> threeStarCondition_ = new RepeatedField<int>();

	public const int OneStarDescFieldNumber = 22;

	private string oneStarDesc_ = "";

	public const int TwoStarDescFieldNumber = 23;

	private string twoStarDesc_ = "";

	public const int ThreeStarDescFieldNumber = 24;

	private string threeStarDesc_ = "";

	public const int DescFieldNumber = 25;

	private string desc_ = "";

	public const int CompleteRewardPreviewFieldNumber = 26;

	private string completeRewardPreview_ = "";

	public const int ThreeStarSweepFieldNumber = 27;

	private bool threeStarSweep_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityLevelsLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(22);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DayOpen
	{
		get
		{
			return dayOpen_;
		}
		set
		{
			dayOpen_ = value;
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
	public string IconRes
	{
		get
		{
			return iconRes_;
		}
		set
		{
			iconRes_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int EnergyConsume
	{
		get
		{
			return energyConsume_;
		}
		set
		{
			energyConsume_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool EnergyConsumeOnRetry
	{
		get
		{
			return energyConsumeOnRetry_;
		}
		set
		{
			energyConsumeOnRetry_ = value;
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
	public RepeatedField<int> PreActivityStory => preActivityStory_;

	[DebuggerNonUserCode]
	public RepeatedField<int> FloorId => floorId_;

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
	public RepeatedField<int> EET => eET_;

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
	public int StarConditionType
	{
		get
		{
			return starConditionType_;
		}
		set
		{
			starConditionType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> OneStarCondition => oneStarCondition_;

	[DebuggerNonUserCode]
	public RepeatedField<int> TwoStarCondition => twoStarCondition_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ThreeStarCondition => threeStarCondition_;

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
	public string CompleteRewardPreview
	{
		get
		{
			return completeRewardPreview_;
		}
		set
		{
			completeRewardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool ThreeStarSweep
	{
		get
		{
			return threeStarSweep_;
		}
		set
		{
			threeStarSweep_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityLevelsLevel()
	{
	}

	[DebuggerNonUserCode]
	public ActivityLevelsLevel(ActivityLevelsLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		dayOpen_ = other.dayOpen_;
		name_ = other.name_;
		iconRes_ = other.iconRes_;
		type_ = other.type_;
		difficulty_ = other.difficulty_;
		energyConsume_ = other.energyConsume_;
		energyConsumeOnRetry_ = other.energyConsumeOnRetry_;
		preLevelId_ = other.preLevelId_;
		preLevelStar_ = other.preLevelStar_;
		preActivityStory_ = other.preActivityStory_.Clone();
		floorId_ = other.floorId_.Clone();
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		eET_ = other.eET_.Clone();
		recommendBuildRank_ = other.recommendBuildRank_;
		suggestedPower_ = other.suggestedPower_;
		starConditionType_ = other.starConditionType_;
		oneStarCondition_ = other.oneStarCondition_.Clone();
		twoStarCondition_ = other.twoStarCondition_.Clone();
		threeStarCondition_ = other.threeStarCondition_.Clone();
		oneStarDesc_ = other.oneStarDesc_;
		twoStarDesc_ = other.twoStarDesc_;
		threeStarDesc_ = other.threeStarDesc_;
		desc_ = other.desc_;
		completeRewardPreview_ = other.completeRewardPreview_;
		threeStarSweep_ = other.threeStarSweep_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityLevelsLevel Clone()
	{
		return new ActivityLevelsLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityLevelsLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityLevelsLevel other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (DayOpen != other.DayOpen)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (IconRes != other.IconRes)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (EnergyConsume != other.EnergyConsume)
		{
			return false;
		}
		if (EnergyConsumeOnRetry != other.EnergyConsumeOnRetry)
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
		if (!preActivityStory_.Equals(other.preActivityStory_))
		{
			return false;
		}
		if (!floorId_.Equals(other.floorId_))
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (!eET_.Equals(other.eET_))
		{
			return false;
		}
		if (RecommendBuildRank != other.RecommendBuildRank)
		{
			return false;
		}
		if (SuggestedPower != other.SuggestedPower)
		{
			return false;
		}
		if (StarConditionType != other.StarConditionType)
		{
			return false;
		}
		if (!oneStarCondition_.Equals(other.oneStarCondition_))
		{
			return false;
		}
		if (!twoStarCondition_.Equals(other.twoStarCondition_))
		{
			return false;
		}
		if (!threeStarCondition_.Equals(other.threeStarCondition_))
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (CompleteRewardPreview != other.CompleteRewardPreview)
		{
			return false;
		}
		if (ThreeStarSweep != other.ThreeStarSweep)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (DayOpen != 0)
		{
			num ^= DayOpen.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (IconRes.Length != 0)
		{
			num ^= IconRes.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (EnergyConsume != 0)
		{
			num ^= EnergyConsume.GetHashCode();
		}
		if (EnergyConsumeOnRetry)
		{
			num ^= EnergyConsumeOnRetry.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (PreLevelStar != 0)
		{
			num ^= PreLevelStar.GetHashCode();
		}
		num ^= preActivityStory_.GetHashCode();
		num ^= floorId_.GetHashCode();
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		num ^= eET_.GetHashCode();
		if (RecommendBuildRank != 0)
		{
			num ^= RecommendBuildRank.GetHashCode();
		}
		if (SuggestedPower != 0)
		{
			num ^= SuggestedPower.GetHashCode();
		}
		if (StarConditionType != 0)
		{
			num ^= StarConditionType.GetHashCode();
		}
		num ^= oneStarCondition_.GetHashCode();
		num ^= twoStarCondition_.GetHashCode();
		num ^= threeStarCondition_.GetHashCode();
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (CompleteRewardPreview.Length != 0)
		{
			num ^= CompleteRewardPreview.GetHashCode();
		}
		if (ThreeStarSweep)
		{
			num ^= ThreeStarSweep.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (DayOpen != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DayOpen);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (IconRes.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(IconRes);
		}
		if (Type != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Type);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Difficulty);
		}
		if (EnergyConsume != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(EnergyConsume);
		}
		if (EnergyConsumeOnRetry)
		{
			output.WriteRawTag(72);
			output.WriteBool(EnergyConsumeOnRetry);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PreLevelId);
		}
		if (PreLevelStar != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(PreLevelStar);
		}
		preActivityStory_.WriteTo(output, _repeated_preActivityStory_codec);
		floorId_.WriteTo(output, _repeated_floorId_codec);
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		eET_.WriteTo(output, _repeated_eET_codec);
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(RecommendBuildRank);
		}
		if (SuggestedPower != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(SuggestedPower);
		}
		if (StarConditionType != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(StarConditionType);
		}
		oneStarCondition_.WriteTo(output, _repeated_oneStarCondition_codec);
		twoStarCondition_.WriteTo(output, _repeated_twoStarCondition_codec);
		threeStarCondition_.WriteTo(output, _repeated_threeStarCondition_codec);
		if (OneStarDesc.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(OneStarDesc);
		}
		if (TwoStarDesc.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(TwoStarDesc);
		}
		if (ThreeStarDesc.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(ThreeStarDesc);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(Desc);
		}
		if (CompleteRewardPreview.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(CompleteRewardPreview);
		}
		if (ThreeStarSweep)
		{
			output.WriteRawTag(216, 1);
			output.WriteBool(ThreeStarSweep);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (DayOpen != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DayOpen);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (IconRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (EnergyConsume != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnergyConsume);
		}
		if (EnergyConsumeOnRetry)
		{
			num += 2;
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (PreLevelStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelStar);
		}
		num += preActivityStory_.CalculateSize(_repeated_preActivityStory_codec);
		num += floorId_.CalculateSize(_repeated_floorId_codec);
		if (PreviewMonsterGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		num += eET_.CalculateSize(_repeated_eET_codec);
		if (RecommendBuildRank != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RecommendBuildRank);
		}
		if (SuggestedPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SuggestedPower);
		}
		if (StarConditionType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(StarConditionType);
		}
		num += oneStarCondition_.CalculateSize(_repeated_oneStarCondition_codec);
		num += twoStarCondition_.CalculateSize(_repeated_twoStarCondition_codec);
		num += threeStarCondition_.CalculateSize(_repeated_threeStarCondition_codec);
		if (OneStarDesc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(OneStarDesc);
		}
		if (TwoStarDesc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(TwoStarDesc);
		}
		if (ThreeStarDesc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(ThreeStarDesc);
		}
		if (Desc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (CompleteRewardPreview.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CompleteRewardPreview);
		}
		if (ThreeStarSweep)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityLevelsLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.DayOpen != 0)
			{
				DayOpen = other.DayOpen;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.IconRes.Length != 0)
			{
				IconRes = other.IconRes;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.EnergyConsume != 0)
			{
				EnergyConsume = other.EnergyConsume;
			}
			if (other.EnergyConsumeOnRetry)
			{
				EnergyConsumeOnRetry = other.EnergyConsumeOnRetry;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.PreLevelStar != 0)
			{
				PreLevelStar = other.PreLevelStar;
			}
			preActivityStory_.Add(other.preActivityStory_);
			floorId_.Add(other.floorId_);
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			eET_.Add(other.eET_);
			if (other.RecommendBuildRank != 0)
			{
				RecommendBuildRank = other.RecommendBuildRank;
			}
			if (other.SuggestedPower != 0)
			{
				SuggestedPower = other.SuggestedPower;
			}
			if (other.StarConditionType != 0)
			{
				StarConditionType = other.StarConditionType;
			}
			oneStarCondition_.Add(other.oneStarCondition_);
			twoStarCondition_.Add(other.twoStarCondition_);
			threeStarCondition_.Add(other.threeStarCondition_);
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.CompleteRewardPreview.Length != 0)
			{
				CompleteRewardPreview = other.CompleteRewardPreview;
			}
			if (other.ThreeStarSweep)
			{
				ThreeStarSweep = other.ThreeStarSweep;
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
				ActivityId = input.ReadInt32();
				break;
			case 24u:
				DayOpen = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				IconRes = input.ReadString();
				break;
			case 48u:
				Type = input.ReadInt32();
				break;
			case 56u:
				Difficulty = input.ReadInt32();
				break;
			case 64u:
				EnergyConsume = input.ReadInt32();
				break;
			case 72u:
				EnergyConsumeOnRetry = input.ReadBool();
				break;
			case 80u:
				PreLevelId = input.ReadInt32();
				break;
			case 88u:
				PreLevelStar = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				preActivityStory_.AddEntriesFrom(input, _repeated_preActivityStory_codec);
				break;
			case 104u:
			case 106u:
				floorId_.AddEntriesFrom(input, _repeated_floorId_codec);
				break;
			case 112u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 120u:
			case 122u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			case 128u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 136u:
				SuggestedPower = input.ReadInt32();
				break;
			case 144u:
				StarConditionType = input.ReadInt32();
				break;
			case 152u:
			case 154u:
				oneStarCondition_.AddEntriesFrom(input, _repeated_oneStarCondition_codec);
				break;
			case 160u:
			case 162u:
				twoStarCondition_.AddEntriesFrom(input, _repeated_twoStarCondition_codec);
				break;
			case 168u:
			case 170u:
				threeStarCondition_.AddEntriesFrom(input, _repeated_threeStarCondition_codec);
				break;
			case 178u:
				OneStarDesc = input.ReadString();
				break;
			case 186u:
				TwoStarDesc = input.ReadString();
				break;
			case 194u:
				ThreeStarDesc = input.ReadString();
				break;
			case 202u:
				Desc = input.ReadString();
				break;
			case 210u:
				CompleteRewardPreview = input.ReadString();
				break;
			case 216u:
				ThreeStarSweep = input.ReadBool();
				break;
			}
		}
	}
}
