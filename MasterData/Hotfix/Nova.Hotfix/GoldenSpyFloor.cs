using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GoldenSpyFloor : IMessage<GoldenSpyFloor>, IMessage, IEquatable<GoldenSpyFloor>, IDeepCloneable<GoldenSpyFloor>
{
	private static readonly MessageParser<GoldenSpyFloor> _parser = new MessageParser<GoldenSpyFloor>(() => new GoldenSpyFloor());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int SeedLevelFieldNumber = 2;

	private int seedLevel_;

	public const int BgNameFieldNumber = 3;

	private string bgName_ = "";

	public const int PrefabNameFieldNumber = 4;

	private static readonly FieldCodec<string> _repeated_prefabName_codec = FieldCodec.ForString(34u);

	private readonly RepeatedField<string> prefabName_ = new RepeatedField<string>();

	public const int TimeLimitFieldNumber = 5;

	private int timeLimit_;

	public const int GoalScoreFieldNumber = 6;

	private int goalScore_;

	public const int BuffCardCountFieldNumber = 7;

	private int buffCardCount_;

	public const int DictionaryIDFieldNumber = 8;

	private int dictionaryID_;

	[DebuggerNonUserCode]
	public static MessageParser<GoldenSpyFloor> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(398);

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
	public int SeedLevel
	{
		get
		{
			return seedLevel_;
		}
		set
		{
			seedLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BgName
	{
		get
		{
			return bgName_;
		}
		set
		{
			bgName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> PrefabName => prefabName_;

	[DebuggerNonUserCode]
	public int TimeLimit
	{
		get
		{
			return timeLimit_;
		}
		set
		{
			timeLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GoalScore
	{
		get
		{
			return goalScore_;
		}
		set
		{
			goalScore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int BuffCardCount
	{
		get
		{
			return buffCardCount_;
		}
		set
		{
			buffCardCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DictionaryID
	{
		get
		{
			return dictionaryID_;
		}
		set
		{
			dictionaryID_ = value;
		}
	}

	[DebuggerNonUserCode]
	public GoldenSpyFloor()
	{
	}

	[DebuggerNonUserCode]
	public GoldenSpyFloor(GoldenSpyFloor other)
		: this()
	{
		id_ = other.id_;
		seedLevel_ = other.seedLevel_;
		bgName_ = other.bgName_;
		prefabName_ = other.prefabName_.Clone();
		timeLimit_ = other.timeLimit_;
		goalScore_ = other.goalScore_;
		buffCardCount_ = other.buffCardCount_;
		dictionaryID_ = other.dictionaryID_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GoldenSpyFloor Clone()
	{
		return new GoldenSpyFloor(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GoldenSpyFloor);
	}

	[DebuggerNonUserCode]
	public bool Equals(GoldenSpyFloor other)
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
		if (SeedLevel != other.SeedLevel)
		{
			return false;
		}
		if (BgName != other.BgName)
		{
			return false;
		}
		if (!prefabName_.Equals(other.prefabName_))
		{
			return false;
		}
		if (TimeLimit != other.TimeLimit)
		{
			return false;
		}
		if (GoalScore != other.GoalScore)
		{
			return false;
		}
		if (BuffCardCount != other.BuffCardCount)
		{
			return false;
		}
		if (DictionaryID != other.DictionaryID)
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
		if (SeedLevel != 0)
		{
			num ^= SeedLevel.GetHashCode();
		}
		if (BgName.Length != 0)
		{
			num ^= BgName.GetHashCode();
		}
		num ^= prefabName_.GetHashCode();
		if (TimeLimit != 0)
		{
			num ^= TimeLimit.GetHashCode();
		}
		if (GoalScore != 0)
		{
			num ^= GoalScore.GetHashCode();
		}
		if (BuffCardCount != 0)
		{
			num ^= BuffCardCount.GetHashCode();
		}
		if (DictionaryID != 0)
		{
			num ^= DictionaryID.GetHashCode();
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
		if (SeedLevel != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(SeedLevel);
		}
		if (BgName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(BgName);
		}
		prefabName_.WriteTo(output, _repeated_prefabName_codec);
		if (TimeLimit != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(TimeLimit);
		}
		if (GoalScore != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(GoalScore);
		}
		if (BuffCardCount != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(BuffCardCount);
		}
		if (DictionaryID != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DictionaryID);
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
		if (SeedLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SeedLevel);
		}
		if (BgName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BgName);
		}
		num += prefabName_.CalculateSize(_repeated_prefabName_codec);
		if (TimeLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimeLimit);
		}
		if (GoalScore != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GoalScore);
		}
		if (BuffCardCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffCardCount);
		}
		if (DictionaryID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DictionaryID);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GoldenSpyFloor other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.SeedLevel != 0)
			{
				SeedLevel = other.SeedLevel;
			}
			if (other.BgName.Length != 0)
			{
				BgName = other.BgName;
			}
			prefabName_.Add(other.prefabName_);
			if (other.TimeLimit != 0)
			{
				TimeLimit = other.TimeLimit;
			}
			if (other.GoalScore != 0)
			{
				GoalScore = other.GoalScore;
			}
			if (other.BuffCardCount != 0)
			{
				BuffCardCount = other.BuffCardCount;
			}
			if (other.DictionaryID != 0)
			{
				DictionaryID = other.DictionaryID;
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
				SeedLevel = input.ReadInt32();
				break;
			case 26u:
				BgName = input.ReadString();
				break;
			case 34u:
				prefabName_.AddEntriesFrom(input, _repeated_prefabName_codec);
				break;
			case 40u:
				TimeLimit = input.ReadInt32();
				break;
			case 48u:
				GoalScore = input.ReadInt32();
				break;
			case 56u:
				BuffCardCount = input.ReadInt32();
				break;
			case 64u:
				DictionaryID = input.ReadInt32();
				break;
			}
		}
	}
}
