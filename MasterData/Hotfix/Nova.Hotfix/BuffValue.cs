using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class BuffValue : IMessage<BuffValue>, IMessage, IEquatable<BuffValue>, IDeepCloneable<BuffValue>
{
	private static readonly MessageParser<BuffValue> _parser = new MessageParser<BuffValue>(() => new BuffValue());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int SortFieldNumber = 3;

	private int sort_;

	public const int EffectsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_effects_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> effects_ = new RepeatedField<int>();

	public const int BuffEffectsFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_buffEffects_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> buffEffects_ = new RepeatedField<int>();

	public const int TimeFieldNumber = 6;

	private int time_;

	public const int LaminatedNumFieldNumber = 7;

	private int laminatedNum_;

	public const int NumFieldNumber = 8;

	private int num_;

	public const int TimeSuperpositionFieldNumber = 9;

	private int timeSuperposition_;

	public const int TimingFieldNumber = 10;

	private int timing_;

	public const int ReplaceTypeFieldNumber = 11;

	private bool replaceType_;

	public const int ReplaceModeFieldNumber = 12;

	private bool replaceMode_;

	public const int AttackClearFieldNumber = 13;

	private bool attackClear_;

	public const int HitClearFieldNumber = 14;

	private bool hitClear_;

	public const int IsInheritFieldNumber = 15;

	private bool isInherit_;

	public const int IsExitDeleteFieldNumber = 16;

	private bool isExitDelete_;

	[DebuggerNonUserCode]
	public static MessageParser<BuffValue> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(146);

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
	public int Sort
	{
		get
		{
			return sort_;
		}
		set
		{
			sort_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Effects => effects_;

	[DebuggerNonUserCode]
	public RepeatedField<int> BuffEffects => buffEffects_;

	[DebuggerNonUserCode]
	public int Time
	{
		get
		{
			return time_;
		}
		set
		{
			time_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LaminatedNum
	{
		get
		{
			return laminatedNum_;
		}
		set
		{
			laminatedNum_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Num
	{
		get
		{
			return num_;
		}
		set
		{
			num_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TimeSuperposition
	{
		get
		{
			return timeSuperposition_;
		}
		set
		{
			timeSuperposition_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Timing
	{
		get
		{
			return timing_;
		}
		set
		{
			timing_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ReplaceType
	{
		get
		{
			return replaceType_;
		}
		set
		{
			replaceType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ReplaceMode
	{
		get
		{
			return replaceMode_;
		}
		set
		{
			replaceMode_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool AttackClear
	{
		get
		{
			return attackClear_;
		}
		set
		{
			attackClear_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool HitClear
	{
		get
		{
			return hitClear_;
		}
		set
		{
			hitClear_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsInherit
	{
		get
		{
			return isInherit_;
		}
		set
		{
			isInherit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsExitDelete
	{
		get
		{
			return isExitDelete_;
		}
		set
		{
			isExitDelete_ = value;
		}
	}

	[DebuggerNonUserCode]
	public BuffValue()
	{
	}

	[DebuggerNonUserCode]
	public BuffValue(BuffValue other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		sort_ = other.sort_;
		effects_ = other.effects_.Clone();
		buffEffects_ = other.buffEffects_.Clone();
		time_ = other.time_;
		laminatedNum_ = other.laminatedNum_;
		num_ = other.num_;
		timeSuperposition_ = other.timeSuperposition_;
		timing_ = other.timing_;
		replaceType_ = other.replaceType_;
		replaceMode_ = other.replaceMode_;
		attackClear_ = other.attackClear_;
		hitClear_ = other.hitClear_;
		isInherit_ = other.isInherit_;
		isExitDelete_ = other.isExitDelete_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public BuffValue Clone()
	{
		return new BuffValue(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as BuffValue);
	}

	[DebuggerNonUserCode]
	public bool Equals(BuffValue other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (Sort != other.Sort)
		{
			return false;
		}
		if (!effects_.Equals(other.effects_))
		{
			return false;
		}
		if (!buffEffects_.Equals(other.buffEffects_))
		{
			return false;
		}
		if (Time != other.Time)
		{
			return false;
		}
		if (LaminatedNum != other.LaminatedNum)
		{
			return false;
		}
		if (Num != other.Num)
		{
			return false;
		}
		if (TimeSuperposition != other.TimeSuperposition)
		{
			return false;
		}
		if (Timing != other.Timing)
		{
			return false;
		}
		if (ReplaceType != other.ReplaceType)
		{
			return false;
		}
		if (ReplaceMode != other.ReplaceMode)
		{
			return false;
		}
		if (AttackClear != other.AttackClear)
		{
			return false;
		}
		if (HitClear != other.HitClear)
		{
			return false;
		}
		if (IsInherit != other.IsInherit)
		{
			return false;
		}
		if (IsExitDelete != other.IsExitDelete)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (Sort != 0)
		{
			num ^= Sort.GetHashCode();
		}
		num ^= effects_.GetHashCode();
		num ^= buffEffects_.GetHashCode();
		if (Time != 0)
		{
			num ^= Time.GetHashCode();
		}
		if (LaminatedNum != 0)
		{
			num ^= LaminatedNum.GetHashCode();
		}
		if (Num != 0)
		{
			num ^= Num.GetHashCode();
		}
		if (TimeSuperposition != 0)
		{
			num ^= TimeSuperposition.GetHashCode();
		}
		if (Timing != 0)
		{
			num ^= Timing.GetHashCode();
		}
		if (ReplaceType)
		{
			num ^= ReplaceType.GetHashCode();
		}
		if (ReplaceMode)
		{
			num ^= ReplaceMode.GetHashCode();
		}
		if (AttackClear)
		{
			num ^= AttackClear.GetHashCode();
		}
		if (HitClear)
		{
			num ^= HitClear.GetHashCode();
		}
		if (IsInherit)
		{
			num ^= IsInherit.GetHashCode();
		}
		if (IsExitDelete)
		{
			num ^= IsExitDelete.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (Sort != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Sort);
		}
		effects_.WriteTo(output, _repeated_effects_codec);
		buffEffects_.WriteTo(output, _repeated_buffEffects_codec);
		if (Time != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Time);
		}
		if (LaminatedNum != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(LaminatedNum);
		}
		if (Num != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(Num);
		}
		if (TimeSuperposition != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TimeSuperposition);
		}
		if (Timing != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Timing);
		}
		if (ReplaceType)
		{
			output.WriteRawTag(88);
			output.WriteBool(ReplaceType);
		}
		if (ReplaceMode)
		{
			output.WriteRawTag(96);
			output.WriteBool(ReplaceMode);
		}
		if (AttackClear)
		{
			output.WriteRawTag(104);
			output.WriteBool(AttackClear);
		}
		if (HitClear)
		{
			output.WriteRawTag(112);
			output.WriteBool(HitClear);
		}
		if (IsInherit)
		{
			output.WriteRawTag(120);
			output.WriteBool(IsInherit);
		}
		if (IsExitDelete)
		{
			output.WriteRawTag(128, 1);
			output.WriteBool(IsExitDelete);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (Sort != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Sort);
		}
		num += effects_.CalculateSize(_repeated_effects_codec);
		num += buffEffects_.CalculateSize(_repeated_buffEffects_codec);
		if (Time != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Time);
		}
		if (LaminatedNum != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LaminatedNum);
		}
		if (Num != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Num);
		}
		if (TimeSuperposition != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TimeSuperposition);
		}
		if (Timing != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Timing);
		}
		if (ReplaceType)
		{
			num += 2;
		}
		if (ReplaceMode)
		{
			num += 2;
		}
		if (AttackClear)
		{
			num += 2;
		}
		if (HitClear)
		{
			num += 2;
		}
		if (IsInherit)
		{
			num += 2;
		}
		if (IsExitDelete)
		{
			num += 3;
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(BuffValue other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.Sort != 0)
			{
				Sort = other.Sort;
			}
			effects_.Add(other.effects_);
			buffEffects_.Add(other.buffEffects_);
			if (other.Time != 0)
			{
				Time = other.Time;
			}
			if (other.LaminatedNum != 0)
			{
				LaminatedNum = other.LaminatedNum;
			}
			if (other.Num != 0)
			{
				Num = other.Num;
			}
			if (other.TimeSuperposition != 0)
			{
				TimeSuperposition = other.TimeSuperposition;
			}
			if (other.Timing != 0)
			{
				Timing = other.Timing;
			}
			if (other.ReplaceType)
			{
				ReplaceType = other.ReplaceType;
			}
			if (other.ReplaceMode)
			{
				ReplaceMode = other.ReplaceMode;
			}
			if (other.AttackClear)
			{
				AttackClear = other.AttackClear;
			}
			if (other.HitClear)
			{
				HitClear = other.HitClear;
			}
			if (other.IsInherit)
			{
				IsInherit = other.IsInherit;
			}
			if (other.IsExitDelete)
			{
				IsExitDelete = other.IsExitDelete;
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
			case 18u:
				Name = input.ReadString();
				break;
			case 24u:
				Sort = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				effects_.AddEntriesFrom(input, _repeated_effects_codec);
				break;
			case 40u:
			case 42u:
				buffEffects_.AddEntriesFrom(input, _repeated_buffEffects_codec);
				break;
			case 48u:
				Time = input.ReadInt32();
				break;
			case 56u:
				LaminatedNum = input.ReadInt32();
				break;
			case 64u:
				Num = input.ReadInt32();
				break;
			case 72u:
				TimeSuperposition = input.ReadInt32();
				break;
			case 80u:
				Timing = input.ReadInt32();
				break;
			case 88u:
				ReplaceType = input.ReadBool();
				break;
			case 96u:
				ReplaceMode = input.ReadBool();
				break;
			case 104u:
				AttackClear = input.ReadBool();
				break;
			case 112u:
				HitClear = input.ReadBool();
				break;
			case 120u:
				IsInherit = input.ReadBool();
				break;
			case 128u:
				IsExitDelete = input.ReadBool();
				break;
			}
		}
	}
}
