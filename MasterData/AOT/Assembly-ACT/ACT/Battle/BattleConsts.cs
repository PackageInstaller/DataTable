using UnityEngine;

namespace ACT.Battle;

public static class BattleConsts
{
	public static float windowResolutionWidth;

	public static float windowResolutionHeight;

	public static int enviromentMask;

	public static int entityMask;

	public static int hitMask;

	public static int interactMask;

	public const int defaultLayer = 0;

	public const int hiddenLayer = 3;

	public const int ignoreRaycastLayer = 2;

	public const int entityLayer = 6;

	public const int enviromentLayer = 7;

	public const int cameraColliderLayer = 8;

	public const int attackBoxLayer = 9;

	public const int hitLayer = 10;

	public const int DropItemLayer = 12;

	public const int UI3D = 15;

	public const int timelineLayer = 16;

	public const int interactLayer = 17;

	public const int jumpDownLayer = 19;

	public const int jumpDownGround = 20;

	public const int hideInTimeline = 21;

	public const int CharacterUIScene = 22;

	public const int InteractWallLayer = 23;

	public const int SpecialCharacterLayer = 24;

	public const int SkillCount = 3;

	public const float EXTRA_COMPENSATEDISTANCE = 0.05f;

	public static int SHADER_DISSOLVE;

	public static int SHADER_DissolveEmmision;

	public static int SHADER_FAKE_LIGHT;

	public static int SHADER_FAKE_LIGHT_DIR;

	public static int SUB_EFFECT_FRESNEL_COLOR;

	public static int SUB_EFFECT_FRESNEL_RANGE;

	public static int SUB_EFFECT_FRESNEL_SMOOTH;

	public static int SUB_EFFECT_SHADER_DITHER;

	public static int SUB_EFFECT_OUTLINE;

	public static int SUB_EFFECT_OUTLINE_COLOR;

	public static int SUB_EFFECT_OUTLINE_WIDTH;

	public static int SUB_EFFECT_EMIT_COLOR;

	public static int SUB_EFFECT_EMIT;

	public static int SHADER_DISSOLVE_NEW_SCAN_LINE;

	public static int SHADER_EFFECT_DISSOLVE_CUT;

	public static int SHADER_EFFECT_SCANRANGE;

	public static int SHADER_EFFECT_NOISEOFFSETSCAN;

	public static int SHADER_EFFECT_SCANNOISEPOWER;

	public static int SHAER_EFFECT_DISSOLVEEMMISION1;

	public static int SHAER_EFFECT_DISSOLVEEMMISION2;

	public static int SHAER_EFFECT_DISSOLVEDiIROFFSET;

	public static int SHADER_ACT_NEW_DISSOLVE_CUT;

	public static int SHAER_EFFECT_BELTOFFSET;

	public static int SHAER_EFFECT_DODGEEFFECT;

	public static string SHADER_EFFECT_MASKUVOFFSET;

	public static string SHADER_EFFECT_FLOWEMISSIONTEX;

	public static string AIM_ATTACH_POINT;

	public static float tenResistance;

	public static float HATRED_RANGE_Z_SIZE;

	public static int SHADER_EMISSION_COLOR;

	public static int SHADER_DISTANCECHANGE_COLOR;

	public static int SHADER_GLITCHWEIGHT;

	public static string BULLET_DESTROY_TAG;

	public static string MAINCAM;

	public static int TEAMCAPITAL;

	public static string CANTCLIMB;

	public const string TAG_IGNORECOLLISION = "IgnoreCollision";

	public const string TAG_ELECTRICPIPE = "ElectricPipe";

	public const string TAG_REFLECTIVE = "Reflective";

	public const string BT_EVENT_ENTER_WEAK = "enterWeak";

	public const string BT_EVENT_POSTURE_RECOVER = "postureRecover";

	public const string RECOVERMAXHP = "RecoverMaxHP";

	public const float BLACKSCREENFADEDURATION = 0.5f;

	public const float UI_DITHER_DURATION = 0.1f;

	static BattleConsts()
	{
		windowResolutionWidth = 2340f;
		windowResolutionHeight = 1080f;
		SHADER_EFFECT_MASKUVOFFSET = "_Mask_ST";
		SHADER_EFFECT_FLOWEMISSIONTEX = "_FlowEmissionTex_ST";
		AIM_ATTACH_POINT = "waist";
		tenResistance = 0.5f;
		HATRED_RANGE_Z_SIZE = 4f;
		BULLET_DESTROY_TAG = "BulletDestroy";
		MAINCAM = "mainCam";
		TEAMCAPITAL = 3;
		CANTCLIMB = "CantClimb";
		enviromentMask = 1704065;
		entityMask = 64;
		hitMask = 1024;
		interactMask = 131072;
		SHADER_DISSOLVE = Shader.PropertyToID("_DissolveThreshold");
		SHADER_DissolveEmmision = Shader.PropertyToID("_DissolveColor");
		SHADER_FAKE_LIGHT = Shader.PropertyToID("_FakeLight");
		SHADER_FAKE_LIGHT_DIR = Shader.PropertyToID("_FakeLightDir");
		SUB_EFFECT_FRESNEL_COLOR = Shader.PropertyToID("_FresnelColor");
		SUB_EFFECT_FRESNEL_RANGE = Shader.PropertyToID("_FresnelRange");
		SUB_EFFECT_FRESNEL_SMOOTH = Shader.PropertyToID("_FresnelSmooth");
		SUB_EFFECT_SHADER_DITHER = Shader.PropertyToID("_DitherValue");
		SUB_EFFECT_OUTLINE = Shader.PropertyToID("_EffectOutline");
		SUB_EFFECT_OUTLINE_COLOR = Shader.PropertyToID("_EffectOutlineColor");
		SUB_EFFECT_OUTLINE_WIDTH = Shader.PropertyToID("_EffectOutlineWidth");
		SUB_EFFECT_EMIT_COLOR = Shader.PropertyToID("_EffectEmitColor");
		SUB_EFFECT_EMIT = Shader.PropertyToID("_EffectEmit");
		SHADER_DISSOLVE_NEW_SCAN_LINE = Shader.PropertyToID("_ScanLine");
		SHADER_EFFECT_DISSOLVE_CUT = Shader.PropertyToID("_Cut");
		SHADER_EMISSION_COLOR = Shader.PropertyToID("_EmissionColor");
		SHADER_DISTANCECHANGE_COLOR = Shader.PropertyToID("_DistanceChangeColor");
		SHADER_GLITCHWEIGHT = Shader.PropertyToID("_GlitchWeight");
		SHADER_EFFECT_SCANRANGE = Shader.PropertyToID("_ScanRange");
		SHADER_EFFECT_NOISEOFFSETSCAN = Shader.PropertyToID("_NoiseOffsetScan");
		SHADER_EFFECT_SCANNOISEPOWER = Shader.PropertyToID("_NoisePower");
		SHAER_EFFECT_DISSOLVEEMMISION1 = Shader.PropertyToID("_DissolveColor1");
		SHAER_EFFECT_DISSOLVEEMMISION2 = Shader.PropertyToID("_DissolveColor2");
		SHAER_EFFECT_DISSOLVEDiIROFFSET = Shader.PropertyToID("_Dissolve_DirOffset");
		SHADER_ACT_NEW_DISSOLVE_CUT = Shader.PropertyToID("_Cut");
		SHAER_EFFECT_DODGEEFFECT = Shader.PropertyToID("needDodgeEffect");
		SHAER_EFFECT_BELTOFFSET = Shader.PropertyToID("_BaseMap_ST");
	}
}
