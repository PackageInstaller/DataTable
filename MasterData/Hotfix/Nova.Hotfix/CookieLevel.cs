using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class CookieLevel : IMessage<CookieLevel>, IMessage, IEquatable<CookieLevel>, IDeepCloneable<CookieLevel>
{
	private static readonly MessageParser<CookieLevel> _parser = new MessageParser<CookieLevel>(() => new CookieLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int ActivityIdFieldNumber = 2;

	private int activityId_;

	public const int DayOpenFieldNumber = 3;

	private int dayOpen_;

	public const int NameFieldNumber = 4;

	private string name_ = "";

	public const int IconResFieldNumber = 5;

	private string iconRes_ = "";

	public const int PackTypeFieldNumber = 6;

	private int packType_;

	public const int DifficultyFieldNumber = 7;

	private int difficulty_;

	public const int PackModelFieldNumber = 8;

	private int packModel_;

	public const int FloorIdFieldNumber = 9;

	private int floorId_;

	public const int PreLevelIdFieldNumber = 10;

	private int preLevelId_;

	public const int FirstCompletionScoreFieldNumber = 11;

	private int firstCompletionScore_;

	public const int PackContentFieldNumber = 12;

	private string packContent_ = "";

	public const int CountDownLimitFieldNumber = 13;

	private int countDownLimit_;

	public const int ReturnCdFieldNumber = 14;

	private int returnCd_;

	public const int FirstCompletionReward1TidFieldNumber = 15;

	private int firstCompletionReward1Tid_;

	public const int FirstCompletionReward1QtyFieldNumber = 16;

	private int firstCompletionReward1Qty_;

	public const int FirstCompletionReward2TidFieldNumber = 17;

	private int firstCompletionReward2Tid_;

	public const int FirstCompletionReward2QtyFieldNumber = 18;

	private int firstCompletionReward2Qty_;

	[DebuggerNonUserCode]
	public static MessageParser<CookieLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(220);

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
	public string IconRes
	{
		get
		{
			return iconRes_;
		}
		set
		{
			iconRes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int PackType
	{
		get
		{
			return packType_;
		}
		set
		{
			packType_ = value;
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
	public int PackModel
	{
		get
		{
			return packModel_;
		}
		set
		{
			packModel_ = value;
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
	public int FirstCompletionScore
	{
		get
		{
			return firstCompletionScore_;
		}
		set
		{
			firstCompletionScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string PackContent
	{
		get
		{
			return packContent_;
		}
		set
		{
			packContent_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int ReturnCd
	{
		get
		{
			return returnCd_;
		}
		set
		{
			returnCd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompletionReward1Tid
	{
		get
		{
			return firstCompletionReward1Tid_;
		}
		set
		{
			firstCompletionReward1Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompletionReward1Qty
	{
		get
		{
			return firstCompletionReward1Qty_;
		}
		set
		{
			firstCompletionReward1Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompletionReward2Tid
	{
		get
		{
			return firstCompletionReward2Tid_;
		}
		set
		{
			firstCompletionReward2Tid_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FirstCompletionReward2Qty
	{
		get
		{
			return firstCompletionReward2Qty_;
		}
		set
		{
			firstCompletionReward2Qty_ = value;
		}
	}

	[DebuggerNonUserCode]
	public CookieLevel()
	{
	}

	[DebuggerNonUserCode]
	public CookieLevel(CookieLevel other)
		: this()
	{
		id_ = other.id_;
		activityId_ = other.activityId_;
		dayOpen_ = other.dayOpen_;
		name_ = other.name_;
		iconRes_ = other.iconRes_;
		packType_ = other.packType_;
		difficulty_ = other.difficulty_;
		packModel_ = other.packModel_;
		floorId_ = other.floorId_;
		preLevelId_ = other.preLevelId_;
		firstCompletionScore_ = other.firstCompletionScore_;
		packContent_ = other.packContent_;
		countDownLimit_ = other.countDownLimit_;
		returnCd_ = other.returnCd_;
		firstCompletionReward1Tid_ = other.firstCompletionReward1Tid_;
		firstCompletionReward1Qty_ = other.firstCompletionReward1Qty_;
		firstCompletionReward2Tid_ = other.firstCompletionReward2Tid_;
		firstCompletionReward2Qty_ = other.firstCompletionReward2Qty_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public CookieLevel Clone()
	{
		return new CookieLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as CookieLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(CookieLevel other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (IconRes != other.IconRes)
		{
			return false;
		}
		if (PackType != other.PackType)
		{
			return false;
		}
		if (Difficulty != other.Difficulty)
		{
			return false;
		}
		if (PackModel != other.PackModel)
		{
			return false;
		}
		if (FloorId != other.FloorId)
		{
			return false;
		}
		if (PreLevelId != other.PreLevelId)
		{
			return false;
		}
		if (FirstCompletionScore != other.FirstCompletionScore)
		{
			return false;
		}
		if (PackContent != other.PackContent)
		{
			return false;
		}
		if (CountDownLimit != other.CountDownLimit)
		{
			return false;
		}
		if (ReturnCd != other.ReturnCd)
		{
			return false;
		}
		if (FirstCompletionReward1Tid != other.FirstCompletionReward1Tid)
		{
			return false;
		}
		if (FirstCompletionReward1Qty != other.FirstCompletionReward1Qty)
		{
			return false;
		}
		if (FirstCompletionReward2Tid != other.FirstCompletionReward2Tid)
		{
			return false;
		}
		if (FirstCompletionReward2Qty != other.FirstCompletionReward2Qty)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (IconRes.Length != 0)
		{
			num ^= IconRes.GetHashCode();
		}
		if (PackType != 0)
		{
			num ^= PackType.GetHashCode();
		}
		if (Difficulty != 0)
		{
			num ^= Difficulty.GetHashCode();
		}
		if (PackModel != 0)
		{
			num ^= PackModel.GetHashCode();
		}
		if (FloorId != 0)
		{
			num ^= FloorId.GetHashCode();
		}
		if (PreLevelId != 0)
		{
			num ^= PreLevelId.GetHashCode();
		}
		if (FirstCompletionScore != 0)
		{
			num ^= FirstCompletionScore.GetHashCode();
		}
		if (PackContent.Length != 0)
		{
			num ^= PackContent.GetHashCode();
		}
		if (CountDownLimit != 0)
		{
			num ^= CountDownLimit.GetHashCode();
		}
		if (ReturnCd != 0)
		{
			num ^= ReturnCd.GetHashCode();
		}
		if (FirstCompletionReward1Tid != 0)
		{
			num ^= FirstCompletionReward1Tid.GetHashCode();
		}
		if (FirstCompletionReward1Qty != 0)
		{
			num ^= FirstCompletionReward1Qty.GetHashCode();
		}
		if (FirstCompletionReward2Tid != 0)
		{
			num ^= FirstCompletionReward2Tid.GetHashCode();
		}
		if (FirstCompletionReward2Qty != 0)
		{
			num ^= FirstCompletionReward2Qty.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(Name);
		}
		if (IconRes.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(IconRes);
		}
		if (PackType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PackType);
		}
		if (Difficulty != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(Difficulty);
		}
		if (PackModel != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(PackModel);
		}
		if (FloorId != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(FloorId);
		}
		if (PreLevelId != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(PreLevelId);
		}
		if (FirstCompletionScore != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(FirstCompletionScore);
		}
		if (PackContent.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(PackContent);
		}
		if (CountDownLimit != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(CountDownLimit);
		}
		if (ReturnCd != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(ReturnCd);
		}
		if (FirstCompletionReward1Tid != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(FirstCompletionReward1Tid);
		}
		if (FirstCompletionReward1Qty != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(FirstCompletionReward1Qty);
		}
		if (FirstCompletionReward2Tid != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(FirstCompletionReward2Tid);
		}
		if (FirstCompletionReward2Qty != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(FirstCompletionReward2Qty);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (IconRes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(IconRes);
		}
		if (PackType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PackType);
		}
		if (Difficulty != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Difficulty);
		}
		if (PackModel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PackModel);
		}
		if (FloorId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FloorId);
		}
		if (PreLevelId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PreLevelId);
		}
		if (FirstCompletionScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstCompletionScore);
		}
		if (PackContent.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(PackContent);
		}
		if (CountDownLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CountDownLimit);
		}
		if (ReturnCd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ReturnCd);
		}
		if (FirstCompletionReward1Tid != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FirstCompletionReward1Tid);
		}
		if (FirstCompletionReward1Qty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstCompletionReward1Qty);
		}
		if (FirstCompletionReward2Tid != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstCompletionReward2Tid);
		}
		if (FirstCompletionReward2Qty != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FirstCompletionReward2Qty);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(CookieLevel other)
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
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.IconRes.Length != 0)
			{
				IconRes = other.IconRes;
			}
			if (other.PackType != 0)
			{
				PackType = other.PackType;
			}
			if (other.Difficulty != 0)
			{
				Difficulty = other.Difficulty;
			}
			if (other.PackModel != 0)
			{
				PackModel = other.PackModel;
			}
			if (other.FloorId != 0)
			{
				FloorId = other.FloorId;
			}
			if (other.PreLevelId != 0)
			{
				PreLevelId = other.PreLevelId;
			}
			if (other.FirstCompletionScore != 0)
			{
				FirstCompletionScore = other.FirstCompletionScore;
			}
			if (other.PackContent.Length != 0)
			{
				PackContent = other.PackContent;
			}
			if (other.CountDownLimit != 0)
			{
				CountDownLimit = other.CountDownLimit;
			}
			if (other.ReturnCd != 0)
			{
				ReturnCd = other.ReturnCd;
			}
			if (other.FirstCompletionReward1Tid != 0)
			{
				FirstCompletionReward1Tid = other.FirstCompletionReward1Tid;
			}
			if (other.FirstCompletionReward1Qty != 0)
			{
				FirstCompletionReward1Qty = other.FirstCompletionReward1Qty;
			}
			if (other.FirstCompletionReward2Tid != 0)
			{
				FirstCompletionReward2Tid = other.FirstCompletionReward2Tid;
			}
			if (other.FirstCompletionReward2Qty != 0)
			{
				FirstCompletionReward2Qty = other.FirstCompletionReward2Qty;
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
			case 34u:
				Name = input.ReadString();
				break;
			case 42u:
				IconRes = input.ReadString();
				break;
			case 48u:
				PackType = input.ReadInt32();
				break;
			case 56u:
				Difficulty = input.ReadInt32();
				break;
			case 64u:
				PackModel = input.ReadInt32();
				break;
			case 72u:
				FloorId = input.ReadInt32();
				break;
			case 80u:
				PreLevelId = input.ReadInt32();
				break;
			case 88u:
				FirstCompletionScore = input.ReadInt32();
				break;
			case 98u:
				PackContent = input.ReadString();
				break;
			case 104u:
				CountDownLimit = input.ReadInt32();
				break;
			case 112u:
				ReturnCd = input.ReadInt32();
				break;
			case 120u:
				FirstCompletionReward1Tid = input.ReadInt32();
				break;
			case 128u:
				FirstCompletionReward1Qty = input.ReadInt32();
				break;
			case 136u:
				FirstCompletionReward2Tid = input.ReadInt32();
				break;
			case 144u:
				FirstCompletionReward2Qty = input.ReadInt32();
				break;
			}
		}
	}
}
