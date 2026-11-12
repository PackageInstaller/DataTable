using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityStory : IMessage<ActivityStory>, IMessage, IEquatable<ActivityStory>, IDeepCloneable<ActivityStory>
{
	private static readonly MessageParser<ActivityStory> _parser = new MessageParser<ActivityStory>(() => new ActivityStory());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ChapterIdFieldNumber = 2;

	private int chapterId_;

	public const int DayOpenFieldNumber = 3;

	private int dayOpen_;

	public const int IndexFieldNumber = 4;

	private string index_ = "";

	public const int TitleFieldNumber = 5;

	private string title_ = "";

	public const int IconResFieldNumber = 6;

	private string iconRes_ = "";

	public const int DescFieldNumber = 7;

	private string desc_ = "";

	public const int TypeFieldNumber = 8;

	private int type_;

	public const int IsBattleFieldNumber = 9;

	private bool isBattle_;

	public const int StoryIdFieldNumber = 10;

	private string storyId_ = "";

	public const int FloorIdFieldNumber = 11;

	private static readonly FieldCodec<int> _repeated_floorId_codec = FieldCodec.ForInt32(90u);

	private readonly RepeatedField<int> floorId_ = new RepeatedField<int>();

	public const int TrialBuildFieldNumber = 12;

	private int trialBuild_;

	public const int PreviewMonsterGroupIdFieldNumber = 13;

	private int previewMonsterGroupId_;

	public const int RecommendFieldNumber = 14;

	private string recommend_ = "";

	public const int ConditionIdFieldNumber = 15;

	private int conditionId_;

	public const int IsBranchFieldNumber = 16;

	private bool isBranch_;

	public const int ParentStoryIdFieldNumber = 17;

	private static readonly FieldCodec<string> _repeated_parentStoryId_codec = FieldCodec.ForString(138u);

	private readonly RepeatedField<string> parentStoryId_ = new RepeatedField<string>();

	public const int AimFieldNumber = 18;

	private string aim_ = "";

	public const int HasEvidenceFieldNumber = 19;

	private bool hasEvidence_;

	public const int AvgLuaNameFieldNumber = 20;

	private string avgLuaName_ = "";

	public const int AvgMotionFieldNumber = 21;

	private string avgMotion_ = "";

	public const int IsLastFieldNumber = 22;

	private bool isLast_;

	public const int FirstCompleteRewardFieldNumber = 23;

	private string firstCompleteReward_ = "";

	public const int IconFieldNumber = 24;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<ActivityStory> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(58);

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
	public bool IsBattle
	{
		get
		{
			return isBattle_;
		}
		set
		{
			isBattle_ = value;
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
	public RepeatedField<int> FloorId => floorId_;

	[DebuggerNonUserCode]
	public int TrialBuild
	{
		get
		{
			return trialBuild_;
		}
		set
		{
			trialBuild_ = value;
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
	public string Recommend
	{
		get
		{
			return recommend_;
		}
		set
		{
			recommend_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ConditionId
	{
		get
		{
			return conditionId_;
		}
		set
		{
			conditionId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsBranch
	{
		get
		{
			return isBranch_;
		}
		set
		{
			isBranch_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> ParentStoryId => parentStoryId_;

	[DebuggerNonUserCode]
	public string Aim
	{
		get
		{
			return aim_;
		}
		set
		{
			aim_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool HasEvidence
	{
		get
		{
			return hasEvidence_;
		}
		set
		{
			hasEvidence_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AvgLuaName
	{
		get
		{
			return avgLuaName_;
		}
		set
		{
			avgLuaName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AvgMotion
	{
		get
		{
			return avgMotion_;
		}
		set
		{
			avgMotion_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsLast
	{
		get
		{
			return isLast_;
		}
		set
		{
			isLast_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string FirstCompleteReward
	{
		get
		{
			return firstCompleteReward_;
		}
		set
		{
			firstCompleteReward_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public ActivityStory()
	{
	}

	[DebuggerNonUserCode]
	public ActivityStory(ActivityStory other)
		: this()
	{
		id_ = other.id_;
		chapterId_ = other.chapterId_;
		dayOpen_ = other.dayOpen_;
		index_ = other.index_;
		title_ = other.title_;
		iconRes_ = other.iconRes_;
		desc_ = other.desc_;
		type_ = other.type_;
		isBattle_ = other.isBattle_;
		storyId_ = other.storyId_;
		floorId_ = other.floorId_.Clone();
		trialBuild_ = other.trialBuild_;
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		recommend_ = other.recommend_;
		conditionId_ = other.conditionId_;
		isBranch_ = other.isBranch_;
		parentStoryId_ = other.parentStoryId_.Clone();
		aim_ = other.aim_;
		hasEvidence_ = other.hasEvidence_;
		avgLuaName_ = other.avgLuaName_;
		avgMotion_ = other.avgMotion_;
		isLast_ = other.isLast_;
		firstCompleteReward_ = other.firstCompleteReward_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityStory Clone()
	{
		return new ActivityStory(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityStory);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityStory other)
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
		if (DayOpen != other.DayOpen)
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
		if (IconRes != other.IconRes)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (IsBattle != other.IsBattle)
		{
			return false;
		}
		if (StoryId != other.StoryId)
		{
			return false;
		}
		if (!floorId_.Equals(other.floorId_))
		{
			return false;
		}
		if (TrialBuild != other.TrialBuild)
		{
			return false;
		}
		if (PreviewMonsterGroupId != other.PreviewMonsterGroupId)
		{
			return false;
		}
		if (Recommend != other.Recommend)
		{
			return false;
		}
		if (ConditionId != other.ConditionId)
		{
			return false;
		}
		if (IsBranch != other.IsBranch)
		{
			return false;
		}
		if (!parentStoryId_.Equals(other.parentStoryId_))
		{
			return false;
		}
		if (Aim != other.Aim)
		{
			return false;
		}
		if (HasEvidence != other.HasEvidence)
		{
			return false;
		}
		if (AvgLuaName != other.AvgLuaName)
		{
			return false;
		}
		if (AvgMotion != other.AvgMotion)
		{
			return false;
		}
		if (IsLast != other.IsLast)
		{
			return false;
		}
		if (FirstCompleteReward != other.FirstCompleteReward)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (DayOpen != 0)
		{
			num ^= DayOpen.GetHashCode();
		}
		if (Index.Length != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (IconRes.Length != 0)
		{
			num ^= IconRes.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (IsBattle)
		{
			num ^= IsBattle.GetHashCode();
		}
		if (StoryId.Length != 0)
		{
			num ^= StoryId.GetHashCode();
		}
		num ^= floorId_.GetHashCode();
		if (TrialBuild != 0)
		{
			num ^= TrialBuild.GetHashCode();
		}
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		if (Recommend.Length != 0)
		{
			num ^= Recommend.GetHashCode();
		}
		if (ConditionId != 0)
		{
			num ^= ConditionId.GetHashCode();
		}
		if (IsBranch)
		{
			num ^= IsBranch.GetHashCode();
		}
		num ^= parentStoryId_.GetHashCode();
		if (Aim.Length != 0)
		{
			num ^= Aim.GetHashCode();
		}
		if (HasEvidence)
		{
			num ^= HasEvidence.GetHashCode();
		}
		if (AvgLuaName.Length != 0)
		{
			num ^= AvgLuaName.GetHashCode();
		}
		if (AvgMotion.Length != 0)
		{
			num ^= AvgMotion.GetHashCode();
		}
		if (IsLast)
		{
			num ^= IsLast.GetHashCode();
		}
		if (FirstCompleteReward.Length != 0)
		{
			num ^= FirstCompleteReward.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (DayOpen != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DayOpen);
		}
		if (Index.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Index);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Title);
		}
		if (IconRes.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(IconRes);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Desc);
		}
		if (Type != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Type);
		}
		if (IsBattle)
		{
			output.WriteRawTag(72);
			output.WriteBool(IsBattle);
		}
		if (StoryId.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(StoryId);
		}
		floorId_.WriteTo(output, _repeated_floorId_codec);
		if (TrialBuild != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(TrialBuild);
		}
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		if (Recommend.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Recommend);
		}
		if (ConditionId != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(ConditionId);
		}
		if (IsBranch)
		{
			output.WriteRawTag(128, 1);
			output.WriteBool(IsBranch);
		}
		parentStoryId_.WriteTo(output, _repeated_parentStoryId_codec);
		if (Aim.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(Aim);
		}
		if (HasEvidence)
		{
			output.WriteRawTag(152, 1);
			output.WriteBool(HasEvidence);
		}
		if (AvgLuaName.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(AvgLuaName);
		}
		if (AvgMotion.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(AvgMotion);
		}
		if (IsLast)
		{
			output.WriteRawTag(176, 1);
			output.WriteBool(IsLast);
		}
		if (FirstCompleteReward.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(FirstCompleteReward);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(Icon);
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
		if (DayOpen != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DayOpen);
		}
		if (Index.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Index);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (IconRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (IsBattle)
		{
			num += 2;
		}
		if (StoryId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StoryId);
		}
		num += floorId_.CalculateSize(_repeated_floorId_codec);
		if (TrialBuild != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrialBuild);
		}
		if (PreviewMonsterGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		if (Recommend.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Recommend);
		}
		if (ConditionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ConditionId);
		}
		if (IsBranch)
		{
			num += 3;
		}
		num += parentStoryId_.CalculateSize(_repeated_parentStoryId_codec);
		if (Aim.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Aim);
		}
		if (HasEvidence)
		{
			num += 3;
		}
		if (AvgLuaName.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AvgLuaName);
		}
		if (AvgMotion.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AvgMotion);
		}
		if (IsLast)
		{
			num += 3;
		}
		if (FirstCompleteReward.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(FirstCompleteReward);
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityStory other)
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
			if (other.DayOpen != 0)
			{
				DayOpen = other.DayOpen;
			}
			if (other.Index.Length != 0)
			{
				Index = other.Index;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.IconRes.Length != 0)
			{
				IconRes = other.IconRes;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.IsBattle)
			{
				IsBattle = other.IsBattle;
			}
			if (other.StoryId.Length != 0)
			{
				StoryId = other.StoryId;
			}
			floorId_.Add(other.floorId_);
			if (other.TrialBuild != 0)
			{
				TrialBuild = other.TrialBuild;
			}
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			if (other.Recommend.Length != 0)
			{
				Recommend = other.Recommend;
			}
			if (other.ConditionId != 0)
			{
				ConditionId = other.ConditionId;
			}
			if (other.IsBranch)
			{
				IsBranch = other.IsBranch;
			}
			parentStoryId_.Add(other.parentStoryId_);
			if (other.Aim.Length != 0)
			{
				Aim = other.Aim;
			}
			if (other.HasEvidence)
			{
				HasEvidence = other.HasEvidence;
			}
			if (other.AvgLuaName.Length != 0)
			{
				AvgLuaName = other.AvgLuaName;
			}
			if (other.AvgMotion.Length != 0)
			{
				AvgMotion = other.AvgMotion;
			}
			if (other.IsLast)
			{
				IsLast = other.IsLast;
			}
			if (other.FirstCompleteReward.Length != 0)
			{
				FirstCompleteReward = other.FirstCompleteReward;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				DayOpen = input.ReadInt32();
				break;
			case 34u:
				Index = input.ReadString();
				break;
			case 42u:
				Title = input.ReadString();
				break;
			case 50u:
				IconRes = input.ReadString();
				break;
			case 58u:
				Desc = input.ReadString();
				break;
			case 64u:
				Type = input.ReadInt32();
				break;
			case 72u:
				IsBattle = input.ReadBool();
				break;
			case 82u:
				StoryId = input.ReadString();
				break;
			case 88u:
			case 90u:
				floorId_.AddEntriesFrom(input, _repeated_floorId_codec);
				break;
			case 96u:
				TrialBuild = input.ReadInt32();
				break;
			case 104u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 114u:
				Recommend = input.ReadString();
				break;
			case 120u:
				ConditionId = input.ReadInt32();
				break;
			case 128u:
				IsBranch = input.ReadBool();
				break;
			case 138u:
				parentStoryId_.AddEntriesFrom(input, _repeated_parentStoryId_codec);
				break;
			case 146u:
				Aim = input.ReadString();
				break;
			case 152u:
				HasEvidence = input.ReadBool();
				break;
			case 162u:
				AvgLuaName = input.ReadString();
				break;
			case 170u:
				AvgMotion = input.ReadString();
				break;
			case 176u:
				IsLast = input.ReadBool();
				break;
			case 186u:
				FirstCompleteReward = input.ReadString();
				break;
			case 194u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
