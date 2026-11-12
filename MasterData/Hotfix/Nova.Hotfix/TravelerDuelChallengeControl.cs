using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TravelerDuelChallengeControl : IMessage<TravelerDuelChallengeControl>, IMessage, IEquatable<TravelerDuelChallengeControl>, IDeepCloneable<TravelerDuelChallengeControl>
{
	private static readonly MessageParser<TravelerDuelChallengeControl> _parser = new MessageParser<TravelerDuelChallengeControl>(() => new TravelerDuelChallengeControl());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int BossLevelIdFieldNumber = 2;

	private int bossLevelId_;

	public const int AffixGroupIdsFieldNumber = 3;

	private string affixGroupIds_ = "";

	public const int QuestGroupIdFieldNumber = 4;

	private int questGroupId_;

	public const int BackGroundSourceFieldNumber = 5;

	private string backGroundSource_ = "";

	public const int OpenTimeFieldNumber = 6;

	private string openTime_ = "";

	public const int EndTimeFieldNumber = 7;

	private string endTime_ = "";

	public const int HotValueRewardsGroupIdFieldNumber = 8;

	private int hotValueRewardsGroupId_;

	public const int TargetGroupIdFieldNumber = 9;

	private int targetGroupId_;

	public const int FansLevelGroupIdFieldNumber = 10;

	private int fansLevelGroupId_;

	public const int HonorIdFieldNumber = 11;

	private int honorId_;

	[DebuggerNonUserCode]
	public static MessageParser<TravelerDuelChallengeControl> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1008);

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
	public int BossLevelId
	{
		get
		{
			return bossLevelId_;
		}
		set
		{
			bossLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AffixGroupIds
	{
		get
		{
			return affixGroupIds_;
		}
		set
		{
			affixGroupIds_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int QuestGroupId
	{
		get
		{
			return questGroupId_;
		}
		set
		{
			questGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BackGroundSource
	{
		get
		{
			return backGroundSource_;
		}
		set
		{
			backGroundSource_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string EndTime
	{
		get
		{
			return endTime_;
		}
		set
		{
			endTime_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int HotValueRewardsGroupId
	{
		get
		{
			return hotValueRewardsGroupId_;
		}
		set
		{
			hotValueRewardsGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TargetGroupId
	{
		get
		{
			return targetGroupId_;
		}
		set
		{
			targetGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FansLevelGroupId
	{
		get
		{
			return fansLevelGroupId_;
		}
		set
		{
			fansLevelGroupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HonorId
	{
		get
		{
			return honorId_;
		}
		set
		{
			honorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeControl()
	{
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeControl(TravelerDuelChallengeControl other)
		: this()
	{
		id_ = other.id_;
		bossLevelId_ = other.bossLevelId_;
		affixGroupIds_ = other.affixGroupIds_;
		questGroupId_ = other.questGroupId_;
		backGroundSource_ = other.backGroundSource_;
		openTime_ = other.openTime_;
		endTime_ = other.endTime_;
		hotValueRewardsGroupId_ = other.hotValueRewardsGroupId_;
		targetGroupId_ = other.targetGroupId_;
		fansLevelGroupId_ = other.fansLevelGroupId_;
		honorId_ = other.honorId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TravelerDuelChallengeControl Clone()
	{
		return new TravelerDuelChallengeControl(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TravelerDuelChallengeControl);
	}

	[DebuggerNonUserCode]
	public bool Equals(TravelerDuelChallengeControl other)
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
		if (BossLevelId != other.BossLevelId)
		{
			return false;
		}
		if (AffixGroupIds != other.AffixGroupIds)
		{
			return false;
		}
		if (QuestGroupId != other.QuestGroupId)
		{
			return false;
		}
		if (BackGroundSource != other.BackGroundSource)
		{
			return false;
		}
		if (OpenTime != other.OpenTime)
		{
			return false;
		}
		if (EndTime != other.EndTime)
		{
			return false;
		}
		if (HotValueRewardsGroupId != other.HotValueRewardsGroupId)
		{
			return false;
		}
		if (TargetGroupId != other.TargetGroupId)
		{
			return false;
		}
		if (FansLevelGroupId != other.FansLevelGroupId)
		{
			return false;
		}
		if (HonorId != other.HonorId)
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
		if (BossLevelId != 0)
		{
			num ^= BossLevelId.GetHashCode();
		}
		if (AffixGroupIds.Length != 0)
		{
			num ^= AffixGroupIds.GetHashCode();
		}
		if (QuestGroupId != 0)
		{
			num ^= QuestGroupId.GetHashCode();
		}
		if (BackGroundSource.Length != 0)
		{
			num ^= BackGroundSource.GetHashCode();
		}
		if (OpenTime.Length != 0)
		{
			num ^= OpenTime.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		if (HotValueRewardsGroupId != 0)
		{
			num ^= HotValueRewardsGroupId.GetHashCode();
		}
		if (TargetGroupId != 0)
		{
			num ^= TargetGroupId.GetHashCode();
		}
		if (FansLevelGroupId != 0)
		{
			num ^= FansLevelGroupId.GetHashCode();
		}
		if (HonorId != 0)
		{
			num ^= HonorId.GetHashCode();
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
		if (BossLevelId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BossLevelId);
		}
		if (AffixGroupIds.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(AffixGroupIds);
		}
		if (QuestGroupId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(QuestGroupId);
		}
		if (BackGroundSource.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(BackGroundSource);
		}
		if (OpenTime.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(OpenTime);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(EndTime);
		}
		if (HotValueRewardsGroupId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(HotValueRewardsGroupId);
		}
		if (TargetGroupId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TargetGroupId);
		}
		if (FansLevelGroupId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(FansLevelGroupId);
		}
		if (HonorId != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(HonorId);
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
		if (BossLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BossLevelId);
		}
		if (AffixGroupIds.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AffixGroupIds);
		}
		if (QuestGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestGroupId);
		}
		if (BackGroundSource.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BackGroundSource);
		}
		if (OpenTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenTime);
		}
		if (EndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		if (HotValueRewardsGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HotValueRewardsGroupId);
		}
		if (TargetGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetGroupId);
		}
		if (FansLevelGroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FansLevelGroupId);
		}
		if (HonorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HonorId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(TravelerDuelChallengeControl other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.BossLevelId != 0)
			{
				BossLevelId = other.BossLevelId;
			}
			if (other.AffixGroupIds.Length != 0)
			{
				AffixGroupIds = other.AffixGroupIds;
			}
			if (other.QuestGroupId != 0)
			{
				QuestGroupId = other.QuestGroupId;
			}
			if (other.BackGroundSource.Length != 0)
			{
				BackGroundSource = other.BackGroundSource;
			}
			if (other.OpenTime.Length != 0)
			{
				OpenTime = other.OpenTime;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			if (other.HotValueRewardsGroupId != 0)
			{
				HotValueRewardsGroupId = other.HotValueRewardsGroupId;
			}
			if (other.TargetGroupId != 0)
			{
				TargetGroupId = other.TargetGroupId;
			}
			if (other.FansLevelGroupId != 0)
			{
				FansLevelGroupId = other.FansLevelGroupId;
			}
			if (other.HonorId != 0)
			{
				HonorId = other.HonorId;
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
				BossLevelId = input.ReadInt32();
				break;
			case 26u:
				AffixGroupIds = input.ReadString();
				break;
			case 32u:
				QuestGroupId = input.ReadInt32();
				break;
			case 42u:
				BackGroundSource = input.ReadString();
				break;
			case 50u:
				OpenTime = input.ReadString();
				break;
			case 58u:
				EndTime = input.ReadString();
				break;
			case 64u:
				HotValueRewardsGroupId = input.ReadInt32();
				break;
			case 72u:
				TargetGroupId = input.ReadInt32();
				break;
			case 80u:
				FansLevelGroupId = input.ReadInt32();
				break;
			case 88u:
				HonorId = input.ReadInt32();
				break;
			}
		}
	}
}
