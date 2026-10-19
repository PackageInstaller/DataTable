using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class BattlePassDbModel : IMessage<BattlePassDbModel>, IMessage, IEquatable<BattlePassDbModel>, IDeepCloneable<BattlePassDbModel>, IBufferMessage
{
	private static readonly MessageParser<BattlePassDbModel> _parser = new MessageParser<BattlePassDbModel>(() => new BattlePassDbModel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int LevelFieldNumber = 2;

	private int level_;

	public const int ExpFieldNumber = 3;

	private int exp_;

	public const int WeeklyExpFieldNumber = 4;

	private int weeklyExp_;

	public const int PremiumFieldNumber = 5;

	private bool premium_;

	public const int ClaimedTasksFieldNumber = 6;

	private static readonly MapField<int, ClaimedTask>.Codec _map_claimedTasks_codec = new MapField<int, ClaimedTask>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForMessage(18u, ClaimedTask.Parser), 50u);

	private readonly MapField<int, ClaimedTask> claimedTasks_ = new MapField<int, ClaimedTask>();

	public const int ClaimedFreeRewardsFieldNumber = 7;

	private static readonly MapField<int, bool>.Codec _map_claimedFreeRewards_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 58u);

	private readonly MapField<int, bool> claimedFreeRewards_ = new MapField<int, bool>();

	public const int ClaimedPremiumRewardsFieldNumber = 8;

	private static readonly MapField<int, bool>.Codec _map_claimedPremiumRewards_codec = new MapField<int, bool>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForBool(16u, defaultValue: false), 66u);

	private readonly MapField<int, bool> claimedPremiumRewards_ = new MapField<int, bool>();

	public const int PayLevelFieldNumber = 9;

	private BattlePassPayLevel payLevel_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<BattlePassDbModel> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[292];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
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
	[GeneratedCode("protoc", null)]
	public int WeeklyExp
	{
		get
		{
			return weeklyExp_;
		}
		set
		{
			weeklyExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Premium
	{
		get
		{
			return premium_;
		}
		set
		{
			premium_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, ClaimedTask> ClaimedTasks => claimedTasks_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ClaimedFreeRewards => claimedFreeRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, bool> ClaimedPremiumRewards => claimedPremiumRewards_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassPayLevel PayLevel
	{
		get
		{
			return payLevel_;
		}
		set
		{
			payLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassDbModel()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassDbModel(BattlePassDbModel other)
		: this()
	{
		id_ = other.id_;
		level_ = other.level_;
		exp_ = other.exp_;
		weeklyExp_ = other.weeklyExp_;
		premium_ = other.premium_;
		claimedTasks_ = other.claimedTasks_.Clone();
		claimedFreeRewards_ = other.claimedFreeRewards_.Clone();
		claimedPremiumRewards_ = other.claimedPremiumRewards_.Clone();
		payLevel_ = other.payLevel_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public BattlePassDbModel Clone()
	{
		return new BattlePassDbModel(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as BattlePassDbModel);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(BattlePassDbModel other)
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
		if (Level != other.Level)
		{
			return false;
		}
		if (Exp != other.Exp)
		{
			return false;
		}
		if (WeeklyExp != other.WeeklyExp)
		{
			return false;
		}
		if (Premium != other.Premium)
		{
			return false;
		}
		if (!ClaimedTasks.Equals(other.ClaimedTasks))
		{
			return false;
		}
		if (!ClaimedFreeRewards.Equals(other.ClaimedFreeRewards))
		{
			return false;
		}
		if (!ClaimedPremiumRewards.Equals(other.ClaimedPremiumRewards))
		{
			return false;
		}
		if (PayLevel != other.PayLevel)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (Level != 0)
		{
			num ^= Level.GetHashCode();
		}
		if (Exp != 0)
		{
			num ^= Exp.GetHashCode();
		}
		if (WeeklyExp != 0)
		{
			num ^= WeeklyExp.GetHashCode();
		}
		if (Premium)
		{
			num ^= Premium.GetHashCode();
		}
		num ^= ClaimedTasks.GetHashCode();
		num ^= ClaimedFreeRewards.GetHashCode();
		num ^= ClaimedPremiumRewards.GetHashCode();
		if (PayLevel != BattlePassPayLevel.BattlePassPayNull)
		{
			num ^= PayLevel.GetHashCode();
		}
		if (_unknownFields != null)
		{
			num ^= _unknownFields.GetHashCode();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void WriteTo(CodedOutputStream output)
	{
		output.WriteRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalWriteTo(ref WriteContext output)
	{
		if (Id != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(Id);
		}
		if (Level != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Level);
		}
		if (Exp != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Exp);
		}
		if (WeeklyExp != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(WeeklyExp);
		}
		if (Premium)
		{
			output.WriteRawTag(40);
			output.WriteBool(Premium);
		}
		claimedTasks_.WriteTo(ref output, _map_claimedTasks_codec);
		claimedFreeRewards_.WriteTo(ref output, _map_claimedFreeRewards_codec);
		claimedPremiumRewards_.WriteTo(ref output, _map_claimedPremiumRewards_codec);
		if (PayLevel != BattlePassPayLevel.BattlePassPayNull)
		{
			output.WriteRawTag(72);
			output.WriteEnum((int)PayLevel);
		}
		if (_unknownFields != null)
		{
			_unknownFields.WriteTo(ref output);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CalculateSize()
	{
		int num = 0;
		if (Id != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Id);
		}
		if (Level != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Level);
		}
		if (Exp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Exp);
		}
		if (WeeklyExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WeeklyExp);
		}
		if (Premium)
		{
			num += 2;
		}
		num += claimedTasks_.CalculateSize(_map_claimedTasks_codec);
		num += claimedFreeRewards_.CalculateSize(_map_claimedFreeRewards_codec);
		num += claimedPremiumRewards_.CalculateSize(_map_claimedPremiumRewards_codec);
		if (PayLevel != BattlePassPayLevel.BattlePassPayNull)
		{
			num += 1 + CodedOutputStream.ComputeEnumSize((int)PayLevel);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(BattlePassDbModel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Level != 0)
			{
				Level = other.Level;
			}
			if (other.Exp != 0)
			{
				Exp = other.Exp;
			}
			if (other.WeeklyExp != 0)
			{
				WeeklyExp = other.WeeklyExp;
			}
			if (other.Premium)
			{
				Premium = other.Premium;
			}
			claimedTasks_.Add(other.claimedTasks_);
			claimedFreeRewards_.Add(other.claimedFreeRewards_);
			claimedPremiumRewards_.Add(other.claimedPremiumRewards_);
			if (other.PayLevel != BattlePassPayLevel.BattlePassPayNull)
			{
				PayLevel = other.PayLevel;
			}
			_unknownFields = UnknownFieldSet.MergeFrom(_unknownFields, other._unknownFields);
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(CodedInputStream input)
	{
		input.ReadRawMessage(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	void IBufferMessage.InternalMergeFrom(ref ParseContext input)
	{
		uint num;
		while ((num = input.ReadTag()) != 0)
		{
			switch (num)
			{
			default:
				_unknownFields = UnknownFieldSet.MergeFieldFrom(_unknownFields, ref input);
				break;
			case 8u:
				Id = input.ReadInt32();
				break;
			case 16u:
				Level = input.ReadInt32();
				break;
			case 24u:
				Exp = input.ReadInt32();
				break;
			case 32u:
				WeeklyExp = input.ReadInt32();
				break;
			case 40u:
				Premium = input.ReadBool();
				break;
			case 50u:
				claimedTasks_.AddEntriesFrom(ref input, _map_claimedTasks_codec);
				break;
			case 58u:
				claimedFreeRewards_.AddEntriesFrom(ref input, _map_claimedFreeRewards_codec);
				break;
			case 66u:
				claimedPremiumRewards_.AddEntriesFrom(ref input, _map_claimedPremiumRewards_codec);
				break;
			case 72u:
				PayLevel = (BattlePassPayLevel)input.ReadEnum();
				break;
			}
		}
	}
}
