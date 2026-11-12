using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterManual : IMessage<MonsterManual>, IMessage, IEquatable<MonsterManual>, IDeepCloneable<MonsterManual>
{
	private static readonly MessageParser<MonsterManual> _parser = new MessageParser<MonsterManual>(() => new MonsterManual());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int IconFieldNumber = 2;

	private string icon_ = "";

	public const int NameFieldNumber = 3;

	private string name_ = "";

	public const int EETFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_eET_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> eET_ = new RepeatedField<int>();

	public const int WeakEETFieldNumber = 5;

	private static readonly FieldCodec<int> _repeated_weakEET_codec = FieldCodec.ForInt32(42u);

	private readonly RepeatedField<int> weakEET_ = new RepeatedField<int>();

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int SkillDescFieldNumber = 7;

	private string skillDesc_ = "";

	public const int EpicLvFieldNumber = 8;

	private int epicLv_;

	public const int HPFieldNumber = 9;

	private int hP_;

	public const int ATKFieldNumber = 10;

	private int aTK_;

	public const int DEFFieldNumber = 11;

	private int dEF_;

	public const int TOUGHNESSFieldNumber = 12;

	private int tOUGHNESS_;

	public const int AbilityTitle1FieldNumber = 13;

	private string abilityTitle1_ = "";

	public const int AbilityDesc1FieldNumber = 14;

	private string abilityDesc1_ = "";

	public const int AbilityTitle2FieldNumber = 15;

	private string abilityTitle2_ = "";

	public const int AbilityDesc2FieldNumber = 16;

	private string abilityDesc2_ = "";

	public const int AbilityTitle3FieldNumber = 17;

	private string abilityTitle3_ = "";

	public const int AbilityDesc3FieldNumber = 18;

	private string abilityDesc3_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<MonsterManual> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(580);

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
	public RepeatedField<int> EET => eET_;

	[DebuggerNonUserCode]
	public RepeatedField<int> WeakEET => weakEET_;

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
	public string SkillDesc
	{
		get
		{
			return skillDesc_;
		}
		set
		{
			skillDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int EpicLv
	{
		get
		{
			return epicLv_;
		}
		set
		{
			epicLv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HP
	{
		get
		{
			return hP_;
		}
		set
		{
			hP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ATK
	{
		get
		{
			return aTK_;
		}
		set
		{
			aTK_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DEF
	{
		get
		{
			return dEF_;
		}
		set
		{
			dEF_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TOUGHNESS
	{
		get
		{
			return tOUGHNESS_;
		}
		set
		{
			tOUGHNESS_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string AbilityTitle1
	{
		get
		{
			return abilityTitle1_;
		}
		set
		{
			abilityTitle1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AbilityDesc1
	{
		get
		{
			return abilityDesc1_;
		}
		set
		{
			abilityDesc1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AbilityTitle2
	{
		get
		{
			return abilityTitle2_;
		}
		set
		{
			abilityTitle2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AbilityDesc2
	{
		get
		{
			return abilityDesc2_;
		}
		set
		{
			abilityDesc2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AbilityTitle3
	{
		get
		{
			return abilityTitle3_;
		}
		set
		{
			abilityTitle3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AbilityDesc3
	{
		get
		{
			return abilityDesc3_;
		}
		set
		{
			abilityDesc3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public MonsterManual()
	{
	}

	[DebuggerNonUserCode]
	public MonsterManual(MonsterManual other)
		: this()
	{
		id_ = other.id_;
		icon_ = other.icon_;
		name_ = other.name_;
		eET_ = other.eET_.Clone();
		weakEET_ = other.weakEET_.Clone();
		desc_ = other.desc_;
		skillDesc_ = other.skillDesc_;
		epicLv_ = other.epicLv_;
		hP_ = other.hP_;
		aTK_ = other.aTK_;
		dEF_ = other.dEF_;
		tOUGHNESS_ = other.tOUGHNESS_;
		abilityTitle1_ = other.abilityTitle1_;
		abilityDesc1_ = other.abilityDesc1_;
		abilityTitle2_ = other.abilityTitle2_;
		abilityDesc2_ = other.abilityDesc2_;
		abilityTitle3_ = other.abilityTitle3_;
		abilityDesc3_ = other.abilityDesc3_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterManual Clone()
	{
		return new MonsterManual(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterManual);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterManual other)
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
		if (Name != other.Name)
		{
			return false;
		}
		if (!eET_.Equals(other.eET_))
		{
			return false;
		}
		if (!weakEET_.Equals(other.weakEET_))
		{
			return false;
		}
		if (Desc != other.Desc)
		{
			return false;
		}
		if (SkillDesc != other.SkillDesc)
		{
			return false;
		}
		if (EpicLv != other.EpicLv)
		{
			return false;
		}
		if (HP != other.HP)
		{
			return false;
		}
		if (ATK != other.ATK)
		{
			return false;
		}
		if (DEF != other.DEF)
		{
			return false;
		}
		if (TOUGHNESS != other.TOUGHNESS)
		{
			return false;
		}
		if (AbilityTitle1 != other.AbilityTitle1)
		{
			return false;
		}
		if (AbilityDesc1 != other.AbilityDesc1)
		{
			return false;
		}
		if (AbilityTitle2 != other.AbilityTitle2)
		{
			return false;
		}
		if (AbilityDesc2 != other.AbilityDesc2)
		{
			return false;
		}
		if (AbilityTitle3 != other.AbilityTitle3)
		{
			return false;
		}
		if (AbilityDesc3 != other.AbilityDesc3)
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
		if (Name.Length != 0)
		{
			num ^= Name.GetHashCode();
		}
		num ^= eET_.GetHashCode();
		num ^= weakEET_.GetHashCode();
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (SkillDesc.Length != 0)
		{
			num ^= SkillDesc.GetHashCode();
		}
		if (EpicLv != 0)
		{
			num ^= EpicLv.GetHashCode();
		}
		if (HP != 0)
		{
			num ^= HP.GetHashCode();
		}
		if (ATK != 0)
		{
			num ^= ATK.GetHashCode();
		}
		if (DEF != 0)
		{
			num ^= DEF.GetHashCode();
		}
		if (TOUGHNESS != 0)
		{
			num ^= TOUGHNESS.GetHashCode();
		}
		if (AbilityTitle1.Length != 0)
		{
			num ^= AbilityTitle1.GetHashCode();
		}
		if (AbilityDesc1.Length != 0)
		{
			num ^= AbilityDesc1.GetHashCode();
		}
		if (AbilityTitle2.Length != 0)
		{
			num ^= AbilityTitle2.GetHashCode();
		}
		if (AbilityDesc2.Length != 0)
		{
			num ^= AbilityDesc2.GetHashCode();
		}
		if (AbilityTitle3.Length != 0)
		{
			num ^= AbilityTitle3.GetHashCode();
		}
		if (AbilityDesc3.Length != 0)
		{
			num ^= AbilityDesc3.GetHashCode();
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
		if (Icon.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Icon);
		}
		if (Name.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(Name);
		}
		eET_.WriteTo(output, _repeated_eET_codec);
		weakEET_.WriteTo(output, _repeated_weakEET_codec);
		if (Desc.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(Desc);
		}
		if (SkillDesc.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(SkillDesc);
		}
		if (EpicLv != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(EpicLv);
		}
		if (HP != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(HP);
		}
		if (ATK != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(ATK);
		}
		if (DEF != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(DEF);
		}
		if (TOUGHNESS != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(TOUGHNESS);
		}
		if (AbilityTitle1.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(AbilityTitle1);
		}
		if (AbilityDesc1.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(AbilityDesc1);
		}
		if (AbilityTitle2.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(AbilityTitle2);
		}
		if (AbilityDesc2.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(AbilityDesc2);
		}
		if (AbilityTitle3.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(AbilityTitle3);
		}
		if (AbilityDesc3.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(AbilityDesc3);
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
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		num += eET_.CalculateSize(_repeated_eET_codec);
		num += weakEET_.CalculateSize(_repeated_weakEET_codec);
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (SkillDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(SkillDesc);
		}
		if (EpicLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EpicLv);
		}
		if (HP != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HP);
		}
		if (ATK != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ATK);
		}
		if (DEF != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(DEF);
		}
		if (TOUGHNESS != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TOUGHNESS);
		}
		if (AbilityTitle1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AbilityTitle1);
		}
		if (AbilityDesc1.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AbilityDesc1);
		}
		if (AbilityTitle2.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AbilityTitle2);
		}
		if (AbilityDesc2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AbilityDesc2);
		}
		if (AbilityTitle3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AbilityTitle3);
		}
		if (AbilityDesc3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AbilityDesc3);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterManual other)
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
			if (other.Name.Length != 0)
			{
				Name = other.Name;
			}
			eET_.Add(other.eET_);
			weakEET_.Add(other.weakEET_);
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.SkillDesc.Length != 0)
			{
				SkillDesc = other.SkillDesc;
			}
			if (other.EpicLv != 0)
			{
				EpicLv = other.EpicLv;
			}
			if (other.HP != 0)
			{
				HP = other.HP;
			}
			if (other.ATK != 0)
			{
				ATK = other.ATK;
			}
			if (other.DEF != 0)
			{
				DEF = other.DEF;
			}
			if (other.TOUGHNESS != 0)
			{
				TOUGHNESS = other.TOUGHNESS;
			}
			if (other.AbilityTitle1.Length != 0)
			{
				AbilityTitle1 = other.AbilityTitle1;
			}
			if (other.AbilityDesc1.Length != 0)
			{
				AbilityDesc1 = other.AbilityDesc1;
			}
			if (other.AbilityTitle2.Length != 0)
			{
				AbilityTitle2 = other.AbilityTitle2;
			}
			if (other.AbilityDesc2.Length != 0)
			{
				AbilityDesc2 = other.AbilityDesc2;
			}
			if (other.AbilityTitle3.Length != 0)
			{
				AbilityTitle3 = other.AbilityTitle3;
			}
			if (other.AbilityDesc3.Length != 0)
			{
				AbilityDesc3 = other.AbilityDesc3;
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
				Icon = input.ReadString();
				break;
			case 26u:
				Name = input.ReadString();
				break;
			case 32u:
			case 34u:
				eET_.AddEntriesFrom(input, _repeated_eET_codec);
				break;
			case 40u:
			case 42u:
				weakEET_.AddEntriesFrom(input, _repeated_weakEET_codec);
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 58u:
				SkillDesc = input.ReadString();
				break;
			case 64u:
				EpicLv = input.ReadInt32();
				break;
			case 72u:
				HP = input.ReadInt32();
				break;
			case 80u:
				ATK = input.ReadInt32();
				break;
			case 88u:
				DEF = input.ReadInt32();
				break;
			case 96u:
				TOUGHNESS = input.ReadInt32();
				break;
			case 106u:
				AbilityTitle1 = input.ReadString();
				break;
			case 114u:
				AbilityDesc1 = input.ReadString();
				break;
			case 122u:
				AbilityTitle2 = input.ReadString();
				break;
			case 130u:
				AbilityDesc2 = input.ReadString();
				break;
			case 138u:
				AbilityTitle3 = input.ReadString();
				break;
			case 146u:
				AbilityDesc3 = input.ReadString();
				break;
			}
		}
	}
}
