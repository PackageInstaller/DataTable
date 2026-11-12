using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireSurvivor : IMessage<VampireSurvivor>, IMessage, IEquatable<VampireSurvivor>, IDeepCloneable<VampireSurvivor>
{
	private static readonly MessageParser<VampireSurvivor> _parser = new MessageParser<VampireSurvivor>(() => new VampireSurvivor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int Name1FieldNumber = 3;

	private string name1_ = "";

	public const int Name2FieldNumber = 4;

	private string name2_ = "";

	public const int EETFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	public const int NotEETFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_notEET_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> notEET_ = new RepeatedField<int>();

	public const int SuggestedPowerFieldNumber = 7;

	private int suggestedPower_;

	public const int RecommendBuildRankFieldNumber = 8;

	private int recommendBuildRank_;

	public const int ModeFieldNumber = 9;

	private int mode_;

	public const int TypeFieldNumber = 10;

	private int type_;

	public const int PreLevelIdFieldNumber = 11;

	private int preLevelId_;

	public const int NeedWorldClassFieldNumber = 12;

	private int needWorldClass_;

	public const int FirstQuestGroupIdFieldNumber = 13;

	private int firstQuestGroupId_;

	public const int LevelGroupIdFieldNumber = 14;

	private int levelGroupId_;

	public const int FloorIdFieldNumber = 15;

	private int floorId_;

	public const int NormalScore1FieldNumber = 16;

	private int normalScore1_;

	public const int EliteScore1FieldNumber = 17;

	private int eliteScore1_;

	public const int BossScore1FieldNumber = 18;

	private int bossScore1_;

	public const int TimeScore1FieldNumber = 19;

	private int timeScore1_;

	public const int TimeLimit1FieldNumber = 20;

	private int timeLimit1_;

	public const int NormalScore2FieldNumber = 21;

	private int normalScore2_;

	public const int EliteScore2FieldNumber = 22;

	private int eliteScore2_;

	public const int BossScore2FieldNumber = 23;

	private int bossScore2_;

	public const int TimeScore2FieldNumber = 24;

	private int timeScore2_;

	public const int TimeLimit2FieldNumber = 25;

	private int timeLimit2_;

	public const int EETScore1FieldNumber = 26;

	private static readonly FieldCodec<int> _repeated_eETScore1_codec = FieldCodec.ForInt32(210u);

	private readonly RepeatedField<int> eETScore1_ = new RepeatedField<int>();

	public const int EETScore2FieldNumber = 27;

	private static readonly FieldCodec<int> _repeated_eETScore2_codec = FieldCodec.ForInt32(218u);

	private readonly RepeatedField<int> eETScore2_ = new RepeatedField<int>();

	public const int FHPreviewMonsterGroupIdFieldNumber = 28;

	private int fHPreviewMonsterGroupId_;

	public const int SHPreviewMonsterGroupIdFieldNumber = 29;

	private int sHPreviewMonsterGroupId_;

	public const int CoverEpisodeFieldNumber = 30;

	private string coverEpisode_ = "";

	public const int EpisodeFieldNumber = 31;

	private string episode_ = "";

	public const int Episode2FieldNumber = 32;

	private string episode2_ = "";

	public const int FateCardBundleFieldNumber = 33;

	private static readonly FieldCodec<int> _repeated_fateCardBundle_codec = FieldCodec.ForInt32(266u);

	private readonly RepeatedField<int> fateCardBundle_ = new RepeatedField<int>();

	public const int SpeciaFateCardFieldNumber = 34;

	private string speciaFateCard_ = "";

	public const int SpeciaFateCardParamFieldNumber = 35;

	private string speciaFateCardParam_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<VampireSurvivor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1060);

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
	public string Name1
	{
		get
		{
			return name1_;
		}
		set
		{
			name1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Name2
	{
		get
		{
			return name2_;
		}
		set
		{
			name2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EET => eET_;

	[DebuggerNonUserCode]
	public RepeatedField<int> NotEET => notEET_;

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
	public int Mode
	{
		get
		{
			return mode_;
		}
		set
		{
			mode_ = value;
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
	public int FirstQuestGroupId
	{
		get
		{
			return firstQuestGroupId_;
		}
		set
		{
			firstQuestGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelGroupId
	{
		get
		{
			return levelGroupId_;
		}
		set
		{
			levelGroupId_ = value;
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
	public int NormalScore1
	{
		get
		{
			return normalScore1_;
		}
		set
		{
			normalScore1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EliteScore1
	{
		get
		{
			return eliteScore1_;
		}
		set
		{
			eliteScore1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BossScore1
	{
		get
		{
			return bossScore1_;
		}
		set
		{
			bossScore1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TimeScore1
	{
		get
		{
			return timeScore1_;
		}
		set
		{
			timeScore1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TimeLimit1
	{
		get
		{
			return timeLimit1_;
		}
		set
		{
			timeLimit1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NormalScore2
	{
		get
		{
			return normalScore2_;
		}
		set
		{
			normalScore2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EliteScore2
	{
		get
		{
			return eliteScore2_;
		}
		set
		{
			eliteScore2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BossScore2
	{
		get
		{
			return bossScore2_;
		}
		set
		{
			bossScore2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TimeScore2
	{
		get
		{
			return timeScore2_;
		}
		set
		{
			timeScore2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TimeLimit2
	{
		get
		{
			return timeLimit2_;
		}
		set
		{
			timeLimit2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EETScore1 => eETScore1_;

	[DebuggerNonUserCode]
	public RepeatedField<int> EETScore2 => eETScore2_;

	[DebuggerNonUserCode]
	public int FHPreviewMonsterGroupId
	{
		get
		{
			return fHPreviewMonsterGroupId_;
		}
		set
		{
			fHPreviewMonsterGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SHPreviewMonsterGroupId
	{
		get
		{
			return sHPreviewMonsterGroupId_;
		}
		set
		{
			sHPreviewMonsterGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string CoverEpisode
	{
		get
		{
			return coverEpisode_;
		}
		set
		{
			coverEpisode_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public string Episode2
	{
		get
		{
			return episode2_;
		}
		set
		{
			episode2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> FateCardBundle => fateCardBundle_;

	[DebuggerNonUserCode]
	public string SpeciaFateCard
	{
		get
		{
			return speciaFateCard_;
		}
		set
		{
			speciaFateCard_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SpeciaFateCardParam
	{
		get
		{
			return speciaFateCardParam_;
		}
		set
		{
			speciaFateCardParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public VampireSurvivor()
	{
	}

	[DebuggerNonUserCode]
	public VampireSurvivor(VampireSurvivor other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		name1_ = other.name1_;
		name2_ = other.name2_;
		eET_ = other.eET_.Clone();
		notEET_ = other.notEET_.Clone();
		suggestedPower_ = other.suggestedPower_;
		recommendBuildRank_ = other.recommendBuildRank_;
		mode_ = other.mode_;
		type_ = other.type_;
		preLevelId_ = other.preLevelId_;
		needWorldClass_ = other.needWorldClass_;
		firstQuestGroupId_ = other.firstQuestGroupId_;
		levelGroupId_ = other.levelGroupId_;
		floorId_ = other.floorId_;
		normalScore1_ = other.normalScore1_;
		eliteScore1_ = other.eliteScore1_;
		bossScore1_ = other.bossScore1_;
		timeScore1_ = other.timeScore1_;
		timeLimit1_ = other.timeLimit1_;
		normalScore2_ = other.normalScore2_;
		eliteScore2_ = other.eliteScore2_;
		bossScore2_ = other.bossScore2_;
		timeScore2_ = other.timeScore2_;
		timeLimit2_ = other.timeLimit2_;
		eETScore1_ = other.eETScore1_.Clone();
		eETScore2_ = other.eETScore2_.Clone();
		fHPreviewMonsterGroupId_ = other.fHPreviewMonsterGroupId_;
		sHPreviewMonsterGroupId_ = other.sHPreviewMonsterGroupId_;
		coverEpisode_ = other.coverEpisode_;
		episode_ = other.episode_;
		episode2_ = other.episode2_;
		fateCardBundle_ = other.fateCardBundle_.Clone();
		speciaFateCard_ = other.speciaFateCard_;
		speciaFateCardParam_ = other.speciaFateCardParam_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireSurvivor Clone()
	{
		return new VampireSurvivor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireSurvivor);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireSurvivor other)
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
		if (Name1 != other.Name1)
		{
			return false;
		}
		if (Name2 != other.Name2)
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
		if (SuggestedPower != other.SuggestedPower)
		{
			return false;
		}
		if (RecommendBuildRank != other.RecommendBuildRank)
		{
			return false;
		}
		if (Mode != other.Mode)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (NeedWorldClass != other.NeedWorldClass)
		{
			return false;
		}
		if (FirstQuestGroupId != other.FirstQuestGroupId)
		{
			return false;
		}
		if (LevelGroupId != other.LevelGroupId)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (NormalScore1 != other.NormalScore1)
		{
			return false;
		}
		if (EliteScore1 != other.EliteScore1)
		{
			return false;
		}
		if (BossScore1 != other.BossScore1)
		{
			return false;
		}
		if (TimeScore1 != other.TimeScore1)
		{
			return false;
		}
		if (TimeLimit1 != other.TimeLimit1)
		{
			return false;
		}
		if (NormalScore2 != other.NormalScore2)
		{
			return false;
		}
		if (EliteScore2 != other.EliteScore2)
		{
			return false;
		}
		if (BossScore2 != other.BossScore2)
		{
			return false;
		}
		if (TimeScore2 != other.TimeScore2)
		{
			return false;
		}
		if (TimeLimit2 != other.TimeLimit2)
		{
			return false;
		}
		if (!eETScore1_.Equals(other.eETScore1_))
		{
			return false;
		}
		if (!eETScore2_.Equals(other.eETScore2_))
		{
			return false;
		}
		if (FHPreviewMonsterGroupId != other.FHPreviewMonsterGroupId)
		{
			return false;
		}
		if (SHPreviewMonsterGroupId != other.SHPreviewMonsterGroupId)
		{
			return false;
		}
		if (CoverEpisode != other.CoverEpisode)
		{
			return false;
		}
		if (Episode != other.Episode)
		{
			return false;
		}
		if (Episode2 != other.Episode2)
		{
			return false;
		}
		if (!fateCardBundle_.Equals(other.fateCardBundle_))
		{
			return false;
		}
		if (SpeciaFateCard != other.SpeciaFateCard)
		{
			return false;
		}
		if (SpeciaFateCardParam != other.SpeciaFateCardParam)
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
		if (Name1.Length != 0)
		{
			num ^= Name1.GetHashCode();
		}
		if (Name2.Length != 0)
		{
			num ^= Name2.GetHashCode();
		}
		num ^= eET_.GetHashCode();
		num ^= notEET_.GetHashCode();
		if (SuggestedPower != 0)
		{
			num ^= SuggestedPower.GetHashCode();
		}
		if (RecommendBuildRank != 0)
		{
			num ^= RecommendBuildRank.GetHashCode();
		}
		if (Mode != 0)
		{
			num ^= Mode.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (NeedWorldClass != 0)
		{
			num ^= NeedWorldClass.GetHashCode();
		}
		if (FirstQuestGroupId != 0)
		{
			num ^= FirstQuestGroupId.GetHashCode();
		}
		if (LevelGroupId != 0)
		{
			num ^= LevelGroupId.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (NormalScore1 != 0)
		{
			num ^= NormalScore1.GetHashCode();
		}
		if (EliteScore1 != 0)
		{
			num ^= EliteScore1.GetHashCode();
		}
		if (BossScore1 != 0)
		{
			num ^= BossScore1.GetHashCode();
		}
		if (TimeScore1 != 0)
		{
			num ^= TimeScore1.GetHashCode();
		}
		if (TimeLimit1 != 0)
		{
			num ^= TimeLimit1.GetHashCode();
		}
		if (NormalScore2 != 0)
		{
			num ^= NormalScore2.GetHashCode();
		}
		if (EliteScore2 != 0)
		{
			num ^= EliteScore2.GetHashCode();
		}
		if (BossScore2 != 0)
		{
			num ^= BossScore2.GetHashCode();
		}
		if (TimeScore2 != 0)
		{
			num ^= TimeScore2.GetHashCode();
		}
		if (TimeLimit2 != 0)
		{
			num ^= TimeLimit2.GetHashCode();
		}
		num ^= eETScore1_.GetHashCode();
		num ^= eETScore2_.GetHashCode();
		if (FHPreviewMonsterGroupId != 0)
		{
			num ^= FHPreviewMonsterGroupId.GetHashCode();
		}
		if (SHPreviewMonsterGroupId != 0)
		{
			num ^= SHPreviewMonsterGroupId.GetHashCode();
		}
		if (CoverEpisode.Length != 0)
		{
			num ^= CoverEpisode.GetHashCode();
		}
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (Episode2.Length != 0)
		{
			num ^= Episode2.GetHashCode();
		}
		num ^= fateCardBundle_.GetHashCode();
		if (SpeciaFateCard.Length != 0)
		{
			num ^= SpeciaFateCard.GetHashCode();
		}
		if (SpeciaFateCardParam.Length != 0)
		{
			num ^= SpeciaFateCardParam.GetHashCode();
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
		if (Name1.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name1);
		}
		if (Name2.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name2);
		}
		eET_.WriteTo(output, _repeated_eET_codec);
		notEET_.WriteTo(output, _repeated_notEET_codec);
		if (SuggestedPower != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(SuggestedPower);
		}
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(RecommendBuildRank);
		}
		if (Mode != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Mode);
		}
		if (Type != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Type);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(PreLevelId);
		}
		if (NeedWorldClass != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(NeedWorldClass);
		}
		if (FirstQuestGroupId != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(FirstQuestGroupId);
		}
		if (LevelGroupId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(LevelGroupId);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(FloorId);
		}
		if (NormalScore1 != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(NormalScore1);
		}
		if (EliteScore1 != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(EliteScore1);
		}
		if (BossScore1 != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(BossScore1);
		}
		if (TimeScore1 != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(TimeScore1);
		}
		if (TimeLimit1 != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(TimeLimit1);
		}
		if (NormalScore2 != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(NormalScore2);
		}
		if (EliteScore2 != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(EliteScore2);
		}
		if (BossScore2 != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(BossScore2);
		}
		if (TimeScore2 != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(TimeScore2);
		}
		if (TimeLimit2 != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(TimeLimit2);
		}
		eETScore1_.WriteTo(output, _repeated_eETScore1_codec);
		eETScore2_.WriteTo(output, _repeated_eETScore2_codec);
		if (FHPreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(FHPreviewMonsterGroupId);
		}
		if (SHPreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(SHPreviewMonsterGroupId);
		}
		if (CoverEpisode.Length != 0)
		{
			output.WriteRawTag(242, 1);
			output.WriteString(CoverEpisode);
		}
		if (Episode.Length != 0)
		{
			output.WriteRawTag(250, 1);
			output.WriteString(Episode);
		}
		if (Episode2.Length != 0)
		{
			output.WriteRawTag(130, 2);
			output.WriteString(Episode2);
		}
		fateCardBundle_.WriteTo(output, _repeated_fateCardBundle_codec);
		if (SpeciaFateCard.Length != 0)
		{
			output.WriteRawTag(146, 2);
			output.WriteString(SpeciaFateCard);
		}
		if (SpeciaFateCardParam.Length != 0)
		{
			output.WriteRawTag(154, 2);
			output.WriteString(SpeciaFateCardParam);
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
		if (Name1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name1);
		}
		if (Name2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name2);
		}
		num += eET_.CalculateSize(_repeated_eET_codec);
		num += notEET_.CalculateSize(_repeated_notEET_codec);
		if (SuggestedPower != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SuggestedPower);
		}
		if (RecommendBuildRank != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RecommendBuildRank);
		}
		if (Mode != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Mode);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (NeedWorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedWorldClass);
		}
		if (FirstQuestGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstQuestGroupId);
		}
		if (LevelGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelGroupId);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (NormalScore1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NormalScore1);
		}
		if (EliteScore1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EliteScore1);
		}
		if (BossScore1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BossScore1);
		}
		if (TimeScore1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TimeScore1);
		}
		if (TimeLimit1 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TimeLimit1);
		}
		if (NormalScore2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NormalScore2);
		}
		if (EliteScore2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(EliteScore2);
		}
		if (BossScore2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(BossScore2);
		}
		if (TimeScore2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TimeScore2);
		}
		if (TimeLimit2 != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TimeLimit2);
		}
		num += eETScore1_.CalculateSize(_repeated_eETScore1_codec);
		num += eETScore2_.CalculateSize(_repeated_eETScore2_codec);
		if (FHPreviewMonsterGroupId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FHPreviewMonsterGroupId);
		}
		if (SHPreviewMonsterGroupId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SHPreviewMonsterGroupId);
		}
		if (CoverEpisode.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CoverEpisode);
		}
		if (Episode.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (Episode2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Episode2);
		}
		num += fateCardBundle_.CalculateSize(_repeated_fateCardBundle_codec);
		if (SpeciaFateCard.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SpeciaFateCard);
		}
		if (SpeciaFateCardParam.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(SpeciaFateCardParam);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireSurvivor other)
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
			if (other.Name1.Length != 0)
			{
				Name1 = other.Name1;
			}
			if (other.Name2.Length != 0)
			{
				Name2 = other.Name2;
			}
			eET_.Add(other.eET_);
			notEET_.Add(other.notEET_);
			if (other.SuggestedPower != 0)
			{
				SuggestedPower = other.SuggestedPower;
			}
			if (other.RecommendBuildRank != 0)
			{
				RecommendBuildRank = other.RecommendBuildRank;
			}
			if (other.Mode != 0)
			{
				Mode = other.Mode;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.NeedWorldClass != 0)
			{
				NeedWorldClass = other.NeedWorldClass;
			}
			if (other.FirstQuestGroupId != 0)
			{
				FirstQuestGroupId = other.FirstQuestGroupId;
			}
			if (other.LevelGroupId != 0)
			{
				LevelGroupId = other.LevelGroupId;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.NormalScore1 != 0)
			{
				NormalScore1 = other.NormalScore1;
			}
			if (other.EliteScore1 != 0)
			{
				EliteScore1 = other.EliteScore1;
			}
			if (other.BossScore1 != 0)
			{
				BossScore1 = other.BossScore1;
			}
			if (other.TimeScore1 != 0)
			{
				TimeScore1 = other.TimeScore1;
			}
			if (other.TimeLimit1 != 0)
			{
				TimeLimit1 = other.TimeLimit1;
			}
			if (other.NormalScore2 != 0)
			{
				NormalScore2 = other.NormalScore2;
			}
			if (other.EliteScore2 != 0)
			{
				EliteScore2 = other.EliteScore2;
			}
			if (other.BossScore2 != 0)
			{
				BossScore2 = other.BossScore2;
			}
			if (other.TimeScore2 != 0)
			{
				TimeScore2 = other.TimeScore2;
			}
			if (other.TimeLimit2 != 0)
			{
				TimeLimit2 = other.TimeLimit2;
			}
			eETScore1_.Add(other.eETScore1_);
			eETScore2_.Add(other.eETScore2_);
			if (other.FHPreviewMonsterGroupId != 0)
			{
				FHPreviewMonsterGroupId = other.FHPreviewMonsterGroupId;
			}
			if (other.SHPreviewMonsterGroupId != 0)
			{
				SHPreviewMonsterGroupId = other.SHPreviewMonsterGroupId;
			}
			if (other.CoverEpisode.Length != 0)
			{
				CoverEpisode = other.CoverEpisode;
			}
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.Episode2.Length != 0)
			{
				Episode2 = other.Episode2;
			}
			fateCardBundle_.Add(other.fateCardBundle_);
			if (other.SpeciaFateCard.Length != 0)
			{
				SpeciaFateCard = other.SpeciaFateCard;
			}
			if (other.SpeciaFateCardParam.Length != 0)
			{
				SpeciaFateCardParam = other.SpeciaFateCardParam;
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
				Name1 = input.ReadString();
				break;
			case 34u:
				Name2 = input.ReadString();
				break;
			case 40u:
			case 42u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			case 48u:
			case 50u:
				notEET_.AddEntriesFrom(input, _repeated_notEET_codec);
				break;
			case 56u:
				SuggestedPower = input.ReadInt32();
				break;
			case 64u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 72u:
				Mode = input.ReadInt32();
				break;
			case 80u:
				Type = input.ReadInt32();
				break;
			case 88u:
				PreLevelId = input.ReadInt32();
				break;
			case 96u:
				NeedWorldClass = input.ReadInt32();
				break;
			case 104u:
				FirstQuestGroupId = input.ReadInt32();
				break;
			case 112u:
				LevelGroupId = input.ReadInt32();
				break;
			case 120u:
				FloorId = input.ReadInt32();
				break;
			case 128u:
				NormalScore1 = input.ReadInt32();
				break;
			case 136u:
				EliteScore1 = input.ReadInt32();
				break;
			case 144u:
				BossScore1 = input.ReadInt32();
				break;
			case 152u:
				TimeScore1 = input.ReadInt32();
				break;
			case 160u:
				TimeLimit1 = input.ReadInt32();
				break;
			case 168u:
				NormalScore2 = input.ReadInt32();
				break;
			case 176u:
				EliteScore2 = input.ReadInt32();
				break;
			case 184u:
				BossScore2 = input.ReadInt32();
				break;
			case 192u:
				TimeScore2 = input.ReadInt32();
				break;
			case 200u:
				TimeLimit2 = input.ReadInt32();
				break;
			case 208u:
			case 210u:
				eETScore1_.AddEntriesFrom(input, _repeated_eETScore1_codec);
				break;
			case 216u:
			case 218u:
				eETScore2_.AddEntriesFrom(input, _repeated_eETScore2_codec);
				break;
			case 224u:
				FHPreviewMonsterGroupId = input.ReadInt32();
				break;
			case 232u:
				SHPreviewMonsterGroupId = input.ReadInt32();
				break;
			case 242u:
				CoverEpisode = input.ReadString();
				break;
			case 250u:
				Episode = input.ReadString();
				break;
			case 258u:
				Episode2 = input.ReadString();
				break;
			case 264u:
			case 266u:
				fateCardBundle_.AddEntriesFrom(input, _repeated_fateCardBundle_codec);
				break;
			case 274u:
				SpeciaFateCard = input.ReadString();
				break;
			case 282u:
				SpeciaFateCardParam = input.ReadString();
				break;
			}
		}
	}
}
