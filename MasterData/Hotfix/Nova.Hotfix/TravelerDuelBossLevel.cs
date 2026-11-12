using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TravelerDuelBossLevel : IMessage<TravelerDuelBossLevel>, IMessage, IEquatable<TravelerDuelBossLevel>, IDeepCloneable<TravelerDuelBossLevel>
{
	private static readonly MessageParser<TravelerDuelBossLevel> _parser = new MessageParser<TravelerDuelBossLevel>(() => new TravelerDuelBossLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BossIdFieldNumber = 2;

	private int bossId_;

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int DescFieldNumber = 4;

	private string desc_ = "";

	public const int SuggestedPowerFieldNumber = 5;

	private int suggestedPower_;

	public const int RecommendBuildRankFieldNumber = 6;

	private int recommendBuildRank_;

	public const int EETFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	public const int TimelimitFieldNumber = 8;

	private int timelimit_;

	public const int PreviewMonsterGroupIdFieldNumber = 9;

	private int previewMonsterGroupId_;

	public const int FloorIdFieldNumber = 10;

	private int floorId_;

	public const int IconFieldNumber = 11;

	private string icon_ = "";

	public const int SkillShowFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_skillShow_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> skillShow_ = new RepeatedField<int>();

	public const int CoverFieldNumber = 13;

	private string cover_ = "";

	public const int SkinIdFieldNumber = 14;

	private int skinId_;

	[DebuggerNonUserCode]
	public static MessageParser<TravelerDuelBossLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1004);

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
	public int BossId
	{
		get
		{
			return bossId_;
		}
		set
		{
			bossId_ = value;
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
	public RepeatedField<int> EET => eET_;

	[DebuggerNonUserCode]
	public int Timelimit
	{
		get
		{
			return timelimit_;
		}
		set
		{
			timelimit_ = value;
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
	public RepeatedField<int> SkillShow => skillShow_;

	[DebuggerNonUserCode]
	public string Cover
	{
		get
		{
			return cover_;
		}
		set
		{
			cover_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SkinId
	{
		get
		{
			return skinId_;
		}
		set
		{
			skinId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TravelerDuelBossLevel()
	{
	}

	[DebuggerNonUserCode]
	public TravelerDuelBossLevel(TravelerDuelBossLevel other)
		: this()
	{
		id_ = other.id_;
		bossId_ = other.bossId_;
		name_ = other.name_;
		desc_ = other.desc_;
		suggestedPower_ = other.suggestedPower_;
		recommendBuildRank_ = other.recommendBuildRank_;
		eET_ = other.eET_.Clone();
		timelimit_ = other.timelimit_;
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		floorId_ = other.floorId_;
		icon_ = other.icon_;
		skillShow_ = other.skillShow_.Clone();
		cover_ = other.cover_;
		skinId_ = other.skinId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TravelerDuelBossLevel Clone()
	{
		return new TravelerDuelBossLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TravelerDuelBossLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(TravelerDuelBossLevel other)
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
		if (BossId != other.BossId)
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
		if (!eET_.Equals(other.eET_))
		{
			return false;
		}
		if (Timelimit != other.Timelimit)
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (!skillShow_.Equals(other.skillShow_))
		{
			return false;
		}
		if (Cover != other.Cover)
		{
			return false;
		}
		if (SkinId != other.SkinId)
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
		if (BossId != 0)
		{
			num ^= BossId.GetHashCode();
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
		num ^= eET_.GetHashCode();
		if (Timelimit != 0)
		{
			num ^= Timelimit.GetHashCode();
		}
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		num ^= skillShow_.GetHashCode();
		if (Cover.Length != 0)
		{
			num ^= Cover.GetHashCode();
		}
		if (SkinId != 0)
		{
			num ^= SkinId.GetHashCode();
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
		if (BossId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BossId);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Desc);
		}
		if (SuggestedPower != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SuggestedPower);
		}
		if (RecommendBuildRank != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(RecommendBuildRank);
		}
		eET_.WriteTo(output, _repeated_eET_codec);
		if (Timelimit != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Timelimit);
		}
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(FloorId);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Icon);
		}
		skillShow_.WriteTo(output, _repeated_skillShow_codec);
		if (Cover.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Cover);
		}
		if (SkinId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(SkinId);
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
		if (BossId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossId);
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
		num += eET_.CalculateSize(_repeated_eET_codec);
		if (Timelimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Timelimit);
		}
		if (PreviewMonsterGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		num += skillShow_.CalculateSize(_repeated_skillShow_codec);
		if (Cover.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Cover);
		}
		if (SkinId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkinId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TravelerDuelBossLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.BossId != 0)
			{
				BossId = other.BossId;
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
			eET_.Add(other.eET_);
			if (other.Timelimit != 0)
			{
				Timelimit = other.Timelimit;
			}
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			skillShow_.Add(other.skillShow_);
			if (other.Cover.Length != 0)
			{
				Cover = other.Cover;
			}
			if (other.SkinId != 0)
			{
				SkinId = other.SkinId;
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
				BossId = input.ReadInt32();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 34u:
				Desc = input.ReadString();
				break;
			case 40u:
				SuggestedPower = input.ReadInt32();
				break;
			case 48u:
				RecommendBuildRank = input.ReadInt32();
				break;
			case 56u:
			case 58u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			case 64u:
				Timelimit = input.ReadInt32();
				break;
			case 72u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 80u:
				FloorId = input.ReadInt32();
				break;
			case 90u:
				Icon = input.ReadString();
				break;
			case 96u:
			case 98u:
				skillShow_.AddEntriesFrom(input, _repeated_skillShow_codec);
				break;
			case 106u:
				Cover = input.ReadString();
				break;
			case 112u:
				SkinId = input.ReadInt32();
				break;
			}
		}
	}
}
