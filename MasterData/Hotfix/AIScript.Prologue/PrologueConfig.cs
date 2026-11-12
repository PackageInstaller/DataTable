using TrueSync;

namespace AIScript.Prologue;

public class PrologueConfig
{
	public static int ProVideoGUI = 92;

	public static string videoUrl_start = "Prologue/Prologue_P1";

	public static bool videoUrl_start_skip = true;

	public static string videoUrl_middle = "Prologue/Prologue_P2";

	public static bool videoUrl_middle_skip = true;

	public static string videoUrl_end = "Prologue/Prologue_P3";

	public static bool videoUrl_end_skip = true;

	public static float transDuration = 1.5f;

	public static float fadeDuration = 1.5f;

	public static FP video_triggerTime = 30.4f;

	public static int actorId = 103;

	public static int monsterId = 1200101;

	public static float fadeTime = 2f;

	public static float maxSpd_1 = 2.5f;

	public static float maxSpd_2 = 4.2f;

	public static float maxSpd_3 = 1.5f;

	public static float maxSpd_4 = 1.5f;

	public static float camraTime = 1f;

	public static int buff = 911200110;

	public static float playSpeed_1 = 1.5f;

	public static float playSpeed_1_2 = 2f;

	public static float npcSpeed_1 = 1.5f;

	public static float npcSpeed_1_2 = 5f;

	public static FP wait_idle = 2.5f;

	public static FP wait_move = 2f;

	public static FP wait_turnback = 7f;

	public static FP time_1 = 3f;

	public static FP moveDis_1 = 2f;

	public static FP time_2 = 5f;

	public static FP moveDis_2 = 2f;

	public static FP rotSpd_2 = 100f;

	public static TSVector2 slideDir = new TSVector2(-0.68f, 0.73f);

	public static FP slideTime = 9.4f;

	public static FP gravity = -200000f;

	public static string combo_phone = "Prologue_Phase1_TakePhone";

	public static string combo_turnBack0 = "Prologue_Phase1_GoBack_WithPhone";

	public static string combo_turnDown0 = "Prologue_Phase1_LookDown_WithPhone";

	public static string combo_turnBack = "Prologue_Phase1_GoBack_WithoutPhone";

	public static string combo_turnDown = "Prologue_Phase1_LookDown_WithoutPhone";

	public static string combo_slope = "Prologue_Phase1_Slide";

	public static string combo_slope2 = "Slide";

	public static float playSpeed_2 = 6f;

	public static FP bornTime = 3.5f;

	public static string interactID_battle1End = "";

	public static string interactID_backFire = "";

	public static string interactID_battle2End = "Battle2End";

	public static FP dis_Born = 2f;

	public static FP time_DelayBorn = 0f;

	public static string combo_fire = "Prologue_Phase2_StartBattle";

	public static string combo_unfire = "Prologue_Phase2_EndBattle";

	public static string combo_born = "Spawn";

	public static string combo_unfire_look = "Prologue_Phase2_EndBattleWithButterfly";

	public static FP wait_idle_3 = 5f;

	public static FP wait_move_3 = 3f;

	public static float playSpeed_3_move = 2f;

	public static float npcSpeed_3 = 2f;

	public static FP rotTime_3 = 1f;

	public static FP moveDis_3 = 2f;

	public static float playSpeed_3_climb = 2f;

	public static float offsetAngleX = -30f;

	public static float offsetAngleY = 90f;

	public static string bubbleID3 = "BBm00_01";

	public static int bubbleGroupID3 = 10;

	public static string combo_notBack = "Prologue_Phase3_Stop";

	public static string combo_stop = "Prologue_Phase3_LevelEnd";
}
