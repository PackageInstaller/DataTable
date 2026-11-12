using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._14901;

public class Config_Support
{
	public static readonly int damageTag_B2 = CommonHelper.StringToHash("149_B2");

	public static readonly int damageTag_Chain = CommonHelper.StringToHash("149_B2_Chain");

	public static readonly int damageTag_Earthquake = CommonHelper.StringToHash("149_B2_Earthquake");

	public static readonly Dictionary<int, string> dicSkillTag = new Dictionary<int, string>
	{
		[0] = "149_B2",
		[1] = "149_B2P21",
		[10] = "149_B2P22",
		[100] = "149_B2P23",
		[11] = "149_B2P21P22",
		[101] = "149_B2P21P23",
		[110] = "149_B2P22P23"
	};

	public const string area_seismicWave_start = "AreaEffect_14901_B2_Skill_Earthquake_Start";

	public const string seismicWave_event_start = "149_Earthquake_Enemy_Start";

	public const string area_seismicWave = "AreaEffect_14901_B2_Skill_Earthquake";

	public const string seismicWave_event = "149_Earthquake_Enemy";

	public const string area_seismicWave_self = "AreaEffect_14901_B2_Skill_Earthquake_Self";

	public const string seismicWave_event_self = "149_Earthquake_Self";

	public static readonly Vector3 offsetPos = new Vector3(0f, 0f, 6.7f);

	public static readonly Vector3 offsetPosSelf = new Vector3(0f, 0f, 0.5f);

	public const int perkId_21 = 514921;

	public const int onceId_21 = 14921011;

	public static readonly List<Vector3> areaPos = new List<Vector3>
	{
		new Vector3(2.4f, 0f, 6.4f),
		new Vector3(0f, 0f, 6.7f),
		new Vector3(-2.4f, 0f, 6.4f)
	};

	public const int perkId_22 = 514922;

	public const int onceId_22 = 14922011;

	public const int perkId_23 = 514923;

	public const int loopNum_23 = 6;

	public const int perkId_24 = 514924;

	public const int onceId_24 = 14924011;

	public static readonly FP scale_24 = 1.3;

	public const int perkId_25 = 514925;

	public const int buff_25 = 14925011;

	public const int perkId_26 = 514926;

	public const int onceId_26 = 14926001;

	public const int ScriptParameter_26 = 14926011;

	public const int perkId_27 = 514927;

	public const int buff_27_1 = 14927011;

	public const int buff_27_2 = 14927012;

	public const int hitId_27 = 149327101;

	public const string hitFx_27 = "fx_14401_hit_Attack";

	public const int perkId_28 = 514928;

	public const int time_28 = 1;

	public const int onceId_28 = 14928001;

	public const int perkId_29 = 514929;

	public const int onceId_29 = 14929001;

	public const int perkId_30 = 514930;

	public const string area_seismicWave_30_Start = "AreaEffect_14901_B2P30_Skill_Earthquake_Start";

	public const string area_seismicWave_30 = "AreaEffect_14901_B2P30_Skill_Earthquake";

	public const string area_seismicWave_self_30 = "AreaEffect_14901_B2P30_Skill_Earthquake_Self";

	public const int perkId_31 = 514931;

	public const int buff_31 = 14931011;

	public const int perkId_32 = 514932;

	public const int buff_32 = 14932011;

	public const int perkId_33 = 514933;

	public const int buffId_33 = 14933011;

	public static FP supportSkillBeginTime;
}
