using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class AffinityLevel : IMessage<AffinityLevel>, IMessage, IEquatable<AffinityLevel>, IDeepCloneable<AffinityLevel>
{
	private static readonly MessageParser<AffinityLevel> _parser = new MessageParser<AffinityLevel>(() => new AffinityLevel());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AffinityLevel_FieldNumber = 2;

	private int affinityLevel_;

	public const int NeedExpFieldNumber = 3;

	private int needExp_;

	public const int TemplateIdFieldNumber = 4;

	private int templateId_;

	public const int AffinityLevelNameFieldNumber = 5;

	private string affinityLevelName_ = "";

	public const int AffinityLevelIconFieldNumber = 6;

	private string affinityLevelIcon_ = "";

	public const int AffinityLevelRewardIconFieldNumber = 7;

	private string affinityLevelRewardIcon_ = "";

	public const int AffinityLevelRewardLockIconFieldNumber = 8;

	private string affinityLevelRewardLockIcon_ = "";

	public const int EffectFieldNumber = 9;

	private static readonly FieldCodec<int> _repeated_effect_codec = FieldCodec.ForInt32(74u);

	private readonly RepeatedField<int> effect_ = new RepeatedField<int>();

	public const int AffinityLevelStageFieldNumber = 10;

	private int affinityLevelStage_;

	public const int IsKeyAffinityLevelFieldNumber = 11;

	private bool isKeyAffinityLevel_;

	[DebuggerNonUserCode]
	public static MessageParser<AffinityLevel> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(80);

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
	public int AffinityLevel_
	{
		get
		{
			return affinityLevel_;
		}
		set
		{
			affinityLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NeedExp
	{
		get
		{
			return needExp_;
		}
		set
		{
			needExp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TemplateId
	{
		get
		{
			return templateId_;
		}
		set
		{
			templateId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AffinityLevelName
	{
		get
		{
			return affinityLevelName_;
		}
		set
		{
			affinityLevelName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AffinityLevelIcon
	{
		get
		{
			return affinityLevelIcon_;
		}
		set
		{
			affinityLevelIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AffinityLevelRewardIcon
	{
		get
		{
			return affinityLevelRewardIcon_;
		}
		set
		{
			affinityLevelRewardIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AffinityLevelRewardLockIcon
	{
		get
		{
			return affinityLevelRewardLockIcon_;
		}
		set
		{
			affinityLevelRewardLockIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Effect => effect_;

	[DebuggerNonUserCode]
	public int AffinityLevelStage
	{
		get
		{
			return affinityLevelStage_;
		}
		set
		{
			affinityLevelStage_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsKeyAffinityLevel
	{
		get
		{
			return isKeyAffinityLevel_;
		}
		set
		{
			isKeyAffinityLevel_ = value;
		}
	}

	[DebuggerNonUserCode]
	public AffinityLevel()
	{
	}

	[DebuggerNonUserCode]
	public AffinityLevel(AffinityLevel other)
		: this()
	{
		id_ = other.id_;
		affinityLevel_ = other.affinityLevel_;
		needExp_ = other.needExp_;
		templateId_ = other.templateId_;
		affinityLevelName_ = other.affinityLevelName_;
		affinityLevelIcon_ = other.affinityLevelIcon_;
		affinityLevelRewardIcon_ = other.affinityLevelRewardIcon_;
		affinityLevelRewardLockIcon_ = other.affinityLevelRewardLockIcon_;
		effect_ = other.effect_.Clone();
		affinityLevelStage_ = other.affinityLevelStage_;
		isKeyAffinityLevel_ = other.isKeyAffinityLevel_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public AffinityLevel Clone()
	{
		return new AffinityLevel(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as AffinityLevel);
	}

	[DebuggerNonUserCode]
	public bool Equals(AffinityLevel other)
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
		if (AffinityLevel_ != other.AffinityLevel_)
		{
			return false;
		}
		if (NeedExp != other.NeedExp)
		{
			return false;
		}
		if (TemplateId != other.TemplateId)
		{
			return false;
		}
		if (AffinityLevelName != other.AffinityLevelName)
		{
			return false;
		}
		if (AffinityLevelIcon != other.AffinityLevelIcon)
		{
			return false;
		}
		if (AffinityLevelRewardIcon != other.AffinityLevelRewardIcon)
		{
			return false;
		}
		if (AffinityLevelRewardLockIcon != other.AffinityLevelRewardLockIcon)
		{
			return false;
		}
		if (!effect_.Equals(other.effect_))
		{
			return false;
		}
		if (AffinityLevelStage != other.AffinityLevelStage)
		{
			return false;
		}
		if (IsKeyAffinityLevel != other.IsKeyAffinityLevel)
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
		if (AffinityLevel_ != 0)
		{
			num ^= AffinityLevel_.GetHashCode();
		}
		if (NeedExp != 0)
		{
			num ^= NeedExp.GetHashCode();
		}
		if (TemplateId != 0)
		{
			num ^= TemplateId.GetHashCode();
		}
		if (AffinityLevelName.Length != 0)
		{
			num ^= AffinityLevelName.GetHashCode();
		}
		if (AffinityLevelIcon.Length != 0)
		{
			num ^= AffinityLevelIcon.GetHashCode();
		}
		if (AffinityLevelRewardIcon.Length != 0)
		{
			num ^= AffinityLevelRewardIcon.GetHashCode();
		}
		if (AffinityLevelRewardLockIcon.Length != 0)
		{
			num ^= AffinityLevelRewardLockIcon.GetHashCode();
		}
		num ^= effect_.GetHashCode();
		if (AffinityLevelStage != 0)
		{
			num ^= AffinityLevelStage.GetHashCode();
		}
		if (IsKeyAffinityLevel)
		{
			num ^= IsKeyAffinityLevel.GetHashCode();
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
		if (AffinityLevel_ != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(AffinityLevel_);
		}
		if (NeedExp != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(NeedExp);
		}
		if (TemplateId != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(TemplateId);
		}
		if (AffinityLevelName.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(AffinityLevelName);
		}
		if (AffinityLevelIcon.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(AffinityLevelIcon);
		}
		if (AffinityLevelRewardIcon.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(AffinityLevelRewardIcon);
		}
		if (AffinityLevelRewardLockIcon.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(AffinityLevelRewardLockIcon);
		}
		effect_.WriteTo(output, _repeated_effect_codec);
		if (AffinityLevelStage != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(AffinityLevelStage);
		}
		if (IsKeyAffinityLevel)
		{
			output.WriteRawTag(88);
			output.WriteBool(IsKeyAffinityLevel);
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
		if (AffinityLevel_ != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffinityLevel_);
		}
		if (NeedExp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NeedExp);
		}
		if (TemplateId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TemplateId);
		}
		if (AffinityLevelName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AffinityLevelName);
		}
		if (AffinityLevelIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AffinityLevelIcon);
		}
		if (AffinityLevelRewardIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AffinityLevelRewardIcon);
		}
		if (AffinityLevelRewardLockIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AffinityLevelRewardLockIcon);
		}
		num += effect_.CalculateSize(_repeated_effect_codec);
		if (AffinityLevelStage != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(AffinityLevelStage);
		}
		if (IsKeyAffinityLevel)
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
	public void MergeFrom(AffinityLevel other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.AffinityLevel_ != 0)
			{
				AffinityLevel_ = other.AffinityLevel_;
			}
			if (other.NeedExp != 0)
			{
				NeedExp = other.NeedExp;
			}
			if (other.TemplateId != 0)
			{
				TemplateId = other.TemplateId;
			}
			if (other.AffinityLevelName.Length != 0)
			{
				AffinityLevelName = other.AffinityLevelName;
			}
			if (other.AffinityLevelIcon.Length != 0)
			{
				AffinityLevelIcon = other.AffinityLevelIcon;
			}
			if (other.AffinityLevelRewardIcon.Length != 0)
			{
				AffinityLevelRewardIcon = other.AffinityLevelRewardIcon;
			}
			if (other.AffinityLevelRewardLockIcon.Length != 0)
			{
				AffinityLevelRewardLockIcon = other.AffinityLevelRewardLockIcon;
			}
			effect_.Add(other.effect_);
			if (other.AffinityLevelStage != 0)
			{
				AffinityLevelStage = other.AffinityLevelStage;
			}
			if (other.IsKeyAffinityLevel)
			{
				IsKeyAffinityLevel = other.IsKeyAffinityLevel;
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
				AffinityLevel_ = input.ReadInt32();
				break;
			case 24u:
				NeedExp = input.ReadInt32();
				break;
			case 32u:
				TemplateId = input.ReadInt32();
				break;
			case 42u:
				AffinityLevelName = input.ReadString();
				break;
			case 50u:
				AffinityLevelIcon = input.ReadString();
				break;
			case 58u:
				AffinityLevelRewardIcon = input.ReadString();
				break;
			case 66u:
				AffinityLevelRewardLockIcon = input.ReadString();
				break;
			case 72u:
			case 74u:
				effect_.AddEntriesFrom(input, _repeated_effect_codec);
				break;
			case 80u:
				AffinityLevelStage = input.ReadInt32();
				break;
			case 88u:
				IsKeyAffinityLevel = input.ReadBool();
				break;
			}
		}
	}
}
