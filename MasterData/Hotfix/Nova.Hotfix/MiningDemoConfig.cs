using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MiningDemoConfig : IMessage<MiningDemoConfig>, IMessage, IEquatable<MiningDemoConfig>, IDeepCloneable<MiningDemoConfig>
{
	private static readonly MessageParser<MiningDemoConfig> _parser = new MessageParser<MiningDemoConfig>(() => new MiningDemoConfig());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int GridListFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_gridList_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> gridList_ = new RepeatedField<int>();

	public const int RewardListFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_rewardList_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> rewardList_ = new RepeatedField<int>();

	public const int RewardAIndexFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_rewardAIndex_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> rewardAIndex_ = new RepeatedField<int>();

	public const int RewardBIndexFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_rewardBIndex_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> rewardBIndex_ = new RepeatedField<int>();

	public const int RewardCIndexFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_rewardCIndex_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> rewardCIndex_ = new RepeatedField<int>();

	public const int RewardDIndexFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_rewardDIndex_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> rewardDIndex_ = new RepeatedField<int>();

	public const int RewardDirFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_rewardDir_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> rewardDir_ = new RepeatedField<int>();

	public const int GridCoordsFieldNumber = 9;

	private string gridCoords_ = "";

	public const int TreasureGroupIndexFieldNumber = 10;

	private int treasureGroupIndex_;

	public const int CheckFieldNumber = 11;

	private string check_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MiningDemoConfig> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(552);

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
	public RepeatedField<int> GridList => gridList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RewardList => rewardList_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RewardAIndex => rewardAIndex_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RewardBIndex => rewardBIndex_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RewardCIndex => rewardCIndex_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RewardDIndex => rewardDIndex_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RewardDir => rewardDir_;

	[DebuggerNonUserCode]
	public string GridCoords
	{
		get
		{
			return gridCoords_;
		}
		set
		{
			gridCoords_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TreasureGroupIndex
	{
		get
		{
			return treasureGroupIndex_;
		}
		set
		{
			treasureGroupIndex_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Check
	{
		get
		{
			return check_;
		}
		set
		{
			check_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MiningDemoConfig()
	{
	}

	[DebuggerNonUserCode]
	public MiningDemoConfig(MiningDemoConfig other)
		: this()
	{
		id_ = other.id_;
		gridList_ = other.gridList_.Clone();
		rewardList_ = other.rewardList_.Clone();
		rewardAIndex_ = other.rewardAIndex_.Clone();
		rewardBIndex_ = other.rewardBIndex_.Clone();
		rewardCIndex_ = other.rewardCIndex_.Clone();
		rewardDIndex_ = other.rewardDIndex_.Clone();
		rewardDir_ = other.rewardDir_.Clone();
		gridCoords_ = other.gridCoords_;
		treasureGroupIndex_ = other.treasureGroupIndex_;
		check_ = other.check_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MiningDemoConfig Clone()
	{
		return new MiningDemoConfig(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MiningDemoConfig);
	}

	[DebuggerNonUserCode]
	public bool Equals(MiningDemoConfig other)
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
		if (!gridList_.Equals(other.gridList_))
		{
			return false;
		}
		if (!rewardList_.Equals(other.rewardList_))
		{
			return false;
		}
		if (!rewardAIndex_.Equals(other.rewardAIndex_))
		{
			return false;
		}
		if (!rewardBIndex_.Equals(other.rewardBIndex_))
		{
			return false;
		}
		if (!rewardCIndex_.Equals(other.rewardCIndex_))
		{
			return false;
		}
		if (!rewardDIndex_.Equals(other.rewardDIndex_))
		{
			return false;
		}
		if (!rewardDir_.Equals(other.rewardDir_))
		{
			return false;
		}
		if (GridCoords != other.GridCoords)
		{
			return false;
		}
		if (TreasureGroupIndex != other.TreasureGroupIndex)
		{
			return false;
		}
		if (Check != other.Check)
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
		num ^= gridList_.GetHashCode();
		num ^= rewardList_.GetHashCode();
		num ^= rewardAIndex_.GetHashCode();
		num ^= rewardBIndex_.GetHashCode();
		num ^= rewardCIndex_.GetHashCode();
		num ^= rewardDIndex_.GetHashCode();
		num ^= rewardDir_.GetHashCode();
		if (GridCoords.Length != 0)
		{
			num ^= GridCoords.GetHashCode();
		}
		if (TreasureGroupIndex != 0)
		{
			num ^= TreasureGroupIndex.GetHashCode();
		}
		if (Check.Length != 0)
		{
			num ^= Check.GetHashCode();
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
		gridList_.WriteTo(output, _repeated_gridList_codec);
		rewardList_.WriteTo(output, _repeated_rewardList_codec);
		rewardAIndex_.WriteTo(output, _repeated_rewardAIndex_codec);
		rewardBIndex_.WriteTo(output, _repeated_rewardBIndex_codec);
		rewardCIndex_.WriteTo(output, _repeated_rewardCIndex_codec);
		rewardDIndex_.WriteTo(output, _repeated_rewardDIndex_codec);
		rewardDir_.WriteTo(output, _repeated_rewardDir_codec);
		if (GridCoords.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(GridCoords);
		}
		if (TreasureGroupIndex != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(TreasureGroupIndex);
		}
		if (Check.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Check);
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
		num += gridList_.CalculateSize(_repeated_gridList_codec);
		num += rewardList_.CalculateSize(_repeated_rewardList_codec);
		num += rewardAIndex_.CalculateSize(_repeated_rewardAIndex_codec);
		num += rewardBIndex_.CalculateSize(_repeated_rewardBIndex_codec);
		num += rewardCIndex_.CalculateSize(_repeated_rewardCIndex_codec);
		num += rewardDIndex_.CalculateSize(_repeated_rewardDIndex_codec);
		num += rewardDir_.CalculateSize(_repeated_rewardDir_codec);
		if (GridCoords.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GridCoords);
		}
		if (TreasureGroupIndex != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TreasureGroupIndex);
		}
		if (Check.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Check);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MiningDemoConfig other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			gridList_.Add(other.gridList_);
			rewardList_.Add(other.rewardList_);
			rewardAIndex_.Add(other.rewardAIndex_);
			rewardBIndex_.Add(other.rewardBIndex_);
			rewardCIndex_.Add(other.rewardCIndex_);
			rewardDIndex_.Add(other.rewardDIndex_);
			rewardDir_.Add(other.rewardDir_);
			if (other.GridCoords.Length != 0)
			{
				GridCoords = other.GridCoords;
			}
			if (other.TreasureGroupIndex != 0)
			{
				TreasureGroupIndex = other.TreasureGroupIndex;
			}
			if (other.Check.Length != 0)
			{
				Check = other.Check;
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
			case 18u:
				gridList_.AddEntriesFrom(input, _repeated_gridList_codec);
				break;
			case 24u:
			case 26u:
				rewardList_.AddEntriesFrom(input, _repeated_rewardList_codec);
				break;
			case 32u:
			case 34u:
				rewardAIndex_.AddEntriesFrom(input, _repeated_rewardAIndex_codec);
				break;
			case 40u:
			case 42u:
				rewardBIndex_.AddEntriesFrom(input, _repeated_rewardBIndex_codec);
				break;
			case 48u:
			case 50u:
				rewardCIndex_.AddEntriesFrom(input, _repeated_rewardCIndex_codec);
				break;
			case 56u:
			case 58u:
				rewardDIndex_.AddEntriesFrom(input, _repeated_rewardDIndex_codec);
				break;
			case 64u:
			case 66u:
				rewardDir_.AddEntriesFrom(input, _repeated_rewardDir_codec);
				break;
			case 74u:
				GridCoords = input.ReadString();
				break;
			case 80u:
				TreasureGroupIndex = input.ReadInt32();
				break;
			case 90u:
				Check = input.ReadString();
				break;
			}
		}
	}
}
