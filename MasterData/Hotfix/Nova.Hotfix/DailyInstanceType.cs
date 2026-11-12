using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DailyInstanceType : IMessage<DailyInstanceType>, IMessage, IEquatable<DailyInstanceType>, IDeepCloneable<DailyInstanceType>
{
	private static readonly MessageParser<DailyInstanceType> _parser = new MessageParser<DailyInstanceType>(() => new DailyInstanceType());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int MainLineIdFieldNumber = 3;

	private int mainLineId_;

	public const int WorldClassLevelFieldNumber = 4;

	private int worldClassLevel_;

	public const int EpisodeFieldNumber = 5;

	private string episode_ = "";

	public const int ImageFieldNumber = 6;

	private string image_ = "";

	public const int SortFieldNumber = 7;

	private int sort_;

	public const int HowRewardFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_howReward_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> howReward_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<DailyInstanceType> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(234);

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
	public int MainLineId
	{
		get
		{
			return mainLineId_;
		}
		set
		{
			mainLineId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WorldClassLevel
	{
		get
		{
			return worldClassLevel_;
		}
		set
		{
			worldClassLevel_ = value;
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
	public RepeatedField<int> HowReward => howReward_;

	[DebuggerNonUserCode]
	public DailyInstanceType()
	{
	}

	[DebuggerNonUserCode]
	public DailyInstanceType(DailyInstanceType other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		mainLineId_ = other.mainLineId_;
		worldClassLevel_ = other.worldClassLevel_;
		episode_ = other.episode_;
		image_ = other.image_;
		sort_ = other.sort_;
		howReward_ = other.howReward_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DailyInstanceType Clone()
	{
		return new DailyInstanceType(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DailyInstanceType);
	}

	[DebuggerNonUserCode]
	public bool Equals(DailyInstanceType other)
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
		if (MainLineId != other.MainLineId)
		{
			return false;
		}
		if (WorldClassLevel != other.WorldClassLevel)
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
		if (Sort != other.Sort)
		{
			return false;
		}
		if (!howReward_.Equals(other.howReward_))
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
		if (MainLineId != 0)
		{
			num ^= MainLineId.GetHashCode();
		}
		if (WorldClassLevel != 0)
		{
			num ^= WorldClassLevel.GetHashCode();
		}
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (Image.Length != 0)
		{
			num ^= Image.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		num ^= howReward_.GetHashCode();
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
		if (MainLineId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(MainLineId);
		}
		if (WorldClassLevel != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(WorldClassLevel);
		}
		if (Episode.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Episode);
		}
		if (Image.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Image);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Sort);
		}
		howReward_.WriteTo(output, _repeated_howReward_codec);
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
		if (MainLineId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MainLineId);
		}
		if (WorldClassLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClassLevel);
		}
		if (Episode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (Image.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Image);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		num += howReward_.CalculateSize(_repeated_howReward_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DailyInstanceType other)
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
			if (other.MainLineId != 0)
			{
				MainLineId = other.MainLineId;
			}
			if (other.WorldClassLevel != 0)
			{
				WorldClassLevel = other.WorldClassLevel;
			}
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.Image.Length != 0)
			{
				Image = other.Image;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			howReward_.Add(other.howReward_);
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
				MainLineId = input.ReadInt32();
				break;
			case 32u:
				WorldClassLevel = input.ReadInt32();
				break;
			case 42u:
				Episode = input.ReadString();
				break;
			case 50u:
				Image = input.ReadString();
				break;
			case 56u:
				Sort = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				howReward_.AddEntriesFrom(input, _repeated_howReward_codec);
				break;
			}
		}
	}
}
