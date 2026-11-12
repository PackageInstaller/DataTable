using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTower : IMessage<StarTower>, IMessage, IEquatable<StarTower>, IDeepCloneable<StarTower>
{
	private static readonly MessageParser<StarTower> _parser = new MessageParser<StarTower>(() => new StarTower());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int GroupIdFieldNumber = 4;

	private int groupId_;

	public const int PreConditionsFieldNumber = 5;

	private string preConditions_ = "";

	public const int PreviewMonsterGroupIdFieldNumber = 6;

	private int previewMonsterGroupId_;

	public const int DifficultyFieldNumber = 7;

	private int difficulty_;

	public const int ValueDifficultyFieldNumber = 8;

	private int valueDifficulty_;

	public const int RecommendFieldNumber = 9;

	private int recommend_;

	public const int CurrencyIdFieldNumber = 10;

	private int currencyId_;

	public const int StageGroupIdsFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_stageGroupIds_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> stageGroupIds_ = new RepeatedField<int>();

	public const int FloorNumFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_floorNum_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> floorNum_ = new RepeatedField<int>();

	public const int TeamExpGroupIdFieldNumber = 13;

	private int teamExpGroupId_;

	public const int SubNoteSkillDropGroupIdFieldNumber = 14;

	private int subNoteSkillDropGroupId_;

	public const int FirstAwardFieldNumber = 15;

	private string firstAward_ = "";

	public const int EETFieldNumber = 16;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(130u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	public const int NotEETFieldNumber = 17;

	private static readonly FieldCodec<int> _repeated_notEET_codec = FieldCodec.ForInt32(138u);

	private readonly RepeatedField<int> notEET_ = new RepeatedField<int>();

	public const int EpisodeFieldNumber = 18;

	private string episode_ = "";

	public const int ImageFieldNumber = 19;

	private string image_ = "";

	public const int NPCIdFieldNumber = 20;

	private int nPCId_;

	public const int RewardPreviewFieldNumber = 21;

	private string rewardPreview_ = "";

	public const int ShopNpcFieldNumber = 22;

	private int shopNpc_;

	public const int StandShopNpcFieldNumber = 23;

	private int standShopNpc_;

	public const int UpgradeNpcFieldNumber = 24;

	private int upgradeNpc_;

	public const int ResqueNpcFieldNumber = 25;

	private int resqueNpc_;

	public const int DangerNpcFieldNumber = 26;

	private int dangerNpc_;

	public const int HorrorNpcFieldNumber = 27;

	private int horrorNpc_;

	public const int DangerEndEventFieldNumber = 28;

	private int dangerEndEvent_;

	public const int HorrorEndEventFieldNumber = 29;

	private int horrorEndEvent_;

	public const int DestructibleObjectTypeFieldNumber = 30;

	private int destructibleObjectType_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTower> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(816);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PreConditions
	{
		get
		{
			return preConditions_;
		}
		set
		{
			preConditions_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int ValueDifficulty
	{
		get
		{
			return valueDifficulty_;
		}
		set
		{
			valueDifficulty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Recommend
	{
		get
		{
			return recommend_;
		}
		set
		{
			recommend_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CurrencyId
	{
		get
		{
			return currencyId_;
		}
		set
		{
			currencyId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> StageGroupIds => stageGroupIds_;

	[DebuggerNonUserCode]
	public RepeatedField<int> FloorNum => floorNum_;

	[DebuggerNonUserCode]
	public int TeamExpGroupId
	{
		get
		{
			return teamExpGroupId_;
		}
		set
		{
			teamExpGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SubNoteSkillDropGroupId
	{
		get
		{
			return subNoteSkillDropGroupId_;
		}
		set
		{
			subNoteSkillDropGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FirstAward
	{
		get
		{
			return firstAward_;
		}
		set
		{
			firstAward_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EET => eET_;

	[DebuggerNonUserCode]
	public RepeatedField<int> NotEET => notEET_;

	[DebuggerNonUserCode]
	public string Episode
	{
		get
		{
			return episode_;
		}
		set
		{
			episode_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Image
	{
		get
		{
			return image_;
		}
		set
		{
			image_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int NPCId
	{
		get
		{
			return nPCId_;
		}
		set
		{
			nPCId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardPreview
	{
		get
		{
			return rewardPreview_;
		}
		set
		{
			rewardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ShopNpc
	{
		get
		{
			return shopNpc_;
		}
		set
		{
			shopNpc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StandShopNpc
	{
		get
		{
			return standShopNpc_;
		}
		set
		{
			standShopNpc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UpgradeNpc
	{
		get
		{
			return upgradeNpc_;
		}
		set
		{
			upgradeNpc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ResqueNpc
	{
		get
		{
			return resqueNpc_;
		}
		set
		{
			resqueNpc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DangerNpc
	{
		get
		{
			return dangerNpc_;
		}
		set
		{
			dangerNpc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HorrorNpc
	{
		get
		{
			return horrorNpc_;
		}
		set
		{
			horrorNpc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DangerEndEvent
	{
		get
		{
			return dangerEndEvent_;
		}
		set
		{
			dangerEndEvent_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HorrorEndEvent
	{
		get
		{
			return horrorEndEvent_;
		}
		set
		{
			horrorEndEvent_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DestructibleObjectType
	{
		get
		{
			return destructibleObjectType_;
		}
		set
		{
			destructibleObjectType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTower()
	{
	}

	[DebuggerNonUserCode]
	public StarTower(StarTower other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		groupId_ = other.groupId_;
		preConditions_ = other.preConditions_;
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		difficulty_ = other.difficulty_;
		valueDifficulty_ = other.valueDifficulty_;
		recommend_ = other.recommend_;
		currencyId_ = other.currencyId_;
		stageGroupIds_ = other.stageGroupIds_.Clone();
		floorNum_ = other.floorNum_.Clone();
		teamExpGroupId_ = other.teamExpGroupId_;
		subNoteSkillDropGroupId_ = other.subNoteSkillDropGroupId_;
		firstAward_ = other.firstAward_;
		eET_ = other.eET_.Clone();
		notEET_ = other.notEET_.Clone();
		episode_ = other.episode_;
		image_ = other.image_;
		nPCId_ = other.nPCId_;
		rewardPreview_ = other.rewardPreview_;
		shopNpc_ = other.shopNpc_;
		standShopNpc_ = other.standShopNpc_;
		upgradeNpc_ = other.upgradeNpc_;
		resqueNpc_ = other.resqueNpc_;
		dangerNpc_ = other.dangerNpc_;
		horrorNpc_ = other.horrorNpc_;
		dangerEndEvent_ = other.dangerEndEvent_;
		horrorEndEvent_ = other.horrorEndEvent_;
		destructibleObjectType_ = other.destructibleObjectType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTower Clone()
	{
		return new StarTower(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTower);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTower other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (PreConditions != other.PreConditions)
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (ValueDifficulty != other.ValueDifficulty)
		{
			return false;
		}
		if (Recommend != other.Recommend)
		{
			return false;
		}
		if (CurrencyId != other.CurrencyId)
		{
			return false;
		}
		if (!stageGroupIds_.Equals(other.stageGroupIds_))
		{
			return false;
		}
		if (!floorNum_.Equals(other.floorNum_))
		{
			return false;
		}
		if (TeamExpGroupId != other.TeamExpGroupId)
		{
			return false;
		}
		if (SubNoteSkillDropGroupId != other.SubNoteSkillDropGroupId)
		{
			return false;
		}
		if (FirstAward != other.FirstAward)
		{
			return false;
		}
		if (!eET_.Equals(other.eET_))
		{
			return false;
		}
		if (!notEET_.Equals(other.notEET_))
		{
			return false;
		}
		if (Episode != other.Episode)
		{
			return false;
		}
		if (Image != other.Image)
		{
			return false;
		}
		if (NPCId != other.NPCId)
		{
			return false;
		}
		if (RewardPreview != other.RewardPreview)
		{
			return false;
		}
		if (ShopNpc != other.ShopNpc)
		{
			return false;
		}
		if (StandShopNpc != other.StandShopNpc)
		{
			return false;
		}
		if (UpgradeNpc != other.UpgradeNpc)
		{
			return false;
		}
		if (ResqueNpc != other.ResqueNpc)
		{
			return false;
		}
		if (DangerNpc != other.DangerNpc)
		{
			return false;
		}
		if (HorrorNpc != other.HorrorNpc)
		{
			return false;
		}
		if (DangerEndEvent != other.DangerEndEvent)
		{
			return false;
		}
		if (HorrorEndEvent != other.HorrorEndEvent)
		{
			return false;
		}
		if (DestructibleObjectType != other.DestructibleObjectType)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (PreConditions.Length != 0)
		{
			num ^= PreConditions.GetHashCode();
		}
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (ValueDifficulty != 0)
		{
			num ^= ValueDifficulty.GetHashCode();
		}
		if (Recommend != 0)
		{
			num ^= Recommend.GetHashCode();
		}
		if (CurrencyId != 0)
		{
			num ^= CurrencyId.GetHashCode();
		}
		num ^= stageGroupIds_.GetHashCode();
		num ^= floorNum_.GetHashCode();
		if (TeamExpGroupId != 0)
		{
			num ^= TeamExpGroupId.GetHashCode();
		}
		if (SubNoteSkillDropGroupId != 0)
		{
			num ^= SubNoteSkillDropGroupId.GetHashCode();
		}
		if (FirstAward.Length != 0)
		{
			num ^= FirstAward.GetHashCode();
		}
		num ^= eET_.GetHashCode();
		num ^= notEET_.GetHashCode();
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		if (NPCId != 0)
		{
			num ^= NPCId.GetHashCode();
		}
		if (RewardPreview.Length != 0)
		{
			num ^= RewardPreview.GetHashCode();
		}
		if (ShopNpc != 0)
		{
			num ^= ShopNpc.GetHashCode();
		}
		if (StandShopNpc != 0)
		{
			num ^= StandShopNpc.GetHashCode();
		}
		if (UpgradeNpc != 0)
		{
			num ^= UpgradeNpc.GetHashCode();
		}
		if (ResqueNpc != 0)
		{
			num ^= ResqueNpc.GetHashCode();
		}
		if (DangerNpc != 0)
		{
			num ^= DangerNpc.GetHashCode();
		}
		if (HorrorNpc != 0)
		{
			num ^= HorrorNpc.GetHashCode();
		}
		if (DangerEndEvent != 0)
		{
			num ^= DangerEndEvent.GetHashCode();
		}
		if (HorrorEndEvent != 0)
		{
			num ^= HorrorEndEvent.GetHashCode();
		}
		if (DestructibleObjectType != 0)
		{
			num ^= DestructibleObjectType.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(GroupId);
		}
		if (PreConditions.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(PreConditions);
		}
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Difficulty);
		}
		if (ValueDifficulty != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(ValueDifficulty);
		}
		if (Recommend != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Recommend);
		}
		if (CurrencyId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(CurrencyId);
		}
		stageGroupIds_.WriteTo(output, _repeated_stageGroupIds_codec);
		floorNum_.WriteTo(output, _repeated_floorNum_codec);
		if (TeamExpGroupId != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(TeamExpGroupId);
		}
		if (SubNoteSkillDropGroupId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(SubNoteSkillDropGroupId);
		}
		if (FirstAward.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(FirstAward);
		}
		eET_.WriteTo(output, _repeated_eET_codec);
		notEET_.WriteTo(output, _repeated_notEET_codec);
		if (Episode.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(Episode);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Image);
		}
		if (NPCId != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(NPCId);
		}
		if (RewardPreview.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(RewardPreview);
		}
		if (ShopNpc != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(ShopNpc);
		}
		if (StandShopNpc != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(StandShopNpc);
		}
		if (UpgradeNpc != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(UpgradeNpc);
		}
		if (ResqueNpc != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(ResqueNpc);
		}
		if (DangerNpc != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(DangerNpc);
		}
		if (HorrorNpc != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(HorrorNpc);
		}
		if (DangerEndEvent != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(DangerEndEvent);
		}
		if (HorrorEndEvent != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(HorrorEndEvent);
		}
		if (DestructibleObjectType != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(DestructibleObjectType);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (PreConditions.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PreConditions);
		}
		if (PreviewMonsterGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (ValueDifficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ValueDifficulty);
		}
		if (Recommend != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Recommend);
		}
		if (CurrencyId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CurrencyId);
		}
		num += stageGroupIds_.CalculateSize(_repeated_stageGroupIds_codec);
		num += floorNum_.CalculateSize(_repeated_floorNum_codec);
		if (TeamExpGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TeamExpGroupId);
		}
		if (SubNoteSkillDropGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SubNoteSkillDropGroupId);
		}
		if (FirstAward.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FirstAward);
		}
		num += eET_.CalculateSize(_repeated_eET_codec);
		num += notEET_.CalculateSize(_repeated_notEET_codec);
		if (Episode.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (Image.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (NPCId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NPCId);
		}
		if (RewardPreview.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(RewardPreview);
		}
		if (ShopNpc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ShopNpc);
		}
		if (StandShopNpc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(StandShopNpc);
		}
		if (UpgradeNpc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(UpgradeNpc);
		}
		if (ResqueNpc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ResqueNpc);
		}
		if (DangerNpc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DangerNpc);
		}
		if (HorrorNpc != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HorrorNpc);
		}
		if (DangerEndEvent != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DangerEndEvent);
		}
		if (HorrorEndEvent != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HorrorEndEvent);
		}
		if (DestructibleObjectType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DestructibleObjectType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTower other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.PreConditions.Length != 0)
			{
				PreConditions = other.PreConditions;
			}
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.ValueDifficulty != 0)
			{
				ValueDifficulty = other.ValueDifficulty;
			}
			if (other.Recommend != 0)
			{
				Recommend = other.Recommend;
			}
			if (other.CurrencyId != 0)
			{
				CurrencyId = other.CurrencyId;
			}
			stageGroupIds_.Add(other.stageGroupIds_);
			floorNum_.Add(other.floorNum_);
			if (other.TeamExpGroupId != 0)
			{
				TeamExpGroupId = other.TeamExpGroupId;
			}
			if (other.SubNoteSkillDropGroupId != 0)
			{
				SubNoteSkillDropGroupId = other.SubNoteSkillDropGroupId;
			}
			if (other.FirstAward.Length != 0)
			{
				FirstAward = other.FirstAward;
			}
			eET_.Add(other.eET_);
			notEET_.Add(other.notEET_);
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			if (other.NPCId != 0)
			{
				NPCId = other.NPCId;
			}
			if (other.RewardPreview.Length != 0)
			{
				RewardPreview = other.RewardPreview;
			}
			if (other.ShopNpc != 0)
			{
				ShopNpc = other.ShopNpc;
			}
			if (other.StandShopNpc != 0)
			{
				StandShopNpc = other.StandShopNpc;
			}
			if (other.UpgradeNpc != 0)
			{
				UpgradeNpc = other.UpgradeNpc;
			}
			if (other.ResqueNpc != 0)
			{
				ResqueNpc = other.ResqueNpc;
			}
			if (other.DangerNpc != 0)
			{
				DangerNpc = other.DangerNpc;
			}
			if (other.HorrorNpc != 0)
			{
				HorrorNpc = other.HorrorNpc;
			}
			if (other.DangerEndEvent != 0)
			{
				DangerEndEvent = other.DangerEndEvent;
			}
			if (other.HorrorEndEvent != 0)
			{
				HorrorEndEvent = other.HorrorEndEvent;
			}
			if (other.DestructibleObjectType != 0)
			{
				DestructibleObjectType = other.DestructibleObjectType;
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
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				GroupId = input.ReadInt32();
				break;
			case 42u:
				PreConditions = input.ReadString();
				break;
			case 48u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 56u:
				Difficulty = input.ReadInt32();
				break;
			case 64u:
				ValueDifficulty = input.ReadInt32();
				break;
			case 72u:
				Recommend = input.ReadInt32();
				break;
			case 80u:
				CurrencyId = input.ReadInt32();
				break;
			case 88u:
			case 90u:
				stageGroupIds_.AddEntriesFrom(input, _repeated_stageGroupIds_codec);
				break;
			case 96u:
			case 98u:
				floorNum_.AddEntriesFrom(input, _repeated_floorNum_codec);
				break;
			case 104u:
				TeamExpGroupId = input.ReadInt32();
				break;
			case 112u:
				SubNoteSkillDropGroupId = input.ReadInt32();
				break;
			case 122u:
				FirstAward = input.ReadString();
				break;
			case 128u:
			case 130u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			case 136u:
			case 138u:
				notEET_.AddEntriesFrom(input, _repeated_notEET_codec);
				break;
			case 146u:
				Episode = input.ReadString();
				break;
			case 154u:
				Image = input.ReadString();
				break;
			case 160u:
				NPCId = input.ReadInt32();
				break;
			case 170u:
				RewardPreview = input.ReadString();
				break;
			case 176u:
				ShopNpc = input.ReadInt32();
				break;
			case 184u:
				StandShopNpc = input.ReadInt32();
				break;
			case 192u:
				UpgradeNpc = input.ReadInt32();
				break;
			case 200u:
				ResqueNpc = input.ReadInt32();
				break;
			case 208u:
				DangerNpc = input.ReadInt32();
				break;
			case 216u:
				HorrorNpc = input.ReadInt32();
				break;
			case 224u:
				DangerEndEvent = input.ReadInt32();
				break;
			case 232u:
				HorrorEndEvent = input.ReadInt32();
				break;
			case 240u:
				DestructibleObjectType = input.ReadInt32();
				break;
			}
		}
	}
}
