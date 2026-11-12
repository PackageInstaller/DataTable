using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierStoryPersonalityOption : IMessage<SoldierStoryPersonalityOption>, IMessage, IEquatable<SoldierStoryPersonalityOption>, IDeepCloneable<SoldierStoryPersonalityOption>
{
	private static readonly MessageParser<SoldierStoryPersonalityOption> _parser = new MessageParser<SoldierStoryPersonalityOption>(() => new SoldierStoryPersonalityOption());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int OptionTypeIdFieldNumber = 2;

	private int optionTypeId_;

	public const int CheckDimensionFieldNumber = 3;

	private int checkDimension_;

	public const int CheckDifficultyFieldNumber = 4;

	private int checkDifficulty_;

	public const int ResultIdFieldNumber = 5;

	private int resultId_;

	public const int FailResultIdFieldNumber = 6;

	private int failResultId_;

	public const int OptionalCondFieldNumber = 7;

	private int optionalCond_;

	public const int OptionalParamFieldNumber = 8;

	private static readonly FieldCodec<int> _repeated_optionalParam_codec = FieldCodec.ForInt32(66u);

	private readonly RepeatedField<int> optionalParam_ = new RepeatedField<int>();

	public const int UnlockCond1FieldNumber = 9;

	private int unlockCond1_;

	public const int UnlockParam1FieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_unlockParam1_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> unlockParam1_ = new RepeatedField<int>();

	public const int UnlockCond2FieldNumber = 11;

	private int unlockCond2_;

	public const int UnlockParam2FieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_unlockParam2_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> unlockParam2_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<SoldierStoryPersonalityOption> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(800);

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
	public int OptionTypeId
	{
		get
		{
			return optionTypeId_;
		}
		set
		{
			optionTypeId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CheckDimension
	{
		get
		{
			return checkDimension_;
		}
		set
		{
			checkDimension_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CheckDifficulty
	{
		get
		{
			return checkDifficulty_;
		}
		set
		{
			checkDifficulty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ResultId
	{
		get
		{
			return resultId_;
		}
		set
		{
			resultId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FailResultId
	{
		get
		{
			return failResultId_;
		}
		set
		{
			failResultId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OptionalCond
	{
		get
		{
			return optionalCond_;
		}
		set
		{
			optionalCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> OptionalParam => optionalParam_;

	[DebuggerNonUserCode]
	public int UnlockCond1
	{
		get
		{
			return unlockCond1_;
		}
		set
		{
			unlockCond1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> UnlockParam1 => unlockParam1_;

	[DebuggerNonUserCode]
	public int UnlockCond2
	{
		get
		{
			return unlockCond2_;
		}
		set
		{
			unlockCond2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> UnlockParam2 => unlockParam2_;

	[DebuggerNonUserCode]
	public SoldierStoryPersonalityOption()
	{
	}

	[DebuggerNonUserCode]
	public SoldierStoryPersonalityOption(SoldierStoryPersonalityOption other)
		: this()
	{
		id_ = other.id_;
		optionTypeId_ = other.optionTypeId_;
		checkDimension_ = other.checkDimension_;
		checkDifficulty_ = other.checkDifficulty_;
		resultId_ = other.resultId_;
		failResultId_ = other.failResultId_;
		optionalCond_ = other.optionalCond_;
		optionalParam_ = other.optionalParam_.Clone();
		unlockCond1_ = other.unlockCond1_;
		unlockParam1_ = other.unlockParam1_.Clone();
		unlockCond2_ = other.unlockCond2_;
		unlockParam2_ = other.unlockParam2_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierStoryPersonalityOption Clone()
	{
		return new SoldierStoryPersonalityOption(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierStoryPersonalityOption);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierStoryPersonalityOption other)
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
		if (OptionTypeId != other.OptionTypeId)
		{
			return false;
		}
		if (CheckDimension != other.CheckDimension)
		{
			return false;
		}
		if (CheckDifficulty != other.CheckDifficulty)
		{
			return false;
		}
		if (ResultId != other.ResultId)
		{
			return false;
		}
		if (FailResultId != other.FailResultId)
		{
			return false;
		}
		if (OptionalCond != other.OptionalCond)
		{
			return false;
		}
		if (!optionalParam_.Equals(other.optionalParam_))
		{
			return false;
		}
		if (UnlockCond1 != other.UnlockCond1)
		{
			return false;
		}
		if (!unlockParam1_.Equals(other.unlockParam1_))
		{
			return false;
		}
		if (UnlockCond2 != other.UnlockCond2)
		{
			return false;
		}
		if (!unlockParam2_.Equals(other.unlockParam2_))
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
		if (OptionTypeId != 0)
		{
			num ^= OptionTypeId.GetHashCode();
		}
		if (CheckDimension != 0)
		{
			num ^= CheckDimension.GetHashCode();
		}
		if (CheckDifficulty != 0)
		{
			num ^= CheckDifficulty.GetHashCode();
		}
		if (ResultId != 0)
		{
			num ^= ResultId.GetHashCode();
		}
		if (FailResultId != 0)
		{
			num ^= FailResultId.GetHashCode();
		}
		if (OptionalCond != 0)
		{
			num ^= OptionalCond.GetHashCode();
		}
		num ^= optionalParam_.GetHashCode();
		if (UnlockCond1 != 0)
		{
			num ^= UnlockCond1.GetHashCode();
		}
		num ^= unlockParam1_.GetHashCode();
		if (UnlockCond2 != 0)
		{
			num ^= UnlockCond2.GetHashCode();
		}
		num ^= unlockParam2_.GetHashCode();
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
		if (OptionTypeId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(OptionTypeId);
		}
		if (CheckDimension != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(CheckDimension);
		}
		if (CheckDifficulty != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(CheckDifficulty);
		}
		if (ResultId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(ResultId);
		}
		if (FailResultId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(FailResultId);
		}
		if (OptionalCond != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(OptionalCond);
		}
		optionalParam_.WriteTo(output, _repeated_optionalParam_codec);
		if (UnlockCond1 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(UnlockCond1);
		}
		unlockParam1_.WriteTo(output, _repeated_unlockParam1_codec);
		if (UnlockCond2 != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(UnlockCond2);
		}
		unlockParam2_.WriteTo(output, _repeated_unlockParam2_codec);
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
		if (OptionTypeId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionTypeId);
		}
		if (CheckDimension != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CheckDimension);
		}
		if (CheckDifficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CheckDifficulty);
		}
		if (ResultId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ResultId);
		}
		if (FailResultId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FailResultId);
		}
		if (OptionalCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OptionalCond);
		}
		num += optionalParam_.CalculateSize(_repeated_optionalParam_codec);
		if (UnlockCond1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockCond1);
		}
		num += unlockParam1_.CalculateSize(_repeated_unlockParam1_codec);
		if (UnlockCond2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UnlockCond2);
		}
		num += unlockParam2_.CalculateSize(_repeated_unlockParam2_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierStoryPersonalityOption other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.OptionTypeId != 0)
			{
				OptionTypeId = other.OptionTypeId;
			}
			if (other.CheckDimension != 0)
			{
				CheckDimension = other.CheckDimension;
			}
			if (other.CheckDifficulty != 0)
			{
				CheckDifficulty = other.CheckDifficulty;
			}
			if (other.ResultId != 0)
			{
				ResultId = other.ResultId;
			}
			if (other.FailResultId != 0)
			{
				FailResultId = other.FailResultId;
			}
			if (other.OptionalCond != 0)
			{
				OptionalCond = other.OptionalCond;
			}
			optionalParam_.Add(other.optionalParam_);
			if (other.UnlockCond1 != 0)
			{
				UnlockCond1 = other.UnlockCond1;
			}
			unlockParam1_.Add(other.unlockParam1_);
			if (other.UnlockCond2 != 0)
			{
				UnlockCond2 = other.UnlockCond2;
			}
			unlockParam2_.Add(other.unlockParam2_);
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
				OptionTypeId = input.ReadInt32();
				break;
			case 24u:
				CheckDimension = input.ReadInt32();
				break;
			case 32u:
				CheckDifficulty = input.ReadInt32();
				break;
			case 40u:
				ResultId = input.ReadInt32();
				break;
			case 48u:
				FailResultId = input.ReadInt32();
				break;
			case 56u:
				OptionalCond = input.ReadInt32();
				break;
			case 64u:
			case 66u:
				optionalParam_.AddEntriesFrom(input, _repeated_optionalParam_codec);
				break;
			case 72u:
				UnlockCond1 = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				unlockParam1_.AddEntriesFrom(input, _repeated_unlockParam1_codec);
				break;
			case 88u:
				UnlockCond2 = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				unlockParam2_.AddEntriesFrom(input, _repeated_unlockParam2_codec);
				break;
			}
		}
	}
}
