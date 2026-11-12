using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GoldenSpyBuffCard : IMessage<GoldenSpyBuffCard>, IMessage, IEquatable<GoldenSpyBuffCard>, IDeepCloneable<GoldenSpyBuffCard>
{
	private static readonly MessageParser<GoldenSpyBuffCard> _parser = new MessageParser<GoldenSpyBuffCard>(() => new GoldenSpyBuffCard());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int LabelFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_label_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> label_ = new RepeatedField<int>();

	public const int EffectTypeFieldNumber = 4;

	private int effectType_;

	public const int ParamsFieldNumber = 5;

	private static readonly FieldCodec<float> _repeated_params_codec = FieldCodec.ForFloat(42u);

	private readonly RepeatedField<float> params_ = new RepeatedField<float>();

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int IconFieldNumber = 7;

	private string icon_ = "";

	public const int BuffTypeFieldNumber = 8;

	private int buffType_;

	public const int MaxCountFieldNumber = 9;

	private int maxCount_;

	public const int ConnectItemsFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_connectItems_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> connectItems_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<GoldenSpyBuffCard> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(388);

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
	public RepeatedField<int> Label => label_;

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
	public RepeatedField<float> Params => params_;

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
	public int BuffType
	{
		get
		{
			return buffType_;
		}
		set
		{
			buffType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MaxCount
	{
		get
		{
			return maxCount_;
		}
		set
		{
			maxCount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> ConnectItems => connectItems_;

	[DebuggerNonUserCode]
	public GoldenSpyBuffCard()
	{
	}

	[DebuggerNonUserCode]
	public GoldenSpyBuffCard(GoldenSpyBuffCard other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		label_ = other.label_.Clone();
		effectType_ = other.effectType_;
		params_ = other.params_.Clone();
		desc_ = other.desc_;
		icon_ = other.icon_;
		buffType_ = other.buffType_;
		maxCount_ = other.maxCount_;
		connectItems_ = other.connectItems_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GoldenSpyBuffCard Clone()
	{
		return new GoldenSpyBuffCard(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GoldenSpyBuffCard);
	}

	[DebuggerNonUserCode]
	public bool Equals(GoldenSpyBuffCard other)
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
		if (!label_.Equals(other.label_))
		{
			return false;
		}
		if (EffectType != other.EffectType)
		{
			return false;
		}
		if (!params_.Equals(other.params_))
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (Icon != other.Icon)
		{
			return false;
		}
		if (BuffType != other.BuffType)
		{
			return false;
		}
		if (MaxCount != other.MaxCount)
		{
			return false;
		}
		if (!connectItems_.Equals(other.connectItems_))
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
		num ^= label_.GetHashCode();
		if (EffectType != 0)
		{
			num ^= EffectType.GetHashCode();
		}
		num ^= params_.GetHashCode();
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (BuffType != 0)
		{
			num ^= BuffType.GetHashCode();
		}
		if (MaxCount != 0)
		{
			num ^= MaxCount.GetHashCode();
		}
		num ^= connectItems_.GetHashCode();
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
		label_.WriteTo(output, _repeated_label_codec);
		if (EffectType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(EffectType);
		}
		params_.WriteTo(output, _repeated_params_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (Icon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(Icon);
		}
		if (BuffType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(BuffType);
		}
		if (MaxCount != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(MaxCount);
		}
		connectItems_.WriteTo(output, _repeated_connectItems_codec);
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
		num += label_.CalculateSize(_repeated_label_codec);
		if (EffectType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EffectType);
		}
		num += params_.CalculateSize(_repeated_params_codec);
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (BuffType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BuffType);
		}
		if (MaxCount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxCount);
		}
		num += connectItems_.CalculateSize(_repeated_connectItems_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GoldenSpyBuffCard other)
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
			label_.Add(other.label_);
			if (other.EffectType != 0)
			{
				EffectType = other.EffectType;
			}
			params_.Add(other.params_);
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.BuffType != 0)
			{
				BuffType = other.BuffType;
			}
			if (other.MaxCount != 0)
			{
				MaxCount = other.MaxCount;
			}
			connectItems_.Add(other.connectItems_);
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
			case 26u:
				label_.AddEntriesFrom(input, _repeated_label_codec);
				break;
			case 32u:
				EffectType = input.ReadInt32();
				break;
			case 42u:
			case 45u:
				params_.AddEntriesFrom(input, _repeated_params_codec);
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 58u:
				Icon = input.ReadString();
				break;
			case 64u:
				BuffType = input.ReadInt32();
				break;
			case 72u:
				MaxCount = input.ReadInt32();
				break;
			case 80u:
			case 82u:
				connectItems_.AddEntriesFrom(input, _repeated_connectItems_codec);
				break;
			}
		}
	}
}
