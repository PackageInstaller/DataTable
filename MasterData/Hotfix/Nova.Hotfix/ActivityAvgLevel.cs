using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityAvgLevel : IMessage<ActivityAvgLevel>, IMessage, IEquatable<ActivityAvgLevel>, IDeepCloneable<ActivityAvgLevel>
{
	private static readonly MessageParser<ActivityAvgLevel> _parser = new MessageParser<ActivityAvgLevel>(() => new ActivityAvgLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int PersonalityIdFieldNumber = 3;

	private int personalityId_;

	public const int DayOpenFieldNumber = 4;

	private int dayOpen_;

	public const int IndexFieldNumber = 5;

	private string index_ = "";

	public const int NameFieldNumber = 6;

	private string name_ = "";

	public const int IconResFieldNumber = 7;

	private string iconRes_ = "";

	public const int TypeFieldNumber = 8;

	private int type_;

	public const int PreLevelIdFieldNumber = 9;

	private int preLevelId_;

	public const int StoryIdFieldNumber = 10;

	private string storyId_ = "";

	public const int DescFieldNumber = 11;

	private string desc_ = "";

	public const int FirstCompleteRewardPreviewFieldNumber = 12;

	private string firstCompleteRewardPreview_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityAvgLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(6);

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
	public int ActivityId
	{
		get
		{
			return activityId_;
		}
		set
		{
			activityId_ = value;
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
	public int DayOpen
	{
		get
		{
			return dayOpen_;
		}
		set
		{
			dayOpen_ = value;
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
	public string IconRes
	{
		get
		{
			return iconRes_;
		}
		set
		{
			iconRes_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string StoryId
	{
		get
		{
			return storyId_;
		}
		set
		{
			storyId_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string FirstCompleteRewardPreview
	{
		get
		{
			return firstCompleteRewardPreview_;
		}
		set
		{
			firstCompleteRewardPreview_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public ActivityAvgLevel()
	{
	}

	[DebuggerNonUserCode]
	public ActivityAvgLevel(ActivityAvgLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		personalityId_ = other.personalityId_;
		dayOpen_ = other.dayOpen_;
		index_ = other.index_;
		name_ = other.name_;
		iconRes_ = other.iconRes_;
		type_ = other.type_;
		preLevelId_ = other.preLevelId_;
		storyId_ = other.storyId_;
		desc_ = other.desc_;
		firstCompleteRewardPreview_ = other.firstCompleteRewardPreview_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityAvgLevel Clone()
	{
		return new ActivityAvgLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityAvgLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityAvgLevel other)
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
		if (ActivityId != other.ActivityId)
		{
			return false;
		}
		if (PersonalityId != other.PersonalityId)
		{
			return false;
		}
		if (DayOpen != other.DayOpen)
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
		if (IconRes != other.IconRes)
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
		if (StoryId != other.StoryId)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (FirstCompleteRewardPreview != other.FirstCompleteRewardPreview)
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
		if (ActivityId != 0)
		{
			num ^= ActivityId.GetHashCode();
		}
		if (PersonalityId != 0)
		{
			num ^= PersonalityId.GetHashCode();
		}
		if (DayOpen != 0)
		{
			num ^= DayOpen.GetHashCode();
		}
		if (Index.Length != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (IconRes.Length != 0)
		{
			num ^= IconRes.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (StoryId.Length != 0)
		{
			num ^= StoryId.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (FirstCompleteRewardPreview.Length != 0)
		{
			num ^= FirstCompleteRewardPreview.GetHashCode();
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
		if (ActivityId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(ActivityId);
		}
		if (PersonalityId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PersonalityId);
		}
		if (DayOpen != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(DayOpen);
		}
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
		if (IconRes.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(IconRes);
		}
		if (Type != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Type);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(PreLevelId);
		}
		if (StoryId.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(StoryId);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Desc);
		}
		if (FirstCompleteRewardPreview.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(FirstCompleteRewardPreview);
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
		if (ActivityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ActivityId);
		}
		if (PersonalityId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PersonalityId);
		}
		if (DayOpen != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DayOpen);
		}
		if (Index.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Index);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (IconRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (StoryId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StoryId);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (FirstCompleteRewardPreview.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FirstCompleteRewardPreview);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityAvgLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.ActivityId != 0)
			{
				ActivityId = other.ActivityId;
			}
			if (other.PersonalityId != 0)
			{
				PersonalityId = other.PersonalityId;
			}
			if (other.DayOpen != 0)
			{
				DayOpen = other.DayOpen;
			}
			if (other.Index.Length != 0)
			{
				Index = other.Index;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.IconRes.Length != 0)
			{
				IconRes = other.IconRes;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.StoryId.Length != 0)
			{
				StoryId = other.StoryId;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.FirstCompleteRewardPreview.Length != 0)
			{
				FirstCompleteRewardPreview = other.FirstCompleteRewardPreview;
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
				ActivityId = input.ReadInt32();
				break;
			case 24u:
				PersonalityId = input.ReadInt32();
				break;
			case 32u:
				DayOpen = input.ReadInt32();
				break;
			case 42u:
				Index = input.ReadString();
				break;
			case 50u:
				Name = input.ReadString();
				break;
			case 58u:
				IconRes = input.ReadString();
				break;
			case 64u:
				Type = input.ReadInt32();
				break;
			case 72u:
				PreLevelId = input.ReadInt32();
				break;
			case 82u:
				StoryId = input.ReadString();
				break;
			case 90u:
				Desc = input.ReadString();
				break;
			case 98u:
				FirstCompleteRewardPreview = input.ReadString();
				break;
			}
		}
	}
}
