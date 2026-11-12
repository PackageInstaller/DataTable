using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._13701;

public class Config_Support
{
	public const string ComboTagSkillSupport = "Skill_Sup";

	public const string JumpAtk = "137SkillSupJumpAtk";

	public const int DroneSpawnInterval = 3;

	public const int MaxDroneCount = 3;

	public const int DroneMonsterId = 13700011;

	public const string BulletAlias_UAVBirthFly = "Bullet_137_UAV_BirthFly";

	public static readonly FP DroneSpawnRadius = 5;

	public static readonly FP ExtraRadiusForJumpAtk = 2;

	public static readonly FP DroneLeftTime = 3;

	public const string AreaEffectKey_JumpAtk = "AreaEffect_137_SkillSup_JumpAtk_Boom";

	public static readonly Dictionary<string, FP> JumpMoveDurationMap = new Dictionary<string, FP>
	{
		{ "137SkillSupJumpStart1", 0.54 },
		{ "137SkillSupJumpStart2", 0.54 },
		{ "137SkillSupJumpStart3", 0.76 },
		{ "137SkillSupJumpStart4", 0.55 },
		{ "137SkillSupJumpStart5", 0.58 },
		{ "137SkillSupJumpStart6", 0.77 },
		{ "137SkillSupJumpStart7", 0.53 },
		{ "137SkillSupJumpStart8", 0.58 },
		{ "137SkillSupJumpStart9", 0.79 }
	};

	public static readonly int damageTag_JumpAtk = CommonHelper.StringToHash("137SkillSupZaDi");

	public const int perkId_513721 = 513721;

	public const int onceId_513721_CritRate = 13721011;

	public const string AreaEffectKey_ExtraJumpAtk = "AreaEffect_137_SkillSup_JumpAtk_Boom_P21";

	public static readonly FP JumpAtkExtraOffset_513721 = 3;

	public static readonly FP JumpAtkExtraDelayStep_513721 = 0.01;

	public const int perkId_513722 = 513722;

	public const int ScriptParameter_RangePerExplode_513722 = 13721011;

	public const int onceId_513722_Damage = 13722011;

	public const int onceId_513722_CritDamage = 13722021;

	public const int maxStack_513722_Damage = 9;

	public const int perkId_513723 = 513723;

	public const int buffId_513723_Mark = 13723011;

	public const int onceId_513723_Damage = 13723011;

	public const int onceId_513723_DroneAtk = 13723021;

	public const int perkId_513724 = 513724;

	public const int hitCount_513724 = 3;

	public static readonly FP cd_513724 = 0.5;

	public const string areaEffectKey_513724_DroneAccumulate = "AreaEffect_137_P24_UAV_AtkAoe";

	public const int buffId_513724_DroneAtkSpeed = 13724011;

	public static readonly int bulletTag_drone = CommonHelper.StringToHash("137UAVBulletAtk");

	public const int perkId_513725 = 513725;

	public const int onceId_513725_Damage = 13725001;

	public const int onceId_513725_CritRate = 13725012;

	public const int perkId_513726 = 513726;

	public const int buffId_513726_AddBuff = 13726011;

	public const int buffId_513726_MainControlCritDamage = 13726021;

	public const int perkId_513727 = 513727;

	public const int onceId_513727_Damage = 13727001;

	public const int onceId_513727_Toughness = 13727002;

	public const int perkId_513728 = 513728;

	public const string NormalAttackCombo_513728 = "Atk1_P28";

	public const int onceId_513728_Damage = 13728001;

	public const int perkId_513729 = 513729;

	public const int onceId_513729_Damage = 13729001;

	public const int perkId_513730 = 513730;

	public const int onceId_513730_Damage = 13730001;

	public const int onceId_513730_NormalAttackDefPenetration = 13730002;

	public const int maxStack_513730 = 2;

	public static readonly FP duration_513730 = 10;

	public const int perkId_513731 = 513731;

	public const int buffId_513731_AddDamage = 13731011;

	public const int perkId_513732 = 513732;

	public const int buffId_513732_AddDamage = 13732011;

	public const int perkId_513733 = 513733;

	public const int buffId_513733_AddDamage = 13733011;

	public const string JumpAtkSessionStartName = "JumpAtkSessionStart";

	public const string JumpAtkJumpIndexName = "JumpAtkJumpIndex";

	public const string JumpAtkExplodeIndexName = "JumpAtkExplodeIndex";

	public const string JumpAtkOnceStackName_513722 = "JumpAtkOnceStack_513722";

	public const string JumpAtkAnchorName = "JumpAtkAnchor";

	public const string JumpAtkForwardName = "JumpAtkForward";

	public const string BulletTag_UAVBirthFly = "137_UAVBirthFly";
}
