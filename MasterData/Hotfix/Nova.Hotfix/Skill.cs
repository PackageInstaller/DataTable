using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class Skill : IMessage<Skill>, IMessage, IEquatable<Skill>, IDeepCloneable<Skill>
{
	private static readonly MessageParser<Skill> _parser = new MessageParser<Skill>(() => new Skill());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int TitleFieldNumber = 2;

	private string title_ = "";

	public const int FCPathFieldNumber = 3;

	private string fCPath_ = "";

	public const int TypeFieldNumber = 4;

	private int type_;

	public const int BriefDescFieldNumber = 5;

	private string briefDesc_ = "";

	public const int DescFieldNumber = 6;

	private string desc_ = "";

	public const int IconFieldNumber = 7;

	private string icon_ = "";

	public const int SkillCDFieldNumber = 8;

	private int skillCD_;

	public const int MaxLevelFieldNumber = 9;

	private int maxLevel_;

	public const int RelatedSkillFieldNumber = 10;

	private string relatedSkill_ = "";

	public const int SectionAmountFieldNumber = 11;

	private int sectionAmount_;

	public const int UseIntervalFieldNumber = 12;

	private int useInterval_;

	public const int UseTimeHintFieldNumber = 13;

	private int useTimeHint_;

	public const int UltraEnergyFieldNumber = 14;

	private int ultraEnergy_;

	public const int CheckCDRestoreFieldNumber = 15;

	private bool checkCDRestore_;

	public const int ForceRunFinishFieldNumber = 16;

	private bool forceRunFinish_;

	public const int GetEnergyLimitFieldNumber = 17;

	private int getEnergyLimit_;

	public const int Param1FieldNumber = 18;

	private string param1_ = "";

	public const int Param2FieldNumber = 19;

	private string param2_ = "";

	public const int Param3FieldNumber = 20;

	private string param3_ = "";

	public const int Param4FieldNumber = 21;

	private string param4_ = "";

	public const int Param5FieldNumber = 22;

	private string param5_ = "";

	public const int Param6FieldNumber = 23;

	private string param6_ = "";

	public const int Param7FieldNumber = 24;

	private string param7_ = "";

	public const int Param8FieldNumber = 25;

	private string param8_ = "";

	public const int Param9FieldNumber = 26;

	private string param9_ = "";

	public const int Param10FieldNumber = 27;

	private string param10_ = "";

	public const int IsCleanSkillCDFieldNumber = 28;

	private bool isCleanSkillCD_;

	public const int CheckSkillIntervalFieldNumber = 29;

	private bool checkSkillInterval_;

	public const int IconExFieldNumber = 30;

	private static readonly FieldCodec<string> _repeated_iconEx_codec = FieldCodec.ForString(242u);

	private readonly RepeatedField<string> iconEx_ = new RepeatedField<string>();

	[DebuggerNonUserCode]
	public static MessageParser<Skill> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(720);

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
	public string FCPath
	{
		get
		{
			return fCPath_;
		}
		set
		{
			fCPath_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int Type
	{
		get
		{
			return type_;
		}
		set
		{
			type_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string BriefDesc
	{
		get
		{
			return briefDesc_;
		}
		set
		{
			briefDesc_ = ProtoPreconditions.CheckNotNull(value, "value");
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
	public int SkillCD
	{
		get
		{
			return skillCD_;
		}
		set
		{
			skillCD_ = value;
		}
	}

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
	public string RelatedSkill
	{
		get
		{
			return relatedSkill_;
		}
		set
		{
			relatedSkill_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int SectionAmount
	{
		get
		{
			return sectionAmount_;
		}
		set
		{
			sectionAmount_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UseInterval
	{
		get
		{
			return useInterval_;
		}
		set
		{
			useInterval_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UseTimeHint
	{
		get
		{
			return useTimeHint_;
		}
		set
		{
			useTimeHint_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UltraEnergy
	{
		get
		{
			return ultraEnergy_;
		}
		set
		{
			ultraEnergy_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CheckCDRestore
	{
		get
		{
			return checkCDRestore_;
		}
		set
		{
			checkCDRestore_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool ForceRunFinish
	{
		get
		{
			return forceRunFinish_;
		}
		set
		{
			forceRunFinish_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GetEnergyLimit
	{
		get
		{
			return getEnergyLimit_;
		}
		set
		{
			getEnergyLimit_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Param1
	{
		get
		{
			return param1_;
		}
		set
		{
			param1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param2
	{
		get
		{
			return param2_;
		}
		set
		{
			param2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param3
	{
		get
		{
			return param3_;
		}
		set
		{
			param3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param4
	{
		get
		{
			return param4_;
		}
		set
		{
			param4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param5
	{
		get
		{
			return param5_;
		}
		set
		{
			param5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param6
	{
		get
		{
			return param6_;
		}
		set
		{
			param6_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param7
	{
		get
		{
			return param7_;
		}
		set
		{
			param7_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param8
	{
		get
		{
			return param8_;
		}
		set
		{
			param8_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param9
	{
		get
		{
			return param9_;
		}
		set
		{
			param9_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Param10
	{
		get
		{
			return param10_;
		}
		set
		{
			param10_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public bool IsCleanSkillCD
	{
		get
		{
			return isCleanSkillCD_;
		}
		set
		{
			isCleanSkillCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool CheckSkillInterval
	{
		get
		{
			return checkSkillInterval_;
		}
		set
		{
			checkSkillInterval_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<string> IconEx => iconEx_;

	[DebuggerNonUserCode]
	public Skill()
	{
	}

	[DebuggerNonUserCode]
	public Skill(Skill other)
		: this()
	{
		id_ = other.id_;
		title_ = other.title_;
		fCPath_ = other.fCPath_;
		type_ = other.type_;
		briefDesc_ = other.briefDesc_;
		desc_ = other.desc_;
		icon_ = other.icon_;
		skillCD_ = other.skillCD_;
		maxLevel_ = other.maxLevel_;
		relatedSkill_ = other.relatedSkill_;
		sectionAmount_ = other.sectionAmount_;
		useInterval_ = other.useInterval_;
		useTimeHint_ = other.useTimeHint_;
		ultraEnergy_ = other.ultraEnergy_;
		checkCDRestore_ = other.checkCDRestore_;
		forceRunFinish_ = other.forceRunFinish_;
		getEnergyLimit_ = other.getEnergyLimit_;
		param1_ = other.param1_;
		param2_ = other.param2_;
		param3_ = other.param3_;
		param4_ = other.param4_;
		param5_ = other.param5_;
		param6_ = other.param6_;
		param7_ = other.param7_;
		param8_ = other.param8_;
		param9_ = other.param9_;
		param10_ = other.param10_;
		isCleanSkillCD_ = other.isCleanSkillCD_;
		checkSkillInterval_ = other.checkSkillInterval_;
		iconEx_ = other.iconEx_.Clone();
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public Skill Clone()
	{
		return new Skill(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as Skill);
	}

	[DebuggerNonUserCode]
	public bool Equals(Skill other)
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
		if (FCPath != other.FCPath)
		{
			return false;
		}
		if (Type != other.Type)
		{
			return false;
		}
		if (BriefDesc != other.BriefDesc)
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
		if (SkillCD != other.SkillCD)
		{
			return false;
		}
		if (MaxLevel != other.MaxLevel)
		{
			return false;
		}
		if (RelatedSkill != other.RelatedSkill)
		{
			return false;
		}
		if (SectionAmount != other.SectionAmount)
		{
			return false;
		}
		if (UseInterval != other.UseInterval)
		{
			return false;
		}
		if (UseTimeHint != other.UseTimeHint)
		{
			return false;
		}
		if (UltraEnergy != other.UltraEnergy)
		{
			return false;
		}
		if (CheckCDRestore != other.CheckCDRestore)
		{
			return false;
		}
		if (ForceRunFinish != other.ForceRunFinish)
		{
			return false;
		}
		if (GetEnergyLimit != other.GetEnergyLimit)
		{
			return false;
		}
		if (Param1 != other.Param1)
		{
			return false;
		}
		if (Param2 != other.Param2)
		{
			return false;
		}
		if (Param3 != other.Param3)
		{
			return false;
		}
		if (Param4 != other.Param4)
		{
			return false;
		}
		if (Param5 != other.Param5)
		{
			return false;
		}
		if (Param6 != other.Param6)
		{
			return false;
		}
		if (Param7 != other.Param7)
		{
			return false;
		}
		if (Param8 != other.Param8)
		{
			return false;
		}
		if (Param9 != other.Param9)
		{
			return false;
		}
		if (Param10 != other.Param10)
		{
			return false;
		}
		if (IsCleanSkillCD != other.IsCleanSkillCD)
		{
			return false;
		}
		if (CheckSkillInterval != other.CheckSkillInterval)
		{
			return false;
		}
		if (!iconEx_.Equals(other.iconEx_))
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
		if (FCPath.Length != 0)
		{
			num ^= FCPath.GetHashCode();
		}
		if (Type != 0)
		{
			num ^= Type.GetHashCode();
		}
		if (BriefDesc.Length != 0)
		{
			num ^= BriefDesc.GetHashCode();
		}
		if (Desc.Length != 0)
		{
			num ^= Desc.GetHashCode();
		}
		if (Icon.Length != 0)
		{
			num ^= Icon.GetHashCode();
		}
		if (SkillCD != 0)
		{
			num ^= SkillCD.GetHashCode();
		}
		if (MaxLevel != 0)
		{
			num ^= MaxLevel.GetHashCode();
		}
		if (RelatedSkill.Length != 0)
		{
			num ^= RelatedSkill.GetHashCode();
		}
		if (SectionAmount != 0)
		{
			num ^= SectionAmount.GetHashCode();
		}
		if (UseInterval != 0)
		{
			num ^= UseInterval.GetHashCode();
		}
		if (UseTimeHint != 0)
		{
			num ^= UseTimeHint.GetHashCode();
		}
		if (UltraEnergy != 0)
		{
			num ^= UltraEnergy.GetHashCode();
		}
		if (CheckCDRestore)
		{
			num ^= CheckCDRestore.GetHashCode();
		}
		if (ForceRunFinish)
		{
			num ^= ForceRunFinish.GetHashCode();
		}
		if (GetEnergyLimit != 0)
		{
			num ^= GetEnergyLimit.GetHashCode();
		}
		if (Param1.Length != 0)
		{
			num ^= Param1.GetHashCode();
		}
		if (Param2.Length != 0)
		{
			num ^= Param2.GetHashCode();
		}
		if (Param3.Length != 0)
		{
			num ^= Param3.GetHashCode();
		}
		if (Param4.Length != 0)
		{
			num ^= Param4.GetHashCode();
		}
		if (Param5.Length != 0)
		{
			num ^= Param5.GetHashCode();
		}
		if (Param6.Length != 0)
		{
			num ^= Param6.GetHashCode();
		}
		if (Param7.Length != 0)
		{
			num ^= Param7.GetHashCode();
		}
		if (Param8.Length != 0)
		{
			num ^= Param8.GetHashCode();
		}
		if (Param9.Length != 0)
		{
			num ^= Param9.GetHashCode();
		}
		if (Param10.Length != 0)
		{
			num ^= Param10.GetHashCode();
		}
		if (IsCleanSkillCD)
		{
			num ^= IsCleanSkillCD.GetHashCode();
		}
		if (CheckSkillInterval)
		{
			num ^= CheckSkillInterval.GetHashCode();
		}
		num ^= iconEx_.GetHashCode();
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
		if (FCPath.Length != 0)
		{
			output.WriteRawTag(26);
			output.WriteString(FCPath);
		}
		if (Type != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Type);
		}
		if (BriefDesc.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(BriefDesc);
		}
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
		if (SkillCD != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(SkillCD);
		}
		if (MaxLevel != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(MaxLevel);
		}
		if (RelatedSkill.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(RelatedSkill);
		}
		if (SectionAmount != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(SectionAmount);
		}
		if (UseInterval != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(UseInterval);
		}
		if (UseTimeHint != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(UseTimeHint);
		}
		if (UltraEnergy != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(UltraEnergy);
		}
		if (CheckCDRestore)
		{
			output.WriteRawTag(120);
			output.WriteBool(CheckCDRestore);
		}
		if (ForceRunFinish)
		{
			output.WriteRawTag(128, 1);
			output.WriteBool(ForceRunFinish);
		}
		if (GetEnergyLimit != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(GetEnergyLimit);
		}
		if (Param1.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(Param1);
		}
		if (Param2.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(Param2);
		}
		if (Param3.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Param3);
		}
		if (Param4.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(Param4);
		}
		if (Param5.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(Param5);
		}
		if (Param6.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(Param6);
		}
		if (Param7.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(Param7);
		}
		if (Param8.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(Param8);
		}
		if (Param9.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(Param9);
		}
		if (Param10.Length != 0)
		{
			output.WriteRawTag(218, 1);
			output.WriteString(Param10);
		}
		if (IsCleanSkillCD)
		{
			output.WriteRawTag(224, 1);
			output.WriteBool(IsCleanSkillCD);
		}
		if (CheckSkillInterval)
		{
			output.WriteRawTag(232, 1);
			output.WriteBool(CheckSkillInterval);
		}
		iconEx_.WriteTo(output, _repeated_iconEx_codec);
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
		if (FCPath.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(FCPath);
		}
		if (Type != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Type);
		}
		if (BriefDesc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BriefDesc);
		}
		if (Desc.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Desc);
		}
		if (Icon.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Icon);
		}
		if (SkillCD != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillCD);
		}
		if (MaxLevel != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MaxLevel);
		}
		if (RelatedSkill.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(RelatedSkill);
		}
		if (SectionAmount != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SectionAmount);
		}
		if (UseInterval != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseInterval);
		}
		if (UseTimeHint != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UseTimeHint);
		}
		if (UltraEnergy != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UltraEnergy);
		}
		if (CheckCDRestore)
		{
			num += 2;
		}
		if (ForceRunFinish)
		{
			num += 3;
		}
		if (GetEnergyLimit != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GetEnergyLimit);
		}
		if (Param1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param1);
		}
		if (Param2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param2);
		}
		if (Param3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param3);
		}
		if (Param4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param4);
		}
		if (Param5.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param5);
		}
		if (Param6.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param6);
		}
		if (Param7.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param7);
		}
		if (Param8.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param8);
		}
		if (Param9.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param9);
		}
		if (Param10.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Param10);
		}
		if (IsCleanSkillCD)
		{
			num += 3;
		}
		if (CheckSkillInterval)
		{
			num += 3;
		}
		num += iconEx_.CalculateSize(_repeated_iconEx_codec);
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(Skill other)
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
			if (other.FCPath.Length != 0)
			{
				FCPath = other.FCPath;
			}
			if (other.Type != 0)
			{
				Type = other.Type;
			}
			if (other.BriefDesc.Length != 0)
			{
				BriefDesc = other.BriefDesc;
			}
			if (other.Desc.Length != 0)
			{
				Desc = other.Desc;
			}
			if (other.Icon.Length != 0)
			{
				Icon = other.Icon;
			}
			if (other.SkillCD != 0)
			{
				SkillCD = other.SkillCD;
			}
			if (other.MaxLevel != 0)
			{
				MaxLevel = other.MaxLevel;
			}
			if (other.RelatedSkill.Length != 0)
			{
				RelatedSkill = other.RelatedSkill;
			}
			if (other.SectionAmount != 0)
			{
				SectionAmount = other.SectionAmount;
			}
			if (other.UseInterval != 0)
			{
				UseInterval = other.UseInterval;
			}
			if (other.UseTimeHint != 0)
			{
				UseTimeHint = other.UseTimeHint;
			}
			if (other.UltraEnergy != 0)
			{
				UltraEnergy = other.UltraEnergy;
			}
			if (other.CheckCDRestore)
			{
				CheckCDRestore = other.CheckCDRestore;
			}
			if (other.ForceRunFinish)
			{
				ForceRunFinish = other.ForceRunFinish;
			}
			if (other.GetEnergyLimit != 0)
			{
				GetEnergyLimit = other.GetEnergyLimit;
			}
			if (other.Param1.Length != 0)
			{
				Param1 = other.Param1;
			}
			if (other.Param2.Length != 0)
			{
				Param2 = other.Param2;
			}
			if (other.Param3.Length != 0)
			{
				Param3 = other.Param3;
			}
			if (other.Param4.Length != 0)
			{
				Param4 = other.Param4;
			}
			if (other.Param5.Length != 0)
			{
				Param5 = other.Param5;
			}
			if (other.Param6.Length != 0)
			{
				Param6 = other.Param6;
			}
			if (other.Param7.Length != 0)
			{
				Param7 = other.Param7;
			}
			if (other.Param8.Length != 0)
			{
				Param8 = other.Param8;
			}
			if (other.Param9.Length != 0)
			{
				Param9 = other.Param9;
			}
			if (other.Param10.Length != 0)
			{
				Param10 = other.Param10;
			}
			if (other.IsCleanSkillCD)
			{
				IsCleanSkillCD = other.IsCleanSkillCD;
			}
			if (other.CheckSkillInterval)
			{
				CheckSkillInterval = other.CheckSkillInterval;
			}
			iconEx_.Add(other.iconEx_);
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
				FCPath = input.ReadString();
				break;
			case 32u:
				Type = input.ReadInt32();
				break;
			case 42u:
				BriefDesc = input.ReadString();
				break;
			case 50u:
				Desc = input.ReadString();
				break;
			case 58u:
				Icon = input.ReadString();
				break;
			case 64u:
				SkillCD = input.ReadInt32();
				break;
			case 72u:
				MaxLevel = input.ReadInt32();
				break;
			case 82u:
				RelatedSkill = input.ReadString();
				break;
			case 88u:
				SectionAmount = input.ReadInt32();
				break;
			case 96u:
				UseInterval = input.ReadInt32();
				break;
			case 104u:
				UseTimeHint = input.ReadInt32();
				break;
			case 112u:
				UltraEnergy = input.ReadInt32();
				break;
			case 120u:
				CheckCDRestore = input.ReadBool();
				break;
			case 128u:
				ForceRunFinish = input.ReadBool();
				break;
			case 136u:
				GetEnergyLimit = input.ReadInt32();
				break;
			case 146u:
				Param1 = input.ReadString();
				break;
			case 154u:
				Param2 = input.ReadString();
				break;
			case 162u:
				Param3 = input.ReadString();
				break;
			case 170u:
				Param4 = input.ReadString();
				break;
			case 178u:
				Param5 = input.ReadString();
				break;
			case 186u:
				Param6 = input.ReadString();
				break;
			case 194u:
				Param7 = input.ReadString();
				break;
			case 202u:
				Param8 = input.ReadString();
				break;
			case 210u:
				Param9 = input.ReadString();
				break;
			case 218u:
				Param10 = input.ReadString();
				break;
			case 224u:
				IsCleanSkillCD = input.ReadBool();
				break;
			case 232u:
				CheckSkillInterval = input.ReadBool();
				break;
			case 242u:
				iconEx_.AddEntriesFrom(input, _repeated_iconEx_codec);
				break;
			}
		}
	}
}
