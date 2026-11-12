using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StoryChapter : IMessage<StoryChapter>, IMessage, IEquatable<StoryChapter>, IDeepCloneable<StoryChapter>
{
	private static readonly MessageParser<StoryChapter> _parser = new MessageParser<StoryChapter>(() => new StoryChapter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TypeFieldNumber = 2;

	private int type_;

	public const int WorldClassFieldNumber = 3;

	private int worldClass_;

	public const int PrevStoriesFieldNumber = 4;

	private static readonly FieldCodec<string> _repeated_prevStories_codec = FieldCodec.ForString(34u);

	private readonly RepeatedField<string> prevStories_ = new RepeatedField<string>();

	public const int IndexFieldNumber = 5;

	private string index_ = "";

	public const int NameFieldNumber = 6;

	private string name_ = "";

	public const int DescFieldNumber = 7;

	private string desc_ = "";

	public const int ChapterIconFieldNumber = 8;

	private string chapterIcon_ = "";

	public const int BannerIconFieldNumber = 9;

	private string bannerIcon_ = "";

	public const int ChapterYearFieldNumber = 10;

	private string chapterYear_ = "";

	public const int UnlockShowStoryIdFieldNumber = 11;

	private int unlockShowStoryId_;

	public const int OpenTimeFieldNumber = 12;

	private string openTime_ = "";

	public const int StoryPanelIdFieldNumber = 13;

	private int storyPanelId_;

	public const int StoryLineIdFieldNumber = 14;

	private int storyLineId_;

	[DebuggerNonUserCode]
	public static MessageParser<StoryChapter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(888);

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
	public int WorldClass
	{
		get
		{
			return worldClass_;
		}
		set
		{
			worldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> PrevStories => prevStories_;

	[DebuggerNonUserCode]
	public string Index
	{
		get
		{
			return index_;
		}
		set
		{
			index_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string ChapterIcon
	{
		get
		{
			return chapterIcon_;
		}
		set
		{
			chapterIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BannerIcon
	{
		get
		{
			return bannerIcon_;
		}
		set
		{
			bannerIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string ChapterYear
	{
		get
		{
			return chapterYear_;
		}
		set
		{
			chapterYear_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int UnlockShowStoryId
	{
		get
		{
			return unlockShowStoryId_;
		}
		set
		{
			unlockShowStoryId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OpenTime
	{
		get
		{
			return openTime_;
		}
		set
		{
			openTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int StoryPanelId
	{
		get
		{
			return storyPanelId_;
		}
		set
		{
			storyPanelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int StoryLineId
	{
		get
		{
			return storyLineId_;
		}
		set
		{
			storyLineId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StoryChapter()
	{
	}

	[DebuggerNonUserCode]
	public StoryChapter(StoryChapter other)
		: this()
	{
		id_ = other.id_;
		type_ = other.type_;
		worldClass_ = other.worldClass_;
		prevStories_ = other.prevStories_.Clone();
		index_ = other.index_;
		name_ = other.name_;
		desc_ = other.desc_;
		chapterIcon_ = other.chapterIcon_;
		bannerIcon_ = other.bannerIcon_;
		chapterYear_ = other.chapterYear_;
		unlockShowStoryId_ = other.unlockShowStoryId_;
		openTime_ = other.openTime_;
		storyPanelId_ = other.storyPanelId_;
		storyLineId_ = other.storyLineId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StoryChapter Clone()
	{
		return new StoryChapter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StoryChapter);
	}

	[DebuggerNonUserCode]
	public bool Equals(StoryChapter other)
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
		if (Type != other.Type)
		{
			return false;
		}
		if (WorldClass != other.WorldClass)
		{
			return false;
		}
		if (!prevStories_.Equals(other.prevStories_))
		{
			return false;
		}
		if (Index != other.Index)
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
		if (ChapterIcon != other.ChapterIcon)
		{
			return false;
		}
		if (BannerIcon != other.BannerIcon)
		{
			return false;
		}
		if (ChapterYear != other.ChapterYear)
		{
			return false;
		}
		if (UnlockShowStoryId != other.UnlockShowStoryId)
		{
			return false;
		}
		if (OpenTime != other.OpenTime)
		{
			return false;
		}
		if (StoryPanelId != other.StoryPanelId)
		{
			return false;
		}
		if (StoryLineId != other.StoryLineId)
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
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (WorldClass != 0)
		{
			num ^= WorldClass.GetHashCode();
		}
		num ^= prevStories_.GetHashCode();
		if (Index.Length != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (ChapterIcon.Length != 0)
		{
			num ^= ChapterIcon.GetHashCode();
		}
		if (BannerIcon.Length != 0)
		{
			num ^= BannerIcon.GetHashCode();
		}
		if (ChapterYear.Length != 0)
		{
			num ^= ChapterYear.GetHashCode();
		}
		if (UnlockShowStoryId != 0)
		{
			num ^= UnlockShowStoryId.GetHashCode();
		}
		if (OpenTime.Length != 0)
		{
			num ^= OpenTime.GetHashCode();
		}
		if (StoryPanelId != 0)
		{
			num ^= StoryPanelId.GetHashCode();
		}
		if (StoryLineId != 0)
		{
			num ^= StoryLineId.GetHashCode();
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
		if (Type != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Type);
		}
		if (WorldClass != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(WorldClass);
		}
		prevStories_.WriteTo(output, _repeated_prevStories_codec);
		if (Index.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Index);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Name);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc);
		}
		if (ChapterIcon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(ChapterIcon);
		}
		if (BannerIcon.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(BannerIcon);
		}
		if (ChapterYear.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(ChapterYear);
		}
		if (UnlockShowStoryId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(UnlockShowStoryId);
		}
		if (OpenTime.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(OpenTime);
		}
		if (StoryPanelId != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(StoryPanelId);
		}
		if (StoryLineId != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(StoryLineId);
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
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (WorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClass);
		}
		num += prevStories_.CalculateSize(_repeated_prevStories_codec);
		if (Index.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Index);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (ChapterIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ChapterIcon);
		}
		if (BannerIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BannerIcon);
		}
		if (ChapterYear.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ChapterYear);
		}
		if (UnlockShowStoryId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockShowStoryId);
		}
		if (OpenTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenTime);
		}
		if (StoryPanelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StoryPanelId);
		}
		if (StoryLineId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StoryLineId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StoryChapter other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.WorldClass != 0)
			{
				WorldClass = other.WorldClass;
			}
			prevStories_.Add(other.prevStories_);
			if (other.Index.Length != 0)
			{
				Index = other.Index;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.ChapterIcon.Length != 0)
			{
				ChapterIcon = other.ChapterIcon;
			}
			if (other.BannerIcon.Length != 0)
			{
				BannerIcon = other.BannerIcon;
			}
			if (other.ChapterYear.Length != 0)
			{
				ChapterYear = other.ChapterYear;
			}
			if (other.UnlockShowStoryId != 0)
			{
				UnlockShowStoryId = other.UnlockShowStoryId;
			}
			if (other.OpenTime.Length != 0)
			{
				OpenTime = other.OpenTime;
			}
			if (other.StoryPanelId != 0)
			{
				StoryPanelId = other.StoryPanelId;
			}
			if (other.StoryLineId != 0)
			{
				StoryLineId = other.StoryLineId;
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
				Type = input.ReadInt32();
				break;
			case 24u:
				WorldClass = input.ReadInt32();
				break;
			case 34u:
				prevStories_.AddEntriesFrom(input, _repeated_prevStories_codec);
				break;
			case 42u:
				Index = input.ReadString();
				break;
			case 50u:
				Name = input.ReadString();
				break;
			case 58u:
				Desc = input.ReadString();
				break;
			case 66u:
				ChapterIcon = input.ReadString();
				break;
			case 74u:
				BannerIcon = input.ReadString();
				break;
			case 82u:
				ChapterYear = input.ReadString();
				break;
			case 88u:
				UnlockShowStoryId = input.ReadInt32();
				break;
			case 98u:
				OpenTime = input.ReadString();
				break;
			case 104u:
				StoryPanelId = input.ReadInt32();
				break;
			case 112u:
				StoryLineId = input.ReadInt32();
				break;
			}
		}
	}
}
