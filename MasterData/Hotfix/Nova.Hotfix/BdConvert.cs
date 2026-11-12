using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BdConvert : IMessage<BdConvert>, IMessage, IEquatable<BdConvert>, IDeepCloneable<BdConvert>
{
	private static readonly MessageParser<BdConvert> _parser = new MessageParser<BdConvert>(() => new BdConvert());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int OptionListFieldNumber = 2;

	private static readonly FieldCodec<int> _repeated_optionList_codec = FieldCodec.ForInt32(18u);

	private readonly RepeatedField<int> optionList_ = new RepeatedField<int>();

	public const int RewardGroupFieldNumber = 3;

	private int rewardGroup_;

	public const int ScoreItemIdFieldNumber = 4;

	private int scoreItemId_;

	public const int ScoreItemLimitFieldNumber = 5;

	private int scoreItemLimit_;

	[DebuggerNonUserCode]
	public static MessageParser<BdConvert> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(120);

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
	public RepeatedField<int> OptionList => optionList_;

	[DebuggerNonUserCode]
	public int RewardGroup
	{
		get
		{
			return rewardGroup_;
		}
		set
		{
			rewardGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ScoreItemId
	{
		get
		{
			return scoreItemId_;
		}
		set
		{
			scoreItemId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ScoreItemLimit
	{
		get
		{
			return scoreItemLimit_;
		}
		set
		{
			scoreItemLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BdConvert()
	{
	}

	[DebuggerNonUserCode]
	public BdConvert(BdConvert other)
		: this()
	{
		id_ = other.id_;
		optionList_ = other.optionList_.Clone();
		rewardGroup_ = other.rewardGroup_;
		scoreItemId_ = other.scoreItemId_;
		scoreItemLimit_ = other.scoreItemLimit_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BdConvert Clone()
	{
		return new BdConvert(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BdConvert);
	}

	[DebuggerNonUserCode]
	public bool Equals(BdConvert other)
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
		if (!optionList_.Equals(other.optionList_))
		{
			return false;
		}
		if (RewardGroup != other.RewardGroup)
		{
			return false;
		}
		if (ScoreItemId != other.ScoreItemId)
		{
			return false;
		}
		if (ScoreItemLimit != other.ScoreItemLimit)
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
		num ^= optionList_.GetHashCode();
		if (RewardGroup != 0)
		{
			num ^= RewardGroup.GetHashCode();
		}
		if (ScoreItemId != 0)
		{
			num ^= ScoreItemId.GetHashCode();
		}
		if (ScoreItemLimit != 0)
		{
			num ^= ScoreItemLimit.GetHashCode();
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
		optionList_.WriteTo(output, _repeated_optionList_codec);
		if (RewardGroup != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RewardGroup);
		}
		if (ScoreItemId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ScoreItemId);
		}
		if (ScoreItemLimit != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ScoreItemLimit);
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
		num += optionList_.CalculateSize(_repeated_optionList_codec);
		if (RewardGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RewardGroup);
		}
		if (ScoreItemId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScoreItemId);
		}
		if (ScoreItemLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ScoreItemLimit);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BdConvert other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			optionList_.Add(other.optionList_);
			if (other.RewardGroup != 0)
			{
				RewardGroup = other.RewardGroup;
			}
			if (other.ScoreItemId != 0)
			{
				ScoreItemId = other.ScoreItemId;
			}
			if (other.ScoreItemLimit != 0)
			{
				ScoreItemLimit = other.ScoreItemLimit;
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
				optionList_.AddEntriesFrom(input, _repeated_optionList_codec);
				break;
			case 24u:
				RewardGroup = input.ReadInt32();
				break;
			case 32u:
				ScoreItemId = input.ReadInt32();
				break;
			case 40u:
				ScoreItemLimit = input.ReadInt32();
				break;
			}
		}
	}
}
