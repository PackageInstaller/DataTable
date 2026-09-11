using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Config;

public sealed class affix_type : IMessage<affix_type>, IMessage, IEquatable<affix_type>, IDeepCloneable<affix_type>
{
	private static readonly MessageParser<affix_type> _parser = new MessageParser<affix_type>(() => new affix_type());

	public const int IDFieldNumber = 1;

	private int iD_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int ExtraDescriptionFieldNumber = 3;

	private string extraDescription_ = "";

	public const int DescriptionFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_description_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> description_ = new RepeatedField<int>();

	public const int AffixBuffIdFieldNumber = 5;

	private int affixBuffId_;

	public const int BuffidFieldNumber = 6;

	private static readonly FieldCodec<int> _repeated_buffid_codec = FieldCodec.ForInt32(50u);

	private readonly RepeatedField<int> buffid_ = new RepeatedField<int>();

	public const int MaxLevelFieldNumber = 7;

	private int maxLevel_;

	public const int LogicIdFieldNumber = 8;

	private int logicId_;

	public const int BaseFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_base_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> base_ = new RepeatedField<int>();

	public const int FactorFieldNumber = 10;

	private static readonly FieldCodec<int> _repeated_factor_codec = FieldCodec.ForInt32(82u);

	private readonly RepeatedField<int> factor_ = new RepeatedField<int>();

	public const int FlowscriptFieldNumber = 11;

	private static readonly FieldCodec<string> _repeated_flowscript_codec = FieldCodec.ForString(90u);

	private readonly RepeatedField<string> flowscript_ = new RepeatedField<string>();

	[DebuggerNonUserCode]
	public static MessageParser<affix_type> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => ConfigReflection.Descriptor.MessageTypes[76];

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public int ID
	{
		get
		{
			return iD_;
		}
		set
		{
			iD_ = value;
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
	public string ExtraDescription
	{
		get
		{
			return extraDescription_;
		}
		set
		{
			extraDescription_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Description => description_;

	[DebuggerNonUserCode]
	public int AffixBuffId
	{
		get
		{
			return affixBuffId_;
		}
		set
		{
			affixBuffId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Buffid => buffid_;

	[DebuggerNonUserCode]
	public int MaxLevel
	{
		get
		{
			return maxLevel_;
		}
		set
		{
			maxLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LogicId
	{
		get
		{
			return logicId_;
		}
		set
		{
			logicId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Base => base_;

	[DebuggerNonUserCode]
	public RepeatedField<int> Factor => factor_;

	[DebuggerNonUserCode]
	public RepeatedField<string> Flowscript => flowscript_;

	[DebuggerNonUserCode]
	public affix_type()
	{
	}

	[DebuggerNonUserCode]
	public affix_type(affix_type other)
		: this()
	{
		iD_ = other.iD_;
		name_ = other.name_;
		extraDescription_ = other.extraDescription_;
		description_ = other.description_.Clone();
		affixBuffId_ = other.affixBuffId_;
		buffid_ = other.buffid_.Clone();
		maxLevel_ = other.maxLevel_;
		logicId_ = other.logicId_;
		base_ = other.base_.Clone();
		factor_ = other.factor_.Clone();
		flowscript_ = other.flowscript_.Clone();
	}

	[DebuggerNonUserCode]
	public affix_type Clone()
	{
		return new affix_type(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as affix_type);
	}

	[DebuggerNonUserCode]
	public bool Equals(affix_type other)
	{
		if (other == null)
		{
			return false;
		}
		if (other == this)
		{
			return true;
		}
		if (ID != other.ID)
		{
			return false;
		}
		if (Name != other.Name)
		{
			return false;
		}
		if (ExtraDescription != other.ExtraDescription)
		{
			return false;
		}
		if (!description_.Equals(other.description_))
		{
			return false;
		}
		if (AffixBuffId != other.AffixBuffId)
		{
			return false;
		}
		if (!buffid_.Equals(other.buffid_))
		{
			return false;
		}
		if (MaxLevel != other.MaxLevel)
		{
			return false;
		}
		if (LogicId != other.LogicId)
		{
			return false;
		}
		if (!base_.Equals(other.base_))
		{
			return false;
		}
		if (!factor_.Equals(other.factor_))
		{
			return false;
		}
		if (!flowscript_.Equals(other.flowscript_))
		{
			return false;
		}
		return true;
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (ID != 0)
		{
			num ^= ID.GetHashCode();
		}
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		if (ExtraDescription.Length != 0)
		{
			num ^= ExtraDescription.GetHashCode();
		}
		num ^= description_.GetHashCode();
		if (AffixBuffId != 0)
		{
			num ^= AffixBuffId.GetHashCode();
		}
		num ^= buffid_.GetHashCode();
		if (MaxLevel != 0)
		{
			num ^= MaxLevel.GetHashCode();
		}
		if (LogicId != 0)
		{
			num ^= LogicId.GetHashCode();
		}
		num ^= base_.GetHashCode();
		num ^= factor_.GetHashCode();
		return num ^ flowscript_.GetHashCode();
	}

	[DebuggerNonUserCode]
	public override string ToString()
	{
		return JsonFormatter.ToDiagnosticString(this);
	}

	[DebuggerNonUserCode]
	public void WriteTo(CodedOutputStream output)
	{
		if (ID != 0)
		{
			output.WriteRawTag(8);
			output.WriteInt32(ID);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (ExtraDescription.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(ExtraDescription);
		}
		description_.WriteTo(output, _repeated_description_codec);
		if (AffixBuffId != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(AffixBuffId);
		}
		buffid_.WriteTo(output, _repeated_buffid_codec);
		if (MaxLevel != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(MaxLevel);
		}
		if (LogicId != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(LogicId);
		}
		base_.WriteTo(output, _repeated_base_codec);
		factor_.WriteTo(output, _repeated_factor_codec);
		flowscript_.WriteTo(output, _repeated_flowscript_codec);
	}

	[DebuggerNonUserCode]
	public int CalculateSize()
	{
		int num = 0;
		if (ID != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ID);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (ExtraDescription.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(ExtraDescription);
		}
		num += description_.CalculateSize(_repeated_description_codec);
		if (AffixBuffId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffixBuffId);
		}
		num += buffid_.CalculateSize(_repeated_buffid_codec);
		if (MaxLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxLevel);
		}
		if (LogicId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(LogicId);
		}
		num += base_.CalculateSize(_repeated_base_codec);
		num += factor_.CalculateSize(_repeated_factor_codec);
		return num + flowscript_.CalculateSize(_repeated_flowscript_codec);
	}

	[DebuggerNonUserCode]
	public void MergeFrom(affix_type other)
	{
		if (other != null)
		{
			if (other.ID != 0)
			{
				ID = other.ID;
			}
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			if (other.ExtraDescription.Length != 0)
			{
				ExtraDescription = other.ExtraDescription;
			}
			description_.Add(other.description_);
			if (other.AffixBuffId != 0)
			{
				AffixBuffId = other.AffixBuffId;
			}
			buffid_.Add(other.buffid_);
			if (other.MaxLevel != 0)
			{
				MaxLevel = other.MaxLevel;
			}
			if (other.LogicId != 0)
			{
				LogicId = other.LogicId;
			}
			base_.Add(other.base_);
			factor_.Add(other.factor_);
			flowscript_.Add(other.flowscript_);
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
				ID = input.ReadInt32();
				break;
			case 18u:
				Name = input.ReadString();
				break;
			case 26u:
				ExtraDescription = input.ReadString();
				break;
			case 32u:
			case 34u:
				description_.AddEntriesFrom(input, _repeated_description_codec);
				break;
			case 40u:
				AffixBuffId = input.ReadInt32();
				break;
			case 48u:
			case 50u:
				buffid_.AddEntriesFrom(input, _repeated_buffid_codec);
				break;
			case 56u:
				MaxLevel = input.ReadInt32();
				break;
			case 64u:
				LogicId = input.ReadInt32();
				break;
			case 72u:
			case 74u:
				base_.AddEntriesFrom(input, _repeated_base_codec);
				break;
			case 80u:
			case 82u:
				factor_.AddEntriesFrom(input, _repeated_factor_codec);
				break;
			case 90u:
				flowscript_.AddEntriesFrom(input, _repeated_flowscript_codec);
				break;
			}
		}
	}
}
