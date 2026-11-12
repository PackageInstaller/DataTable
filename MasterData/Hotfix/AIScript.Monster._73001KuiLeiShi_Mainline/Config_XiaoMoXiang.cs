namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public static class Config_XiaoMoXiang
{
	public const int Skill_MeleeCombo = 7201153;

	public const int Skill_SilkPierce = 7201151;

	public const int Skill_PuppetControl = 7201152;

	public const int Skill_ZhuNengGuangXian = 7201155;

	public const int Skill_NengLiangQiu = 7201156;

	public const int Skill_RangedCombo = 7201154;

	public const int Skill_Born = 9999989;

	public const int Skill_StageChange = 9999990;

	public static readonly int[] zhuNengKuiLeiMonsterIds = new int[1] { 7201401 };

	public static readonly int[] zhuNengPhantomMonsterIds = new int[1] { 7201321 };

	public static readonly int[] silkPhantomMonsterIds = new int[1] { 7201314 };

	public static readonly int[] laserOrbMonsterIds = new int[1] { 7201316 };

	public static readonly int[] trapMonsterIds = new int[1] { 7201317 };

	public static readonly int[] orbPlayerDamageUpBuffIds = new int[1] { 720130171 };

	public static readonly int[] damageBuffIds = new int[1] { 720130171 };

	public static readonly int[] slowBuffIds = new int[1] { 720130102 };

	public static readonly int[] bindBuffIds = new int[1] { 720130103 };

	public static readonly int[] damageReductionBuffIds = new int[1] { 720130191 };

	public static readonly int[] vulnerableBuffIds = new int[1] { 720130181 };

	public const string Lv1 = "Lv1";

	public const string Lv2 = "Lv2";

	public const string Lv3 = "Lv3";

	public const string Lv4 = "Lv4";

	public const string Lv5 = "Lv5";

	public const string Lv6 = "Lv6";

	public const string fx_Shield = "fx_m72011_base_Shield";

	public const string fx_ShieldDown = "fx_m72011_base_Shield_down";

	public const string fx_BreakLine = "fx_m72012_base_shootline_1";

	public static readonly string Skill_ZhuNengGuangXian_Finish = "Skill_ZhuNengGuangXian_Finish";

	public static readonly string Skill_MeleeCombo_Finish = "Skill_MeleeCombo_Finish";

	public static readonly string Skill_RangedCombo_Finish = "Skill_RangedCombo_Finish";

	public static readonly string Skill_NengLiangQiu_Finish = "Skill_NengLiangQiu_Finish";

	public static readonly string NLQ_PullStartTag = "NLQ_PullStart";

	public static readonly string NLQ_PullFinishTag = "NLQ_PullFinish";

	public static readonly string NLQ_PlayerAbsorbCountTag = "NLQ_PlayerAbsorbCount";

	public static readonly string NLQ_JuXingAbsorbCountTag = "NLQ_JuXingAbsorbCount";

	public static int evt_OrbAbsorbedByPlayer = CommonHelper.StringToHash("evt_orbAbsorbedByPlayer");

	public static int evt_OrbAbsorbedByJuXing = CommonHelper.StringToHash("evt_orbAbsorbedByJuXing");

	public const int EnergyToReductionThreshold = 33;
}
