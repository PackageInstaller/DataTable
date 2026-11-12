using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class GoldenSpySkill : IMessage<GoldenSpySkill>, IMessage, IEquatable<GoldenSpySkill>, IDeepCloneable<GoldenSpySkill>
{
	private static readonly MessageParser<GoldenSpySkill> _parser = new MessageParser<GoldenSpySkill>(() => new GoldenSpySkill());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IconFieldNumber = 2;

	private string icon_ = "";

	public const int SkillTypeFieldNumber = 3;

	private int skillType_;

	public const int ParamsFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_params_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> params_ = new RepeatedField<int>();

	[DebuggerNonUserCode]
	public static MessageParser<GoldenSpySkill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(408);

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
	public int SkillType
	{
		get
		{
			return skillType_;
		}
		set
		{
			skillType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Params => params_;

	[DebuggerNonUserCode]
	public GoldenSpySkill()
	{
	}

	[DebuggerNonUserCode]
	public GoldenSpySkill(GoldenSpySkill other)
		: this()
	{
		id_ = other.id_;
		icon_ = other.icon_;
		skillType_ = other.skillType_;
		params_ = other.params_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public GoldenSpySkill Clone()
	{
		return new GoldenSpySkill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as GoldenSpySkill);
	}

	[DebuggerNonUserCode]
	public bool Equals(GoldenSpySkill other)
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
		if (Icon != other.Icon)
		{
			return false;
		}
		if (SkillType != other.SkillType)
		{
			return false;
		}
		if (!params_.Equals(other.params_))
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
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (SkillType != 0)
		{
			num ^= SkillType.GetHashCode();
		}
		num ^= params_.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Icon);
		}
		if (SkillType != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(SkillType);
		}
		params_.WriteTo(output, _repeated_params_codec);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (SkillType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillType);
		}
		num += params_.CalculateSize(_repeated_params_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(GoldenSpySkill other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.SkillType != 0)
			{
				SkillType = other.SkillType;
			}
			params_.Add(other.params_);
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
				Icon = input.ReadString();
				break;
			case 24u:
				SkillType = input.ReadInt32();
				break;
			case 32u:
			case 34u:
				params_.AddEntriesFrom(input, _repeated_params_codec);
				break;
			}
		}
	}
}
