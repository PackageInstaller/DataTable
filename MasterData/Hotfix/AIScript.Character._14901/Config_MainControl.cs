using TrueSync;
using UnityEngine;

namespace AIScript.Character._14901;

public class Config_MainControl
{
	public static readonly int damageTag_NormalAtk_45 = CommonHelper.StringToHash("149_AtkP02_LandTrigger");

	public static readonly int damageTag_IronMaiden = CommonHelper.StringToHash("149_IronMaiden");

	public static readonly int slowBuff_tag = CommonHelper.StringToHash("Slow");

	public const string comboTag_Skill = "149_Skill_Main";

	public static readonly FP lifeTime = 8.3;

	public const int summonId = 14900011;

	public const string summonEvent = "149_Summon_IronMaiden";

	public static readonly FP summonDelay = 0.66;

	public static readonly FP summonAngle = 270;

	public static readonly Vector2 R_pos = new Vector2(3f, 1.5f);

	public static readonly Vector2 L_pos = new Vector2(-3f, 1.5f);

	public static readonly Vector2 M_pos = new Vector2(-1f, 3.5f);

	public static readonly Vector2 Single_pos = new Vector2(3.5f, 1f);

	public const int hitId_link = 149310002;

	public const string hitFx_link = "fx_14901_hit_ironMaiden_1";

	public const string linkFx_IronM = "fx_14901_loop_B1_Skill_IronMaiden_chain";

	public static readonly FP linkHit_cd = 1;

	public static readonly FP link_range = 6.5;

	public const int link_num = 2;

	public const string hitFx_zhaohuanwu = "fx_14901_base_Skill_IronMaiden_hearts";

	public const int buffId_base = 14900001;

	public const int perkId_01 = 514901;

	public const int buff_01 = 14901011;

	public const int perkId_02 = 514902;

	public const int perkId_03 = 514903;

	public const int num_03 = 4;

	public const int perkId_04 = 514904;

	public const int cd_ScriptParameter_04 = 14904011;

	public const int hitId_04 = 149310401;

	public const string hitFx_04 = "fx_14901_base_P4_chain_hit";

	public const string linkFx_04_hit = "fx_14901_base_B1_P4_Skill_IronMaiden_chain_trigger";

	public const string hitFx_04_zhaohuanwu = "fx_14901_base_B1_P4_Skill_IronMaiden_trigger";

	public static readonly FP delay_hit = 0.3f;

	public const int perkId_05 = 514905;

	public const int buff_05 = 14905011;

	public const int perkId_06 = 514906;

	public const int onceId_06_2 = 14906001;

	public const int perkId_07 = 514907;

	public static readonly FP time_07 = 4;

	public const int perkId_08 = 514908;

	public const int buff_08 = 14908011;

	public const int onceId_08 = 14908001;

	public const int perkId_09 = 514909;

	public const int buff_09 = 14909011;

	public const int perkId_10 = 514910;

	public const int onceId_10 = 14910001;

	public static readonly FP time_10 = 12;

	public const int perkId_11 = 514911;

	public const int num_11 = 1;

	public const int buff_11 = 14911011;

	public const int perkId_12 = 514912;

	public static readonly FP range_12 = 13;

	public const int onceId_12 = 14912001;

	public const int perkId_13 = 514913;

	public const int buffId_13 = 14913011;

	public static FP mainConcTime;

	public static int linkNum;

	public static FP linkRange;
}
