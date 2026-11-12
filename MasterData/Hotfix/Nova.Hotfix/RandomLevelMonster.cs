using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class RandomLevelMonster : IMessage<RandomLevelMonster>, IMessage, IEquatable<RandomLevelMonster>, IDeepCloneable<RandomLevelMonster>
{
	private static readonly MessageParser<RandomLevelMonster> _parser = new MessageParser<RandomLevelMonster>(() => new RandomLevelMonster());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private int id_;

	public const int NameFieldNumber = 2;

	private string name_ = "";

	public const int EpicLvFieldNumber = 3;

	private int epicLv_;

	public const int BloodTypeFieldNumber = 4;

	private int bloodType_;

	public const int EETFieldNumber = 5;

	private int eET_;

	public const int FCIdFieldNumber = 6;

	private int fCId_;

	public const int FAIdFieldNumber = 7;

	private int fAId_;

	public const int MovTypeFieldNumber = 8;

	private int movType_;

	public const int RunSpdFieldNumber = 9;

	private int runSpd_;

	public const int TransSpdScaleFieldNumber = 10;

	private int transSpdScale_;

	public const int WalkSpdFieldNumber = 11;

	private int walkSpd_;

	public const int MovAccFieldNumber = 12;

	private int movAcc_;

	public const int VisionRngFieldNumber = 13;

	private int visionRng_;

	public const int VisionDegFieldNumber = 14;

	private int visionDeg_;

	public const int HearRngFieldNumber = 15;

	private int hearRng_;

	public const int RefRngFieldNumber = 16;

	private int refRng_;

	public const int ActRngFieldNumber = 17;

	private int actRng_;

	public const int DisActRngFieldNumber = 18;

	private int disActRng_;

	public const int RotSpdFieldNumber = 19;

	private int rotSpd_;

	public const int TempleteFieldNumber = 20;

	private int templete_;

	public const int WEPFieldNumber = 21;

	private int wEP_;

	public const int FEPFieldNumber = 22;

	private int fEP_;

	public const int SEPFieldNumber = 23;

	private int sEP_;

	public const int AEPFieldNumber = 24;

	private int aEP_;

	public const int LEPFieldNumber = 25;

	private int lEP_;

	public const int DEPFieldNumber = 26;

	private int dEP_;

	public const int WEEFieldNumber = 27;

	private int wEE_;

	public const int FEEFieldNumber = 28;

	private int fEE_;

	public const int SEEFieldNumber = 29;

	private int sEE_;

	public const int AEEFieldNumber = 30;

	private int aEE_;

	public const int LEEFieldNumber = 31;

	private int lEE_;

	public const int DEEFieldNumber = 32;

	private int dEE_;

	public const int WERFieldNumber = 33;

	private int wER_;

	public const int FERFieldNumber = 34;

	private int fER_;

	public const int SERFieldNumber = 35;

	private int sER_;

	public const int AERFieldNumber = 36;

	private int aER_;

	public const int LERFieldNumber = 37;

	private int lER_;

	public const int DERFieldNumber = 38;

	private int dER_;

	public const int BuffIdsFieldNumber = 39;

	private static readonly FieldCodec<int> _repeated_buffIds_codec = FieldCodec.ForInt32(314u);

	private readonly RepeatedField<int> buffIds_ = new RepeatedField<int>();

	public const int WeightFieldNumber = 40;

	private int weight_;

	public const int TrapTagIdsFieldNumber = 41;

	private static readonly FieldCodec<int> _repeated_trapTagIds_codec = FieldCodec.ForInt32(330u);

	private readonly RepeatedField<int> trapTagIds_ = new RepeatedField<int>();

	public const int FactionFieldNumber = 42;

	private int faction_;

	public const int SupChargeFieldNumber = 43;

	private int supCharge_;

	public const int IsShowRngFieldNumber = 44;

	private bool isShowRng_;

	public const int TrapAttrIdFieldNumber = 45;

	private int trapAttrId_;

	public const int Tag1FieldNumber = 46;

	private string tag1_ = "";

	public const int Tag2FieldNumber = 47;

	private string tag2_ = "";

	public const int Tag3FieldNumber = 48;

	private string tag3_ = "";

	public const int Tag4FieldNumber = 49;

	private string tag4_ = "";

	public const int Tag5FieldNumber = 50;

	private string tag5_ = "";

	[DebuggerNonUserCode]
	public static MessageParser<RandomLevelMonster> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(672);

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
	public int BloodType
	{
		get
		{
			return bloodType_;
		}
		set
		{
			bloodType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int EET
	{
		get
		{
			return eET_;
		}
		set
		{
			eET_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FCId
	{
		get
		{
			return fCId_;
		}
		set
		{
			fCId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FAId
	{
		get
		{
			return fAId_;
		}
		set
		{
			fAId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MovType
	{
		get
		{
			return movType_;
		}
		set
		{
			movType_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RunSpd
	{
		get
		{
			return runSpd_;
		}
		set
		{
			runSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TransSpdScale
	{
		get
		{
			return transSpdScale_;
		}
		set
		{
			transSpdScale_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WalkSpd
	{
		get
		{
			return walkSpd_;
		}
		set
		{
			walkSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MovAcc
	{
		get
		{
			return movAcc_;
		}
		set
		{
			movAcc_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VisionRng
	{
		get
		{
			return visionRng_;
		}
		set
		{
			visionRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int VisionDeg
	{
		get
		{
			return visionDeg_;
		}
		set
		{
			visionDeg_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HearRng
	{
		get
		{
			return hearRng_;
		}
		set
		{
			hearRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RefRng
	{
		get
		{
			return refRng_;
		}
		set
		{
			refRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ActRng
	{
		get
		{
			return actRng_;
		}
		set
		{
			actRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DisActRng
	{
		get
		{
			return disActRng_;
		}
		set
		{
			disActRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RotSpd
	{
		get
		{
			return rotSpd_;
		}
		set
		{
			rotSpd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Templete
	{
		get
		{
			return templete_;
		}
		set
		{
			templete_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WEP
	{
		get
		{
			return wEP_;
		}
		set
		{
			wEP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FEP
	{
		get
		{
			return fEP_;
		}
		set
		{
			fEP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SEP
	{
		get
		{
			return sEP_;
		}
		set
		{
			sEP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AEP
	{
		get
		{
			return aEP_;
		}
		set
		{
			aEP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LEP
	{
		get
		{
			return lEP_;
		}
		set
		{
			lEP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DEP
	{
		get
		{
			return dEP_;
		}
		set
		{
			dEP_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WEE
	{
		get
		{
			return wEE_;
		}
		set
		{
			wEE_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FEE
	{
		get
		{
			return fEE_;
		}
		set
		{
			fEE_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SEE
	{
		get
		{
			return sEE_;
		}
		set
		{
			sEE_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AEE
	{
		get
		{
			return aEE_;
		}
		set
		{
			aEE_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LEE
	{
		get
		{
			return lEE_;
		}
		set
		{
			lEE_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DEE
	{
		get
		{
			return dEE_;
		}
		set
		{
			dEE_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WER
	{
		get
		{
			return wER_;
		}
		set
		{
			wER_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FER
	{
		get
		{
			return fER_;
		}
		set
		{
			fER_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SER
	{
		get
		{
			return sER_;
		}
		set
		{
			sER_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AER
	{
		get
		{
			return aER_;
		}
		set
		{
			aER_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LER
	{
		get
		{
			return lER_;
		}
		set
		{
			lER_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DER
	{
		get
		{
			return dER_;
		}
		set
		{
			dER_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> BuffIds => buffIds_;

	[DebuggerNonUserCode]
	public int Weight
	{
		get
		{
			return weight_;
		}
		set
		{
			weight_ = value;
		}
	}

	[DebuggerNonUserCode]
	public RepeatedField<int> TrapTagIds => trapTagIds_;

	[DebuggerNonUserCode]
	public int Faction
	{
		get
		{
			return faction_;
		}
		set
		{
			faction_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SupCharge
	{
		get
		{
			return supCharge_;
		}
		set
		{
			supCharge_ = value;
		}
	}

	[DebuggerNonUserCode]
	public bool IsShowRng
	{
		get
		{
			return isShowRng_;
		}
		set
		{
			isShowRng_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int TrapAttrId
	{
		get
		{
			return trapAttrId_;
		}
		set
		{
			trapAttrId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public string Tag1
	{
		get
		{
			return tag1_;
		}
		set
		{
			tag1_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag2
	{
		get
		{
			return tag2_;
		}
		set
		{
			tag2_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag3
	{
		get
		{
			return tag3_;
		}
		set
		{
			tag3_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag4
	{
		get
		{
			return tag4_;
		}
		set
		{
			tag4_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public string Tag5
	{
		get
		{
			return tag5_;
		}
		set
		{
			tag5_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public RandomLevelMonster()
	{
	}

	[DebuggerNonUserCode]
	public RandomLevelMonster(RandomLevelMonster other)
		: this()
	{
		id_ = other.id_;
		name_ = other.name_;
		epicLv_ = other.epicLv_;
		bloodType_ = other.bloodType_;
		eET_ = other.eET_;
		fCId_ = other.fCId_;
		fAId_ = other.fAId_;
		movType_ = other.movType_;
		runSpd_ = other.runSpd_;
		transSpdScale_ = other.transSpdScale_;
		walkSpd_ = other.walkSpd_;
		movAcc_ = other.movAcc_;
		visionRng_ = other.visionRng_;
		visionDeg_ = other.visionDeg_;
		hearRng_ = other.hearRng_;
		refRng_ = other.refRng_;
		actRng_ = other.actRng_;
		disActRng_ = other.disActRng_;
		rotSpd_ = other.rotSpd_;
		templete_ = other.templete_;
		wEP_ = other.wEP_;
		fEP_ = other.fEP_;
		sEP_ = other.sEP_;
		aEP_ = other.aEP_;
		lEP_ = other.lEP_;
		dEP_ = other.dEP_;
		wEE_ = other.wEE_;
		fEE_ = other.fEE_;
		sEE_ = other.sEE_;
		aEE_ = other.aEE_;
		lEE_ = other.lEE_;
		dEE_ = other.dEE_;
		wER_ = other.wER_;
		fER_ = other.fER_;
		sER_ = other.sER_;
		aER_ = other.aER_;
		lER_ = other.lER_;
		dER_ = other.dER_;
		buffIds_ = other.buffIds_.Clone();
		weight_ = other.weight_;
		trapTagIds_ = other.trapTagIds_.Clone();
		faction_ = other.faction_;
		supCharge_ = other.supCharge_;
		isShowRng_ = other.isShowRng_;
		trapAttrId_ = other.trapAttrId_;
		tag1_ = other.tag1_;
		tag2_ = other.tag2_;
		tag3_ = other.tag3_;
		tag4_ = other.tag4_;
		tag5_ = other.tag5_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public RandomLevelMonster Clone()
	{
		return new RandomLevelMonster(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as RandomLevelMonster);
	}

	[DebuggerNonUserCode]
	public bool Equals(RandomLevelMonster other)
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
		if (EpicLv != other.EpicLv)
		{
			return false;
		}
		if (BloodType != other.BloodType)
		{
			return false;
		}
		if (EET != other.EET)
		{
			return false;
		}
		if (FCId != other.FCId)
		{
			return false;
		}
		if (FAId != other.FAId)
		{
			return false;
		}
		if (MovType != other.MovType)
		{
			return false;
		}
		if (RunSpd != other.RunSpd)
		{
			return false;
		}
		if (TransSpdScale != other.TransSpdScale)
		{
			return false;
		}
		if (WalkSpd != other.WalkSpd)
		{
			return false;
		}
		if (MovAcc != other.MovAcc)
		{
			return false;
		}
		if (VisionRng != other.VisionRng)
		{
			return false;
		}
		if (VisionDeg != other.VisionDeg)
		{
			return false;
		}
		if (HearRng != other.HearRng)
		{
			return false;
		}
		if (RefRng != other.RefRng)
		{
			return false;
		}
		if (ActRng != other.ActRng)
		{
			return false;
		}
		if (DisActRng != other.DisActRng)
		{
			return false;
		}
		if (RotSpd != other.RotSpd)
		{
			return false;
		}
		if (Templete != other.Templete)
		{
			return false;
		}
		if (WEP != other.WEP)
		{
			return false;
		}
		if (FEP != other.FEP)
		{
			return false;
		}
		if (SEP != other.SEP)
		{
			return false;
		}
		if (AEP != other.AEP)
		{
			return false;
		}
		if (LEP != other.LEP)
		{
			return false;
		}
		if (DEP != other.DEP)
		{
			return false;
		}
		if (WEE != other.WEE)
		{
			return false;
		}
		if (FEE != other.FEE)
		{
			return false;
		}
		if (SEE != other.SEE)
		{
			return false;
		}
		if (AEE != other.AEE)
		{
			return false;
		}
		if (LEE != other.LEE)
		{
			return false;
		}
		if (DEE != other.DEE)
		{
			return false;
		}
		if (WER != other.WER)
		{
			return false;
		}
		if (FER != other.FER)
		{
			return false;
		}
		if (SER != other.SER)
		{
			return false;
		}
		if (AER != other.AER)
		{
			return false;
		}
		if (LER != other.LER)
		{
			return false;
		}
		if (DER != other.DER)
		{
			return false;
		}
		if (!buffIds_.Equals(other.buffIds_))
		{
			return false;
		}
		if (Weight != other.Weight)
		{
			return false;
		}
		if (!trapTagIds_.Equals(other.trapTagIds_))
		{
			return false;
		}
		if (Faction != other.Faction)
		{
			return false;
		}
		if (SupCharge != other.SupCharge)
		{
			return false;
		}
		if (IsShowRng != other.IsShowRng)
		{
			return false;
		}
		if (TrapAttrId != other.TrapAttrId)
		{
			return false;
		}
		if (Tag1 != other.Tag1)
		{
			return false;
		}
		if (Tag2 != other.Tag2)
		{
			return false;
		}
		if (Tag3 != other.Tag3)
		{
			return false;
		}
		if (Tag4 != other.Tag4)
		{
			return false;
		}
		if (Tag5 != other.Tag5)
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
		if (EpicLv != 0)
		{
			num ^= EpicLv.GetHashCode();
		}
		if (BloodType != 0)
		{
			num ^= BloodType.GetHashCode();
		}
		if (EET != 0)
		{
			num ^= EET.GetHashCode();
		}
		if (FCId != 0)
		{
			num ^= FCId.GetHashCode();
		}
		if (FAId != 0)
		{
			num ^= FAId.GetHashCode();
		}
		if (MovType != 0)
		{
			num ^= MovType.GetHashCode();
		}
		if (RunSpd != 0)
		{
			num ^= RunSpd.GetHashCode();
		}
		if (TransSpdScale != 0)
		{
			num ^= TransSpdScale.GetHashCode();
		}
		if (WalkSpd != 0)
		{
			num ^= WalkSpd.GetHashCode();
		}
		if (MovAcc != 0)
		{
			num ^= MovAcc.GetHashCode();
		}
		if (VisionRng != 0)
		{
			num ^= VisionRng.GetHashCode();
		}
		if (VisionDeg != 0)
		{
			num ^= VisionDeg.GetHashCode();
		}
		if (HearRng != 0)
		{
			num ^= HearRng.GetHashCode();
		}
		if (RefRng != 0)
		{
			num ^= RefRng.GetHashCode();
		}
		if (ActRng != 0)
		{
			num ^= ActRng.GetHashCode();
		}
		if (DisActRng != 0)
		{
			num ^= DisActRng.GetHashCode();
		}
		if (RotSpd != 0)
		{
			num ^= RotSpd.GetHashCode();
		}
		if (Templete != 0)
		{
			num ^= Templete.GetHashCode();
		}
		if (WEP != 0)
		{
			num ^= WEP.GetHashCode();
		}
		if (FEP != 0)
		{
			num ^= FEP.GetHashCode();
		}
		if (SEP != 0)
		{
			num ^= SEP.GetHashCode();
		}
		if (AEP != 0)
		{
			num ^= AEP.GetHashCode();
		}
		if (LEP != 0)
		{
			num ^= LEP.GetHashCode();
		}
		if (DEP != 0)
		{
			num ^= DEP.GetHashCode();
		}
		if (WEE != 0)
		{
			num ^= WEE.GetHashCode();
		}
		if (FEE != 0)
		{
			num ^= FEE.GetHashCode();
		}
		if (SEE != 0)
		{
			num ^= SEE.GetHashCode();
		}
		if (AEE != 0)
		{
			num ^= AEE.GetHashCode();
		}
		if (LEE != 0)
		{
			num ^= LEE.GetHashCode();
		}
		if (DEE != 0)
		{
			num ^= DEE.GetHashCode();
		}
		if (WER != 0)
		{
			num ^= WER.GetHashCode();
		}
		if (FER != 0)
		{
			num ^= FER.GetHashCode();
		}
		if (SER != 0)
		{
			num ^= SER.GetHashCode();
		}
		if (AER != 0)
		{
			num ^= AER.GetHashCode();
		}
		if (LER != 0)
		{
			num ^= LER.GetHashCode();
		}
		if (DER != 0)
		{
			num ^= DER.GetHashCode();
		}
		num ^= buffIds_.GetHashCode();
		if (Weight != 0)
		{
			num ^= Weight.GetHashCode();
		}
		num ^= trapTagIds_.GetHashCode();
		if (Faction != 0)
		{
			num ^= Faction.GetHashCode();
		}
		if (SupCharge != 0)
		{
			num ^= SupCharge.GetHashCode();
		}
		if (IsShowRng)
		{
			num ^= IsShowRng.GetHashCode();
		}
		if (TrapAttrId != 0)
		{
			num ^= TrapAttrId.GetHashCode();
		}
		if (Tag1.Length != 0)
		{
			num ^= Tag1.GetHashCode();
		}
		if (Tag2.Length != 0)
		{
			num ^= Tag2.GetHashCode();
		}
		if (Tag3.Length != 0)
		{
			num ^= Tag3.GetHashCode();
		}
		if (Tag4.Length != 0)
		{
			num ^= Tag4.GetHashCode();
		}
		if (Tag5.Length != 0)
		{
			num ^= Tag5.GetHashCode();
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
		if (Name.Length != 0)
		{
			output.WriteRawTag(18);
			output.WriteString(Name);
		}
		if (EpicLv != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(EpicLv);
		}
		if (BloodType != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(BloodType);
		}
		if (EET != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(EET);
		}
		if (FCId != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(FCId);
		}
		if (FAId != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(FAId);
		}
		if (MovType != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(MovType);
		}
		if (RunSpd != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(RunSpd);
		}
		if (TransSpdScale != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(TransSpdScale);
		}
		if (WalkSpd != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(WalkSpd);
		}
		if (MovAcc != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(MovAcc);
		}
		if (VisionRng != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(VisionRng);
		}
		if (VisionDeg != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(VisionDeg);
		}
		if (HearRng != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(HearRng);
		}
		if (RefRng != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(RefRng);
		}
		if (ActRng != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(ActRng);
		}
		if (DisActRng != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(DisActRng);
		}
		if (RotSpd != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(RotSpd);
		}
		if (Templete != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(Templete);
		}
		if (WEP != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(WEP);
		}
		if (FEP != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(FEP);
		}
		if (SEP != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(SEP);
		}
		if (AEP != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(AEP);
		}
		if (LEP != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(LEP);
		}
		if (DEP != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(DEP);
		}
		if (WEE != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(WEE);
		}
		if (FEE != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(FEE);
		}
		if (SEE != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(SEE);
		}
		if (AEE != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(AEE);
		}
		if (LEE != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(LEE);
		}
		if (DEE != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(DEE);
		}
		if (WER != 0)
		{
			output.WriteRawTag(136, 2);
			output.WriteInt32(WER);
		}
		if (FER != 0)
		{
			output.WriteRawTag(144, 2);
			output.WriteInt32(FER);
		}
		if (SER != 0)
		{
			output.WriteRawTag(152, 2);
			output.WriteInt32(SER);
		}
		if (AER != 0)
		{
			output.WriteRawTag(160, 2);
			output.WriteInt32(AER);
		}
		if (LER != 0)
		{
			output.WriteRawTag(168, 2);
			output.WriteInt32(LER);
		}
		if (DER != 0)
		{
			output.WriteRawTag(176, 2);
			output.WriteInt32(DER);
		}
		buffIds_.WriteTo(output, _repeated_buffIds_codec);
		if (Weight != 0)
		{
			output.WriteRawTag(192, 2);
			output.WriteInt32(Weight);
		}
		trapTagIds_.WriteTo(output, _repeated_trapTagIds_codec);
		if (Faction != 0)
		{
			output.WriteRawTag(208, 2);
			output.WriteInt32(Faction);
		}
		if (SupCharge != 0)
		{
			output.WriteRawTag(216, 2);
			output.WriteInt32(SupCharge);
		}
		if (IsShowRng)
		{
			output.WriteRawTag(224, 2);
			output.WriteBool(IsShowRng);
		}
		if (TrapAttrId != 0)
		{
			output.WriteRawTag(232, 2);
			output.WriteInt32(TrapAttrId);
		}
		if (Tag1.Length != 0)
		{
			output.WriteRawTag(242, 2);
			output.WriteString(Tag1);
		}
		if (Tag2.Length != 0)
		{
			output.WriteRawTag(250, 2);
			output.WriteString(Tag2);
		}
		if (Tag3.Length != 0)
		{
			output.WriteRawTag(130, 3);
			output.WriteString(Tag3);
		}
		if (Tag4.Length != 0)
		{
			output.WriteRawTag(138, 3);
			output.WriteString(Tag4);
		}
		if (Tag5.Length != 0)
		{
			output.WriteRawTag(146, 3);
			output.WriteString(Tag5);
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
		if (Name.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Name);
		}
		if (EpicLv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EpicLv);
		}
		if (BloodType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(BloodType);
		}
		if (EET != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(EET);
		}
		if (FCId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FCId);
		}
		if (FAId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(FAId);
		}
		if (MovType != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MovType);
		}
		if (RunSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(RunSpd);
		}
		if (TransSpdScale != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TransSpdScale);
		}
		if (WalkSpd != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(WalkSpd);
		}
		if (MovAcc != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MovAcc);
		}
		if (VisionRng != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(VisionRng);
		}
		if (VisionDeg != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(VisionDeg);
		}
		if (HearRng != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(HearRng);
		}
		if (RefRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RefRng);
		}
		if (ActRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ActRng);
		}
		if (DisActRng != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DisActRng);
		}
		if (RotSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RotSpd);
		}
		if (Templete != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Templete);
		}
		if (WEP != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WEP);
		}
		if (FEP != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FEP);
		}
		if (SEP != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SEP);
		}
		if (AEP != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AEP);
		}
		if (LEP != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LEP);
		}
		if (DEP != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DEP);
		}
		if (WEE != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WEE);
		}
		if (FEE != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FEE);
		}
		if (SEE != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SEE);
		}
		if (AEE != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AEE);
		}
		if (LEE != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LEE);
		}
		if (DEE != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DEE);
		}
		if (WER != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WER);
		}
		if (FER != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FER);
		}
		if (SER != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SER);
		}
		if (AER != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AER);
		}
		if (LER != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LER);
		}
		if (DER != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DER);
		}
		num += buffIds_.CalculateSize(_repeated_buffIds_codec);
		if (Weight != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Weight);
		}
		num += trapTagIds_.CalculateSize(_repeated_trapTagIds_codec);
		if (Faction != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Faction);
		}
		if (SupCharge != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SupCharge);
		}
		if (IsShowRng)
		{
			num += 3;
		}
		if (TrapAttrId != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(TrapAttrId);
		}
		if (Tag1.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag1);
		}
		if (Tag2.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag2);
		}
		if (Tag3.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag3);
		}
		if (Tag4.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag4);
		}
		if (Tag5.Length != 0)
		{
			num += 2 + CodedOutputStream.ComputeStringSize(Tag5);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(RandomLevelMonster other)
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
			if (other.EpicLv != 0)
			{
				EpicLv = other.EpicLv;
			}
			if (other.BloodType != 0)
			{
				BloodType = other.BloodType;
			}
			if (other.EET != 0)
			{
				EET = other.EET;
			}
			if (other.FCId != 0)
			{
				FCId = other.FCId;
			}
			if (other.FAId != 0)
			{
				FAId = other.FAId;
			}
			if (other.MovType != 0)
			{
				MovType = other.MovType;
			}
			if (other.RunSpd != 0)
			{
				RunSpd = other.RunSpd;
			}
			if (other.TransSpdScale != 0)
			{
				TransSpdScale = other.TransSpdScale;
			}
			if (other.WalkSpd != 0)
			{
				WalkSpd = other.WalkSpd;
			}
			if (other.MovAcc != 0)
			{
				MovAcc = other.MovAcc;
			}
			if (other.VisionRng != 0)
			{
				VisionRng = other.VisionRng;
			}
			if (other.VisionDeg != 0)
			{
				VisionDeg = other.VisionDeg;
			}
			if (other.HearRng != 0)
			{
				HearRng = other.HearRng;
			}
			if (other.RefRng != 0)
			{
				RefRng = other.RefRng;
			}
			if (other.ActRng != 0)
			{
				ActRng = other.ActRng;
			}
			if (other.DisActRng != 0)
			{
				DisActRng = other.DisActRng;
			}
			if (other.RotSpd != 0)
			{
				RotSpd = other.RotSpd;
			}
			if (other.Templete != 0)
			{
				Templete = other.Templete;
			}
			if (other.WEP != 0)
			{
				WEP = other.WEP;
			}
			if (other.FEP != 0)
			{
				FEP = other.FEP;
			}
			if (other.SEP != 0)
			{
				SEP = other.SEP;
			}
			if (other.AEP != 0)
			{
				AEP = other.AEP;
			}
			if (other.LEP != 0)
			{
				LEP = other.LEP;
			}
			if (other.DEP != 0)
			{
				DEP = other.DEP;
			}
			if (other.WEE != 0)
			{
				WEE = other.WEE;
			}
			if (other.FEE != 0)
			{
				FEE = other.FEE;
			}
			if (other.SEE != 0)
			{
				SEE = other.SEE;
			}
			if (other.AEE != 0)
			{
				AEE = other.AEE;
			}
			if (other.LEE != 0)
			{
				LEE = other.LEE;
			}
			if (other.DEE != 0)
			{
				DEE = other.DEE;
			}
			if (other.WER != 0)
			{
				WER = other.WER;
			}
			if (other.FER != 0)
			{
				FER = other.FER;
			}
			if (other.SER != 0)
			{
				SER = other.SER;
			}
			if (other.AER != 0)
			{
				AER = other.AER;
			}
			if (other.LER != 0)
			{
				LER = other.LER;
			}
			if (other.DER != 0)
			{
				DER = other.DER;
			}
			buffIds_.Add(other.buffIds_);
			if (other.Weight != 0)
			{
				Weight = other.Weight;
			}
			trapTagIds_.Add(other.trapTagIds_);
			if (other.Faction != 0)
			{
				Faction = other.Faction;
			}
			if (other.SupCharge != 0)
			{
				SupCharge = other.SupCharge;
			}
			if (other.IsShowRng)
			{
				IsShowRng = other.IsShowRng;
			}
			if (other.TrapAttrId != 0)
			{
				TrapAttrId = other.TrapAttrId;
			}
			if (other.Tag1.Length != 0)
			{
				Tag1 = other.Tag1;
			}
			if (other.Tag2.Length != 0)
			{
				Tag2 = other.Tag2;
			}
			if (other.Tag3.Length != 0)
			{
				Tag3 = other.Tag3;
			}
			if (other.Tag4.Length != 0)
			{
				Tag4 = other.Tag4;
			}
			if (other.Tag5.Length != 0)
			{
				Tag5 = other.Tag5;
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
				Name = input.ReadString();
				break;
			case 24u:
				EpicLv = input.ReadInt32();
				break;
			case 32u:
				BloodType = input.ReadInt32();
				break;
			case 40u:
				EET = input.ReadInt32();
				break;
			case 48u:
				FCId = input.ReadInt32();
				break;
			case 56u:
				FAId = input.ReadInt32();
				break;
			case 64u:
				MovType = input.ReadInt32();
				break;
			case 72u:
				RunSpd = input.ReadInt32();
				break;
			case 80u:
				TransSpdScale = input.ReadInt32();
				break;
			case 88u:
				WalkSpd = input.ReadInt32();
				break;
			case 96u:
				MovAcc = input.ReadInt32();
				break;
			case 104u:
				VisionRng = input.ReadInt32();
				break;
			case 112u:
				VisionDeg = input.ReadInt32();
				break;
			case 120u:
				HearRng = input.ReadInt32();
				break;
			case 128u:
				RefRng = input.ReadInt32();
				break;
			case 136u:
				ActRng = input.ReadInt32();
				break;
			case 144u:
				DisActRng = input.ReadInt32();
				break;
			case 152u:
				RotSpd = input.ReadInt32();
				break;
			case 160u:
				Templete = input.ReadInt32();
				break;
			case 168u:
				WEP = input.ReadInt32();
				break;
			case 176u:
				FEP = input.ReadInt32();
				break;
			case 184u:
				SEP = input.ReadInt32();
				break;
			case 192u:
				AEP = input.ReadInt32();
				break;
			case 200u:
				LEP = input.ReadInt32();
				break;
			case 208u:
				DEP = input.ReadInt32();
				break;
			case 216u:
				WEE = input.ReadInt32();
				break;
			case 224u:
				FEE = input.ReadInt32();
				break;
			case 232u:
				SEE = input.ReadInt32();
				break;
			case 240u:
				AEE = input.ReadInt32();
				break;
			case 248u:
				LEE = input.ReadInt32();
				break;
			case 256u:
				DEE = input.ReadInt32();
				break;
			case 264u:
				WER = input.ReadInt32();
				break;
			case 272u:
				FER = input.ReadInt32();
				break;
			case 280u:
				SER = input.ReadInt32();
				break;
			case 288u:
				AER = input.ReadInt32();
				break;
			case 296u:
				LER = input.ReadInt32();
				break;
			case 304u:
				DER = input.ReadInt32();
				break;
			case 312u:
			case 314u:
				buffIds_.AddEntriesFrom(input, _repeated_buffIds_codec);
				break;
			case 320u:
				Weight = input.ReadInt32();
				break;
			case 328u:
			case 330u:
				trapTagIds_.AddEntriesFrom(input, _repeated_trapTagIds_codec);
				break;
			case 336u:
				Faction = input.ReadInt32();
				break;
			case 344u:
				SupCharge = input.ReadInt32();
				break;
			case 352u:
				IsShowRng = input.ReadBool();
				break;
			case 360u:
				TrapAttrId = input.ReadInt32();
				break;
			case 370u:
				Tag1 = input.ReadString();
				break;
			case 378u:
				Tag2 = input.ReadString();
				break;
			case 386u:
				Tag3 = input.ReadString();
				break;
			case 394u:
				Tag4 = input.ReadString();
				break;
			case 402u:
				Tag5 = input.ReadString();
				break;
			}
		}
	}
}
