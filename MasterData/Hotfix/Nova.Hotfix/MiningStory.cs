using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MiningStory : IMessage<MiningStory>, IMessage, IEquatable<MiningStory>, IDeepCloneable<MiningStory>
{
	private static readonly MessageParser<MiningStory> _parser = new MessageParser<MiningStory>(() => new MiningStory());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int GroupIdFieldNumber = 3;

	private int groupId_;

	public const int TitleFieldNumber = 4;

	private string title_ = "";

	public const int AvgIdFieldNumber = 5;

	private string avgId_ = "";

	public const int PrePlotFieldNumber = 6;

	private int prePlot_;

	public const int UnlockLayerFieldNumber = 7;

	private int unlockLayer_;

	public const int PicPathFieldNumber = 8;

	private string picPath_ = "";

	public const int RewardFieldNumber = 9;

	private int reward_;

	public const int RewardQtyFieldNumber = 10;

	private int rewardQty_;

	[DebuggerNonUserCode]
	public static MessageParser<MiningStory> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(560);

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
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
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
	public string AvgId
	{
		get
		{
			return avgId_;
		}
		set
		{
			avgId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PrePlot
	{
		get
		{
			return prePlot_;
		}
		set
		{
			prePlot_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UnlockLayer
	{
		get
		{
			return unlockLayer_;
		}
		set
		{
			unlockLayer_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PicPath
	{
		get
		{
			return picPath_;
		}
		set
		{
			picPath_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int RewardQty
	{
		get
		{
			return rewardQty_;
		}
		set
		{
			rewardQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public MiningStory()
	{
	}

	[DebuggerNonUserCode]
	public MiningStory(MiningStory other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		groupId_ = other.groupId_;
		title_ = other.title_;
		avgId_ = other.avgId_;
		prePlot_ = other.prePlot_;
		unlockLayer_ = other.unlockLayer_;
		picPath_ = other.picPath_;
		reward_ = other.reward_;
		rewardQty_ = other.rewardQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MiningStory Clone()
	{
		return new MiningStory(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MiningStory);
	}

	[DebuggerNonUserCode]
	public bool Equals(MiningStory other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Title != other.Title)
		{
			return false;
		}
		if (AvgId != other.AvgId)
		{
			return false;
		}
		if (PrePlot != other.PrePlot)
		{
			return false;
		}
		if (UnlockLayer != other.UnlockLayer)
		{
			return false;
		}
		if (PicPath != other.PicPath)
		{
			return false;
		}
		if (Reward != other.Reward)
		{
			return false;
		}
		if (RewardQty != other.RewardQty)
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
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (AvgId.Length != 0)
		{
			num ^= AvgId.GetHashCode();
		}
		if (PrePlot != 0)
		{
			num ^= PrePlot.GetHashCode();
		}
		if (UnlockLayer != 0)
		{
			num ^= UnlockLayer.GetHashCode();
		}
		if (PicPath.Length != 0)
		{
			num ^= PicPath.GetHashCode();
		}
		if (Reward != 0)
		{
			num ^= Reward.GetHashCode();
		}
		if (RewardQty != 0)
		{
			num ^= RewardQty.GetHashCode();
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
		if (GroupId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(GroupId);
		}
		if (Title.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Title);
		}
		if (AvgId.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(AvgId);
		}
		if (PrePlot != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PrePlot);
		}
		if (UnlockLayer != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(UnlockLayer);
		}
		if (PicPath.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(PicPath);
		}
		if (Reward != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(Reward);
		}
		if (RewardQty != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(RewardQty);
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
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (AvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgId);
		}
		if (PrePlot != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PrePlot);
		}
		if (UnlockLayer != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockLayer);
		}
		if (PicPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PicPath);
		}
		if (Reward != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Reward);
		}
		if (RewardQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MiningStory other)
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
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.AvgId.Length != 0)
			{
				AvgId = other.AvgId;
			}
			if (other.PrePlot != 0)
			{
				PrePlot = other.PrePlot;
			}
			if (other.UnlockLayer != 0)
			{
				UnlockLayer = other.UnlockLayer;
			}
			if (other.PicPath.Length != 0)
			{
				PicPath = other.PicPath;
			}
			if (other.Reward != 0)
			{
				Reward = other.Reward;
			}
			if (other.RewardQty != 0)
			{
				RewardQty = other.RewardQty;
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
				GroupId = input.ReadInt32();
				break;
			case 34u:
				Title = input.ReadString();
				break;
			case 42u:
				AvgId = input.ReadString();
				break;
			case 48u:
				PrePlot = input.ReadInt32();
				break;
			case 56u:
				UnlockLayer = input.ReadInt32();
				break;
			case 66u:
				PicPath = input.ReadString();
				break;
			case 72u:
				Reward = input.ReadInt32();
				break;
			case 80u:
				RewardQty = input.ReadInt32();
				break;
			}
		}
	}
}
