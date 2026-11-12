using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class RegionBoss : IMessage<RegionBoss>, IMessage, IEquatable<RegionBoss>, IDeepCloneable<RegionBoss>
{
	private static readonly MessageParser<RegionBoss> _parser = new MessageParser<RegionBoss>(() => new RegionBoss());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MonsterIdFieldNumber = 2;

	private int monsterId_;

	public const int RegionTypeFieldNumber = 3;

	private int regionType_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int IconFieldNumber = 5;

	private string icon_ = "";

	public const int UnlockConditionFieldNumber = 6;

	private string unlockCondition_ = "";

	public const int NeedRoguelikeFieldNumber = 7;

	private int needRoguelike_;

	public const int SortFieldNumber = 8;

	private int sort_;

	public const int OpenDayFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_openDay_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> openDay_ = new RepeatedField<int>();

	public const int OpenDayDescFieldNumber = 10;

	private string openDayDesc_ = "";

	public const int EETFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	public const int EpisodeFieldNumber = 12;

	private string episode_ = "";

	public const int ImageFieldNumber = 13;

	private string image_ = "";

	public const int DropItemFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_dropItem_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> dropItem_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<RegionBoss> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(676);

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
	public int MonsterId
	{
		get
		{
			return monsterId_;
		}
		set
		{
			monsterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RegionType
	{
		get
		{
			return regionType_;
		}
		set
		{
			regionType_ = value;
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
	public string UnlockCondition
	{
		get
		{
			return unlockCondition_;
		}
		set
		{
			unlockCondition_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int NeedRoguelike
	{
		get
		{
			return needRoguelike_;
		}
		set
		{
			needRoguelike_ = value;
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
	public RepeatedField<int> OpenDay => openDay_;

	[DebuggerNonUserCode]
	public string OpenDayDesc
	{
		get
		{
			return openDayDesc_;
		}
		set
		{
			openDayDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> EET => eET_;

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
	public RepeatedField<int> DropItem => dropItem_;

	[DebuggerNonUserCode]
	public RegionBoss()
	{
	}

	[DebuggerNonUserCode]
	public RegionBoss(RegionBoss other)
		: this()
	{
		id_ = other.id_;
		monsterId_ = other.monsterId_;
		regionType_ = other.regionType_;
		name_ = other.name_;
		icon_ = other.icon_;
		unlockCondition_ = other.unlockCondition_;
		needRoguelike_ = other.needRoguelike_;
		sort_ = other.sort_;
		openDay_ = other.openDay_.Clone();
		openDayDesc_ = other.openDayDesc_;
		eET_ = other.eET_.Clone();
		episode_ = other.episode_;
		image_ = other.image_;
		dropItem_ = other.dropItem_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public RegionBoss Clone()
	{
		return new RegionBoss(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as RegionBoss);
	}

	[DebuggerNonUserCode]
	public bool Equals(RegionBoss other)
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
		if (MonsterId != other.MonsterId)
		{
			return false;
		}
		if (RegionType != other.RegionType)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (UnlockCondition != other.UnlockCondition)
		{
			return false;
		}
		if (NeedRoguelike != other.NeedRoguelike)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (!openDay_.Equals(other.openDay_))
		{
			return false;
		}
		if (OpenDayDesc != other.OpenDayDesc)
		{
			return false;
		}
		if (!eET_.Equals(other.eET_))
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
		if (!dropItem_.Equals(other.dropItem_))
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
		if (MonsterId != 0)
		{
			num ^= MonsterId.GetHashCode();
		}
		if (RegionType != 0)
		{
			num ^= RegionType.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (UnlockCondition.Length != 0)
		{
			num ^= UnlockCondition.GetHashCode();
		}
		if (NeedRoguelike != 0)
		{
			num ^= NeedRoguelike.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		num ^= openDay_.GetHashCode();
		if (OpenDayDesc.Length != 0)
		{
			num ^= OpenDayDesc.GetHashCode();
		}
		num ^= eET_.GetHashCode();
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		num ^= dropItem_.GetHashCode();
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
		if (MonsterId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MonsterId);
		}
		if (RegionType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RegionType);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Icon);
		}
		if (UnlockCondition.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(UnlockCondition);
		}
		if (NeedRoguelike != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(NeedRoguelike);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Sort);
		}
		openDay_.WriteTo(output, _repeated_openDay_codec);
		if (OpenDayDesc.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(OpenDayDesc);
		}
		eET_.WriteTo(output, _repeated_eET_codec);
		if (Episode.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(Episode);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(Image);
		}
		dropItem_.WriteTo(output, _repeated_dropItem_codec);
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
		if (MonsterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterId);
		}
		if (RegionType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RegionType);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (UnlockCondition.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UnlockCondition);
		}
		if (NeedRoguelike != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedRoguelike);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		num += openDay_.CalculateSize(_repeated_openDay_codec);
		if (OpenDayDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenDayDesc);
		}
		num += eET_.CalculateSize(_repeated_eET_codec);
		if (Episode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (Image.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Image);
		}
		num += dropItem_.CalculateSize(_repeated_dropItem_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(RegionBoss other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MonsterId != 0)
			{
				MonsterId = other.MonsterId;
			}
			if (other.RegionType != 0)
			{
				RegionType = other.RegionType;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.UnlockCondition.Length != 0)
			{
				UnlockCondition = other.UnlockCondition;
			}
			if (other.NeedRoguelike != 0)
			{
				NeedRoguelike = other.NeedRoguelike;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			openDay_.Add(other.openDay_);
			if (other.OpenDayDesc.Length != 0)
			{
				OpenDayDesc = other.OpenDayDesc;
			}
			eET_.Add(other.eET_);
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			dropItem_.Add(other.dropItem_);
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
				MonsterId = input.ReadInt32();
				break;
			case 24u:
				RegionType = input.ReadInt32();
				break;
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				Icon = input.ReadString();
				break;
			case 50u:
				UnlockCondition = input.ReadString();
				break;
			case 56u:
				NeedRoguelike = input.ReadInt32();
				break;
			case 64u:
				Sort = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				openDay_.AddEntriesFrom(input, _repeated_openDay_codec);
				break;
			case 82u:
				OpenDayDesc = input.ReadString();
				break;
			case 88u:
			case 90u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			case 98u:
				Episode = input.ReadString();
				break;
			case 106u:
				Image = input.ReadString();
				break;
			case 112u:
			case 114u:
				dropItem_.AddEntriesFrom(input, _repeated_dropItem_codec);
				break;
			}
		}
	}
}
