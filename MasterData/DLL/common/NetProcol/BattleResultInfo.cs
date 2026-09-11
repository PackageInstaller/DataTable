using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace NetProcol;

public sealed class BattleResultInfo : IMessage<BattleResultInfo>, IMessage, IEquatable<BattleResultInfo>, IDeepCloneable<BattleResultInfo>
{
	private static readonly MessageParser<BattleResultInfo> _parser = new MessageParser<BattleResultInfo>(() => new BattleResultInfo());

	public const int ResultFieldNumber = 1;

	private bool result_;

	public const int BattleTimeFieldNumber = 2;

	private int battleTime_;

	public const int TotalDeadNumFieldNumber = 3;

	private int totalDeadNum_;

	public const int TotalHittedNumFieldNumber = 4;

	private int totalHittedNum_;

	public const int InjuredNumFieldNumber = 5;

	private long injuredNum_;

	public const int FallDownNumFieldNumber = 6;

	private int fallDownNum_;

	public const int KnockoutNumFieldNumber = 7;

	private int knockoutNum_;

	public const int QteCountFieldNumber = 8;

	private int qteCount_;

	public const int ResurrectTimesFieldNumber = 9;

	private int resurrectTimes_;

	public const int CharsInfoFieldNumber = 10;

	private static readonly FieldCodec<CharResultInfo> _repeated_charsInfo_codec = FieldCodec.ForMessage(82u, CharResultInfo.Parser);

	private readonly RepeatedField<CharResultInfo> charsInfo_ = new RepeatedField<CharResultInfo>();

	public const int EnemyDeadNumFieldNumber = 11;

	private int enemyDeadNum_;

	public const int ItemIDFieldNumber = 12;

	private static readonly FieldCodec<int> _repeated_itemID_codec = FieldCodec.ForInt32(98u);

	private readonly RepeatedField<int> itemID_ = new RepeatedField<int>();

	public const int ItemNumberFieldNumber = 13;

	private static readonly FieldCodec<int> _repeated_itemNumber_codec = FieldCodec.ForInt32(106u);

	private readonly RepeatedField<int> itemNumber_ = new RepeatedField<int>();

	public const int RecordDataIDFieldNumber = 14;

	private static readonly FieldCodec<int> _repeated_recordDataID_codec = FieldCodec.ForInt32(114u);

	private readonly RepeatedField<int> recordDataID_ = new RepeatedField<int>();

	public const int RecordDataNumberFieldNumber = 15;

	private static readonly FieldCodec<int> _repeated_recordDataNumber_codec = FieldCodec.ForInt32(122u);

	private readonly RepeatedField<int> recordDataNumber_ = new RepeatedField<int>();

	public const int FrameCountFieldNumber = 16;

	private uint frameCount_;

	public const int AchievementFieldNumber = 17;

	private static readonly FieldCodec<int> _repeated_achievement_codec = FieldCodec.ForInt32(138u);

	private readonly RepeatedField<int> achievement_ = new RepeatedField<int>();

	public const int ChoosedEffectIDFieldNumber = 18;

	private static readonly FieldCodec<int> _repeated_choosedEffectID_codec = FieldCodec.ForInt32(146u);

	private readonly RepeatedField<int> choosedEffectID_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<BattleResultInfo> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => NetprotoReflection.Descriptor.MessageTypes[18];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public bool Result
	{
		get
		{
			return result_;
		}
		set
		{
			result_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BattleTime
	{
		get
		{
			return battleTime_;
		}
		set
		{
			battleTime_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TotalDeadNum
	{
		get
		{
			return totalDeadNum_;
		}
		set
		{
			totalDeadNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TotalHittedNum
	{
		get
		{
			return totalHittedNum_;
		}
		set
		{
			totalHittedNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long InjuredNum
	{
		get
		{
			return injuredNum_;
		}
		set
		{
			injuredNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FallDownNum
	{
		get
		{
			return fallDownNum_;
		}
		set
		{
			fallDownNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int KnockoutNum
	{
		get
		{
			return knockoutNum_;
		}
		set
		{
			knockoutNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int QteCount
	{
		get
		{
			return qteCount_;
		}
		set
		{
			qteCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ResurrectTimes
	{
		get
		{
			return resurrectTimes_;
		}
		set
		{
			resurrectTimes_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<CharResultInfo> CharsInfo => charsInfo_;

	[DebuggerNonUserCode]
	public int EnemyDeadNum
	{
		get
		{
			return enemyDeadNum_;
		}
		set
		{
			enemyDeadNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ItemID => itemID_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ItemNumber => itemNumber_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RecordDataID => recordDataID_;

	[DebuggerNonUserCode]
	public RepeatedField<int> RecordDataNumber => recordDataNumber_;

	[DebuggerNonUserCode]
	public uint FrameCount
	{
		get
		{
			return frameCount_;
		}
		set
		{
			frameCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Achievement => achievement_;

	[DebuggerNonUserCode]
	public RepeatedField<int> ChoosedEffectID => choosedEffectID_;

	[DebuggerNonUserCode]
	public BattleResultInfo()
	{
	}

	[DebuggerNonUserCode]
	public BattleResultInfo(BattleResultInfo other)
		: this()
	{
		result_ = other.result_;
		battleTime_ = other.battleTime_;
		totalDeadNum_ = other.totalDeadNum_;
		totalHittedNum_ = other.totalHittedNum_;
		injuredNum_ = other.injuredNum_;
		fallDownNum_ = other.fallDownNum_;
		knockoutNum_ = other.knockoutNum_;
		qteCount_ = other.qteCount_;
		resurrectTimes_ = other.resurrectTimes_;
		charsInfo_ = other.charsInfo_.Clone();
		enemyDeadNum_ = other.enemyDeadNum_;
		itemID_ = other.itemID_.Clone();
		itemNumber_ = other.itemNumber_.Clone();
		recordDataID_ = other.recordDataID_.Clone();
		recordDataNumber_ = other.recordDataNumber_.Clone();
		frameCount_ = other.frameCount_;
		achievement_ = other.achievement_.Clone();
		choosedEffectID_ = other.choosedEffectID_.Clone();
	}

	[DebuggerNonUserCode]
	public BattleResultInfo Clone()
	{
		return new BattleResultInfo(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BattleResultInfo);
	}

	[DebuggerNonUserCode]
	public bool Equals(BattleResultInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Result != other.Result)
		{
			return false;
		}
		if (BattleTime != other.BattleTime)
		{
			return false;
		}
		if (TotalDeadNum != other.TotalDeadNum)
		{
			return false;
		}
		if (TotalHittedNum != other.TotalHittedNum)
		{
			return false;
		}
		if (InjuredNum != other.InjuredNum)
		{
			return false;
		}
		if (FallDownNum != other.FallDownNum)
		{
			return false;
		}
		if (KnockoutNum != other.KnockoutNum)
		{
			return false;
		}
		if (QteCount != other.QteCount)
		{
			return false;
		}
		if (ResurrectTimes != other.ResurrectTimes)
		{
			return false;
		}
		if (!charsInfo_.Equals(other.charsInfo_))
		{
			return false;
		}
		if (EnemyDeadNum != other.EnemyDeadNum)
		{
			return false;
		}
		if (!itemID_.Equals(other.itemID_))
		{
			return false;
		}
		if (!itemNumber_.Equals(other.itemNumber_))
		{
			return false;
		}
		if (!recordDataID_.Equals(other.recordDataID_))
		{
			return false;
		}
		if (!recordDataNumber_.Equals(other.recordDataNumber_))
		{
			return false;
		}
		if (FrameCount != other.FrameCount)
		{
			return false;
		}
		if (!achievement_.Equals(other.achievement_))
		{
			return false;
		}
		if (!choosedEffectID_.Equals(other.choosedEffectID_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Result)
		{
			num ^= Result.GetHashCode();
		}
		if (BattleTime != 0)
		{
			num ^= BattleTime.GetHashCode();
		}
		if (TotalDeadNum != 0)
		{
			num ^= TotalDeadNum.GetHashCode();
		}
		if (TotalHittedNum != 0)
		{
			num ^= TotalHittedNum.GetHashCode();
		}
		if (InjuredNum != 0L)
		{
			num ^= InjuredNum.GetHashCode();
		}
		if (FallDownNum != 0)
		{
			num ^= FallDownNum.GetHashCode();
		}
		if (KnockoutNum != 0)
		{
			num ^= KnockoutNum.GetHashCode();
		}
		if (QteCount != 0)
		{
			num ^= QteCount.GetHashCode();
		}
		if (ResurrectTimes != 0)
		{
			num ^= ResurrectTimes.GetHashCode();
		}
		num ^= charsInfo_.GetHashCode();
		if (EnemyDeadNum != 0)
		{
			num ^= EnemyDeadNum.GetHashCode();
		}
		num ^= itemID_.GetHashCode();
		num ^= itemNumber_.GetHashCode();
		num ^= recordDataID_.GetHashCode();
		num ^= recordDataNumber_.GetHashCode();
		if (FrameCount != 0)
		{
			num ^= FrameCount.GetHashCode();
		}
		num ^= achievement_.GetHashCode();
		return num ^ choosedEffectID_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (Result)
		{
			output.WriteRawTag(8);
			output.WriteBool(Result);
		}
		if (BattleTime != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(BattleTime);
		}
		if (TotalDeadNum != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(TotalDeadNum);
		}
		if (TotalHittedNum != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TotalHittedNum);
		}
		if (InjuredNum != 0L)
		{
			output.WriteRawTag(40);
			output.WriteInt64(InjuredNum);
		}
		if (FallDownNum != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(FallDownNum);
		}
		if (KnockoutNum != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(KnockoutNum);
		}
		if (QteCount != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(QteCount);
		}
		if (ResurrectTimes != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(ResurrectTimes);
		}
		charsInfo_.WriteTo(output, _repeated_charsInfo_codec);
		if (EnemyDeadNum != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(EnemyDeadNum);
		}
		itemID_.WriteTo(output, _repeated_itemID_codec);
		itemNumber_.WriteTo(output, _repeated_itemNumber_codec);
		recordDataID_.WriteTo(output, _repeated_recordDataID_codec);
		recordDataNumber_.WriteTo(output, _repeated_recordDataNumber_codec);
		if (FrameCount != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteUInt32(FrameCount);
		}
		achievement_.WriteTo(output, _repeated_achievement_codec);
		choosedEffectID_.WriteTo(output, _repeated_choosedEffectID_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (Result)
		{
			num += 2;
		}
		if (BattleTime != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BattleTime);
		}
		if (TotalDeadNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalDeadNum);
		}
		if (TotalHittedNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TotalHittedNum);
		}
		if (InjuredNum != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(InjuredNum);
		}
		if (FallDownNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FallDownNum);
		}
		if (KnockoutNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(KnockoutNum);
		}
		if (QteCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(QteCount);
		}
		if (ResurrectTimes != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ResurrectTimes);
		}
		num += charsInfo_.CalculateSize(_repeated_charsInfo_codec);
		if (EnemyDeadNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EnemyDeadNum);
		}
		num += itemID_.CalculateSize(_repeated_itemID_codec);
		num += itemNumber_.CalculateSize(_repeated_itemNumber_codec);
		num += recordDataID_.CalculateSize(_repeated_recordDataID_codec);
		num += recordDataNumber_.CalculateSize(_repeated_recordDataNumber_codec);
		if (FrameCount != 0)
		{
			num += 2 + CodedOutputStream.ComputeUInt32Size(FrameCount);
		}
		num += achievement_.CalculateSize(_repeated_achievement_codec);
		return num + choosedEffectID_.CalculateSize(_repeated_choosedEffectID_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BattleResultInfo other)
	{
		if (other != null)
		{
			if (other.Result)
			{
				Result = other.Result;
			}
			if (other.BattleTime != 0)
			{
				BattleTime = other.BattleTime;
			}
			if (other.TotalDeadNum != 0)
			{
				TotalDeadNum = other.TotalDeadNum;
			}
			if (other.TotalHittedNum != 0)
			{
				TotalHittedNum = other.TotalHittedNum;
			}
			if (other.InjuredNum != 0L)
			{
				InjuredNum = other.InjuredNum;
			}
			if (other.FallDownNum != 0)
			{
				FallDownNum = other.FallDownNum;
			}
			if (other.KnockoutNum != 0)
			{
				KnockoutNum = other.KnockoutNum;
			}
			if (other.QteCount != 0)
			{
				QteCount = other.QteCount;
			}
			if (other.ResurrectTimes != 0)
			{
				ResurrectTimes = other.ResurrectTimes;
			}
			charsInfo_.Add(other.charsInfo_);
			if (other.EnemyDeadNum != 0)
			{
				EnemyDeadNum = other.EnemyDeadNum;
			}
			itemID_.Add(other.itemID_);
			itemNumber_.Add(other.itemNumber_);
			recordDataID_.Add(other.recordDataID_);
			recordDataNumber_.Add(other.recordDataNumber_);
			if (other.FrameCount != 0)
			{
				FrameCount = other.FrameCount;
			}
			achievement_.Add(other.achievement_);
			choosedEffectID_.Add(other.choosedEffectID_);
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
				input.SkipLastField();
				break;
			case 8u:
				Result = input.ReadBool();
				break;
			case 16u:
				BattleTime = input.ReadInt32();
				break;
			case 24u:
				TotalDeadNum = input.ReadInt32();
				break;
			case 32u:
				TotalHittedNum = input.ReadInt32();
				break;
			case 40u:
				InjuredNum = input.ReadInt64();
				break;
			case 48u:
				FallDownNum = input.ReadInt32();
				break;
			case 56u:
				KnockoutNum = input.ReadInt32();
				break;
			case 64u:
				QteCount = input.ReadInt32();
				break;
			case 72u:
				ResurrectTimes = input.ReadInt32();
				break;
			case 82u:
				charsInfo_.AddEntriesFrom(input, _repeated_charsInfo_codec);
				break;
			case 88u:
				EnemyDeadNum = input.ReadInt32();
				break;
			case 96u:
			case 98u:
				itemID_.AddEntriesFrom(input, _repeated_itemID_codec);
				break;
			case 104u:
			case 106u:
				itemNumber_.AddEntriesFrom(input, _repeated_itemNumber_codec);
				break;
			case 112u:
			case 114u:
				recordDataID_.AddEntriesFrom(input, _repeated_recordDataID_codec);
				break;
			case 120u:
			case 122u:
				recordDataNumber_.AddEntriesFrom(input, _repeated_recordDataNumber_codec);
				break;
			case 128u:
				FrameCount = input.ReadUInt32();
				break;
			case 136u:
			case 138u:
				achievement_.AddEntriesFrom(input, _repeated_achievement_codec);
				break;
			case 144u:
			case 146u:
				choosedEffectID_.AddEntriesFrom(input, _repeated_choosedEffectID_codec);
				break;
			}
		}
	}
}
