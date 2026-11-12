using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._15601;

public class Config_MainControl
{
	public static readonly Dictionary<int, int> hitDamageIdMapping = new Dictionary<int, int>
	{
		[156310001] = 156310002,
		[156310003] = 156310004
	};

	public const string comboTag_Skill = "Skill_Mian_CallPenguinDoll";

	public const string eventName_Summon_Skill = "CallPenguinDoll";

	public const string eventName_AddReduceSpeedBuff_Skill = "156SlowMoveStart";

	public const string eventName_RemoveReduceSpeedBuff_Skill = "156SlowMoveEnd";

	public const int buffId_ReduceSpeed_Skill = 15690002;

	public const int summonedId_Skill = 15600011;

	public static readonly FP summonOffset_Skill = 1;

	public static SummonCfg summonCfg_Summon = new SummonCfg
	{
		summonFollowType = SummonFollowType.NotFollow,
		summonAttrType = SummonAttrType.InheritByInitialSnapshot,
		summonRelation = SummonRelation.Coexisted,
		summonType = SummonType.None
	};

	public const string comboTag_Spawn_Summoned_Skill = "Birth";

	public static readonly FP distance_BeginTrace_Summoned_Skill = 1;

	public static readonly FP interval_CheckDistance_Summoned_Skill = 0.2;

	public static readonly FP duration_Tarce_Summoned_Skill = 3;

	public const int skillId_Trace_Summoned_Skill = 15631002;

	public const string comboTag_Skill_Summoned_Skill = "Run";

	public const string comboTag_Death_Summoned_Skill = "Dead";

	public const int perkId_1 = 515601;

	public static readonly FP modelScale_Summoned_P1 = 1;

	public const int buffId_Accelerate_P1 = 15601021;

	public static readonly int damageTag_Trigger_P1 = CommonHelper.StringToHash("PenguinDollAtk");

	public const int buffId_P1 = 15601011;

	public const int perkId_2 = 515602;

	public const string comboTag_Skill_Summoned_P2 = "Run_P2";

	public const string eventName_AddBuff_P2 = "PenguinDoll_Healing";

	public const int buffId_P2 = 15602011;

	public const int perkId_3 = 515603;

	public const string comboTag_NormalAttack_P3 = "Atk_Shot_P3";

	public const int parameterId_P3_1 = 15603011;

	public const int parameterId_P3_2 = 15603012;

	public const int perkId_4 = 515604;

	public const int skillId_P4 = 15631004;

	public const string comboTag_P4 = "P4_Reload";

	public const int buffId_P4 = 15604011;

	public const int perkId_5 = 515605;

	public const string comboTag_Death_Summoned_P5 = "Dead";

	public static readonly int damageTag_Trigger_P5 = CommonHelper.StringToHash("PenguinDollAtk");

	public const int additionalAttrId_P5 = 15605001;

	public static readonly FP duration_Rush_P5 = 0.66;

	public static readonly FP maxDistance_Rush_P5 = 5;

	public const int perkId_6 = 515606;

	public const int buffId_P6 = 15606011;

	public const int perkId_7 = 515607;

	public const int buffId_P7 = 15607011;

	public const int perkId_8 = 515608;

	public static readonly int damageTag_Trigger_P8 = CommonHelper.StringToHash("156NrmAtk");

	public const string bulletFxKey_P8 = "Bullet_156_P8_Egg";

	public static readonly FP shootOffset_P8 = 1;

	public static readonly FP shootPositionY_P8 = 1;

	public const int parameterId_TriggerRate_P8 = 15608011;

	public const int parameterId_TriggerCD_P8 = 15608012;

	public const int perkId_9 = 515609;

	public const int buffId_P9 = 15609011;

	public const int perkId_10 = 515610;

	public const int buffId_P10 = 15610011;

	public const int perkId_11 = 515611;

	public const int addDodgeSection_P11 = 1;

	public const int buffId_P11 = 15611011;

	public const int perkId_12 = 515612;

	public const int buffId_P12 = 15612011;

	public const int perkId_13 = 515613;

	public const int buffId_P13 = 15613011;

	public const string logicTag_SummonedCount = "SummonedCount";
}
