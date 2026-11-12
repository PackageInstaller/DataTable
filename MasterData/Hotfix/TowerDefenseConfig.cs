using TrueSync;

public static class TowerDefenseConfig
{
	public static int HEATSTROKE_MIN = 1;

	public static int HEATSTROKE_THRESHOLD = 101;

	public static int buffId_Fire = 809001310;

	public static int buffId_Heatstroke = 809001320;

	public static int buffId_Cool = 809001330;

	public static int buffId_HotUp = 809001340;

	public static int buffId_HotUp_Warning = 809001370;

	public static int buffId_HotDown = 809001350;

	public static int fire_HotUp_Warning = 60;

	public static int buffId_Fire_Strong = 809001360;

	public static string fbx_Fire_StrongRing = "fx_td_base_hot_up_1";

	public static FP interval_HotOrCool = 0.1f;

	public static FP Spray_Cool = 2;

	public static FP DefaultGridFireEffectNum = 0.3f;

	public static FP FireGridFireEffectNum = 1;

	public static FP SyaryFireEffectnum = 1.8f;

	public static FP SyaryTotoleTime = 5;

	public static int DarkDeployLightRangeThreshold = 20;

	public static int DarkDeployLightRangeNear = 1;

	public static int DarkDeployLightRangeFar = 2;

	public static FP DarkRoleGridDarkenDuration = 7;

	public static int buffId_BlackFog = 809001410;

	public static int buffId_RoleDarken = 809001420;

	public static FP reFogDelay = 1;

	public static FP fogStatePollInterval = FP.One / 10;
}
