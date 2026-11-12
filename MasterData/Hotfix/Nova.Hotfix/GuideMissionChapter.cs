using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GuideMissionChapter : IMessage<GuideMissionChapter>, IMessage, IEquatable<GuideMissionChapter>, IDeepCloneable<GuideMissionChapter>
{
	private static readonly MessageParser<GuideMissionChapter> _parser = new MessageParser<GuideMissionChapter>(() => new GuideMissionChapter());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StoryIdxFieldNumber = 2;

	private int storyIdx_;

	public const int UnlockTimeFieldNumber = 3;

	private string unlockTime_ = "";

	public const int IconPathFieldNumber = 4;

	private string iconPath_ = "";

	public const int IndexFieldNumber = 5;

	private string index_ = "";

	public const int TitleFieldNumber = 6;

	private string title_ = "";

	public const int PreChapterIdFieldNumber = 7;

	private int preChapterId_;

	[DebuggerNonUserCode]
	public static MessageParser<GuideMissionChapter> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(414);

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
	public int StoryIdx
	{
		get
		{
			return storyIdx_;
		}
		set
		{
			storyIdx_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string UnlockTime
	{
		get
		{
			return unlockTime_;
		}
		set
		{
			unlockTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string IconPath
	{
		get
		{
			return iconPath_;
		}
		set
		{
			iconPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

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
	public int PreChapterId
	{
		get
		{
			return preChapterId_;
		}
		set
		{
			preChapterId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GuideMissionChapter()
	{
	}

	[DebuggerNonUserCode]
	public GuideMissionChapter(GuideMissionChapter other)
		: this()
	{
		id_ = other.id_;
		storyIdx_ = other.storyIdx_;
		unlockTime_ = other.unlockTime_;
		iconPath_ = other.iconPath_;
		index_ = other.index_;
		title_ = other.title_;
		preChapterId_ = other.preChapterId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GuideMissionChapter Clone()
	{
		return new GuideMissionChapter(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GuideMissionChapter);
	}

	[DebuggerNonUserCode]
	public bool Equals(GuideMissionChapter other)
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
		if (StoryIdx != other.StoryIdx)
		{
			return false;
		}
		if (UnlockTime != other.UnlockTime)
		{
			return false;
		}
		if (IconPath != other.IconPath)
		{
			return false;
		}
		if (Index != other.Index)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (PreChapterId != other.PreChapterId)
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
		if (StoryIdx != 0)
		{
			num ^= StoryIdx.GetHashCode();
		}
		if (UnlockTime.Length != 0)
		{
			num ^= UnlockTime.GetHashCode();
		}
		if (IconPath.Length != 0)
		{
			num ^= IconPath.GetHashCode();
		}
		if (Index.Length != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (PreChapterId != 0)
		{
			num ^= PreChapterId.GetHashCode();
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
		if (StoryIdx != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(StoryIdx);
		}
		if (UnlockTime.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(UnlockTime);
		}
		if (IconPath.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(IconPath);
		}
		if (Index.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Index);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Title);
		}
		if (PreChapterId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(PreChapterId);
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
		if (StoryIdx != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(StoryIdx);
		}
		if (UnlockTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(UnlockTime);
		}
		if (IconPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconPath);
		}
		if (Index.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Index);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (PreChapterId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreChapterId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GuideMissionChapter other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StoryIdx != 0)
			{
				StoryIdx = other.StoryIdx;
			}
			if (other.UnlockTime.Length != 0)
			{
				UnlockTime = other.UnlockTime;
			}
			if (other.IconPath.Length != 0)
			{
				IconPath = other.IconPath;
			}
			if (other.Index.Length != 0)
			{
				Index = other.Index;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.PreChapterId != 0)
			{
				PreChapterId = other.PreChapterId;
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
				StoryIdx = input.ReadInt32();
				break;
			case 26u:
				UnlockTime = input.ReadString();
				break;
			case 34u:
				IconPath = input.ReadString();
				break;
			case 42u:
				Index = input.ReadString();
				break;
			case 50u:
				Title = input.ReadString();
				break;
			case 56u:
				PreChapterId = input.ReadInt32();
				break;
			}
		}
	}
}
