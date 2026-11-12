using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Config
{
	public const string CenterPoint = "CenterPoint";

	public const string BottlePlaceholder = "BigPerfumePosition";

	public static readonly FP AxisAngle = 0;

	public const int PerfumeGuardBuffId = 700619100;

	public const int PerfumeValueBuffMax = 100;

	public static readonly FP Phase1Accumlate = 2;

	public static readonly FP Phase2Accumlate = 2;

	public static readonly FP Phase3Accumlate = 3;

	public static readonly FP PerfumeDisableTime = 10;

	public const string PerfumeDispelBullet = "Weapon_70061WuYu_PerfumeAttack_Player";

	public static readonly FP DispelStunTime = 10;

	public static readonly string FxPerfumeDispel = "fx_70061_base_perfume_blue";

	public static readonly List<int> ClearMonsterWhenDispel = new List<int> { 1, 2, 6, 3, 5 };

	public static readonly FP DispelBulletShootHeight = 1;

	public static readonly Dictionary<string, (string interactiveId, string actionId)> BottleLandingMap = new Dictionary<string, (string, string)>
	{
		{
			"Position_BottleLanding1",
			("1001", "PerfumeAttack1001")
		},
		{
			"Position_BottleLanding2",
			("1002", "PerfumeAttack1002")
		},
		{
			"Position_BottleLanding3",
			("1003", "PerfumeAttack1003")
		}
	};

	public static readonly string[] PlayerLampHolders = new string[5] { "Position_L1", "Position_L2", "Position_L3", "Position_L4", "Position_L5" };

	public static readonly string[] BossLampHolders = new string[5] { "Position_R1", "Position_R2", "Position_R3", "Position_R4", "Position_R5" };

	public const string Fx_PlayerLampOn = "fx_70061WuYu_loop_scene_light_l";

	public const string Fx_BossLampOn = "fx_70061WuYu_loop_scene_light_r";

	public const string Fx_PerfumeBottleFlash = "fx_70061_base_perfume_gaoliang";

	public static readonly FP Fx_PerfumeBottleFlashHeight = 0;

	public const string PerfumeBottleBullet = "Weapon_70061WuYu_PerfumeBullet_Player";

	public const string PerfumeBottleBullet_Boss = "Weapon_70061WuYu_PerfumeBullet_WuYu";

	public const string BossBottleLandingHolder = "Position_BossBottleLanding";

	public const string Fx_LandedBottle_Player = "fx_70061_loop_perfume";

	public const string Fx_LandedBottle_Boss = "fx_70061_loop_perfume_purple";

	public const string Fx_BossBottleClear = "fx_70061_base_perfume_purple";

	public const int ExplodeTeammateId = 1;

	public const int BigHeadTeammateId = 2;

	public const int BigHeadRangedTeammateId = 6;

	public const int WarlockTeammateId = 3;

	public const int WarlockRangedTeammateId = 5;

	public const int TerrorTeammateId = 4;

	public const int GiantGhostTeammateId = 7;

	public const int Skill_GhostLegion_BroomDash = 7006190;

	public const int Skill_EerieDoorway = 7006110;

	public const int Skill_StrangeCamera = 7006120;

	public const int Skill_ContractSummon = 7006130;

	public const int Skill_BroomBullet = 7006150;

	public const int Skill_MagicRing = 7006160;

	public const int Skill_BombPerfume = 7006170;

	public const int Skill_SweepCombo = 7006180;

	public const int Skill_TerrorSummon = 7006140;

	public const int Skill_GiantGhost = 7006191;

	public const int Skill_BroomDecoy = 7006192;

	public const int Skill_BroomRiding = 7006193;

	public const int Skill_DispelStun = 7006195;

	public const int Skill_Wander = 7006197;

	public const int Skill_Wait = 9999999;

	public static readonly FP BroomDecoyCd = 30;

	public static readonly FP BroomDecoyDamageThresholdPercent = 0.05;

	public static readonly FP BroomDecoyDamageWindow = 3;

	public static readonly FP ExplodeHpPercent = 0.005;

	public static readonly FP BigHeadPercent = 0.08;

	public static readonly FP WarlockPercent = 0.03;

	public const string Tag_LoyalServant = "LoyalServantTagId";

	public const string Tag_FastExplode = "FastExplodeTagId";

	public const string Tag_PerfumeBrew = "PerfumeBrewTagId";

	public static readonly FP Entry_Phase1Accumlate = 3;

	public static readonly FP Entry_Phase2Accumlate = 3;

	public static readonly FP Entry_Phase3Accumlate = 4;

	public const string Tag_DoubleHorror = "DoubleHorrorTagId";

	public const string Tag_SummonBoost_BigHead = "SummonBoostBigHeadTagId";

	public const string Tag_SummonBoost_Warlock = "SummonBoostWarlockTagId";

	public const string Tag_Perk8 = "Perk8TagId";

	public const int Perk8_ShieldId = 709054081;

	public const int Perk8_DamageDebuffId = 709054080;

	public const string Tag_Perk9 = "Perk9TagId";

	public const int Perk9_BuffId = 709054090;

	public const string Tag_Perk35 = "Perk35TagId";

	public static readonly FP Perk35_ImmuneDeadDuration = 30;

	public const int Perk35_DebuffId = 709054350;

	public static readonly Dictionary<int, int> SummonerSyncBuffMap = new Dictionary<int, int>
	{
		{ 709054210, 709054211 },
		{ 709054220, 709054221 },
		{ 709054310, 709054310 },
		{ 709054320, 709054320 },
		{ 709054330, 709054330 },
		{ 709054261, 709054261 },
		{ 709054262, 709054262 },
		{ 709054263, 709054263 },
		{ 709054264, 709054264 },
		{ 709054265, 709054265 },
		{ 709054266, 709054266 },
		{ 709054267, 709054267 },
		{ 709054268, 709054268 },
		{ 709054269, 709054269 },
		{ 709054271, 709054271 },
		{ 709054272, 709054272 },
		{ 709054273, 709054273 },
		{ 709054274, 709054274 },
		{ 709054275, 709054275 },
		{ 709054276, 709054276 },
		{ 709054277, 709054277 },
		{ 709054278, 709054278 },
		{ 709054279, 709054279 }
	};

	public const string PhaseTag = "Phase";

	public const string PerfumeValueTag = "PerfumeValue";

	public const string CanGetPerfumeValueTag = "CanGetPerfume";

	public const string LastSentBossPerfumeIntTag = "LastSentBossPerfumeInt";

	public const string LastSentPlayerPerfumeIntTag = "LastSentPlayerPerfumeInt";

	public const string DispelStunPendingTag = "DispelStunPending";

	public const string CastDecoyLogicTag = "CastDecoyLogicTag";

	public const string PerfumeBottleBulletTag_Boss = "Weapon_70061WuYu_Skill1_Bullet_Boss";

	public const string PerfumeBottleBulletTag_Player = "Weapon_70061WuYu_Skill1_Bullet_Player";

	public const string BossBottleClearEventName = "WuYu_BossBottleClear";

	public const string BossPerfumeFullTag = "BossPerfumeFullTag";

	public const string FullSkillPhaseTag = "FullSkillPhase";

	public const string CanUseBroomDodgeTag = "CanUseBroomDodge";

	public const string PerfumeHasAddedTag = "PerfumeHasAddedTag";
}
