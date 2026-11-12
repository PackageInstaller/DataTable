using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class ScoreBossRank : IMessage<ScoreBossRank>, IMessage, IEquatable<ScoreBossRank>, IDeepCloneable<ScoreBossRank>
{
	private static readonly MessageParser<ScoreBossRank> _parser = new MessageParser<ScoreBossRank>(() => new ScoreBossRank());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SeasonIdFieldNumber = 2;

	private int seasonId_;

	public const int RankLowerFieldNumber = 3;

	private int rankLower_;

	public const int AwardItemTid1FieldNumber = 4;

	private int awardItemTid1_;

	public const int AwardItemNum1FieldNumber = 5;

	private int awardItemNum1_;

	public const int AwardItemTid2FieldNumber = 6;

	private int awardItemTid2_;

	public const int AwardItemNum2FieldNumber = 7;

	private int awardItemNum2_;

	public const int AwardItemTid3FieldNumber = 8;

	private int awardItemTid3_;

	public const int AwardItemNum3FieldNumber = 9;

	private int awardItemNum3_;

	[DebuggerNonUserCode]
	public static MessageParser<ScoreBossRank> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(700);

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
	public int SeasonId
	{
		get
		{
			return seasonId_;
		}
		set
		{
			seasonId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RankLower
	{
		get
		{
			return rankLower_;
		}
		set
		{
			rankLower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemTid1
	{
		get
		{
			return awardItemTid1_;
		}
		set
		{
			awardItemTid1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemNum1
	{
		get
		{
			return awardItemNum1_;
		}
		set
		{
			awardItemNum1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemTid2
	{
		get
		{
			return awardItemTid2_;
		}
		set
		{
			awardItemTid2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemNum2
	{
		get
		{
			return awardItemNum2_;
		}
		set
		{
			awardItemNum2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemTid3
	{
		get
		{
			return awardItemTid3_;
		}
		set
		{
			awardItemTid3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AwardItemNum3
	{
		get
		{
			return awardItemNum3_;
		}
		set
		{
			awardItemNum3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public ScoreBossRank()
	{
	}

	[DebuggerNonUserCode]
	public ScoreBossRank(ScoreBossRank other)
		: this()
	{
		id_ = other.id_;
		seasonId_ = other.seasonId_;
		rankLower_ = other.rankLower_;
		awardItemTid1_ = other.awardItemTid1_;
		awardItemNum1_ = other.awardItemNum1_;
		awardItemTid2_ = other.awardItemTid2_;
		awardItemNum2_ = other.awardItemNum2_;
		awardItemTid3_ = other.awardItemTid3_;
		awardItemNum3_ = other.awardItemNum3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public ScoreBossRank Clone()
	{
		return new ScoreBossRank(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as ScoreBossRank);
	}

	[DebuggerNonUserCode]
	public bool Equals(ScoreBossRank other)
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
		if (SeasonId != other.SeasonId)
		{
			return false;
		}
		if (RankLower != other.RankLower)
		{
			return false;
		}
		if (AwardItemTid1 != other.AwardItemTid1)
		{
			return false;
		}
		if (AwardItemNum1 != other.AwardItemNum1)
		{
			return false;
		}
		if (AwardItemTid2 != other.AwardItemTid2)
		{
			return false;
		}
		if (AwardItemNum2 != other.AwardItemNum2)
		{
			return false;
		}
		if (AwardItemTid3 != other.AwardItemTid3)
		{
			return false;
		}
		if (AwardItemNum3 != other.AwardItemNum3)
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
		if (SeasonId != 0)
		{
			num ^= SeasonId.GetHashCode();
		}
		if (RankLower != 0)
		{
			num ^= RankLower.GetHashCode();
		}
		if (AwardItemTid1 != 0)
		{
			num ^= AwardItemTid1.GetHashCode();
		}
		if (AwardItemNum1 != 0)
		{
			num ^= AwardItemNum1.GetHashCode();
		}
		if (AwardItemTid2 != 0)
		{
			num ^= AwardItemTid2.GetHashCode();
		}
		if (AwardItemNum2 != 0)
		{
			num ^= AwardItemNum2.GetHashCode();
		}
		if (AwardItemTid3 != 0)
		{
			num ^= AwardItemTid3.GetHashCode();
		}
		if (AwardItemNum3 != 0)
		{
			num ^= AwardItemNum3.GetHashCode();
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
		if (SeasonId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SeasonId);
		}
		if (RankLower != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(RankLower);
		}
		if (AwardItemTid1 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(AwardItemTid1);
		}
		if (AwardItemNum1 != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(AwardItemNum1);
		}
		if (AwardItemTid2 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(AwardItemTid2);
		}
		if (AwardItemNum2 != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(AwardItemNum2);
		}
		if (AwardItemTid3 != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(AwardItemTid3);
		}
		if (AwardItemNum3 != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(AwardItemNum3);
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
		if (SeasonId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SeasonId);
		}
		if (RankLower != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RankLower);
		}
		if (AwardItemTid1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemTid1);
		}
		if (AwardItemNum1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemNum1);
		}
		if (AwardItemTid2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemTid2);
		}
		if (AwardItemNum2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemNum2);
		}
		if (AwardItemTid3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemTid3);
		}
		if (AwardItemNum3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AwardItemNum3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(ScoreBossRank other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SeasonId != 0)
			{
				SeasonId = other.SeasonId;
			}
			if (other.RankLower != 0)
			{
				RankLower = other.RankLower;
			}
			if (other.AwardItemTid1 != 0)
			{
				AwardItemTid1 = other.AwardItemTid1;
			}
			if (other.AwardItemNum1 != 0)
			{
				AwardItemNum1 = other.AwardItemNum1;
			}
			if (other.AwardItemTid2 != 0)
			{
				AwardItemTid2 = other.AwardItemTid2;
			}
			if (other.AwardItemNum2 != 0)
			{
				AwardItemNum2 = other.AwardItemNum2;
			}
			if (other.AwardItemTid3 != 0)
			{
				AwardItemTid3 = other.AwardItemTid3;
			}
			if (other.AwardItemNum3 != 0)
			{
				AwardItemNum3 = other.AwardItemNum3;
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
				SeasonId = input.ReadInt32();
				break;
			case 24u:
				RankLower = input.ReadInt32();
				break;
			case 32u:
				AwardItemTid1 = input.ReadInt32();
				break;
			case 40u:
				AwardItemNum1 = input.ReadInt32();
				break;
			case 48u:
				AwardItemTid2 = input.ReadInt32();
				break;
			case 56u:
				AwardItemNum2 = input.ReadInt32();
				break;
			case 64u:
				AwardItemTid3 = input.ReadInt32();
				break;
			case 72u:
				AwardItemNum3 = input.ReadInt32();
				break;
			}
		}
	}
}
