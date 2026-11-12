using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class PenguinCardBuff : IMessage<PenguinCardBuff>, IMessage, IEquatable<PenguinCardBuff>, IDeepCloneable<PenguinCardBuff>
{
	private static readonly MessageParser<PenguinCardBuff> _parser = new MessageParser<PenguinCardBuff>(() => new PenguinCardBuff());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int DescFieldNumber = 3;

	private string desc_ = "";

	public const int ForcedReplacementFieldNumber = 4;

	private bool forcedReplacement_;

	public const int TriggerPhaseFieldNumber = 5;

	private int triggerPhase_;

	public const int TriggerTypeFieldNumber = 6;

	private int triggerType_;

	public const int TriggerParamFieldNumber = 7;

	private string triggerParam_ = "";

	public const int TriggerProbabilityFieldNumber = 8;

	private int triggerProbability_;

	public const int TriggerLimitFieldNumber = 9;

	private int triggerLimit_;

	public const int TriggerLimitParamFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_triggerLimitParam_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> triggerLimitParam_ = new RepeatedField<int>();

	public const int EffectTypeFieldNumber = 11;

	private int effectType_;

	public const int EffectParamFieldNumber = 12;

	private string effectParam_ = "";

	public const int GrowthEffectParamFieldNumber = 13;

	private string growthEffectParam_ = "";

	public const int DurationFieldNumber = 14;

	private int duration_;

	public const int DurationParamFieldNumber = 15;

	private int durationParam_;

	public const int IconFieldNumber = 16;

	private string icon_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<PenguinCardBuff> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(620);

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
	public string Title
	{
		get
		{
			return title_;
		}
		set
		{
			title_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Desc
	{
		get
		{
			return desc_;
		}
		set
		{
			desc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool ForcedReplacement
	{
		get
		{
			return forcedReplacement_;
		}
		set
		{
			forcedReplacement_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerPhase
	{
		get
		{
			return triggerPhase_;
		}
		set
		{
			triggerPhase_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerType
	{
		get
		{
			return triggerType_;
		}
		set
		{
			triggerType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string TriggerParam
	{
		get
		{
			return triggerParam_;
		}
		set
		{
			triggerParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int TriggerProbability
	{
		get
		{
			return triggerProbability_;
		}
		set
		{
			triggerProbability_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TriggerLimit
	{
		get
		{
			return triggerLimit_;
		}
		set
		{
			triggerLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TriggerLimitParam => triggerLimitParam_;

	[DebuggerNonUserCode]
	public int EffectType
	{
		get
		{
			return effectType_;
		}
		set
		{
			effectType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string EffectParam
	{
		get
		{
			return effectParam_;
		}
		set
		{
			effectParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string GrowthEffectParam
	{
		get
		{
			return growthEffectParam_;
		}
		set
		{
			growthEffectParam_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Duration
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
	public int DurationParam
	{
		get
		{
			return durationParam_;
		}
		set
		{
			durationParam_ = value;
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
	public PenguinCardBuff()
	{
	}

	[DebuggerNonUserCode]
	public PenguinCardBuff(PenguinCardBuff other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		desc_ = other.desc_;
		forcedReplacement_ = other.forcedReplacement_;
		triggerPhase_ = other.triggerPhase_;
		triggerType_ = other.triggerType_;
		triggerParam_ = other.triggerParam_;
		triggerProbability_ = other.triggerProbability_;
		triggerLimit_ = other.triggerLimit_;
		triggerLimitParam_ = other.triggerLimitParam_.Clone();
		effectType_ = other.effectType_;
		effectParam_ = other.effectParam_;
		growthEffectParam_ = other.growthEffectParam_;
		duration_ = other.duration_;
		durationParam_ = other.durationParam_;
		icon_ = other.icon_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public PenguinCardBuff Clone()
	{
		return new PenguinCardBuff(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as PenguinCardBuff);
	}

	[DebuggerNonUserCode]
	public bool Equals(PenguinCardBuff other)
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
		if (Title != other.Title)
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (ForcedReplacement != other.ForcedReplacement)
		{
			return false;
		}
		if (TriggerPhase != other.TriggerPhase)
		{
			return false;
		}
		if (TriggerType != other.TriggerType)
		{
			return false;
		}
		if (TriggerParam != other.TriggerParam)
		{
			return false;
		}
		if (TriggerProbability != other.TriggerProbability)
		{
			return false;
		}
		if (TriggerLimit != other.TriggerLimit)
		{
			return false;
		}
		if (!triggerLimitParam_.Equals(other.triggerLimitParam_))
		{
			return false;
		}
		if (EffectType != other.EffectType)
		{
			return false;
		}
		if (EffectParam != other.EffectParam)
		{
			return false;
		}
		if (GrowthEffectParam != other.GrowthEffectParam)
		{
			return false;
		}
		if (Duration != other.Duration)
		{
			return false;
		}
		if (DurationParam != other.DurationParam)
		{
			return false;
		}
		if (Icon != other.Icon)
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
		if (Title.Length != 0)
		{
			num ^= Title.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (ForcedReplacement)
		{
			num ^= ForcedReplacement.GetHashCode();
		}
		if (TriggerPhase != 0)
		{
			num ^= TriggerPhase.GetHashCode();
		}
		if (TriggerType != 0)
		{
			num ^= TriggerType.GetHashCode();
		}
		if (TriggerParam.Length != 0)
		{
			num ^= TriggerParam.GetHashCode();
		}
		if (TriggerProbability != 0)
		{
			num ^= TriggerProbability.GetHashCode();
		}
		if (TriggerLimit != 0)
		{
			num ^= TriggerLimit.GetHashCode();
		}
		num ^= triggerLimitParam_.GetHashCode();
		if (EffectType != 0)
		{
			num ^= EffectType.GetHashCode();
		}
		if (EffectParam.Length != 0)
		{
			num ^= EffectParam.GetHashCode();
		}
		if (GrowthEffectParam.Length != 0)
		{
			num ^= GrowthEffectParam.GetHashCode();
		}
		if (Duration != 0)
		{
			num ^= Duration.GetHashCode();
		}
		if (DurationParam != 0)
		{
			num ^= DurationParam.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
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
		if (Title.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Title);
		}
		if (Desc.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Desc);
		}
		if (ForcedReplacement)
		{
			output.WriteRawTag(32);
			output.WriteBool(ForcedReplacement);
		}
		if (TriggerPhase != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(TriggerPhase);
		}
		if (TriggerType != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(TriggerType);
		}
		if (TriggerParam.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(TriggerParam);
		}
		if (TriggerProbability != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(TriggerProbability);
		}
		if (TriggerLimit != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(TriggerLimit);
		}
		triggerLimitParam_.WriteTo(output, _repeated_triggerLimitParam_codec);
		if (EffectType != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(EffectType);
		}
		if (EffectParam.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(EffectParam);
		}
		if (GrowthEffectParam.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(GrowthEffectParam);
		}
		if (Duration != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(Duration);
		}
		if (DurationParam != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(DurationParam);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(Icon);
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
		if (Title.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Title);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (ForcedReplacement)
		{
			num += 2;
		}
		if (TriggerPhase != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerPhase);
		}
		if (TriggerType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerType);
		}
		if (TriggerParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(TriggerParam);
		}
		if (TriggerProbability != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerProbability);
		}
		if (TriggerLimit != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TriggerLimit);
		}
		num += triggerLimitParam_.CalculateSize(_repeated_triggerLimitParam_codec);
		if (EffectType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectType);
		}
		if (EffectParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(EffectParam);
		}
		if (GrowthEffectParam.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(GrowthEffectParam);
		}
		if (Duration != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Duration);
		}
		if (DurationParam != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DurationParam);
		}
		if (Icon.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(PenguinCardBuff other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Title.Length != 0)
			{
				Title = other.Title;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.ForcedReplacement)
			{
				ForcedReplacement = other.ForcedReplacement;
			}
			if (other.TriggerPhase != 0)
			{
				TriggerPhase = other.TriggerPhase;
			}
			if (other.TriggerType != 0)
			{
				TriggerType = other.TriggerType;
			}
			if (other.TriggerParam.Length != 0)
			{
				TriggerParam = other.TriggerParam;
			}
			if (other.TriggerProbability != 0)
			{
				TriggerProbability = other.TriggerProbability;
			}
			if (other.TriggerLimit != 0)
			{
				TriggerLimit = other.TriggerLimit;
			}
			triggerLimitParam_.Add(other.triggerLimitParam_);
			if (other.EffectType != 0)
			{
				EffectType = other.EffectType;
			}
			if (other.EffectParam.Length != 0)
			{
				EffectParam = other.EffectParam;
			}
			if (other.GrowthEffectParam.Length != 0)
			{
				GrowthEffectParam = other.GrowthEffectParam;
			}
			if (other.Duration != 0)
			{
				Duration = other.Duration;
			}
			if (other.DurationParam != 0)
			{
				DurationParam = other.DurationParam;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
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
				Title = input.ReadString();
				break;
			case 26u:
				Desc = input.ReadString();
				break;
			case 32u:
				ForcedReplacement = input.ReadBool();
				break;
			case 40u:
				TriggerPhase = input.ReadInt32();
				break;
			case 48u:
				TriggerType = input.ReadInt32();
				break;
			case 58u:
				TriggerParam = input.ReadString();
				break;
			case 64u:
				TriggerProbability = input.ReadInt32();
				break;
			case 72u:
				TriggerLimit = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				triggerLimitParam_.AddEntriesFrom(input, _repeated_triggerLimitParam_codec);
				break;
			case 88u:
				EffectType = input.ReadInt32();
				break;
			case 98u:
				EffectParam = input.ReadString();
				break;
			case 106u:
				GrowthEffectParam = input.ReadString();
				break;
			case 112u:
				Duration = input.ReadInt32();
				break;
			case 120u:
				DurationParam = input.ReadInt32();
				break;
			case 130u:
				Icon = input.ReadString();
				break;
			}
		}
	}
}
