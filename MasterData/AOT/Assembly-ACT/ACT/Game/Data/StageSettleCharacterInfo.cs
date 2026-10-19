using System;
using System.CodeDom.Compiler;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace ACT.Game.Data;

public sealed class StageSettleCharacterInfo : IMessage<StageSettleCharacterInfo>, IMessage, IEquatable<StageSettleCharacterInfo>, IDeepCloneable<StageSettleCharacterInfo>, IBufferMessage
{
	private static readonly MessageParser<StageSettleCharacterInfo> _parser = new MessageParser<StageSettleCharacterInfo>(() => new StageSettleCharacterInfo());

	private UnknownFieldSet _unknownFields;

	public const int CharacterIDFieldNumber = 1;

	private int characterID_;

	public const int CharacterLvFieldNumber = 2;

	private int characterLv_;

	public const int DamageFieldNumber = 3;

	private long damage_;

	public const int HpPercentFieldNumber = 4;

	private float hpPercent_;

	public const int DurationFieldNumber = 5;

	private float duration_;

	public const int PotionUseCountFieldNumber = 6;

	private int potionUseCount_;

	public const int ExSkillUseCountFieldNumber = 7;

	private int exSkillUseCount_;

	public const int DodgeCountFieldNumber = 8;

	private int dodgeCount_;

	public const int TriggeredNodeCountFieldNumber = 9;

	private static readonly MapField<int, int>.Codec _map_triggeredNodeCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 74u);

	private readonly MapField<int, int> triggeredNodeCount_ = new MapField<int, int>();

	public const int BreakDiffTypeMonsterShieldCountFieldNumber = 10;

	private static readonly MapField<int, int>.Codec _map_breakDiffTypeMonsterShieldCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 82u);

	private readonly MapField<int, int> breakDiffTypeMonsterShieldCount_ = new MapField<int, int>();

	public const int KillDiffTypeMonsterOnShieldBrokenCountFieldNumber = 11;

	private static readonly MapField<int, int>.Codec _map_killDiffTypeMonsterOnShieldBrokenCount_codec = new MapField<int, int>.Codec(FieldCodec.ForInt32(8u, 0), FieldCodec.ForInt32(16u, 0), 90u);

	private readonly MapField<int, int> killDiffTypeMonsterOnShieldBrokenCount_ = new MapField<int, int>();

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageParser<StageSettleCharacterInfo> Parser => _parser;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public static MessageDescriptor Descriptor => CommonReflection.Descriptor.MessageTypes[203];

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CharacterID
	{
		get
		{
			return characterID_;
		}
		set
		{
			characterID_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int CharacterLv
	{
		get
		{
			return characterLv_;
		}
		set
		{
			characterLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public long Damage
	{
		get
		{
			return damage_;
		}
		set
		{
			damage_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float HpPercent
	{
		get
		{
			return hpPercent_;
		}
		set
		{
			hpPercent_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public float Duration
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
	[GeneratedCode("protoc", null)]
	public int PotionUseCount
	{
		get
		{
			return potionUseCount_;
		}
		set
		{
			potionUseCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int ExSkillUseCount
	{
		get
		{
			return exSkillUseCount_;
		}
		set
		{
			exSkillUseCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public int DodgeCount
	{
		get
		{
			return dodgeCount_;
		}
		set
		{
			dodgeCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> TriggeredNodeCount => triggeredNodeCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> BreakDiffTypeMonsterShieldCount => breakDiffTypeMonsterShieldCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public MapField<int, int> KillDiffTypeMonsterOnShieldBrokenCount => killDiffTypeMonsterOnShieldBrokenCount_;

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleCharacterInfo()
	{
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleCharacterInfo(StageSettleCharacterInfo other)
		: this()
	{
		characterID_ = other.characterID_;
		characterLv_ = other.characterLv_;
		damage_ = other.damage_;
		hpPercent_ = other.hpPercent_;
		duration_ = other.duration_;
		potionUseCount_ = other.potionUseCount_;
		exSkillUseCount_ = other.exSkillUseCount_;
		dodgeCount_ = other.dodgeCount_;
		triggeredNodeCount_ = other.triggeredNodeCount_.Clone();
		breakDiffTypeMonsterShieldCount_ = other.breakDiffTypeMonsterShieldCount_.Clone();
		killDiffTypeMonsterOnShieldBrokenCount_ = other.killDiffTypeMonsterOnShieldBrokenCount_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public StageSettleCharacterInfo Clone()
	{
		return new StageSettleCharacterInfo(this);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public override bool Equals(object other)
	{
		return Equals(other as StageSettleCharacterInfo);
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public bool Equals(StageSettleCharacterInfo other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (CharacterID != other.CharacterID)
		{
			return false;
		}
		if (CharacterLv != other.CharacterLv)
		{
			return false;
		}
		if (Damage != other.Damage)
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(HpPercent, other.HpPercent))
		{
			return false;
		}
		if (!ProtobufEqualityComparers.BitwiseSingleEqualityComparer.Equals(Duration, other.Duration))
		{
			return false;
		}
		if (PotionUseCount != other.PotionUseCount)
		{
			return false;
		}
		if (ExSkillUseCount != other.ExSkillUseCount)
		{
			return false;
		}
		if (DodgeCount != other.DodgeCount)
		{
			return false;
		}
		if (!TriggeredNodeCount.Equals(other.TriggeredNodeCount))
		{
			return false;
		}
		if (!BreakDiffTypeMonsterShieldCount.Equals(other.BreakDiffTypeMonsterShieldCount))
		{
			return false;
		}
		if (!KillDiffTypeMonsterOnShieldBrokenCount.Equals(other.KillDiffTypeMonsterOnShieldBrokenCount))
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
		if (CharacterID != 0)
		{
			num ^= CharacterID.GetHashCode();
		}
		if (CharacterLv != 0)
		{
			num ^= CharacterLv.GetHashCode();
		}
		if (Damage != 0L)
		{
			num ^= Damage.GetHashCode();
		}
		if (HpPercent != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(HpPercent);
		}
		if (Duration != 0f)
		{
			num ^= ProtobufEqualityComparers.BitwiseSingleEqualityComparer.GetHashCode(Duration);
		}
		if (PotionUseCount != 0)
		{
			num ^= PotionUseCount.GetHashCode();
		}
		if (ExSkillUseCount != 0)
		{
			num ^= ExSkillUseCount.GetHashCode();
		}
		if (DodgeCount != 0)
		{
			num ^= DodgeCount.GetHashCode();
		}
		num ^= TriggeredNodeCount.GetHashCode();
		num ^= BreakDiffTypeMonsterShieldCount.GetHashCode();
		num ^= KillDiffTypeMonsterOnShieldBrokenCount.GetHashCode();
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
		if (CharacterID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(CharacterID);
		}
		if (CharacterLv != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(CharacterLv);
		}
		if (Damage != 0L)
		{
			output.WriteRawTag(24);
			output.WriteInt64(Damage);
		}
		if (HpPercent != 0f)
		{
			output.WriteRawTag(37);
			output.WriteFloat(HpPercent);
		}
		if (Duration != 0f)
		{
			output.WriteRawTag(45);
			output.WriteFloat(Duration);
		}
		if (PotionUseCount != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(PotionUseCount);
		}
		if (ExSkillUseCount != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(ExSkillUseCount);
		}
		if (DodgeCount != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(DodgeCount);
		}
		triggeredNodeCount_.WriteTo(ref output, _map_triggeredNodeCount_codec);
		breakDiffTypeMonsterShieldCount_.WriteTo(ref output, _map_breakDiffTypeMonsterShieldCount_codec);
		killDiffTypeMonsterOnShieldBrokenCount_.WriteTo(ref output, _map_killDiffTypeMonsterOnShieldBrokenCount_codec);
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
		if (CharacterID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterID);
		}
		if (CharacterLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CharacterLv);
		}
		if (Damage != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Damage);
		}
		if (HpPercent != 0f)
		{
			num += 5;
		}
		if (Duration != 0f)
		{
			num += 5;
		}
		if (PotionUseCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(PotionUseCount);
		}
		if (ExSkillUseCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ExSkillUseCount);
		}
		if (DodgeCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DodgeCount);
		}
		num += triggeredNodeCount_.CalculateSize(_map_triggeredNodeCount_codec);
		num += breakDiffTypeMonsterShieldCount_.CalculateSize(_map_breakDiffTypeMonsterShieldCount_codec);
		num += killDiffTypeMonsterOnShieldBrokenCount_.CalculateSize(_map_killDiffTypeMonsterOnShieldBrokenCount_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	[GeneratedCode("protoc", null)]
	public void MergeFrom(StageSettleCharacterInfo other)
	{
		if (other != null)
		{
			if (other.CharacterID != 0)
			{
				CharacterID = other.CharacterID;
			}
			if (other.CharacterLv != 0)
			{
				CharacterLv = other.CharacterLv;
			}
			if (other.Damage != 0L)
			{
				Damage = other.Damage;
			}
			if (other.HpPercent != 0f)
			{
				HpPercent = other.HpPercent;
			}
			if (other.Duration != 0f)
			{
				Duration = other.Duration;
			}
			if (other.PotionUseCount != 0)
			{
				PotionUseCount = other.PotionUseCount;
			}
			if (other.ExSkillUseCount != 0)
			{
				ExSkillUseCount = other.ExSkillUseCount;
			}
			if (other.DodgeCount != 0)
			{
				DodgeCount = other.DodgeCount;
			}
			triggeredNodeCount_.Add(other.triggeredNodeCount_);
			breakDiffTypeMonsterShieldCount_.Add(other.breakDiffTypeMonsterShieldCount_);
			killDiffTypeMonsterOnShieldBrokenCount_.Add(other.killDiffTypeMonsterOnShieldBrokenCount_);
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
				CharacterID = input.ReadInt32();
				break;
			case 16u:
				CharacterLv = input.ReadInt32();
				break;
			case 24u:
				Damage = input.ReadInt64();
				break;
			case 37u:
				HpPercent = input.ReadFloat();
				break;
			case 45u:
				Duration = input.ReadFloat();
				break;
			case 48u:
				PotionUseCount = input.ReadInt32();
				break;
			case 56u:
				ExSkillUseCount = input.ReadInt32();
				break;
			case 64u:
				DodgeCount = input.ReadInt32();
				break;
			case 74u:
				triggeredNodeCount_.AddEntriesFrom(ref input, _map_triggeredNodeCount_codec);
				break;
			case 82u:
				breakDiffTypeMonsterShieldCount_.AddEntriesFrom(ref input, _map_breakDiffTypeMonsterShieldCount_codec);
				break;
			case 90u:
				killDiffTypeMonsterOnShieldBrokenCount_.AddEntriesFrom(ref input, _map_killDiffTypeMonsterOnShieldBrokenCount_codec);
				break;
			}
		}
	}
}
