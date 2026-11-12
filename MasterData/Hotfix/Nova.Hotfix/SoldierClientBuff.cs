using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class SoldierClientBuff : IMessage<SoldierClientBuff>, IMessage, IEquatable<SoldierClientBuff>, IDeepCloneable<SoldierClientBuff>
{
	private static readonly MessageParser<SoldierClientBuff> _parser = new MessageParser<SoldierClientBuff>(() => new SoldierClientBuff());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int Cond1FieldNumber = 2;

	private int cond1_;

	public const int CondParams1FieldNumber = 3;

	private static readonly FieldCodec<string> _repeated_condParams1_codec = FieldCodec.ForString(26u);

	private readonly RepeatedField<string> condParams1_ = new RepeatedField<string>();

	public const int Cond2FieldNumber = 4;

	private int cond2_;

	public const int CondParams2FieldNumber = 5;

	private static readonly FieldCodec<string> _repeated_condParams2_codec = FieldCodec.ForString(42u);

	private readonly RepeatedField<string> condParams2_ = new RepeatedField<string>();

	public const int Cond3FieldNumber = 6;

	private int cond3_;

	public const int CondParams3FieldNumber = 7;

	private static readonly FieldCodec<string> _repeated_condParams3_codec = FieldCodec.ForString(58u);

	private readonly RepeatedField<string> condParams3_ = new RepeatedField<string>();

	public const int TargetTypeFieldNumber = 8;

	private int targetType_;

	public const int TargetParamFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_targetParam_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> targetParam_ = new RepeatedField<int>();

	public const int Effect1FieldNumber = 10;

	private int effect1_;

	public const int EffectParams1FieldNumber = 11;

	private static readonly FieldCodec<string> _repeated_effectParams1_codec = FieldCodec.ForString(90u);

	private readonly RepeatedField<string> effectParams1_ = new RepeatedField<string>();

	public const int Effect2FieldNumber = 12;

	private int effect2_;

	public const int EffectParams2FieldNumber = 13;

	private static readonly FieldCodec<string> _repeated_effectParams2_codec = FieldCodec.ForString(106u);

	private readonly RepeatedField<string> effectParams2_ = new RepeatedField<string>();

	public const int Effect3FieldNumber = 14;

	private int effect3_;

	public const int EffectParams3FieldNumber = 15;

	private static readonly FieldCodec<string> _repeated_effectParams3_codec = FieldCodec.ForString(122u);

	private readonly RepeatedField<string> effectParams3_ = new RepeatedField<string>();

	[DebuggerNonUserCode]
	public static MessageParser<SoldierClientBuff> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(750);

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
	public int Cond1
	{
		get
		{
			return cond1_;
		}
		set
		{
			cond1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> CondParams1 => condParams1_;

	[DebuggerNonUserCode]
	public int Cond2
	{
		get
		{
			return cond2_;
		}
		set
		{
			cond2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> CondParams2 => condParams2_;

	[DebuggerNonUserCode]
	public int Cond3
	{
		get
		{
			return cond3_;
		}
		set
		{
			cond3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> CondParams3 => condParams3_;

	[DebuggerNonUserCode]
	public int TargetType
	{
		get
		{
			return targetType_;
		}
		set
		{
			targetType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TargetParam => targetParam_;

	[DebuggerNonUserCode]
	public int Effect1
	{
		get
		{
			return effect1_;
		}
		set
		{
			effect1_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> EffectParams1 => effectParams1_;

	[DebuggerNonUserCode]
	public int Effect2
	{
		get
		{
			return effect2_;
		}
		set
		{
			effect2_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> EffectParams2 => effectParams2_;

	[DebuggerNonUserCode]
	public int Effect3
	{
		get
		{
			return effect3_;
		}
		set
		{
			effect3_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> EffectParams3 => effectParams3_;

	[DebuggerNonUserCode]
	public SoldierClientBuff()
	{
	}

	[DebuggerNonUserCode]
	public SoldierClientBuff(SoldierClientBuff other)
		: this()
	{
		id_ = other.id_;
		cond1_ = other.cond1_;
		condParams1_ = other.condParams1_.Clone();
		cond2_ = other.cond2_;
		condParams2_ = other.condParams2_.Clone();
		cond3_ = other.cond3_;
		condParams3_ = other.condParams3_.Clone();
		targetType_ = other.targetType_;
		targetParam_ = other.targetParam_.Clone();
		effect1_ = other.effect1_;
		effectParams1_ = other.effectParams1_.Clone();
		effect2_ = other.effect2_;
		effectParams2_ = other.effectParams2_.Clone();
		effect3_ = other.effect3_;
		effectParams3_ = other.effectParams3_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public SoldierClientBuff Clone()
	{
		return new SoldierClientBuff(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as SoldierClientBuff);
	}

	[DebuggerNonUserCode]
	public bool Equals(SoldierClientBuff other)
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
		if (Cond1 != other.Cond1)
		{
			return false;
		}
		if (!condParams1_.Equals(other.condParams1_))
		{
			return false;
		}
		if (Cond2 != other.Cond2)
		{
			return false;
		}
		if (!condParams2_.Equals(other.condParams2_))
		{
			return false;
		}
		if (Cond3 != other.Cond3)
		{
			return false;
		}
		if (!condParams3_.Equals(other.condParams3_))
		{
			return false;
		}
		if (TargetType != other.TargetType)
		{
			return false;
		}
		if (!targetParam_.Equals(other.targetParam_))
		{
			return false;
		}
		if (Effect1 != other.Effect1)
		{
			return false;
		}
		if (!effectParams1_.Equals(other.effectParams1_))
		{
			return false;
		}
		if (Effect2 != other.Effect2)
		{
			return false;
		}
		if (!effectParams2_.Equals(other.effectParams2_))
		{
			return false;
		}
		if (Effect3 != other.Effect3)
		{
			return false;
		}
		if (!effectParams3_.Equals(other.effectParams3_))
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
		if (Cond1 != 0)
		{
			num ^= Cond1.GetHashCode();
		}
		num ^= condParams1_.GetHashCode();
		if (Cond2 != 0)
		{
			num ^= Cond2.GetHashCode();
		}
		num ^= condParams2_.GetHashCode();
		if (Cond3 != 0)
		{
			num ^= Cond3.GetHashCode();
		}
		num ^= condParams3_.GetHashCode();
		if (TargetType != 0)
		{
			num ^= TargetType.GetHashCode();
		}
		num ^= targetParam_.GetHashCode();
		if (Effect1 != 0)
		{
			num ^= Effect1.GetHashCode();
		}
		num ^= effectParams1_.GetHashCode();
		if (Effect2 != 0)
		{
			num ^= Effect2.GetHashCode();
		}
		num ^= effectParams2_.GetHashCode();
		if (Effect3 != 0)
		{
			num ^= Effect3.GetHashCode();
		}
		num ^= effectParams3_.GetHashCode();
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
		if (Cond1 != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(Cond1);
		}
		condParams1_.WriteTo(output, _repeated_condParams1_codec);
		if (Cond2 != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Cond2);
		}
		condParams2_.WriteTo(output, _repeated_condParams2_codec);
		if (Cond3 != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Cond3);
		}
		condParams3_.WriteTo(output, _repeated_condParams3_codec);
		if (TargetType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(TargetType);
		}
		targetParam_.WriteTo(output, _repeated_targetParam_codec);
		if (Effect1 != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(Effect1);
		}
		effectParams1_.WriteTo(output, _repeated_effectParams1_codec);
		if (Effect2 != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(Effect2);
		}
		effectParams2_.WriteTo(output, _repeated_effectParams2_codec);
		if (Effect3 != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Effect3);
		}
		effectParams3_.WriteTo(output, _repeated_effectParams3_codec);
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
		if (Cond1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond1);
		}
		num += condParams1_.CalculateSize(_repeated_condParams1_codec);
		if (Cond2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond2);
		}
		num += condParams2_.CalculateSize(_repeated_condParams2_codec);
		if (Cond3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Cond3);
		}
		num += condParams3_.CalculateSize(_repeated_condParams3_codec);
		if (TargetType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TargetType);
		}
		num += targetParam_.CalculateSize(_repeated_targetParam_codec);
		if (Effect1 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect1);
		}
		num += effectParams1_.CalculateSize(_repeated_effectParams1_codec);
		if (Effect2 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect2);
		}
		num += effectParams2_.CalculateSize(_repeated_effectParams2_codec);
		if (Effect3 != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Effect3);
		}
		num += effectParams3_.CalculateSize(_repeated_effectParams3_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(SoldierClientBuff other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Cond1 != 0)
			{
				Cond1 = other.Cond1;
			}
			condParams1_.Add(other.condParams1_);
			if (other.Cond2 != 0)
			{
				Cond2 = other.Cond2;
			}
			condParams2_.Add(other.condParams2_);
			if (other.Cond3 != 0)
			{
				Cond3 = other.Cond3;
			}
			condParams3_.Add(other.condParams3_);
			if (other.TargetType != 0)
			{
				TargetType = other.TargetType;
			}
			targetParam_.Add(other.targetParam_);
			if (other.Effect1 != 0)
			{
				Effect1 = other.Effect1;
			}
			effectParams1_.Add(other.effectParams1_);
			if (other.Effect2 != 0)
			{
				Effect2 = other.Effect2;
			}
			effectParams2_.Add(other.effectParams2_);
			if (other.Effect3 != 0)
			{
				Effect3 = other.Effect3;
			}
			effectParams3_.Add(other.effectParams3_);
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
				Cond1 = input.ReadInt32();
				break;
			case 26u:
				condParams1_.AddEntriesFrom(input, _repeated_condParams1_codec);
				break;
			case 32u:
				Cond2 = input.ReadInt32();
				break;
			case 42u:
				condParams2_.AddEntriesFrom(input, _repeated_condParams2_codec);
				break;
			case 48u:
				Cond3 = input.ReadInt32();
				break;
			case 58u:
				condParams3_.AddEntriesFrom(input, _repeated_condParams3_codec);
				break;
			case 64u:
				TargetType = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				targetParam_.AddEntriesFrom(input, _repeated_targetParam_codec);
				break;
			case 80u:
				Effect1 = input.ReadInt32();
				break;
			case 90u:
				effectParams1_.AddEntriesFrom(input, _repeated_effectParams1_codec);
				break;
			case 96u:
				Effect2 = input.ReadInt32();
				break;
			case 106u:
				effectParams2_.AddEntriesFrom(input, _repeated_effectParams2_codec);
				break;
			case 112u:
				Effect3 = input.ReadInt32();
				break;
			case 122u:
				effectParams3_.AddEntriesFrom(input, _repeated_effectParams3_codec);
				break;
			}
		}
	}
}
