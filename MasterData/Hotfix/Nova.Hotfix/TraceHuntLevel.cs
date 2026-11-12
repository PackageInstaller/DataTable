using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class TraceHuntLevel : IMessage<TraceHuntLevel>, IMessage, IEquatable<TraceHuntLevel>, IDeepCloneable<TraceHuntLevel>
{
	private static readonly MessageParser<TraceHuntLevel> _parser = new MessageParser<TraceHuntLevel>(() => new TraceHuntLevel());

	private UnknownFieldSet _unknownFields;

	public const int LevelFieldNumber = 1;

	private int level_;

	public const int ExpFieldNumber = 2;

	private int exp_;

	public const int WorldClassFieldNumber = 3;

	private int worldClass_;

	public const int MaxStarFieldNumber = 4;

	private int maxStar_;

	public const int TokenRateFieldNumber = 5;

	private int tokenRate_;

	public const int DifficultyListFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_difficultyList_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> difficultyList_ = new RepeatedField<int>();

	public const int DisplayMaxStarFieldNumber = 7;

	private int displayMaxStar_;

	public const int DisplayTokenRateFieldNumber = 8;

	private int displayTokenRate_;

	public const int DisplayLuckyRateFieldNumber = 9;

	private int displayLuckyRate_;

	public const int DisplayAddRateFieldNumber = 10;

	private int displayAddRate_;

	public const int DisplayFreeRateFieldNumber = 11;

	private int displayFreeRate_;

	public const int VoluntaryFieldNumber = 12;

	private bool voluntary_;

	[DebuggerNonUserCode]
	public static MessageParser<TraceHuntLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(988);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int Level
	{
		get
		{
			return level_;
		}
		set
		{
			level_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Exp
	{
		get
		{
			return exp_;
		}
		set
		{
			exp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WorldClass
	{
		get
		{
			return worldClass_;
		}
		set
		{
			worldClass_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxStar
	{
		get
		{
			return maxStar_;
		}
		set
		{
			maxStar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TokenRate
	{
		get
		{
			return tokenRate_;
		}
		set
		{
			tokenRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> DifficultyList => difficultyList_;

	[DebuggerNonUserCode]
	public int DisplayMaxStar
	{
		get
		{
			return displayMaxStar_;
		}
		set
		{
			displayMaxStar_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DisplayTokenRate
	{
		get
		{
			return displayTokenRate_;
		}
		set
		{
			displayTokenRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DisplayLuckyRate
	{
		get
		{
			return displayLuckyRate_;
		}
		set
		{
			displayLuckyRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DisplayAddRate
	{
		get
		{
			return displayAddRate_;
		}
		set
		{
			displayAddRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DisplayFreeRate
	{
		get
		{
			return displayFreeRate_;
		}
		set
		{
			displayFreeRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool Voluntary
	{
		get
		{
			return voluntary_;
		}
		set
		{
			voluntary_ = value;
		}
	}

	[DebuggerNonUserCode]
	public TraceHuntLevel()
	{
	}

	[DebuggerNonUserCode]
	public TraceHuntLevel(TraceHuntLevel other)
		: this()
	{
		level_ = other.level_;
		exp_ = other.exp_;
		worldClass_ = other.worldClass_;
		maxStar_ = other.maxStar_;
		tokenRate_ = other.tokenRate_;
		difficultyList_ = other.difficultyList_.Clone();
		displayMaxStar_ = other.displayMaxStar_;
		displayTokenRate_ = other.displayTokenRate_;
		displayLuckyRate_ = other.displayLuckyRate_;
		displayAddRate_ = other.displayAddRate_;
		displayFreeRate_ = other.displayFreeRate_;
		voluntary_ = other.voluntary_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public TraceHuntLevel Clone()
	{
		return new TraceHuntLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as TraceHuntLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(TraceHuntLevel other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (Level != other.Level)
		{
			return false;
		}
		if (Exp != other.Exp)
		{
			return false;
		}
		if (WorldClass != other.WorldClass)
		{
			return false;
		}
		if (MaxStar != other.MaxStar)
		{
			return false;
		}
		if (TokenRate != other.TokenRate)
		{
			return false;
		}
		if (!difficultyList_.Equals(other.difficultyList_))
		{
			return false;
		}
		if (DisplayMaxStar != other.DisplayMaxStar)
		{
			return false;
		}
		if (DisplayTokenRate != other.DisplayTokenRate)
		{
			return false;
		}
		if (DisplayLuckyRate != other.DisplayLuckyRate)
		{
			return false;
		}
		if (DisplayAddRate != other.DisplayAddRate)
		{
			return false;
		}
		if (DisplayFreeRate != other.DisplayFreeRate)
		{
			return false;
		}
		if (Voluntary != other.Voluntary)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (WorldClass != 0)
		{
			num ^= WorldClass.GetHashCode();
		}
		if (MaxStar != 0)
		{
			num ^= MaxStar.GetHashCode();
		}
		if (TokenRate != 0)
		{
			num ^= TokenRate.GetHashCode();
		}
		num ^= difficultyList_.GetHashCode();
		if (DisplayMaxStar != 0)
		{
			num ^= DisplayMaxStar.GetHashCode();
		}
		if (DisplayTokenRate != 0)
		{
			num ^= DisplayTokenRate.GetHashCode();
		}
		if (DisplayLuckyRate != 0)
		{
			num ^= DisplayLuckyRate.GetHashCode();
		}
		if (DisplayAddRate != 0)
		{
			num ^= DisplayAddRate.GetHashCode();
		}
		if (DisplayFreeRate != 0)
		{
			num ^= DisplayFreeRate.GetHashCode();
		}
		if (Voluntary)
		{
			num ^= Voluntary.GetHashCode();
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
		if (Level != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Level);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Exp);
		}
		if (WorldClass != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(WorldClass);
		}
		if (MaxStar != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(MaxStar);
		}
		if (TokenRate != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(TokenRate);
		}
		difficultyList_.WriteTo(output, _repeated_difficultyList_codec);
		if (DisplayMaxStar != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(DisplayMaxStar);
		}
		if (DisplayTokenRate != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DisplayTokenRate);
		}
		if (DisplayLuckyRate != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(DisplayLuckyRate);
		}
		if (DisplayAddRate != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(DisplayAddRate);
		}
		if (DisplayFreeRate != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(DisplayFreeRate);
		}
		if (Voluntary)
		{
			output.WriteRawTag(96);
			output.WriteBool(Voluntary);
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
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (WorldClass != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WorldClass);
		}
		if (MaxStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxStar);
		}
		if (TokenRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TokenRate);
		}
		num += difficultyList_.CalculateSize(_repeated_difficultyList_codec);
		if (DisplayMaxStar != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DisplayMaxStar);
		}
		if (DisplayTokenRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DisplayTokenRate);
		}
		if (DisplayLuckyRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DisplayLuckyRate);
		}
		if (DisplayAddRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DisplayAddRate);
		}
		if (DisplayFreeRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DisplayFreeRate);
		}
		if (Voluntary)
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
	public void MergeFrom(TraceHuntLevel other)
	{
		if (other != null)
		{
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Exp != 0)
			{
				Exp = other.Exp;
			}
			if (other.WorldClass != 0)
			{
				WorldClass = other.WorldClass;
			}
			if (other.MaxStar != 0)
			{
				MaxStar = other.MaxStar;
			}
			if (other.TokenRate != 0)
			{
				TokenRate = other.TokenRate;
			}
			difficultyList_.Add(other.difficultyList_);
			if (other.DisplayMaxStar != 0)
			{
				DisplayMaxStar = other.DisplayMaxStar;
			}
			if (other.DisplayTokenRate != 0)
			{
				DisplayTokenRate = other.DisplayTokenRate;
			}
			if (other.DisplayLuckyRate != 0)
			{
				DisplayLuckyRate = other.DisplayLuckyRate;
			}
			if (other.DisplayAddRate != 0)
			{
				DisplayAddRate = other.DisplayAddRate;
			}
			if (other.DisplayFreeRate != 0)
			{
				DisplayFreeRate = other.DisplayFreeRate;
			}
			if (other.Voluntary)
			{
				Voluntary = other.Voluntary;
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
				Level = input.ReadInt32();
				break;
			case 16u:
				Exp = input.ReadInt32();
				break;
			case 24u:
				WorldClass = input.ReadInt32();
				break;
			case 32u:
				MaxStar = input.ReadInt32();
				break;
			case 40u:
				TokenRate = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				difficultyList_.AddEntriesFrom(input, _repeated_difficultyList_codec);
				break;
			case 56u:
				DisplayMaxStar = input.ReadInt32();
				break;
			case 64u:
				DisplayTokenRate = input.ReadInt32();
				break;
			case 72u:
				DisplayLuckyRate = input.ReadInt32();
				break;
			case 80u:
				DisplayAddRate = input.ReadInt32();
				break;
			case 88u:
				DisplayFreeRate = input.ReadInt32();
				break;
			case 96u:
				Voluntary = input.ReadBool();
				break;
			}
		}
	}
}
