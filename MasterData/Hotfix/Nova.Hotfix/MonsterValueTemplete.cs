using System;
using System.Diagnostics;
using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Nova.Hotfix;

public sealed class MonsterValueTemplete : IMessage<MonsterValueTemplete>, IMessage, IEquatable<MonsterValueTemplete>, IDeepCloneable<MonsterValueTemplete>
{
	private static readonly MessageParser<MonsterValueTemplete> _parser = new MessageParser<MonsterValueTemplete>(() => new MonsterValueTemplete());

	private UnknownFieldSet _unknownFields;

	public const int IdFieldNumber = 1;

	private long id_;

	public const int TemplateIdFieldNumber = 2;

	private int templateId_;

	public const int LvFieldNumber = 3;

	private int lv_;

	public const int HpFieldNumber = 4;

	private long hp_;

	public const int AtkFieldNumber = 5;

	private int atk_;

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

	public const int AtkSpdFieldNumber = 26;

	private int atkSpd_;

	public const int DefPierceFieldNumber = 27;

	private int defPierce_;

	public const int DefIgnoreFieldNumber = 28;

	private int defIgnore_;

	public const int WEPFieldNumber = 29;

	private int wEP_;

	public const int FEPFieldNumber = 30;

	private int fEP_;

	public const int SEPFieldNumber = 31;

	private int sEP_;

	public const int AEPFieldNumber = 32;

	private int aEP_;

	public const int LEPFieldNumber = 33;

	private int lEP_;

	public const int DEPFieldNumber = 34;

	private int dEP_;

	public const int WEIFieldNumber = 35;

	private int wEI_;

	public const int FEIFieldNumber = 36;

	private int fEI_;

	public const int SEIFieldNumber = 37;

	private int sEI_;

	public const int AEIFieldNumber = 38;

	private int aEI_;

	public const int LEIFieldNumber = 39;

	private int lEI_;

	public const int DEIFieldNumber = 40;

	private int dEI_;

	public const int WEEFieldNumber = 41;

	private int wEE_;

	public const int FEEFieldNumber = 42;

	private int fEE_;

	public const int SEEFieldNumber = 43;

	private int sEE_;

	public const int AEEFieldNumber = 44;

	private int aEE_;

	public const int LEEFieldNumber = 45;

	private int lEE_;

	public const int DEEFieldNumber = 46;

	private int dEE_;

	public const int WERFieldNumber = 47;

	private int wER_;

	public const int FERFieldNumber = 48;

	private int fER_;

	public const int SERFieldNumber = 49;

	private int sER_;

	public const int AERFieldNumber = 50;

	private int aER_;

	public const int LERFieldNumber = 51;

	private int lER_;

	public const int DERFieldNumber = 52;

	private int dER_;

	public const int ToughnessFieldNumber = 53;

	private long toughness_;

	public const int SuppressFieldNumber = 54;

	private int suppress_;

	public const int RCDMARKDMGFieldNumber = 55;

	private int rCDMARKDMG_;

	[DebuggerNonUserCode]
	public static MessageParser<MonsterValueTemplete> Parser => _parser;

	[DebuggerNonUserCode]
	public static MessageDescriptor Descriptor => HotfixClientTableReflection.Descriptor.MessageTypes.get_Item(586);

	[DebuggerNonUserCode]
	MessageDescriptor IMessage.Descriptor => Descriptor;

	[DebuggerNonUserCode]
	public long Id
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
	public int Lv
	{
		get
		{
			return lv_;
		}
		set
		{
			lv_ = value;
		}
	}

	[DebuggerNonUserCode]
	public long Hp
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
	public int AtkSpd
	{
		get
		{
			return atkSpd_;
		}
		set
		{
			atkSpd_ = value;
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
	public long Toughness
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
	public MonsterValueTemplete()
	{
	}

	[DebuggerNonUserCode]
	public MonsterValueTemplete(MonsterValueTemplete other)
		: this()
	{
		id_ = other.id_;
		templateId_ = other.templateId_;
		lv_ = other.lv_;
		hp_ = other.hp_;
		atk_ = other.atk_;
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
		atkSpd_ = other.atkSpd_;
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
		toughness_ = other.toughness_;
		suppress_ = other.suppress_;
		rCDMARKDMG_ = other.rCDMARKDMG_;
		_unknownFields = UnknownFieldSet.Clone(other._unknownFields);
	}

	[DebuggerNonUserCode]
	public MonsterValueTemplete Clone()
	{
		return new MonsterValueTemplete(this);
	}

	[DebuggerNonUserCode]
	public override bool Equals(object other)
	{
		return Equals(other as MonsterValueTemplete);
	}

	[DebuggerNonUserCode]
	public bool Equals(MonsterValueTemplete other)
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
		if (TemplateId != other.TemplateId)
		{
			return false;
		}
		if (Lv != other.Lv)
		{
			return false;
		}
		if (Hp != other.Hp)
		{
			return false;
		}
		if (Atk != other.Atk)
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
		if (AtkSpd != other.AtkSpd)
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
		if (Toughness != other.Toughness)
		{
			return false;
		}
		if (Suppress != other.Suppress)
		{
			return false;
		}
		if (RCDMARKDMG != other.RCDMARKDMG)
		{
			return false;
		}
		return object.Equals(_unknownFields, other._unknownFields);
	}

	[DebuggerNonUserCode]
	public override int GetHashCode()
	{
		int num = 1;
		if (Id != 0L)
		{
			num ^= Id.GetHashCode();
		}
		if (TemplateId != 0)
		{
			num ^= TemplateId.GetHashCode();
		}
		if (Lv != 0)
		{
			num ^= Lv.GetHashCode();
		}
		if (Hp != 0L)
		{
			num ^= Hp.GetHashCode();
		}
		if (Atk != 0)
		{
			num ^= Atk.GetHashCode();
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
		if (AtkSpd != 0)
		{
			num ^= AtkSpd.GetHashCode();
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
		if (Toughness != 0L)
		{
			num ^= Toughness.GetHashCode();
		}
		if (Suppress != 0)
		{
			num ^= Suppress.GetHashCode();
		}
		if (RCDMARKDMG != 0)
		{
			num ^= RCDMARKDMG.GetHashCode();
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
		if (Id != 0L)
		{
			output.WriteRawTag(8);
			output.WriteInt64(Id);
		}
		if (TemplateId != 0)
		{
			output.WriteRawTag(16);
			output.WriteInt32(TemplateId);
		}
		if (Lv != 0)
		{
			output.WriteRawTag(24);
			output.WriteInt32(Lv);
		}
		if (Hp != 0L)
		{
			output.WriteRawTag(32);
			output.WriteInt64(Hp);
		}
		if (Atk != 0)
		{
			output.WriteRawTag(40);
			output.WriteInt32(Atk);
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
		if (AtkSpd != 0)
		{
			output.WriteRawTag(208, 1);
			output.WriteInt32(AtkSpd);
		}
		if (DefPierce != 0)
		{
			output.WriteRawTag(216, 1);
			output.WriteInt32(DefPierce);
		}
		if (DefIgnore != 0)
		{
			output.WriteRawTag(224, 1);
			output.WriteInt32(DefIgnore);
		}
		if (WEP != 0)
		{
			output.WriteRawTag(232, 1);
			output.WriteInt32(WEP);
		}
		if (FEP != 0)
		{
			output.WriteRawTag(240, 1);
			output.WriteInt32(FEP);
		}
		if (SEP != 0)
		{
			output.WriteRawTag(248, 1);
			output.WriteInt32(SEP);
		}
		if (AEP != 0)
		{
			output.WriteRawTag(128, 2);
			output.WriteInt32(AEP);
		}
		if (LEP != 0)
		{
			output.WriteRawTag(136, 2);
			output.WriteInt32(LEP);
		}
		if (DEP != 0)
		{
			output.WriteRawTag(144, 2);
			output.WriteInt32(DEP);
		}
		if (WEI != 0)
		{
			output.WriteRawTag(152, 2);
			output.WriteInt32(WEI);
		}
		if (FEI != 0)
		{
			output.WriteRawTag(160, 2);
			output.WriteInt32(FEI);
		}
		if (SEI != 0)
		{
			output.WriteRawTag(168, 2);
			output.WriteInt32(SEI);
		}
		if (AEI != 0)
		{
			output.WriteRawTag(176, 2);
			output.WriteInt32(AEI);
		}
		if (LEI != 0)
		{
			output.WriteRawTag(184, 2);
			output.WriteInt32(LEI);
		}
		if (DEI != 0)
		{
			output.WriteRawTag(192, 2);
			output.WriteInt32(DEI);
		}
		if (WEE != 0)
		{
			output.WriteRawTag(200, 2);
			output.WriteInt32(WEE);
		}
		if (FEE != 0)
		{
			output.WriteRawTag(208, 2);
			output.WriteInt32(FEE);
		}
		if (SEE != 0)
		{
			output.WriteRawTag(216, 2);
			output.WriteInt32(SEE);
		}
		if (AEE != 0)
		{
			output.WriteRawTag(224, 2);
			output.WriteInt32(AEE);
		}
		if (LEE != 0)
		{
			output.WriteRawTag(232, 2);
			output.WriteInt32(LEE);
		}
		if (DEE != 0)
		{
			output.WriteRawTag(240, 2);
			output.WriteInt32(DEE);
		}
		if (WER != 0)
		{
			output.WriteRawTag(248, 2);
			output.WriteInt32(WER);
		}
		if (FER != 0)
		{
			output.WriteRawTag(128, 3);
			output.WriteInt32(FER);
		}
		if (SER != 0)
		{
			output.WriteRawTag(136, 3);
			output.WriteInt32(SER);
		}
		if (AER != 0)
		{
			output.WriteRawTag(144, 3);
			output.WriteInt32(AER);
		}
		if (LER != 0)
		{
			output.WriteRawTag(152, 3);
			output.WriteInt32(LER);
		}
		if (DER != 0)
		{
			output.WriteRawTag(160, 3);
			output.WriteInt32(DER);
		}
		if (Toughness != 0L)
		{
			output.WriteRawTag(168, 3);
			output.WriteInt64(Toughness);
		}
		if (Suppress != 0)
		{
			output.WriteRawTag(176, 3);
			output.WriteInt32(Suppress);
		}
		if (RCDMARKDMG != 0)
		{
			output.WriteRawTag(184, 3);
			output.WriteInt32(RCDMARKDMG);
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
		if (Id != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Id);
		}
		if (TemplateId != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(TemplateId);
		}
		if (Lv != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Lv);
		}
		if (Hp != 0L)
		{
			num += 1 + CodedOutputStream.ComputeInt64Size(Hp);
		}
		if (Atk != 0)
		{
			num += 1 + CodedOutputStream.ComputeInt32Size(Atk);
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
		if (AtkSpd != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(AtkSpd);
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
		if (Toughness != 0L)
		{
			num += 2 + CodedOutputStream.ComputeInt64Size(Toughness);
		}
		if (Suppress != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(Suppress);
		}
		if (RCDMARKDMG != 0)
		{
			num += 2 + CodedOutputStream.ComputeInt32Size(RCDMARKDMG);
		}
		if (_unknownFields != null)
		{
			num += _unknownFields.CalculateSize();
		}
		return num;
	}

	[DebuggerNonUserCode]
	public void MergeFrom(MonsterValueTemplete other)
	{
		if (other != null)
		{
			if (other.Id != 0L)
			{
				Id = other.Id;
			}
			if (other.TemplateId != 0)
			{
				TemplateId = other.TemplateId;
			}
			if (other.Lv != 0)
			{
				Lv = other.Lv;
			}
			if (other.Hp != 0L)
			{
				Hp = other.Hp;
			}
			if (other.Atk != 0)
			{
				Atk = other.Atk;
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
			if (other.AtkSpd != 0)
			{
				AtkSpd = other.AtkSpd;
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
			if (other.Toughness != 0L)
			{
				Toughness = other.Toughness;
			}
			if (other.Suppress != 0)
			{
				Suppress = other.Suppress;
			}
			if (other.RCDMARKDMG != 0)
			{
				RCDMARKDMG = other.RCDMARKDMG;
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
				Id = input.ReadInt64();
				break;
			case 16u:
				TemplateId = input.ReadInt32();
				break;
			case 24u:
				Lv = input.ReadInt32();
				break;
			case 32u:
				Hp = input.ReadInt64();
				break;
			case 40u:
				Atk = input.ReadInt32();
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
				AtkSpd = input.ReadInt32();
				break;
			case 216u:
				DefPierce = input.ReadInt32();
				break;
			case 224u:
				DefIgnore = input.ReadInt32();
				break;
			case 232u:
				WEP = input.ReadInt32();
				break;
			case 240u:
				FEP = input.ReadInt32();
				break;
			case 248u:
				SEP = input.ReadInt32();
				break;
			case 256u:
				AEP = input.ReadInt32();
				break;
			case 264u:
				LEP = input.ReadInt32();
				break;
			case 272u:
				DEP = input.ReadInt32();
				break;
			case 280u:
				WEI = input.ReadInt32();
				break;
			case 288u:
				FEI = input.ReadInt32();
				break;
			case 296u:
				SEI = input.ReadInt32();
				break;
			case 304u:
				AEI = input.ReadInt32();
				break;
			case 312u:
				LEI = input.ReadInt32();
				break;
			case 320u:
				DEI = input.ReadInt32();
				break;
			case 328u:
				WEE = input.ReadInt32();
				break;
			case 336u:
				FEE = input.ReadInt32();
				break;
			case 344u:
				SEE = input.ReadInt32();
				break;
			case 352u:
				AEE = input.ReadInt32();
				break;
			case 360u:
				LEE = input.ReadInt32();
				break;
			case 368u:
				DEE = input.ReadInt32();
				break;
			case 376u:
				WER = input.ReadInt32();
				break;
			case 384u:
				FER = input.ReadInt32();
				break;
			case 392u:
				SER = input.ReadInt32();
				break;
			case 400u:
				AER = input.ReadInt32();
				break;
			case 408u:
				LER = input.ReadInt32();
				break;
			case 416u:
				DER = input.ReadInt32();
				break;
			case 424u:
				Toughness = input.ReadInt64();
				break;
			case 432u:
				Suppress = input.ReadInt32();
				break;
			case 440u:
				RCDMARKDMG = input.ReadInt32();
				break;
			}
		}
	}
}
