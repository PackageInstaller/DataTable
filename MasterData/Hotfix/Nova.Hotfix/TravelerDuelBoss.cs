using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TravelerDuelBoss : IMessage<TravelerDuelBoss>, IMessage, IEquatable<TravelerDuelBoss>, IDeepCloneable<TravelerDuelBoss>
{
	private static readonly MessageParser<TravelerDuelBoss> _parser = new MessageParser<TravelerDuelBoss>(() => new TravelerDuelBoss());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int TravelerDuelBossTypeFieldNumber = 3;

	private int travelerDuelBossType_;

	public const int EpisodeFieldNumber = 4;

	private string episode_ = "";

	public const int ImageFieldNumber = 5;

	private string image_ = "";

	public const int CoverFieldNumber = 6;

	private string cover_ = "";

	public const int ShowRewardFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_showReward_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> showReward_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<TravelerDuelBoss> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1002);

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
	public int TravelerDuelBossType
	{
		get
		{
			return travelerDuelBossType_;
		}
		set
		{
			travelerDuelBossType_ = value;
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
	public RepeatedField<int> ShowReward => showReward_;

	[DebuggerNonUserCode]
	public TravelerDuelBoss()
	{
	}

	[DebuggerNonUserCode]
	public TravelerDuelBoss(TravelerDuelBoss other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		travelerDuelBossType_ = other.travelerDuelBossType_;
		episode_ = other.episode_;
		image_ = other.image_;
		cover_ = other.cover_;
		showReward_ = other.showReward_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TravelerDuelBoss Clone()
	{
		return new TravelerDuelBoss(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TravelerDuelBoss);
	}

	[DebuggerNonUserCode]
	public bool Equals(TravelerDuelBoss other)
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
		if (TravelerDuelBossType != other.TravelerDuelBossType)
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
		if (Cover != other.Cover)
		{
			return false;
		}
		if (!showReward_.Equals(other.showReward_))
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
		if (TravelerDuelBossType != 0)
		{
			num ^= TravelerDuelBossType.GetHashCode();
		}
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		if (Cover.Length != 0)
		{
			num ^= Cover.GetHashCode();
		}
		num ^= showReward_.GetHashCode();
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
		if (TravelerDuelBossType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TravelerDuelBossType);
		}
		if (Episode.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Episode);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Image);
		}
		if (Cover.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Cover);
		}
		showReward_.WriteTo(output, _repeated_showReward_codec);
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
		if (TravelerDuelBossType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TravelerDuelBossType);
		}
		if (Episode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (Image.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (Cover.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Cover);
		}
		num += showReward_.CalculateSize(_repeated_showReward_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TravelerDuelBoss other)
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
			if (other.TravelerDuelBossType != 0)
			{
				TravelerDuelBossType = other.TravelerDuelBossType;
			}
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			if (other.Cover.Length != 0)
			{
				Cover = other.Cover;
			}
			showReward_.Add(other.showReward_);
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
				TravelerDuelBossType = input.ReadInt32();
				break;
			case 34u:
				Episode = input.ReadString();
				break;
			case 42u:
				Image = input.ReadString();
				break;
			case 50u:
				Cover = input.ReadString();
				break;
			case 56u:
			case 58u:
				showReward_.AddEntriesFrom(input, _repeated_showReward_codec);
				break;
			}
		}
	}
}
