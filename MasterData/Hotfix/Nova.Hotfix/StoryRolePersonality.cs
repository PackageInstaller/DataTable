using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class StoryRolePersonality : IMessage<StoryRolePersonality>, IMessage, IEquatable<StoryRolePersonality>, IDeepCloneable<StoryRolePersonality>
{
	private static readonly MessageParser<StoryRolePersonality> _parser = new MessageParser<StoryRolePersonality>(() => new StoryRolePersonality());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int AvgCharIdFieldNumber = 2;

	private string avgCharId_ = "";

	public const int PersonalitysFieldNumber = 3;

	private static readonly FieldCodec<int> _repeated_personalitys_codec = FieldCodec.ForInt32(26u);

	private readonly RepeatedField<int> personalitys_ = new RepeatedField<int>();

	public const int BaseValueFieldNumber = 4;

	private static readonly FieldCodec<int> _repeated_baseValue_codec = FieldCodec.ForInt32(34u);

	private readonly RepeatedField<int> baseValue_ = new RepeatedField<int>();

	public const int AmaxFieldNumber = 5;

	private string amax_ = "";

	public const int AmaxFaceFieldNumber = 6;

	private string amaxFace_ = "";

	public const int AmaxHeadFieldNumber = 7;

	private string amaxHead_ = "";

	public const int BmaxFieldNumber = 8;

	private string bmax_ = "";

	public const int BmaxFaceFieldNumber = 9;

	private string bmaxFace_ = "";

	public const int BmaxHeadFieldNumber = 10;

	private string bmaxHead_ = "";

	public const int CmaxFieldNumber = 11;

	private string cmax_ = "";

	public const int CmaxFaceFieldNumber = 12;

	private string cmaxFace_ = "";

	public const int CmaxHeadFieldNumber = 13;

	private string cmaxHead_ = "";

	public const int AplusFieldNumber = 14;

	private string aplus_ = "";

	public const int AplusFaceFieldNumber = 15;

	private string aplusFace_ = "";

	public const int AplusHeadFieldNumber = 16;

	private string aplusHead_ = "";

	public const int BplusFieldNumber = 17;

	private string bplus_ = "";

	public const int BplusFaceFieldNumber = 18;

	private string bplusFace_ = "";

	public const int BplusHeadFieldNumber = 19;

	private string bplusHead_ = "";

	public const int CplusFieldNumber = 20;

	private string cplus_ = "";

	public const int CplusFaceFieldNumber = 21;

	private string cplusFace_ = "";

	public const int CplusHeadFieldNumber = 22;

	private string cplusHead_ = "";

	public const int AbcFieldNumber = 23;

	private string abc_ = "";

	public const int AbcFaceFieldNumber = 24;

	private string abcFace_ = "";

	public const int AbcHeadFieldNumber = 25;

	private string abcHead_ = "";

	public const int BacFieldNumber = 26;

	private string bac_ = "";

	public const int BacFaceFieldNumber = 27;

	private string bacFace_ = "";

	public const int BacHeadFieldNumber = 28;

	private string bacHead_ = "";

	public const int CabFieldNumber = 29;

	private string cab_ = "";

	public const int CabFaceFieldNumber = 30;

	private string cabFace_ = "";

	public const int CabHeadFieldNumber = 31;

	private string cabHead_ = "";

	public const int NormalFieldNumber = 32;

	private string normal_ = "";

	public const int NormalFaceFieldNumber = 33;

	private string normalFace_ = "";

	public const int NormalHeadFieldNumber = 34;

	private string normalHead_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<StoryRolePersonality> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(902);

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
	public string AvgCharId
	{
		get
		{
			return avgCharId_;
		}
		set
		{
			avgCharId_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> Personalitys => personalitys_;

	[DebuggerNonUserCode]
	public RepeatedField<int> BaseValue => baseValue_;

	[DebuggerNonUserCode]
	public string Amax
	{
		get
		{
			return amax_;
		}
		set
		{
			amax_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AmaxFace
	{
		get
		{
			return amaxFace_;
		}
		set
		{
			amaxFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AmaxHead
	{
		get
		{
			return amaxHead_;
		}
		set
		{
			amaxHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Bmax
	{
		get
		{
			return bmax_;
		}
		set
		{
			bmax_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BmaxFace
	{
		get
		{
			return bmaxFace_;
		}
		set
		{
			bmaxFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BmaxHead
	{
		get
		{
			return bmaxHead_;
		}
		set
		{
			bmaxHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Cmax
	{
		get
		{
			return cmax_;
		}
		set
		{
			cmax_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CmaxFace
	{
		get
		{
			return cmaxFace_;
		}
		set
		{
			cmaxFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CmaxHead
	{
		get
		{
			return cmaxHead_;
		}
		set
		{
			cmaxHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Aplus
	{
		get
		{
			return aplus_;
		}
		set
		{
			aplus_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AplusFace
	{
		get
		{
			return aplusFace_;
		}
		set
		{
			aplusFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AplusHead
	{
		get
		{
			return aplusHead_;
		}
		set
		{
			aplusHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Bplus
	{
		get
		{
			return bplus_;
		}
		set
		{
			bplus_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BplusFace
	{
		get
		{
			return bplusFace_;
		}
		set
		{
			bplusFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BplusHead
	{
		get
		{
			return bplusHead_;
		}
		set
		{
			bplusHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Cplus
	{
		get
		{
			return cplus_;
		}
		set
		{
			cplus_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CplusFace
	{
		get
		{
			return cplusFace_;
		}
		set
		{
			cplusFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CplusHead
	{
		get
		{
			return cplusHead_;
		}
		set
		{
			cplusHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Abc
	{
		get
		{
			return abc_;
		}
		set
		{
			abc_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AbcFace
	{
		get
		{
			return abcFace_;
		}
		set
		{
			abcFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string AbcHead
	{
		get
		{
			return abcHead_;
		}
		set
		{
			abcHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Bac
	{
		get
		{
			return bac_;
		}
		set
		{
			bac_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BacFace
	{
		get
		{
			return bacFace_;
		}
		set
		{
			bacFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string BacHead
	{
		get
		{
			return bacHead_;
		}
		set
		{
			bacHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Cab
	{
		get
		{
			return cab_;
		}
		set
		{
			cab_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CabFace
	{
		get
		{
			return cabFace_;
		}
		set
		{
			cabFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string CabHead
	{
		get
		{
			return cabHead_;
		}
		set
		{
			cabHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Normal
	{
		get
		{
			return normal_;
		}
		set
		{
			normal_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string NormalFace
	{
		get
		{
			return normalFace_;
		}
		set
		{
			normalFace_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string NormalHead
	{
		get
		{
			return normalHead_;
		}
		set
		{
			normalHead_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public StoryRolePersonality()
	{
	}

	[DebuggerNonUserCode]
	public StoryRolePersonality(StoryRolePersonality other)
		: this()
	{
		id_ = other.id_;
		avgCharId_ = other.avgCharId_;
		personalitys_ = other.personalitys_.Clone();
		baseValue_ = other.baseValue_.Clone();
		amax_ = other.amax_;
		amaxFace_ = other.amaxFace_;
		amaxHead_ = other.amaxHead_;
		bmax_ = other.bmax_;
		bmaxFace_ = other.bmaxFace_;
		bmaxHead_ = other.bmaxHead_;
		cmax_ = other.cmax_;
		cmaxFace_ = other.cmaxFace_;
		cmaxHead_ = other.cmaxHead_;
		aplus_ = other.aplus_;
		aplusFace_ = other.aplusFace_;
		aplusHead_ = other.aplusHead_;
		bplus_ = other.bplus_;
		bplusFace_ = other.bplusFace_;
		bplusHead_ = other.bplusHead_;
		cplus_ = other.cplus_;
		cplusFace_ = other.cplusFace_;
		cplusHead_ = other.cplusHead_;
		abc_ = other.abc_;
		abcFace_ = other.abcFace_;
		abcHead_ = other.abcHead_;
		bac_ = other.bac_;
		bacFace_ = other.bacFace_;
		bacHead_ = other.bacHead_;
		cab_ = other.cab_;
		cabFace_ = other.cabFace_;
		cabHead_ = other.cabHead_;
		normal_ = other.normal_;
		normalFace_ = other.normalFace_;
		normalHead_ = other.normalHead_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public StoryRolePersonality Clone()
	{
		return new StoryRolePersonality(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as StoryRolePersonality);
	}

	[DebuggerNonUserCode]
	public bool Equals(StoryRolePersonality other)
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
		if (AvgCharId != other.AvgCharId)
		{
			return false;
		}
		if (!personalitys_.Equals(other.personalitys_))
		{
			return false;
		}
		if (!baseValue_.Equals(other.baseValue_))
		{
			return false;
		}
		if (Amax != other.Amax)
		{
			return false;
		}
		if (AmaxFace != other.AmaxFace)
		{
			return false;
		}
		if (AmaxHead != other.AmaxHead)
		{
			return false;
		}
		if (Bmax != other.Bmax)
		{
			return false;
		}
		if (BmaxFace != other.BmaxFace)
		{
			return false;
		}
		if (BmaxHead != other.BmaxHead)
		{
			return false;
		}
		if (Cmax != other.Cmax)
		{
			return false;
		}
		if (CmaxFace != other.CmaxFace)
		{
			return false;
		}
		if (CmaxHead != other.CmaxHead)
		{
			return false;
		}
		if (Aplus != other.Aplus)
		{
			return false;
		}
		if (AplusFace != other.AplusFace)
		{
			return false;
		}
		if (AplusHead != other.AplusHead)
		{
			return false;
		}
		if (Bplus != other.Bplus)
		{
			return false;
		}
		if (BplusFace != other.BplusFace)
		{
			return false;
		}
		if (BplusHead != other.BplusHead)
		{
			return false;
		}
		if (Cplus != other.Cplus)
		{
			return false;
		}
		if (CplusFace != other.CplusFace)
		{
			return false;
		}
		if (CplusHead != other.CplusHead)
		{
			return false;
		}
		if (Abc != other.Abc)
		{
			return false;
		}
		if (AbcFace != other.AbcFace)
		{
			return false;
		}
		if (AbcHead != other.AbcHead)
		{
			return false;
		}
		if (Bac != other.Bac)
		{
			return false;
		}
		if (BacFace != other.BacFace)
		{
			return false;
		}
		if (BacHead != other.BacHead)
		{
			return false;
		}
		if (Cab != other.Cab)
		{
			return false;
		}
		if (CabFace != other.CabFace)
		{
			return false;
		}
		if (CabHead != other.CabHead)
		{
			return false;
		}
		if (Normal != other.Normal)
		{
			return false;
		}
		if (NormalFace != other.NormalFace)
		{
			return false;
		}
		if (NormalHead != other.NormalHead)
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
		if (AvgCharId.Length != 0)
		{
			num ^= AvgCharId.GetHashCode();
		}
		num ^= personalitys_.GetHashCode();
		num ^= baseValue_.GetHashCode();
		if (Amax.Length != 0)
		{
			num ^= Amax.GetHashCode();
		}
		if (AmaxFace.Length != 0)
		{
			num ^= AmaxFace.GetHashCode();
		}
		if (AmaxHead.Length != 0)
		{
			num ^= AmaxHead.GetHashCode();
		}
		if (Bmax.Length != 0)
		{
			num ^= Bmax.GetHashCode();
		}
		if (BmaxFace.Length != 0)
		{
			num ^= BmaxFace.GetHashCode();
		}
		if (BmaxHead.Length != 0)
		{
			num ^= BmaxHead.GetHashCode();
		}
		if (Cmax.Length != 0)
		{
			num ^= Cmax.GetHashCode();
		}
		if (CmaxFace.Length != 0)
		{
			num ^= CmaxFace.GetHashCode();
		}
		if (CmaxHead.Length != 0)
		{
			num ^= CmaxHead.GetHashCode();
		}
		if (Aplus.Length != 0)
		{
			num ^= Aplus.GetHashCode();
		}
		if (AplusFace.Length != 0)
		{
			num ^= AplusFace.GetHashCode();
		}
		if (AplusHead.Length != 0)
		{
			num ^= AplusHead.GetHashCode();
		}
		if (Bplus.Length != 0)
		{
			num ^= Bplus.GetHashCode();
		}
		if (BplusFace.Length != 0)
		{
			num ^= BplusFace.GetHashCode();
		}
		if (BplusHead.Length != 0)
		{
			num ^= BplusHead.GetHashCode();
		}
		if (Cplus.Length != 0)
		{
			num ^= Cplus.GetHashCode();
		}
		if (CplusFace.Length != 0)
		{
			num ^= CplusFace.GetHashCode();
		}
		if (CplusHead.Length != 0)
		{
			num ^= CplusHead.GetHashCode();
		}
		if (Abc.Length != 0)
		{
			num ^= Abc.GetHashCode();
		}
		if (AbcFace.Length != 0)
		{
			num ^= AbcFace.GetHashCode();
		}
		if (AbcHead.Length != 0)
		{
			num ^= AbcHead.GetHashCode();
		}
		if (Bac.Length != 0)
		{
			num ^= Bac.GetHashCode();
		}
		if (BacFace.Length != 0)
		{
			num ^= BacFace.GetHashCode();
		}
		if (BacHead.Length != 0)
		{
			num ^= BacHead.GetHashCode();
		}
		if (Cab.Length != 0)
		{
			num ^= Cab.GetHashCode();
		}
		if (CabFace.Length != 0)
		{
			num ^= CabFace.GetHashCode();
		}
		if (CabHead.Length != 0)
		{
			num ^= CabHead.GetHashCode();
		}
		if (Normal.Length != 0)
		{
			num ^= Normal.GetHashCode();
		}
		if (NormalFace.Length != 0)
		{
			num ^= NormalFace.GetHashCode();
		}
		if (NormalHead.Length != 0)
		{
			num ^= NormalHead.GetHashCode();
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
		if (AvgCharId.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(AvgCharId);
		}
		personalitys_.WriteTo(output, _repeated_personalitys_codec);
		baseValue_.WriteTo(output, _repeated_baseValue_codec);
		if (Amax.Length != 0)
		{
			output.WriteRawTag(42);
			output.WriteString(Amax);
		}
		if (AmaxFace.Length != 0)
		{
			output.WriteRawTag(50);
			output.WriteString(AmaxFace);
		}
		if (AmaxHead.Length != 0)
		{
			output.WriteRawTag(58);
			output.WriteString(AmaxHead);
		}
		if (Bmax.Length != 0)
		{
			output.WriteRawTag(66);
			output.WriteString(Bmax);
		}
		if (BmaxFace.Length != 0)
		{
			output.WriteRawTag(74);
			output.WriteString(BmaxFace);
		}
		if (BmaxHead.Length != 0)
		{
			output.WriteRawTag(82);
			output.WriteString(BmaxHead);
		}
		if (Cmax.Length != 0)
		{
			output.WriteRawTag(90);
			output.WriteString(Cmax);
		}
		if (CmaxFace.Length != 0)
		{
			output.WriteRawTag(98);
			output.WriteString(CmaxFace);
		}
		if (CmaxHead.Length != 0)
		{
			output.WriteRawTag(106);
			output.WriteString(CmaxHead);
		}
		if (Aplus.Length != 0)
		{
			output.WriteRawTag(114);
			output.WriteString(Aplus);
		}
		if (AplusFace.Length != 0)
		{
			output.WriteRawTag(122);
			output.WriteString(AplusFace);
		}
		if (AplusHead.Length != 0)
		{
			output.WriteRawTag(130, 1);
			output.WriteString(AplusHead);
		}
		if (Bplus.Length != 0)
		{
			output.WriteRawTag(138, 1);
			output.WriteString(Bplus);
		}
		if (BplusFace.Length != 0)
		{
			output.WriteRawTag(146, 1);
			output.WriteString(BplusFace);
		}
		if (BplusHead.Length != 0)
		{
			output.WriteRawTag(154, 1);
			output.WriteString(BplusHead);
		}
		if (Cplus.Length != 0)
		{
			output.WriteRawTag(162, 1);
			output.WriteString(Cplus);
		}
		if (CplusFace.Length != 0)
		{
			output.WriteRawTag(170, 1);
			output.WriteString(CplusFace);
		}
		if (CplusHead.Length != 0)
		{
			output.WriteRawTag(178, 1);
			output.WriteString(CplusHead);
		}
		if (Abc.Length != 0)
		{
			output.WriteRawTag(186, 1);
			output.WriteString(Abc);
		}
		if (AbcFace.Length != 0)
		{
			output.WriteRawTag(194, 1);
			output.WriteString(AbcFace);
		}
		if (AbcHead.Length != 0)
		{
			output.WriteRawTag(202, 1);
			output.WriteString(AbcHead);
		}
		if (Bac.Length != 0)
		{
			output.WriteRawTag(210, 1);
			output.WriteString(Bac);
		}
		if (BacFace.Length != 0)
		{
			output.WriteRawTag(218, 1);
			output.WriteString(BacFace);
		}
		if (BacHead.Length != 0)
		{
			output.WriteRawTag(226, 1);
			output.WriteString(BacHead);
		}
		if (Cab.Length != 0)
		{
			output.WriteRawTag(234, 1);
			output.WriteString(Cab);
		}
		if (CabFace.Length != 0)
		{
			output.WriteRawTag(242, 1);
			output.WriteString(CabFace);
		}
		if (CabHead.Length != 0)
		{
			output.WriteRawTag(250, 1);
			output.WriteString(CabHead);
		}
		if (Normal.Length != 0)
		{
			output.WriteRawTag(130, 2);
			output.WriteString(Normal);
		}
		if (NormalFace.Length != 0)
		{
			output.WriteRawTag(138, 2);
			output.WriteString(NormalFace);
		}
		if (NormalHead.Length != 0)
		{
			output.WriteRawTag(146, 2);
			output.WriteString(NormalHead);
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
		if (AvgCharId.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AvgCharId);
		}
		num += personalitys_.CalculateSize(_repeated_personalitys_codec);
		num += baseValue_.CalculateSize(_repeated_baseValue_codec);
		if (Amax.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Amax);
		}
		if (AmaxFace.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AmaxFace);
		}
		if (AmaxHead.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AmaxHead);
		}
		if (Bmax.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Bmax);
		}
		if (BmaxFace.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BmaxFace);
		}
		if (BmaxHead.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(BmaxHead);
		}
		if (Cmax.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Cmax);
		}
		if (CmaxFace.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CmaxFace);
		}
		if (CmaxHead.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(CmaxHead);
		}
		if (Aplus.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Aplus);
		}
		if (AplusFace.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(AplusFace);
		}
		if (AplusHead.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AplusHead);
		}
		if (Bplus.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Bplus);
		}
		if (BplusFace.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BplusFace);
		}
		if (BplusHead.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BplusHead);
		}
		if (Cplus.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Cplus);
		}
		if (CplusFace.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CplusFace);
		}
		if (CplusHead.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CplusHead);
		}
		if (Abc.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Abc);
		}
		if (AbcFace.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AbcFace);
		}
		if (AbcHead.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(AbcHead);
		}
		if (Bac.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Bac);
		}
		if (BacFace.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BacFace);
		}
		if (BacHead.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(BacHead);
		}
		if (Cab.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Cab);
		}
		if (CabFace.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CabFace);
		}
		if (CabHead.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(CabHead);
		}
		if (Normal.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Normal);
		}
		if (NormalFace.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(NormalFace);
		}
		if (NormalHead.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(NormalHead);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(StoryRolePersonality other)
	{
		if (other != null)
		{
			if (other.Id != 0)
			{
				Id = other.Id;
			}
			if (other.AvgCharId.Length != 0)
			{
				AvgCharId = other.AvgCharId;
			}
			personalitys_.Add(other.personalitys_);
			baseValue_.Add(other.baseValue_);
			if (other.Amax.Length != 0)
			{
				Amax = other.Amax;
			}
			if (other.AmaxFace.Length != 0)
			{
				AmaxFace = other.AmaxFace;
			}
			if (other.AmaxHead.Length != 0)
			{
				AmaxHead = other.AmaxHead;
			}
			if (other.Bmax.Length != 0)
			{
				Bmax = other.Bmax;
			}
			if (other.BmaxFace.Length != 0)
			{
				BmaxFace = other.BmaxFace;
			}
			if (other.BmaxHead.Length != 0)
			{
				BmaxHead = other.BmaxHead;
			}
			if (other.Cmax.Length != 0)
			{
				Cmax = other.Cmax;
			}
			if (other.CmaxFace.Length != 0)
			{
				CmaxFace = other.CmaxFace;
			}
			if (other.CmaxHead.Length != 0)
			{
				CmaxHead = other.CmaxHead;
			}
			if (other.Aplus.Length != 0)
			{
				Aplus = other.Aplus;
			}
			if (other.AplusFace.Length != 0)
			{
				AplusFace = other.AplusFace;
			}
			if (other.AplusHead.Length != 0)
			{
				AplusHead = other.AplusHead;
			}
			if (other.Bplus.Length != 0)
			{
				Bplus = other.Bplus;
			}
			if (other.BplusFace.Length != 0)
			{
				BplusFace = other.BplusFace;
			}
			if (other.BplusHead.Length != 0)
			{
				BplusHead = other.BplusHead;
			}
			if (other.Cplus.Length != 0)
			{
				Cplus = other.Cplus;
			}
			if (other.CplusFace.Length != 0)
			{
				CplusFace = other.CplusFace;
			}
			if (other.CplusHead.Length != 0)
			{
				CplusHead = other.CplusHead;
			}
			if (other.Abc.Length != 0)
			{
				Abc = other.Abc;
			}
			if (other.AbcFace.Length != 0)
			{
				AbcFace = other.AbcFace;
			}
			if (other.AbcHead.Length != 0)
			{
				AbcHead = other.AbcHead;
			}
			if (other.Bac.Length != 0)
			{
				Bac = other.Bac;
			}
			if (other.BacFace.Length != 0)
			{
				BacFace = other.BacFace;
			}
			if (other.BacHead.Length != 0)
			{
				BacHead = other.BacHead;
			}
			if (other.Cab.Length != 0)
			{
				Cab = other.Cab;
			}
			if (other.CabFace.Length != 0)
			{
				CabFace = other.CabFace;
			}
			if (other.CabHead.Length != 0)
			{
				CabHead = other.CabHead;
			}
			if (other.Normal.Length != 0)
			{
				Normal = other.Normal;
			}
			if (other.NormalFace.Length != 0)
			{
				NormalFace = other.NormalFace;
			}
			if (other.NormalHead.Length != 0)
			{
				NormalHead = other.NormalHead;
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
				AvgCharId = input.ReadString();
				break;
			case 24u:
			case 26u:
				personalitys_.AddEntriesFrom(input, _repeated_personalitys_codec);
				break;
			case 32u:
			case 34u:
				baseValue_.AddEntriesFrom(input, _repeated_baseValue_codec);
				break;
			case 42u:
				Amax = input.ReadString();
				break;
			case 50u:
				AmaxFace = input.ReadString();
				break;
			case 58u:
				AmaxHead = input.ReadString();
				break;
			case 66u:
				Bmax = input.ReadString();
				break;
			case 74u:
				BmaxFace = input.ReadString();
				break;
			case 82u:
				BmaxHead = input.ReadString();
				break;
			case 90u:
				Cmax = input.ReadString();
				break;
			case 98u:
				CmaxFace = input.ReadString();
				break;
			case 106u:
				CmaxHead = input.ReadString();
				break;
			case 114u:
				Aplus = input.ReadString();
				break;
			case 122u:
				AplusFace = input.ReadString();
				break;
			case 130u:
				AplusHead = input.ReadString();
				break;
			case 138u:
				Bplus = input.ReadString();
				break;
			case 146u:
				BplusFace = input.ReadString();
				break;
			case 154u:
				BplusHead = input.ReadString();
				break;
			case 162u:
				Cplus = input.ReadString();
				break;
			case 170u:
				CplusFace = input.ReadString();
				break;
			case 178u:
				CplusHead = input.ReadString();
				break;
			case 186u:
				Abc = input.ReadString();
				break;
			case 194u:
				AbcFace = input.ReadString();
				break;
			case 202u:
				AbcHead = input.ReadString();
				break;
			case 210u:
				Bac = input.ReadString();
				break;
			case 218u:
				BacFace = input.ReadString();
				break;
			case 226u:
				BacHead = input.ReadString();
				break;
			case 234u:
				Cab = input.ReadString();
				break;
			case 242u:
				CabFace = input.ReadString();
				break;
			case 250u:
				CabHead = input.ReadString();
				break;
			case 258u:
				Normal = input.ReadString();
				break;
			case 266u:
				NormalFace = input.ReadString();
				break;
			case 274u:
				NormalHead = input.ReadString();
				break;
			}
		}
	}
}
