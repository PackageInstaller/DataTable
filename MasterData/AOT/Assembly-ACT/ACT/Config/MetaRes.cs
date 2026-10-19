using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Drama;
using ACT.RichText;
using ACT.Sound;
using Cinemachine;
using Lumin.LoungeSystem;
using PathFinding2D.Runtime.Settings;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.Config;

public class MetaRes : LuminSerializedScriptableObject
{
	public struct CustomAssetRefrence
	{
		public YooAssetReference assetReferenceAssetID;
	}

	[Range(0f, 10f)]
	public float NoInputThreshold = 2f;

	[Range(0f, 3f)]
	public float RangeNoInputThreshold = 0.3f;

	[Range(0f, 8f)]
	public float H_Length = 4f;

	[Range(0f, 8f)]
	public float V_Length = 6f;

	[Range(0f, 0.5f)]
	public float PlayerManualInputOverrideTime = 0.3f;

	[Space(30f)]
	[Range(1f, 179f)]
	public float upAngle = 90f;

	[Range(1f, 179f)]
	public float downAngle = 90f;

	[Range(1f, 179f)]
	public float absoluteUpAngle;

	[Range(1f, 179f)]
	public float absoluteDownAngle;

	[Range(0.01f, 1f)]
	public float joyconDeadzone;

	[Tooltip("仅当前操控角色在场景中升级才会播放特效")]
	public YooAssetReference characterLevelUpEffectAssetID;

	public bool skipPlot;

	public float enterRepeatDelay;

	public float repeatInterval;

	public float deadZoneOnEnter;

	public float deadZoneOnRepeat;

	[Tooltip("掉落物来源为Monster时，在XY平面的修正旋转范围，只能配从0度开始，不要超过90度")]
	public Vector2 monsterDropControlRandomRotationRange;

	[Tooltip("掉落物来源为Monster时，有方向时的速度范围")]
	public Vector2 monsterDropHasDirVelocity;

	[Tooltip("掉落物来源为Monster时，没方向时的速度范围")]
	public Vector2 monsterDropHasNoDirVelocity;

	[Tooltip("怪物掉落物飞出时伴随的额外物品品质特效")]
	public Dictionary<int, YooAssetReference> monsterDropExtraEffects;

	[Tooltip("x,y,z分别为绕x,y,z轴旋转的范围")]
	public Vector3 dropControlRandomRotationRange;

	[Tooltip("x,y为速度区间")]
	public Vector2 dropControlRandomVelocity;

	public YooAssetReference[] defaultItemBhaveAssetID;

	[Tooltip("掉落物捡起前的delay时间")]
	public Vector2 collectCD;

	[Tooltip("掉落物捡起飞行时间")]
	public Vector2 collectDuration = new Vector2(1f, 2f);

	[Tooltip("掉落贝塞尔曲线控制点x坐标关于deltaX的曲线")]
	public AnimationCurve pickControlCurveX;

	[Tooltip("掉落贝塞尔曲线控制点y坐标关于deltaY的曲线")]
	public AnimationCurve pickControlCurveY;

	[Tooltip("掉落物捡起时的effect")]
	public YooAssetReference[] collectedEffectAssetID;

	[Tooltip("掉落物特效cd")]
	public float collectedEffectCd;

	[Tooltip("掉落物node bounds")]
	public Vector3 dropNodeSize = new Vector3(20f, 20f, 10f);

	public Vector3[] particleRandomDirections;

	public Vector2 particleRandomDegree;

	public Vector2 particleRandomLengthSqrt;

	public Vector2 particleRandomVelocity;

	public ConfigColor elementUi;

	public Dictionary<AbilityEntityType, int> abilityEntityCountLimit = new Dictionary<AbilityEntityType, int>();

	public Dictionary<AbilityEntityType, DerivativeType> abilityEntityDerivativeType = new Dictionary<AbilityEntityType, DerivativeType>();

	public Dictionary<AbilityEntityType, DerivativeSubType> abilityEntityDerivativeSubType = new Dictionary<AbilityEntityType, DerivativeSubType>();

	public List<ConfigAbilityList> abLists;

	public List<float> pathOffsetChangeArray;

	public ConfigDebuff configDebuff;

	public ConfigDynamicValue configDynamicValue;

	public ConfigProperty configProperty;

	public RealTimeConversationResources dialogResources;

	public ConfigGroundLightDiePara configGroundLightDiePara;

	public ConfigGlobalSpeed hitGlobalSpeed;

	public float ditherTime = 0.5f;

	public float hitEffectTime = 0.1f;

	public float getHitTime = 0.1f;

	public ConfigCommonEnemyInfo enemyInfo;

	public ConfigHitEffectComparisonTable hitEffectComparisonTable;

	[Tooltip("破盾时的通用处理")]
	public ConfigBreakPostureActions breakPostureActions;

	public ConfigEffectDress configEffectDress;

	public ConfigFOVControlCameraNoise fovControlConfig;

	[Tooltip("控制相机焦点的输入引导、平滑、防抖等参数")]
	public ConfigCameraFocus cameraFocusConfig;

	public float coyoteTime = 0.1f;

	public float lastConflictTriggerTimer = 0.2f;

	public float dissolveTime = 0.5f;

	public float roleGetHitTime = 0.1f;

	public float roleGetHitLightTime = 0.1f;

	public float roleDummyDuration = 0.4f;

	public float canDoWitchTime = 0.2f;

	public float roleDummyRadius;

	public float roleDummyHeight;

	public float roleAttackCompensation;

	[Tooltip("后续如果传送等系统上要用就用这个")]
	public float battleTeamDissolveTime = 0.8f;

	[Tooltip("后续如果传送等系统上要用就用这个")]
	public float refreshEnemyArrowsHeightOffset;

	public YooAssetReference attComReferenceAssetID;

	public YooAssetReference desComReferenceAssetID;

	public YooAssetReference taskTypeAtlasNameAssetID;

	public YooAssetReference mapIconnReferenceAssetID;

	public Texture2D normal;

	public Texture2D pressed;

	public Texture2D above;

	public Texture2D unallowed;

	public YooAssetReference itemTMPSa;

	public YooAssetReference equipTMPSa;

	public YooAssetReference eliteTMPSa;

	public YooAssetReference bottleTMPSa;

	[SerializeField]
	private YooAssetReference _tmpPrompt;

	[SerializeField]
	private YooAssetReference _skillSheet;

	public YooAssetReference cookIconAtlasAssetID;

	public YooAssetReference constellationAtlasNameAssetID;

	public YooAssetReference itemAtlasNameAssetID;

	public YooAssetReference characterHalfBodyAtlasNameAssetID;

	public YooAssetReference characterCircleHeadIconAssetID;

	public YooAssetReference characterHalfBodyLitAssetID;

	public YooAssetReference charaHeadAtlasNameAssetID;

	public YooAssetReference characterPaintingNameAssetID;

	public YooAssetReference buffAtlasNameAssetID;

	public YooAssetReference mapIconNameAssetID;

	public YooAssetReference missionTypeNameAssetID;

	public YooAssetReference raidAtlasNameAssetID;

	public YooAssetReference abyssTeamAtlasNameAssetID;

	public YooAssetReference teamAtlasNameAssetID;

	public YooAssetReference attributeNameAssetID;

	public YooAssetReference CharacterSquareHeadIconAssetID;

	public YooAssetReference dramaAsideAtalasNameAssetID;

	public YooAssetReference dramaConversationAtalasNameAssetID;

	public YooAssetReference characterViewAtlasNameAssetID;

	public YooAssetReference cardPoolAtlasNameAssetID;

	public YooAssetReference cardPoolFullBodyAssetID;

	public YooAssetReference cardPoolHalfBodyAssetID;

	public YooAssetReference chipSuitAtlasNameAssetID;

	public YooAssetReference elementUltraSkillAtlasNameAssetID;

	public YooAssetReference interactIconNameAssetID;

	public YooAssetReference elementAssetID;

	public YooAssetReference professionAssetID;

	public YooAssetReference weaponTypeAssetID;

	public YooAssetReference elementalResonanceAtlasAssetID;

	public YooAssetReference monsterheadiconAtlasAssetID;

	[FormerlySerializedAs("bossHeadAtlas")]
	public YooAssetReference MonsterCircleHeadAtlasAssetID;

	public YooAssetReference romanAtlasAssetID;

	public YooAssetReference TreasureMapAtlasAssetID;

	public YooAssetReference realElementAtlasAssetID;

	public YooAssetReference chipSuitLittleIconAssetID;

	public YooAssetReference chipViewIconAssetID;

	public YooAssetReference missionArrowEffect;

	public YooAssetReference uiSceneReferenceAssetID;

	public YooAssetReference uiCharacterSceneReferenceAssetID;

	public YooAssetReference uiConversationSceneReferenceAssetID;

	public YooAssetReference characterViewV3SceneReferenceAssetID;

	public YooAssetReference characterSkinViewSceneReferenceAssetID;

	public YooAssetReference characterPresentationViewSceneReferenceAssetID;

	public YooAssetReference rogueTeamViewSceneReferenceAssetID;

	public YooAssetReference carddrawSceneReferenceAssetID;

	public YooAssetReference characterTimelineShowSceneReferenceAssetID;

	public YooAssetReference uiMosterSceneReferenceAssetID;

	public YooAssetReference uiExploringChallengeSceneReferenceAssetID;

	public YooAssetReference loungeSceneReferenceAssetID;

	public YooAssetReference conversationSceneBlurAssetID;

	public YooAssetReference collectionPointReferenceAssetID;

	public YooAssetReference collectionGemReferenceAssetID;

	public YooAssetReference raidRewardPointReferenceAssetID;

	public YooAssetReference raidBossChallengeRewardPointReferenceAssetID;

	public YooAssetReference TempleRewardPointReferenceAssetID;

	public YooAssetReference battleTempleBuffGiveReferenceAssetID;

	public YooAssetReference templeCheckPointReferenceAssetID;

	public YooAssetReference monsterPointReferenceAssetID;

	public YooAssetReference elevatorConsoleReferenceAssetID;

	public YooAssetReference damageableReferenceAssetID;

	public YooAssetReference lightHouseReferenceAssetID;

	public YooAssetReference transferReferenceAssetID;

	public YooAssetReference npcPointReferenceAssetID;

	public YooAssetReference interactBehaveControlReferenceAssetID;

	public YooAssetReference dropItemReferenceAssetID;

	public YooAssetReference blackFogReferenceAssetID;

	public YooAssetReference stateFlagReferenceAssetID;

	public YooAssetReference stateTriggerReferenceAssetID;

	public YooAssetReference onceCollectionHideReferenceAssetID;

	public YooAssetReference raidEnterReferenceAssetID;

	public YooAssetReference templeEnterReferenceAssetID;

	public YooAssetReference readObjectReferenceAssetID;

	public YooAssetReference collectReadObjectReferenceAssetID;

	public YooAssetReference raidTrapReferenceAssetID;

	public YooAssetReference raidCollectorReferenceAssetID;

	public YooAssetReference raidCheckPointReferenceAssetID;

	public YooAssetReference clawReferenceAssetID;

	public YooAssetReference NPCVolumeEffectAssetID;

	public YooAssetReference worldMonsterPointReferenceAssetID;

	public YooAssetReference bloodStainReferenceAssetID;

	public YooAssetReference weakRefrenceAssetID;

	public YooAssetReference enemyWeakRefrenceAssetID;

	public ActionFireEffect shieldHitEffect;

	public YooAssetReference switchOutReferenceAssetID;

	public AudioEventReference switchOutSoundEvent;

	public AudioEventReference parrySoundEvent;

	public AudioEventReference assistFullSoundEvent;

	[Tooltip("小怪UI预制件")]
	public YooAssetReference monsterCustomUIReferenceAssetID;

	[Tooltip("精英怪UI预制件")]
	public YooAssetReference eliteMonsterCustomUIReferenceAssetID;

	[Tooltip("精英怪UI预制件")]
	public YooAssetReference trajectoryCustomUIReferenceAssetID;

	[Tooltip("助战Npc血条")]
	public YooAssetReference assistNpcCustomUIReferenceAssetID;

	[Tooltip("精英怪UI预制件")]
	public YooAssetReference npcUIReferenceAssetID;

	[Tooltip("引导特效")]
	public YooAssetReference guidEffectReferenceAssetID;

	public List<YooAssetReference> assetRefrencesAssetID = new List<YooAssetReference>();

	public List<YooAssetReference> volumeRefrencesAssetID = new List<YooAssetReference>();

	private Dictionary<string, int> customAssetRefrencesDic = new Dictionary<string, int>();

	public Material[] matOverrides;

	public CurveLibrary curveLibrary;

	public ACTCustomTagConfig actTagConfig;

	public GameObject shadowCaster;

	public GameObject uiRobot;

	public YooAssetReference robotShowReferenceAssetID;

	public YooAssetReference robotHideReferenceAssetID;

	[Tooltip("特效旋转角度")]
	public float EffectRandomAngle;

	[Tooltip("要和HitType的值一一对应")]
	public float[] ikStrength;

	public ConfigGroupAIList groupAIs;

	public float barShakePercent;

	public float monsterBarShakePercent;

	public List<YooAssetReference> CommonBanksAssetID = new List<YooAssetReference>();

	[HideInInspector]
	public List<int> MissionList = new List<int>();

	public List<YooAssetReference> MissionBanksAssetID = new List<YooAssetReference>();

	public ConfigContextTypes configContextTypes;

	public ConfigMonoSkillEvt configMonoSkillEvt;

	public ConfigChangeCharacter switchSkillChangeCharacter;

	public ConfigChangeCharacter battleChangeCharacter;

	public GameObject traceCam;

	public ConfigHitOnWall hitOnWallParameter;

	public Vector2 lengthRandomRange = Vector2.one;

	public MapConfig mapConfig;

	public LoungeConfig LoungeConfig;

	public EnemyMaterialConfig enemyMaterialConfig;

	public Vector3 cameraFollowOffset = new Vector3(0f, 0.9f, 0f);

	[SerializeField]
	[Header("FOV缩放时Y轴偏移")]
	private float _adultFovOffsetY = 0.7f;

	[SerializeField]
	[Header("每次缩放的时间")]
	private float _zoomLerpTime = 0.2f;

	[SerializeField]
	[Range(0f, 1f)]
	[Header("每次缩放步进百分比")]
	private float _zoomStep = 0.2f;

	[SerializeField]
	[Header("手机上每次缩放的时间")]
	private float _mobileZoomLerpTime = 0.2f;

	[SerializeField]
	[Range(0f, 1f)]
	[Header("手机上每次缩放步进百分比")]
	private float _mobileZoomStep = 0.2f;

	public float EditorCameraNoiseStrength = 1f;

	public float MobileCameraNoiseStrength = 1f;

	public float ExitBossBattleTime;

	public float ExitMonsterTime;

	public ACTDebugCommandConfig missionAccountConfig;

	public float controlPathDistance;

	public YooAssetReference signalReferenceAssetID;

	public YooAssetReference spotLightVolumeMatAssetID;

	public ConfigDynamicVarMap dynamicVarMap;

	public ConfigBattleTimeline battleTimelineConfig;

	public YooAssetReference templeLockStateTimeline;

	public YooAssetReference templeUnLockStateTimeline;

	[SerializeField]
	private YooAssetReference _teleportMoveInteractTimeline;

	[SerializeField]
	private YooAssetReference _teleportMoveTpAndRespawnTimeline;

	public NPCHeadIconConfig npcOrInteractObjectIconConfig;

	[NonSerialized]
	public NpcGlobalConfig npcGlobalConfig;

	public YooAssetReference femaleMainCharacterModel;

	public YooAssetReference maleMainCharacterModel;

	public NoiseSettings npcCameraNoise;

	public YooAssetReference switchRoleEffect;

	public YooAssetReference npcDialogueBubble;

	public YooAssetReference _triggerTutorialComponent;

	public RaidPerformanceConfig battleRoomPerformanceConfig;

	public NavigationRuntimeProfile navigationRuntimeProfile;

	public YooAssetReference TmpPrompt => _tmpPrompt;

	public YooAssetReference SkillSheet => _skillSheet;

	public float ZoomLerpTime => _zoomLerpTime;

	public float ZoomStep => _zoomStep;

	public float MobileZoomLerpTime => _mobileZoomLerpTime;

	public float MobileZoomStep => _mobileZoomStep;

	public float AdultFovOffsetY => _adultFovOffsetY;

	public YooAssetReference TeleportMoveInteractTimeline => _teleportMoveInteractTimeline;

	public YooAssetReference TeleportMoveTpAndRespawnTimeline => _teleportMoveTpAndRespawnTimeline;

	public ConfigAbility GetAbility(int id)
	{
		int index = (id & -16777216) >> 24;
		int num = id & 0xFFFFFF;
		return abLists[index].abilities[num];
	}

	public YooAssetReference GetAssetRefernce(int index)
	{
		try
		{
			return assetRefrencesAssetID[index];
		}
		catch
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"{index} not in assetRefrences !!! 在BatchBuild窗口重新执行MetaRes");
			}
			return null;
		}
	}
}
