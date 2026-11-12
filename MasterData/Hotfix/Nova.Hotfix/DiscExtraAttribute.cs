using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class DiscExtraAttribute : IMessage<DiscExtraAttribute>, IMessage, IEquatable<DiscExtraAttribute>, IDeepCloneable<DiscExtraAttribute>
{
	private static readonly MessageParser<DiscExtraAttribute> _parser = new MessageParser<DiscExtraAttribute>(() => new DiscExtraAttribute());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private string id_ = "";

	public const int GroupIdFieldNumber = 2;

	private int groupId_;

	public const int BreakFieldNumber = 3;

	private int break_;

	public const int AtkFieldNumber = 4;

	private int atk_;

	public const int HpFieldNumber = 5;

	private int hp_;

	public const int DefFieldNumber = 6;

	private int def_;

	public const int CritRateFieldNumber = 7;

	private int critRate_;

	public const int NormalCritRateFieldNumber = 8;

	private int normalCritRate_;

	public const int SkillCritRateFieldNumber = 9;

	private int skillCritRate_;

	public const int UltraCritRateFieldNumber = 10;

	private int ultraCritRate_;

	public const int MarkCritRateFieldNumber = 11;

	private int markCritRate_;

	public const int SummonCritRateFieldNumber = 12;

	private int summonCritRate_;

	public const int ProjectileCritRateFieldNumber = 13;

	private int projectileCritRate_;

	public const int OtherCritRateFieldNumber = 14;

	private int otherCritRate_;

	public const int CritResistanceFieldNumber = 15;

	private int critResistance_;

	public const int CritPowerFieldNumber = 16;

	private int critPower_;

	public const int NormalCritPowerFieldNumber = 17;

	private int normalCritPower_;

	public const int SkillCritPowerFieldNumber = 18;

	private int skillCritPower_;

	public const int UltraCritPowerFieldNumber = 19;

	private int ultraCritPower_;

	public const int MarkCritPowerFieldNumber = 20;

	private int markCritPower_;

	public const int SummonCritPowerFieldNumber = 21;

	private int summonCritPower_;

	public const int ProjectileCritPowerFieldNumber = 22;

	private int projectileCritPower_;

	public const int OtherCritPowerFieldNumber = 23;

	private int otherCritPower_;

	public const int HitRateFieldNumber = 24;

	private int hitRate_;

	public const int EvdFieldNumber = 25;

	private int evd_;

	public const int DefPierceFieldNumber = 26;

	private int defPierce_;

	public const int DefIgnoreFieldNumber = 27;

	private int defIgnore_;

	public const int WEPFieldNumber = 28;

	private int wEP_;

	public const int FEPFieldNumber = 29;

	private int fEP_;

	public const int SEPFieldNumber = 30;

	private int sEP_;

	public const int AEPFieldNumber = 31;

	private int aEP_;

	public const int LEPFieldNumber = 32;

	private int lEP_;

	public const int DEPFieldNumber = 33;

	private int dEP_;

	public const int WEIFieldNumber = 34;

	private int wEI_;

	public const int FEIFieldNumber = 35;

	private int fEI_;

	public const int SEIFieldNumber = 36;

	private int sEI_;

	public const int AEIFieldNumber = 37;

	private int aEI_;

	public const int LEIFieldNumber = 38;

	private int lEI_;

	public const int DEIFieldNumber = 39;

	private int dEI_;

	public const int WEEFieldNumber = 40;

	private int wEE_;

	public const int FEEFieldNumber = 41;

	private int fEE_;

	public const int SEEFieldNumber = 42;

	private int sEE_;

	public const int AEEFieldNumber = 43;

	private int aEE_;

	public const int LEEFieldNumber = 44;

	private int lEE_;

	public const int DEEFieldNumber = 45;

	private int dEE_;

	public const int WERFieldNumber = 46;

	private int wER_;

	public const int FERFieldNumber = 47;

	private int fER_;

	public const int SERFieldNumber = 48;

	private int sER_;

	public const int AERFieldNumber = 49;

	private int aER_;

	public const int LERFieldNumber = 50;

	private int lER_;

	public const int DERFieldNumber = 51;

	private int dER_;

	public const int ToughnessDamageAdjustFieldNumber = 52;

	private int toughnessDamageAdjust_;

	public const int ToughnessFieldNumber = 53;

	private int toughness_;

	public const int SuppressFieldNumber = 54;

	private int suppress_;

	public const int NORMALDMGFieldNumber = 55;

	private int nORMALDMG_;

	public const int SKILLDMGFieldNumber = 56;

	private int sKILLDMG_;

	public const int ULTRADMGFieldNumber = 57;

	private int uLTRADMG_;

	public const int OTHERDMGFieldNumber = 58;

	private int oTHERDMG_;

	public const int RCDNORMALDMGFieldNumber = 59;

	private int rCDNORMALDMG_;

	public const int RCDSKILLDMGFieldNumber = 60;

	private int rCDSKILLDMG_;

	public const int RCDULTRADMGFieldNumber = 61;

	private int rCDULTRADMG_;

	public const int RCDOTHERDMGFieldNumber = 62;

	private int rCDOTHERDMG_;

	public const int MARKDMGFieldNumber = 63;

	private int mARKDMG_;

	public const int RCDMARKDMGFieldNumber = 64;

	private int rCDMARKDMG_;

	public const int SUMMONDMGFieldNumber = 65;

	private int sUMMONDMG_;

	public const int RCDSUMMONDMGFieldNumber = 66;

	private int rCDSUMMONDMG_;

	public const int PROJECTILEDMGFieldNumber = 67;

	private int pROJECTILEDMG_;

	public const int RCDPROJECTILEDMGFieldNumber = 68;

	private int rCDPROJECTILEDMG_;

	public const int GENDMGFieldNumber = 69;

	private int gENDMG_;

	public const int DMGPLUSFieldNumber = 70;

	private int dMGPLUS_;

	public const int FINALDMGFieldNumber = 71;

	private int fINALDMG_;

	public const int FINALDMGPLUSFieldNumber = 72;

	private int fINALDMGPLUS_;

	public const int WEERCDFieldNumber = 73;

	private int wEERCD_;

	public const int FEERCDFieldNumber = 74;

	private int fEERCD_;

	public const int SEERCDFieldNumber = 75;

	private int sEERCD_;

	public const int AEERCDFieldNumber = 76;

	private int aEERCD_;

	public const int LEERCDFieldNumber = 77;

	private int lEERCD_;

	public const int DEERCDFieldNumber = 78;

	private int dEERCD_;

	public const int GENDMGRCDFieldNumber = 79;

	private int gENDMGRCD_;

	public const int DMGPLUSRCDFieldNumber = 80;

	private int dMGPLUSRCD_;

	[DebuggerNonUserCode]
	public static MessageParser<DiscExtraAttribute> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(274);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public string Id
	{
		get
		{
			return id_;
		}
		set
		{
			id_ = ProtoPreconditions.CheckNotNull(value, "value");
		}
	}

	[DebuggerNonUserCode]
	public int GroupId
	{
		get
		{
			return groupId_;
		}
		set
		{
			groupId_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Break
	{
		get
		{
			return break_;
		}
		set
		{
			break_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Atk
	{
		get
		{
			return atk_;
		}
		set
		{
			atk_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Hp
	{
		get
		{
			return hp_;
		}
		set
		{
			hp_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Def
	{
		get
		{
			return def_;
		}
		set
		{
			def_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CritRate
	{
		get
		{
			return critRate_;
		}
		set
		{
			critRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NormalCritRate
	{
		get
		{
			return normalCritRate_;
		}
		set
		{
			normalCritRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillCritRate
	{
		get
		{
			return skillCritRate_;
		}
		set
		{
			skillCritRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UltraCritRate
	{
		get
		{
			return ultraCritRate_;
		}
		set
		{
			ultraCritRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MarkCritRate
	{
		get
		{
			return markCritRate_;
		}
		set
		{
			markCritRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SummonCritRate
	{
		get
		{
			return summonCritRate_;
		}
		set
		{
			summonCritRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ProjectileCritRate
	{
		get
		{
			return projectileCritRate_;
		}
		set
		{
			projectileCritRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OtherCritRate
	{
		get
		{
			return otherCritRate_;
		}
		set
		{
			otherCritRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CritResistance
	{
		get
		{
			return critResistance_;
		}
		set
		{
			critResistance_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int CritPower
	{
		get
		{
			return critPower_;
		}
		set
		{
			critPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NormalCritPower
	{
		get
		{
			return normalCritPower_;
		}
		set
		{
			normalCritPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SkillCritPower
	{
		get
		{
			return skillCritPower_;
		}
		set
		{
			skillCritPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int UltraCritPower
	{
		get
		{
			return ultraCritPower_;
		}
		set
		{
			ultraCritPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MarkCritPower
	{
		get
		{
			return markCritPower_;
		}
		set
		{
			markCritPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SummonCritPower
	{
		get
		{
			return summonCritPower_;
		}
		set
		{
			summonCritPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ProjectileCritPower
	{
		get
		{
			return projectileCritPower_;
		}
		set
		{
			projectileCritPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OtherCritPower
	{
		get
		{
			return otherCritPower_;
		}
		set
		{
			otherCritPower_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int HitRate
	{
		get
		{
			return hitRate_;
		}
		set
		{
			hitRate_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Evd
	{
		get
		{
			return evd_;
		}
		set
		{
			evd_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DefPierce
	{
		get
		{
			return defPierce_;
		}
		set
		{
			defPierce_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DefIgnore
	{
		get
		{
			return defIgnore_;
		}
		set
		{
			defIgnore_ = value;
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
	public int WEI
	{
		get
		{
			return wEI_;
		}
		set
		{
			wEI_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FEI
	{
		get
		{
			return fEI_;
		}
		set
		{
			fEI_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SEI
	{
		get
		{
			return sEI_;
		}
		set
		{
			sEI_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AEI
	{
		get
		{
			return aEI_;
		}
		set
		{
			aEI_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LEI
	{
		get
		{
			return lEI_;
		}
		set
		{
			lEI_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DEI
	{
		get
		{
			return dEI_;
		}
		set
		{
			dEI_ = value;
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
	public int ToughnessDamageAdjust
	{
		get
		{
			return toughnessDamageAdjust_;
		}
		set
		{
			toughnessDamageAdjust_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Toughness
	{
		get
		{
			return toughness_;
		}
		set
		{
			toughness_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int Suppress
	{
		get
		{
			return suppress_;
		}
		set
		{
			suppress_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int NORMALDMG
	{
		get
		{
			return nORMALDMG_;
		}
		set
		{
			nORMALDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SKILLDMG
	{
		get
		{
			return sKILLDMG_;
		}
		set
		{
			sKILLDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int ULTRADMG
	{
		get
		{
			return uLTRADMG_;
		}
		set
		{
			uLTRADMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int OTHERDMG
	{
		get
		{
			return oTHERDMG_;
		}
		set
		{
			oTHERDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RCDNORMALDMG
	{
		get
		{
			return rCDNORMALDMG_;
		}
		set
		{
			rCDNORMALDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RCDSKILLDMG
	{
		get
		{
			return rCDSKILLDMG_;
		}
		set
		{
			rCDSKILLDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RCDULTRADMG
	{
		get
		{
			return rCDULTRADMG_;
		}
		set
		{
			rCDULTRADMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RCDOTHERDMG
	{
		get
		{
			return rCDOTHERDMG_;
		}
		set
		{
			rCDOTHERDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int MARKDMG
	{
		get
		{
			return mARKDMG_;
		}
		set
		{
			mARKDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RCDMARKDMG
	{
		get
		{
			return rCDMARKDMG_;
		}
		set
		{
			rCDMARKDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SUMMONDMG
	{
		get
		{
			return sUMMONDMG_;
		}
		set
		{
			sUMMONDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RCDSUMMONDMG
	{
		get
		{
			return rCDSUMMONDMG_;
		}
		set
		{
			rCDSUMMONDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int PROJECTILEDMG
	{
		get
		{
			return pROJECTILEDMG_;
		}
		set
		{
			pROJECTILEDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int RCDPROJECTILEDMG
	{
		get
		{
			return rCDPROJECTILEDMG_;
		}
		set
		{
			rCDPROJECTILEDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GENDMG
	{
		get
		{
			return gENDMG_;
		}
		set
		{
			gENDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DMGPLUS
	{
		get
		{
			return dMGPLUS_;
		}
		set
		{
			dMGPLUS_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FINALDMG
	{
		get
		{
			return fINALDMG_;
		}
		set
		{
			fINALDMG_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FINALDMGPLUS
	{
		get
		{
			return fINALDMGPLUS_;
		}
		set
		{
			fINALDMGPLUS_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int WEERCD
	{
		get
		{
			return wEERCD_;
		}
		set
		{
			wEERCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int FEERCD
	{
		get
		{
			return fEERCD_;
		}
		set
		{
			fEERCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int SEERCD
	{
		get
		{
			return sEERCD_;
		}
		set
		{
			sEERCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int AEERCD
	{
		get
		{
			return aEERCD_;
		}
		set
		{
			aEERCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int LEERCD
	{
		get
		{
			return lEERCD_;
		}
		set
		{
			lEERCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DEERCD
	{
		get
		{
			return dEERCD_;
		}
		set
		{
			dEERCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int GENDMGRCD
	{
		get
		{
			return gENDMGRCD_;
		}
		set
		{
			gENDMGRCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public int DMGPLUSRCD
	{
		get
		{
			return dMGPLUSRCD_;
		}
		set
		{
			dMGPLUSRCD_ = value;
		}
	}

	[DebuggerNonUserCode]
	public DiscExtraAttribute()
	{
	}

	[DebuggerNonUserCode]
	public DiscExtraAttribute(DiscExtraAttribute other)
		: this()
	{
		id_ = other.id_;
		groupId_ = other.groupId_;
		break_ = other.break_;
		atk_ = other.atk_;
		hp_ = other.hp_;
		def_ = other.def_;
		critRate_ = other.critRate_;
		normalCritRate_ = other.normalCritRate_;
		skillCritRate_ = other.skillCritRate_;
		ultraCritRate_ = other.ultraCritRate_;
		markCritRate_ = other.markCritRate_;
		summonCritRate_ = other.summonCritRate_;
		projectileCritRate_ = other.projectileCritRate_;
		otherCritRate_ = other.otherCritRate_;
		critResistance_ = other.critResistance_;
		critPower_ = other.critPower_;
		normalCritPower_ = other.normalCritPower_;
		skillCritPower_ = other.skillCritPower_;
		ultraCritPower_ = other.ultraCritPower_;
		markCritPower_ = other.markCritPower_;
		summonCritPower_ = other.summonCritPower_;
		projectileCritPower_ = other.projectileCritPower_;
		otherCritPower_ = other.otherCritPower_;
		hitRate_ = other.hitRate_;
		evd_ = other.evd_;
		defPierce_ = other.defPierce_;
		defIgnore_ = other.defIgnore_;
		wEP_ = other.wEP_;
		fEP_ = other.fEP_;
		sEP_ = other.sEP_;
		aEP_ = other.aEP_;
		lEP_ = other.lEP_;
		dEP_ = other.dEP_;
		wEI_ = other.wEI_;
		fEI_ = other.fEI_;
		sEI_ = other.sEI_;
		aEI_ = other.aEI_;
		lEI_ = other.lEI_;
		dEI_ = other.dEI_;
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
		toughnessDamageAdjust_ = other.toughnessDamageAdjust_;
		toughness_ = other.toughness_;
		suppress_ = other.suppress_;
		nORMALDMG_ = other.nORMALDMG_;
		sKILLDMG_ = other.sKILLDMG_;
		uLTRADMG_ = other.uLTRADMG_;
		oTHERDMG_ = other.oTHERDMG_;
		rCDNORMALDMG_ = other.rCDNORMALDMG_;
		rCDSKILLDMG_ = other.rCDSKILLDMG_;
		rCDULTRADMG_ = other.rCDULTRADMG_;
		rCDOTHERDMG_ = other.rCDOTHERDMG_;
		mARKDMG_ = other.mARKDMG_;
		rCDMARKDMG_ = other.rCDMARKDMG_;
		sUMMONDMG_ = other.sUMMONDMG_;
		rCDSUMMONDMG_ = other.rCDSUMMONDMG_;
		pROJECTILEDMG_ = other.pROJECTILEDMG_;
		rCDPROJECTILEDMG_ = other.rCDPROJECTILEDMG_;
		gENDMG_ = other.gENDMG_;
		dMGPLUS_ = other.dMGPLUS_;
		fINALDMG_ = other.fINALDMG_;
		fINALDMGPLUS_ = other.fINALDMGPLUS_;
		wEERCD_ = other.wEERCD_;
		fEERCD_ = other.fEERCD_;
		sEERCD_ = other.sEERCD_;
		aEERCD_ = other.aEERCD_;
		lEERCD_ = other.lEERCD_;
		dEERCD_ = other.dEERCD_;
		gENDMGRCD_ = other.gENDMGRCD_;
		dMGPLUSRCD_ = other.dMGPLUSRCD_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public DiscExtraAttribute Clone()
	{
		return new DiscExtraAttribute(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as DiscExtraAttribute);
	}

	[DebuggerNonUserCode]
	public bool Equals(DiscExtraAttribute other)
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
		if (GroupId != other.GroupId)
		{
			return false;
		}
		if (Break != other.Break)
		{
			return false;
		}
		if (Atk != other.Atk)
		{
			return false;
		}
		if (Hp != other.Hp)
		{
			return false;
		}
		if (Def != other.Def)
		{
			return false;
		}
		if (CritRate != other.CritRate)
		{
			return false;
		}
		if (NormalCritRate != other.NormalCritRate)
		{
			return false;
		}
		if (SkillCritRate != other.SkillCritRate)
		{
			return false;
		}
		if (UltraCritRate != other.UltraCritRate)
		{
			return false;
		}
		if (MarkCritRate != other.MarkCritRate)
		{
			return false;
		}
		if (SummonCritRate != other.SummonCritRate)
		{
			return false;
		}
		if (ProjectileCritRate != other.ProjectileCritRate)
		{
			return false;
		}
		if (OtherCritRate != other.OtherCritRate)
		{
			return false;
		}
		if (CritResistance != other.CritResistance)
		{
			return false;
		}
		if (CritPower != other.CritPower)
		{
			return false;
		}
		if (NormalCritPower != other.NormalCritPower)
		{
			return false;
		}
		if (SkillCritPower != other.SkillCritPower)
		{
			return false;
		}
		if (UltraCritPower != other.UltraCritPower)
		{
			return false;
		}
		if (MarkCritPower != other.MarkCritPower)
		{
			return false;
		}
		if (SummonCritPower != other.SummonCritPower)
		{
			return false;
		}
		if (ProjectileCritPower != other.ProjectileCritPower)
		{
			return false;
		}
		if (OtherCritPower != other.OtherCritPower)
		{
			return false;
		}
		if (HitRate != other.HitRate)
		{
			return false;
		}
		if (Evd != other.Evd)
		{
			return false;
		}
		if (DefPierce != other.DefPierce)
		{
			return false;
		}
		if (DefIgnore != other.DefIgnore)
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
		if (WEI != other.WEI)
		{
			return false;
		}
		if (FEI != other.FEI)
		{
			return false;
		}
		if (SEI != other.SEI)
		{
			return false;
		}
		if (AEI != other.AEI)
		{
			return false;
		}
		if (LEI != other.LEI)
		{
			return false;
		}
		if (DEI != other.DEI)
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
		if (ToughnessDamageAdjust != other.ToughnessDamageAdjust)
		{
			return false;
		}
		if (Toughness != other.Toughness)
		{
			return false;
		}
		if (Suppress != other.Suppress)
		{
			return false;
		}
		if (NORMALDMG != other.NORMALDMG)
		{
			return false;
		}
		if (SKILLDMG != other.SKILLDMG)
		{
			return false;
		}
		if (ULTRADMG != other.ULTRADMG)
		{
			return false;
		}
		if (OTHERDMG != other.OTHERDMG)
		{
			return false;
		}
		if (RCDNORMALDMG != other.RCDNORMALDMG)
		{
			return false;
		}
		if (RCDSKILLDMG != other.RCDSKILLDMG)
		{
			return false;
		}
		if (RCDULTRADMG != other.RCDULTRADMG)
		{
			return false;
		}
		if (RCDOTHERDMG != other.RCDOTHERDMG)
		{
			return false;
		}
		if (MARKDMG != other.MARKDMG)
		{
			return false;
		}
		if (RCDMARKDMG != other.RCDMARKDMG)
		{
			return false;
		}
		if (SUMMONDMG != other.SUMMONDMG)
		{
			return false;
		}
		if (RCDSUMMONDMG != other.RCDSUMMONDMG)
		{
			return false;
		}
		if (PROJECTILEDMG != other.PROJECTILEDMG)
		{
			return false;
		}
		if (RCDPROJECTILEDMG != other.RCDPROJECTILEDMG)
		{
			return false;
		}
		if (GENDMG != other.GENDMG)
		{
			return false;
		}
		if (DMGPLUS != other.DMGPLUS)
		{
			return false;
		}
		if (FINALDMG != other.FINALDMG)
		{
			return false;
		}
		if (FINALDMGPLUS != other.FINALDMGPLUS)
		{
			return false;
		}
		if (WEERCD != other.WEERCD)
		{
			return false;
		}
		if (FEERCD != other.FEERCD)
		{
			return false;
		}
		if (SEERCD != other.SEERCD)
		{
			return false;
		}
		if (AEERCD != other.AEERCD)
		{
			return false;
		}
		if (LEERCD != other.LEERCD)
		{
			return false;
		}
		if (DEERCD != other.DEERCD)
		{
			return false;
		}
		if (GENDMGRCD != other.GENDMGRCD)
		{
			return false;
		}
		if (DMGPLUSRCD != other.DMGPLUSRCD)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id.Length != 0)
		{
			num ^= Id.GetHashCode();
		}
		if (GroupId != 0)
		{
			num ^= GroupId.GetHashCode();
		}
		if (Break != 0)
		{
			num ^= Break.GetHashCode();
		}
		if (Atk != 0)
		{
			num ^= Atk.GetHashCode();
		}
		if (Hp != 0)
		{
			num ^= Hp.GetHashCode();
		}
		if (Def != 0)
		{
			num ^= Def.GetHashCode();
		}
		if (CritRate != 0)
		{
			num ^= CritRate.GetHashCode();
		}
		if (NormalCritRate != 0)
		{
			num ^= NormalCritRate.GetHashCode();
		}
		if (SkillCritRate != 0)
		{
			num ^= SkillCritRate.GetHashCode();
		}
		if (UltraCritRate != 0)
		{
			num ^= UltraCritRate.GetHashCode();
		}
		if (MarkCritRate != 0)
		{
			num ^= MarkCritRate.GetHashCode();
		}
		if (SummonCritRate != 0)
		{
			num ^= SummonCritRate.GetHashCode();
		}
		if (ProjectileCritRate != 0)
		{
			num ^= ProjectileCritRate.GetHashCode();
		}
		if (OtherCritRate != 0)
		{
			num ^= OtherCritRate.GetHashCode();
		}
		if (CritResistance != 0)
		{
			num ^= CritResistance.GetHashCode();
		}
		if (CritPower != 0)
		{
			num ^= CritPower.GetHashCode();
		}
		if (NormalCritPower != 0)
		{
			num ^= NormalCritPower.GetHashCode();
		}
		if (SkillCritPower != 0)
		{
			num ^= SkillCritPower.GetHashCode();
		}
		if (UltraCritPower != 0)
		{
			num ^= UltraCritPower.GetHashCode();
		}
		if (MarkCritPower != 0)
		{
			num ^= MarkCritPower.GetHashCode();
		}
		if (SummonCritPower != 0)
		{
			num ^= SummonCritPower.GetHashCode();
		}
		if (ProjectileCritPower != 0)
		{
			num ^= ProjectileCritPower.GetHashCode();
		}
		if (OtherCritPower != 0)
		{
			num ^= OtherCritPower.GetHashCode();
		}
		if (HitRate != 0)
		{
			num ^= HitRate.GetHashCode();
		}
		if (Evd != 0)
		{
			num ^= Evd.GetHashCode();
		}
		if (DefPierce != 0)
		{
			num ^= DefPierce.GetHashCode();
		}
		if (DefIgnore != 0)
		{
			num ^= DefIgnore.GetHashCode();
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
		if (WEI != 0)
		{
			num ^= WEI.GetHashCode();
		}
		if (FEI != 0)
		{
			num ^= FEI.GetHashCode();
		}
		if (SEI != 0)
		{
			num ^= SEI.GetHashCode();
		}
		if (AEI != 0)
		{
			num ^= AEI.GetHashCode();
		}
		if (LEI != 0)
		{
			num ^= LEI.GetHashCode();
		}
		if (DEI != 0)
		{
			num ^= DEI.GetHashCode();
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
		if (ToughnessDamageAdjust != 0)
		{
			num ^= ToughnessDamageAdjust.GetHashCode();
		}
		if (Toughness != 0)
		{
			num ^= Toughness.GetHashCode();
		}
		if (Suppress != 0)
		{
			num ^= Suppress.GetHashCode();
		}
		if (NORMALDMG != 0)
		{
			num ^= NORMALDMG.GetHashCode();
		}
		if (SKILLDMG != 0)
		{
			num ^= SKILLDMG.GetHashCode();
		}
		if (ULTRADMG != 0)
		{
			num ^= ULTRADMG.GetHashCode();
		}
		if (OTHERDMG != 0)
		{
			num ^= OTHERDMG.GetHashCode();
		}
		if (RCDNORMALDMG != 0)
		{
			num ^= RCDNORMALDMG.GetHashCode();
		}
		if (RCDSKILLDMG != 0)
		{
			num ^= RCDSKILLDMG.GetHashCode();
		}
		if (RCDULTRADMG != 0)
		{
			num ^= RCDULTRADMG.GetHashCode();
		}
		if (RCDOTHERDMG != 0)
		{
			num ^= RCDOTHERDMG.GetHashCode();
		}
		if (MARKDMG != 0)
		{
			num ^= MARKDMG.GetHashCode();
		}
		if (RCDMARKDMG != 0)
		{
			num ^= RCDMARKDMG.GetHashCode();
		}
		if (SUMMONDMG != 0)
		{
			num ^= SUMMONDMG.GetHashCode();
		}
		if (RCDSUMMONDMG != 0)
		{
			num ^= RCDSUMMONDMG.GetHashCode();
		}
		if (PROJECTILEDMG != 0)
		{
			num ^= PROJECTILEDMG.GetHashCode();
		}
		if (RCDPROJECTILEDMG != 0)
		{
			num ^= RCDPROJECTILEDMG.GetHashCode();
		}
		if (GENDMG != 0)
		{
			num ^= GENDMG.GetHashCode();
		}
		if (DMGPLUS != 0)
		{
			num ^= DMGPLUS.GetHashCode();
		}
		if (FINALDMG != 0)
		{
			num ^= FINALDMG.GetHashCode();
		}
		if (FINALDMGPLUS != 0)
		{
			num ^= FINALDMGPLUS.GetHashCode();
		}
		if (WEERCD != 0)
		{
			num ^= WEERCD.GetHashCode();
		}
		if (FEERCD != 0)
		{
			num ^= FEERCD.GetHashCode();
		}
		if (SEERCD != 0)
		{
			num ^= SEERCD.GetHashCode();
		}
		if (AEERCD != 0)
		{
			num ^= AEERCD.GetHashCode();
		}
		if (LEERCD != 0)
		{
			num ^= LEERCD.GetHashCode();
		}
		if (DEERCD != 0)
		{
			num ^= DEERCD.GetHashCode();
		}
		if (GENDMGRCD != 0)
		{
			num ^= GENDMGRCD.GetHashCode();
		}
		if (DMGPLUSRCD != 0)
		{
			num ^= DMGPLUSRCD.GetHashCode();
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
		if (Id.Length != 0)
		{
			output.WriteRawTag(10);
			output.WriteString(Id);
		}
		if (GroupId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(GroupId);
		}
		if (Break != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Break);
		}
		if (Atk != 0)
		{
			output.WriteRawTag(32);
			output.WriteInt32(Atk);
		}
		if (Hp != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Hp);
		}
		if (Def != 0)
		{
			output.WriteRawTag(48);
			output.WriteInt32(Def);
		}
		if (CritRate != 0)
		{
			output.WriteRawTag(56);
			output.WriteInt32(CritRate);
		}
		if (NormalCritRate != 0)
		{
			output.WriteRawTag(64);
			output.WriteInt32(NormalCritRate);
		}
		if (SkillCritRate != 0)
		{
			output.WriteRawTag(72);
			output.WriteInt32(SkillCritRate);
		}
		if (UltraCritRate != 0)
		{
			output.WriteRawTag(80);
			output.WriteInt32(UltraCritRate);
		}
		if (MarkCritRate != 0)
		{
			output.WriteRawTag(88);
			output.WriteInt32(MarkCritRate);
		}
		if (SummonCritRate != 0)
		{
			output.WriteRawTag(96);
			output.WriteInt32(SummonCritRate);
		}
		if (ProjectileCritRate != 0)
		{
			output.WriteRawTag(104);
			output.WriteInt32(ProjectileCritRate);
		}
		if (OtherCritRate != 0)
		{
			output.WriteRawTag(112);
			output.WriteInt32(OtherCritRate);
		}
		if (CritResistance != 0)
		{
			output.WriteRawTag(120);
			output.WriteInt32(CritResistance);
		}
		if (CritPower != 0)
		{
			output.WriteRawTag(128, 1);
			output.WriteInt32(CritPower);
		}
		if (NormalCritPower != 0)
		{
			output.WriteRawTag(136, 1);
			output.WriteInt32(NormalCritPower);
		}
		if (SkillCritPower != 0)
		{
			output.WriteRawTag(144, 1);
			output.WriteInt32(SkillCritPower);
		}
		if (UltraCritPower != 0)
		{
			output.WriteRawTag(152, 1);
			output.WriteInt32(UltraCritPower);
		}
		if (MarkCritPower != 0)
		{
			output.WriteRawTag(160, 1);
			output.WriteInt32(MarkCritPower);
		}
		if (SummonCritPower != 0)
		{
			output.WriteRawTag(168, 1);
			output.WriteInt32(SummonCritPower);
		}
		if (ProjectileCritPower != 0)
		{
			output.WriteRawTag(176, 1);
			output.WriteInt32(ProjectileCritPower);
		}
		if (OtherCritPower != 0)
		{
			output.WriteRawTag(184, 1);
			output.WriteInt32(OtherCritPower);
		}
		if (HitRate != 0)
		{
			output.WriteRawTag(192, 1);
			output.WriteInt32(HitRate);
		}
		if (Evd != 0)
		{
			output.WriteRawTag(200, 1);
			output.WriteInt32(Evd);
		}
		if (DefPierce != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(DefPierce);
		}
		if (DefIgnore != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(DefIgnore);
		}
		if (WEP != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(WEP);
		}
		if (FEP != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(FEP);
		}
		if (SEP != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(SEP);
		}
		if (AEP != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(AEP);
		}
		if (LEP != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(LEP);
		}
		if (DEP != 0)
		{
			output.WriteRawTag(136, 2);
			output.WriteInt32(DEP);
		}
		if (WEI != 0)
		{
			output.WriteRawTag(144, 2);
			output.WriteInt32(WEI);
		}
		if (FEI != 0)
		{
			output.WriteRawTag(152, 2);
			output.WriteInt32(FEI);
		}
		if (SEI != 0)
		{
			output.WriteRawTag(160, 2);
			output.WriteInt32(SEI);
		}
		if (AEI != 0)
		{
			output.WriteRawTag(168, 2);
			output.WriteInt32(AEI);
		}
		if (LEI != 0)
		{
			output.WriteRawTag(176, 2);
			output.WriteInt32(LEI);
		}
		if (DEI != 0)
		{
			output.WriteRawTag(184, 2);
			output.WriteInt32(DEI);
		}
		if (WEE != 0)
		{
			output.WriteRawTag(192, 2);
			output.WriteInt32(WEE);
		}
		if (FEE != 0)
		{
			output.WriteRawTag(200, 2);
			output.WriteInt32(FEE);
		}
		if (SEE != 0)
		{
			output.WriteRawTag(208, 2);
			output.WriteInt32(SEE);
		}
		if (AEE != 0)
		{
			output.WriteRawTag(216, 2);
			output.WriteInt32(AEE);
		}
		if (LEE != 0)
		{
			output.WriteRawTag(224, 2);
			output.WriteInt32(LEE);
		}
		if (DEE != 0)
		{
			output.WriteRawTag(232, 2);
			output.WriteInt32(DEE);
		}
		if (WER != 0)
		{
			output.WriteRawTag(240, 2);
			output.WriteInt32(WER);
		}
		if (FER != 0)
		{
			output.WriteRawTag(248, 2);
			output.WriteInt32(FER);
		}
		if (SER != 0)
		{
			output.WriteRawTag(128, 3);
			output.WriteInt32(SER);
		}
		if (AER != 0)
		{
			output.WriteRawTag(136, 3);
			output.WriteInt32(AER);
		}
		if (LER != 0)
		{
			output.WriteRawTag(144, 3);
			output.WriteInt32(LER);
		}
		if (DER != 0)
		{
			output.WriteRawTag(152, 3);
			output.WriteInt32(DER);
		}
		if (ToughnessDamageAdjust != 0)
		{
			output.WriteRawTag(160, 3);
			output.WriteInt32(ToughnessDamageAdjust);
		}
		if (Toughness != 0)
		{
			output.WriteRawTag(168, 3);
			output.WriteInt32(Toughness);
		}
		if (Suppress != 0)
		{
			output.WriteRawTag(176, 3);
			output.WriteInt32(Suppress);
		}
		if (NORMALDMG != 0)
		{
			output.WriteRawTag(184, 3);
			output.WriteInt32(NORMALDMG);
		}
		if (SKILLDMG != 0)
		{
			output.WriteRawTag(192, 3);
			output.WriteInt32(SKILLDMG);
		}
		if (ULTRADMG != 0)
		{
			output.WriteRawTag(200, 3);
			output.WriteInt32(ULTRADMG);
		}
		if (OTHERDMG != 0)
		{
			output.WriteRawTag(208, 3);
			output.WriteInt32(OTHERDMG);
		}
		if (RCDNORMALDMG != 0)
		{
			output.WriteRawTag(216, 3);
			output.WriteInt32(RCDNORMALDMG);
		}
		if (RCDSKILLDMG != 0)
		{
			output.WriteRawTag(224, 3);
			output.WriteInt32(RCDSKILLDMG);
		}
		if (RCDULTRADMG != 0)
		{
			output.WriteRawTag(232, 3);
			output.WriteInt32(RCDULTRADMG);
		}
		if (RCDOTHERDMG != 0)
		{
			output.WriteRawTag(240, 3);
			output.WriteInt32(RCDOTHERDMG);
		}
		if (MARKDMG != 0)
		{
			output.WriteRawTag(248, 3);
			output.WriteInt32(MARKDMG);
		}
		if (RCDMARKDMG != 0)
		{
			output.WriteRawTag(128, 4);
			output.WriteInt32(RCDMARKDMG);
		}
		if (SUMMONDMG != 0)
		{
			output.WriteRawTag(136, 4);
			output.WriteInt32(SUMMONDMG);
		}
		if (RCDSUMMONDMG != 0)
		{
			output.WriteRawTag(144, 4);
			output.WriteInt32(RCDSUMMONDMG);
		}
		if (PROJECTILEDMG != 0)
		{
			output.WriteRawTag(152, 4);
			output.WriteInt32(PROJECTILEDMG);
		}
		if (RCDPROJECTILEDMG != 0)
		{
			output.WriteRawTag(160, 4);
			output.WriteInt32(RCDPROJECTILEDMG);
		}
		if (GENDMG != 0)
		{
			output.WriteRawTag(168, 4);
			output.WriteInt32(GENDMG);
		}
		if (DMGPLUS != 0)
		{
			output.WriteRawTag(176, 4);
			output.WriteInt32(DMGPLUS);
		}
		if (FINALDMG != 0)
		{
			output.WriteRawTag(184, 4);
			output.WriteInt32(FINALDMG);
		}
		if (FINALDMGPLUS != 0)
		{
			output.WriteRawTag(192, 4);
			output.WriteInt32(FINALDMGPLUS);
		}
		if (WEERCD != 0)
		{
			output.WriteRawTag(200, 4);
			output.WriteInt32(WEERCD);
		}
		if (FEERCD != 0)
		{
			output.WriteRawTag(208, 4);
			output.WriteInt32(FEERCD);
		}
		if (SEERCD != 0)
		{
			output.WriteRawTag(216, 4);
			output.WriteInt32(SEERCD);
		}
		if (AEERCD != 0)
		{
			output.WriteRawTag(224, 4);
			output.WriteInt32(AEERCD);
		}
		if (LEERCD != 0)
		{
			output.WriteRawTag(232, 4);
			output.WriteInt32(LEERCD);
		}
		if (DEERCD != 0)
		{
			output.WriteRawTag(240, 4);
			output.WriteInt32(DEERCD);
		}
		if (GENDMGRCD != 0)
		{
			output.WriteRawTag(248, 4);
			output.WriteInt32(GENDMGRCD);
		}
		if (DMGPLUSRCD != 0)
		{
			output.WriteRawTag(128, 5);
			output.WriteInt32(DMGPLUSRCD);
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
		if (Id.Length != 0)
		{
			num += 1 + CodedOutputStream.ComputeStringSize(Id);
		}
		if (GroupId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(GroupId);
		}
		if (Break != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Break);
		}
		if (Atk != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Atk);
		}
		if (Hp != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Hp);
		}
		if (Def != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Def);
		}
		if (CritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CritRate);
		}
		if (NormalCritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(NormalCritRate);
		}
		if (SkillCritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SkillCritRate);
		}
		if (UltraCritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(UltraCritRate);
		}
		if (MarkCritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(MarkCritRate);
		}
		if (SummonCritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(SummonCritRate);
		}
		if (ProjectileCritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(ProjectileCritRate);
		}
		if (OtherCritRate != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(OtherCritRate);
		}
		if (CritResistance != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(CritResistance);
		}
		if (CritPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(CritPower);
		}
		if (NormalCritPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NormalCritPower);
		}
		if (SkillCritPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SkillCritPower);
		}
		if (UltraCritPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(UltraCritPower);
		}
		if (MarkCritPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MarkCritPower);
		}
		if (SummonCritPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SummonCritPower);
		}
		if (ProjectileCritPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ProjectileCritPower);
		}
		if (OtherCritPower != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(OtherCritPower);
		}
		if (HitRate != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(HitRate);
		}
		if (Evd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Evd);
		}
		if (DefPierce != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DefPierce);
		}
		if (DefIgnore != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DefIgnore);
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
		if (WEI != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WEI);
		}
		if (FEI != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FEI);
		}
		if (SEI != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SEI);
		}
		if (AEI != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AEI);
		}
		if (LEI != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LEI);
		}
		if (DEI != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DEI);
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
		if (ToughnessDamageAdjust != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ToughnessDamageAdjust);
		}
		if (Toughness != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Toughness);
		}
		if (Suppress != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Suppress);
		}
		if (NORMALDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(NORMALDMG);
		}
		if (SKILLDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SKILLDMG);
		}
		if (ULTRADMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(ULTRADMG);
		}
		if (OTHERDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(OTHERDMG);
		}
		if (RCDNORMALDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RCDNORMALDMG);
		}
		if (RCDSKILLDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RCDSKILLDMG);
		}
		if (RCDULTRADMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RCDULTRADMG);
		}
		if (RCDOTHERDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RCDOTHERDMG);
		}
		if (MARKDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(MARKDMG);
		}
		if (RCDMARKDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RCDMARKDMG);
		}
		if (SUMMONDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SUMMONDMG);
		}
		if (RCDSUMMONDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RCDSUMMONDMG);
		}
		if (PROJECTILEDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(PROJECTILEDMG);
		}
		if (RCDPROJECTILEDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RCDPROJECTILEDMG);
		}
		if (GENDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GENDMG);
		}
		if (DMGPLUS != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DMGPLUS);
		}
		if (FINALDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FINALDMG);
		}
		if (FINALDMGPLUS != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FINALDMGPLUS);
		}
		if (WEERCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(WEERCD);
		}
		if (FEERCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(FEERCD);
		}
		if (SEERCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(SEERCD);
		}
		if (AEERCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AEERCD);
		}
		if (LEERCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(LEERCD);
		}
		if (DEERCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DEERCD);
		}
		if (GENDMGRCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(GENDMGRCD);
		}
		if (DMGPLUSRCD != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(DMGPLUSRCD);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(DiscExtraAttribute other)
	{
		if (other != null)
		{
			if (other.Id.Length != 0)
			{
				Id = other.Id;
			}
			if (other.GroupId != 0)
			{
				GroupId = other.GroupId;
			}
			if (other.Break != 0)
			{
				Break = other.Break;
			}
			if (other.Atk != 0)
			{
				Atk = other.Atk;
			}
			if (other.Hp != 0)
			{
				Hp = other.Hp;
			}
			if (other.Def != 0)
			{
				Def = other.Def;
			}
			if (other.CritRate != 0)
			{
				CritRate = other.CritRate;
			}
			if (other.NormalCritRate != 0)
			{
				NormalCritRate = other.NormalCritRate;
			}
			if (other.SkillCritRate != 0)
			{
				SkillCritRate = other.SkillCritRate;
			}
			if (other.UltraCritRate != 0)
			{
				UltraCritRate = other.UltraCritRate;
			}
			if (other.MarkCritRate != 0)
			{
				MarkCritRate = other.MarkCritRate;
			}
			if (other.SummonCritRate != 0)
			{
				SummonCritRate = other.SummonCritRate;
			}
			if (other.ProjectileCritRate != 0)
			{
				ProjectileCritRate = other.ProjectileCritRate;
			}
			if (other.OtherCritRate != 0)
			{
				OtherCritRate = other.OtherCritRate;
			}
			if (other.CritResistance != 0)
			{
				CritResistance = other.CritResistance;
			}
			if (other.CritPower != 0)
			{
				CritPower = other.CritPower;
			}
			if (other.NormalCritPower != 0)
			{
				NormalCritPower = other.NormalCritPower;
			}
			if (other.SkillCritPower != 0)
			{
				SkillCritPower = other.SkillCritPower;
			}
			if (other.UltraCritPower != 0)
			{
				UltraCritPower = other.UltraCritPower;
			}
			if (other.MarkCritPower != 0)
			{
				MarkCritPower = other.MarkCritPower;
			}
			if (other.SummonCritPower != 0)
			{
				SummonCritPower = other.SummonCritPower;
			}
			if (other.ProjectileCritPower != 0)
			{
				ProjectileCritPower = other.ProjectileCritPower;
			}
			if (other.OtherCritPower != 0)
			{
				OtherCritPower = other.OtherCritPower;
			}
			if (other.HitRate != 0)
			{
				HitRate = other.HitRate;
			}
			if (other.Evd != 0)
			{
				Evd = other.Evd;
			}
			if (other.DefPierce != 0)
			{
				DefPierce = other.DefPierce;
			}
			if (other.DefIgnore != 0)
			{
				DefIgnore = other.DefIgnore;
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
			if (other.WEI != 0)
			{
				WEI = other.WEI;
			}
			if (other.FEI != 0)
			{
				FEI = other.FEI;
			}
			if (other.SEI != 0)
			{
				SEI = other.SEI;
			}
			if (other.AEI != 0)
			{
				AEI = other.AEI;
			}
			if (other.LEI != 0)
			{
				LEI = other.LEI;
			}
			if (other.DEI != 0)
			{
				DEI = other.DEI;
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
			if (other.ToughnessDamageAdjust != 0)
			{
				ToughnessDamageAdjust = other.ToughnessDamageAdjust;
			}
			if (other.Toughness != 0)
			{
				Toughness = other.Toughness;
			}
			if (other.Suppress != 0)
			{
				Suppress = other.Suppress;
			}
			if (other.NORMALDMG != 0)
			{
				NORMALDMG = other.NORMALDMG;
			}
			if (other.SKILLDMG != 0)
			{
				SKILLDMG = other.SKILLDMG;
			}
			if (other.ULTRADMG != 0)
			{
				ULTRADMG = other.ULTRADMG;
			}
			if (other.OTHERDMG != 0)
			{
				OTHERDMG = other.OTHERDMG;
			}
			if (other.RCDNORMALDMG != 0)
			{
				RCDNORMALDMG = other.RCDNORMALDMG;
			}
			if (other.RCDSKILLDMG != 0)
			{
				RCDSKILLDMG = other.RCDSKILLDMG;
			}
			if (other.RCDULTRADMG != 0)
			{
				RCDULTRADMG = other.RCDULTRADMG;
			}
			if (other.RCDOTHERDMG != 0)
			{
				RCDOTHERDMG = other.RCDOTHERDMG;
			}
			if (other.MARKDMG != 0)
			{
				MARKDMG = other.MARKDMG;
			}
			if (other.RCDMARKDMG != 0)
			{
				RCDMARKDMG = other.RCDMARKDMG;
			}
			if (other.SUMMONDMG != 0)
			{
				SUMMONDMG = other.SUMMONDMG;
			}
			if (other.RCDSUMMONDMG != 0)
			{
				RCDSUMMONDMG = other.RCDSUMMONDMG;
			}
			if (other.PROJECTILEDMG != 0)
			{
				PROJECTILEDMG = other.PROJECTILEDMG;
			}
			if (other.RCDPROJECTILEDMG != 0)
			{
				RCDPROJECTILEDMG = other.RCDPROJECTILEDMG;
			}
			if (other.GENDMG != 0)
			{
				GENDMG = other.GENDMG;
			}
			if (other.DMGPLUS != 0)
			{
				DMGPLUS = other.DMGPLUS;
			}
			if (other.FINALDMG != 0)
			{
				FINALDMG = other.FINALDMG;
			}
			if (other.FINALDMGPLUS != 0)
			{
				FINALDMGPLUS = other.FINALDMGPLUS;
			}
			if (other.WEERCD != 0)
			{
				WEERCD = other.WEERCD;
			}
			if (other.FEERCD != 0)
			{
				FEERCD = other.FEERCD;
			}
			if (other.SEERCD != 0)
			{
				SEERCD = other.SEERCD;
			}
			if (other.AEERCD != 0)
			{
				AEERCD = other.AEERCD;
			}
			if (other.LEERCD != 0)
			{
				LEERCD = other.LEERCD;
			}
			if (other.DEERCD != 0)
			{
				DEERCD = other.DEERCD;
			}
			if (other.GENDMGRCD != 0)
			{
				GENDMGRCD = other.GENDMGRCD;
			}
			if (other.DMGPLUSRCD != 0)
			{
				DMGPLUSRCD = other.DMGPLUSRCD;
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
			case 10u:
				Id = input.ReadString();
				break;
			case 16u:
				GroupId = input.ReadInt32();
				break;
			case 24u:
				Break = input.ReadInt32();
				break;
			case 32u:
				Atk = input.ReadInt32();
				break;
			case 40u:
				Hp = input.ReadInt32();
				break;
			case 48u:
				Def = input.ReadInt32();
				break;
			case 56u:
				CritRate = input.ReadInt32();
				break;
			case 64u:
				NormalCritRate = input.ReadInt32();
				break;
			case 72u:
				SkillCritRate = input.ReadInt32();
				break;
			case 80u:
				UltraCritRate = input.ReadInt32();
				break;
			case 88u:
				MarkCritRate = input.ReadInt32();
				break;
			case 96u:
				SummonCritRate = input.ReadInt32();
				break;
			case 104u:
				ProjectileCritRate = input.ReadInt32();
				break;
			case 112u:
				OtherCritRate = input.ReadInt32();
				break;
			case 120u:
				CritResistance = input.ReadInt32();
				break;
			case 128u:
				CritPower = input.ReadInt32();
				break;
			case 136u:
				NormalCritPower = input.ReadInt32();
				break;
			case 144u:
				SkillCritPower = input.ReadInt32();
				break;
			case 152u:
				UltraCritPower = input.ReadInt32();
				break;
			case 160u:
				MarkCritPower = input.ReadInt32();
				break;
			case 168u:
				SummonCritPower = input.ReadInt32();
				break;
			case 176u:
				ProjectileCritPower = input.ReadInt32();
				break;
			case 184u:
				OtherCritPower = input.ReadInt32();
				break;
			case 192u:
				HitRate = input.ReadInt32();
				break;
			case 200u:
				Evd = input.ReadInt32();
				break;
			case 208u:
				DefPierce = input.ReadInt32();
				break;
			case 216u:
				DefIgnore = input.ReadInt32();
				break;
			case 224u:
				WEP = input.ReadInt32();
				break;
			case 232u:
				FEP = input.ReadInt32();
				break;
			case 240u:
				SEP = input.ReadInt32();
				break;
			case 248u:
				AEP = input.ReadInt32();
				break;
			case 256u:
				LEP = input.ReadInt32();
				break;
			case 264u:
				DEP = input.ReadInt32();
				break;
			case 272u:
				WEI = input.ReadInt32();
				break;
			case 280u:
				FEI = input.ReadInt32();
				break;
			case 288u:
				SEI = input.ReadInt32();
				break;
			case 296u:
				AEI = input.ReadInt32();
				break;
			case 304u:
				LEI = input.ReadInt32();
				break;
			case 312u:
				DEI = input.ReadInt32();
				break;
			case 320u:
				WEE = input.ReadInt32();
				break;
			case 328u:
				FEE = input.ReadInt32();
				break;
			case 336u:
				SEE = input.ReadInt32();
				break;
			case 344u:
				AEE = input.ReadInt32();
				break;
			case 352u:
				LEE = input.ReadInt32();
				break;
			case 360u:
				DEE = input.ReadInt32();
				break;
			case 368u:
				WER = input.ReadInt32();
				break;
			case 376u:
				FER = input.ReadInt32();
				break;
			case 384u:
				SER = input.ReadInt32();
				break;
			case 392u:
				AER = input.ReadInt32();
				break;
			case 400u:
				LER = input.ReadInt32();
				break;
			case 408u:
				DER = input.ReadInt32();
				break;
			case 416u:
				ToughnessDamageAdjust = input.ReadInt32();
				break;
			case 424u:
				Toughness = input.ReadInt32();
				break;
			case 432u:
				Suppress = input.ReadInt32();
				break;
			case 440u:
				NORMALDMG = input.ReadInt32();
				break;
			case 448u:
				SKILLDMG = input.ReadInt32();
				break;
			case 456u:
				ULTRADMG = input.ReadInt32();
				break;
			case 464u:
				OTHERDMG = input.ReadInt32();
				break;
			case 472u:
				RCDNORMALDMG = input.ReadInt32();
				break;
			case 480u:
				RCDSKILLDMG = input.ReadInt32();
				break;
			case 488u:
				RCDULTRADMG = input.ReadInt32();
				break;
			case 496u:
				RCDOTHERDMG = input.ReadInt32();
				break;
			case 504u:
				MARKDMG = input.ReadInt32();
				break;
			case 512u:
				RCDMARKDMG = input.ReadInt32();
				break;
			case 520u:
				SUMMONDMG = input.ReadInt32();
				break;
			case 528u:
				RCDSUMMONDMG = input.ReadInt32();
				break;
			case 536u:
				PROJECTILEDMG = input.ReadInt32();
				break;
			case 544u:
				RCDPROJECTILEDMG = input.ReadInt32();
				break;
			case 552u:
				GENDMG = input.ReadInt32();
				break;
			case 560u:
				DMGPLUS = input.ReadInt32();
				break;
			case 568u:
				FINALDMG = input.ReadInt32();
				break;
			case 576u:
				FINALDMGPLUS = input.ReadInt32();
				break;
			case 584u:
				WEERCD = input.ReadInt32();
				break;
			case 592u:
				FEERCD = input.ReadInt32();
				break;
			case 600u:
				SEERCD = input.ReadInt32();
				break;
			case 608u:
				AEERCD = input.ReadInt32();
				break;
			case 616u:
				LEERCD = input.ReadInt32();
				break;
			case 624u:
				DEERCD = input.ReadInt32();
				break;
			case 632u:
				GENDMGRCD = input.ReadInt32();
				break;
			case 640u:
				DMGPLUSRCD = input.ReadInt32();
				break;
			}
		}
	}
}
