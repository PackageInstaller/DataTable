using TrueSync;

namespace AIScript.Character._15501;

public static class Config_L
{
	public static FP trace_second = 10;

	public static FP trace_first = 5;

	public static FP trace_stop = 1;

	public static string effectRush_B = "fx_15501_Bullet_Skill_Support_Summon_Rush_black";

	public static string effectRush_W = "fx_15501_Bullet_Skill_Support_Summon_Rush_white";

	public static string effectRelax_B = "fx_15501_Bullet_Skill_Summon_Leisure_Black";

	public static string effectRelax_W = "fx_15501_Bullet_Skill_Summon_Leisure_White";

	public static string effectIdle_B = "fx_15501_Bullet_Skill_Summon_Leisure_Idle_black";

	public static string effectIdle_W = "fx_15501_Bullet_Skill_Summon_Leisure_Idle_white";

	public static string effectMove = "fx_15501_Loop_Skill_Support_Summon_Move02";

	public static string keyHide_B = "15501_Black_BlinkOut";

	public static string keyShow_B = "15501_Black_BlinkIn";

	public static string keyHide_W = "15501_White_BlinkOut";

	public static string keyShow_W = "15501_White_BlinkIn";

	public static string keyHide_B_Rush = "15501_Black_BlinkOut_Rush";

	public static string keyShow_B_Rush = "15501_Black_BlinkIn_Rush";

	public static string keyHide_W_Rush = "15501_White_BlinkOut_Rush";

	public static string keyShow_W_Rush = "15501_White_BlinkIn_Rush";

	public static FP hideTime = 0.4f;

	public static FP Interval_Relax_first = 10;

	public static TSVector2 leftLocalPos = new TSVector2(-1.5, 0);

	public static TSVector2 rightLocalPos = new TSVector2(1.5, 0);

	public static FP blinkRange = 1.7;

	public static string effectAtk = "fx_15501_base_attack_summon_receive";

	public static int uavAtkW_dataId = 15510011;

	public static int uavAtkB_dataId = 15510021;
}
