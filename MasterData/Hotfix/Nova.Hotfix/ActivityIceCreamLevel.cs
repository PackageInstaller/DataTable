using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ActivityIceCreamLevel : IMessage<ActivityIceCreamLevel>, IMessage, IEquatable<ActivityIceCreamLevel>, IDeepCloneable<ActivityIceCreamLevel>
{
	private static readonly MessageParser<ActivityIceCreamLevel> _parser = new MessageParser<ActivityIceCreamLevel>(() => new ActivityIceCreamLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int DurationFieldNumber = 3;

	private int duration_;

	public const int IslandNameFieldNumber = 4;

	private string islandName_ = "";

	public const int NameFieldNumber = 5;

	private string name_ = "";

	public const int DesFieldNumber = 6;

	private string des_ = "";

	public const int PreLevelIdFieldNumber = 7;

	private int preLevelId_;

	public const int LevelTypeFieldNumber = 8;

	private int levelType_;

	public const int UnlockSlotFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_unlockSlot_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> unlockSlot_ = new RepeatedField<int>();

	public const int CustomerCountFieldNumber = 10;

	private int customerCount_;

	public const int PatienceValueFieldNumber = 11;

	private int patienceValue_;

	public const int HealthFieldNumber = 12;

	private int health_;

	public const int FeverFieldNumber = 13;

	private int fever_;

	public const int IceCreamBallLimitFieldNumber = 14;

	private int iceCreamBallLimit_;

	public const int BuffPoolIdFieldNumber = 15;

	private int buffPoolId_;

	public const int CharPoolIdFieldNumber = 16;

	private int charPoolId_;

	public const int PassScoreFieldNumber = 17;

	private int passScore_;

	public const int PassScoreDesFieldNumber = 18;

	private string passScoreDes_ = "";

	public const int OrderNumFieldNumber = 19;

	private int orderNum_;

	public const int OrderNumDesFieldNumber = 20;

	private string orderNumDes_ = "";

	public const int FirstCompleteReward1TidFieldNumber = 21;

	private int firstCompleteReward1Tid_;

	public const int FirstCompleteReward1QtyFieldNumber = 22;

	private int firstCompleteReward1Qty_;

	public const int FirstCompleteReward2TidFieldNumber = 23;

	private int firstCompleteReward2Tid_;

	public const int FirstCompleteReward2QtyFieldNumber = 24;

	private int firstCompleteReward2Qty_;

	public const int DictionaryIdFieldNumber = 25;

	private int dictionaryId_;

	[DebuggerNonUserCode]
	public static MessageParser<ActivityIceCreamLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(18);

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
	public int Duration
	{
		get
		{
			return duration_;
		}
		set
		{
			duration_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string IslandName
	{
		get
		{
			return islandName_;
		}
		set
		{
			islandName_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public string Des
	{
		get
		{
			return des_;
		}
		set
		{
			des_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PreLevelId
	{
		get
		{
			return preLevelId_;
		}
		set
		{
			preLevelId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LevelType
	{
		get
		{
			return levelType_;
		}
		set
		{
			levelType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> UnlockSlot => unlockSlot_;

	[DebuggerNonUserCode]
	public int CustomerCount
	{
		get
		{
			return customerCount_;
		}
		set
		{
			customerCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PatienceValue
	{
		get
		{
			return patienceValue_;
		}
		set
		{
			patienceValue_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Health
	{
		get
		{
			return health_;
		}
		set
		{
			health_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Fever
	{
		get
		{
			return fever_;
		}
		set
		{
			fever_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int IceCreamBallLimit
	{
		get
		{
			return iceCreamBallLimit_;
		}
		set
		{
			iceCreamBallLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffPoolId
	{
		get
		{
			return buffPoolId_;
		}
		set
		{
			buffPoolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CharPoolId
	{
		get
		{
			return charPoolId_;
		}
		set
		{
			charPoolId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PassScore
	{
		get
		{
			return passScore_;
		}
		set
		{
			passScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PassScoreDes
	{
		get
		{
			return passScoreDes_;
		}
		set
		{
			passScoreDes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int OrderNum
	{
		get
		{
			return orderNum_;
		}
		set
		{
			orderNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string OrderNumDes
	{
		get
		{
			return orderNumDes_;
		}
		set
		{
			orderNumDes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompleteReward1Tid
	{
		get
		{
			return firstCompleteReward1Tid_;
		}
		set
		{
			firstCompleteReward1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompleteReward1Qty
	{
		get
		{
			return firstCompleteReward1Qty_;
		}
		set
		{
			firstCompleteReward1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompleteReward2Tid
	{
		get
		{
			return firstCompleteReward2Tid_;
		}
		set
		{
			firstCompleteReward2Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompleteReward2Qty
	{
		get
		{
			return firstCompleteReward2Qty_;
		}
		set
		{
			firstCompleteReward2Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DictionaryId
	{
		get
		{
			return dictionaryId_;
		}
		set
		{
			dictionaryId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ActivityIceCreamLevel()
	{
	}

	[DebuggerNonUserCode]
	public ActivityIceCreamLevel(ActivityIceCreamLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		duration_ = other.duration_;
		islandName_ = other.islandName_;
		name_ = other.name_;
		des_ = other.des_;
		preLevelId_ = other.preLevelId_;
		levelType_ = other.levelType_;
		unlockSlot_ = other.unlockSlot_.Clone();
		customerCount_ = other.customerCount_;
		patienceValue_ = other.patienceValue_;
		health_ = other.health_;
		fever_ = other.fever_;
		iceCreamBallLimit_ = other.iceCreamBallLimit_;
		buffPoolId_ = other.buffPoolId_;
		charPoolId_ = other.charPoolId_;
		passScore_ = other.passScore_;
		passScoreDes_ = other.passScoreDes_;
		orderNum_ = other.orderNum_;
		orderNumDes_ = other.orderNumDes_;
		firstCompleteReward1Tid_ = other.firstCompleteReward1Tid_;
		firstCompleteReward1Qty_ = other.firstCompleteReward1Qty_;
		firstCompleteReward2Tid_ = other.firstCompleteReward2Tid_;
		firstCompleteReward2Qty_ = other.firstCompleteReward2Qty_;
		dictionaryId_ = other.dictionaryId_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ActivityIceCreamLevel Clone()
	{
		return new ActivityIceCreamLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ActivityIceCreamLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(ActivityIceCreamLevel other)
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
		if (Duration != other.Duration)
		{
			return false;
		}
		if (IslandName != other.IslandName)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (Des != other.Des)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (LevelType != other.LevelType)
		{
			return false;
		}
		if (!unlockSlot_.Equals(other.unlockSlot_))
		{
			return false;
		}
		if (CustomerCount != other.CustomerCount)
		{
			return false;
		}
		if (PatienceValue != other.PatienceValue)
		{
			return false;
		}
		if (Health != other.Health)
		{
			return false;
		}
		if (Fever != other.Fever)
		{
			return false;
		}
		if (IceCreamBallLimit != other.IceCreamBallLimit)
		{
			return false;
		}
		if (BuffPoolId != other.BuffPoolId)
		{
			return false;
		}
		if (CharPoolId != other.CharPoolId)
		{
			return false;
		}
		if (PassScore != other.PassScore)
		{
			return false;
		}
		if (PassScoreDes != other.PassScoreDes)
		{
			return false;
		}
		if (OrderNum != other.OrderNum)
		{
			return false;
		}
		if (OrderNumDes != other.OrderNumDes)
		{
			return false;
		}
		if (FirstCompleteReward1Tid != other.FirstCompleteReward1Tid)
		{
			return false;
		}
		if (FirstCompleteReward1Qty != other.FirstCompleteReward1Qty)
		{
			return false;
		}
		if (FirstCompleteReward2Tid != other.FirstCompleteReward2Tid)
		{
			return false;
		}
		if (FirstCompleteReward2Qty != other.FirstCompleteReward2Qty)
		{
			return false;
		}
		if (DictionaryId != other.DictionaryId)
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
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (IslandName.Length != 0)
		{
			num ^= IslandName.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Des.Length != 0)
		{
			num ^= Des.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (LevelType != 0)
		{
			num ^= LevelType.GetHashCode();
		}
		num ^= unlockSlot_.GetHashCode();
		if (CustomerCount != 0)
		{
			num ^= CustomerCount.GetHashCode();
		}
		if (PatienceValue != 0)
		{
			num ^= PatienceValue.GetHashCode();
		}
		if (Health != 0)
		{
			num ^= Health.GetHashCode();
		}
		if (Fever != 0)
		{
			num ^= Fever.GetHashCode();
		}
		if (IceCreamBallLimit != 0)
		{
			num ^= IceCreamBallLimit.GetHashCode();
		}
		if (BuffPoolId != 0)
		{
			num ^= BuffPoolId.GetHashCode();
		}
		if (CharPoolId != 0)
		{
			num ^= CharPoolId.GetHashCode();
		}
		if (PassScore != 0)
		{
			num ^= PassScore.GetHashCode();
		}
		if (PassScoreDes.Length != 0)
		{
			num ^= PassScoreDes.GetHashCode();
		}
		if (OrderNum != 0)
		{
			num ^= OrderNum.GetHashCode();
		}
		if (OrderNumDes.Length != 0)
		{
			num ^= OrderNumDes.GetHashCode();
		}
		if (FirstCompleteReward1Tid != 0)
		{
			num ^= FirstCompleteReward1Tid.GetHashCode();
		}
		if (FirstCompleteReward1Qty != 0)
		{
			num ^= FirstCompleteReward1Qty.GetHashCode();
		}
		if (FirstCompleteReward2Tid != 0)
		{
			num ^= FirstCompleteReward2Tid.GetHashCode();
		}
		if (FirstCompleteReward2Qty != 0)
		{
			num ^= FirstCompleteReward2Qty.GetHashCode();
		}
		if (DictionaryId != 0)
		{
			num ^= DictionaryId.GetHashCode();
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
		if (Duration != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Duration);
		}
		if (IslandName.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(IslandName);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Name);
		}
		if (Des.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Des);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(PreLevelId);
		}
		if (LevelType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(LevelType);
		}
		unlockSlot_.WriteTo(output, _repeated_unlockSlot_codec);
		if (CustomerCount != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(CustomerCount);
		}
		if (PatienceValue != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(PatienceValue);
		}
		if (Health != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Health);
		}
		if (Fever != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(Fever);
		}
		if (IceCreamBallLimit != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(IceCreamBallLimit);
		}
		if (BuffPoolId != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(BuffPoolId);
		}
		if (CharPoolId != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(CharPoolId);
		}
		if (PassScore != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(PassScore);
		}
		if (PassScoreDes.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(PassScoreDes);
		}
		if (OrderNum != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(OrderNum);
		}
		if (OrderNumDes.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(OrderNumDes);
		}
		if (FirstCompleteReward1Tid != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(FirstCompleteReward1Tid);
		}
		if (FirstCompleteReward1Qty != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(FirstCompleteReward1Qty);
		}
		if (FirstCompleteReward2Tid != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(FirstCompleteReward2Tid);
		}
		if (FirstCompleteReward2Qty != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(FirstCompleteReward2Qty);
		}
		if (DictionaryId != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(DictionaryId);
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
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (IslandName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IslandName);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Des.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Des);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (LevelType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LevelType);
		}
		num += unlockSlot_.CalculateSize(_repeated_unlockSlot_codec);
		if (CustomerCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CustomerCount);
		}
		if (PatienceValue != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PatienceValue);
		}
		if (Health != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Health);
		}
		if (Fever != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Fever);
		}
		if (IceCreamBallLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(IceCreamBallLimit);
		}
		if (BuffPoolId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffPoolId);
		}
		if (CharPoolId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CharPoolId);
		}
		if (PassScore != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PassScore);
		}
		if (PassScoreDes.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(PassScoreDes);
		}
		if (OrderNum != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(OrderNum);
		}
		if (OrderNumDes.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(OrderNumDes);
		}
		if (FirstCompleteReward1Tid != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstCompleteReward1Tid);
		}
		if (FirstCompleteReward1Qty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstCompleteReward1Qty);
		}
		if (FirstCompleteReward2Tid != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstCompleteReward2Tid);
		}
		if (FirstCompleteReward2Qty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstCompleteReward2Qty);
		}
		if (DictionaryId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DictionaryId);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ActivityIceCreamLevel other)
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
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			if (other.IslandName.Length != 0)
			{
				IslandName = other.IslandName;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Des.Length != 0)
			{
				Des = other.Des;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.LevelType != 0)
			{
				LevelType = other.LevelType;
			}
			unlockSlot_.Add(other.unlockSlot_);
			if (other.CustomerCount != 0)
			{
				CustomerCount = other.CustomerCount;
			}
			if (other.PatienceValue != 0)
			{
				PatienceValue = other.PatienceValue;
			}
			if (other.Health != 0)
			{
				Health = other.Health;
			}
			if (other.Fever != 0)
			{
				Fever = other.Fever;
			}
			if (other.IceCreamBallLimit != 0)
			{
				IceCreamBallLimit = other.IceCreamBallLimit;
			}
			if (other.BuffPoolId != 0)
			{
				BuffPoolId = other.BuffPoolId;
			}
			if (other.CharPoolId != 0)
			{
				CharPoolId = other.CharPoolId;
			}
			if (other.PassScore != 0)
			{
				PassScore = other.PassScore;
			}
			if (other.PassScoreDes.Length != 0)
			{
				PassScoreDes = other.PassScoreDes;
			}
			if (other.OrderNum != 0)
			{
				OrderNum = other.OrderNum;
			}
			if (other.OrderNumDes.Length != 0)
			{
				OrderNumDes = other.OrderNumDes;
			}
			if (other.FirstCompleteReward1Tid != 0)
			{
				FirstCompleteReward1Tid = other.FirstCompleteReward1Tid;
			}
			if (other.FirstCompleteReward1Qty != 0)
			{
				FirstCompleteReward1Qty = other.FirstCompleteReward1Qty;
			}
			if (other.FirstCompleteReward2Tid != 0)
			{
				FirstCompleteReward2Tid = other.FirstCompleteReward2Tid;
			}
			if (other.FirstCompleteReward2Qty != 0)
			{
				FirstCompleteReward2Qty = other.FirstCompleteReward2Qty;
			}
			if (other.DictionaryId != 0)
			{
				DictionaryId = other.DictionaryId;
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
				Duration = input.ReadInt32();
				break;
			case 34u:
				IslandName = input.ReadString();
				break;
			case 42u:
				Name = input.ReadString();
				break;
			case 50u:
				Des = input.ReadString();
				break;
			case 56u:
				PreLevelId = input.ReadInt32();
				break;
			case 64u:
				LevelType = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				unlockSlot_.AddEntriesFrom(input, _repeated_unlockSlot_codec);
				break;
			case 80u:
				CustomerCount = input.ReadInt32();
				break;
			case 88u:
				PatienceValue = input.ReadInt32();
				break;
			case 96u:
				Health = input.ReadInt32();
				break;
			case 104u:
				Fever = input.ReadInt32();
				break;
			case 112u:
				IceCreamBallLimit = input.ReadInt32();
				break;
			case 120u:
				BuffPoolId = input.ReadInt32();
				break;
			case 128u:
				CharPoolId = input.ReadInt32();
				break;
			case 136u:
				PassScore = input.ReadInt32();
				break;
			case 146u:
				PassScoreDes = input.ReadString();
				break;
			case 152u:
				OrderNum = input.ReadInt32();
				break;
			case 162u:
				OrderNumDes = input.ReadString();
				break;
			case 168u:
				FirstCompleteReward1Tid = input.ReadInt32();
				break;
			case 176u:
				FirstCompleteReward1Qty = input.ReadInt32();
				break;
			case 184u:
				FirstCompleteReward2Tid = input.ReadInt32();
				break;
			case 192u:
				FirstCompleteReward2Qty = input.ReadInt32();
				break;
			case 200u:
				DictionaryId = input.ReadInt32();
				break;
			}
		}
	}
}
