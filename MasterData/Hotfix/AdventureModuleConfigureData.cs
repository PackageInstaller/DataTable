using TrueSync;
using UnityEngine;

[CreateAssetMenu]
public class AdventureModuleConfigureData : ScriptableObject
{
	public TSVector2 Level_MaxSceneSize = new TSVector2(100f, 100f);

	public TSVector2 Level_MaxSceneSize_Min = new TSVector2(100f, 100f);

	public TSVector2 Level_SceneBlockSize = new TSVector2(50f, 50f);

	public TSVector2 Level_SceneCellSize = new TSVector2(4f, 4f);

	[Space]
	public int Level_MonsterPreloadCount = 3;

	public int Level_EpicMonsterPreloadCount = 2;

	public int Level_BossMonsterPreloadCount = 1;

	public FP Level_RefRoomMonsterDelayTime = 500;

	[Space]
	public FP Level_NavmeshUpdateInterval = 0.25f;

	public FP Level_NavigationMaxNearestNodeDistance = 100f;

	public FP Level_ReachableNearestNodeDistance = 0.5f;

	public FP Combat_HitboxDamageImmuneDuration = 0.5f;

	public FP Combat_HitboxContinuousDamageDetectInterval = 0.1f;

	public FP Combat_TrapImmuneDuration = 0.5f;

	[Space]
	public FP Combat_MaxAttackCooldownTime = 5f;

	[Space]
	public FP Skill_Locking_Time = 300f;

	[Space]
	public FP Combat_MaxJumpHeight = 6f;

	public FP Combat_MinJumpHeight = 3f;

	public FP Combat_MinJumpDuration = 0.3f;

	public FP Combat_Gravity = -10f;

	[Space]
	public FP PrefectDodge_BulletDistance = 2;

	public FP PrefectDodge_MonsterDistance = 5;

	public FP PrefectDodge_MeleeTime = 0.2f;

	[TSFPRange(0f, 1f)]
	public FP PrefectDodge_TimeScale = 0.1f;

	public FP PrefectDodge_TimeDuration = 0.5f;

	public FP PrefectDodge_TimeAfterDodgeBegin = 0.2f;

	public AdventurePlayerFeedbackEffectConfigureData FeedbackData_PrefectDodge;

	[Space]
	public FP dtRadius = 1.5f;

	[Space]
	public FP reloadDelayTime = 1f;

	[Space]
	public FP Actor_ReturnCDRate = 0.5f;

	[Space]
	public string BuffTag_ReduceAttr = "降低属性";

	public string BuffTag_Weaken = "减益";

	public string BuffTag_Enhance = "增益";

	public string BuffTag_ReduceMoveSpd = "减速";

	[Space]
	[TSFPRange(0f, 1f)]
	public FP FrozenTime_Scale = 0f;

	public Color WitchTime_BackgroundColor = Color.black;

	public string FrozenTime_FXPath = "";

	[Space]
	public float skillUnExecutableTipDuration = 5f;

	public ActorRelatedResourceConfig CommonRelatedResourceConfig;

	public FP Actor_NavAgentAvoidRadiusRate = 0.85f;

	public FP Actor_NavigationMinUpdateIntervalTime = 0.125f;

	public FP Actor_DefaultNavigationAccelerationScaleFactor = 0.25f;

	public FP Actor_DefaultNavigationRotationSpeedScaleFactor = 0.5f;

	[Space]
	public FP Actor_WalkMovementSpeedScaleFactor = 0.4f;

	[Space]
	public bool Actor_Shake = true;

	public float Actor_Shake_SingleDuration;

	public float Actor_Shake_Range;

	public int Actor_Shake_LoopTimes;

	[Space]
	public FP Actor_Damage_HurtEffectAndAudio_CD = 1;

	public string Actor_hit_effect = "FX/ScreenEffect/fx_screen_actor_hit";

	[Space]
	public string ToughnessBrokenFxPath;

	public int ToughnessBrokenState_BuffId;

	public string ToughnessBroken_IgnoreClearTag;

	public FP ToughnessBroken_RecoverTime = 0.1f;

	public FP ToughnessBroken_IdleDuration = 1f;

	public FP ToughnessProtectTime = 1f;

	[Space]
	public Color SearchRangeGizmoColor;

	public Color InputSearchRangeGizmoColor;

	public Color AttackRangeGizmoColor;

	public int Player_LearnableJobClassAbilitiesCountEachRank = 3;

	public FP SummonMonsterCorssLevelSpawnRadius = 3f;

	public FP TriggerElementMarkCD = 0.5f;

	public int BuffId_Glimmer;

	[Space]
	public Material Env_VisionIndicatorMaskMaterial;

	public Material Env_NavIndicatorMaskMaterial;

	public float FX_HurtCueEffectScaleFactor = 0.3f;

	public Vector2 FX_HurtCueEffectScaleFactorRange = new Vector2(1f, 2.5f);

	public Gradient FX_HurtCueEffectGradient;

	public Gradient FX_HurtCueEffectGradient_CEN;

	public float FX_HurtCueEffectExposure;

	[Min(0.01f)]
	public float FX_HurtCueEffectDuration = 0.3f;

	[Range(0f, 2f)]
	public float FX_HurtCueEffectStrokeWidth = 0.5f;

	[Range(0.01f, 2f)]
	public float FX_HurtCueEffectStrokeSmoothness = 0.25f;

	[Space]
	public float FX_BuffEffectAutoScaleFactor = 0.3f;

	public Vector2 FX_BuffEffectAutoScaleFactorRange = new Vector2(1f, 2.5f);

	[Space]
	public float FX_TagEffectAutoScaleFactor = 0.3f;

	public Vector2 FX_TagEffectAutoScaleFactorRange = new Vector2(1f, 2.5f);

	[Space]
	public Gradient FX_SuperArmorCueEffectGradient;

	public float FX_SuperArmorCueEffectExposure;

	[Min(0.01f)]
	public float FX_SuperArmorCueEffectDuration = 0.3f;

	[Range(0f, 1f)]
	public float FX_SuperArmorCueEffectStrokeWidth = 0.25f;

	[Space]
	public Gradient FX_ImmuneControlCueEffectGradient;

	public float FX_ImmuneControlCueEffectExposure;

	[Min(0.01f)]
	public float FX_ImmuneControlCueEffectDuration = 0.3f;

	[Range(0f, 1f)]
	public float FX_ImmuneControlCueEffectStrokeWidth = 0.5f;

	[Space]
	public Gradient FX_InvincibleCueEffectGradient;

	public float FX_InvincibleCueEffectExposure;

	[Min(0.01f)]
	public float FX_InvincibleCueEffectDuration = 0.3f;

	[Range(0f, 1f)]
	public float FX_InvincibleCueEffectStrokeWidth = 0.5f;

	[Space]
	public FP FX_DefaultFreezeFrameWhenDamage = 0.1f;

	public FP FX_DefaultFreezeFrameWhenCrit = 0.2f;

	public FP FX_DefaultFreezeFrameWhenToughnessBroken = 0.2f;

	public FP FX_DefaultFreezeFrameWhenKill = 0.2f;

	[TSFPRange(0f, 1f)]
	public FP FX_DefaultFreezeFrameTimeScaleWhenKill = 0.1f;

	[Space]
	public AdventurePlayerFeedbackEffectConfigureData FeedbackData_FinalKill;

	[Space]
	public GameObject FX_TeamUpgradeWhenBatteFinish;

	[Space]
	public string FX_VampireSurvivorSimplifyHurtFXPath;

	public int FX_VampireSurvivorSimplifyHurtFXPreloadCount;

	public float Network_DeterministicTransformSyncSmoothFactorPos = 0.035f;

	public float Network_DeterministicTransformSyncSmoothFactorRot = 0.6f;

	public string SkillTemplatePath;

	public float EnergyReduceTime = 10f;

	public int CharacterSkillAssignWeight = 3;

	public int MeleeCharacterNormalAttackAssignWeight = 3;

	public float AutoBattleDifferentActorSkillInterval = 1f;

	public float DynamicLoad_SceneObjLoadDistance = 50f;

	public int DynamicLoad_SceneObjFrameUpdateNum = 5;

	public float DynamicLoad_MonsterLoadDistance = 50f;

	public int DynamicLoad_MonsterFrameUpdateNum = 1;

	public float switchDuration = 0.1f;

	public float sFadeInDuration = 0.7f;

	public float cameraSwitchDuration = 0.3f;

	public FP BackOffset = 2;

	public FP SearchRadius = 12;

	public FP defRdin = 1.5;

	public FP defRd = 3;

	public int revivePer = 20;

	public FP assistBornOverlapDistance = 1;

	public FP assistBornRandomOuterRadius = 2;

	public FP assistJumpDistance = 1;

	public string assistInFx;

	public string assistOutFx;

	public string FX_StunFXPath = "";

	public string FX_StunFXPath_Weakened = "";

	public string FX_FrozenFXPath = "FX/Buff/fx_buff_ice";

	public string FX_FrozenFXPath_Weakened = "FX/Buff/fx_buff_ice";

	public string FX_FrozenFXPath_Break = "FX/ActorCommon/fx_common_base_ice_break";

	public string FX_SleepFXPath = "";

	public string FX_SleepFXPath_Weakened = "";

	public string FX_CharmFXPath = "";

	public string FX_CharmFXPath_Weakened = "";

	public string FX_TerrorFXPath = "";

	public string FX_TerrorFXPath_Weakened = "";

	public string FX_TauntFXPath = "";

	public string FX_TauntFXPath_Weakened = "";

	public string FX_BondageFXPath = "";

	public string FX_BondageFXPath_Weakened = "";

	public string FX_SilenceFXPath = "";

	public string FX_SilenceFXPath_Weakened = "";

	public string FX_ChaosFXPath = "";

	public string FX_ChaosFXPath_Weakened = "";

	public string FX_BlindnessFXPath = "";

	public string FX_BlindnessFXPath_Weakened = "";

	public string FX_ReduceFOVFXPath = "FX/ScreenEffect/fx_screen_frezon";

	public DeterministicShape Shap_Chaos = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Circle,
		radius = 6,
		angle = 360
	};

	public string normalShieldFxPath = "";

	public bool enableLogAndTips;

	public float logDuration = 5f;

	public int summonMaxNum = 5;

	public int monsterMaxCount = 5;

	public int flypyMaxNum_Player = 5;

	public int flypyMaxNum_Monster = 5;

	public int areaEffectMaxNum_Player = 5;

	public int areaEffectMaxNum_Monster = 5;

	public float RotTime;

	public float DelayTime;
}
