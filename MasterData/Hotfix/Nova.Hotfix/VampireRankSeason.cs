using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class VampireRankSeason : IMessage<VampireRankSeason>, IMessage, IEquatable<VampireRankSeason>, IDeepCloneable<VampireRankSeason>
{
	private static readonly MessageParser<VampireRankSeason> _parser = new MessageParser<VampireRankSeason>(() => new VampireRankSeason());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MissionIdFieldNumber = 2;

	private int missionId_;

	public const int OpenTimeFieldNumber = 3;

	private string openTime_ = "";

	public const int EndTimeFieldNumber = 4;

	private string endTime_ = "";

	public const int FateCardBundleFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_fateCardBundle_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> fateCardBundle_ = new RepeatedField<int>();

	public const int SpeciaFateCardFieldNumber = 6;

	private string speciaFateCard_ = "";

	public const int SpeciaFateCardParamFieldNumber = 7;

	private string speciaFateCardParam_ = "";

	public const int QuestGroupFieldNumber = 8;

	private int questGroup_;

	[DebuggerNonUserCode]
	public static MessageParser<VampireRankSeason> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(1058);

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
	public int MissionId
	{
		get
		{
			return missionId_;
		}
		set
		{
			missionId_ = value;
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
	public RepeatedField<int> FateCardBundle => fateCardBundle_;

	[DebuggerNonUserCode]
	public string SpeciaFateCard
	{
		get
		{
			return speciaFateCard_;
		}
		set
		{
			speciaFateCard_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SpeciaFateCardParam
	{
		get
		{
			return speciaFateCardParam_;
		}
		set
		{
			speciaFateCardParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int QuestGroup
	{
		get
		{
			return questGroup_;
		}
		set
		{
			questGroup_ = value;
		}
	}

	[DebuggerNonUserCode]
	public VampireRankSeason()
	{
	}

	[DebuggerNonUserCode]
	public VampireRankSeason(VampireRankSeason other)
		: this()
	{
		id_ = other.id_;
		missionId_ = other.missionId_;
		openTime_ = other.openTime_;
		endTime_ = other.endTime_;
		fateCardBundle_ = other.fateCardBundle_.Clone();
		speciaFateCard_ = other.speciaFateCard_;
		speciaFateCardParam_ = other.speciaFateCardParam_;
		questGroup_ = other.questGroup_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public VampireRankSeason Clone()
	{
		return new VampireRankSeason(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as VampireRankSeason);
	}

	[DebuggerNonUserCode]
	public bool Equals(VampireRankSeason other)
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
		if (MissionId != other.MissionId)
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
		if (!fateCardBundle_.Equals(other.fateCardBundle_))
		{
			return false;
		}
		if (SpeciaFateCard != other.SpeciaFateCard)
		{
			return false;
		}
		if (SpeciaFateCardParam != other.SpeciaFateCardParam)
		{
			return false;
		}
		if (QuestGroup != other.QuestGroup)
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
		if (MissionId != 0)
		{
			num ^= MissionId.GetHashCode();
		}
		if (OpenTime.Length != 0)
		{
			num ^= OpenTime.GetHashCode();
		}
		if (EndTime.Length != 0)
		{
			num ^= EndTime.GetHashCode();
		}
		num ^= fateCardBundle_.GetHashCode();
		if (SpeciaFateCard.Length != 0)
		{
			num ^= SpeciaFateCard.GetHashCode();
		}
		if (SpeciaFateCardParam.Length != 0)
		{
			num ^= SpeciaFateCardParam.GetHashCode();
		}
		if (QuestGroup != 0)
		{
			num ^= QuestGroup.GetHashCode();
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
		if (MissionId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MissionId);
		}
		if (OpenTime.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(OpenTime);
		}
		if (EndTime.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(EndTime);
		}
		fateCardBundle_.WriteTo(output, _repeated_fateCardBundle_codec);
		if (SpeciaFateCard.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(SpeciaFateCard);
		}
		if (SpeciaFateCardParam.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(SpeciaFateCardParam);
		}
		if (QuestGroup != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(QuestGroup);
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
		if (MissionId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MissionId);
		}
		if (OpenTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(OpenTime);
		}
		if (EndTime.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EndTime);
		}
		num += fateCardBundle_.CalculateSize(_repeated_fateCardBundle_codec);
		if (SpeciaFateCard.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SpeciaFateCard);
		}
		if (SpeciaFateCardParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SpeciaFateCardParam);
		}
		if (QuestGroup != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QuestGroup);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(VampireRankSeason other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MissionId != 0)
			{
				MissionId = other.MissionId;
			}
			if (other.OpenTime.Length != 0)
			{
				OpenTime = other.OpenTime;
			}
			if (other.EndTime.Length != 0)
			{
				EndTime = other.EndTime;
			}
			fateCardBundle_.Add(other.fateCardBundle_);
			if (other.SpeciaFateCard.Length != 0)
			{
				SpeciaFateCard = other.SpeciaFateCard;
			}
			if (other.SpeciaFateCardParam.Length != 0)
			{
				SpeciaFateCardParam = other.SpeciaFateCardParam;
			}
			if (other.QuestGroup != 0)
			{
				QuestGroup = other.QuestGroup;
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
				MissionId = input.ReadInt32();
				break;
			case 26u:
				OpenTime = input.ReadString();
				break;
			case 34u:
				EndTime = input.ReadString();
				break;
			case 40u:
			case 42u:
				fateCardBundle_.AddEntriesFrom(input, _repeated_fateCardBundle_codec);
				break;
			case 50u:
				SpeciaFateCard = input.ReadString();
				break;
			case 58u:
				SpeciaFateCardParam = input.ReadString();
				break;
			case 64u:
				QuestGroup = input.ReadInt32();
				break;
			}
		}
	}
}
