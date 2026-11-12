using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._14301;

public class Config_MainControl
{
	public const int buffId_MeleeAttackRangeFx = 14300011;

	public const int buffId_NotHaveSkillSection = 14300012;

	public const int buffId_SkillSection = 14300013;

	public const string comboTag_Skill = "Skill_Mian_SheZhan";

	public const int shootPointCount_Skill = 6;

	public static readonly FP startAngeleOffset_Skill = 90;

	public static readonly FP shootRadius_Skill = 2.7;

	public static readonly FP shootPositionY_Skill = 1.35;

	public const string eventName_Skill_ShootBullet = "143SkillMainShot";

	public const string bulletKey_Skill_Shoot = "Bullet_143_SkillMain_Base";

	public const int perkId_1 = 514301;

	public const int buffId_State_P1 = 14301011;

	public static readonly int damageTag_Trigger_P1 = CommonHelper.StringToHash("143NrmJianAtk");

	public const string tornadoAreaEffectKey_P1 = "AreaEffect_143_P1_LongJuanFeng";

	public const int perkId_2 = 514302;

	public const string eventName_GenerateTornado_P2 = "143P2LongJuanFeng";

	public const string tornadoAreaEffectKey_P2 = "AreaEffect_143_P2_LongJuanFeng";

	public const int count_GenerateTornado_P2 = 2;

	public static readonly FP generateTornadoRadius_P1_P2 = 3;

	public const string tornadoAreaEffectKey_P1_P2 = "AreaEffect_143_P1_LongJuanFeng_P2";

	public const int perkId_3 = 514303;

	public const string laserAreaEffectKey_P3 = "AreaEffect_143_P3_JiGuang";

	public static readonly int damageTag_Trigger_P3 = CommonHelper.StringToHash("143BulletAtk");

	public const int additionalAttrId_P3 = 14303011;

	public const int perkId_4 = 514304;

	public static readonly int damageTag_Trigger_P4 = CommonHelper.StringToHash("143BulletAtk");

	public const int additionalAttrId_P4 = 14304011;

	public static readonly int damageTag_AddTriggerMark_P4 = CommonHelper.StringToHash("143BulletAtk");

	public static readonly FP holdButtonTime_AutoBattle_P4 = 1.5;

	public const int perkId_5 = 514305;

	public const string comboTag_Skill_P5 = "Skill_Mian_SheZhan_P5";

	public static readonly FP triggerDistance_AddDamage_P5 = 3;

	public const int additionalAttrId_P5 = 14305001;

	public const int perkId_6 = 514306;

	public static readonly int damageTag_Trigger_P6 = CommonHelper.StringToHash("143SkillMainSwordAtk");

	public const int additionalAttrId_P6 = 14306001;

	public const int perkId_7 = 514307;

	public static readonly int damageTag_Trigger_P7 = CommonHelper.StringToHash("143SkillMainSwordAtk");

	public const int buffId_P7 = 14307011;

	public const int perkId_8 = 514308;

	public const int buffId_P8 = 14308011;

	public static readonly int damageTag_Trigger_P8 = CommonHelper.StringToHash("143SkillMainBulletAtk");

	public const int additionalAttrId_P8 = 14308001;

	public const int perkId_9 = 514309;

	public static readonly int damageTag_Trigger_P9 = CommonHelper.StringToHash("143BulletAtk");

	public const int buffId_P9 = 14309011;

	public const int parameterId_P9 = 14309011;

	public const int perkId_10 = 514310;

	public const int buffId_P10 = 14310011;

	public static readonly FP addBuffDuration_P10 = 3;

	public const string eventName_GenerateLaser_P10 = "143NrmQiangAtkEvent";

	public const string laserAreaEffectKey_P10 = "AreaEffect_143_P10_JiGuang";

	public static readonly List<TSVector2> generateLaserOffsetList_P10 = new List<TSVector2>
	{
		new TSVector2(1, 0),
		new TSVector2(-1, 0)
	};

	public static readonly FP generateLaserPositionY_P10 = 0;

	public static readonly FP triggerCD_P10 = 1;

	public const int perkId_11 = 514311;

	public const int addDodgeTotalSectionAmount_P11 = 1;

	public const int buffId_P11 = 14311011;

	public const int perkId_12 = 514312;

	public const int buffId_P12 = 14312011;

	public const int perkId_13 = 514313;

	public const int buffId_P13 = 14313011;

	public const string logicTag_SkillIsMaxSection = "SkillIsMaxSection";

	public const string logicTag_LastTriggerTime_P10 = "LastTriggerTime_P10";
}
