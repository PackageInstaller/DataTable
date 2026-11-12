using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ThrowGiftLevel : IMessage<ThrowGiftLevel>, IMessage, IEquatable<ThrowGiftLevel>, IDeepCloneable<ThrowGiftLevel>
{
	private static readonly MessageParser<ThrowGiftLevel> _parser = new MessageParser<ThrowGiftLevel>(() => new ThrowGiftLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int DayOpenFieldNumber = 3;

	private int dayOpen_;

	public const int DifficultyFieldNumber = 4;

	private int difficulty_;

	public const int DifficultyNameFieldNumber = 5;

	private string difficultyName_ = "";

	public const int IconFieldNumber = 6;

	private string icon_ = "";

	public const int LevelNameFieldNumber = 7;

	private string levelName_ = "";

	public const int FloorIdFieldNumber = 8;

	private int floorId_;

	public const int CountDownLimitFieldNumber = 9;

	private int countDownLimit_;

	public const int PreLevelIdFieldNumber = 10;

	private int preLevelId_;

	public const int ThrowGiftLevelCondFieldNumber = 11;

	private int throwGiftLevelCond_;

	public const int ThrowGiftLevelParamsFieldNumber = 12;

	private int throwGiftLevelParams_;

	public const int ThrowGiftLevelCondDescFieldNumber = 13;

	private string throwGiftLevelCondDesc_ = "";

	public const int FlightPathFieldNumber = 14;

	private bool flightPath_;

	public const int SwitchArrowFieldNumber = 15;

	private bool switchArrow_;

	public const int DefaultPenguinItemIdFieldNumber = 16;

	private int defaultPenguinItemId_;

	public const int FirstCompleteReward1TidFieldNumber = 17;

	private int firstCompleteReward1Tid_;

	public const int FirstCompleteReward1QtyFieldNumber = 18;

	private int firstCompleteReward1Qty_;

	public const int FirstCompleteReward2TidFieldNumber = 19;

	private int firstCompleteReward2Tid_;

	public const int FirstCompleteReward2QtyFieldNumber = 20;

	private int firstCompleteReward2Qty_;

	[DebuggerNonUserCode]
	public static MessageParser<ThrowGiftLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(934);

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
	public int DayOpen
	{
		get
		{
			return dayOpen_;
		}
		set
		{
			dayOpen_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Difficulty
	{
		get
		{
			return difficulty_;
		}
		set
		{
			difficulty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string DifficultyName
	{
		get
		{
			return difficultyName_;
		}
		set
		{
			difficultyName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Icon
	{
		get
		{
			return icon_;
		}
		set
		{
			icon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string LevelName
	{
		get
		{
			return levelName_;
		}
		set
		{
			levelName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int FloorId
	{
		get
		{
			return floorId_;
		}
		set
		{
			floorId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CountDownLimit
	{
		get
		{
			return countDownLimit_;
		}
		set
		{
			countDownLimit_ = value;
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
	public int ThrowGiftLevelCond
	{
		get
		{
			return throwGiftLevelCond_;
		}
		set
		{
			throwGiftLevelCond_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ThrowGiftLevelParams
	{
		get
		{
			return throwGiftLevelParams_;
		}
		set
		{
			throwGiftLevelParams_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string ThrowGiftLevelCondDesc
	{
		get
		{
			return throwGiftLevelCondDesc_;
		}
		set
		{
			throwGiftLevelCondDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool FlightPath
	{
		get
		{
			return flightPath_;
		}
		set
		{
			flightPath_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool SwitchArrow
	{
		get
		{
			return switchArrow_;
		}
		set
		{
			switchArrow_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DefaultPenguinItemId
	{
		get
		{
			return defaultPenguinItemId_;
		}
		set
		{
			defaultPenguinItemId_ = value;
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
	public ThrowGiftLevel()
	{
	}

	[DebuggerNonUserCode]
	public ThrowGiftLevel(ThrowGiftLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		dayOpen_ = other.dayOpen_;
		difficulty_ = other.difficulty_;
		difficultyName_ = other.difficultyName_;
		icon_ = other.icon_;
		levelName_ = other.levelName_;
		floorId_ = other.floorId_;
		countDownLimit_ = other.countDownLimit_;
		preLevelId_ = other.preLevelId_;
		throwGiftLevelCond_ = other.throwGiftLevelCond_;
		throwGiftLevelParams_ = other.throwGiftLevelParams_;
		throwGiftLevelCondDesc_ = other.throwGiftLevelCondDesc_;
		flightPath_ = other.flightPath_;
		switchArrow_ = other.switchArrow_;
		defaultPenguinItemId_ = other.defaultPenguinItemId_;
		firstCompleteReward1Tid_ = other.firstCompleteReward1Tid_;
		firstCompleteReward1Qty_ = other.firstCompleteReward1Qty_;
		firstCompleteReward2Tid_ = other.firstCompleteReward2Tid_;
		firstCompleteReward2Qty_ = other.firstCompleteReward2Qty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ThrowGiftLevel Clone()
	{
		return new ThrowGiftLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ThrowGiftLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(ThrowGiftLevel other)
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
		if (DayOpen != other.DayOpen)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (DifficultyName != other.DifficultyName)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (LevelName != other.LevelName)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (CountDownLimit != other.CountDownLimit)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (ThrowGiftLevelCond != other.ThrowGiftLevelCond)
		{
			return false;
		}
		if (ThrowGiftLevelParams != other.ThrowGiftLevelParams)
		{
			return false;
		}
		if (ThrowGiftLevelCondDesc != other.ThrowGiftLevelCondDesc)
		{
			return false;
		}
		if (FlightPath != other.FlightPath)
		{
			return false;
		}
		if (SwitchArrow != other.SwitchArrow)
		{
			return false;
		}
		if (DefaultPenguinItemId != other.DefaultPenguinItemId)
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
		if (DayOpen != 0)
		{
			num ^= DayOpen.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (DifficultyName.Length != 0)
		{
			num ^= DifficultyName.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (LevelName.Length != 0)
		{
			num ^= LevelName.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (CountDownLimit != 0)
		{
			num ^= CountDownLimit.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (ThrowGiftLevelCond != 0)
		{
			num ^= ThrowGiftLevelCond.GetHashCode();
		}
		if (ThrowGiftLevelParams != 0)
		{
			num ^= ThrowGiftLevelParams.GetHashCode();
		}
		if (ThrowGiftLevelCondDesc.Length != 0)
		{
			num ^= ThrowGiftLevelCondDesc.GetHashCode();
		}
		if (FlightPath)
		{
			num ^= FlightPath.GetHashCode();
		}
		if (SwitchArrow)
		{
			num ^= SwitchArrow.GetHashCode();
		}
		if (DefaultPenguinItemId != 0)
		{
			num ^= DefaultPenguinItemId.GetHashCode();
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
		if (DayOpen != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(DayOpen);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Difficulty);
		}
		if (DifficultyName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(DifficultyName);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Icon);
		}
		if (LevelName.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(LevelName);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(FloorId);
		}
		if (CountDownLimit != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(CountDownLimit);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PreLevelId);
		}
		if (ThrowGiftLevelCond != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(ThrowGiftLevelCond);
		}
		if (ThrowGiftLevelParams != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(ThrowGiftLevelParams);
		}
		if (ThrowGiftLevelCondDesc.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(ThrowGiftLevelCondDesc);
		}
		if (FlightPath)
		{
			output.WriteRawTag(112);
			output.WriteBool(FlightPath);
		}
		if (SwitchArrow)
		{
			output.WriteRawTag(120);
			output.WriteBool(SwitchArrow);
		}
		if (DefaultPenguinItemId != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(DefaultPenguinItemId);
		}
		if (FirstCompleteReward1Tid != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(FirstCompleteReward1Tid);
		}
		if (FirstCompleteReward1Qty != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(FirstCompleteReward1Qty);
		}
		if (FirstCompleteReward2Tid != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(FirstCompleteReward2Tid);
		}
		if (FirstCompleteReward2Qty != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(FirstCompleteReward2Qty);
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
		if (DayOpen != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DayOpen);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (DifficultyName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(DifficultyName);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (LevelName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(LevelName);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (CountDownLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountDownLimit);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (ThrowGiftLevelCond != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ThrowGiftLevelCond);
		}
		if (ThrowGiftLevelParams != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ThrowGiftLevelParams);
		}
		if (ThrowGiftLevelCondDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ThrowGiftLevelCondDesc);
		}
		if (FlightPath)
		{
			num += 2;
		}
		if (SwitchArrow)
		{
			num += 2;
		}
		if (DefaultPenguinItemId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DefaultPenguinItemId);
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
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ThrowGiftLevel other)
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
			if (other.DayOpen != 0)
			{
				DayOpen = other.DayOpen;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.DifficultyName.Length != 0)
			{
				DifficultyName = other.DifficultyName;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.LevelName.Length != 0)
			{
				LevelName = other.LevelName;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.CountDownLimit != 0)
			{
				CountDownLimit = other.CountDownLimit;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.ThrowGiftLevelCond != 0)
			{
				ThrowGiftLevelCond = other.ThrowGiftLevelCond;
			}
			if (other.ThrowGiftLevelParams != 0)
			{
				ThrowGiftLevelParams = other.ThrowGiftLevelParams;
			}
			if (other.ThrowGiftLevelCondDesc.Length != 0)
			{
				ThrowGiftLevelCondDesc = other.ThrowGiftLevelCondDesc;
			}
			if (other.FlightPath)
			{
				FlightPath = other.FlightPath;
			}
			if (other.SwitchArrow)
			{
				SwitchArrow = other.SwitchArrow;
			}
			if (other.DefaultPenguinItemId != 0)
			{
				DefaultPenguinItemId = other.DefaultPenguinItemId;
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
				DayOpen = input.ReadInt32();
				break;
			case 32u:
				Difficulty = input.ReadInt32();
				break;
			case 42u:
				DifficultyName = input.ReadString();
				break;
			case 50u:
				Icon = input.ReadString();
				break;
			case 58u:
				LevelName = input.ReadString();
				break;
			case 64u:
				FloorId = input.ReadInt32();
				break;
			case 72u:
				CountDownLimit = input.ReadInt32();
				break;
			case 80u:
				PreLevelId = input.ReadInt32();
				break;
			case 88u:
				ThrowGiftLevelCond = input.ReadInt32();
				break;
			case 96u:
				ThrowGiftLevelParams = input.ReadInt32();
				break;
			case 106u:
				ThrowGiftLevelCondDesc = input.ReadString();
				break;
			case 112u:
				FlightPath = input.ReadBool();
				break;
			case 120u:
				SwitchArrow = input.ReadBool();
				break;
			case 128u:
				DefaultPenguinItemId = input.ReadInt32();
				break;
			case 136u:
				FirstCompleteReward1Tid = input.ReadInt32();
				break;
			case 144u:
				FirstCompleteReward1Qty = input.ReadInt32();
				break;
			case 152u:
				FirstCompleteReward2Tid = input.ReadInt32();
				break;
			case 160u:
				FirstCompleteReward2Qty = input.ReadInt32();
				break;
			}
		}
	}
}
