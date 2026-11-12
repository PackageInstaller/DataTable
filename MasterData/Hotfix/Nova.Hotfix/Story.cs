using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Story : IMessage<Story>, IMessage, IEquatable<Story>, IDeepCloneable<Story>
{
	private static readonly MessageParser<Story> _parser = new MessageParser<Story>(() => new Story());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int StoryIdFieldNumber = 2;

	private string storyId_ = "";

	public const int ChapterFieldNumber = 3;

	private int chapter_;

	public const int IndexFieldNumber = 4;

	private string index_ = "";

	public const int TitleFieldNumber = 5;

	private string title_ = "";

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int TrialBuildFieldNumber = 7;

	private int trialBuild_;

	public const int ConditionIdFieldNumber = 8;

	private string conditionId_ = "";

	public const int IsBranchFieldNumber = 9;

	private bool isBranch_;

	public const int IsBattleFieldNumber = 10;

	private bool isBattle_;

	public const int EnterMethodFieldNumber = 11;

	private int enterMethod_;

	public const int RewardFieldNumber = 12;

	private int reward_;

	public const int RewardDisplayFieldNumber = 13;

	private string rewardDisplay_ = "";

	public const int ParentStoryIdFieldNumber = 14;

	private static readonly FieldCodec<string> _repeated_parentStoryId_codec = FieldCodec.ForString(114u);

	private readonly RepeatedField<string> parentStoryId_ = new RepeatedField<string>();

	public const int HasEvidenceFieldNumber = 15;

	private bool hasEvidence_;

	public const int AvgLuaNameFieldNumber = 16;

	private string avgLuaName_ = "";

	public const int FloorIdFieldNumber = 17;

	private static readonly FieldCodec<int> _repeated_floorId_codec = FieldCodec.ForInt32(138u);

	private readonly RepeatedField<int> floorId_ = new RepeatedField<int>();

	public const int PreviewMonsterGroupIdFieldNumber = 18;

	private int previewMonsterGroupId_;

	public const int RecommendFieldNumber = 19;

	private string recommend_ = "";

	public const int AimFieldNumber = 20;

	private string aim_ = "";

	public const int IsLastFieldNumber = 21;

	private bool isLast_;

	public const int AvgMotionFieldNumber = 22;

	private string avgMotion_ = "";

	public const int MemoryTypeFieldNumber = 23;

	private int memoryType_;

	[DebuggerNonUserCode]
	public static MessageParser<Story> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(886);

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
	public int Chapter
	{
		get
		{
			return chapter_;
		}
		set
		{
			chapter_ = value;
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
	public string ConditionId
	{
		get
		{
			return conditionId_;
		}
		set
		{
			conditionId_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int EnterMethod
	{
		get
		{
			return enterMethod_;
		}
		set
		{
			enterMethod_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Reward
	{
		get
		{
			return reward_;
		}
		set
		{
			reward_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string RewardDisplay
	{
		get
		{
			return rewardDisplay_;
		}
		set
		{
			rewardDisplay_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> ParentStoryId => parentStoryId_;

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
	public RepeatedField<int> FloorId => floorId_;

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
	public int MemoryType
	{
		get
		{
			return memoryType_;
		}
		set
		{
			memoryType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public Story()
	{
	}

	[DebuggerNonUserCode]
	public Story(Story other)
		: this()
	{
		id_ = other.id_;
		storyId_ = other.storyId_;
		chapter_ = other.chapter_;
		index_ = other.index_;
		title_ = other.title_;
		desc_ = other.desc_;
		trialBuild_ = other.trialBuild_;
		conditionId_ = other.conditionId_;
		isBranch_ = other.isBranch_;
		isBattle_ = other.isBattle_;
		enterMethod_ = other.enterMethod_;
		reward_ = other.reward_;
		rewardDisplay_ = other.rewardDisplay_;
		parentStoryId_ = other.parentStoryId_.Clone();
		hasEvidence_ = other.hasEvidence_;
		avgLuaName_ = other.avgLuaName_;
		floorId_ = other.floorId_.Clone();
		previewMonsterGroupId_ = other.previewMonsterGroupId_;
		recommend_ = other.recommend_;
		aim_ = other.aim_;
		isLast_ = other.isLast_;
		avgMotion_ = other.avgMotion_;
		memoryType_ = other.memoryType_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Story Clone()
	{
		return new Story(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Story);
	}

	[DebuggerNonUserCode]
	public bool Equals(Story other)
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
		if (StoryId != other.StoryId)
		{
			return false;
		}
		if (Chapter != other.Chapter)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (TrialBuild != other.TrialBuild)
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
		if (IsBattle != other.IsBattle)
		{
			return false;
		}
		if (EnterMethod != other.EnterMethod)
		{
			return false;
		}
		if (Reward != other.Reward)
		{
			return false;
		}
		if (RewardDisplay != other.RewardDisplay)
		{
			return false;
		}
		if (!parentStoryId_.Equals(other.parentStoryId_))
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
		if (!floorId_.Equals(other.floorId_))
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
		if (Aim != other.Aim)
		{
			return false;
		}
		if (IsLast != other.IsLast)
		{
			return false;
		}
		if (AvgMotion != other.AvgMotion)
		{
			return false;
		}
		if (MemoryType != other.MemoryType)
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
		if (StoryId.Length != 0)
		{
			num ^= StoryId.GetHashCode();
		}
		if (Chapter != 0)
		{
			num ^= Chapter.GetHashCode();
		}
		if (Index.Length != 0)
		{
			num ^= Index.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (TrialBuild != 0)
		{
			num ^= TrialBuild.GetHashCode();
		}
		if (ConditionId.Length != 0)
		{
			num ^= ConditionId.GetHashCode();
		}
		if (IsBranch)
		{
			num ^= IsBranch.GetHashCode();
		}
		if (IsBattle)
		{
			num ^= IsBattle.GetHashCode();
		}
		if (EnterMethod != 0)
		{
			num ^= EnterMethod.GetHashCode();
		}
		if (Reward != 0)
		{
			num ^= Reward.GetHashCode();
		}
		if (RewardDisplay.Length != 0)
		{
			num ^= RewardDisplay.GetHashCode();
		}
		num ^= parentStoryId_.GetHashCode();
		if (HasEvidence)
		{
			num ^= HasEvidence.GetHashCode();
		}
		if (AvgLuaName.Length != 0)
		{
			num ^= AvgLuaName.GetHashCode();
		}
		num ^= floorId_.GetHashCode();
		if (PreviewMonsterGroupId != 0)
		{
			num ^= PreviewMonsterGroupId.GetHashCode();
		}
		if (Recommend.Length != 0)
		{
			num ^= Recommend.GetHashCode();
		}
		if (Aim.Length != 0)
		{
			num ^= Aim.GetHashCode();
		}
		if (IsLast)
		{
			num ^= IsLast.GetHashCode();
		}
		if (AvgMotion.Length != 0)
		{
			num ^= AvgMotion.GetHashCode();
		}
		if (MemoryType != 0)
		{
			num ^= MemoryType.GetHashCode();
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
		if (StoryId.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(StoryId);
		}
		if (Chapter != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Chapter);
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (TrialBuild != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(TrialBuild);
		}
		if (ConditionId.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(ConditionId);
		}
		if (IsBranch)
		{
			output.WriteRawTag(72);
			output.WriteBool(IsBranch);
		}
		if (IsBattle)
		{
			output.WriteRawTag(80);
			output.WriteBool(IsBattle);
		}
		if (EnterMethod != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(EnterMethod);
		}
		if (Reward != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Reward);
		}
		if (RewardDisplay.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(RewardDisplay);
		}
		parentStoryId_.WriteTo(output, _repeated_parentStoryId_codec);
		if (HasEvidence)
		{
			output.WriteRawTag(120);
			output.WriteBool(HasEvidence);
		}
		if (AvgLuaName.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(AvgLuaName);
		}
		floorId_.WriteTo(output, _repeated_floorId_codec);
		if (PreviewMonsterGroupId != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(PreviewMonsterGroupId);
		}
		if (Recommend.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Recommend);
		}
		if (Aim.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Aim);
		}
		if (IsLast)
		{
			output.WriteRawTag(168, 1);
			output.WriteBool(IsLast);
		}
		if (AvgMotion.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(AvgMotion);
		}
		if (MemoryType != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(MemoryType);
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
		if (StoryId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(StoryId);
		}
		if (Chapter != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Chapter);
		}
		if (Index.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Index);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (TrialBuild != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TrialBuild);
		}
		if (ConditionId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ConditionId);
		}
		if (IsBranch)
		{
			num += 2;
		}
		if (IsBattle)
		{
			num += 2;
		}
		if (EnterMethod != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnterMethod);
		}
		if (Reward != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward);
		}
		if (RewardDisplay.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RewardDisplay);
		}
		num += parentStoryId_.CalculateSize(_repeated_parentStoryId_codec);
		if (HasEvidence)
		{
			num += 2;
		}
		if (AvgLuaName.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AvgLuaName);
		}
		num += floorId_.CalculateSize(_repeated_floorId_codec);
		if (PreviewMonsterGroupId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PreviewMonsterGroupId);
		}
		if (Recommend.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Recommend);
		}
		if (Aim.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Aim);
		}
		if (IsLast)
		{
			num += 3;
		}
		if (AvgMotion.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AvgMotion);
		}
		if (MemoryType != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MemoryType);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Story other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.StoryId.Length != 0)
			{
				StoryId = other.StoryId;
			}
			if (other.Chapter != 0)
			{
				Chapter = other.Chapter;
			}
			if (other.Index.Length != 0)
			{
				Index = other.Index;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.TrialBuild != 0)
			{
				TrialBuild = other.TrialBuild;
			}
			if (other.ConditionId.Length != 0)
			{
				ConditionId = other.ConditionId;
			}
			if (other.IsBranch)
			{
				IsBranch = other.IsBranch;
			}
			if (other.IsBattle)
			{
				IsBattle = other.IsBattle;
			}
			if (other.EnterMethod != 0)
			{
				EnterMethod = other.EnterMethod;
			}
			if (other.Reward != 0)
			{
				Reward = other.Reward;
			}
			if (other.RewardDisplay.Length != 0)
			{
				RewardDisplay = other.RewardDisplay;
			}
			parentStoryId_.Add(other.parentStoryId_);
			if (other.HasEvidence)
			{
				HasEvidence = other.HasEvidence;
			}
			if (other.AvgLuaName.Length != 0)
			{
				AvgLuaName = other.AvgLuaName;
			}
			floorId_.Add(other.floorId_);
			if (other.PreviewMonsterGroupId != 0)
			{
				PreviewMonsterGroupId = other.PreviewMonsterGroupId;
			}
			if (other.Recommend.Length != 0)
			{
				Recommend = other.Recommend;
			}
			if (other.Aim.Length != 0)
			{
				Aim = other.Aim;
			}
			if (other.IsLast)
			{
				IsLast = other.IsLast;
			}
			if (other.AvgMotion.Length != 0)
			{
				AvgMotion = other.AvgMotion;
			}
			if (other.MemoryType != 0)
			{
				MemoryType = other.MemoryType;
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
				StoryId = input.ReadString();
				break;
			case 24u:
				Chapter = input.ReadInt32();
				break;
			case 34u:
				Index = input.ReadString();
				break;
			case 42u:
				Title = input.ReadString();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 56u:
				TrialBuild = input.ReadInt32();
				break;
			case 66u:
				ConditionId = input.ReadString();
				break;
			case 72u:
				IsBranch = input.ReadBool();
				break;
			case 80u:
				IsBattle = input.ReadBool();
				break;
			case 88u:
				EnterMethod = input.ReadInt32();
				break;
			case 96u:
				Reward = input.ReadInt32();
				break;
			case 106u:
				RewardDisplay = input.ReadString();
				break;
			case 114u:
				parentStoryId_.AddEntriesFrom(input, _repeated_parentStoryId_codec);
				break;
			case 120u:
				HasEvidence = input.ReadBool();
				break;
			case 130u:
				AvgLuaName = input.ReadString();
				break;
			case 136u:
			case 138u:
				floorId_.AddEntriesFrom(input, _repeated_floorId_codec);
				break;
			case 144u:
				PreviewMonsterGroupId = input.ReadInt32();
				break;
			case 154u:
				Recommend = input.ReadString();
				break;
			case 162u:
				Aim = input.ReadString();
				break;
			case 168u:
				IsLast = input.ReadBool();
				break;
			case 178u:
				AvgMotion = input.ReadString();
				break;
			case 184u:
				MemoryType = input.ReadInt32();
				break;
			}
		}
	}
}
