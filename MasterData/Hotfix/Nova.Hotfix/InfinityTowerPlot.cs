using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class InfinityTowerPlot : IMessage<InfinityTowerPlot>, IMessage, IEquatable<InfinityTowerPlot>, IDeepCloneable<InfinityTowerPlot>
{
	private static readonly MessageParser<InfinityTowerPlot> _parser = new MessageParser<InfinityTowerPlot>(() => new InfinityTowerPlot());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int PlotSumFieldNumber = 4;

	private string plotSum_ = "";

	public const int PlotIdFieldNumber = 5;

	private int plotId_;

	public const int AvgIdFieldNumber = 6;

	private string avgId_ = "";

	public const int UnlockCondFieldNumber = 7;

	private int unlockCond_;

	public const int CondParamFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_condParam_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> condParam_ = new RepeatedField<int>();

	public const int RewardItemIdFieldNumber = 9;

	private int rewardItemId_;

	public const int RewardItemQtyFieldNumber = 10;

	private int rewardItemQty_;

	[DebuggerNonUserCode]
	public static MessageParser<InfinityTowerPlot> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(462);

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
	public string PlotSum
	{
		get
		{
			return plotSum_;
		}
		set
		{
			plotSum_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PlotId
	{
		get
		{
			return plotId_;
		}
		set
		{
			plotId_ = value;
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
	public int UnlockCond
	{
		get
		{
			return unlockCond_;
		}
		set
		{
			unlockCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> CondParam => condParam_;

	[DebuggerNonUserCode]
	public int RewardItemId
	{
		get
		{
			return rewardItemId_;
		}
		set
		{
			rewardItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RewardItemQty
	{
		get
		{
			return rewardItemQty_;
		}
		set
		{
			rewardItemQty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public InfinityTowerPlot()
	{
	}

	[DebuggerNonUserCode]
	public InfinityTowerPlot(InfinityTowerPlot other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		desc_ = other.desc_;
		plotSum_ = other.plotSum_;
		plotId_ = other.plotId_;
		avgId_ = other.avgId_;
		unlockCond_ = other.unlockCond_;
		condParam_ = other.condParam_.Clone();
		rewardItemId_ = other.rewardItemId_;
		rewardItemQty_ = other.rewardItemQty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public InfinityTowerPlot Clone()
	{
		return new InfinityTowerPlot(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as InfinityTowerPlot);
	}

	[DebuggerNonUserCode]
	public bool Equals(InfinityTowerPlot other)
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
		if (Desc != other.Desc)
		{
			return false;
		}
		if (PlotSum != other.PlotSum)
		{
			return false;
		}
		if (PlotId != other.PlotId)
		{
			return false;
		}
		if (AvgId != other.AvgId)
		{
			return false;
		}
		if (UnlockCond != other.UnlockCond)
		{
			return false;
		}
		if (!condParam_.Equals(other.condParam_))
		{
			return false;
		}
		if (RewardItemId != other.RewardItemId)
		{
			return false;
		}
		if (RewardItemQty != other.RewardItemQty)
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
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (PlotSum.Length != 0)
		{
			num ^= PlotSum.GetHashCode();
		}
		if (PlotId != 0)
		{
			num ^= PlotId.GetHashCode();
		}
		if (AvgId.Length != 0)
		{
			num ^= AvgId.GetHashCode();
		}
		if (UnlockCond != 0)
		{
			num ^= UnlockCond.GetHashCode();
		}
		num ^= condParam_.GetHashCode();
		if (RewardItemId != 0)
		{
			num ^= RewardItemId.GetHashCode();
		}
		if (RewardItemQty != 0)
		{
			num ^= RewardItemQty.GetHashCode();
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
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (PlotSum.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(PlotSum);
		}
		if (PlotId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(PlotId);
		}
		if (AvgId.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(AvgId);
		}
		if (UnlockCond != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(UnlockCond);
		}
		condParam_.WriteTo(output, _repeated_condParam_codec);
		if (RewardItemId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RewardItemId);
		}
		if (RewardItemQty != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(RewardItemQty);
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
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (PlotSum.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PlotSum);
		}
		if (PlotId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PlotId);
		}
		if (AvgId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgId);
		}
		if (UnlockCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockCond);
		}
		num += condParam_.CalculateSize(_repeated_condParam_codec);
		if (RewardItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardItemId);
		}
		if (RewardItemQty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardItemQty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(InfinityTowerPlot other)
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
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.PlotSum.Length != 0)
			{
				PlotSum = other.PlotSum;
			}
			if (other.PlotId != 0)
			{
				PlotId = other.PlotId;
			}
			if (other.AvgId.Length != 0)
			{
				AvgId = other.AvgId;
			}
			if (other.UnlockCond != 0)
			{
				UnlockCond = other.UnlockCond;
			}
			condParam_.Add(other.condParam_);
			if (other.RewardItemId != 0)
			{
				RewardItemId = other.RewardItemId;
			}
			if (other.RewardItemQty != 0)
			{
				RewardItemQty = other.RewardItemQty;
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
			case 26u:
				Desc = input.ReadString();
				break;
			case 34u:
				PlotSum = input.ReadString();
				break;
			case 40u:
				PlotId = input.ReadInt32();
				break;
			case 50u:
				AvgId = input.ReadString();
				break;
			case 56u:
				UnlockCond = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				condParam_.AddEntriesFrom(input, _repeated_condParam_codec);
				break;
			case 72u:
				RewardItemId = input.ReadInt32();
				break;
			case 80u:
				RewardItemQty = input.ReadInt32();
				break;
			}
		}
	}
}
