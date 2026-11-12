using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StarTowerMonsterSpAttr : IMessage<StarTowerMonsterSpAttr>, IMessage, IEquatable<StarTowerMonsterSpAttr>, IDeepCloneable<StarTowerMonsterSpAttr>
{
	private static readonly MessageParser<StarTowerMonsterSpAttr> _parser = new MessageParser<StarTowerMonsterSpAttr>(() => new StarTowerMonsterSpAttr());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int MonsterPositionFieldNumber = 2;

	private int monsterPosition_;

	public const int ThemeSkillsFieldNumber = 3;

	private string themeSkills_ = "";

	public const int ContinuousKillingTimeFieldNumber = 4;

	private int continuousKillingTime_;

	public const int RougeMoneyDropRangeFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_rougeMoneyDropRange_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> rougeMoneyDropRange_ = new RepeatedField<int>();

	public const int RougeExpDropRangeFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_rougeExpDropRange_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> rougeExpDropRange_ = new RepeatedField<int>();

	public const int RefDistanceFieldNumber = 7;

	private static readonly FieldCodec<int> _repeated_refDistance_codec = FieldCodec.ForInt32(58u);

	private readonly RepeatedField<int> refDistance_ = new RepeatedField<int>();

	public const int RefIntervalFieldNumber = 8;

	private int refInterval_;

	public const int WayPointShiftFieldNumber = 9;

	private bool wayPointShift_;

	[DebuggerNonUserCode]
	public static MessageParser<StarTowerMonsterSpAttr> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(866);

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
	public int MonsterPosition
	{
		get
		{
			return monsterPosition_;
		}
		set
		{
			monsterPosition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ThemeSkills
	{
		get
		{
			return themeSkills_;
		}
		set
		{
			themeSkills_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int ContinuousKillingTime
	{
		get
		{
			return continuousKillingTime_;
		}
		set
		{
			continuousKillingTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> RougeMoneyDropRange => rougeMoneyDropRange_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RougeExpDropRange => rougeExpDropRange_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RefDistance => refDistance_;

	[DebuggerNonUserCode]
	public int RefInterval
	{
		get
		{
			return refInterval_;
		}
		set
		{
			refInterval_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool WayPointShift
	{
		get
		{
			return wayPointShift_;
		}
		set
		{
			wayPointShift_ = value;
		}
	}

	[DebuggerNonUserCode]
	public StarTowerMonsterSpAttr()
	{
	}

	[DebuggerNonUserCode]
	public StarTowerMonsterSpAttr(StarTowerMonsterSpAttr other)
		: this()
	{
		id_ = other.id_;
		monsterPosition_ = other.monsterPosition_;
		themeSkills_ = other.themeSkills_;
		continuousKillingTime_ = other.continuousKillingTime_;
		rougeMoneyDropRange_ = other.rougeMoneyDropRange_.Clone();
		rougeExpDropRange_ = other.rougeExpDropRange_.Clone();
		refDistance_ = other.refDistance_.Clone();
		refInterval_ = other.refInterval_;
		wayPointShift_ = other.wayPointShift_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StarTowerMonsterSpAttr Clone()
	{
		return new StarTowerMonsterSpAttr(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StarTowerMonsterSpAttr);
	}

	[DebuggerNonUserCode]
	public bool Equals(StarTowerMonsterSpAttr other)
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
		if (MonsterPosition != other.MonsterPosition)
		{
			return false;
		}
		if (ThemeSkills != other.ThemeSkills)
		{
			return false;
		}
		if (ContinuousKillingTime != other.ContinuousKillingTime)
		{
			return false;
		}
		if (!rougeMoneyDropRange_.Equals(other.rougeMoneyDropRange_))
		{
			return false;
		}
		if (!rougeExpDropRange_.Equals(other.rougeExpDropRange_))
		{
			return false;
		}
		if (!refDistance_.Equals(other.refDistance_))
		{
			return false;
		}
		if (RefInterval != other.RefInterval)
		{
			return false;
		}
		if (WayPointShift != other.WayPointShift)
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
		if (MonsterPosition != 0)
		{
			num ^= MonsterPosition.GetHashCode();
		}
		if (ThemeSkills.Length != 0)
		{
			num ^= ThemeSkills.GetHashCode();
		}
		if (ContinuousKillingTime != 0)
		{
			num ^= ContinuousKillingTime.GetHashCode();
		}
		num ^= rougeMoneyDropRange_.GetHashCode();
		num ^= rougeExpDropRange_.GetHashCode();
		num ^= refDistance_.GetHashCode();
		if (RefInterval != 0)
		{
			num ^= RefInterval.GetHashCode();
		}
		if (WayPointShift)
		{
			num ^= WayPointShift.GetHashCode();
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
		if (MonsterPosition != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(MonsterPosition);
		}
		if (ThemeSkills.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ThemeSkills);
		}
		if (ContinuousKillingTime != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(ContinuousKillingTime);
		}
		rougeMoneyDropRange_.WriteTo(output, _repeated_rougeMoneyDropRange_codec);
		rougeExpDropRange_.WriteTo(output, _repeated_rougeExpDropRange_codec);
		refDistance_.WriteTo(output, _repeated_refDistance_codec);
		if (RefInterval != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(RefInterval);
		}
		if (WayPointShift)
		{
			output.WriteRawTag(72);
			output.WriteBool(WayPointShift);
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
		if (MonsterPosition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MonsterPosition);
		}
		if (ThemeSkills.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ThemeSkills);
		}
		if (ContinuousKillingTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ContinuousKillingTime);
		}
		num += rougeMoneyDropRange_.CalculateSize(_repeated_rougeMoneyDropRange_codec);
		num += rougeExpDropRange_.CalculateSize(_repeated_rougeExpDropRange_codec);
		num += refDistance_.CalculateSize(_repeated_refDistance_codec);
		if (RefInterval != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RefInterval);
		}
		if (WayPointShift)
		{
			num += 2;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StarTowerMonsterSpAttr other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.MonsterPosition != 0)
			{
				MonsterPosition = other.MonsterPosition;
			}
			if (other.ThemeSkills.Length != 0)
			{
				ThemeSkills = other.ThemeSkills;
			}
			if (other.ContinuousKillingTime != 0)
			{
				ContinuousKillingTime = other.ContinuousKillingTime;
			}
			rougeMoneyDropRange_.Add(other.rougeMoneyDropRange_);
			rougeExpDropRange_.Add(other.rougeExpDropRange_);
			refDistance_.Add(other.refDistance_);
			if (other.RefInterval != 0)
			{
				RefInterval = other.RefInterval;
			}
			if (other.WayPointShift)
			{
				WayPointShift = other.WayPointShift;
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
				MonsterPosition = input.ReadInt32();
				break;
			case 26u:
				ThemeSkills = input.ReadString();
				break;
			case 32u:
				ContinuousKillingTime = input.ReadInt32();
				break;
			case 40u:
			case 42u:
				rougeMoneyDropRange_.AddEntriesFrom(input, _repeated_rougeMoneyDropRange_codec);
				break;
			case 48u:
			case 50u:
				rougeExpDropRange_.AddEntriesFrom(input, _repeated_rougeExpDropRange_codec);
				break;
			case 56u:
			case 58u:
				refDistance_.AddEntriesFrom(input, _repeated_refDistance_codec);
				break;
			case 64u:
				RefInterval = input.ReadInt32();
				break;
			case 72u:
				WayPointShift = input.ReadBool();
				break;
			}
		}
	}
}
