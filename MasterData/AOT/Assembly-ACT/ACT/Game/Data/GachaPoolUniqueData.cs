using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class GachaPoolUniqueData : IMessage<GachaPoolUniqueData>, IMessage, IEquatable<GachaPoolUniqueData>, IDeepCloneable<GachaPoolUniqueData>, IBufferMessage
{
	private static readonly MessageParser<GachaPoolUniqueData> _parser = new MessageParser<GachaPoolUniqueData>(() => new GachaPoolUniqueData());

	private UnknownFieldSet _unknownFields;

	public const int TotalCountFieldNumber = 1;

	private int totalCount_;

	public const int TakenBonusFieldNumber = 2;

	private static readonly MapField<int, bool>.Codec _map_takenBonus_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 18u);

	private readonly MapField<int, bool> takenBonus_ = new MapField<int, bool>();

	public const int PoolIdFieldNumber = 3;

	private int poolId_;

	public const int HasTakenMilestoneRewardFieldNumber = 4;

	private bool hasTakenMilestoneReward_;

	public const int TiggeredFirstGuaranteedFieldNumber = 5;

	private bool tiggeredFirstGuaranteed_;

	public const int TargetGachaItemIdFieldNumber = 6;

	private int targetGachaItemId_;

	public const int TargetPointFieldNumber = 7;

	private int targetPoint_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<GachaPoolUniqueData> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[157];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TotalCount
	{
		get
		{
			return totalCount_;
		}
		set
		{
			totalCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> TakenBonus => takenBonus_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int PoolId
	{
		get
		{
			return poolId_;
		}
		set
		{
			poolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool HasTakenMilestoneReward
	{
		get
		{
			return hasTakenMilestoneReward_;
		}
		set
		{
			hasTakenMilestoneReward_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool TiggeredFirstGuaranteed
	{
		get
		{
			return tiggeredFirstGuaranteed_;
		}
		set
		{
			tiggeredFirstGuaranteed_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TargetGachaItemId
	{
		get
		{
			return targetGachaItemId_;
		}
		set
		{
			targetGachaItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int TargetPoint
	{
		get
		{
			return targetPoint_;
		}
		set
		{
			targetPoint_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolUniqueData()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolUniqueData(GachaPoolUniqueData other)
		: this()
	{
		totalCount_ = other.totalCount_;
		takenBonus_ = other.takenBonus_.Clone();
		poolId_ = other.poolId_;
		hasTakenMilestoneReward_ = other.hasTakenMilestoneReward_;
		tiggeredFirstGuaranteed_ = other.tiggeredFirstGuaranteed_;
		targetGachaItemId_ = other.targetGachaItemId_;
		targetPoint_ = other.targetPoint_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public GachaPoolUniqueData Clone()
	{
		return new GachaPoolUniqueData(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as GachaPoolUniqueData);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(GachaPoolUniqueData other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (TotalCount != other.TotalCount)
		{
			return false;
		}
		if (!TakenBonus.Equals(other.TakenBonus))
		{
			return false;
		}
		if (PoolId != other.PoolId)
		{
			return false;
		}
		if (HasTakenMilestoneReward != other.HasTakenMilestoneReward)
		{
			return false;
		}
		if (TiggeredFirstGuaranteed != other.TiggeredFirstGuaranteed)
		{
			return false;
		}
		if (TargetGachaItemId != other.TargetGachaItemId)
		{
			return false;
		}
		if (TargetPoint != other.TargetPoint)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (TotalCount != 0)
		{
			num ^= TotalCount.GetHashCode();
		}
		num ^= TakenBonus.GetHashCode();
		if (PoolId != 0)
		{
			num ^= PoolId.GetHashCode();
		}
		if (HasTakenMilestoneReward)
		{
			num ^= HasTakenMilestoneReward.GetHashCode();
		}
		if (TiggeredFirstGuaranteed)
		{
			num ^= TiggeredFirstGuaranteed.GetHashCode();
		}
		if (TargetGachaItemId != 0)
		{
			num ^= TargetGachaItemId.GetHashCode();
		}
		if (TargetPoint != 0)
		{
			num ^= TargetPoint.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (TotalCount != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(TotalCount);
		}
		takenBonus_.WriteTo(ref output, _map_takenBonus_codec);
		if (PoolId != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(PoolId);
		}
		if (HasTakenMilestoneReward)
		{
			output.WriteRawTag(32);
			output.WriteBool(HasTakenMilestoneReward);
		}
		if (TiggeredFirstGuaranteed)
		{
			output.WriteRawTag(40);
			output.WriteBool(TiggeredFirstGuaranteed);
		}
		if (TargetGachaItemId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TargetGachaItemId);
		}
		if (TargetPoint != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(TargetPoint);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (TotalCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalCount);
		}
		num += takenBonus_.CalculateSize(_map_takenBonus_codec);
		if (PoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PoolId);
		}
		if (HasTakenMilestoneReward)
		{
			num += 2;
		}
		if (TiggeredFirstGuaranteed)
		{
			num += 2;
		}
		if (TargetGachaItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetGachaItemId);
		}
		if (TargetPoint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetPoint);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(GachaPoolUniqueData other)
	{
		if (other != null)
		{
			if (other.TotalCount != 0)
			{
				TotalCount = other.TotalCount;
			}
			takenBonus_.Add(other.takenBonus_);
			if (other.PoolId != 0)
			{
				PoolId = other.PoolId;
			}
			if (other.HasTakenMilestoneReward)
			{
				HasTakenMilestoneReward = other.HasTakenMilestoneReward;
			}
			if (other.TiggeredFirstGuaranteed)
			{
				TiggeredFirstGuaranteed = other.TiggeredFirstGuaranteed;
			}
			if (other.TargetGachaItemId != 0)
			{
				TargetGachaItemId = other.TargetGachaItemId;
			}
			if (other.TargetPoint != 0)
			{
				TargetPoint = other.TargetPoint;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				TotalCount = input.ReadInt32();
				break;
			case 18u:
				takenBonus_.AddEntriesFrom(ref input, _map_takenBonus_codec);
				break;
			case 24u:
				PoolId = input.ReadInt32();
				break;
			case 32u:
				HasTakenMilestoneReward = input.ReadBool();
				break;
			case 40u:
				TiggeredFirstGuaranteed = input.ReadBool();
				break;
			case 48u:
				TargetGachaItemId = input.ReadInt32();
				break;
			case 56u:
				TargetPoint = input.ReadInt32();
				break;
			}
		}
	}
}
