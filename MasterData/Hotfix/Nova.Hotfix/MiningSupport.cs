using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MiningSupport : IMessage<MiningSupport>, IMessage, IEquatable<MiningSupport>, IDeepCloneable<MiningSupport>
{
	private static readonly MessageParser<MiningSupport> _parser = new MessageParser<MiningSupport>(() => new MiningSupport());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int CharIconFieldNumber = 2;

	private string charIcon_ = "";

	public const int SkillNameFieldNumber = 3;

	private string skillName_ = "";

	public const int SkillDesFieldNumber = 4;

	private string skillDes_ = "";

	public const int SupportEffectFieldNumber = 5;

	private int supportEffect_;

	public const int SupportParamsFieldNumber = 6;

	private string supportParams_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MiningSupport> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(562);

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
	public string CharIcon
	{
		get
		{
			return charIcon_;
		}
		set
		{
			charIcon_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SkillName
	{
		get
		{
			return skillName_;
		}
		set
		{
			skillName_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string SkillDes
	{
		get
		{
			return skillDes_;
		}
		set
		{
			skillDes_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SupportEffect
	{
		get
		{
			return supportEffect_;
		}
		set
		{
			supportEffect_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string SupportParams
	{
		get
		{
			return supportParams_;
		}
		set
		{
			supportParams_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MiningSupport()
	{
	}

	[DebuggerNonUserCode]
	public MiningSupport(MiningSupport other)
		: this()
	{
		id_ = other.id_;
		charIcon_ = other.charIcon_;
		skillName_ = other.skillName_;
		skillDes_ = other.skillDes_;
		supportEffect_ = other.supportEffect_;
		supportParams_ = other.supportParams_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MiningSupport Clone()
	{
		return new MiningSupport(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MiningSupport);
	}

	[DebuggerNonUserCode]
	public bool Equals(MiningSupport other)
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
		if (CharIcon != other.CharIcon)
		{
			return false;
		}
		if (SkillName != other.SkillName)
		{
			return false;
		}
		if (SkillDes != other.SkillDes)
		{
			return false;
		}
		if (SupportEffect != other.SupportEffect)
		{
			return false;
		}
		if (SupportParams != other.SupportParams)
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
		if (CharIcon.Length != 0)
		{
			num ^= CharIcon.GetHashCode();
		}
		if (SkillName.Length != 0)
		{
			num ^= SkillName.GetHashCode();
		}
		if (SkillDes.Length != 0)
		{
			num ^= SkillDes.GetHashCode();
		}
		if (SupportEffect != 0)
		{
			num ^= SupportEffect.GetHashCode();
		}
		if (SupportParams.Length != 0)
		{
			num ^= SupportParams.GetHashCode();
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
		if (CharIcon.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(CharIcon);
		}
		if (SkillName.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(SkillName);
		}
		if (SkillDes.Length != 0)
		{
			output.WriteRawTag(34);
			output.WriteString(SkillDes);
		}
		if (SupportEffect != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(SupportEffect);
		}
		if (SupportParams.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(SupportParams);
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
		if (CharIcon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CharIcon);
		}
		if (SkillName.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SkillName);
		}
		if (SkillDes.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SkillDes);
		}
		if (SupportEffect != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SupportEffect);
		}
		if (SupportParams.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SupportParams);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MiningSupport other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.CharIcon.Length != 0)
			{
				CharIcon = other.CharIcon;
			}
			if (other.SkillName.Length != 0)
			{
				SkillName = other.SkillName;
			}
			if (other.SkillDes.Length != 0)
			{
				SkillDes = other.SkillDes;
			}
			if (other.SupportEffect != 0)
			{
				SupportEffect = other.SupportEffect;
			}
			if (other.SupportParams.Length != 0)
			{
				SupportParams = other.SupportParams;
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
				CharIcon = input.ReadString();
				break;
			case 26u:
				SkillName = input.ReadString();
				break;
			case 34u:
				SkillDes = input.ReadString();
				break;
			case 40u:
				SupportEffect = input.ReadInt32();
				break;
			case 50u:
				SupportParams = input.ReadString();
				break;
			}
		}
	}
}
