using System.Runtime.CompilerServices;

namespace AIScript.Monster._73001KuiLeiShi;

public static class Config_XiaoMoXiang
{
	public const int Skill_MeleeCombo = 7201103;

	public const int Skill_SilkPierce = 7201101;

	public const int Skill_PuppetControl = 7201102;

	public const int Skill_ZhuNengGuangXian = 7201105;

	public const int Skill_NengLiangQiu = 7201106;

	public const int Skill_RangedCombo = 7201104;

	public const int Skill_Born = 9999989;

	public const int Skill_StageChange = 9999990;

	public static readonly int[] zhuNengKuiLeiMonsterIds;

	public static readonly int[] zhuNengPhantomMonsterIds;

	public static readonly int[] silkPhantomMonsterIds;

	public static readonly int[] laserOrbMonsterIds;

	public static readonly int[] trapMonsterIds;

	public static readonly int[] orbPlayerDamageUpBuffIds;

	public static readonly int[] damageBuffIds;

	public static readonly int[] slowBuffIds;

	public static readonly int[] bindBuffIds;

	public static readonly int[] damageReductionBuffIds;

	public static readonly int[] vulnerableBuffIds;

	public const string Lv1 = "Lv1";

	public const string Lv2 = "Lv2";

	public const string Lv3 = "Lv3";

	public const string Lv4 = "Lv4";

	public const string Lv5 = "Lv5";

	public const string Lv6 = "Lv6";

	public const string fx_Shield = "fx_m72011_base_Shield";

	public const string fx_ShieldDown = "fx_m72011_base_Shield_down";

	public const string fx_BreakLine = "fx_m72012_base_shootline_1";

	public static readonly string Skill_ZhuNengGuangXian_Finish;

	public static readonly string Skill_MeleeCombo_Finish;

	public static readonly string Skill_RangedCombo_Finish;

	public static readonly string Skill_NengLiangQiu_Finish;

	public static readonly string NLQ_PullStartTag;

	public static readonly string NLQ_PullFinishTag;

	public static readonly string NLQ_PlayerAbsorbCountTag;

	public static readonly string NLQ_JuXingAbsorbCountTag;

	public static int evt_OrbAbsorbedByPlayer;

	public static int evt_OrbAbsorbedByJuXing;

	public const int EnergyToReductionThreshold = 33;

	static Config_XiaoMoXiang()
	{
		//IL_00bc: Field data (rva=0x5c0) could not be found in any section!
		//IL_00bc: Field data (rva=0x5c0) could not be found in any section!
		//IL_0090: Field data (rva=0x648) could not be found in any section!
		//IL_0090: Field data (rva=0x648) could not be found in any section!
		//IL_007a: Field data (rva=0x648) could not be found in any section!
		//IL_007a: Field data (rva=0x648) could not be found in any section!
		//IL_0064: Field data (rva=0x6e0) could not be found in any section!
		//IL_0064: Field data (rva=0x6e0) could not be found in any section!
		//IL_000c: Field data (rva=0x570) could not be found in any section!
		//IL_000c: Field data (rva=0x570) could not be found in any section!
		int[] array = new int[6];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._0EF515F8E2FA7755700B18A4D149924C1A413FEB9DF233742497668908E03CD5));
		zhuNengKuiLeiMonsterIds = array;
		zhuNengPhantomMonsterIds = new int[6] { 1933663298, 1937007987, 1668436828, 1953450079, 1551395174, 1734963796 };
		silkPhantomMonsterIds = new int[6] { 1701336156, 1699767661, 1415342962, 1701668200, 1869366111, 1866622069 };
		laserOrbMonsterIds = new int[6] { 1766612837, 1769236583, 1749509998, 779383663, 29539, 256 };
		int[] array2 = new int[6];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._2DCB5185A4C92EA29C0293414EF833FB6C7E411D992A3E861601ACF8BEAF7ACC));
		trapMonsterIds = array2;
		int[] array3 = new int[6];
		RuntimeHelpers.InitializeArray(array3, __ldtoken(_003CPrivateImplementationDetails_003E._24C3F9DEBB4E1A75EF198442A0C774E93B085EB5DE3C1B4AA10EC17896A5D15F));
		orbPlayerDamageUpBuffIds = array3;
		int[] array4 = new int[6];
		RuntimeHelpers.InitializeArray(array4, __ldtoken(_003CPrivateImplementationDetails_003E._24C3F9DEBB4E1A75EF198442A0C774E93B085EB5DE3C1B4AA10EC17896A5D15F));
		damageBuffIds = array4;
		slowBuffIds = new int[6] { 1869771886, 1919249516, 1751335263, 1702258025, 1953391981, 829836383 };
		int[] array5 = new int[6];
		RuntimeHelpers.InitializeArray(array5, __ldtoken(_003CPrivateImplementationDetails_003E._1292B9422F2EA98C2F872D94B2CE9339334111B9526765688F07C31EDC4338BB));
		bindBuffIds = array5;
		damageReductionBuffIds = new int[6] { 788529152, 1936933212, 1551070309, 1600352851, 1718906696, 1415346281 };
		vulnerableBuffIds = new int[6] { 2087480425, 1818848083, 1766612844, 1769236583, 1749247854, 1601071457 };
		Skill_ZhuNengGuangXian_Finish = "Skill_ZhuNengGuangXian_Finish";
		Skill_MeleeCombo_Finish = "Skill_MeleeCombo_Finish";
		Skill_RangedCombo_Finish = "Skill_RangedCombo_Finish";
		Skill_NengLiangQiu_Finish = "Skill_NengLiangQiu_Finish";
		NLQ_PullStartTag = "NLQ_PullStart";
		NLQ_PullFinishTag = "NLQ_PullFinish";
		NLQ_PlayerAbsorbCountTag = "NLQ_PlayerAbsorbCount";
		NLQ_JuXingAbsorbCountTag = "NLQ_JuXingAbsorbCount";
		evt_OrbAbsorbedByPlayer = CommonHelper.StringToHash("evt_orbAbsorbedByPlayer");
		evt_OrbAbsorbedByJuXing = CommonHelper.StringToHash("evt_orbAbsorbedByJuXing");
	}
}
