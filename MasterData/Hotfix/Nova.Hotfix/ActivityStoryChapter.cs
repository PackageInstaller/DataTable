using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityStoryChapter : IMessage<ActivityStoryChapter>, IMessage, IEquatable<ActivityStoryChapter>, IDeepCloneable<ActivityStoryChapter>
{
	private static readonly MessageParser<ActivityStoryChapter> _parser = new MessageParser<ActivityStoryChapter>(() => new ActivityStoryChapter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ChapterIdFieldNumber = 2;

	private int chapterId_;

	public const int SortOrderFieldNumber = 3;

	private int sortOrder_;

	public const int PersonalityIdFieldNumber = 4;

	private int personalityId_;

	public const int ActivityGroupTypeFieldNumber = 5;

	private int activityGroupType_;

	public const int IsPersonalityTouchMainlineFieldNumber = 6;

	private bool isPersonalityTouchMainline_;

	public const int TitleFieldNumber = 7;

	private string title_ = "";

	public const int StoryTimeFieldNumber = 8;

	private string storyTime_ = "";

	public const int StoryLineIdFieldNumber = 9;

	private int storyLineId_;

	public const int PrevChapterTypeFieldNumber = 10;

	private int prevChapterType_;

	public const int PrevChapterIdFieldNumber = 11;

	private int prevChapterId_;

	public const int HandBookIdFieldNumber = 12;

	private int handBookId_;

	public const int IconRes1FieldNumber = 13;

	private string iconRes1_ = "";

	public const int IconRes2FieldNumber = 14;

	private string iconRes2_ = "";

	public const int IconRes3FieldNumber = 15;

	private string iconRes3_ = "";

	public const int BannerFieldNumber = 16;

	private string banner_ = "";

	public const int PanelIdFieldNumber = 17;

	private int panelId_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityStoryChapter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(60);

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
	public int ChapterId
	{
		get
		{
			return chapterId_;
		}
		set
		{
			chapterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SortOrder
	{
		get
		{
			return sortOrder_;
		}
		set
		{
			sortOrder_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PersonalityId
	{
		get
		{
			return personalityId_;
		}
		set
		{
			personalityId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActivityGroupType
	{
		get
		{
			return activityGroupType_;
		}
		set
		{
			activityGroupType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsPersonalityTouchMainline
	{
		get
		{
			return isPersonalityTouchMainline_;
		}
		set
		{
			isPersonalityTouchMainline_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string StoryTime
	{
		get
		{
			return storyTime_;
		}
		set
		{
			storyTime_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int PrevChapterType
	{
		get
		{
			return prevChapterType_;
		}
		set
		{
			prevChapterType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PrevChapterId
	{
		get
		{
			return prevChapterId_;
		}
		set
		{
			prevChapterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HandBookId
	{
		get
		{
			return handBookId_;
		}
		set
		{
			handBookId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string IconRes1
	{
		get
		{
			return iconRes1_;
		}
		set
		{
			iconRes1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string IconRes2
	{
		get
		{
			return iconRes2_;
		}
		set
		{
			iconRes2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string IconRes3
	{
		get
		{
			return iconRes3_;
		}
		set
		{
			iconRes3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Banner
	{
		get
		{
			return banner_;
		}
		set
		{
			banner_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PanelId
	{
		get
		{
			return panelId_;
		}
		set
		{
			panelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityStoryChapter()
	{
	}

	[DebuggerNonUserCode]
	public ActivityStoryChapter(ActivityStoryChapter other)
		: this()
	{
		id_ = other.id_;
		chapterId_ = other.chapterId_;
		sortOrder_ = other.sortOrder_;
		personalityId_ = other.personalityId_;
		activityGroupType_ = other.activityGroupType_;
		isPersonalityTouchMainline_ = other.isPersonalityTouchMainline_;
		title_ = other.title_;
		storyTime_ = other.storyTime_;
		storyLineId_ = other.storyLineId_;
		prevChapterType_ = other.prevChapterType_;
		prevChapterId_ = other.prevChapterId_;
		handBookId_ = other.handBookId_;
		iconRes1_ = other.iconRes1_;
		iconRes2_ = other.iconRes2_;
		iconRes3_ = other.iconRes3_;
		banner_ = other.banner_;
		panelId_ = other.panelId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityStoryChapter Clone()
	{
		return new ActivityStoryChapter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityStoryChapter);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityStoryChapter other)
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
		if (ChapterId != other.ChapterId)
		{
			return false;
		}
		if (SortOrder != other.SortOrder)
		{
			return false;
		}
		if (PersonalityId != other.PersonalityId)
		{
			return false;
		}
		if (ActivityGroupType != other.ActivityGroupType)
		{
			return false;
		}
		if (IsPersonalityTouchMainline != other.IsPersonalityTouchMainline)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (StoryTime != other.StoryTime)
		{
			return false;
		}
		if (StoryLineId != other.StoryLineId)
		{
			return false;
		}
		if (PrevChapterType != other.PrevChapterType)
		{
			return false;
		}
		if (PrevChapterId != other.PrevChapterId)
		{
			return false;
		}
		if (HandBookId != other.HandBookId)
		{
			return false;
		}
		if (IconRes1 != other.IconRes1)
		{
			return false;
		}
		if (IconRes2 != other.IconRes2)
		{
			return false;
		}
		if (IconRes3 != other.IconRes3)
		{
			return false;
		}
		if (Banner != other.Banner)
		{
			return false;
		}
		if (PanelId != other.PanelId)
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
		if (ChapterId != 0)
		{
			num ^= ChapterId.GetHashCode();
		}
		if (SortOrder != 0)
		{
			num ^= SortOrder.GetHashCode();
		}
		if (PersonalityId != 0)
		{
			num ^= PersonalityId.GetHashCode();
		}
		if (ActivityGroupType != 0)
		{
			num ^= ActivityGroupType.GetHashCode();
		}
		if (IsPersonalityTouchMainline)
		{
			num ^= IsPersonalityTouchMainline.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (StoryTime.Length != 0)
		{
			num ^= StoryTime.GetHashCode();
		}
		if (StoryLineId != 0)
		{
			num ^= StoryLineId.GetHashCode();
		}
		if (PrevChapterType != 0)
		{
			num ^= PrevChapterType.GetHashCode();
		}
		if (PrevChapterId != 0)
		{
			num ^= PrevChapterId.GetHashCode();
		}
		if (HandBookId != 0)
		{
			num ^= HandBookId.GetHashCode();
		}
		if (IconRes1.Length != 0)
		{
			num ^= IconRes1.GetHashCode();
		}
		if (IconRes2.Length != 0)
		{
			num ^= IconRes2.GetHashCode();
		}
		if (IconRes3.Length != 0)
		{
			num ^= IconRes3.GetHashCode();
		}
		if (Banner.Length != 0)
		{
			num ^= Banner.GetHashCode();
		}
		if (PanelId != 0)
		{
			num ^= PanelId.GetHashCode();
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
		if (ChapterId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ChapterId);
		}
		if (SortOrder != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SortOrder);
		}
		if (PersonalityId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(PersonalityId);
		}
		if (ActivityGroupType != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ActivityGroupType);
		}
		if (IsPersonalityTouchMainline)
		{
			output.WriteRawTag(48);
			output.WriteBool(IsPersonalityTouchMainline);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Title);
		}
		if (StoryTime.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(StoryTime);
		}
		if (StoryLineId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(StoryLineId);
		}
		if (PrevChapterType != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PrevChapterType);
		}
		if (PrevChapterId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(PrevChapterId);
		}
		if (HandBookId != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(HandBookId);
		}
		if (IconRes1.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(IconRes1);
		}
		if (IconRes2.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(IconRes2);
		}
		if (IconRes3.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(IconRes3);
		}
		if (Banner.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Banner);
		}
		if (PanelId != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(PanelId);
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
		if (ChapterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ChapterId);
		}
		if (SortOrder != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SortOrder);
		}
		if (PersonalityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PersonalityId);
		}
		if (ActivityGroupType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityGroupType);
		}
		if (IsPersonalityTouchMainline)
		{
			num += 2;
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (StoryTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StoryTime);
		}
		if (StoryLineId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StoryLineId);
		}
		if (PrevChapterType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PrevChapterType);
		}
		if (PrevChapterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PrevChapterId);
		}
		if (HandBookId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HandBookId);
		}
		if (IconRes1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes1);
		}
		if (IconRes2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes2);
		}
		if (IconRes3.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes3);
		}
		if (Banner.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Banner);
		}
		if (PanelId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PanelId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityStoryChapter other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ChapterId != 0)
			{
				ChapterId = other.ChapterId;
			}
			if (other.SortOrder != 0)
			{
				SortOrder = other.SortOrder;
			}
			if (other.PersonalityId != 0)
			{
				PersonalityId = other.PersonalityId;
			}
			if (other.ActivityGroupType != 0)
			{
				ActivityGroupType = other.ActivityGroupType;
			}
			if (other.IsPersonalityTouchMainline)
			{
				IsPersonalityTouchMainline = other.IsPersonalityTouchMainline;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.StoryTime.Length != 0)
			{
				StoryTime = other.StoryTime;
			}
			if (other.StoryLineId != 0)
			{
				StoryLineId = other.StoryLineId;
			}
			if (other.PrevChapterType != 0)
			{
				PrevChapterType = other.PrevChapterType;
			}
			if (other.PrevChapterId != 0)
			{
				PrevChapterId = other.PrevChapterId;
			}
			if (other.HandBookId != 0)
			{
				HandBookId = other.HandBookId;
			}
			if (other.IconRes1.Length != 0)
			{
				IconRes1 = other.IconRes1;
			}
			if (other.IconRes2.Length != 0)
			{
				IconRes2 = other.IconRes2;
			}
			if (other.IconRes3.Length != 0)
			{
				IconRes3 = other.IconRes3;
			}
			if (other.Banner.Length != 0)
			{
				Banner = other.Banner;
			}
			if (other.PanelId != 0)
			{
				PanelId = other.PanelId;
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
				ChapterId = input.ReadInt32();
				break;
			case 24u:
				SortOrder = input.ReadInt32();
				break;
			case 32u:
				PersonalityId = input.ReadInt32();
				break;
			case 40u:
				ActivityGroupType = input.ReadInt32();
				break;
			case 48u:
				IsPersonalityTouchMainline = input.ReadBool();
				break;
			case 58u:
				Title = input.ReadString();
				break;
			case 66u:
				StoryTime = input.ReadString();
				break;
			case 72u:
				StoryLineId = input.ReadInt32();
				break;
			case 80u:
				PrevChapterType = input.ReadInt32();
				break;
			case 88u:
				PrevChapterId = input.ReadInt32();
				break;
			case 96u:
				HandBookId = input.ReadInt32();
				break;
			case 106u:
				IconRes1 = input.ReadString();
				break;
			case 114u:
				IconRes2 = input.ReadString();
				break;
			case 122u:
				IconRes3 = input.ReadString();
				break;
			case 130u:
				Banner = input.ReadString();
				break;
			case 136u:
				PanelId = input.ReadInt32();
				break;
			}
		}
	}
}
