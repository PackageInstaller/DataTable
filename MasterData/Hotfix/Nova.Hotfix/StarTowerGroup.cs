using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerGroup : IMessage<StarTowerGroup>, IMessage, IEquatable<StarTowerGroup>, IDeepCloneable<StarTowerGroup>
{
	private static readonly MessageParser<StarTowerGroup> _parser = new MessageParser<StarTowerGroup>(() => new StarTowerGroup());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int EETFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	public const int EpisodeFieldNumber = 4;

	private string episode_ = "";

	public const int CoverImageFieldNumber = 5;

	private string coverImage_ = "";

	public const int SortFieldNumber = 6;

	private int sort_;

	public const int GroupThemeFieldNumber = 7;

	private int groupTheme_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerGroup> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(854);

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
	public string CoverImage
	{
		get
		{
			return coverImage_;
		}
		set
		{
			coverImage_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int GroupTheme
	{
		get
		{
			return groupTheme_;
		}
		set
		{
			groupTheme_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerGroup()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerGroup(StarTowerGroup other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		eET_ = other.eET_.Clone();
		episode_ = other.episode_;
		coverImage_ = other.coverImage_;
		sort_ = other.sort_;
		groupTheme_ = other.groupTheme_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerGroup Clone()
	{
		return new StarTowerGroup(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerGroup);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerGroup other)
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
		if (!eET_.Equals(other.eET_))
		{
			return false;
		}
		if (Episode != other.Episode)
		{
			return false;
		}
		if (CoverImage != other.CoverImage)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (GroupTheme != other.GroupTheme)
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
		num ^= eET_.GetHashCode();
		if (Episode.Length != 0)
		{
			num ^= Episode.GetHashCode();
		}
		if (CoverImage.Length != 0)
		{
			num ^= CoverImage.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		if (GroupTheme != 0)
		{
			num ^= GroupTheme.GetHashCode();
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
		eET_.WriteTo(output, _repeated_eET_codec);
		if (Episode.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Episode);
		}
		if (CoverImage.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(CoverImage);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Sort);
		}
		if (GroupTheme != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(GroupTheme);
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
		num += eET_.CalculateSize(_repeated_eET_codec);
		if (Episode.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Episode);
		}
		if (CoverImage.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CoverImage);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		if (GroupTheme != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupTheme);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerGroup other)
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
			eET_.Add(other.eET_);
			if (other.Episode.Length != 0)
			{
				Episode = other.Episode;
			}
			if (other.CoverImage.Length != 0)
			{
				CoverImage = other.CoverImage;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			if (other.GroupTheme != 0)
			{
				GroupTheme = other.GroupTheme;
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
			case 26u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			case 34u:
				Episode = input.ReadString();
				break;
			case 42u:
				CoverImage = input.ReadString();
				break;
			case 48u:
				Sort = input.ReadInt32();
				break;
			case 56u:
				GroupTheme = input.ReadInt32();
				break;
			}
		}
	}
}
