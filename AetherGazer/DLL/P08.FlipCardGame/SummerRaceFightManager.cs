using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using ControllerExSpace;
using UnityEngine;

public class SummerRaceFightManager : MonoBehaviour
{
	[Serializable]
	private sealed class RuntimeLaunchConfig
	{
		public string activityId = string.Empty;

		public bool hasMode;

		public FightMode mode;

		public string stageId = string.Empty;

		public int startWaveIndex;

		public string playerBuildName = string.Empty;

		public bool hasPlayerBuildOverride;

		public SummerRaceBodyType playerBodyType = SummerRaceBodyType.Medium;

		public WeaponKind[] playerWeaponKinds = Array.Empty<WeaponKind>();

		public int[] playerWeaponSlotIndices = Array.Empty<int>();

		public SummerRacePlayerController.WeaponProfileOverrideSpec[] playerWeaponOverrides = Array.Empty<SummerRacePlayerController.WeaponProfileOverrideSpec>();

		public EquipKind[] playerEquipKinds = Array.Empty<EquipKind>();

		public int[] playerEquipSlotIndices = Array.Empty<int>();

		public SummerRacePlayerController.EquipProfileOverrideSpec[] playerEquipOverrides = Array.Empty<SummerRacePlayerController.EquipProfileOverrideSpec>();

		public SummerRacePlayerController.BodyProfileOverrideSpec playerBodyOverride;

		public string enemyBuildName = string.Empty;

		public bool hasEnemyBuildOverride;

		public SummerRaceBodyType enemyBodyType = SummerRaceBodyType.Medium;

		public WeaponKind[] enemyWeaponKinds = Array.Empty<WeaponKind>();

		public EquipKind[] enemyEquipKinds = Array.Empty<EquipKind>();

		public string[] enemyIds = Array.Empty<string>();

		public bool hasActivitySourceOverride;

		public SummerRaceActivityStageSourceRecord[] activityStageSources = Array.Empty<SummerRaceActivityStageSourceRecord>();

		public SummerRaceActivityEnemySourceRecord[] activityEnemySources = Array.Empty<SummerRaceActivityEnemySourceRecord>();

		public SummerRaceActivityWeaponSourceRecord[] activityWeaponSources = Array.Empty<SummerRaceActivityWeaponSourceRecord>();

		public SummerRaceActivityEquipSourceRecord[] activityEquipSources = Array.Empty<SummerRaceActivityEquipSourceRecord>();
	}

	[Serializable]
	private sealed class LuaLaunchPayload
	{
		public string mode = string.Empty;

		public string stageId = string.Empty;

		public int startWaveIndex;

		public string activityId = string.Empty;

		public string playerBuildName = string.Empty;

		public LuaPlayerConfig playerConfig;

		public LuaEnemyConfig enemyConfig;

		public LuaActivityConfig activityConfig;
	}

	[Serializable]
	private sealed class LuaBodyOverrideConfig
	{
		public float hp = float.NaN;

		public float baseHp = float.NaN;

		public float cost = float.NaN;

		public float costCap = float.NaN;

		public float speed = float.NaN;

		public float moveSpeed = float.NaN;

		public float forwardAcceleration = float.NaN;

		public float mass = float.NaN;

		public float drag = float.NaN;

		public float angularDrag = float.NaN;

		public float gravityScale = float.NaN;

		public float tractionGain = float.NaN;

		public float collisionImpulseScale = float.NaN;
	}

	[Serializable]
	private sealed class LuaPlayerConfig
	{
		public string buildName = string.Empty;

		public string bodyKey = string.Empty;

		public string[] weaponKeys = Array.Empty<string>();

		public int[] weaponSlotIndices = Array.Empty<int>();

		public LuaWeaponOverrideConfig[] weaponOverrides = Array.Empty<LuaWeaponOverrideConfig>();

		public string[] equipKeys = Array.Empty<string>();

		public int[] equipSlotIndices = Array.Empty<int>();

		public LuaEquipOverrideConfig[] equipOverrides = Array.Empty<LuaEquipOverrideConfig>();

		public LuaBodyOverrideConfig bodyOverrides;

		public float hp = float.NaN;

		public float baseHp = float.NaN;

		public float cost = float.NaN;

		public float costCap = float.NaN;

		public float speed = float.NaN;

		public float moveSpeed = float.NaN;

		public float forwardAcceleration = float.NaN;

		public float mass = float.NaN;

		public float drag = float.NaN;

		public float angularDrag = float.NaN;

		public float gravityScale = float.NaN;

		public float tractionGain = float.NaN;

		public float collisionImpulseScale = float.NaN;
	}

	[Serializable]
	private sealed class LuaWeaponOverrideConfig
	{
		public string weaponKey = string.Empty;

		public int cost;

		public float energyCost;

		public int damage;

		public float rof;

		public bool hasBurnOverride;

		public int burnDps;

		public float burnDuration;

		public float[] effectParams = Array.Empty<float>();
	}

	[Serializable]
	private sealed class LuaEquipOverrideConfig
	{
		public string equipKey = string.Empty;

		public int cost;

		public float energyCost;
	}

	[Serializable]
	private sealed class LuaEnemyConfig
	{
		public string buildName = string.Empty;

		public string bodyKey = string.Empty;

		public string[] weaponKeys = Array.Empty<string>();

		public string[] equipKeys = Array.Empty<string>();

		public string[] enemyIds = Array.Empty<string>();
	}

	[Serializable]
	private sealed class LuaActivityConfig
	{
		public string activityId = string.Empty;

		public LuaActivityStageConfig stage;

		public LuaActivityEnemySourceConfig[] enemies = Array.Empty<LuaActivityEnemySourceConfig>();

		public LuaActivityWeaponSourceConfig[] weapons = Array.Empty<LuaActivityWeaponSourceConfig>();

		public LuaActivityEquipSourceConfig[] equips = Array.Empty<LuaActivityEquipSourceConfig>();
	}

	[Serializable]
	private sealed class LuaActivityWeaponSourceConfig
	{
		public string weaponKey = string.Empty;

		public string displayName = string.Empty;

		public int cost;

		public float energyCost;

		public float cooldownSeconds;

		public int damage;

		public float rof;

		public bool hasBurnOverride;

		public int burnDps;

		public float burnDuration;

		public float[] effectParams = Array.Empty<float>();
	}

	[Serializable]
	private sealed class LuaActivityEquipSourceConfig
	{
		public string equipKey = string.Empty;

		public string displayName = string.Empty;

		public int cost;

		public float energyCost;

		public float cooldownSeconds;
	}

	[Serializable]
	private sealed class LuaActivityStageConfig
	{
		public string stageId = string.Empty;

		public string mode = string.Empty;

		public string mapName = string.Empty;

		public int sortOrder;

		public bool isMainline = true;

		public string challengePoolId = string.Empty;

		public int recommendedPower;

		public int timeLimitSeconds;

		public int survivalDurationSeconds;

		public float challengeWaveHealRatio = float.NaN;

		public float damageToEnergyRatio = float.NaN;

		public float energyRegenPerSecond = float.NaN;

		public float maxEnergy = float.NaN;

		public int[] challengeWaveScoreTable = Array.Empty<int>();

		public LuaActivitySpecialDefeatRuleConfig[] specialDefeatRules = Array.Empty<LuaActivitySpecialDefeatRuleConfig>();

		public LuaActivityWaveConfig[] waves = Array.Empty<LuaActivityWaveConfig>();

		public LuaActivitySpawnConfig[] survivalRandomPool = Array.Empty<LuaActivitySpawnConfig>();

		public LuaActivitySpawnConfig[] challengeRandomPool = Array.Empty<LuaActivitySpawnConfig>();
	}

	[Serializable]
	private sealed class LuaActivitySpecialDefeatRuleConfig
	{
		public int waveIndex;

		public string enemyId = string.Empty;

		public int guideId;

		public string fxId = string.Empty;
	}

	[Serializable]
	private sealed class LuaActivityWaveConfig
	{
		public int waveIndex;

		public float spawnIntervalSeconds;

		public int maxAliveEnemies;

		public int timeLimitSeconds;

		public string[] enemyIds = Array.Empty<string>();
	}

	[Serializable]
	private sealed class LuaActivitySpawnConfig
	{
		public string enemyId = string.Empty;

		public int count = 1;

		public float spawnDelaySeconds;

		public int weight = 1;

		public int minWave = 1;

		public int maxWave = 999;
	}

	[Serializable]
	private sealed class LuaActivityEnemySourceConfig
	{
		public string enemyId = string.Empty;

		public string displayName = string.Empty;

		public string buildName = string.Empty;

		public string buildAssetName = string.Empty;

		public string build_asset_name = string.Empty;

		public string bodyKey = string.Empty;

		public string bodyIcon = string.Empty;

		public string logo = string.Empty;

		public string[] weaponKeys = Array.Empty<string>();

		public string[] equipKeys = Array.Empty<string>();

		public int baseHp = 1;

		public float moveSpeed;

		public float damageMultiplier = 1f;

		public string battleIntroText = string.Empty;

		public string overclockBubbleText = string.Empty;

		public string defeatEffect = string.Empty;
	}

	[Serializable]
	private sealed class SpecialDefeatEventPayload
	{
		public int token;

		public string stageId = string.Empty;

		public int wave;

		public string enemyId = string.Empty;

		public int guideId;

		public string fxId = string.Empty;
	}

	[Serializable]
	private sealed class SpecialDefeatFinishedPayload
	{
		public int token;

		public string resumedPhase = string.Empty;
	}

	[Serializable]
	private sealed class EnemyDefeatBeforeFxEventPayload
	{
		public int token;

		public string stageId = string.Empty;

		public int wave;

		public string enemyId = string.Empty;
	}

	[Serializable]
	private sealed class TimeoutResultEventPayload
	{
		public string result = string.Empty;

		public string reason = "timeout";

		public float delaySeconds;
	}

	[Serializable]
	private sealed class BattleResultBannerEventPayload
	{
		public string result = string.Empty;

		public string reason = "battle";

		public float delaySeconds;
	}

	public enum FightMode
	{
		Championship,
		SurvivalPractice,
		OneVsTwoPractice,
		Challenge
	}

	private enum FightPhase
	{
		Countdown,
		Battle,
		SpecialDefeatPending,
		Result
	}

	private sealed class EnemySpawnMeta
	{
		public int WaveIndex;

		public string EnemyId = string.Empty;

		public string DefeatEffect = string.Empty;

		public float SpawnX;

		public float SpawnY;
	}

	private static PhysicsMaterial2D arenaFloorMaterial;

	private static PhysicsMaterial2D arenaBoundaryMaterial;

	private const string DefaultFightMapName = "Activity_SummerRace_FightBg_01";

	private const string DemonCastleFightMapName = "Activity_SummerRace_FightBg_02";

	private const string FightMapSpriteFolder = "TextureBg/Activity_SummerRace/";

	private const string FightMapControllerName = "bg";

	private const string FightMapRaceCityState = "raceCity";

	private const string FightMapDemonCastleState = "demonCastle";

	private const string ResultReasonTimeout = "timeout";

	private const string ResultReasonGiveUp = "giveup";

	private const float CameraReferenceAspect = 1.7777778f;

	private const float TimeoutResultDelaySeconds = 2f;

	private const float BattleResultBannerDelaySeconds = 2f;

	[Header("Mode")]
	[SerializeField]
	private FightMode fightMode;

	[SerializeField]
	private bool physicsTestMode;

	[Header("Spawn")]
	[SerializeField]
	private string[] spawnNames = new string[1] { "SpawnRight" };

	[SerializeField]
	private string playerSpawnName = "PlayerSpawn";

	[SerializeField]
	private float sideLaneY = -1.3f;

	[SerializeField]
	private bool ensureEnemyBodyVariety = true;

	[SerializeField]
	private int initialEnemyCount = 3;

	[SerializeField]
	private float minEnemySpawnGapX = 1.9f;

	[SerializeField]
	private float minSpawnToPlayerGapX = 3f;

	[SerializeField]
	private float spawnColliderPaddingX = 0.18f;

	[SerializeField]
	private float spawnSearchStepX = 0.95f;

	[SerializeField]
	private int spawnSearchSteps = 8;

	[SerializeField]
	private float spawnMinX = -8.4f;

	[SerializeField]
	private float spawnMaxX = 8.4f;

	[SerializeField]
	private bool enforceOpeningFixedSpawnX = true;

	[SerializeField]
	private float openingSpawnLeftX = -8f;

	[SerializeField]
	private float openingSpawnRightX = 6f;

	[SerializeField]
	private float openingSpawnPlayerForbiddenGapX = 4.2f;

	[SerializeField]
	private float survivalFirstSpawnPlayerForbiddenGapX = 5.8f;

	[SerializeField]
	private bool enableEnemyBuildDiversity = true;

	[SerializeField]
	private bool balanceEnemyArchetype = true;

	[SerializeField]
	private int enemyBuildMemorySize = 8;

	[SerializeField]
	private int enemyBuildRerollAttempts = 6;

	[Header("Championship")]
	[SerializeField]
	private float championshipSpawnInterval = 1f;

	[Header("Survival")]
	[SerializeField]
	private float survivalDuration = 120f;

	[SerializeField]
	private float survivalSpawnInterval = 20f;

	[SerializeField]
	private int survivalTotalEnemies = 6;

	[Header("1v2")]
	[SerializeField]
	private float oneVsTwoSpawnInterval = 0.8f;

	[Header("Challenge")]
	[SerializeField]
	private float challengeSpawnInterval = 1.1f;

	[SerializeField]
	private int challengeMaxAlive = 8;

	[SerializeField]
	private int challengeInitialWaveEnemies = 3;

	[SerializeField]
	private int challengeWaveEnemyGrowth = 1;

	[SerializeField]
	private int challengeMaxAliveGrowth = 1;

	[SerializeField]
	private float challengeMinSpawnInterval = 0.45f;

	[SerializeField]
	private float challengeSpawnIntervalDecay = 0.08f;

	private const int SurvivalMaxAliveEnemyCount = 2;

	private const int ChallengeMaxWaveCount = 20;

	private const float CountdownReadyDurationSeconds = 1.1f;

	private const float CountdownStartDurationSeconds = 1f;

	private const float PlayerLabelPosePublishBattleSeconds = 5f;

	private static readonly int[] ChallengeWaveScoreTable;

	[Header("Enemy Tunings")]
	[SerializeField]
	private int baseEnemyHp = 3;

	[SerializeField]
	private float baseEnemySpeed = 2.5f;

	[SerializeField]
	private int baseEnemyCollisionDamage = 1;

	[Header("Activity Config")]
	[SerializeField]
	private string activityId = "tank";

	[SerializeField]
	private string activityBuildDatabaseName = string.Empty;

	[SerializeField]
	private SummerRaceActivityStageSourceRecord[] activityStageSource = Array.Empty<SummerRaceActivityStageSourceRecord>();

	[Header("UI")]
	[SerializeField]
	private bool runtimeDebugLog;

	[SerializeField]
	private bool drawArenaColliderOutlineInGame;

	[SerializeField]
	private bool forceDefault2DMaterialForSceneSpriteRenderers = true;

	[SerializeField]
	private bool forceArenaFloorPositionFromCode;

	[SerializeField]
	private float arenaFloorYOffsetFromLane = -2.7f;

	[Header("Camera")]
	[SerializeField]
	private bool autoFrameCamera = true;

	[SerializeField]
	private bool respectLuaMainCameraControl = true;

	[SerializeField]
	private float cameraOrthoSize = 5.2f;

	[SerializeField]
	private float cameraYOffsetFromLane = 1.2f;

	[SerializeField]
	private float cameraOverviewOrthoSize = 6.5f;

	[SerializeField]
	private float cameraSafeZoneRatio = 0.72f;

	[SerializeField]
	private float cameraVehiclePadding = 0.75f;

	[SerializeField]
	private float cameraVehicleCenterYOffset = -0.15f;

	[SerializeField]
	private bool cameraClampToBgBounds = true;

	[SerializeField]
	private string cameraBgRootName = "Bg";

	[SerializeField]
	private float cameraBottomSafePadding = 0.25f;

	[SerializeField]
	private float cameraTopSafePadding = 0.25f;

	[SerializeField]
	private float cameraSmoothTime = 0.28f;

	[SerializeField]
	private float cameraPushSpeed = 1.5f;

	[SerializeField]
	private float cameraPullSpeed = 3.5f;

	[SerializeField]
	private float cameraCollisionShakeMinSpeed = 3.2f;

	[SerializeField]
	private float cameraCollisionShakeAmplitude = 0.08f;

	[SerializeField]
	private float cameraCollisionShakeDuration = 0.12f;

	[SerializeField]
	private float cameraDefeatShakeAmplitude = 0.14f;

	[SerializeField]
	private float cameraDefeatShakeDuration = 0.18f;

	private FightPhase phase;

	private SummerRacePlayerController player;

	private Transform[] spawnPoints;

	private Transform playerSpawnAnchor;

	private float countdownRemaining;

	private float currentWaveTimeLimitSeconds;

	private float currentWaveRemainingSeconds;

	private float battleElapsed;

	private float waveElapsedBaseline;

	private float nextSpawnTime;

	private int aliveEnemies;

	private int spawnedEnemies;

	private int forcedEnemyBodyCursor;

	private int destroyedEnemies;

	private int currentWaveIndex;

	private int enemiesToSpawnThisWave;

	private int enemiesKilledThisWave;

	private int currentWaveTotal;

	private int challengeScore;

	private int challengeBestScore;

	private int challengeBestWave;

	private int challengeLastScore;

	private int challengeLastWave;

	private int currentChallengeMaxAlive;

	private bool resultWin;

	private string resultText = string.Empty;

	private string resultReason = string.Empty;

	private Coroutine timeoutResultCoroutine;

	private Coroutine timeoutWinWaveAdvanceCoroutine;

	private Coroutine battleResultBannerCoroutine;

	private bool timeoutWinResultShownForWave;

	private bool timeoutWinDefeatPending;

	private bool battleResultBannerPending;

	private bool battleResultRuntimeLocked;

	private bool battleResultCameraFrozen;

	private int pendingBattleResultSpecialDefeatFinishedToken;

	private Vector3 battleResultFrozenCameraPosition;

	private float battleResultFrozenCameraOrthoSize;

	private bool lastRuntimeDebugLogForwarded;

	private bool applyPreparedLaunchRestart;

	private bool isPaused;

	private bool bootstrappedForPlay;

	private bool initialEnemiesSpawned;

	private bool suppressRuntimeSnapshotForLoseSettlement;

	private float lastBootstrapAt = -999f;

	private readonly List<SummerRaceEnemy> aliveEnemyRefs = new List<SummerRaceEnemy>();

	private readonly List<SummerRaceBuildBlueprint> spawnedEnemyBlueprints = new List<SummerRaceBuildBlueprint>();

	private readonly List<float> spawnCandidateOffsets = new List<float>(20);

	private readonly Queue<string> recentEnemyBuildSignatureQueue = new Queue<string>();

	private readonly HashSet<string> recentEnemyBuildSignatureSet = new HashSet<string>();

	private readonly Dictionary<SummerRaceBuildArchetype, int> enemyArchetypeSpawnCounts = new Dictionary<SummerRaceBuildArchetype, int>();

	private readonly Dictionary<SummerRaceEnemy, EnemySpawnMeta> enemySpawnMetaMap = new Dictionary<SummerRaceEnemy, EnemySpawnMeta>();

	private readonly List<SummerRaceActivitySpecialDefeatRuleContract> activeSpecialDefeatRules = new List<SummerRaceActivitySpecialDefeatRuleContract>();

	private readonly Queue<SummerRaceActivityEnemyContract> pendingCatalogWaveEnemies = new Queue<SummerRaceActivityEnemyContract>();

	private readonly List<SummerRaceActivityEnemySpawnContract> survivalCatalogEntries = new List<SummerRaceActivityEnemySpawnContract>();

	private readonly List<SummerRaceActivityEnemySpawnContract> challengeWavePoolEntries = new List<SummerRaceActivityEnemySpawnContract>();

	private readonly List<SummerRaceRoundSettlement> roundSettlementRecords = new List<SummerRaceRoundSettlement>();

	private readonly List<SummerRaceSurvivalEnemySettlement> survivalEnemySettlementRecords = new List<SummerRaceSurvivalEnemySettlement>();

	private readonly List<SummerRaceChallengeRoundSettlement> challengeRoundSettlementRecords = new List<SummerRaceChallengeRoundSettlement>();

	private readonly Dictionary<int, float> waveEntryEnergySnapshots = new Dictionary<int, float>();

	private readonly List<Rigidbody2D> countdownFrozenRigidbodies = new List<Rigidbody2D>(24);

	private readonly List<Rigidbody2D> pausedFrozenRigidbodies = new List<Rigidbody2D>(64);

	private readonly SummerRaceEnemy[] survivalEnemyHudSlotEnemies = new SummerRaceEnemy[2];

	private readonly SummerRaceEnemyHudRuntimeState[] survivalEnemyHudSlotStates = new SummerRaceEnemyHudRuntimeState[2];

	private readonly SummerRaceBattleRuntime battleRuntime = new SummerRaceBattleRuntime();

	private SummerRaceBattleRuntimeBridge battleRuntimeBridge;

	private SummerRaceEnemyHudRuntimeState lastDefeatedEnemyHudSlot;

	private SummerRaceActivityConfigCatalogProvider activityCatalogProvider;

	private SummerRaceActivityRuntimeCatalog activityCatalog;

	private SummerRaceActivityStageContract activeActivityStage;

	private SummerRaceActivityChallengePoolContract activeChallengePool;

	private SummerRaceActivityEnemyContract launchEnemyContractOverride;

	private float currentCatalogSpawnInterval = -1f;

	private int currentSurvivalSpawnLimit;

	private float nextRuntimeSnapshotPushAt;

	private SummerRaceCameraFrameState cameraFrameState;

	private SummerRaceCameraShakeState cameraShakeState;

	private Vector3 cameraLastAppliedShakeOffset;

	private static Func<bool> luaUiContextReadyProvider;

	private static bool luaUiContextReadyFallback;

	private static bool luaUiContextProviderFailureLogged;

	private static bool validationControlEnabled;

	private static RuntimeLaunchConfig pendingLaunchConfig;

	private RuntimeLaunchConfig activeLaunchConfig;

	private string[] launchEnemyIds = Array.Empty<string>();

	private string reportedStageId = string.Empty;

	private bool countdownPhysicsLocked;

	private bool pausePhysicsLocked;

	private string runtimeEnemyIntroText = string.Empty;

	private float currentWaveEntrySpawnY = float.NaN;

	private string runtimeEnemyOverclockBubbleText = string.Empty;

	private int runtimeEnemyOverclockBubbleToken;

	private bool enemyHeadOut;

	private bool specialDefeatPending;

	private bool specialDefeatBlackoutDone;

	private bool specialDefeatGuideDone;

	private int specialDefeatTokenSeed;

	private int specialDefeatActiveToken;

	private SummerRaceEnemy specialDefeatTargetEnemy;

	private SummerRaceActivitySpecialDefeatRuleContract specialDefeatActiveRule;

	private Coroutine specialDefeatFinalizeCoroutine;

	private int enemyDefeatGuideTokenSeed;

	private bool enemyDefeatGuideSyncActive;

	private readonly HashSet<int> enemyDefeatGuideFinishedTokens = new HashSet<int>();

	private readonly Dictionary<SummerRaceEnemy, Coroutine> pendingNormalDefeatCoroutines = new Dictionary<SummerRaceEnemy, Coroutine>();

	private const float MaxDefeatFxFinalizeWaitSeconds = 2f;

	private const float MaxEnemyDefeatGuideWaitSeconds = 10f;

	public static SummerRaceFightManager Instance { get; private set; }

	public bool DrawArenaColliderOutlineInGame => drawArenaColliderOutlineInGame;

	public SummerRacePlayerController CurrentPlayer => player;

	public SummerRaceBuildDatabaseSO CurrentActivityBuildDatabase => ResolveActivityBuildDatabase();

	public SummerRaceActivityRuntimeCatalog CurrentActivityConfig => activityCatalog;

	public SummerRaceActivityStageContract CurrentActivityStage => activeActivityStage;

	public SummerRaceActivityChallengePoolContract CurrentActivityChallengePool => activeChallengePool;

	public bool IsCombatPresentationAudioBlocked
	{
		get
		{
			if (!isPaused && !battleResultRuntimeLocked)
			{
				return phase == FightPhase.Result;
			}
			return true;
		}
	}

	public bool IsBattleActive
	{
		get
		{
			if (phase == FightPhase.Battle && !isPaused && !battleResultBannerPending && timeoutResultCoroutine == null)
			{
				return timeoutWinWaveAdvanceCoroutine == null;
			}
			return false;
		}
	}

	public bool DebugIsPaused => isPaused;

	public string DebugPhase => phase.ToString();

	public float DebugCountdownRemaining => countdownRemaining;

	public int DebugAliveEnemies => aliveEnemies;

	public int DebugSpawnedEnemies => spawnedEnemies;

	public int DebugDestroyedEnemies => destroyedEnemies;

	public bool DebugResultWin => resultWin;

	public string DebugResultText => resultText;

	public string DebugActivityBuildDatabaseName => activityBuildDatabaseName;

	public SummerRaceBattleSnapshot GetBattleRuntimeSnapshot()
	{
		return battleRuntime.GetSnapshot();
	}

	public void ForcePublishRuntimeSnapshot()
	{
		PublishRuntimeSnapshot(force: true);
	}

	public void PrepareOutGameStoryCamera(float outGameOrthographicSize)
	{
		autoFrameCamera = false;
		battleResultCameraFrozen = false;
		Camera main = Camera.main;
		if (!(main == null))
		{
			if (cameraLastAppliedShakeOffset != Vector3.zero)
			{
				main.transform.position -= cameraLastAppliedShakeOffset;
				cameraLastAppliedShakeOffset = Vector3.zero;
			}
			main.orthographic = false;
			main.orthographicSize = Mathf.Max(0.01f, outGameOrthographicSize);
		}
	}

	public bool RequestSetPaused(bool paused)
	{
		if (phase == FightPhase.Result)
		{
			return false;
		}
		if (isPaused == paused)
		{
			PublishRuntimeSnapshot(force: true);
			return true;
		}
		isPaused = paused;
		if (player != null)
		{
			player.SetMovementLocked(isPaused || phase != FightPhase.Battle);
		}
		ApplyPausePhysicsLock(isPaused);
		if (isPaused)
		{
			SummerRaceCombatPresentationAudioSink.StopAllActivePlaybacks();
		}
		PublishRuntimeSnapshot(force: true);
		return true;
	}

	public bool RequestGiveUpBattle()
	{
		if (phase != FightPhase.Battle && !isPaused)
		{
			return false;
		}
		if (phase == FightPhase.Result || phase == FightPhase.SpecialDefeatPending)
		{
			return false;
		}
		EndFight(isWin: false, "Player gave up", "giveup");
		return true;
	}

	public bool RequestClearCurrentWaveForGm()
	{
		if (phase != FightPhase.Battle || isPaused)
		{
			return false;
		}
		if (fightMode == FightMode.SurvivalPractice)
		{
			return false;
		}
		int num = 0;
		for (int num2 = aliveEnemyRefs.Count - 1; num2 >= 0; num2--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num2];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num2);
			}
			else
			{
				num++;
				summerRaceEnemy.TakeDamage(int.MaxValue);
			}
		}
		enemiesToSpawnThisWave = 0;
		Log("GM clear wave: mode=" + fightMode.ToString() + " wave=" + (currentWaveIndex + 1) + " forcedDefeat=" + num);
		PublishRuntimeSnapshot(force: true);
		return true;
	}

	public bool HandleEnemyFatalHit(SummerRaceEnemy enemy)
	{
		if (enemy == null || phase != FightPhase.Battle)
		{
			return false;
		}
		if (!IsSpecialDefeatSupportedMainlineMode())
		{
			return BeginNormalDefeatPending(enemy);
		}
		if (!TryMatchSpecialDefeatRule(enemy, out var matchedRule))
		{
			return BeginNormalDefeatPending(enemy);
		}
		BeginSpecialDefeatPending(enemy, matchedRule);
		return true;
	}

	public void NotifySpecialDefeatBlackoutFinished(int token)
	{
		if (specialDefeatPending && token == specialDefeatActiveToken)
		{
			specialDefeatBlackoutDone = true;
			ExecuteSpecialDefeatRepositionAndFreeze();
			TryFinalizeSpecialDefeatAfterLuaSync(token);
		}
	}

	public void NotifySpecialDefeatGuideFinished(int token)
	{
		if (specialDefeatPending && token == specialDefeatActiveToken && !(specialDefeatTargetEnemy == null))
		{
			specialDefeatGuideDone = true;
			TryFinalizeSpecialDefeatAfterLuaSync(token);
		}
	}

	public void NotifyEnemyDefeatGuideFinished(int token)
	{
		if (token > 0)
		{
			enemyDefeatGuideFinishedTokens.Add(token);
		}
	}

	public SummerRaceBuildBlueprint[] GetSpawnedEnemyBlueprintsSnapshot()
	{
		return spawnedEnemyBlueprints.ToArray();
	}

	private void Awake()
	{
		if (Instance != null && Instance != this)
		{
			SummerRaceRuntimeLog.Error("[SummerRace] Duplicate SummerRaceFightManager detected. Destroying duplicate instance.");
			UnityEngine.Object.Destroy(base.gameObject);
		}
		else
		{
			Instance = this;
			SyncRuntimeDebugLogSwitch();
			EnsureBattleRuntimeBridge();
		}
	}

	private void EnsureBattleRuntimeBridge()
	{
		if (battleRuntimeBridge == null)
		{
			battleRuntimeBridge = new SummerRaceBattleRuntimeBridge(battleRuntime);
		}
	}

	private int ResolveHudWave()
	{
		if (fightMode == FightMode.Championship)
		{
			return Mathf.Min(currentWaveIndex + 1, ResolveConfiguredWaveTotalForMode());
		}
		if (fightMode == FightMode.OneVsTwoPractice)
		{
			return Mathf.Min(currentWaveIndex + 1, ResolveConfiguredWaveTotalForMode());
		}
		return Mathf.Max(1, currentWaveIndex + 1);
	}

	private int ResolveHudWaveTotal()
	{
		if (fightMode == FightMode.Championship || fightMode == FightMode.OneVsTwoPractice)
		{
			return ResolveConfiguredWaveTotalForMode();
		}
		if (fightMode == FightMode.SurvivalPractice)
		{
			return 1;
		}
		return 20;
	}

	private int ResolveConfiguredWaveTotalForMode()
	{
		if (activeActivityStage != null && activeActivityStage.Waves != null && activeActivityStage.Waves.Length != 0)
		{
			return activeActivityStage.Waves.Length;
		}
		return Mathf.Max(1, currentWaveIndex + 1);
	}

	private float ResolveHudTimerSeconds()
	{
		if (phase == FightPhase.Countdown)
		{
			return Mathf.Max(0f, countdownRemaining);
		}
		if ((fightMode == FightMode.Championship || fightMode == FightMode.OneVsTwoPractice || fightMode == FightMode.Challenge) && currentWaveTimeLimitSeconds > 0f)
		{
			return Mathf.Max(0f, currentWaveRemainingSeconds);
		}
		if (fightMode == FightMode.SurvivalPractice)
		{
			return Mathf.Max(0f, ResolveSurvivalDurationSeconds() - battleElapsed);
		}
		return ResolveCurrentWaveElapsed();
	}

	private float ResolveCurrentCountdownRemaining()
	{
		if (phase != FightPhase.Countdown)
		{
			return 0f;
		}
		return Mathf.Max(0f, countdownRemaining);
	}

	private float ResolveCurrentWaveElapsed()
	{
		if (phase == FightPhase.Countdown)
		{
			return 0f;
		}
		float num = Mathf.Max(0f, battleElapsed - waveElapsedBaseline);
		if (currentWaveTimeLimitSeconds > 0f)
		{
			num = Mathf.Min(num, currentWaveTimeLimitSeconds);
		}
		return num;
	}

	private static float ResolveHpPercent(float hp, float maxHp)
	{
		if (maxHp <= 0f)
		{
			if (!(hp > 0f))
			{
				return 0f;
			}
			return 1f;
		}
		return Mathf.Clamp01(hp / maxHp);
	}

	private bool ResolveTimeLimitWinnerByHpPercent(out string resultMessage)
	{
		float num = 0f;
		if (player != null)
		{
			num = ResolveHpPercent(player.CurrentHP, player.MaxHP);
		}
		float num2 = 0f;
		bool flag = false;
		for (int i = 0; i < aliveEnemyRefs.Count; i++)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[i];
			if (!(summerRaceEnemy == null) && summerRaceEnemy.IsCombatAlive)
			{
				flag = true;
				float num3 = ResolveHpPercent(summerRaceEnemy.CurrentHP, summerRaceEnemy.MaxHP);
				if (num3 > num2)
				{
					num2 = num3;
				}
			}
		}
		if (!flag)
		{
			num2 = 0f;
		}
		if (num >= num2)
		{
			resultMessage = "Time up - higher HP% win";
			return true;
		}
		resultMessage = "Time up - lower HP% lose";
		return false;
	}

	private void ForceClearAliveEnemiesForWaveTransition()
	{
		for (int num = aliveEnemyRefs.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num);
			}
			else
			{
				ClearProjectilesForCharacter(summerRaceEnemy);
				UnityEngine.Object.Destroy(summerRaceEnemy.gameObject);
			}
		}
		aliveEnemyRefs.Clear();
		enemySpawnMetaMap.Clear();
		lastDefeatedEnemyHudSlot = null;
		aliveEnemies = 0;
	}

	private void BeginTimeoutWinDefeatSequence()
	{
		if (timeoutWinDefeatPending)
		{
			return;
		}
		if (timeoutWinResultShownForWave)
		{
			ForceDefeatAliveEnemiesForTimeoutWin();
		}
		else if (timeoutResultCoroutine == null)
		{
			timeoutWinResultShownForWave = true;
			ApplyCountdownPhysicsLock(locked: true);
			if (player != null)
			{
				player.SetMovementLocked(locked: true);
			}
			PushTimeoutResultToLua(isWin: true);
			PublishRuntimeSnapshot(force: true);
			timeoutResultCoroutine = StartCoroutine(CoDelayTimeoutWinDefeat());
		}
	}

	private void BeginTimeoutWinWaveAdvanceSequence()
	{
		if (timeoutWinWaveAdvanceCoroutine == null)
		{
			timeoutWinWaveAdvanceCoroutine = StartCoroutine(CoAdvanceAfterTimeoutWinWave());
		}
	}

	private void TryContinueTimeoutWinAfterEnemyDestroyed()
	{
		if (timeoutWinResultShownForWave && phase == FightPhase.Battle)
		{
			timeoutWinDefeatPending = false;
			if (aliveEnemies > 0 && enemiesToSpawnThisWave <= 0 && enemiesKilledThisWave < currentWaveTotal)
			{
				ForceDefeatAliveEnemiesForTimeoutWin();
			}
			else if (enemiesToSpawnThisWave <= 0 && enemiesKilledThisWave >= currentWaveTotal && aliveEnemies <= 0)
			{
				BeginTimeoutWinWaveAdvanceSequence();
			}
		}
	}

	private IEnumerator CoDelayTimeoutWinDefeat()
	{
		yield return new WaitForSecondsRealtime(2f);
		timeoutResultCoroutine = null;
		if (phase == FightPhase.Battle)
		{
			ApplyCountdownPhysicsLock(locked: false);
			if (player != null)
			{
				player.SetMovementLocked(locked: false);
			}
			ForceDefeatAliveEnemiesForTimeoutWin();
		}
	}

	private IEnumerator CoAdvanceAfterTimeoutWinWave()
	{
		yield return new WaitForSecondsRealtime(0.15f);
		timeoutWinWaveAdvanceCoroutine = null;
		if (phase == FightPhase.Battle && timeoutWinResultShownForWave && enemiesToSpawnThisWave <= 0 && enemiesKilledThisWave >= currentWaveTotal && aliveEnemies <= 0)
		{
			ProceedToNextWaveOrFinish();
		}
	}

	private void ProceedToNextWaveOrFinishAfterBattleResultBanner()
	{
		ProceedToNextWaveOrFinishAfterBattleResultBanner(0);
	}

	private void ProceedToNextWaveOrFinishAfterBattleResultBanner(int specialDefeatFinishedToken)
	{
		if (timeoutWinResultShownForWave)
		{
			if (specialDefeatFinishedToken > 0)
			{
				PushSpecialDefeatFinishedToLua(specialDefeatFinishedToken, ResolveHudPhaseState());
			}
			ProceedToNextWaveOrFinish();
		}
		else if (!battleResultBannerPending)
		{
			if (phase == FightPhase.SpecialDefeatPending)
			{
				phase = FightPhase.Battle;
			}
			FreezeBattleResultCamera();
			pendingBattleResultSpecialDefeatFinishedToken = Mathf.Max(0, specialDefeatFinishedToken);
			PushBattleResultBannerToLua(isWin: true);
			battleResultBannerPending = true;
			SetBattleResultRuntimeLocked(locked: true);
			ApplyCountdownPhysicsLock(locked: true);
			if (player != null)
			{
				player.SetMovementLocked(locked: true);
			}
			PublishRuntimeSnapshot(force: true);
			battleResultBannerCoroutine = StartCoroutine(CoDelayBattleResultBanner(continueToNextWave: true, "Wave clear"));
		}
	}

	private void EndFightAfterBattleResultBanner(bool isWin, string message)
	{
		if (!battleResultBannerPending)
		{
			FreezeBattleResultCamera();
			PushBattleResultBannerToLua(isWin);
			battleResultBannerPending = true;
			SetBattleResultRuntimeLocked(locked: true);
			ApplyCountdownPhysicsLock(locked: true);
			if (player != null)
			{
				player.SetMovementLocked(locked: true);
			}
			PublishRuntimeSnapshot(force: true);
			battleResultBannerCoroutine = StartCoroutine(CoDelayBattleResultBanner(continueToNextWave: false, message));
		}
	}

	private IEnumerator CoDelayBattleResultBanner(bool continueToNextWave, string message)
	{
		yield return new WaitForSecondsRealtime(2f);
		battleResultBannerCoroutine = null;
		battleResultBannerPending = false;
		ReleaseBattleResultCamera();
		if (phase == FightPhase.Battle)
		{
			ApplyCountdownPhysicsLock(locked: false);
			if (player != null)
			{
				player.SetMovementLocked(locked: false);
			}
			if (continueToNextWave)
			{
				PushPendingBattleResultSpecialDefeatFinished();
				ProceedToNextWaveOrFinish();
			}
			else
			{
				EndFight(isWin: false, message);
			}
		}
	}

	private void CancelBattleResultBannerSequence()
	{
		if (battleResultBannerCoroutine != null)
		{
			StopCoroutine(battleResultBannerCoroutine);
			battleResultBannerCoroutine = null;
		}
		battleResultBannerPending = false;
		pendingBattleResultSpecialDefeatFinishedToken = 0;
		SetBattleResultRuntimeLocked(locked: false);
		ReleaseBattleResultCamera();
	}

	private void PushPendingBattleResultSpecialDefeatFinished()
	{
		int num = pendingBattleResultSpecialDefeatFinishedToken;
		pendingBattleResultSpecialDefeatFinishedToken = 0;
		if (num > 0)
		{
			PushSpecialDefeatFinishedToLua(num, ResolveHudPhaseState());
		}
	}

	private void FreezeBattleResultCamera()
	{
		Camera main = Camera.main;
		if (main == null)
		{
			battleResultCameraFrozen = false;
			return;
		}
		battleResultFrozenCameraPosition = main.transform.position;
		battleResultFrozenCameraOrthoSize = main.orthographicSize;
		battleResultCameraFrozen = true;
	}

	private void ApplyBattleResultCameraFreeze()
	{
		if (battleResultCameraFrozen)
		{
			Camera main = Camera.main;
			if (main == null)
			{
				battleResultCameraFrozen = false;
				return;
			}
			main.transform.position = battleResultFrozenCameraPosition;
			main.orthographicSize = battleResultFrozenCameraOrthoSize;
		}
	}

	private void ReleaseBattleResultCamera()
	{
		battleResultCameraFrozen = false;
	}

	private void ForceDefeatAliveEnemiesForTimeoutWin()
	{
		int num = 0;
		for (int num2 = aliveEnemyRefs.Count - 1; num2 >= 0; num2--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num2];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num2);
				continue;
			}
			if (IsTimeoutWinSpecialDefeatEffect(ResolveDefeatEffectForEnemy(summerRaceEnemy)) && TryMatchSpecialDefeatRule(summerRaceEnemy, out var matchedRule))
			{
				BeginSpecialDefeatPending(summerRaceEnemy, matchedRule);
			}
			else if (!BeginNormalDefeatPending(summerRaceEnemy))
			{
				continue;
			}
			num++;
		}
		enemiesToSpawnThisWave = 0;
		timeoutWinDefeatPending = num > 0;
		if (num <= 0 && enemiesKilledThisWave >= currentWaveTotal && aliveEnemies <= 0)
		{
			BeginTimeoutWinWaveAdvanceSequence();
		}
		Log("Timeout win defeat alive enemies: mode=" + fightMode.ToString() + " wave=" + (currentWaveIndex + 1) + " forcedDefeat=" + num);
		PublishRuntimeSnapshot(force: true);
	}

	private void CancelTimeoutResultSequence()
	{
		_ = timeoutResultCoroutine;
		if (timeoutResultCoroutine != null)
		{
			StopCoroutine(timeoutResultCoroutine);
			timeoutResultCoroutine = null;
		}
		if (timeoutWinWaveAdvanceCoroutine != null)
		{
			StopCoroutine(timeoutWinWaveAdvanceCoroutine);
			timeoutWinWaveAdvanceCoroutine = null;
		}
		timeoutWinDefeatPending = false;
		CancelBattleResultBannerSequence();
	}

	private string ResolveHudPhaseState()
	{
		if (phase == FightPhase.Countdown)
		{
			return "Countdown";
		}
		if (phase == FightPhase.SpecialDefeatPending)
		{
			return "SpecialDefeatPending";
		}
		if (phase == FightPhase.Result)
		{
			return "Result";
		}
		if (!isPaused)
		{
			return "Battle";
		}
		return "Pause";
	}

	private int ResolveChallengeWaveNumber()
	{
		return Mathf.Max(1, currentWaveIndex + 1);
	}

	private int ResolveSettlementWaveNumber()
	{
		return Mathf.Max(1, currentWaveIndex + 1);
	}

	private int ResolveLaunchCatalogWaveIndex()
	{
		if (activeLaunchConfig == null)
		{
			return 0;
		}
		if (activeLaunchConfig.startWaveIndex <= 0)
		{
			return 0;
		}
		return activeLaunchConfig.startWaveIndex - 1;
	}

	private int ResolveChallengeWaveEnemyCount(int waveNumber)
	{
		if (waveNumber > 20)
		{
			return 0;
		}
		return 1;
	}

	private float ResolveChallengeSpawnInterval(int waveNumber)
	{
		float num = Mathf.Max(0f, challengeSpawnIntervalDecay);
		float b = challengeSpawnInterval - num * (float)Mathf.Max(0, waveNumber - 1);
		return Mathf.Max(Mathf.Max(0.1f, challengeMinSpawnInterval), b);
	}

	private int ResolveChallengeMaxAlive(int waveNumber)
	{
		if (waveNumber > 20)
		{
			return 0;
		}
		return 1;
	}

	private int ResolveChallengeScore()
	{
		int waveNumber = Mathf.Clamp(ResolveChallengeWaveNumber(), 1, 20);
		return ComputeChallengeWaveScore(waveNumber, ResolveChallengeCurrentEnemyHpPercent());
	}

	private int ResolveChallengeWaveEarnedScore(int waveNumber)
	{
		int num = Mathf.Clamp(waveNumber, 1, 20);
		return Mathf.Max(0, ResolveChallengeScore() - ResolveChallengeWaveBaseScore(num - 1));
	}

	private static string NormalizeSettlementResult(string result)
	{
		if (!string.IsNullOrWhiteSpace(result))
		{
			return result.Trim().ToLowerInvariant();
		}
		return "none";
	}

	private void RecordRoundSettlement(int round, string result, float durationSec)
	{
		int num = Mathf.Max(1, round);
		string text = NormalizeSettlementResult(result);
		float durationSec2 = Mathf.Max(0f, durationSec);
		if (text == "lose")
		{
			RemoveLoseRoundSettlements();
		}
		for (int i = 0; i < roundSettlementRecords.Count; i++)
		{
			if (roundSettlementRecords[i].round == num)
			{
				roundSettlementRecords[i].result = text;
				roundSettlementRecords[i].durationSec = durationSec2;
				return;
			}
		}
		roundSettlementRecords.Add(new SummerRaceRoundSettlement
		{
			round = num,
			result = text,
			durationSec = durationSec2
		});
	}

	private void RemoveLoseRoundSettlements()
	{
		for (int num = roundSettlementRecords.Count - 1; num >= 0; num--)
		{
			SummerRaceRoundSettlement summerRaceRoundSettlement = roundSettlementRecords[num];
			if (summerRaceRoundSettlement != null && NormalizeSettlementResult(summerRaceRoundSettlement.result) == "lose")
			{
				roundSettlementRecords.RemoveAt(num);
			}
		}
	}

	private SummerRaceRoundSettlement[] BuildRoundSettlementArray()
	{
		if (roundSettlementRecords.Count == 0)
		{
			return Array.Empty<SummerRaceRoundSettlement>();
		}
		roundSettlementRecords.Sort((SummerRaceRoundSettlement left, SummerRaceRoundSettlement right) => left.round.CompareTo(right.round));
		SummerRaceRoundSettlement[] array = new SummerRaceRoundSettlement[roundSettlementRecords.Count];
		for (int num = 0; num < roundSettlementRecords.Count; num++)
		{
			SummerRaceRoundSettlement summerRaceRoundSettlement = roundSettlementRecords[num];
			array[num] = ((summerRaceRoundSettlement != null) ? summerRaceRoundSettlement.Clone() : new SummerRaceRoundSettlement());
		}
		return array;
	}

	private void RecordSurvivalEnemySettlement(int round, string enemyId, string result, float durationSec, bool showTime)
	{
		if (fightMode == FightMode.SurvivalPractice && !string.IsNullOrWhiteSpace(enemyId))
		{
			survivalEnemySettlementRecords.Add(new SummerRaceSurvivalEnemySettlement
			{
				round = Mathf.Max(1, round),
				enemyId = enemyId.Trim(),
				result = NormalizeSettlementResult(result),
				durationSec = Mathf.Max(0f, durationSec),
				showTime = showTime
			});
		}
	}

	private void RecordAliveEnemySettlementRecords(bool isWin)
	{
		if (fightMode != FightMode.SurvivalPractice)
		{
			return;
		}
		string result = (isWin ? "win" : "lose");
		float durationSec = ResolveCurrentWaveElapsed();
		for (int i = 0; i < aliveEnemyRefs.Count; i++)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[i];
			if (!(summerRaceEnemy == null))
			{
				int round = Mathf.Max(1, summerRaceEnemy.SpawnWaveIndex);
				string enemyId = summerRaceEnemy.CatalogEnemyId;
				if (enemySpawnMetaMap.TryGetValue(summerRaceEnemy, out var value) && value != null)
				{
					round = Mathf.Max(1, value.WaveIndex);
					enemyId = value.EnemyId;
				}
				RecordSurvivalEnemySettlement(round, enemyId, result, durationSec, showTime: false);
			}
		}
	}

	private SummerRaceSurvivalEnemySettlement[] BuildSurvivalEnemySettlementArray()
	{
		if (survivalEnemySettlementRecords.Count == 0)
		{
			return Array.Empty<SummerRaceSurvivalEnemySettlement>();
		}
		SummerRaceSurvivalEnemySettlement[] array = new SummerRaceSurvivalEnemySettlement[survivalEnemySettlementRecords.Count];
		for (int i = 0; i < survivalEnemySettlementRecords.Count; i++)
		{
			SummerRaceSurvivalEnemySettlement summerRaceSurvivalEnemySettlement = survivalEnemySettlementRecords[i];
			array[i] = ((summerRaceSurvivalEnemySettlement != null) ? summerRaceSurvivalEnemySettlement.Clone() : new SummerRaceSurvivalEnemySettlement());
		}
		return array;
	}

	private void RecordChallengeRoundSettlement(int round, string result, float durationSec, int score)
	{
		int num = Mathf.Clamp(round, 1, 20);
		string result2 = NormalizeSettlementResult(result);
		float durationSec2 = Mathf.Max(0f, durationSec);
		int score2 = Mathf.Max(0, score);
		for (int i = 0; i < challengeRoundSettlementRecords.Count; i++)
		{
			if (challengeRoundSettlementRecords[i].round == num)
			{
				challengeRoundSettlementRecords[i].result = result2;
				challengeRoundSettlementRecords[i].durationSec = durationSec2;
				challengeRoundSettlementRecords[i].score = score2;
				return;
			}
		}
		challengeRoundSettlementRecords.Add(new SummerRaceChallengeRoundSettlement
		{
			round = num,
			result = result2,
			durationSec = durationSec2,
			score = score2
		});
	}

	private SummerRaceChallengeRoundSettlement[] BuildChallengeRoundSettlementArray()
	{
		if (challengeRoundSettlementRecords.Count == 0)
		{
			return Array.Empty<SummerRaceChallengeRoundSettlement>();
		}
		challengeRoundSettlementRecords.Sort((SummerRaceChallengeRoundSettlement left, SummerRaceChallengeRoundSettlement right) => left.round.CompareTo(right.round));
		SummerRaceChallengeRoundSettlement[] array = new SummerRaceChallengeRoundSettlement[challengeRoundSettlementRecords.Count];
		for (int num = 0; num < challengeRoundSettlementRecords.Count; num++)
		{
			SummerRaceChallengeRoundSettlement summerRaceChallengeRoundSettlement = challengeRoundSettlementRecords[num];
			array[num] = ((summerRaceChallengeRoundSettlement != null) ? summerRaceChallengeRoundSettlement.Clone() : new SummerRaceChallengeRoundSettlement());
		}
		return array;
	}

	private int ResolveChallengeWaveBaseScore(int waveNumber)
	{
		int[] array = ResolveChallengeWaveScoreTable();
		int num = Mathf.Max(0, waveNumber);
		if (num <= 0)
		{
			return 0;
		}
		if (num <= array.Length)
		{
			return array[num - 1];
		}
		int num2 = num - array.Length;
		return array[array.Length - 1] + num2 * 3000;
	}

	private int ComputeChallengeWaveScore(int waveNumber, float hpPercent)
	{
		int num = ResolveChallengeWaveBaseScore(waveNumber);
		int num2 = ResolveChallengeWaveBaseScore(waveNumber - 1);
		float num3 = 1f - Mathf.Clamp01(hpPercent);
		float f = (float)num2 + (float)(num - num2) * num3;
		return Mathf.Max(0, Mathf.RoundToInt(f));
	}

	private int[] ResolveChallengeWaveScoreTable()
	{
		int[] array = ((activeActivityStage != null) ? activeActivityStage.ChallengeWaveScoreTable : null);
		if (array != null && array.Length != 0)
		{
			return array;
		}
		return ChallengeWaveScoreTable;
	}

	private float ResolveChallengeCurrentEnemyHpPercent()
	{
		if (enemiesKilledThisWave <= 0 && aliveEnemies <= 0)
		{
			return 1f;
		}
		SummerRaceEnemy summerRaceEnemy = null;
		for (int i = 0; i < aliveEnemyRefs.Count; i++)
		{
			SummerRaceEnemy summerRaceEnemy2 = aliveEnemyRefs[i];
			if (summerRaceEnemy2 == null)
			{
				continue;
			}
			if (summerRaceEnemy == null)
			{
				summerRaceEnemy = summerRaceEnemy2;
				continue;
			}
			float num = summerRaceEnemy2.CurrentHP / Mathf.Max(1f, summerRaceEnemy2.MaxHP);
			float num2 = summerRaceEnemy.CurrentHP / Mathf.Max(1f, summerRaceEnemy.MaxHP);
			if (num > num2)
			{
				summerRaceEnemy = summerRaceEnemy2;
			}
		}
		if (summerRaceEnemy == null)
		{
			return 0f;
		}
		return Mathf.Clamp01(summerRaceEnemy.CurrentHP / Mathf.Max(1f, summerRaceEnemy.MaxHP));
	}

	private float ResolveChallengeWaveHealRatio()
	{
		if (activeActivityStage == null)
		{
			throw new InvalidOperationException("[SummerRace] Challenge wave heal ratio requires activeActivityStage.");
		}
		float challengeWaveHealRatio = activeActivityStage.ChallengeWaveHealRatio;
		if (float.IsNaN(challengeWaveHealRatio) || float.IsInfinity(challengeWaveHealRatio) || challengeWaveHealRatio < 0f || challengeWaveHealRatio > 1f)
		{
			throw new InvalidOperationException("[SummerRace] Invalid challenge wave heal ratio: " + challengeWaveHealRatio + " (expected 0~1).");
		}
		return challengeWaveHealRatio;
	}

	private float ResolveCountdownTotalDuration()
	{
		return 2.1f;
	}

	private void ResolvePlayerSpawnAnchorOrFail()
	{
		if (string.IsNullOrWhiteSpace(playerSpawnName))
		{
			throw new InvalidOperationException("[SummerRace] playerSpawnName must not be empty.");
		}
		GameObject gameObject = GameObject.Find(playerSpawnName.Trim());
		if (gameObject == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing required player spawn anchor: " + playerSpawnName);
		}
		playerSpawnAnchor = gameObject.transform;
	}

	private float RequirePlayerSpawnAnchorX()
	{
		if (playerSpawnAnchor == null)
		{
			throw new InvalidOperationException("[SummerRace] Player spawn anchor is not resolved.");
		}
		return playerSpawnAnchor.position.x;
	}

	private void OnEnable()
	{
		NormalizeCameraSerializedDefaults();
		if (Application.isPlaying && !bootstrappedForPlay)
		{
			BootstrapRuntimeState();
		}
	}

	private void NormalizeCameraSerializedDefaults()
	{
		if (cameraOverviewOrthoSize <= 0f)
		{
			cameraOverviewOrthoSize = 6.5f;
		}
		if (cameraSafeZoneRatio <= 0f)
		{
			cameraSafeZoneRatio = 0.72f;
		}
		if (cameraVehiclePadding <= 0f)
		{
			cameraVehiclePadding = 0.75f;
		}
		if (string.IsNullOrWhiteSpace(cameraBgRootName))
		{
			cameraBgRootName = "Bg";
		}
		if (cameraSmoothTime <= 0f)
		{
			cameraSmoothTime = 0.28f;
		}
		if (cameraPushSpeed <= 0f)
		{
			cameraPushSpeed = 1.5f;
		}
		if (cameraPullSpeed <= 0f)
		{
			cameraPullSpeed = 3.5f;
		}
		if (cameraCollisionShakeMinSpeed <= 0f)
		{
			cameraCollisionShakeMinSpeed = 3.2f;
		}
		if (cameraCollisionShakeAmplitude <= 0f)
		{
			cameraCollisionShakeAmplitude = 0.08f;
		}
		if (cameraCollisionShakeDuration <= 0f)
		{
			cameraCollisionShakeDuration = 0.12f;
		}
		if (cameraDefeatShakeAmplitude <= 0f)
		{
			cameraDefeatShakeAmplitude = 0.14f;
		}
		if (cameraDefeatShakeDuration <= 0f)
		{
			cameraDefeatShakeDuration = 0.18f;
		}
	}

	private void OnDisable()
	{
		ClearBattleCameraAppliedOffset();
		CleanupPendingNormalDefeatState();
		CleanupSpecialDefeatState();
		ApplyPausePhysicsLock(locked: false);
		ApplyCountdownPhysicsLock(locked: false);
		if (Instance == this)
		{
			Instance = null;
		}
		SummerRaceRuntimeLog.SetGameplayVerboseEnabled(enabled: false);
		bootstrappedForPlay = false;
	}

	private void ClearBattleCameraAppliedOffset()
	{
		if (!(cameraLastAppliedShakeOffset == Vector3.zero))
		{
			Camera main = Camera.main;
			if (main != null)
			{
				main.transform.position -= cameraLastAppliedShakeOffset;
			}
			cameraLastAppliedShakeOffset = Vector3.zero;
		}
	}

	private void Start()
	{
		if (!bootstrappedForPlay)
		{
			BootstrapRuntimeState();
		}
	}

	public bool DebugHasExplicitCatalogSource()
	{
		if (activeLaunchConfig != null && activeLaunchConfig.hasActivitySourceOverride)
		{
			if (!string.IsNullOrWhiteSpace(activityBuildDatabaseName) && activeLaunchConfig.activityStageSources != null)
			{
				return activeLaunchConfig.activityStageSources.Length != 0;
			}
			return false;
		}
		if (!string.IsNullOrWhiteSpace(activityBuildDatabaseName) && activityStageSource != null)
		{
			return activityStageSource.Length != 0;
		}
		return false;
	}

	public bool DebugTryConfigureValidationCatalogSources(string buildDatabaseNameOverride, SummerRaceActivityStageSourceRecord[] stageSource)
	{
		if (!IsValidationControlContext())
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] validation catalog injection rejected: validation control gate is disabled.");
			return false;
		}
		if (string.IsNullOrWhiteSpace(buildDatabaseNameOverride))
		{
			throw new InvalidOperationException("Validation build database name must not be empty.");
		}
		activityBuildDatabaseName = buildDatabaseNameOverride.Trim();
		activityStageSource = stageSource ?? Array.Empty<SummerRaceActivityStageSourceRecord>();
		return true;
	}

	public bool DebugTryRestartModeForValidation(FightMode mode)
	{
		if (!IsValidationControlContext())
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] validation mode restart rejected: validation control gate is disabled.");
			return false;
		}
		fightMode = mode;
		physicsTestMode = false;
		bootstrappedForPlay = false;
		BootstrapRuntimeState();
		return true;
	}

	public static void RegisterLuaUiContextReadyProvider(Func<bool> provider)
	{
		luaUiContextReadyProvider = provider;
		luaUiContextProviderFailureLogged = false;
	}

	public static void SetValidationControlEnabled(bool enabled)
	{
		validationControlEnabled = enabled;
	}

	public static void SetLuaUiContextReady(bool isReady)
	{
		luaUiContextReadyFallback = isReady;
	}

	public static void ClearPendingLaunchConfig()
	{
		pendingLaunchConfig = null;
	}

	public static bool TryApplyPreparedLaunchForRuntimeRestart()
	{
		if (pendingLaunchConfig == null)
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] runtime restart rejected: pending launch config is null.");
			return false;
		}
		SummerRaceFightManager summerRaceFightManager = Instance ?? UnityEngine.Object.FindObjectOfType<SummerRaceFightManager>(includeInactive: true);
		if (summerRaceFightManager == null)
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] runtime restart rejected: SummerRaceFightManager not found.");
			return false;
		}
		summerRaceFightManager.CleanupRuntimeForPreparedLaunchRestart();
		summerRaceFightManager.applyPreparedLaunchRestart = true;
		summerRaceFightManager.bootstrappedForPlay = false;
		summerRaceFightManager.BootstrapRuntimeState();
		summerRaceFightManager.EnsureSideViewCamera(forceApply: true);
		return true;
	}

	public static bool IsArenaColliderOutlineInGameEnabled()
	{
		SummerRaceFightManager summerRaceFightManager = Instance ?? UnityEngine.Object.FindObjectOfType<SummerRaceFightManager>(includeInactive: true);
		if (summerRaceFightManager != null)
		{
			return summerRaceFightManager.DrawArenaColliderOutlineInGame;
		}
		return false;
	}

	public static void SetPendingLaunchConfigFromLuaJson(string launchJson)
	{
		if (string.IsNullOrWhiteSpace(launchJson))
		{
			pendingLaunchConfig = null;
			return;
		}
		LuaLaunchPayload luaLaunchPayload;
		try
		{
			luaLaunchPayload = JsonUtility.FromJson<LuaLaunchPayload>(launchJson);
		}
		catch (Exception ex)
		{
			throw new InvalidOperationException("[SummerRace] Invalid launch payload JSON from Lua: " + ex.Message, ex);
		}
		if (luaLaunchPayload == null)
		{
			throw new InvalidOperationException("[SummerRace] Launch payload JSON decoded to null.");
		}
		pendingLaunchConfig = BuildLaunchConfig(luaLaunchPayload);
	}

	private static RuntimeLaunchConfig BuildLaunchConfig(LuaLaunchPayload payload)
	{
		RuntimeLaunchConfig runtimeLaunchConfig = new RuntimeLaunchConfig();
		if (!string.IsNullOrWhiteSpace(payload.mode))
		{
			runtimeLaunchConfig.mode = ParseFightMode(payload.mode);
			runtimeLaunchConfig.hasMode = true;
		}
		runtimeLaunchConfig.activityId = ResolveActivityIdFromPayload(payload);
		runtimeLaunchConfig.stageId = (string.IsNullOrWhiteSpace(payload.stageId) ? string.Empty : payload.stageId.Trim());
		if (payload.startWaveIndex < 0)
		{
			throw new InvalidOperationException("[SummerRace] startWaveIndex must be greater than or equal to 0.");
		}
		runtimeLaunchConfig.startWaveIndex = payload.startWaveIndex;
		runtimeLaunchConfig.playerBuildName = ResolvePlayerBuildNameFromPayload(payload);
		ResolvePlayerBuildOverrideFromPayload(payload, runtimeLaunchConfig);
		runtimeLaunchConfig.enemyBuildName = ResolveEnemyBuildNameFromPayload(payload);
		ResolveEnemyBuildOverrideFromPayload(payload, runtimeLaunchConfig);
		runtimeLaunchConfig.enemyIds = ResolveEnemyIdsFromPayload(payload);
		ResolveActivitySourceOverrideFromPayload(payload, runtimeLaunchConfig);
		if (!runtimeLaunchConfig.hasMode && string.IsNullOrWhiteSpace(runtimeLaunchConfig.activityId) && string.IsNullOrWhiteSpace(runtimeLaunchConfig.stageId) && runtimeLaunchConfig.startWaveIndex <= 0 && string.IsNullOrWhiteSpace(runtimeLaunchConfig.playerBuildName) && !runtimeLaunchConfig.hasPlayerBuildOverride && string.IsNullOrWhiteSpace(runtimeLaunchConfig.enemyBuildName) && !runtimeLaunchConfig.hasEnemyBuildOverride && !runtimeLaunchConfig.hasActivitySourceOverride && runtimeLaunchConfig.enemyIds.Length == 0)
		{
			return null;
		}
		if (string.IsNullOrWhiteSpace(runtimeLaunchConfig.stageId))
		{
			throw new InvalidOperationException("[SummerRace] Launch payload requires explicit stageId.");
		}
		return runtimeLaunchConfig;
	}

	private static string ResolveActivityIdFromPayload(LuaLaunchPayload payload)
	{
		if (payload != null && !string.IsNullOrWhiteSpace(payload.activityId))
		{
			return payload.activityId.Trim();
		}
		if (payload != null && payload.activityConfig != null && !string.IsNullOrWhiteSpace(payload.activityConfig.activityId))
		{
			return payload.activityConfig.activityId.Trim();
		}
		return string.Empty;
	}

	private static string ResolvePlayerBuildNameFromPayload(LuaLaunchPayload payload)
	{
		if (payload.playerConfig != null && !string.IsNullOrWhiteSpace(payload.playerConfig.buildName))
		{
			return payload.playerConfig.buildName.Trim();
		}
		if (!string.IsNullOrWhiteSpace(payload.playerBuildName))
		{
			return payload.playerBuildName.Trim();
		}
		return string.Empty;
	}

	private static void ResolvePlayerBuildOverrideFromPayload(LuaLaunchPayload payload, RuntimeLaunchConfig config)
	{
		if (payload != null && payload.playerConfig != null && SummerRaceBattleStartContextUtility.TryParseBodyType(payload.playerConfig.bodyKey, out var bodyType))
		{
			config.playerBodyType = bodyType;
			config.playerWeaponKinds = SummerRaceBattleStartContextUtility.ParseWeaponKinds(payload.playerConfig.weaponKeys);
			config.playerWeaponSlotIndices = CloneSlotIndices(payload.playerConfig.weaponSlotIndices);
			config.playerWeaponOverrides = BuildWeaponOverrideSpecs(payload.playerConfig.weaponOverrides, config.playerWeaponKinds, "playerConfig.weaponOverrides");
			config.playerEquipKinds = SummerRaceBattleStartContextUtility.ParseEquipKinds(payload.playerConfig.equipKeys);
			config.playerEquipSlotIndices = CloneSlotIndices(payload.playerConfig.equipSlotIndices);
			config.playerEquipOverrides = BuildEquipOverrideSpecs(payload.playerConfig.equipOverrides, config.playerEquipKinds, "playerConfig.equipOverrides");
			config.playerBodyOverride = BuildPlayerBodyOverride(payload.playerConfig);
			config.hasPlayerBuildOverride = true;
		}
	}

	private static int[] CloneSlotIndices(int[] slotIndices)
	{
		if (slotIndices == null || slotIndices.Length == 0)
		{
			return Array.Empty<int>();
		}
		return (int[])slotIndices.Clone();
	}

	private static SummerRacePlayerController.WeaponProfileOverrideSpec[] BuildWeaponOverrideSpecs(LuaWeaponOverrideConfig[] overrideConfigs, WeaponKind[] resolvedWeaponKinds, string contextLabel)
	{
		if (overrideConfigs == null || overrideConfigs.Length == 0)
		{
			return Array.Empty<SummerRacePlayerController.WeaponProfileOverrideSpec>();
		}
		WeaponKind[] array = resolvedWeaponKinds ?? Array.Empty<WeaponKind>();
		if (overrideConfigs.Length != array.Length)
		{
			throw new InvalidOperationException("[SummerRace] " + contextLabel + " length mismatch: overrides=" + overrideConfigs.Length + " weaponKinds=" + array.Length);
		}
		SummerRacePlayerController.WeaponProfileOverrideSpec[] array2 = new SummerRacePlayerController.WeaponProfileOverrideSpec[overrideConfigs.Length];
		for (int i = 0; i < overrideConfigs.Length; i++)
		{
			LuaWeaponOverrideConfig luaWeaponOverrideConfig = overrideConfigs[i];
			if (luaWeaponOverrideConfig == null)
			{
				throw new InvalidOperationException("[SummerRace] " + contextLabel + "[" + i + "] is null.");
			}
			WeaponKind weaponKind = array[i];
			if (!string.IsNullOrWhiteSpace(luaWeaponOverrideConfig.weaponKey))
			{
				WeaponKind[] array3 = SummerRaceBattleStartContextUtility.ParseWeaponKinds(new string[1] { luaWeaponOverrideConfig.weaponKey });
				if (array3.Length != 1)
				{
					throw new InvalidOperationException("[SummerRace] " + contextLabel + "[" + i + "] invalid weaponKey: " + luaWeaponOverrideConfig.weaponKey);
				}
				if (array3[0] != weaponKind)
				{
					throw new InvalidOperationException("[SummerRace] " + contextLabel + "[" + i + "] key mismatch: weaponKey=" + luaWeaponOverrideConfig.weaponKey + " expectedKind=" + weaponKind);
				}
			}
			if (luaWeaponOverrideConfig.damage < 0)
			{
				throw new InvalidOperationException("[SummerRace] " + contextLabel + "[" + i + "] invalid damage < 0: " + luaWeaponOverrideConfig.damage);
			}
			if (luaWeaponOverrideConfig.rof <= 0f)
			{
				throw new InvalidOperationException("[SummerRace] " + contextLabel + "[" + i + "] invalid rof <= 0: " + luaWeaponOverrideConfig.rof);
			}
			array2[i] = new SummerRacePlayerController.WeaponProfileOverrideSpec
			{
				WeaponKind = weaponKind,
				Cost = Mathf.Max(0, luaWeaponOverrideConfig.cost),
				EnergyCost = Mathf.Max(0f, luaWeaponOverrideConfig.energyCost),
				Damage = luaWeaponOverrideConfig.damage,
				FireInterval = 1f / luaWeaponOverrideConfig.rof,
				HasBurnOverride = luaWeaponOverrideConfig.hasBurnOverride,
				BurnDps = Mathf.Max(0, luaWeaponOverrideConfig.burnDps),
				BurnDuration = Mathf.Max(0f, luaWeaponOverrideConfig.burnDuration),
				EffectParams = ((luaWeaponOverrideConfig.effectParams != null) ? ((float[])luaWeaponOverrideConfig.effectParams.Clone()) : Array.Empty<float>())
			};
		}
		return array2;
	}

	private static SummerRacePlayerController.EquipProfileOverrideSpec[] BuildEquipOverrideSpecs(LuaEquipOverrideConfig[] overrideConfigs, EquipKind[] resolvedEquipKinds, string contextLabel)
	{
		if (overrideConfigs == null || overrideConfigs.Length == 0)
		{
			return Array.Empty<SummerRacePlayerController.EquipProfileOverrideSpec>();
		}
		EquipKind[] array = resolvedEquipKinds ?? Array.Empty<EquipKind>();
		if (overrideConfigs.Length != array.Length)
		{
			throw new InvalidOperationException("[SummerRace] " + contextLabel + " length mismatch: overrides=" + overrideConfigs.Length + " equipKinds=" + array.Length);
		}
		SummerRacePlayerController.EquipProfileOverrideSpec[] array2 = new SummerRacePlayerController.EquipProfileOverrideSpec[overrideConfigs.Length];
		for (int i = 0; i < overrideConfigs.Length; i++)
		{
			LuaEquipOverrideConfig luaEquipOverrideConfig = overrideConfigs[i];
			if (luaEquipOverrideConfig == null)
			{
				throw new InvalidOperationException("[SummerRace] " + contextLabel + "[" + i + "] is null.");
			}
			EquipKind equipKind = array[i];
			if (!string.IsNullOrWhiteSpace(luaEquipOverrideConfig.equipKey))
			{
				EquipKind[] array3 = SummerRaceBattleStartContextUtility.ParseEquipKinds(new string[1] { luaEquipOverrideConfig.equipKey });
				if (array3.Length != 1)
				{
					throw new InvalidOperationException("[SummerRace] " + contextLabel + "[" + i + "] invalid equipKey: " + luaEquipOverrideConfig.equipKey);
				}
				if (array3[0] != equipKind)
				{
					throw new InvalidOperationException("[SummerRace] " + contextLabel + "[" + i + "] key mismatch: equipKey=" + luaEquipOverrideConfig.equipKey + " expectedKind=" + equipKind);
				}
			}
			array2[i] = new SummerRacePlayerController.EquipProfileOverrideSpec
			{
				EquipKind = equipKind,
				Cost = Mathf.Max(0, luaEquipOverrideConfig.cost),
				EnergyCost = Mathf.Max(0f, luaEquipOverrideConfig.energyCost)
			};
		}
		return array2;
	}

	private static SummerRacePlayerController.BodyProfileOverrideSpec BuildPlayerBodyOverride(LuaPlayerConfig playerConfig)
	{
		if (playerConfig == null)
		{
			return null;
		}
		LuaBodyOverrideConfig bodyOverrides = playerConfig.bodyOverrides;
		SummerRacePlayerController.BodyProfileOverrideSpec bodyProfileOverrideSpec = new SummerRacePlayerController.BodyProfileOverrideSpec();
		if (TryResolveOverrideValue(bodyOverrides?.baseHp ?? float.NaN, playerConfig.baseHp, bodyOverrides?.hp ?? float.NaN, playerConfig.hp, out var value))
		{
			bodyProfileOverrideSpec.HasMaxHp = true;
			bodyProfileOverrideSpec.MaxHp = value;
		}
		if (TryResolveOverrideValue(bodyOverrides?.costCap ?? float.NaN, playerConfig.costCap, bodyOverrides?.cost ?? float.NaN, playerConfig.cost, out var value2))
		{
			bodyProfileOverrideSpec.HasCostCap = true;
			bodyProfileOverrideSpec.CostCap = Mathf.RoundToInt(value2);
		}
		if (TryResolveOverrideValue(bodyOverrides?.moveSpeed ?? float.NaN, playerConfig.moveSpeed, bodyOverrides?.speed ?? float.NaN, playerConfig.speed, out var value3))
		{
			bodyProfileOverrideSpec.HasCruiseSpeed = true;
			bodyProfileOverrideSpec.CruiseSpeed = value3;
		}
		if (TryResolveOverrideValue(bodyOverrides?.forwardAcceleration ?? float.NaN, playerConfig.forwardAcceleration, out var value4))
		{
			bodyProfileOverrideSpec.HasForwardAcceleration = true;
			bodyProfileOverrideSpec.ForwardAcceleration = value4;
		}
		if (TryResolveOverrideValue(bodyOverrides?.mass ?? float.NaN, playerConfig.mass, out var value5))
		{
			bodyProfileOverrideSpec.HasMass = true;
			bodyProfileOverrideSpec.Mass = value5;
		}
		if (TryResolveOverrideValue(bodyOverrides?.drag ?? float.NaN, playerConfig.drag, out var value6))
		{
			bodyProfileOverrideSpec.HasDrag = true;
			bodyProfileOverrideSpec.Drag = value6;
		}
		if (TryResolveOverrideValue(bodyOverrides?.angularDrag ?? float.NaN, playerConfig.angularDrag, out var value7))
		{
			bodyProfileOverrideSpec.HasAngularDrag = true;
			bodyProfileOverrideSpec.AngularDrag = value7;
		}
		if (TryResolveOverrideValue(bodyOverrides?.gravityScale ?? float.NaN, playerConfig.gravityScale, out var value8))
		{
			bodyProfileOverrideSpec.HasGravityScale = true;
			bodyProfileOverrideSpec.GravityScale = value8;
		}
		if (TryResolveOverrideValue(bodyOverrides?.tractionGain ?? float.NaN, playerConfig.tractionGain, out var value9))
		{
			bodyProfileOverrideSpec.HasTractionGain = true;
			bodyProfileOverrideSpec.TractionGain = value9;
		}
		if (TryResolveOverrideValue(bodyOverrides?.collisionImpulseScale ?? float.NaN, playerConfig.collisionImpulseScale, out var value10))
		{
			bodyProfileOverrideSpec.HasCollisionImpulseScale = true;
			bodyProfileOverrideSpec.CollisionImpulseScale = value10;
		}
		if (!bodyProfileOverrideSpec.HasAnyOverride)
		{
			return null;
		}
		return bodyProfileOverrideSpec;
	}

	private static bool TryResolveOverrideValue(float primary, float secondary, out float value)
	{
		return TryResolveOverrideValue(primary, secondary, float.NaN, float.NaN, out value);
	}

	private static bool TryResolveOverrideValue(float primary, float secondary, float fallbackPrimary, float fallbackSecondary, out float value)
	{
		if (!float.IsNaN(primary))
		{
			value = primary;
			return true;
		}
		if (!float.IsNaN(secondary))
		{
			value = secondary;
			return true;
		}
		if (!float.IsNaN(fallbackPrimary))
		{
			value = fallbackPrimary;
			return true;
		}
		if (!float.IsNaN(fallbackSecondary))
		{
			value = fallbackSecondary;
			return true;
		}
		value = 0f;
		return false;
	}

	private static string ResolveEnemyBuildNameFromPayload(LuaLaunchPayload payload)
	{
		if (payload != null && payload.enemyConfig != null && !string.IsNullOrWhiteSpace(payload.enemyConfig.buildName))
		{
			return payload.enemyConfig.buildName.Trim();
		}
		return string.Empty;
	}

	private static void ResolveEnemyBuildOverrideFromPayload(LuaLaunchPayload payload, RuntimeLaunchConfig config)
	{
		if (payload != null && payload.enemyConfig != null && SummerRaceBattleStartContextUtility.TryParseBodyType(payload.enemyConfig.bodyKey, out var bodyType))
		{
			config.enemyBodyType = bodyType;
			config.enemyWeaponKinds = SummerRaceBattleStartContextUtility.ParseWeaponKinds(payload.enemyConfig.weaponKeys);
			config.enemyEquipKinds = SummerRaceBattleStartContextUtility.ParseEquipKinds(payload.enemyConfig.equipKeys);
			config.hasEnemyBuildOverride = true;
		}
	}

	private static void ResolveActivitySourceOverrideFromPayload(LuaLaunchPayload payload, RuntimeLaunchConfig config)
	{
		if (payload != null && payload.activityConfig != null && payload.activityConfig.stage != null)
		{
			LuaActivityConfig activityConfig = payload.activityConfig;
			SummerRaceActivityStageSourceRecord summerRaceActivityStageSourceRecord = BuildStageSourceFromPayload(activityConfig.stage, config);
			SummerRaceActivityEnemySourceRecord[] activityEnemySources = BuildEnemySourcesFromPayload(activityConfig.enemies);
			SummerRaceActivityWeaponSourceRecord[] activityWeaponSources = BuildWeaponSourcesFromPayload(activityConfig.weapons);
			SummerRaceActivityEquipSourceRecord[] activityEquipSources = BuildEquipSourcesFromPayload(activityConfig.equips);
			if (string.IsNullOrWhiteSpace(config.stageId))
			{
				config.stageId = summerRaceActivityStageSourceRecord.Id;
			}
			ValidateLaunchStageWaveCount(config, summerRaceActivityStageSourceRecord);
			config.activityId = ((!string.IsNullOrWhiteSpace(config.activityId)) ? config.activityId : (string.IsNullOrWhiteSpace(activityConfig.activityId) ? config.activityId : activityConfig.activityId.Trim()));
			config.activityStageSources = new SummerRaceActivityStageSourceRecord[1] { summerRaceActivityStageSourceRecord };
			config.activityEnemySources = activityEnemySources;
			config.activityWeaponSources = activityWeaponSources;
			config.activityEquipSources = activityEquipSources;
			config.hasActivitySourceOverride = true;
		}
	}

	private static void ValidateLaunchStageWaveCount(RuntimeLaunchConfig config, SummerRaceActivityStageSourceRecord stageSource)
	{
		if (config != null && stageSource != null && config.enemyIds != null && config.enemyIds.Length != 0 && stageSource.Mode == SummerRaceActivityMode.Tournament)
		{
			int num = ((stageSource.Waves != null) ? stageSource.Waves.Length : 0);
			if (num != config.enemyIds.Length)
			{
				throw new InvalidOperationException("[SummerRace] launch stage wave count mismatch: stageId=" + stageSource.Id + " waves=" + num + " enemyIds=" + config.enemyIds.Length + ".");
			}
		}
	}

	private static SummerRaceActivityWeaponSourceRecord[] BuildWeaponSourcesFromPayload(LuaActivityWeaponSourceConfig[] weapons)
	{
		if (weapons == null || weapons.Length == 0)
		{
			return Array.Empty<SummerRaceActivityWeaponSourceRecord>();
		}
		List<SummerRaceActivityWeaponSourceRecord> list = new List<SummerRaceActivityWeaponSourceRecord>(weapons.Length);
		for (int i = 0; i < weapons.Length; i++)
		{
			LuaActivityWeaponSourceConfig luaActivityWeaponSourceConfig = weapons[i];
			if (luaActivityWeaponSourceConfig != null)
			{
				WeaponKind[] array = SummerRaceBattleStartContextUtility.ParseWeaponKinds(new string[1] { luaActivityWeaponSourceConfig.weaponKey });
				if (array.Length != 1)
				{
					throw new InvalidOperationException("[SummerRace] activityConfig.weapons[" + i + "] invalid weaponKey: " + luaActivityWeaponSourceConfig.weaponKey);
				}
				if (luaActivityWeaponSourceConfig.damage < 0)
				{
					throw new InvalidOperationException("[SummerRace] activityConfig.weapons[" + i + "] invalid damage < 0: " + luaActivityWeaponSourceConfig.damage);
				}
				if (luaActivityWeaponSourceConfig.rof <= 0f)
				{
					throw new InvalidOperationException("[SummerRace] activityConfig.weapons[" + i + "] invalid rof <= 0: " + luaActivityWeaponSourceConfig.rof);
				}
				list.Add(new SummerRaceActivityWeaponSourceRecord
				{
					WeaponType = ToWeaponTypeConfig(array[0]),
					DisplayName = (string.IsNullOrWhiteSpace(luaActivityWeaponSourceConfig.displayName) ? string.Empty : luaActivityWeaponSourceConfig.displayName.Trim()),
					Cost = Mathf.Max(0, luaActivityWeaponSourceConfig.cost),
					EnergyCost = Mathf.Max(0f, luaActivityWeaponSourceConfig.energyCost),
					CooldownSeconds = Mathf.Max(0f, luaActivityWeaponSourceConfig.cooldownSeconds),
					Damage = luaActivityWeaponSourceConfig.damage,
					FireInterval = 1f / luaActivityWeaponSourceConfig.rof,
					HasBurnOverride = luaActivityWeaponSourceConfig.hasBurnOverride,
					BurnDps = Mathf.Max(0, luaActivityWeaponSourceConfig.burnDps),
					BurnDuration = Mathf.Max(0f, luaActivityWeaponSourceConfig.burnDuration),
					EffectParams = ((luaActivityWeaponSourceConfig.effectParams != null) ? ((float[])luaActivityWeaponSourceConfig.effectParams.Clone()) : Array.Empty<float>())
				});
			}
		}
		return list.ToArray();
	}

	private static SummerRaceActivityEquipSourceRecord[] BuildEquipSourcesFromPayload(LuaActivityEquipSourceConfig[] equips)
	{
		if (equips == null || equips.Length == 0)
		{
			return Array.Empty<SummerRaceActivityEquipSourceRecord>();
		}
		List<SummerRaceActivityEquipSourceRecord> list = new List<SummerRaceActivityEquipSourceRecord>(equips.Length);
		for (int i = 0; i < equips.Length; i++)
		{
			LuaActivityEquipSourceConfig luaActivityEquipSourceConfig = equips[i];
			if (luaActivityEquipSourceConfig != null)
			{
				EquipKind[] array = SummerRaceBattleStartContextUtility.ParseEquipKinds(new string[1] { luaActivityEquipSourceConfig.equipKey });
				if (array.Length != 1)
				{
					throw new InvalidOperationException("[SummerRace] activityConfig.equips[" + i + "] invalid equipKey: " + luaActivityEquipSourceConfig.equipKey);
				}
				list.Add(new SummerRaceActivityEquipSourceRecord
				{
					EquipType = ToEquipTypeConfig(array[0]),
					DisplayName = (string.IsNullOrWhiteSpace(luaActivityEquipSourceConfig.displayName) ? string.Empty : luaActivityEquipSourceConfig.displayName.Trim()),
					Cost = Mathf.Max(0, luaActivityEquipSourceConfig.cost),
					EnergyCost = Mathf.Max(0f, luaActivityEquipSourceConfig.energyCost),
					CooldownSeconds = Mathf.Max(0f, luaActivityEquipSourceConfig.cooldownSeconds)
				});
			}
		}
		return list.ToArray();
	}

	private static SummerRaceActivityStageSourceRecord BuildStageSourceFromPayload(LuaActivityStageConfig stage, RuntimeLaunchConfig config)
	{
		if (stage == null)
		{
			throw new InvalidOperationException("[SummerRace] activityConfig.stage must not be null.");
		}
		string text = ((!string.IsNullOrWhiteSpace(stage.stageId)) ? stage.stageId.Trim() : ((!string.IsNullOrWhiteSpace(config.stageId)) ? config.stageId : string.Empty));
		if (string.IsNullOrWhiteSpace(text))
		{
			throw new InvalidOperationException("[SummerRace] activityConfig.stage.stageId must not be empty.");
		}
		SummerRaceActivityMode mode = ParseActivityMode(stage.mode, config);
		if (config.hasMode)
		{
			FightMode fightMode = ToFightMode(mode);
			if (config.mode != fightMode)
			{
				throw new InvalidOperationException("[SummerRace] activityConfig.stage mode mismatch: stage is " + fightMode.ToString() + " but launch mode is " + config.mode.ToString() + ".");
			}
		}
		else
		{
			config.mode = ToFightMode(mode);
			config.hasMode = true;
		}
		return new SummerRaceActivityStageSourceRecord
		{
			Id = text,
			DisplayName = text,
			Mode = mode,
			SortOrder = stage.sortOrder,
			IsMainline = stage.isMainline,
			MapName = (string.IsNullOrWhiteSpace(stage.mapName) ? string.Empty : stage.mapName.Trim()),
			ChallengePoolId = (string.IsNullOrWhiteSpace(stage.challengePoolId) ? string.Empty : stage.challengePoolId.Trim()),
			RecommendedPower = Mathf.Max(0, stage.recommendedPower),
			TimeLimitSeconds = Mathf.Max(0, stage.timeLimitSeconds),
			SurvivalDurationSeconds = Mathf.Max(0, stage.survivalDurationSeconds),
			ChallengeWaveHealRatio = SanitizeChallengeWaveHealRatio(stage.challengeWaveHealRatio),
			DamageToEnergyRatio = SanitizeDamageToEnergyRatio(stage.damageToEnergyRatio),
			EnergyRegenPerSecond = SanitizeEnergyRegenPerSecond(stage.energyRegenPerSecond),
			MaxEnergy = SanitizeMaxEnergy(stage.maxEnergy),
			ChallengeWaveScoreTable = SanitizeWaveScoreTable(stage.challengeWaveScoreTable),
			SpecialDefeatRules = BuildSpecialDefeatRulesFromPayload(stage.specialDefeatRules),
			Waves = BuildWaveSourcesFromPayload(stage.waves),
			SurvivalRandomPool = BuildEnemySpawnSources(stage.survivalRandomPool),
			ChallengeRandomPool = BuildEnemySpawnSources(stage.challengeRandomPool)
		};
	}

	private static SummerRaceActivitySpecialDefeatRuleSourceRecord[] BuildSpecialDefeatRulesFromPayload(LuaActivitySpecialDefeatRuleConfig[] rows)
	{
		if (rows == null || rows.Length == 0)
		{
			return Array.Empty<SummerRaceActivitySpecialDefeatRuleSourceRecord>();
		}
		List<SummerRaceActivitySpecialDefeatRuleSourceRecord> list = new List<SummerRaceActivitySpecialDefeatRuleSourceRecord>(rows.Length);
		foreach (LuaActivitySpecialDefeatRuleConfig luaActivitySpecialDefeatRuleConfig in rows)
		{
			if (luaActivitySpecialDefeatRuleConfig != null && !string.IsNullOrWhiteSpace(luaActivitySpecialDefeatRuleConfig.enemyId))
			{
				list.Add(new SummerRaceActivitySpecialDefeatRuleSourceRecord
				{
					WaveIndex = Mathf.Max(1, luaActivitySpecialDefeatRuleConfig.waveIndex),
					EnemyId = luaActivitySpecialDefeatRuleConfig.enemyId.Trim(),
					GuideId = Mathf.Max(0, luaActivitySpecialDefeatRuleConfig.guideId),
					FxId = (string.IsNullOrWhiteSpace(luaActivitySpecialDefeatRuleConfig.fxId) ? string.Empty : luaActivitySpecialDefeatRuleConfig.fxId.Trim())
				});
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<SummerRaceActivitySpecialDefeatRuleSourceRecord>();
		}
		return list.ToArray();
	}

	private static SummerRaceActivityMode ParseActivityMode(string modeRaw, RuntimeLaunchConfig config)
	{
		if (!string.IsNullOrWhiteSpace(modeRaw))
		{
			return ToActivityMode(ParseFightMode(modeRaw));
		}
		if (config != null && config.hasMode)
		{
			return ToActivityMode(config.mode);
		}
		throw new InvalidOperationException("[SummerRace] activityConfig.stage.mode must not be empty.");
	}

	private static SummerRaceActivityWaveSourceRecord[] BuildWaveSourcesFromPayload(LuaActivityWaveConfig[] waves)
	{
		if (waves == null || waves.Length == 0)
		{
			return Array.Empty<SummerRaceActivityWaveSourceRecord>();
		}
		SummerRaceActivityWaveSourceRecord[] array = new SummerRaceActivityWaveSourceRecord[waves.Length];
		for (int i = 0; i < waves.Length; i++)
		{
			LuaActivityWaveConfig luaActivityWaveConfig = waves[i] ?? new LuaActivityWaveConfig();
			int waveIndex = ((luaActivityWaveConfig.waveIndex > 0) ? luaActivityWaveConfig.waveIndex : (i + 1));
			array[i] = new SummerRaceActivityWaveSourceRecord
			{
				WaveIndex = waveIndex,
				SpawnIntervalSeconds = Mathf.Max(0f, luaActivityWaveConfig.spawnIntervalSeconds),
				MaxAliveEnemies = Mathf.Max(0, luaActivityWaveConfig.maxAliveEnemies),
				TimeLimitSeconds = Mathf.Max(0, luaActivityWaveConfig.timeLimitSeconds),
				Enemies = BuildEnemySpawnSources(luaActivityWaveConfig.enemyIds)
			};
		}
		return array;
	}

	private static SummerRaceActivityEnemySpawnSourceRecord[] BuildEnemySpawnSources(string[] enemyIds)
	{
		string[] array = NormalizeEnemyIdArray(enemyIds);
		if (array.Length == 0)
		{
			return Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
		}
		SummerRaceActivityEnemySpawnSourceRecord[] array2 = new SummerRaceActivityEnemySpawnSourceRecord[array.Length];
		for (int i = 0; i < array.Length; i++)
		{
			array2[i] = new SummerRaceActivityEnemySpawnSourceRecord
			{
				EnemyId = array[i],
				Count = 1,
				Weight = 1
			};
		}
		return array2;
	}

	private static SummerRaceActivityEnemySpawnSourceRecord[] BuildEnemySpawnSources(LuaActivitySpawnConfig[] entries)
	{
		if (entries == null || entries.Length == 0)
		{
			return Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
		}
		List<SummerRaceActivityEnemySpawnSourceRecord> list = new List<SummerRaceActivityEnemySpawnSourceRecord>(entries.Length);
		foreach (LuaActivitySpawnConfig luaActivitySpawnConfig in entries)
		{
			if (luaActivitySpawnConfig != null && !string.IsNullOrWhiteSpace(luaActivitySpawnConfig.enemyId))
			{
				list.Add(new SummerRaceActivityEnemySpawnSourceRecord
				{
					EnemyId = luaActivitySpawnConfig.enemyId.Trim(),
					Count = Mathf.Max(1, luaActivitySpawnConfig.count),
					SpawnDelaySeconds = Mathf.Max(0f, luaActivitySpawnConfig.spawnDelaySeconds),
					Weight = Mathf.Max(1, luaActivitySpawnConfig.weight),
					MinWave = Mathf.Max(1, luaActivitySpawnConfig.minWave),
					MaxWave = Mathf.Max(Mathf.Max(1, luaActivitySpawnConfig.minWave), luaActivitySpawnConfig.maxWave)
				});
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<SummerRaceActivityEnemySpawnSourceRecord>();
		}
		return list.ToArray();
	}

	private static int[] SanitizeWaveScoreTable(int[] scoreTable)
	{
		if (scoreTable == null || scoreTable.Length == 0)
		{
			return Array.Empty<int>();
		}
		List<int> list = new List<int>(scoreTable.Length);
		for (int i = 0; i < scoreTable.Length; i++)
		{
			int num = Mathf.Max(0, scoreTable[i]);
			if (num > 0)
			{
				list.Add(num);
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<int>();
		}
		return list.ToArray();
	}

	private static float SanitizeChallengeWaveHealRatio(float ratio)
	{
		if (float.IsNaN(ratio) || float.IsInfinity(ratio) || ratio < 0f || ratio > 1f)
		{
			throw new InvalidOperationException("[SummerRace] activityConfig.stage.challengeWaveHealRatio must be within [0,1], got " + ratio + ".");
		}
		return ratio;
	}

	private static float SanitizeDamageToEnergyRatio(float ratio)
	{
		if (float.IsNaN(ratio))
		{
			return 0.25f;
		}
		if (float.IsInfinity(ratio) || ratio < 0f)
		{
			throw new InvalidOperationException("[SummerRace] activityConfig.stage.damageToEnergyRatio must be >= 0, got " + ratio + ".");
		}
		return ratio;
	}

	private static float SanitizeEnergyRegenPerSecond(float regenPerSecond)
	{
		if (float.IsNaN(regenPerSecond))
		{
			return 1.8f;
		}
		if (float.IsInfinity(regenPerSecond) || regenPerSecond < 0f)
		{
			throw new InvalidOperationException("[SummerRace] activityConfig.stage.energyRegenPerSecond must be >= 0, got " + regenPerSecond + ".");
		}
		return regenPerSecond;
	}

	private static float SanitizeMaxEnergy(float maxEnergy)
	{
		if (float.IsNaN(maxEnergy))
		{
			return 10f;
		}
		if (float.IsInfinity(maxEnergy) || maxEnergy <= 0f)
		{
			throw new InvalidOperationException("[SummerRace] activityConfig.stage.maxEnergy must be > 0, got " + maxEnergy + ".");
		}
		return maxEnergy;
	}

	private static SummerRaceActivityEnemySourceRecord[] BuildEnemySourcesFromPayload(LuaActivityEnemySourceConfig[] enemies)
	{
		if (enemies == null || enemies.Length == 0)
		{
			return Array.Empty<SummerRaceActivityEnemySourceRecord>();
		}
		List<SummerRaceActivityEnemySourceRecord> list = new List<SummerRaceActivityEnemySourceRecord>(enemies.Length);
		for (int i = 0; i < enemies.Length; i++)
		{
			LuaActivityEnemySourceConfig luaActivityEnemySourceConfig = enemies[i];
			if (luaActivityEnemySourceConfig == null || string.IsNullOrWhiteSpace(luaActivityEnemySourceConfig.enemyId))
			{
				continue;
			}
			SummerRaceActivityEnemySourceRecord summerRaceActivityEnemySourceRecord = new SummerRaceActivityEnemySourceRecord
			{
				Id = luaActivityEnemySourceConfig.enemyId.Trim(),
				DisplayName = (string.IsNullOrWhiteSpace(luaActivityEnemySourceConfig.displayName) ? luaActivityEnemySourceConfig.enemyId.Trim() : luaActivityEnemySourceConfig.displayName.Trim()),
				BaseHp = Mathf.Max(1, luaActivityEnemySourceConfig.baseHp),
				MoveSpeed = ((luaActivityEnemySourceConfig.moveSpeed > 0f) ? luaActivityEnemySourceConfig.moveSpeed : 2.5f),
				DamageMultiplier = Mathf.Max(0f, luaActivityEnemySourceConfig.damageMultiplier),
				BattleIntroText = (string.IsNullOrWhiteSpace(luaActivityEnemySourceConfig.battleIntroText) ? string.Empty : luaActivityEnemySourceConfig.battleIntroText.Trim()),
				OverclockBubbleText = (string.IsNullOrWhiteSpace(luaActivityEnemySourceConfig.overclockBubbleText) ? string.Empty : luaActivityEnemySourceConfig.overclockBubbleText.Trim()),
				DefeatEffect = (string.IsNullOrWhiteSpace(luaActivityEnemySourceConfig.defeatEffect) ? string.Empty : luaActivityEnemySourceConfig.defeatEffect.Trim()),
				BodyIcon = (string.IsNullOrWhiteSpace(luaActivityEnemySourceConfig.bodyIcon) ? string.Empty : luaActivityEnemySourceConfig.bodyIcon.Trim()),
				LogoSkinName = (string.IsNullOrWhiteSpace(luaActivityEnemySourceConfig.logo) ? string.Empty : luaActivityEnemySourceConfig.logo.Trim())
			};
			string text = ResolveEnemyBuildName(luaActivityEnemySourceConfig);
			WeaponKind[] array = SummerRaceBattleStartContextUtility.ParseWeaponKinds(luaActivityEnemySourceConfig.weaponKeys);
			EquipKind[] array2 = SummerRaceBattleStartContextUtility.ParseEquipKinds(luaActivityEnemySourceConfig.equipKeys);
			bool flag = false;
			SummerRaceBodyType bodyType = SummerRaceBodyType.Medium;
			if (!string.IsNullOrWhiteSpace(luaActivityEnemySourceConfig.bodyKey))
			{
				if (!SummerRaceBattleStartContextUtility.TryParseBodyType(luaActivityEnemySourceConfig.bodyKey, out bodyType))
				{
					throw new InvalidOperationException("[SummerRace] activityConfig.enemies[" + i + "] bodyKey is invalid: " + luaActivityEnemySourceConfig.bodyKey);
				}
				flag = true;
			}
			if (!string.IsNullOrWhiteSpace(text))
			{
				summerRaceActivityEnemySourceRecord.BuildDefinition = SummerRaceConfigLoader.LoadBuildDef(text);
				if (summerRaceActivityEnemySourceRecord.BuildDefinition == null)
				{
					throw new InvalidOperationException("[SummerRace] activityConfig.enemies[" + i + "] build asset not found: " + text);
				}
				summerRaceActivityEnemySourceRecord.SignatureHint = ((summerRaceActivityEnemySourceRecord.BuildDefinition != null && !string.IsNullOrWhiteSpace(summerRaceActivityEnemySourceRecord.BuildDefinition.buildName)) ? summerRaceActivityEnemySourceRecord.BuildDefinition.buildName : text);
				if (flag)
				{
					summerRaceActivityEnemySourceRecord.BodyType = ToBodyTypeConfig(bodyType);
					summerRaceActivityEnemySourceRecord.HasBodyOverride = true;
				}
				if (array.Length != 0)
				{
					summerRaceActivityEnemySourceRecord.Weapons = ToWeaponTypeConfigs(array);
					summerRaceActivityEnemySourceRecord.HasWeaponOverride = true;
				}
				if (array2.Length != 0)
				{
					summerRaceActivityEnemySourceRecord.Equips = ToEquipTypeConfigs(array2);
					summerRaceActivityEnemySourceRecord.HasEquipOverride = true;
				}
			}
			else
			{
				if (!flag)
				{
					throw new InvalidOperationException("[SummerRace] activityConfig.enemies[" + i + "] requires either build asset name or valid bodyKey.");
				}
				summerRaceActivityEnemySourceRecord.BodyType = ToBodyTypeConfig(bodyType);
				summerRaceActivityEnemySourceRecord.Weapons = ToWeaponTypeConfigs(array);
				summerRaceActivityEnemySourceRecord.Equips = ToEquipTypeConfigs(array2);
				summerRaceActivityEnemySourceRecord.HasBodyOverride = true;
				summerRaceActivityEnemySourceRecord.HasWeaponOverride = array.Length != 0;
				summerRaceActivityEnemySourceRecord.HasEquipOverride = array2.Length != 0;
				summerRaceActivityEnemySourceRecord.SignatureHint = summerRaceActivityEnemySourceRecord.DisplayName;
			}
			list.Add(summerRaceActivityEnemySourceRecord);
		}
		return list.ToArray();
	}

	private static string ResolveEnemyBuildName(LuaActivityEnemySourceConfig enemy)
	{
		if (enemy == null)
		{
			return string.Empty;
		}
		if (!string.IsNullOrWhiteSpace(enemy.buildAssetName))
		{
			return enemy.buildAssetName.Trim();
		}
		if (!string.IsNullOrWhiteSpace(enemy.build_asset_name))
		{
			return enemy.build_asset_name.Trim();
		}
		if (!string.IsNullOrWhiteSpace(enemy.buildName))
		{
			return enemy.buildName.Trim();
		}
		return string.Empty;
	}

	private static string[] ResolveEnemyIdsFromPayload(LuaLaunchPayload payload)
	{
		if (payload != null && payload.enemyConfig != null)
		{
			return NormalizeEnemyIdArray(payload.enemyConfig.enemyIds);
		}
		return Array.Empty<string>();
	}

	private static string[] NormalizeEnemyIdArray(string[] enemyIds)
	{
		if (enemyIds == null || enemyIds.Length == 0)
		{
			return Array.Empty<string>();
		}
		List<string> list = new List<string>(enemyIds.Length);
		foreach (string text in enemyIds)
		{
			if (!string.IsNullOrWhiteSpace(text))
			{
				list.Add(text.Trim());
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<string>();
		}
		return list.ToArray();
	}

	private static FightMode ParseFightMode(string modeRaw)
	{
		switch (modeRaw.Trim().ToLowerInvariant())
		{
		case "1":
		case "championship":
		case "normal":
		case "tournament":
			return FightMode.Championship;
		case "2":
		case "survival_practice":
		case "survival":
			return FightMode.SurvivalPractice;
		case "3":
		case "one_vs_two_practice":
		case "onevstwo":
		case "1v2":
			return FightMode.OneVsTwoPractice;
		case "4":
		case "challenge":
			return FightMode.Challenge;
		case "0":
			return FightMode.Championship;
		default:
			throw new InvalidOperationException("[SummerRace] Unsupported launch mode from Lua: " + modeRaw);
		}
	}

	private void BootstrapRuntimeState()
	{
		if (bootstrappedForPlay)
		{
			return;
		}
		if (physicsTestMode && !IsPhysicsValidationContext())
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] physicsTestMode is enabled outside validation context. Forcing it off.");
			physicsTestMode = false;
		}
		Time.timeScale = 1f;
		ApplyPausePhysicsLock(locked: false);
		ApplyCountdownPhysicsLock(locked: false);
		player = UnityEngine.Object.FindObjectOfType<SummerRacePlayerController>(includeInactive: true);
		if (player == null)
		{
			throw new InvalidOperationException("[SummerRace] Missing SummerRacePlayerController in scene.");
		}
		bool activeSelf = player.gameObject.activeSelf;
		if (activeSelf)
		{
			player.gameObject.SetActive(value: false);
		}
		spawnPoints = ResolveSpawnPoints();
		if (spawnPoints == null || spawnPoints.Length == 0)
		{
			throw new InvalidOperationException("[SummerRace] No valid spawn points found for SummerRaceFightManager.");
		}
		ResolvePlayerSpawnAnchorOrFail();
		EnsureArenaFloor();
		EnsureArenaBoundaries();
		CleanupOrphanBodyPrefabClones("BootstrapRuntimeState");
		activeLaunchConfig = pendingLaunchConfig;
		pendingLaunchConfig = null;
		ApplyLaunchModeOverride();
		launchEnemyIds = Array.Empty<string>();
		reportedStageId = string.Empty;
		if (player != null)
		{
			ApplyLaunchPlayerOverride();
			player.RuntimePrepareForBattle(sideLaneY);
			player.EnsureModularBackendInitialized();
			player.SetInvincibleForPhysicsTest(ShouldApplyPhysicsValidationOverrides());
			if (!player.gameObject.activeSelf)
			{
				player.gameObject.SetActive(value: true);
			}
			if (activeSelf)
			{
				Log("Bootstrap reactivated player after deterministic spawn reset: " + player.gameObject.name);
			}
		}
		phase = FightPhase.Countdown;
		CancelTimeoutResultSequence();
		resultWin = false;
		resultText = string.Empty;
		resultReason = string.Empty;
		suppressRuntimeSnapshotForLoseSettlement = false;
		battleElapsed = 0f;
		waveElapsedBaseline = 0f;
		currentWaveTimeLimitSeconds = 0f;
		currentWaveRemainingSeconds = 0f;
		nextSpawnTime = 0f;
		isPaused = false;
		initialEnemiesSpawned = false;
		spawnedEnemyBlueprints.Clear();
		recentEnemyBuildSignatureQueue.Clear();
		recentEnemyBuildSignatureSet.Clear();
		enemyArchetypeSpawnCounts.Clear();
		pendingCatalogWaveEnemies.Clear();
		survivalCatalogEntries.Clear();
		currentCatalogSpawnInterval = -1f;
		launchEnemyContractOverride = null;
		nextRuntimeSnapshotPushAt = 0f;
		runtimeEnemyOverclockBubbleText = string.Empty;
		runtimeEnemyOverclockBubbleToken = 0;
		ReloadActivityRuntimeCatalog();
		ApplyLaunchStageAndEnemyOverride();
		ApplyConfiguredFightMap();
		ApplyStageRuntimeTunings();
		SetupFightByMode();
		AlignSideLaneObjects();
		ResetPlayerForWaveEntry(useChallengePartialHeal: false);
		BeginWaveEntrySequence();
		ApplySceneSpriteRendererMaterials();
		EnsureSideViewCamera();
		ResetBattleCameraState();
		bootstrappedForPlay = true;
		lastBootstrapAt = Time.unscaledTime;
		PublishResolvedStage();
		PublishRuntimeSnapshot(force: true);
		Log("Bootstrap done: spawnPoints=" + spawnPoints.Length + ", phase=" + phase.ToString() + ", initialEnemyCount=" + initialEnemyCount + ", catalogEnemies=" + ((activityCatalog != null && activityCatalog.Enemies != null) ? activityCatalog.Enemies.Length : 0) + ", stage=" + ((activeActivityStage != null) ? activeActivityStage.Id : "none"));
	}

	private static bool IsPhysicsValidationContext()
	{
		MonoBehaviour[] array = UnityEngine.Object.FindObjectsOfType<MonoBehaviour>(includeInactive: true);
		foreach (MonoBehaviour monoBehaviour in array)
		{
			if (!(monoBehaviour == null) && monoBehaviour.isActiveAndEnabled && string.Equals(monoBehaviour.GetType().Name, "SummerRaceModeValidationProbe", StringComparison.Ordinal))
			{
				return true;
			}
		}
		return false;
	}

	private static bool ShouldApplyPhysicsValidationOverrides()
	{
		return IsPhysicsValidationContext();
	}

	private static bool IsValidationControlContext()
	{
		if (validationControlEnabled)
		{
			return IsPhysicsValidationContext();
		}
		return false;
	}

	private void CleanupRuntimeForPreparedLaunchRestart()
	{
		CleanupPendingNormalDefeatState();
		CleanupSpecialDefeatState();
		CancelTimeoutResultSequence();
		ApplyPausePhysicsLock(locked: false);
		ApplyCountdownPhysicsLock(locked: false);
		for (int num = aliveEnemyRefs.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num];
			if (summerRaceEnemy != null)
			{
				UnityEngine.Object.Destroy(summerRaceEnemy.gameObject);
			}
		}
		aliveEnemyRefs.Clear();
		enemySpawnMetaMap.Clear();
		lastDefeatedEnemyHudSlot = null;
		CleanupOrphanBodyPrefabClones("PreparedLaunchRestart");
		launchEnemyIds = Array.Empty<string>();
		pendingCatalogWaveEnemies.Clear();
		survivalCatalogEntries.Clear();
		activeSpecialDefeatRules.Clear();
		currentCatalogSpawnInterval = -1f;
		launchEnemyContractOverride = null;
		nextSpawnTime = 0f;
		isPaused = false;
		resultWin = false;
		resultText = string.Empty;
		resultReason = string.Empty;
		reportedStageId = string.Empty;
		battleRuntime.ClearSettlement();
		if (player != null)
		{
			player.ResetRuntimePreparationForBattleRestart();
		}
	}

	private void Update()
	{
		SyncRuntimeDebugLogSwitch();
		if (!bootstrappedForPlay)
		{
			PublishRuntimeSnapshot(force: false);
			return;
		}
		if (isPaused)
		{
			PublishRuntimeSnapshot(force: false);
			return;
		}
		if (phase == FightPhase.Countdown)
		{
			TickCountdown();
			PublishRuntimeSnapshot(force: false);
			return;
		}
		if (phase == FightPhase.SpecialDefeatPending)
		{
			PublishRuntimeSnapshot(force: false);
			return;
		}
		if (phase != FightPhase.Battle)
		{
			PublishRuntimeSnapshot(force: false);
			return;
		}
		if (battleResultBannerPending || timeoutResultCoroutine != null || timeoutWinWaveAdvanceCoroutine != null)
		{
			PublishRuntimeSnapshot(force: false);
			return;
		}
		battleElapsed += Time.deltaTime;
		switch (fightMode)
		{
		case FightMode.Championship:
			TickWaveMode(championshipSpawnInterval, hasTimeLimit: false, 0f, 1);
			break;
		case FightMode.SurvivalPractice:
			TickSurvivalMode();
			break;
		case FightMode.OneVsTwoPractice:
			TickWaveMode(oneVsTwoSpawnInterval, hasTimeLimit: false, 0f, 2);
			break;
		case FightMode.Challenge:
			TickChallengeMode();
			break;
		}
		PublishRuntimeSnapshot(force: false);
	}

	private void LateUpdate()
	{
		if (battleResultBannerPending)
		{
			ApplyBattleResultCameraFreeze();
		}
		else if (phase != FightPhase.Result)
		{
			TickBattleCamera(Time.unscaledDeltaTime);
		}
		PublishPlayerLabelPose();
	}

	private void TickCountdown()
	{
		countdownRemaining -= Time.deltaTime;
		if (!(countdownRemaining > 0f))
		{
			ApplyCountdownPhysicsLock(locked: false);
			phase = FightPhase.Battle;
			SetBattleResultRuntimeLocked(locked: false);
			waveElapsedBaseline = battleElapsed;
			nextSpawnTime = ResolveBattleStartNextSpawnTime(fightMode, Time.time, (currentCatalogSpawnInterval > 0f) ? currentCatalogSpawnInterval : survivalSpawnInterval, initialEnemiesSpawned ? Mathf.Max(0, spawnedEnemies) : 0, Mathf.Max(0, initialEnemyCount), 0.25f);
			if (player != null)
			{
				player.SetMovementLocked(locked: false);
			}
			PublishRuntimeSnapshot(force: true);
		}
	}

	private static float ResolveBattleStartNextSpawnTime(FightMode mode, float now, float survivalInterval, int spawnedEnemyCount, int initialEnemyCount, float defaultDelay)
	{
		float num = Mathf.Max(0f, defaultDelay);
		if (mode != FightMode.SurvivalPractice || spawnedEnemyCount <= 0 || initialEnemyCount <= 0)
		{
			return now + num;
		}
		return now + Mathf.Max(0f, survivalInterval);
	}

	private void TickWaveMode(float spawnInterval, bool hasTimeLimit, float timeLimit, int maxAliveEnemiesInWave)
	{
		ApplyChampionshipSingleEnemyRule();
		float num = ((currentCatalogSpawnInterval > 0f) ? currentCatalogSpawnInterval : spawnInterval);
		int num2 = Mathf.Max(1, maxAliveEnemiesInWave);
		if (currentWaveTimeLimitSeconds > 0f)
		{
			currentWaveRemainingSeconds = Mathf.Max(0f, currentWaveRemainingSeconds - Time.deltaTime);
			if (currentWaveRemainingSeconds <= 0f)
			{
				if (ResolveTimeLimitWinnerByHpPercent(out var resultMessage))
				{
					BeginTimeoutWinDefeatSequence();
					return;
				}
				PushTimeoutResultToLua(isWin: false);
				EndFight(isWin: false, resultMessage, "timeout");
				return;
			}
		}
		if (hasTimeLimit && battleElapsed >= timeLimit)
		{
			bool isWin = ResolveTimeLimitWinnerByHpPercent(out var resultMessage2);
			PushTimeoutResultToLua(isWin);
			EndFight(isWin, resultMessage2, "timeout");
			return;
		}
		if (Time.time >= nextSpawnTime && enemiesToSpawnThisWave > 0 && aliveEnemies < num2)
		{
			if (SpawnEnemyForCurrentWave())
			{
				enemiesToSpawnThisWave--;
			}
			nextSpawnTime = Time.time + num;
		}
		bool num3 = enemiesToSpawnThisWave <= 0;
		bool flag = enemiesKilledThisWave >= currentWaveTotal && aliveEnemies <= 0;
		if (num3 & flag)
		{
			ProceedToNextWaveOrFinishAfterBattleResultBanner();
		}
	}

	private void TickSurvivalMode()
	{
		float num = ResolveSurvivalDurationSeconds();
		float num2 = ((currentCatalogSpawnInterval > 0f) ? currentCatalogSpawnInterval : survivalSpawnInterval);
		int num3 = currentSurvivalSpawnLimit;
		int num4 = ResolveSurvivalMaxAlive();
		if (battleElapsed >= num)
		{
			EndFight(isWin: true, "Survival clear");
		}
		else if (num3 > 0 && spawnedEnemies >= num3)
		{
			if (aliveEnemies <= 0)
			{
				EndFight(isWin: true, "All enemies defeated");
			}
		}
		else if ((num4 <= 0 || aliveEnemies < num4) && Time.time >= nextSpawnTime)
		{
			SummerRaceActivityEnemyContract nextSurvivalCatalogEnemy = GetNextSurvivalCatalogEnemy();
			if (nextSurvivalCatalogEnemy == null)
			{
				throw new InvalidOperationException("Survival spawn requires catalog enemy contract.");
			}
			if (SpawnEnemy(nextSurvivalCatalogEnemy, 1))
			{
				spawnedEnemies++;
			}
			nextSpawnTime = Time.time + num2;
		}
	}

	private void TickChallengeMode()
	{
		if (currentWaveTimeLimitSeconds > 0f)
		{
			currentWaveRemainingSeconds = Mathf.Max(0f, currentWaveRemainingSeconds - Time.deltaTime);
			if (currentWaveRemainingSeconds <= 0f)
			{
				if (ResolveTimeLimitWinnerByHpPercent(out var resultMessage))
				{
					BeginTimeoutWinDefeatSequence();
					return;
				}
				PushTimeoutResultToLua(isWin: false);
				EndFight(isWin: false, resultMessage, "timeout");
				return;
			}
		}
		float num = ((currentCatalogSpawnInterval > 0f) ? currentCatalogSpawnInterval : ResolveChallengeSpawnInterval(ResolveChallengeWaveNumber()));
		if (aliveEnemies < Mathf.Max(1, currentChallengeMaxAlive) && Time.time >= nextSpawnTime && enemiesToSpawnThisWave > 0)
		{
			int wave = ResolveChallengeWaveNumber();
			SummerRaceActivityEnemyContract summerRaceActivityEnemyContract = ResolveChallengeCatalogEnemy();
			if (summerRaceActivityEnemyContract == null)
			{
				throw new InvalidOperationException("Challenge spawn requires catalog enemy contract.");
			}
			if (SpawnEnemy(summerRaceActivityEnemyContract, wave))
			{
				spawnedEnemies++;
			}
			nextSpawnTime = Time.time + num;
		}
		challengeScore = ResolveChallengeScore();
		if (enemiesToSpawnThisWave <= 0 && enemiesKilledThisWave >= currentWaveTotal && aliveEnemies <= 0)
		{
			ProceedToNextWaveOrFinishAfterBattleResultBanner();
		}
	}

	public void RegisterEnemyDestroyed(SummerRaceEnemy enemy)
	{
		int num = currentWaveIndex + 1;
		string enemyId = string.Empty;
		bool flag = enemy == null;
		if (enemy != null)
		{
			num = Mathf.Max(1, enemy.SpawnWaveIndex);
			flag = aliveEnemyRefs.Contains(enemy);
			if (enemySpawnMetaMap.TryGetValue(enemy, out var value) && value != null)
			{
				flag = true;
				num = Mathf.Max(1, value.WaveIndex);
				enemyId = value.EnemyId;
			}
		}
		if (!flag)
		{
			Log("Enemy destroyed ignored: enemy is no longer tracked by active wave state.");
			return;
		}
		aliveEnemies = Mathf.Max(0, aliveEnemies - 1);
		destroyedEnemies++;
		if (num == currentWaveIndex + 1)
		{
			enemiesKilledThisWave++;
		}
		else
		{
			Log("Enemy destroyed from previous wave ignored for current wave count: enemyWave=" + num + " currentWave=" + (currentWaveIndex + 1));
		}
		if (enemy != null)
		{
			CaptureLastDefeatedEnemyHudSlot(enemy);
			MarkSurvivalEnemyHudSlotDefeated(enemy);
			RecordSurvivalEnemySettlement(num, enemyId, "win", ResolveCurrentWaveElapsed(), showTime: true);
			aliveEnemyRefs.Remove(enemy);
			enemySpawnMetaMap.Remove(enemy);
		}
		if (fightMode == FightMode.Challenge)
		{
			challengeScore = ResolveChallengeScore();
		}
		else if (fightMode == FightMode.SurvivalPractice)
		{
			TryAccelerateSurvivalSpawnAfterEnemyDestroyed();
		}
		TryContinueTimeoutWinAfterEnemyDestroyed();
		Log("Enemy destroyed: alive=" + aliveEnemies + " destroyed=" + destroyedEnemies + " waveKills=" + enemiesKilledThisWave);
	}

	private void TryAccelerateSurvivalSpawnAfterEnemyDestroyed()
	{
		if (phase != FightPhase.Battle)
		{
			return;
		}
		int num = currentSurvivalSpawnLimit;
		if (num <= 0 || spawnedEnemies < num)
		{
			int num2 = ResolveSurvivalMaxAlive();
			if (num2 <= 0 || aliveEnemies < num2)
			{
				nextSpawnTime = Mathf.Min(nextSpawnTime, Time.time);
			}
		}
	}

	public void OnPlayerDefeated()
	{
		if (phase == FightPhase.Battle)
		{
			if (fightMode == FightMode.Challenge)
			{
				EndFightAfterBattleResultBanner(isWin: false, "Challenge ended");
			}
			else
			{
				EndFightAfterBattleResultBanner(isWin: false, "Player defeated");
			}
		}
	}

	private void SetupFightByMode()
	{
		bool num = applyPreparedLaunchRestart;
		applyPreparedLaunchRestart = false;
		if (!num || fightMode == FightMode.Challenge)
		{
			waveEntryEnergySnapshots.Clear();
		}
		aliveEnemies = 0;
		spawnedEnemies = 0;
		forcedEnemyBodyCursor = 0;
		destroyedEnemies = 0;
		currentWaveIndex = 0;
		enemiesKilledThisWave = 0;
		currentWaveTotal = 0;
		challengeScore = 0;
		challengeLastScore = 0;
		challengeLastWave = 0;
		if (num && (fightMode == FightMode.Championship || fightMode == FightMode.OneVsTwoPractice))
		{
			RemoveLoseRoundSettlements();
		}
		else
		{
			roundSettlementRecords.Clear();
		}
		survivalEnemySettlementRecords.Clear();
		challengeRoundSettlementRecords.Clear();
		activeSpecialDefeatRules.Clear();
		CollectSpecialDefeatRulesForCurrentStage();
		waveElapsedBaseline = 0f;
		pendingCatalogWaveEnemies.Clear();
		currentCatalogSpawnInterval = -1f;
		currentSurvivalSpawnLimit = 0;
		currentChallengeMaxAlive = Mathf.Max(1, challengeMaxAlive);
		ClearSurvivalEnemyHudSlots();
		lastDefeatedEnemyHudSlot = null;
		if (fightMode == FightMode.Championship)
		{
			int requestedWaveIndex = ResolveLaunchCatalogWaveIndex();
			if (!TryPrimeCatalogWave(requestedWaveIndex))
			{
				throw new InvalidOperationException("Championship mode requires catalog wave configuration.");
			}
		}
		else if (fightMode == FightMode.OneVsTwoPractice)
		{
			int requestedWaveIndex2 = ResolveLaunchCatalogWaveIndex();
			if (!TryPrimeCatalogWave(requestedWaveIndex2))
			{
				throw new InvalidOperationException("1v2 mode requires catalog wave configuration.");
			}
		}
		else if (fightMode == FightMode.Challenge)
		{
			SummerRaceChallengeProgressSnapshot summerRaceChallengeProgressSnapshot = SummerRaceChallengeProgressStore.Load();
			challengeBestScore = summerRaceChallengeProgressSnapshot.BestScore;
			challengeBestWave = summerRaceChallengeProgressSnapshot.BestWave;
			challengeLastScore = summerRaceChallengeProgressSnapshot.LastScore;
			challengeLastWave = summerRaceChallengeProgressSnapshot.LastWave;
			if (!TryPrimeChallengeWave(0))
			{
				throw new InvalidOperationException("Challenge mode requires catalog challenge data.");
			}
		}
		else
		{
			RebuildSurvivalCatalogPool();
			enemiesToSpawnThisWave = 0;
		}
	}

	private void CollectSpecialDefeatRulesForCurrentStage()
	{
		if (!IsSpecialDefeatSupportedMainlineMode() || activeActivityStage.SpecialDefeatRules == null || activeActivityStage.SpecialDefeatRules.Length == 0)
		{
			return;
		}
		for (int i = 0; i < activeActivityStage.SpecialDefeatRules.Length; i++)
		{
			SummerRaceActivitySpecialDefeatRuleContract summerRaceActivitySpecialDefeatRuleContract = activeActivityStage.SpecialDefeatRules[i];
			if (summerRaceActivitySpecialDefeatRuleContract != null && !string.IsNullOrWhiteSpace(summerRaceActivitySpecialDefeatRuleContract.EnemyId))
			{
				activeSpecialDefeatRules.Add(new SummerRaceActivitySpecialDefeatRuleContract
				{
					WaveIndex = Mathf.Max(1, summerRaceActivitySpecialDefeatRuleContract.WaveIndex),
					EnemyId = summerRaceActivitySpecialDefeatRuleContract.EnemyId.Trim(),
					GuideId = Mathf.Max(0, summerRaceActivitySpecialDefeatRuleContract.GuideId),
					FxId = (string.IsNullOrWhiteSpace(summerRaceActivitySpecialDefeatRuleContract.FxId) ? string.Empty : summerRaceActivitySpecialDefeatRuleContract.FxId.Trim())
				});
			}
		}
	}

	private bool TryMatchSpecialDefeatRule(SummerRaceEnemy enemy, out SummerRaceActivitySpecialDefeatRuleContract matchedRule)
	{
		matchedRule = null;
		if (enemy == null || activeSpecialDefeatRules.Count <= 0)
		{
			return false;
		}
		int num = Mathf.Max(1, enemy.SpawnWaveIndex);
		string text = (string.IsNullOrWhiteSpace(enemy.CatalogEnemyId) ? string.Empty : enemy.CatalogEnemyId.Trim());
		if (enemySpawnMetaMap.TryGetValue(enemy, out var value) && value != null)
		{
			num = Mathf.Max(1, value.WaveIndex);
			if (!string.IsNullOrWhiteSpace(value.EnemyId))
			{
				text = value.EnemyId.Trim();
			}
		}
		if (string.IsNullOrWhiteSpace(text))
		{
			return false;
		}
		for (int i = 0; i < activeSpecialDefeatRules.Count; i++)
		{
			SummerRaceActivitySpecialDefeatRuleContract summerRaceActivitySpecialDefeatRuleContract = activeSpecialDefeatRules[i];
			if (summerRaceActivitySpecialDefeatRuleContract != null && Mathf.Max(1, summerRaceActivitySpecialDefeatRuleContract.WaveIndex) == num && string.Equals(summerRaceActivitySpecialDefeatRuleContract.EnemyId, text, StringComparison.Ordinal))
			{
				matchedRule = summerRaceActivitySpecialDefeatRuleContract;
				activeSpecialDefeatRules.RemoveAt(i);
				return true;
			}
		}
		return false;
	}

	private void BeginSpecialDefeatPending(SummerRaceEnemy enemy, SummerRaceActivitySpecialDefeatRuleContract rule)
	{
		CleanupSpecialDefeatState();
		if (!(enemy == null) && rule != null)
		{
			specialDefeatPending = true;
			specialDefeatBlackoutDone = false;
			specialDefeatGuideDone = false;
			phase = FightPhase.SpecialDefeatPending;
			specialDefeatTargetEnemy = enemy;
			specialDefeatActiveRule = rule;
			specialDefeatActiveToken = ++specialDefeatTokenSeed;
			isPaused = false;
			if (player != null)
			{
				player.SetMovementLocked(locked: true);
			}
			ApplyCountdownPhysicsLock(locked: true);
			PushSpecialDefeatTriggeredToLua();
			PublishRuntimeSnapshot(force: true);
		}
	}

	private void TryFinalizeSpecialDefeatAfterLuaSync(int token)
	{
		if (specialDefeatPending && token == specialDefeatActiveToken && specialDefeatBlackoutDone && specialDefeatGuideDone)
		{
			if (specialDefeatFinalizeCoroutine != null)
			{
				StopCoroutine(specialDefeatFinalizeCoroutine);
			}
			specialDefeatFinalizeCoroutine = StartCoroutine(CoFinalizeSpecialDefeat(token));
		}
	}

	private void ExecuteSpecialDefeatRepositionAndFreeze()
	{
		if (!specialDefeatPending)
		{
			return;
		}
		if (player != null)
		{
			player.RestoreToFullBetweenWaves(RequirePlayerSpawnAnchorX(), float.NaN);
			player.SetMovementLocked(locked: true);
			player.PlaySpecialDefeatBattleAdminIntro();
		}
		for (int num = aliveEnemyRefs.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num];
			EnemySpawnMeta value;
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num);
			}
			else if (enemySpawnMetaMap.TryGetValue(summerRaceEnemy, out value) && value != null)
			{
				summerRaceEnemy.ResetForSpecialDefeat(value.SpawnX, float.NaN);
				summerRaceEnemy.PlaySpecialDefeatBattleAdminIntro();
			}
		}
		ApplyCountdownPhysicsLock(locked: true);
		PublishRuntimeSnapshot(force: true);
	}

	private IEnumerator CoFinalizeSpecialDefeat(int token)
	{
		if (UsesPersistentEnemyHudSlots())
		{
			SetPersistentEnemyHudSlotHeadOut(specialDefeatTargetEnemy, headOut: true);
			PublishRuntimeSnapshot(force: true);
		}
		else
		{
			SetEnemyHeadOut(value: true);
		}
		SummerRaceEnemy target = specialDefeatTargetEnemy;
		string defeatEffect = ResolveSpecialDefeatEffect(specialDefeatActiveRule, target);
		bool playFlagDefeat = IsFlagDefeatEffect(defeatEffect);
		if (!playFlagDefeat)
		{
			SummerRaceActivitySpecialDefeatRuleContract rule = new SummerRaceActivitySpecialDefeatRuleContract
			{
				FxId = NormalizeDefeatFxId(defeatEffect)
			};
			bool flag = IsBoom2DefeatEffect(defeatEffect);
			if (flag && target != null)
			{
				target.PrepareForDefeatExplosion();
			}
			float fxLifetime = SanitizeDefeatFxFinalizeWaitSeconds(PlaySpecialDefeatFxOnTarget(rule, target));
			float hideLeadSeconds = (flag ? 0.3f : 0f);
			float num = Mathf.Max(0f, fxLifetime - hideLeadSeconds);
			if (num > 0f)
			{
				yield return new WaitForSecondsRealtime(num);
			}
			if (hideLeadSeconds > 0f && target != null)
			{
				target.HideForSpecialDefeatExplosion();
			}
			float num2 = Mathf.Min(hideLeadSeconds, fxLifetime);
			if (num2 > 0f)
			{
				yield return new WaitForSecondsRealtime(num2);
			}
		}
		if (!specialDefeatPending || token != specialDefeatActiveToken)
		{
			yield break;
		}
		if (target != null)
		{
			if (playFlagDefeat)
			{
				float num3 = Mathf.Clamp(target.PlaySpecialDefeatLoseAnimation(), 0f, 5f);
				if (num3 > 0f)
				{
					yield return new WaitForSecondsRealtime(num3);
				}
				yield return null;
			}
			RegisterEnemyDestroyed(target);
			UnityEngine.Object.Destroy(target.gameObject);
		}
		string resumedPhase = "Result";
		bool flag2 = false;
		if (phase == FightPhase.SpecialDefeatPending)
		{
			if (enemiesToSpawnThisWave <= 0 && enemiesKilledThisWave >= currentWaveTotal && aliveEnemies <= 0)
			{
				ProceedToNextWaveOrFinishAfterBattleResultBanner(token);
				flag2 = battleResultBannerPending;
				resumedPhase = (flag2 ? "Result" : ResolveHudPhaseState());
			}
			else
			{
				phase = FightPhase.Battle;
				ApplyCountdownPhysicsLock(locked: false);
				if (player != null)
				{
					player.SetMovementLocked(locked: false);
				}
				resumedPhase = ResolveHudPhaseState();
			}
		}
		if (!flag2)
		{
			PushSpecialDefeatFinishedToLua(token, resumedPhase);
		}
		CleanupSpecialDefeatState();
		PublishRuntimeSnapshot(force: true);
	}

	private float PlaySpecialDefeatFxOnTarget(SummerRaceActivitySpecialDefeatRuleContract rule, SummerRaceEnemy targetEnemy)
	{
		if (targetEnemy == null)
		{
			return 0f;
		}
		string text = ((rule != null && !string.IsNullOrWhiteSpace(rule.FxId)) ? rule.FxId.Trim() : "fx_summerrace_boom_1");
		string effectPath = ((text.IndexOf('/') >= 0) ? text : ("summerrace/effect/" + text));
		return SummerRaceCombatPresentationRouter.PublishDefeat(presentationEvent: new SummerRaceDefeatPresentationEvent(effectPath, targetEnemy.transform.position, Vector2.right, targetEnemy.transform, targetEnemy.transform), sourceTransform: targetEnemy.transform);
	}

	private string ResolveSpecialDefeatEffect(SummerRaceActivitySpecialDefeatRuleContract rule, SummerRaceEnemy targetEnemy)
	{
		if (rule != null && !string.IsNullOrWhiteSpace(rule.FxId))
		{
			return rule.FxId.Trim();
		}
		return ResolveDefeatEffectForEnemy(targetEnemy);
	}

	private bool BeginNormalDefeatPending(SummerRaceEnemy enemy)
	{
		if (enemy == null)
		{
			return false;
		}
		if (pendingNormalDefeatCoroutines.ContainsKey(enemy))
		{
			return true;
		}
		if (IsFlagDefeatEffect(ResolveDefeatEffectForEnemy(enemy)))
		{
			enemy.PrepareForFlagDefeatAnimation();
		}
		else
		{
			enemy.HideForNormalDefeatExplosion();
		}
		if (UsesPersistentEnemyHudSlots())
		{
			PublishRuntimeSnapshot(force: true);
		}
		else
		{
			SetEnemyHeadOut(value: true);
		}
		Coroutine value = StartCoroutine(CoFinalizeNormalDefeat(enemy));
		pendingNormalDefeatCoroutines[enemy] = value;
		return true;
	}

	private IEnumerator CoFinalizeNormalDefeat(SummerRaceEnemy enemy)
	{
		if (enemy == null)
		{
			yield break;
		}
		yield return CoWaitEnemyDefeatGuideBeforeFx(enemy);
		string defeatEffect = ResolveDefeatEffectForEnemy(enemy);
		if (IsFlagDefeatEffect(defeatEffect))
		{
			float num = Mathf.Clamp(enemy.PlaySpecialDefeatLoseAnimation(), 0f, 5f);
			if (num > 0f)
			{
				yield return new WaitForSecondsRealtime(num);
			}
			yield return null;
		}
		else
		{
			SummerRaceActivitySpecialDefeatRuleContract rule = new SummerRaceActivitySpecialDefeatRuleContract
			{
				FxId = NormalizeDefeatFxId(defeatEffect)
			};
			NotifyNormalDefeatExplosionForCameraShake();
			bool flag = IsBoom2DefeatEffect(defeatEffect);
			if (flag && enemy != null)
			{
				enemy.PrepareForDefeatExplosion();
			}
			float fxLifetime = SanitizeDefeatFxFinalizeWaitSeconds(PlaySpecialDefeatFxOnTarget(rule, enemy));
			float hideLeadSeconds = (flag ? 0.3f : 0f);
			float num2 = Mathf.Max(0f, fxLifetime - hideLeadSeconds);
			if (num2 > 0f)
			{
				yield return new WaitForSecondsRealtime(num2);
			}
			if (hideLeadSeconds > 0f && enemy != null)
			{
				enemy.HideForSpecialDefeatExplosion();
			}
			float num3 = Mathf.Min(hideLeadSeconds, fxLifetime);
			if (num3 > 0f)
			{
				yield return new WaitForSecondsRealtime(num3);
			}
		}
		if (enemy != null)
		{
			RegisterEnemyDestroyed(enemy);
			UnityEngine.Object.Destroy(enemy.gameObject);
		}
		pendingNormalDefeatCoroutines.Remove(enemy);
	}

	private IEnumerator CoWaitEnemyDefeatGuideBeforeFx(SummerRaceEnemy enemy)
	{
		if (enemy == null || !IsEnemyDefeatGuideWaitRelevant(enemy))
		{
			yield break;
		}
		while (enemyDefeatGuideSyncActive && IsEnemyDefeatGuideWaitRelevant(enemy))
		{
			yield return null;
		}
		if (!IsEnemyDefeatGuideWaitRelevant(enemy))
		{
			yield break;
		}
		enemyDefeatGuideSyncActive = true;
		int token = PushEnemyDefeatBeforeFxToLua(enemy);
		if (token <= 0)
		{
			enemyDefeatGuideSyncActive = false;
			yield break;
		}
		float startedAt = Time.realtimeSinceStartup;
		while (IsEnemyDefeatGuideWaitRelevant(enemy) && !enemyDefeatGuideFinishedTokens.Contains(token) && Time.realtimeSinceStartup - startedAt < 10f)
		{
			yield return null;
		}
		enemyDefeatGuideFinishedTokens.Remove(token);
		enemyDefeatGuideSyncActive = false;
	}

	private bool IsEnemyDefeatGuideWaitRelevant(SummerRaceEnemy enemy)
	{
		if (enemy == null || phase == FightPhase.Result)
		{
			return false;
		}
		if (phase != FightPhase.Battle)
		{
			return phase == FightPhase.SpecialDefeatPending;
		}
		return true;
	}

	private int PushEnemyDefeatBeforeFxToLua(SummerRaceEnemy enemy)
	{
		if (enemy == null)
		{
			return 0;
		}
		int wave = Mathf.Max(1, enemy.SpawnWaveIndex);
		string text = enemy.CatalogEnemyId ?? string.Empty;
		if (enemySpawnMetaMap.TryGetValue(enemy, out var value) && value != null)
		{
			wave = Mathf.Max(1, value.WaveIndex);
			if (!string.IsNullOrWhiteSpace(value.EnemyId))
			{
				text = value.EnemyId.Trim();
			}
		}
		if (string.IsNullOrWhiteSpace(text))
		{
			return 0;
		}
		int num = ++enemyDefeatGuideTokenSeed;
		if (!SummerRaceLuaBridge.PushEnemyDefeatBeforeFxEvent(JsonUtility.ToJson(new EnemyDefeatBeforeFxEventPayload
		{
			token = num,
			stageId = ResolveReportedStageId(),
			wave = wave,
			enemyId = text
		})))
		{
			return 0;
		}
		return num;
	}

	private void PushTimeoutResultToLua(bool isWin)
	{
		SummerRaceLuaBridge.PushTimeoutResultEvent(JsonUtility.ToJson(new TimeoutResultEventPayload
		{
			result = (isWin ? "win" : "lose"),
			delaySeconds = 2f
		}));
	}

	private void PushBattleResultBannerToLua(bool isWin)
	{
		SummerRaceLuaBridge.PushBattleResultBannerEvent(JsonUtility.ToJson(new BattleResultBannerEventPayload
		{
			result = (isWin ? "win" : "lose"),
			delaySeconds = 2f
		}));
	}

	private void CleanupPendingNormalDefeatState()
	{
		enemyDefeatGuideFinishedTokens.Clear();
		enemyDefeatGuideSyncActive = false;
		if (pendingNormalDefeatCoroutines.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<SummerRaceEnemy, Coroutine> pendingNormalDefeatCoroutine in pendingNormalDefeatCoroutines)
		{
			if (pendingNormalDefeatCoroutine.Value != null)
			{
				StopCoroutine(pendingNormalDefeatCoroutine.Value);
			}
		}
		pendingNormalDefeatCoroutines.Clear();
	}

	private static float SanitizeDefeatFxFinalizeWaitSeconds(float rawLifetime)
	{
		if (float.IsNaN(rawLifetime) || float.IsInfinity(rawLifetime) || rawLifetime <= 0f)
		{
			return 0f;
		}
		return Mathf.Min(rawLifetime, 2f);
	}

	private string ResolveDefeatEffectForEnemy(SummerRaceEnemy enemy)
	{
		if (enemy != null && enemySpawnMetaMap.TryGetValue(enemy, out var value) && value != null)
		{
			if (!string.IsNullOrWhiteSpace(value.DefeatEffect))
			{
				return value.DefeatEffect.Trim();
			}
			return string.Empty;
		}
		string text = ((enemy != null) ? enemy.CatalogEnemyId : string.Empty);
		if (!string.IsNullOrWhiteSpace(text) && activityCatalog != null && activityCatalog.TryGetEnemy(text.Trim(), out var enemy2) && enemy2 != null)
		{
			if (!string.IsNullOrWhiteSpace(enemy2.DefeatEffect))
			{
				return enemy2.DefeatEffect.Trim();
			}
			return string.Empty;
		}
		return string.Empty;
	}

	private static bool IsFlagDefeatEffect(string defeatEffect)
	{
		return string.Equals(string.IsNullOrWhiteSpace(defeatEffect) ? string.Empty : defeatEffect.Trim(), "flag", StringComparison.OrdinalIgnoreCase);
	}

	private static bool IsBoom2DefeatEffect(string defeatEffect)
	{
		string text = (string.IsNullOrWhiteSpace(defeatEffect) ? string.Empty : defeatEffect.Trim());
		if (text.IndexOf("boom_2", StringComparison.OrdinalIgnoreCase) < 0 && text.IndexOf("boom2", StringComparison.OrdinalIgnoreCase) < 0)
		{
			return text.IndexOf("boom02", StringComparison.OrdinalIgnoreCase) >= 0;
		}
		return true;
	}

	private static bool IsTimeoutWinSpecialDefeatEffect(string defeatEffect)
	{
		if (!IsBoom2DefeatEffect(defeatEffect))
		{
			return IsFlagDefeatEffect(defeatEffect);
		}
		return true;
	}

	private static string NormalizeDefeatFxId(string defeatEffect)
	{
		string text = (string.IsNullOrWhiteSpace(defeatEffect) ? string.Empty : defeatEffect.Trim());
		if (string.IsNullOrEmpty(text) || IsFlagDefeatEffect(text))
		{
			return "fx_summerrace_boom_1";
		}
		if (text.IndexOf('/') >= 0)
		{
			return text;
		}
		if (!text.StartsWith("fx_summerrace_", StringComparison.Ordinal))
		{
			return "fx_summerrace_" + text;
		}
		return text;
	}

	private void PushSpecialDefeatTriggeredToLua()
	{
		if (!specialDefeatPending || specialDefeatTargetEnemy == null)
		{
			return;
		}
		int wave = Mathf.Max(1, specialDefeatTargetEnemy.SpawnWaveIndex);
		string text = specialDefeatTargetEnemy.CatalogEnemyId ?? string.Empty;
		if (enemySpawnMetaMap.TryGetValue(specialDefeatTargetEnemy, out var value) && value != null)
		{
			wave = Mathf.Max(1, value.WaveIndex);
			if (!string.IsNullOrWhiteSpace(value.EnemyId))
			{
				text = value.EnemyId.Trim();
			}
		}
		SummerRaceLuaBridge.PushSpecialDefeatEvent(JsonUtility.ToJson(new SpecialDefeatEventPayload
		{
			token = specialDefeatActiveToken,
			stageId = ResolveReportedStageId(),
			wave = wave,
			enemyId = (text ?? string.Empty),
			guideId = ((specialDefeatActiveRule != null) ? Mathf.Max(0, specialDefeatActiveRule.GuideId) : 0),
			fxId = ((specialDefeatActiveRule != null && !string.IsNullOrWhiteSpace(specialDefeatActiveRule.FxId)) ? specialDefeatActiveRule.FxId.Trim() : "fx_summerrace_boom_1")
		}));
	}

	private void PushSpecialDefeatFinishedToLua(int token, string resumedPhase)
	{
		SummerRaceLuaBridge.PushSpecialDefeatFinished(JsonUtility.ToJson(new SpecialDefeatFinishedPayload
		{
			token = token,
			resumedPhase = (string.IsNullOrWhiteSpace(resumedPhase) ? string.Empty : resumedPhase)
		}));
	}

	private void CleanupSpecialDefeatState()
	{
		if (specialDefeatFinalizeCoroutine != null)
		{
			StopCoroutine(specialDefeatFinalizeCoroutine);
			specialDefeatFinalizeCoroutine = null;
		}
		specialDefeatPending = false;
		specialDefeatBlackoutDone = false;
		specialDefeatGuideDone = false;
		specialDefeatActiveToken = 0;
		specialDefeatTargetEnemy = null;
		specialDefeatActiveRule = null;
		enemyDefeatGuideFinishedTokens.Clear();
		enemyDefeatGuideSyncActive = false;
	}

	private bool SpawnEnemyForCurrentWave()
	{
		int wave = Mathf.Max(1, currentWaveIndex + 1);
		SummerRaceActivityEnemyContract summerRaceActivityEnemyContract = ((pendingCatalogWaveEnemies.Count > 0) ? pendingCatalogWaveEnemies.Peek() : null);
		if (summerRaceActivityEnemyContract == null)
		{
			throw new InvalidOperationException("SpawnEnemyForCurrentWave requires catalog enemy contract.");
		}
		bool num = SpawnEnemy(summerRaceActivityEnemyContract, wave);
		if (num)
		{
			pendingCatalogWaveEnemies.Dequeue();
			spawnedEnemies++;
		}
		return num;
	}

	private void SpawnInitialEnemies()
	{
		if (initialEnemiesSpawned)
		{
			return;
		}
		if (initialEnemyCount <= 0)
		{
			initialEnemiesSpawned = true;
			return;
		}
		int wave = Mathf.Max(1, currentWaveIndex + 1);
		int num = Mathf.Max(0, initialEnemyCount);
		if (fightMode == FightMode.SurvivalPractice)
		{
			num = Mathf.Min(num, 1);
		}
		int num2 = ResolveWaveModeMaxAliveForCurrentFightMode();
		for (int i = 0; i < num; i++)
		{
			if (fightMode == FightMode.Championship || fightMode == FightMode.OneVsTwoPractice)
			{
				if (aliveEnemies >= num2 || enemiesToSpawnThisWave <= 0)
				{
					break;
				}
				if (SpawnEnemyForCurrentWave())
				{
					enemiesToSpawnThisWave--;
				}
			}
			else if (fightMode == FightMode.Challenge)
			{
				if (enemiesToSpawnThisWave <= 0)
				{
					break;
				}
				SummerRaceActivityEnemyContract summerRaceActivityEnemyContract = ResolveChallengeCatalogEnemy();
				if (summerRaceActivityEnemyContract == null)
				{
					throw new InvalidOperationException("Challenge enemy spawn requires catalog contract.");
				}
				if (SpawnEnemy(summerRaceActivityEnemyContract, wave))
				{
					enemiesToSpawnThisWave--;
					spawnedEnemies++;
				}
			}
			else
			{
				SummerRaceActivityEnemyContract nextSurvivalCatalogEnemy = GetNextSurvivalCatalogEnemy();
				if (nextSurvivalCatalogEnemy == null)
				{
					throw new InvalidOperationException("Survival enemy spawn requires catalog contract.");
				}
				if (SpawnEnemy(nextSurvivalCatalogEnemy, wave))
				{
					spawnedEnemies++;
				}
			}
		}
		initialEnemiesSpawned = true;
	}

	private int ResolveWaveModeMaxAliveForCurrentFightMode()
	{
		return fightMode switch
		{
			FightMode.Championship => 1, 
			FightMode.OneVsTwoPractice => 2, 
			_ => int.MaxValue, 
		};
	}

	private bool SpawnEnemy(SummerRaceActivityEnemyContract contract, int wave)
	{
		if (contract == null)
		{
			throw new InvalidOperationException("SpawnEnemy(contract, wave) received null contract.");
		}
		if (spawnPoints == null || spawnPoints.Length == 0)
		{
			Log("Spawn skipped: spawnPoints empty");
			return false;
		}
		bool openingSpawn = spawnedEnemies <= 0;
		float minGapToPlayer = ResolvePlayerSpawnForbiddenGapX(openingSpawn);
		Vector3 preferredPos = ResolveSpawnPosition(openingSpawn, minGapToPlayer);
		if (float.IsNaN(preferredPos.x))
		{
			Log("Spawn skipped: no valid spawn position");
			return false;
		}
		SummerRaceBodyType? forcedBodyType = PeekForcedEnemyBodyType();
		SummerRaceActivityEnemyContract contract2 = ApplyLaunchEnemyBuildOverride(contract);
		SummerRaceActivityEnemyContract summerRaceActivityEnemyContract = ResolveCatalogContractForSpawn(contract2, forcedBodyType);
		string text = ((summerRaceActivityEnemyContract != null) ? summerRaceActivityEnemyContract.Id : contract.Id);
		GameObject gameObject = new GameObject(string.IsNullOrEmpty(text) ? ("Enemy2D_" + spawnedEnemies) : (text + "_" + spawnedEnemies));
		gameObject.transform.position = new Vector3(preferredPos.x, sideLaneY, 0f);
		SummerRaceEnemy summerRaceEnemy = gameObject.AddComponent<SummerRaceEnemy>();
		summerRaceEnemy.ConfigureCatalogBuild(summerRaceActivityEnemyContract);
		summerRaceEnemy.SetCombatTarget(player);
		ApplyEnemyEnergyRuntimeTunings(summerRaceEnemy);
		runtimeEnemyIntroText = ((summerRaceActivityEnemyContract != null) ? (summerRaceActivityEnemyContract.BattleIntroText ?? string.Empty) : string.Empty);
		summerRaceEnemy.EnsureModularBackendInitialized();
		summerRaceEnemy.SetCombatTarget(player);
		ApplyEnemySpriteRendererMaterials(summerRaceEnemy);
		if (!TryResolveSpawnSeparation(summerRaceEnemy, preferredPos, openingSpawn, minGapToPlayer, out var resolvedPos))
		{
			Log("Spawn skipped: unresolved overlap near x=" + preferredPos.x.ToString("F2"));
			UnityEngine.Object.Destroy(gameObject);
			return false;
		}
		float num = summerRaceEnemy.ResolveSpawnPlacementY(sideLaneY);
		float spawnY = ResolveEnemyWaveEntrySpawnY(num);
		summerRaceEnemy.SetLaneY(sideLaneY);
		summerRaceEnemy.ApplyWaveEntrySpawnPose(resolvedPos.x, spawnY);
		aliveEnemyRefs.Add(summerRaceEnemy);
		aliveEnemies++;
		TrackEnemySpawn(summerRaceEnemy, gameObject, wave, text, num);
		BindSurvivalEnemyHudSlot(summerRaceEnemy);
		CommitForcedEnemyBodySample(forcedBodyType);
		return true;
	}

	private float ResolveEnemyWaveEntrySpawnY(float defaultSpawnY)
	{
		if (float.IsNaN(currentWaveEntrySpawnY) || float.IsInfinity(currentWaveEntrySpawnY))
		{
			return defaultSpawnY;
		}
		return currentWaveEntrySpawnY;
	}

	private void ApplyEnemySpriteRendererMaterials(SummerRaceEnemy enemy)
	{
		if (forceDefault2DMaterialForSceneSpriteRenderers && !(enemy == null))
		{
			SpriteRenderer[] componentsInChildren = enemy.GetComponentsInChildren<SpriteRenderer>(includeInactive: true);
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				SummerRaceSpriteMaterialUtility.ApplyDefault2D(componentsInChildren[i]);
			}
		}
	}

	private SummerRaceBodyType? PeekForcedEnemyBodyType()
	{
		if (!ensureEnemyBodyVariety || forcedEnemyBodyCursor >= 3)
		{
			return null;
		}
		return (SummerRaceBodyType)(forcedEnemyBodyCursor % 3);
	}

	private void CommitForcedEnemyBodySample(SummerRaceBodyType? forcedBodyType)
	{
		if (forcedBodyType.HasValue && ensureEnemyBodyVariety && forcedEnemyBodyCursor < 3)
		{
			forcedEnemyBodyCursor++;
		}
	}

	private SummerRaceActivityEnemyContract ResolveCatalogContractForSpawn(SummerRaceActivityEnemyContract contract, SummerRaceBodyType? forcedBodyType)
	{
		if (contract == null)
		{
			return null;
		}
		if (!ShouldApplyPhysicsValidationOverrides() || !forcedBodyType.HasValue)
		{
			return contract;
		}
		if (contract.BodyType == forcedBodyType.Value)
		{
			return contract;
		}
		return new SummerRaceActivityEnemyContract
		{
			Id = contract.Id,
			DisplayName = contract.DisplayName,
			BodyType = forcedBodyType.Value,
			Weapons = (contract.Weapons ?? Array.Empty<WeaponKind>()),
			Equips = (contract.Equips ?? Array.Empty<EquipKind>()),
			PreferredArchetype = contract.PreferredArchetype,
			SignatureHint = contract.SignatureHint,
			BaseHp = contract.BaseHp,
			MoveSpeed = contract.MoveSpeed,
			CollisionDamage = contract.CollisionDamage,
			DamageMultiplier = contract.DamageMultiplier,
			BattleIntroText = contract.BattleIntroText,
			OverclockBubbleText = contract.OverclockBubbleText,
			DefeatEffect = contract.DefeatEffect,
			BodyIcon = contract.BodyIcon,
			LogoSkinName = contract.LogoSkinName
		};
	}

	private SummerRaceActivityEnemyContract ApplyLaunchEnemyBuildOverride(SummerRaceActivityEnemyContract contract)
	{
		if (contract == null || launchEnemyContractOverride == null)
		{
			return contract;
		}
		return new SummerRaceActivityEnemyContract
		{
			Id = contract.Id,
			DisplayName = contract.DisplayName,
			BodyType = launchEnemyContractOverride.BodyType,
			Weapons = (launchEnemyContractOverride.Weapons ?? Array.Empty<WeaponKind>()),
			Equips = (launchEnemyContractOverride.Equips ?? Array.Empty<EquipKind>()),
			PreferredArchetype = launchEnemyContractOverride.PreferredArchetype,
			SignatureHint = (string.IsNullOrWhiteSpace(launchEnemyContractOverride.SignatureHint) ? contract.SignatureHint : launchEnemyContractOverride.SignatureHint),
			BaseHp = Mathf.Max(contract.BaseHp, launchEnemyContractOverride.BaseHp),
			MoveSpeed = Mathf.Max(contract.MoveSpeed, launchEnemyContractOverride.MoveSpeed),
			CollisionDamage = contract.CollisionDamage,
			DamageMultiplier = contract.DamageMultiplier,
			BattleIntroText = contract.BattleIntroText,
			OverclockBubbleText = contract.OverclockBubbleText,
			DefeatEffect = contract.DefeatEffect,
			BodyIcon = contract.BodyIcon,
			LogoSkinName = contract.LogoSkinName
		};
	}

	private SummerRaceActivityEnemyContract CreateLaunchEnemyContractFromBuildName(string buildName)
	{
		SummerRaceBuildDefSO summerRaceBuildDefSO = SummerRaceConfigLoader.LoadBuildDef(buildName);
		if (summerRaceBuildDefSO == null)
		{
			throw new InvalidOperationException("Launch enemy build override not found: " + buildName);
		}
		if (summerRaceBuildDefSO.body == null)
		{
			throw new InvalidOperationException("Launch enemy build override body is missing: " + buildName);
		}
		SummerRaceBodyType bodyType = SummerRaceConfigLoader.ToRuntimeBodyType(summerRaceBuildDefSO.body.bodyType);
		WeaponKind[] weapons = ToRuntimeWeaponKinds(summerRaceBuildDefSO.weapons);
		EquipKind[] equips = ToRuntimeEquipKinds(summerRaceBuildDefSO.equips);
		LogLoadoutCostIfOverflow("Enemy launch build", bodyType, weapons, equips);
		string text = (string.IsNullOrWhiteSpace(summerRaceBuildDefSO.buildName) ? summerRaceBuildDefSO.name : summerRaceBuildDefSO.buildName);
		return new SummerRaceActivityEnemyContract
		{
			Id = buildName,
			DisplayName = text,
			BodyType = bodyType,
			Weapons = weapons,
			Equips = equips,
			PreferredArchetype = SummerRaceBuildArchetype.Unknown,
			SignatureHint = text,
			BaseHp = Mathf.Max(1, Mathf.RoundToInt(summerRaceBuildDefSO.body.baseHp)),
			MoveSpeed = Mathf.Max(0.1f, summerRaceBuildDefSO.body.moveSpeed),
			CollisionDamage = baseEnemyCollisionDamage,
			DamageMultiplier = 1f,
			BattleIntroText = string.Empty,
			OverclockBubbleText = string.Empty,
			DefeatEffect = string.Empty,
			BodyIcon = string.Empty,
			LogoSkinName = string.Empty
		};
	}

	private SummerRaceActivityEnemyContract CreateLaunchEnemyContractFromLoadout(SummerRaceBodyType bodyType, WeaponKind[] weapons, EquipKind[] equips, string signatureHint)
	{
		SummerRaceBodyDefSO summerRaceBodyDefSO = SummerRaceConfigLoader.LoadBodyDef(bodyType);
		if (summerRaceBodyDefSO == null)
		{
			throw new InvalidOperationException("Launch enemy body override not found: " + bodyType);
		}
		WeaponKind[] weapons2 = weapons ?? Array.Empty<WeaponKind>();
		EquipKind[] equips2 = equips ?? Array.Empty<EquipKind>();
		LogLoadoutCostIfOverflow(signatureHint, bodyType, weapons2, equips2);
		return new SummerRaceActivityEnemyContract
		{
			Id = signatureHint,
			DisplayName = signatureHint,
			BodyType = bodyType,
			Weapons = weapons2,
			Equips = equips2,
			PreferredArchetype = SummerRaceBuildArchetype.Unknown,
			SignatureHint = signatureHint,
			BaseHp = Mathf.Max(1, Mathf.RoundToInt(summerRaceBodyDefSO.baseHp)),
			MoveSpeed = Mathf.Max(0.1f, summerRaceBodyDefSO.moveSpeed),
			CollisionDamage = baseEnemyCollisionDamage,
			DamageMultiplier = 1f,
			BattleIntroText = string.Empty,
			OverclockBubbleText = string.Empty,
			DefeatEffect = string.Empty,
			BodyIcon = string.Empty,
			LogoSkinName = string.Empty
		};
	}

	private static WeaponKind[] ToRuntimeWeaponKinds(List<SummerRaceWeaponDefSO> weaponDefs)
	{
		if (weaponDefs == null || weaponDefs.Count == 0)
		{
			return Array.Empty<WeaponKind>();
		}
		List<WeaponKind> list = new List<WeaponKind>(weaponDefs.Count);
		for (int i = 0; i < weaponDefs.Count; i++)
		{
			SummerRaceWeaponDefSO summerRaceWeaponDefSO = weaponDefs[i];
			if (!(summerRaceWeaponDefSO == null))
			{
				list.Add(SummerRaceConfigLoader.ToRuntimeWeaponKind(summerRaceWeaponDefSO.weaponType));
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<WeaponKind>();
		}
		return list.ToArray();
	}

	private static EquipKind[] ToRuntimeEquipKinds(List<SummerRaceEquipDefSO> equipDefs)
	{
		if (equipDefs == null || equipDefs.Count == 0)
		{
			return Array.Empty<EquipKind>();
		}
		List<EquipKind> list = new List<EquipKind>(equipDefs.Count);
		for (int i = 0; i < equipDefs.Count; i++)
		{
			SummerRaceEquipDefSO summerRaceEquipDefSO = equipDefs[i];
			if (!(summerRaceEquipDefSO == null))
			{
				list.Add(SummerRaceConfigLoader.ToRuntimeEquipKind(summerRaceEquipDefSO.equipType));
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<EquipKind>();
		}
		return list.ToArray();
	}

	private static void LogLoadoutCostIfOverflow(string label, SummerRaceBodyType bodyType, WeaponKind[] weapons, EquipKind[] equips)
	{
		SummerRaceBodyDefSO summerRaceBodyDefSO = SummerRaceConfigLoader.LoadBodyDef(bodyType);
		if (summerRaceBodyDefSO == null)
		{
			throw new InvalidOperationException("Loadout validation body config not found: " + bodyType);
		}
		int num = 0;
		WeaponKind[] array = weapons ?? Array.Empty<WeaponKind>();
		EquipKind[] array2 = equips ?? Array.Empty<EquipKind>();
		for (int i = 0; i < array.Length; i++)
		{
			SummerRaceWeaponDefSO summerRaceWeaponDefSO = SummerRaceConfigLoader.LoadWeaponDef(array[i]);
			num += ((summerRaceWeaponDefSO != null) ? Mathf.Max(0, summerRaceWeaponDefSO.cost) : 0);
		}
		for (int j = 0; j < array2.Length; j++)
		{
			SummerRaceEquipDefSO summerRaceEquipDefSO = SummerRaceConfigLoader.LoadEquipDef(array2[j]);
			num += ((summerRaceEquipDefSO != null) ? Mathf.Max(0, summerRaceEquipDefSO.cost) : 0);
		}
		if (num > summerRaceBodyDefSO.costCap)
		{
			SummerRaceRuntimeLog.Error("[SummerRace][Fight] " + label + " loadout cost exceeds body cap: cost=" + num + " cap=" + summerRaceBodyDefSO.costCap + " body=" + bodyType);
		}
	}

	private Vector3 ResolveSpawnPosition(bool openingSpawn, float minGapToPlayer)
	{
		if (spawnPoints == null || spawnPoints.Length == 0)
		{
			return new Vector3(float.NaN, 0f, 0f);
		}
		bool flag = TryResolvePlayerSpawnState(out var playerX, out var playerHalfWidth);
		if (openingSpawn && enforceOpeningFixedSpawnX && TryResolveOpeningFixedSpawnPosition(flag, playerX, playerHalfWidth, minGapToPlayer, out var resolvedPos))
		{
			return resolvedPos;
		}
		Vector3 result = new Vector3(float.NaN, sideLaneY, 0f);
		float num = float.NegativeInfinity;
		for (int i = 0; i < spawnPoints.Length; i++)
		{
			Transform transform = spawnPoints[i];
			if (transform == null)
			{
				continue;
			}
			Vector3 position = transform.position;
			position.y = sideLaneY;
			position.z = 0f;
			float minEnemyGapX = GetMinEnemyGapX(position.x);
			float num2 = (flag ? Mathf.Abs(position.x - playerX) : 100f);
			if (!flag || !(num2 < minGapToPlayer))
			{
				float num3 = minEnemyGapX * 2.2f + num2;
				if (num3 > num)
				{
					num = num3;
					result = position;
				}
			}
		}
		if (float.IsNaN(result.x))
		{
			for (int j = 0; j < spawnPoints.Length; j++)
			{
				if (!(spawnPoints[j] == null))
				{
					result = spawnPoints[j].position;
					result.y = sideLaneY;
					result.z = 0f;
					break;
				}
			}
		}
		if (float.IsNaN(result.x))
		{
			return result;
		}
		for (int k = 0; k < 6; k++)
		{
			float minEnemyGapX2 = GetMinEnemyGapX(result.x);
			float num4 = (flag ? Mathf.Abs(result.x - playerX) : 100f);
			if (minEnemyGapX2 >= minEnemySpawnGapX && (!flag || num4 >= minGapToPlayer))
			{
				break;
			}
			float num5 = (flag ? Mathf.Sign(result.x - playerX) : ((k % 2 == 0) ? 1f : (-1f)));
			if (Mathf.Abs(num5) < 0.001f)
			{
				num5 = ((k % 2 == 0) ? 1f : (-1f));
			}
			result.x = Mathf.Clamp(result.x + num5 * 0.9f, spawnMinX, spawnMaxX);
		}
		return result;
	}

	private float ResolvePlayerSpawnForbiddenGapX(bool openingSpawn)
	{
		float num = Mathf.Max(0f, minSpawnToPlayerGapX);
		if (!openingSpawn)
		{
			return num;
		}
		num = Mathf.Max(num, openingSpawnPlayerForbiddenGapX);
		if (fightMode == FightMode.SurvivalPractice)
		{
			num = Mathf.Max(num, survivalFirstSpawnPlayerForbiddenGapX);
		}
		return num;
	}

	private bool TryResolvePlayerSpawnState(out float playerX, out float playerHalfWidth)
	{
		playerX = 0f;
		playerHalfWidth = 0.72f;
		if (player == null)
		{
			return false;
		}
		Rigidbody2D component = player.GetComponent<Rigidbody2D>();
		playerX = ((component != null) ? component.position.x : player.transform.position.x);
		Collider2D component2 = player.GetComponent<Collider2D>();
		if (component2 != null)
		{
			playerHalfWidth = Mathf.Max(0.45f, component2.bounds.extents.x);
		}
		return true;
	}

	private bool TryResolveOpeningFixedSpawnPosition(bool hasPlayer, float playerX, float playerHalfWidth, float minGapToPlayer, out Vector3 resolvedPos)
	{
		resolvedPos = new Vector3(float.NaN, sideLaneY, 0f);
		float num = Mathf.Clamp(openingSpawnLeftX, spawnMinX, spawnMaxX);
		float num2 = Mathf.Clamp(openingSpawnRightX, spawnMinX, spawnMaxX);
		int num3;
		float num4;
		if (hasPlayer)
		{
			num3 = ((Mathf.Abs(num2 - playerX) >= Mathf.Abs(num - playerX)) ? 1 : 0);
			if (num3 == 0)
			{
				num4 = num;
				goto IL_006e;
			}
		}
		else
		{
			num3 = 1;
		}
		num4 = num2;
		goto IL_006e;
		IL_006e:
		float x = num4;
		float x2 = ((num3 != 0) ? num : num2);
		if (TryAcceptOpeningFixedSpawnX(x, hasPlayer, playerX, playerHalfWidth, minGapToPlayer, out resolvedPos))
		{
			return true;
		}
		return TryAcceptOpeningFixedSpawnX(x2, hasPlayer, playerX, playerHalfWidth, minGapToPlayer, out resolvedPos);
	}

	private bool TryAcceptOpeningFixedSpawnX(float x, bool hasPlayer, float playerX, float playerHalfWidth, float minGapToPlayer, out Vector3 resolvedPos)
	{
		resolvedPos = new Vector3(float.NaN, sideLaneY, 0f);
		float num = Mathf.Clamp(x, spawnMinX, spawnMaxX);
		if (hasPlayer && Mathf.Abs(num - playerX) < minGapToPlayer)
		{
			return false;
		}
		if (HasSpawnCollisionAtX(num, 0.65f, hasPlayer, playerX, playerHalfWidth, minGapToPlayer))
		{
			return false;
		}
		resolvedPos = new Vector3(num, sideLaneY, 0f);
		return true;
	}

	private bool TryResolveSpawnSeparation(SummerRaceEnemy enemy, Vector3 preferredPos, bool openingSpawn, float minGapToPlayer, out Vector3 resolvedPos)
	{
		resolvedPos = new Vector3(float.NaN, sideLaneY, 0f);
		if (enemy == null)
		{
			return false;
		}
		Collider2D component = enemy.GetComponent<Collider2D>();
		float selfHalfWidth = ((component != null) ? Mathf.Max(0.45f, component.bounds.extents.x) : 0.65f);
		bool hasPlayer = TryResolvePlayerSpawnState(out var playerX, out var playerHalfWidth);
		if (openingSpawn)
		{
			float x = Mathf.Clamp(preferredPos.x, spawnMinX, spawnMaxX);
			if (HasSpawnCollisionAtX(x, selfHalfWidth, hasPlayer, playerX, playerHalfWidth, minGapToPlayer))
			{
				return false;
			}
			resolvedPos = new Vector3(x, sideLaneY, 0f);
			return true;
		}
		BuildSpawnCandidateOffsets();
		for (int i = 0; i < spawnCandidateOffsets.Count; i++)
		{
			float x2 = Mathf.Clamp(preferredPos.x + spawnCandidateOffsets[i], spawnMinX, spawnMaxX);
			if (!HasSpawnCollisionAtX(x2, selfHalfWidth, hasPlayer, playerX, playerHalfWidth, minGapToPlayer))
			{
				resolvedPos = new Vector3(x2, sideLaneY, 0f);
				return true;
			}
		}
		return false;
	}

	private bool HasSpawnCollisionAtX(float x, float selfHalfWidth, bool hasPlayer, float playerX, float playerHalfWidth, float minGapToPlayer)
	{
		if (hasPlayer)
		{
			float a = selfHalfWidth + playerHalfWidth + Mathf.Max(0f, spawnColliderPaddingX);
			a = Mathf.Max(a, minGapToPlayer);
			if (Mathf.Abs(x - playerX) < a)
			{
				return true;
			}
		}
		for (int num = aliveEnemyRefs.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num);
			}
			else
			{
				Collider2D component = summerRaceEnemy.GetComponent<Collider2D>();
				float num2 = ((component != null) ? Mathf.Max(0.45f, component.bounds.extents.x) : 0.65f);
				float a2 = selfHalfWidth + num2 + Mathf.Max(0f, spawnColliderPaddingX);
				a2 = Mathf.Max(a2, minEnemySpawnGapX);
				if (Mathf.Abs(x - summerRaceEnemy.transform.position.x) < a2)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void BuildSpawnCandidateOffsets()
	{
		spawnCandidateOffsets.Clear();
		spawnCandidateOffsets.Add(0f);
		float num = Mathf.Max(0.25f, spawnSearchStepX);
		int num2 = Mathf.Clamp(spawnSearchSteps, 2, 20);
		for (int i = 1; i <= num2; i++)
		{
			float num3 = (float)i * num;
			spawnCandidateOffsets.Add(num3);
			spawnCandidateOffsets.Add(0f - num3);
		}
	}

	private float GetMinEnemyGapX(float x)
	{
		float num = float.MaxValue;
		for (int num2 = aliveEnemyRefs.Count - 1; num2 >= 0; num2--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num2];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num2);
			}
			else
			{
				float num3 = Mathf.Abs(summerRaceEnemy.transform.position.x - x);
				if (num3 < num)
				{
					num = num3;
				}
			}
		}
		if (num == float.MaxValue)
		{
			return 100f;
		}
		return num;
	}

	private void Log(string msg)
	{
		SummerRaceRuntimeLog.Verbose("[SummerRace][Fight] " + msg, this);
	}

	private void SyncRuntimeDebugLogSwitch()
	{
		if (lastRuntimeDebugLogForwarded != runtimeDebugLog)
		{
			lastRuntimeDebugLogForwarded = runtimeDebugLog;
			SummerRaceRuntimeLog.SetGameplayVerboseEnabled(runtimeDebugLog);
		}
	}

	private void ResetPlayerForWaveEntry(bool useChallengePartialHeal)
	{
		if (!(player == null))
		{
			float spawnX = RequirePlayerSpawnAnchorX();
			currentWaveEntrySpawnY = player.ResolveWaveEntrySpawnY();
			if ((fightMode == FightMode.Challenge) & useChallengePartialHeal)
			{
				player.RestorePartialHpBetweenWaves(ResolveChallengeWaveHealRatio(), spawnX, currentWaveEntrySpawnY);
				RestorePlayerEnergyForWaveEntryIfRecorded();
				RecordPlayerEnergyForWaveEntry();
				Log("Player wave entry reset(challenge): spawnX=" + spawnX.ToString("F2") + " spawnY=" + currentWaveEntrySpawnY.ToString("F2") + " " + DescribePlayerPose(player));
			}
			else
			{
				player.RestoreToFullBetweenWaves(spawnX, currentWaveEntrySpawnY);
				RestorePlayerEnergyForWaveEntryIfRecorded();
				RecordPlayerEnergyForWaveEntry();
				Log("Player wave entry reset: spawnX=" + spawnX.ToString("F2") + " spawnY=" + currentWaveEntrySpawnY.ToString("F2") + " " + DescribePlayerPose(player));
			}
		}
	}

	private void RestorePlayerEnergyForWaveEntryIfRecorded()
	{
		if (!(player == null))
		{
			int key = ResolveSettlementWaveNumber();
			if (waveEntryEnergySnapshots.TryGetValue(key, out var value))
			{
				player.RestoreEnergyForWaveEntrySnapshot(value);
				Log("Player wave entry energy restored: wave=" + key + " energy=" + player.CurrentEnergy.ToString("F2"));
			}
		}
	}

	private void RecordPlayerEnergyForWaveEntry()
	{
		if (!(player == null))
		{
			int key = ResolveSettlementWaveNumber();
			waveEntryEnergySnapshots[key] = player.CurrentEnergy;
			Log("Player wave entry energy recorded: wave=" + key + " energy=" + player.CurrentEnergy.ToString("F2"));
		}
	}

	private static string DescribePlayerPose(SummerRacePlayerController controller)
	{
		if (controller == null)
		{
			return "pose=missing-player";
		}
		Rigidbody2D component = controller.GetComponent<Rigidbody2D>();
		if (component == null)
		{
			return "pose=tf=" + controller.transform.position.ToString("F2");
		}
		return "pose=rb=" + component.position.ToString("F2") + " tf=" + controller.transform.position.ToString("F2");
	}

	private void BeginWaveEntrySequence()
	{
		lastDefeatedEnemyHudSlot = null;
		ClearPersistentEnemyHudSlotsForWaveEntry();
		ClearProjectilesForWaveTransition();
		SetEnemyHeadOut(value: false, publishImmediately: false);
		phase = FightPhase.Countdown;
		countdownRemaining = ResolveCountdownTotalDuration();
		waveElapsedBaseline = battleElapsed;
		currentWaveRemainingSeconds = currentWaveTimeLimitSeconds;
		nextSpawnTime = 0f;
		runtimeEnemyIntroText = string.Empty;
		runtimeEnemyOverclockBubbleText = string.Empty;
		runtimeEnemyOverclockBubbleToken = 0;
		isPaused = false;
		initialEnemiesSpawned = false;
		timeoutWinResultShownForWave = false;
		timeoutWinDefeatPending = false;
		if (float.IsNaN(currentWaveEntrySpawnY) && player != null)
		{
			currentWaveEntrySpawnY = player.ResolveWaveEntrySpawnY();
		}
		SpawnInitialEnemies();
		if (player != null)
		{
			player.SetMovementLocked(locked: true);
		}
		ApplyCountdownPhysicsLock(locked: true);
		PublishRuntimeSnapshot(force: true);
	}

	private void ClearProjectilesForWaveTransition()
	{
		ClearProjectilesForCharacter(player);
		for (int num = aliveEnemyRefs.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num);
			}
			else
			{
				ClearProjectilesForCharacter(summerRaceEnemy);
			}
		}
	}

	private static void ClearProjectilesForCharacter(Component character)
	{
		if (!(character == null))
		{
			VehicleWeaponSystem component = character.GetComponent<VehicleWeaponSystem>();
			if (component != null)
			{
				component.ClearProjectilesForWaveTransition();
			}
		}
	}

	private void ProceedToNextWaveOrFinish()
	{
		if (fightMode == FightMode.Challenge)
		{
			ProceedToNextChallengeWave();
			return;
		}
		RecordRoundSettlement(ResolveSettlementWaveNumber(), "win", ResolveCurrentWaveElapsed());
		currentWaveIndex++;
		enemiesKilledThisWave = 0;
		pendingCatalogWaveEnemies.Clear();
		if (fightMode == FightMode.Championship)
		{
			if (!TryPrimeCatalogWave(currentWaveIndex))
			{
				EndFight(isWin: true, "Championship clear");
				return;
			}
			ResetPlayerForWaveEntry(useChallengePartialHeal: false);
			BeginWaveEntrySequence();
		}
		else if (fightMode == FightMode.OneVsTwoPractice)
		{
			if (!TryPrimeCatalogWave(currentWaveIndex))
			{
				EndFight(isWin: true, "1v2 clear");
				return;
			}
			ResetPlayerForWaveEntry(useChallengePartialHeal: false);
			BeginWaveEntrySequence();
		}
	}

	private bool TryPrimeChallengeWave(int requestedWaveIndex)
	{
		pendingCatalogWaveEnemies.Clear();
		currentCatalogSpawnInterval = -1f;
		if (activityCatalog == null)
		{
			return false;
		}
		int num = Mathf.Max(0, requestedWaveIndex);
		int num2 = num + 1;
		if (num2 > 20)
		{
			return false;
		}
		int num3 = ResolveChallengeWaveEnemyCount(num2);
		if (num3 <= 0)
		{
			return false;
		}
		currentWaveIndex = num;
		currentWaveTotal = num3;
		enemiesToSpawnThisWave = num3;
		enemiesKilledThisWave = 0;
		currentCatalogSpawnInterval = ResolveChallengeSpawnInterval(num2);
		currentWaveTimeLimitSeconds = ((activeActivityStage != null) ? Mathf.Max(0f, activeActivityStage.TimeLimitSeconds) : 0f);
		currentWaveRemainingSeconds = currentWaveTimeLimitSeconds;
		currentChallengeMaxAlive = ResolveChallengeMaxAlive(num2);
		if (ResolveChallengeCatalogEnemy() == null)
		{
			return false;
		}
		Log("Challenge wave ready: wave=" + num2 + " count=" + currentWaveTotal + " maxAlive=" + currentChallengeMaxAlive + " interval=" + currentCatalogSpawnInterval.ToString("F2"));
		return true;
	}

	private void ProceedToNextChallengeWave()
	{
		int num = ResolveChallengeWaveNumber();
		RecordRoundSettlement(num, "win", ResolveCurrentWaveElapsed());
		RecordChallengeRoundSettlement(num, "win", ResolveCurrentWaveElapsed(), ResolveChallengeWaveEarnedScore(num));
		if (num >= 20)
		{
			EndFight(isWin: true, "Challenge clear");
			return;
		}
		currentWaveIndex++;
		enemiesKilledThisWave = 0;
		pendingCatalogWaveEnemies.Clear();
		if (!TryPrimeChallengeWave(currentWaveIndex))
		{
			throw new InvalidOperationException("Challenge wave progression requires catalog challenge data.");
		}
		ResetPlayerForWaveEntry(useChallengePartialHeal: true);
		challengeScore = ResolveChallengeScore();
		BeginWaveEntrySequence();
	}

	private void ReloadActivityRuntimeCatalog()
	{
		SummerRaceActivityStageSourceRecord[] stages = activityStageSource;
		SummerRaceActivityEnemySourceRecord[] explicitEnemySources = null;
		string text = activityId;
		if (activeLaunchConfig != null && activeLaunchConfig.hasActivitySourceOverride)
		{
			stages = activeLaunchConfig.activityStageSources ?? Array.Empty<SummerRaceActivityStageSourceRecord>();
			explicitEnemySources = activeLaunchConfig.activityEnemySources ?? Array.Empty<SummerRaceActivityEnemySourceRecord>();
			if (!string.IsNullOrWhiteSpace(activeLaunchConfig.activityId))
			{
				text = activeLaunchConfig.activityId;
			}
		}
		string requestedStageId = ResolveCatalogRequestedStageId();
		SummerRaceActivityLoadContext loadContext = new SummerRaceActivityLoadContext
		{
			ActivityId = text,
			RequestedStageId = requestedStageId
		};
		SummerRaceResolvedActivityRuntime summerRaceResolvedActivityRuntime = SummerRaceActivityRuntimeResolver.Resolve(text, ResolveActivityBuildDatabase(), stages, ResolveActivityMode(), loadContext, explicitEnemySources, (activeLaunchConfig != null && activeLaunchConfig.hasActivitySourceOverride) ? activeLaunchConfig.activityWeaponSources : null, (activeLaunchConfig != null && activeLaunchConfig.hasActivitySourceOverride) ? activeLaunchConfig.activityEquipSources : null);
		activityCatalogProvider = summerRaceResolvedActivityRuntime.Provider;
		activityCatalog = summerRaceResolvedActivityRuntime.Catalog;
		activeActivityStage = summerRaceResolvedActivityRuntime.ActiveStage;
		activeChallengePool = summerRaceResolvedActivityRuntime.ActiveChallengePool;
		Log("Activity catalog ready: enemies=" + ((activityCatalog != null && activityCatalog.Enemies != null) ? activityCatalog.Enemies.Length : 0) + " stages=" + ((activityCatalog != null && activityCatalog.Stages != null) ? activityCatalog.Stages.Length : 0) + " activeStage=" + ((activeActivityStage != null) ? activeActivityStage.Id : "none"));
	}

	private string ResolveCatalogRequestedStageId()
	{
		if (activeLaunchConfig != null && !string.IsNullOrWhiteSpace(activeLaunchConfig.stageId))
		{
			return activeLaunchConfig.stageId.Trim();
		}
		SummerRaceActivityStageSourceRecord[] array = ((activeLaunchConfig != null && activeLaunchConfig.hasActivitySourceOverride) ? (activeLaunchConfig.activityStageSources ?? Array.Empty<SummerRaceActivityStageSourceRecord>()) : (activityStageSource ?? Array.Empty<SummerRaceActivityStageSourceRecord>()));
		SummerRaceActivityMode summerRaceActivityMode = ResolveActivityMode();
		foreach (SummerRaceActivityStageSourceRecord summerRaceActivityStageSourceRecord in array)
		{
			if (summerRaceActivityStageSourceRecord != null && summerRaceActivityStageSourceRecord.Mode == summerRaceActivityMode && !string.IsNullOrWhiteSpace(summerRaceActivityStageSourceRecord.Id))
			{
				return summerRaceActivityStageSourceRecord.Id.Trim();
			}
		}
		return string.Empty;
	}

	private void ApplyLaunchModeOverride()
	{
		if (activeLaunchConfig != null && activeLaunchConfig.hasMode)
		{
			fightMode = activeLaunchConfig.mode;
			Log("Launch override: fightMode=" + fightMode);
		}
	}

	private void ApplyLaunchPlayerOverride()
	{
		if (activeLaunchConfig != null && !(player == null))
		{
			if (!string.IsNullOrWhiteSpace(activeLaunchConfig.playerBuildName))
			{
				player.SetConfiguredBuildNameForRuntime(activeLaunchConfig.playerBuildName);
				Log("Launch override: playerBuildName=" + activeLaunchConfig.playerBuildName);
			}
			else if (activeLaunchConfig.hasPlayerBuildOverride)
			{
				player.SetRuntimeBuildOverride(activeLaunchConfig.playerBodyType, activeLaunchConfig.playerWeaponKinds, activeLaunchConfig.playerWeaponOverrides, activeLaunchConfig.playerEquipKinds, activeLaunchConfig.playerEquipOverrides, activeLaunchConfig.playerBodyOverride, activeLaunchConfig.playerWeaponSlotIndices, activeLaunchConfig.playerEquipSlotIndices);
				Log("Launch override: body=" + activeLaunchConfig.playerBodyType.ToString() + " weapons=" + activeLaunchConfig.playerWeaponKinds.Length + " equips=" + activeLaunchConfig.playerEquipKinds.Length);
			}
		}
	}

	private void ApplyLaunchStageAndEnemyOverride()
	{
		launchEnemyIds = Array.Empty<string>();
		launchEnemyContractOverride = null;
		if (activeLaunchConfig != null)
		{
			if (!string.IsNullOrWhiteSpace(activeLaunchConfig.stageId))
			{
				ApplyLaunchStageOverride(activeLaunchConfig.stageId);
			}
			else
			{
				reportedStageId = ((activeActivityStage != null) ? activeActivityStage.Id : string.Empty);
			}
			if (activeLaunchConfig.enemyIds != null && activeLaunchConfig.enemyIds.Length != 0 && fightMode != FightMode.OneVsTwoPractice)
			{
				launchEnemyIds = activeLaunchConfig.enemyIds;
				Log("Launch override: enemyIds count=" + launchEnemyIds.Length);
			}
			if (!string.IsNullOrWhiteSpace(activeLaunchConfig.enemyBuildName))
			{
				launchEnemyContractOverride = CreateLaunchEnemyContractFromBuildName(activeLaunchConfig.enemyBuildName);
				Log("Launch override: enemyBuildName=" + activeLaunchConfig.enemyBuildName);
			}
			else if (activeLaunchConfig.hasEnemyBuildOverride)
			{
				launchEnemyContractOverride = CreateLaunchEnemyContractFromLoadout(activeLaunchConfig.enemyBodyType, activeLaunchConfig.enemyWeaponKinds, activeLaunchConfig.enemyEquipKinds, "launch_enemy_override");
				Log("Launch override: enemyBody=" + activeLaunchConfig.enemyBodyType.ToString() + " weapons=" + activeLaunchConfig.enemyWeaponKinds.Length + " equips=" + activeLaunchConfig.enemyEquipKinds.Length);
			}
		}
	}

	private void ApplyLaunchStageOverride(string stageId)
	{
		if (activityCatalog == null)
		{
			throw new InvalidOperationException("Launch stage override requires activity catalog.");
		}
		if (!activityCatalog.TryGetStage(stageId, out var stage) || stage == null)
		{
			reportedStageId = stageId;
			Log("Launch stage override kept as external stageId only: " + stageId);
			return;
		}
		FightMode fightMode = ToFightMode(stage.Mode);
		if (activeLaunchConfig != null && activeLaunchConfig.hasMode && activeLaunchConfig.mode != fightMode)
		{
			throw new InvalidOperationException("Launch stage/mode mismatch: stage '" + stageId + "' is " + fightMode.ToString() + " but mode override is " + activeLaunchConfig.mode.ToString() + ".");
		}
		this.fightMode = fightMode;
		activeActivityStage = stage;
		if (!string.IsNullOrEmpty(stage.ChallengePoolId))
		{
			activityCatalog.TryGetChallengePool(stage.ChallengePoolId, out activeChallengePool);
		}
		else
		{
			activeChallengePool = null;
		}
		reportedStageId = stageId;
		Log("Launch override: stageId=" + stageId + " mode=" + this.fightMode);
	}

	private string ResolveReportedStageId()
	{
		if (!string.IsNullOrWhiteSpace(reportedStageId))
		{
			return reportedStageId;
		}
		if (activeActivityStage == null)
		{
			return string.Empty;
		}
		return activeActivityStage.Id;
	}

	private bool IsSpecialDefeatSupportedMainlineMode()
	{
		if (fightMode == FightMode.Championship && activeActivityStage != null)
		{
			return activeActivityStage.IsMainline;
		}
		return false;
	}

	private static FightMode ToFightMode(SummerRaceActivityMode mode)
	{
		return mode switch
		{
			SummerRaceActivityMode.Tournament => FightMode.Championship, 
			SummerRaceActivityMode.SurvivalPractice => FightMode.SurvivalPractice, 
			SummerRaceActivityMode.OneVsTwoPractice => FightMode.OneVsTwoPractice, 
			SummerRaceActivityMode.Challenge => FightMode.Challenge, 
			_ => throw new InvalidOperationException("Stage mode cannot map to fight mode: " + mode), 
		};
	}

	private static SummerRaceActivityMode ToActivityMode(FightMode mode)
	{
		return mode switch
		{
			FightMode.Championship => SummerRaceActivityMode.Tournament, 
			FightMode.SurvivalPractice => SummerRaceActivityMode.SurvivalPractice, 
			FightMode.OneVsTwoPractice => SummerRaceActivityMode.OneVsTwoPractice, 
			FightMode.Challenge => SummerRaceActivityMode.Challenge, 
			_ => SummerRaceActivityMode.Unknown, 
		};
	}

	private static SummerRaceBodyTypeConfig ToBodyTypeConfig(SummerRaceBodyType bodyType)
	{
		return bodyType switch
		{
			SummerRaceBodyType.Light => SummerRaceBodyTypeConfig.Light, 
			SummerRaceBodyType.Medium => SummerRaceBodyTypeConfig.Medium, 
			SummerRaceBodyType.Heavy => SummerRaceBodyTypeConfig.Heavy, 
			_ => throw new InvalidOperationException("Unsupported runtime body type: " + bodyType), 
		};
	}

	private static SummerRaceWeaponTypeConfig[] ToWeaponTypeConfigs(WeaponKind[] weapons)
	{
		if (weapons == null || weapons.Length == 0)
		{
			return Array.Empty<SummerRaceWeaponTypeConfig>();
		}
		SummerRaceWeaponTypeConfig[] array = new SummerRaceWeaponTypeConfig[weapons.Length];
		for (int i = 0; i < weapons.Length; i++)
		{
			array[i] = ToWeaponTypeConfig(weapons[i]);
		}
		return array;
	}

	private static SummerRaceWeaponTypeConfig ToWeaponTypeConfig(WeaponKind weapon)
	{
		return weapon switch
		{
			WeaponKind.RocketLauncher => SummerRaceWeaponTypeConfig.RocketLauncher, 
			WeaponKind.MachineGun => SummerRaceWeaponTypeConfig.MachineGun, 
			WeaponKind.Boomerang => SummerRaceWeaponTypeConfig.Boomerang, 
			WeaponKind.ScatterShell => SummerRaceWeaponTypeConfig.ScatterShell, 
			WeaponKind.LaserCannon => SummerRaceWeaponTypeConfig.LaserCannon, 
			WeaponKind.Drill => SummerRaceWeaponTypeConfig.Drill, 
			WeaponKind.RotatingSaw => SummerRaceWeaponTypeConfig.RotatingSaw, 
			WeaponKind.Shovel => SummerRaceWeaponTypeConfig.Shovel, 
			_ => throw new InvalidOperationException("Unsupported runtime weapon kind: " + weapon), 
		};
	}

	private static SummerRaceEquipTypeConfig[] ToEquipTypeConfigs(EquipKind[] equips)
	{
		if (equips == null || equips.Length == 0)
		{
			return Array.Empty<SummerRaceEquipTypeConfig>();
		}
		SummerRaceEquipTypeConfig[] array = new SummerRaceEquipTypeConfig[equips.Length];
		for (int i = 0; i < equips.Length; i++)
		{
			array[i] = ToEquipTypeConfig(equips[i]);
		}
		return array;
	}

	private static SummerRaceEquipTypeConfig ToEquipTypeConfig(EquipKind equip)
	{
		return equip switch
		{
			EquipKind.Thruster => SummerRaceEquipTypeConfig.Thruster, 
			EquipKind.BoxingGlove => SummerRaceEquipTypeConfig.BoxingGlove, 
			EquipKind.ElectricNet => SummerRaceEquipTypeConfig.ElectricNet, 
			EquipKind.Hook => SummerRaceEquipTypeConfig.Hook, 
			EquipKind.ShieldGenerator => SummerRaceEquipTypeConfig.ShieldGenerator, 
			_ => throw new InvalidOperationException("Unsupported runtime equip kind: " + equip), 
		};
	}

	private SummerRaceBuildDatabaseSO ResolveActivityBuildDatabase()
	{
		if (string.IsNullOrWhiteSpace(activityBuildDatabaseName))
		{
			throw new InvalidOperationException("Activity build database name must be assigned explicitly on SummerRaceFightManager.");
		}
		return SummerRaceConfigLoader.LoadBuildDatabase(activityBuildDatabaseName);
	}

	private SummerRaceActivityMode ResolveActivityMode()
	{
		return fightMode switch
		{
			FightMode.Championship => SummerRaceActivityMode.Tournament, 
			FightMode.SurvivalPractice => SummerRaceActivityMode.SurvivalPractice, 
			FightMode.OneVsTwoPractice => SummerRaceActivityMode.OneVsTwoPractice, 
			FightMode.Challenge => SummerRaceActivityMode.Challenge, 
			_ => SummerRaceActivityMode.Unknown, 
		};
	}

	private bool TryPrimeCatalogWave(int requestedWaveIndex)
	{
		pendingCatalogWaveEnemies.Clear();
		currentCatalogSpawnInterval = -1f;
		if (activeActivityStage == null || activeActivityStage.Waves == null || activeActivityStage.Waves.Length == 0 || activityCatalog == null)
		{
			return false;
		}
		int num = activeActivityStage.Waves.Length;
		if (requestedWaveIndex < 0 || requestedWaveIndex >= num)
		{
			return false;
		}
		SummerRaceActivityWaveContract summerRaceActivityWaveContract = activeActivityStage.Waves[requestedWaveIndex];
		if (summerRaceActivityWaveContract == null)
		{
			return false;
		}
		currentWaveIndex = requestedWaveIndex;
		currentCatalogSpawnInterval = ((summerRaceActivityWaveContract.SpawnIntervalSeconds > 0f) ? summerRaceActivityWaveContract.SpawnIntervalSeconds : currentCatalogSpawnInterval);
		currentWaveTimeLimitSeconds = Mathf.Max(0f, summerRaceActivityWaveContract.TimeLimitSeconds);
		currentWaveRemainingSeconds = currentWaveTimeLimitSeconds;
		SummerRaceActivityEnemySpawnContract[] array = summerRaceActivityWaveContract.Enemies ?? Array.Empty<SummerRaceActivityEnemySpawnContract>();
		for (int i = 0; i < array.Length; i++)
		{
			SummerRaceActivityEnemySpawnContract summerRaceActivityEnemySpawnContract = array[i];
			if (summerRaceActivityEnemySpawnContract == null || string.IsNullOrEmpty(summerRaceActivityEnemySpawnContract.EnemyId))
			{
				throw new InvalidOperationException("Catalog wave contains an empty enemy entry at wave=" + (requestedWaveIndex + 1) + " index=" + i + ".");
			}
			if (!activityCatalog.TryGetEnemy(summerRaceActivityEnemySpawnContract.EnemyId, out var enemy))
			{
				throw new InvalidOperationException("Catalog wave references unknown enemy id '" + summerRaceActivityEnemySpawnContract.EnemyId + "' at wave=" + (requestedWaveIndex + 1) + " index=" + i + ".");
			}
			int num2 = Mathf.Max(1, summerRaceActivityEnemySpawnContract.Count);
			for (int j = 0; j < num2; j++)
			{
				pendingCatalogWaveEnemies.Enqueue(enemy);
			}
		}
		ApplyLaunchWaveEnemyOverride(requestedWaveIndex);
		if (fightMode == FightMode.Championship && pendingCatalogWaveEnemies.Count > 1)
		{
			SummerRaceActivityEnemyContract item = pendingCatalogWaveEnemies.Peek();
			pendingCatalogWaveEnemies.Clear();
			pendingCatalogWaveEnemies.Enqueue(item);
		}
		currentWaveTotal = pendingCatalogWaveEnemies.Count;
		if (currentWaveTotal <= 0)
		{
			throw new InvalidOperationException("Catalog wave " + (requestedWaveIndex + 1) + " resolved zero enemies after explicit validation.");
		}
		enemiesToSpawnThisWave = currentWaveTotal;
		ApplyChampionshipSingleEnemyRule();
		Log("Catalog wave ready: stage=" + activeActivityStage.Id + " wave=" + (currentWaveIndex + 1) + " count=" + currentWaveTotal);
		return true;
	}

	private void ApplyLaunchWaveEnemyOverride(int waveIndex)
	{
		if (launchEnemyIds != null && launchEnemyIds.Length != 0)
		{
			int num = ((launchEnemyIds.Length != 1) ? waveIndex : 0);
			if (num < 0 || num >= launchEnemyIds.Length)
			{
				throw new InvalidOperationException("Launch enemy override count is " + launchEnemyIds.Length + " but wave index is " + waveIndex + ".");
			}
			string text = launchEnemyIds[num];
			if (!activityCatalog.TryGetEnemy(text, out var enemy) || enemy == null)
			{
				throw new InvalidOperationException("Launch enemy override references unknown enemyId: " + text);
			}
			pendingCatalogWaveEnemies.Clear();
			pendingCatalogWaveEnemies.Enqueue(enemy);
			Log("Launch override: wave=" + (waveIndex + 1) + " enemyId=" + text);
		}
	}

	private void ApplyChampionshipSingleEnemyRule()
	{
		if (fightMode == FightMode.Championship)
		{
			if (pendingCatalogWaveEnemies.Count > 1)
			{
				SummerRaceActivityEnemyContract item = pendingCatalogWaveEnemies.Peek();
				pendingCatalogWaveEnemies.Clear();
				pendingCatalogWaveEnemies.Enqueue(item);
				Log("Championship clamp: queue trimmed to 1 enemy for current wave.");
			}
			if (currentWaveTotal > 1)
			{
				currentWaveTotal = 1;
				Log("Championship clamp: currentWaveTotal forced to 1.");
			}
			if (enemiesToSpawnThisWave > 1)
			{
				enemiesToSpawnThisWave = 1;
				Log("Championship clamp: enemiesToSpawnThisWave forced to 1.");
			}
		}
	}

	private void RebuildSurvivalCatalogPool()
	{
		survivalCatalogEntries.Clear();
		currentSurvivalSpawnLimit = Mathf.Max(0, survivalTotalEnemies);
		if (activityCatalog == null)
		{
			throw new InvalidOperationException("Survival mode requires an active activity catalog.");
		}
		SummerRaceActivityEnemySpawnContract[] array = ((activeActivityStage != null) ? (activeActivityStage.SurvivalRandomPool ?? Array.Empty<SummerRaceActivityEnemySpawnContract>()) : Array.Empty<SummerRaceActivityEnemySpawnContract>());
		if (array.Length == 0)
		{
			throw new InvalidOperationException("Survival mode requires an explicit SurvivalRandomPool configuration.");
		}
		for (int i = 0; i < array.Length; i++)
		{
			SummerRaceActivityEnemySpawnContract summerRaceActivityEnemySpawnContract = array[i];
			if (summerRaceActivityEnemySpawnContract == null || string.IsNullOrEmpty(summerRaceActivityEnemySpawnContract.EnemyId))
			{
				throw new InvalidOperationException("Survival random pool contains an empty enemy entry at index=" + i + ".");
			}
			if (!activityCatalog.TryGetEnemy(summerRaceActivityEnemySpawnContract.EnemyId, out var enemy) || enemy == null)
			{
				throw new InvalidOperationException("Survival random pool references unknown enemy id '" + summerRaceActivityEnemySpawnContract.EnemyId + "' at index=" + i + ".");
			}
			survivalCatalogEntries.Add(summerRaceActivityEnemySpawnContract);
		}
		if (survivalCatalogEntries.Count <= 0)
		{
			throw new InvalidOperationException("Survival random pool resolved zero enemies after explicit validation.");
		}
	}

	private SummerRaceActivityEnemyContract GetNextSurvivalCatalogEnemy()
	{
		if (survivalCatalogEntries.Count == 0)
		{
			return null;
		}
		return ResolveWeightedCatalogEnemy(survivalCatalogEntries, "survival random pool");
	}

	private int ResolveSurvivalMaxAlive()
	{
		return 2;
	}

	private float ResolveSurvivalDurationSeconds()
	{
		if (activeActivityStage != null)
		{
			if (activeActivityStage.SurvivalDurationSeconds > 0)
			{
				return activeActivityStage.SurvivalDurationSeconds;
			}
			if (activeActivityStage.TimeLimitSeconds > 0)
			{
				return activeActivityStage.TimeLimitSeconds;
			}
		}
		return survivalDuration;
	}

	private void ClearSurvivalEnemyHudSlots()
	{
		for (int i = 0; i < survivalEnemyHudSlotEnemies.Length; i++)
		{
			survivalEnemyHudSlotEnemies[i] = null;
			survivalEnemyHudSlotStates[i] = null;
		}
	}

	private void ClearPersistentEnemyHudSlotsForWaveEntry()
	{
		if (fightMode == FightMode.OneVsTwoPractice)
		{
			ClearSurvivalEnemyHudSlots();
		}
	}

	private void BindSurvivalEnemyHudSlot(SummerRaceEnemy enemy)
	{
		if (!UsesPersistentEnemyHudSlots() || enemy == null)
		{
			return;
		}
		int num = -1;
		for (int i = 0; i < survivalEnemyHudSlotEnemies.Length; i++)
		{
			if (survivalEnemyHudSlotEnemies[i] == null)
			{
				num = i;
				break;
			}
		}
		if (num >= 0)
		{
			survivalEnemyHudSlotEnemies[num] = enemy;
			survivalEnemyHudSlotStates[num] = BuildEnemyHudRuntimeState(enemy, alive: true);
		}
	}

	private void MarkSurvivalEnemyHudSlotDefeated(SummerRaceEnemy enemy)
	{
		if (!UsesPersistentEnemyHudSlots() || enemy == null)
		{
			return;
		}
		for (int i = 0; i < survivalEnemyHudSlotEnemies.Length; i++)
		{
			if (!(survivalEnemyHudSlotEnemies[i] != enemy))
			{
				SummerRaceEnemyHudRuntimeState summerRaceEnemyHudRuntimeState = BuildEnemyHudRuntimeState(enemy, alive: false);
				summerRaceEnemyHudRuntimeState.enemyHp = 0f;
				summerRaceEnemyHudRuntimeState.enemyHeadOut = fightMode == FightMode.SurvivalPractice || fightMode == FightMode.OneVsTwoPractice;
				survivalEnemyHudSlotStates[i] = summerRaceEnemyHudRuntimeState;
				survivalEnemyHudSlotEnemies[i] = null;
				break;
			}
		}
	}

	private void CaptureLastDefeatedEnemyHudSlot(SummerRaceEnemy enemy)
	{
		if (!(enemy == null) && !UsesPersistentEnemyHudSlots())
		{
			SummerRaceEnemyHudRuntimeState summerRaceEnemyHudRuntimeState = BuildEnemyHudRuntimeState(enemy, alive: false);
			if (!string.IsNullOrEmpty(summerRaceEnemyHudRuntimeState.enemyId) || !string.IsNullOrEmpty(summerRaceEnemyHudRuntimeState.enemyName))
			{
				summerRaceEnemyHudRuntimeState.enemyHp = 0f;
				lastDefeatedEnemyHudSlot = summerRaceEnemyHudRuntimeState;
			}
		}
	}

	private SummerRaceEnemyHudRuntimeState[] ResolveEnemyHudSlotsForSnapshot()
	{
		if (!UsesPersistentEnemyHudSlots())
		{
			if (aliveEnemies <= 0 && lastDefeatedEnemyHudSlot != null && (!string.IsNullOrEmpty(lastDefeatedEnemyHudSlot.enemyId) || !string.IsNullOrEmpty(lastDefeatedEnemyHudSlot.enemyName)))
			{
				return new SummerRaceEnemyHudRuntimeState[1] { lastDefeatedEnemyHudSlot };
			}
			return Array.Empty<SummerRaceEnemyHudRuntimeState>();
		}
		List<SummerRaceEnemyHudRuntimeState> list = new List<SummerRaceEnemyHudRuntimeState>(survivalEnemyHudSlotStates.Length);
		for (int i = 0; i < survivalEnemyHudSlotStates.Length; i++)
		{
			SummerRaceEnemy summerRaceEnemy = survivalEnemyHudSlotEnemies[i];
			if (summerRaceEnemy != null && (summerRaceEnemy.IsCombatAlive || summerRaceEnemy.IsNormalDefeatPending))
			{
				bool flag = survivalEnemyHudSlotStates[i] != null && survivalEnemyHudSlotStates[i].enemyHeadOut;
				SummerRaceEnemyHudRuntimeState summerRaceEnemyHudRuntimeState = BuildEnemyHudRuntimeState(summerRaceEnemy, alive: true);
				summerRaceEnemyHudRuntimeState.enemyHeadOut |= flag;
				survivalEnemyHudSlotStates[i] = summerRaceEnemyHudRuntimeState;
			}
			SummerRaceEnemyHudRuntimeState summerRaceEnemyHudRuntimeState2 = survivalEnemyHudSlotStates[i];
			if (summerRaceEnemyHudRuntimeState2 != null && (!string.IsNullOrEmpty(summerRaceEnemyHudRuntimeState2.enemyId) || !string.IsNullOrEmpty(summerRaceEnemyHudRuntimeState2.enemyName)))
			{
				list.Add(summerRaceEnemyHudRuntimeState2);
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<SummerRaceEnemyHudRuntimeState>();
		}
		return list.ToArray();
	}

	private bool UsesPersistentEnemyHudSlots()
	{
		if (fightMode != FightMode.SurvivalPractice)
		{
			return fightMode == FightMode.OneVsTwoPractice;
		}
		return true;
	}

	private bool SetPersistentEnemyHudSlotHeadOut(SummerRaceEnemy enemy, bool headOut)
	{
		if (!UsesPersistentEnemyHudSlots() || enemy == null)
		{
			return false;
		}
		for (int i = 0; i < survivalEnemyHudSlotEnemies.Length; i++)
		{
			if (!(survivalEnemyHudSlotEnemies[i] != enemy))
			{
				SummerRaceEnemyHudRuntimeState summerRaceEnemyHudRuntimeState = survivalEnemyHudSlotStates[i] ?? BuildEnemyHudRuntimeState(enemy, alive: true);
				summerRaceEnemyHudRuntimeState.enemyHeadOut = headOut;
				survivalEnemyHudSlotStates[i] = summerRaceEnemyHudRuntimeState;
				return true;
			}
		}
		return false;
	}

	private static SummerRaceEnemyHudRuntimeState BuildEnemyHudRuntimeState(SummerRaceEnemy enemy, bool alive)
	{
		if (enemy == null)
		{
			return new SummerRaceEnemyHudRuntimeState();
		}
		return new SummerRaceEnemyHudRuntimeState
		{
			enemyId = (enemy.CatalogEnemyId ?? string.Empty),
			enemyName = (enemy.DisplayName ?? string.Empty),
			enemyHp = (alive ? Mathf.Max(0f, enemy.CurrentHP) : 0f),
			enemyMaxHp = Mathf.Max(1f, enemy.MaxHP),
			enemyAlive = alive,
			enemyHeadOut = (alive && enemy.IsNormalDefeatPending)
		};
	}

	private SummerRaceActivityEnemyContract ResolveChallengeCatalogEnemy()
	{
		if (activityCatalog == null)
		{
			throw new InvalidOperationException("Challenge mode requires an active activity catalog.");
		}
		if (activeChallengePool == null || activeChallengePool.Entries == null || activeChallengePool.Entries.Length == 0)
		{
			throw new InvalidOperationException("Challenge mode requires an explicit challenge pool.");
		}
		int num = ResolveChallengeWaveNumber();
		challengeWavePoolEntries.Clear();
		SummerRaceActivityEnemySpawnContract[] entries = activeChallengePool.Entries;
		foreach (SummerRaceActivityEnemySpawnContract summerRaceActivityEnemySpawnContract in entries)
		{
			if (summerRaceActivityEnemySpawnContract != null)
			{
				int num2 = Mathf.Max(1, summerRaceActivityEnemySpawnContract.MinWave);
				int num3 = Mathf.Max(num2, summerRaceActivityEnemySpawnContract.MaxWave);
				if (num >= num2 && num <= num3)
				{
					challengeWavePoolEntries.Add(summerRaceActivityEnemySpawnContract);
				}
			}
		}
		if (challengeWavePoolEntries.Count == 0)
		{
			throw new InvalidOperationException("Challenge pool has no entries for wave " + num + ". Please verify min/max wave ranges.");
		}
		return ResolveWeightedCatalogEnemy(challengeWavePoolEntries, "challenge pool wave " + num);
	}

	private SummerRaceActivityEnemyContract ResolveWeightedCatalogEnemy(IList<SummerRaceActivityEnemySpawnContract> entries, string sourceLabel)
	{
		if (entries == null || entries.Count == 0)
		{
			return null;
		}
		int num = 0;
		for (int i = 0; i < entries.Count; i++)
		{
			SummerRaceActivityEnemySpawnContract summerRaceActivityEnemySpawnContract = entries[i];
			if (summerRaceActivityEnemySpawnContract == null || string.IsNullOrEmpty(summerRaceActivityEnemySpawnContract.EnemyId))
			{
				throw new InvalidOperationException(sourceLabel + " contains an empty enemy entry.");
			}
			num += Mathf.Max(1, summerRaceActivityEnemySpawnContract.Weight);
		}
		if (num <= 0)
		{
			throw new InvalidOperationException(sourceLabel + " resolved zero total weight.");
		}
		int num2 = UnityEngine.Random.Range(0, num);
		for (int j = 0; j < entries.Count; j++)
		{
			SummerRaceActivityEnemySpawnContract summerRaceActivityEnemySpawnContract2 = entries[j];
			num2 -= Mathf.Max(1, summerRaceActivityEnemySpawnContract2.Weight);
			if (num2 < 0)
			{
				if (!activityCatalog.TryGetEnemy(summerRaceActivityEnemySpawnContract2.EnemyId, out var enemy) || enemy == null)
				{
					throw new InvalidOperationException(sourceLabel + " references unknown enemy id '" + summerRaceActivityEnemySpawnContract2.EnemyId + "'.");
				}
				return enemy;
			}
		}
		throw new InvalidOperationException(sourceLabel + " weighted selection failed unexpectedly.");
	}

	private void TrackEnemySpawn(SummerRaceEnemy enemy, GameObject enemyObj, int wave, string catalogId)
	{
		TrackEnemySpawn(enemy, enemyObj, wave, catalogId, float.NaN);
	}

	private void TrackEnemySpawn(SummerRaceEnemy enemy, GameObject enemyObj, int wave, string catalogId, float stableSpawnY)
	{
		if (enemy != null)
		{
			float spawnX = ((enemyObj != null) ? enemyObj.transform.position.x : enemy.transform.position.x);
			float spawnY = ((!float.IsNaN(stableSpawnY)) ? stableSpawnY : ((enemyObj != null) ? enemyObj.transform.position.y : enemy.transform.position.y));
			string defeatEffect = string.Empty;
			if (!string.IsNullOrWhiteSpace(catalogId) && activityCatalog != null && activityCatalog.TryGetEnemy(catalogId.Trim(), out var enemy2) && enemy2 != null)
			{
				defeatEffect = (string.IsNullOrWhiteSpace(enemy2.DefeatEffect) ? string.Empty : enemy2.DefeatEffect.Trim());
			}
			enemy.SetRuntimeSpawnMeta(catalogId, wave);
			enemySpawnMetaMap[enemy] = new EnemySpawnMeta
			{
				WaveIndex = Mathf.Max(1, wave),
				EnemyId = (string.IsNullOrWhiteSpace(catalogId) ? string.Empty : catalogId.Trim()),
				DefeatEffect = defeatEffect,
				SpawnX = spawnX,
				SpawnY = spawnY
			};
		}
		if ((object)enemy != null)
		{
			SummerRaceBuildBlueprint blueprint = ((ISummerRaceBuildProfileProvider)enemy).ExportRuntimeBlueprint();
			TrackSpawnedEnemyBlueprint(blueprint);
			SummerRaceBuildRating buildRating = ((ISummerRaceBuildProfileProvider)enemy).GetBuildRating();
			string archetypeLabel = SummerRaceBuildScoring.GetArchetypeLabel(blueprint.Archetype);
			string text = (string.IsNullOrEmpty(catalogId) ? string.Empty : (" catalog=" + catalogId));
			Log("Spawn enemy: " + enemyObj.name + " wave=" + wave + text + " at=" + enemyObj.transform.position.ToString("F2") + " alive=" + aliveEnemies + " build=" + buildRating.ToShortLabel() + " archetype=" + archetypeLabel + " sig=" + blueprint.Signature);
		}
		else
		{
			Log("Spawn enemy: " + enemyObj.name + " wave=" + wave + " at=" + enemyObj.transform.position.ToString("F2") + " alive=" + aliveEnemies);
		}
	}

	private Transform[] ResolveSpawnPoints()
	{
		List<Transform> list = new List<Transform>();
		for (int i = 0; i < spawnNames.Length; i++)
		{
			GameObject gameObject = GameObject.Find(spawnNames[i]);
			if (gameObject != null)
			{
				list.Add(gameObject.transform);
			}
		}
		return list.ToArray();
	}

	private void EnsureArenaBoundaries()
	{
		EnsureBoundary("BoundaryTop", new Vector2(0f, 5.45f), new Vector2(20f, 1f));
		EnsureBoundary("BoundaryBottom", new Vector2(0f, -5.45f), new Vector2(20f, 1f));
		EnsureBoundary("BoundaryLeft", new Vector2(-9.25f, 0f), new Vector2(1f, 12f));
		EnsureBoundary("BoundaryRight", new Vector2(9.25f, 0f), new Vector2(1f, 12f));
	}

	private void EnsureArenaFloor()
	{
		GameObject gameObject = GameObject.Find("ArenaFloor");
		bool flag = false;
		if (gameObject == null)
		{
			gameObject = new GameObject("ArenaFloor");
			flag = true;
		}
		if ((Application.isPlaying || forceArenaFloorPositionFromCode) | flag)
		{
			float y = sideLaneY + arenaFloorYOffsetFromLane;
			gameObject.transform.position = new Vector3(0f, y, 0f);
		}
		gameObject.transform.localScale = new Vector3(20f, 2.8f, 1f);
		Collider component = gameObject.GetComponent<Collider>();
		if (component != null)
		{
			UnityEngine.Object.Destroy(component);
		}
		Rigidbody component2 = gameObject.GetComponent<Rigidbody>();
		if (component2 != null)
		{
			UnityEngine.Object.Destroy(component2);
		}
		MeshFilter component3 = gameObject.GetComponent<MeshFilter>();
		if (component3 != null)
		{
			UnityEngine.Object.Destroy(component3);
		}
		MeshRenderer component4 = gameObject.GetComponent<MeshRenderer>();
		if (component4 != null)
		{
			UnityEngine.Object.Destroy(component4);
		}
		SpriteRenderer spriteRenderer = gameObject.GetComponent<SpriteRenderer>();
		Transform transform = gameObject.transform.Find("FloorVisual");
		if (spriteRenderer == null)
		{
			if (transform == null)
			{
				GameObject obj = new GameObject("FloorVisual");
				obj.transform.SetParent(gameObject.transform, worldPositionStays: false);
				transform = obj.transform;
			}
			spriteRenderer = transform.GetComponent<SpriteRenderer>();
			if (spriteRenderer == null)
			{
				spriteRenderer = transform.gameObject.AddComponent<SpriteRenderer>();
			}
			transform.localPosition = Vector3.zero;
			transform.localRotation = Quaternion.identity;
			transform.localScale = Vector3.one;
		}
		if (spriteRenderer != null)
		{
			spriteRenderer.sprite = SummerRaceSpriteUtil.GetSquareSprite();
			spriteRenderer.color = new Color(0.31f, 0.33f, 0.37f, 1f);
			spriteRenderer.sortingOrder = -6;
			SummerRaceSpriteMaterialUtility.ApplyDefault2D(spriteRenderer);
		}
		BoxCollider2D boxCollider2D = gameObject.GetComponent<BoxCollider2D>();
		if (boxCollider2D == null)
		{
			boxCollider2D = gameObject.AddComponent<BoxCollider2D>();
		}
		boxCollider2D.size = Vector2.one;
		boxCollider2D.sharedMaterial = GetArenaFloorMaterial();
		ApplyArenaColliderOutline(gameObject, new Color(0.3f, 0.95f, 0.95f, 0.9f), 0.016f, 170);
		Transform transform2 = gameObject.transform.Find("TopStripe");
		if (transform2 == null)
		{
			GameObject obj2 = new GameObject("TopStripe");
			obj2.transform.SetParent(gameObject.transform, worldPositionStays: false);
			transform2 = obj2.transform;
		}
		transform2.localPosition = new Vector3(0f, 0.5f, 0f);
		transform2.localScale = new Vector3(1f, 0.06f, 1f);
		transform2.localRotation = Quaternion.identity;
		SpriteRenderer spriteRenderer2 = transform2.GetComponent<SpriteRenderer>();
		if (spriteRenderer2 == null)
		{
			spriteRenderer2 = transform2.gameObject.AddComponent<SpriteRenderer>();
		}
		spriteRenderer2.sprite = SummerRaceSpriteUtil.GetSquareSprite();
		spriteRenderer2.color = new Color(0.72f, 0.74f, 0.78f, 1f);
		spriteRenderer2.sortingOrder = -5;
		SummerRaceSpriteMaterialUtility.ApplyDefault2D(spriteRenderer2);
	}

	private void ApplySceneSpriteRendererMaterials()
	{
		if (forceDefault2DMaterialForSceneSpriteRenderers)
		{
			SpriteRenderer[] array = UnityEngine.Object.FindObjectsOfType<SpriteRenderer>();
			for (int i = 0; i < array.Length; i++)
			{
				SummerRaceSpriteMaterialUtility.ApplyDefault2D(array[i]);
			}
		}
	}

	private void ApplyConfiguredFightMap()
	{
		string text = ResolveConfiguredFightMapName();
		GameObject gameObject = GameObject.Find("Bg");
		if (gameObject == null)
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] configured fight map skipped: Bg root not found.");
			return;
		}
		ApplyFightMapControllerState(gameObject, text);
		if (IsControllerDrivenFightMap(text))
		{
			return;
		}
		SpriteRenderer spriteRenderer = ResolveFightMapSpriteRenderer(gameObject.transform);
		if (spriteRenderer == null)
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] configured fight map skipped: default map renderer not found.");
			return;
		}
		string text2 = "TextureBg/Activity_SummerRace/" + text;
		Sprite spriteWithoutAtlas = AtlasManager.GetSpriteWithoutAtlas(text2);
		if (spriteWithoutAtlas == null)
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] configured fight map sprite not found: " + text2);
		}
		else
		{
			spriteRenderer.sprite = spriteWithoutAtlas;
		}
	}

	private string ResolveConfiguredFightMapName()
	{
		string text = ((activeActivityStage != null) ? activeActivityStage.MapName : string.Empty);
		if (string.IsNullOrWhiteSpace(text))
		{
			return "Activity_SummerRace_FightBg_01";
		}
		return text.Trim();
	}

	private static void ApplyFightMapControllerState(GameObject bgRoot, string mapName)
	{
		string value = ResolveFightMapControllerState(mapName);
		if (string.IsNullOrEmpty(value))
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] configured fight map has no bg controller state mapping: " + mapName);
			return;
		}
		ControllerExCollection component = bgRoot.GetComponent<ControllerExCollection>();
		if (component == null)
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] configured fight map skipped: Bg controller collection not found.");
			return;
		}
		ControllerEx controller = component.GetController("bg");
		if (controller == null)
		{
			SummerRaceRuntimeLog.Warning("[SummerRace] configured fight map skipped: Bg controller 'bg' not found.");
		}
		else
		{
			controller.SetSelectedState(value);
		}
	}

	private static string ResolveFightMapControllerState(string mapName)
	{
		if (string.IsNullOrWhiteSpace(mapName) || string.Equals(mapName, "Activity_SummerRace_FightBg_01", StringComparison.Ordinal))
		{
			return "raceCity";
		}
		if (string.Equals(mapName, "Activity_SummerRace_FightBg_02", StringComparison.Ordinal))
		{
			return "demonCastle";
		}
		return string.Empty;
	}

	private static bool IsControllerDrivenFightMap(string mapName)
	{
		if (!string.Equals(mapName, "Activity_SummerRace_FightBg_01", StringComparison.Ordinal))
		{
			return string.Equals(mapName, "Activity_SummerRace_FightBg_02", StringComparison.Ordinal);
		}
		return true;
	}

	private static SpriteRenderer ResolveFightMapSpriteRenderer(Transform bgRoot)
	{
		if (bgRoot == null)
		{
			return null;
		}
		Transform transform = bgRoot.Find("Activity_SummerRace_FightBg_01");
		if (transform != null)
		{
			SpriteRenderer component = transform.GetComponent<SpriteRenderer>();
			if (component != null)
			{
				return component;
			}
		}
		SpriteRenderer[] componentsInChildren = bgRoot.GetComponentsInChildren<SpriteRenderer>(includeInactive: true);
		foreach (SpriteRenderer spriteRenderer in componentsInChildren)
		{
			if (!(spriteRenderer == null) && !(spriteRenderer.sprite == null) && string.Equals(spriteRenderer.sprite.name, "Activity_SummerRace_FightBg_01", StringComparison.Ordinal))
			{
				return spriteRenderer;
			}
		}
		return null;
	}

	private void AlignSideLaneObjects()
	{
		if (player != null)
		{
			player.SetLaneY(sideLaneY);
		}
		for (int i = 0; i < spawnPoints.Length; i++)
		{
			if (!(spawnPoints[i] == null))
			{
				Vector3 position = spawnPoints[i].position;
				position.y = sideLaneY;
				spawnPoints[i].position = position;
			}
		}
		for (int num = aliveEnemyRefs.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num);
			}
			else
			{
				summerRaceEnemy.SetLaneY(sideLaneY);
			}
		}
	}

	private void EnsureBoundary(string name, Vector2 pos, Vector2 size)
	{
		GameObject gameObject = GameObject.Find(name);
		bool flag = false;
		if (gameObject == null)
		{
			gameObject = new GameObject(name);
			flag = true;
		}
		BoxCollider2D boxCollider2D = gameObject.GetComponent<BoxCollider2D>();
		bool flag2 = false;
		if (boxCollider2D == null)
		{
			boxCollider2D = gameObject.AddComponent<BoxCollider2D>();
			flag2 = true;
		}
		if (flag | flag2)
		{
			gameObject.transform.position = pos;
			boxCollider2D.offset = Vector2.zero;
			boxCollider2D.size = size;
		}
		boxCollider2D.sharedMaterial = GetArenaBoundaryMaterial();
		ApplyArenaColliderOutline(gameObject, new Color(0.95f, 0.85f, 0.25f, 0.9f), 0.014f, 169);
	}

	private void ApplyArenaColliderOutline(GameObject target, Color color, float width, int sortingOrder)
	{
		if (target == null)
		{
			return;
		}
		if (drawArenaColliderOutlineInGame)
		{
			SummerRaceColliderOutline.Ensure(target, color, width, sortingOrder);
			return;
		}
		SummerRaceColliderOutline component = target.GetComponent<SummerRaceColliderOutline>();
		if (component != null)
		{
			UnityEngine.Object.Destroy(component);
		}
		LineRenderer component2 = target.GetComponent<LineRenderer>();
		if (component2 != null)
		{
			UnityEngine.Object.Destroy(component2);
		}
	}

	private static PhysicsMaterial2D GetArenaFloorMaterial()
	{
		if (arenaFloorMaterial == null)
		{
			arenaFloorMaterial = new PhysicsMaterial2D("SummerRace_ArenaFloor")
			{
				friction = 0.12f,
				bounciness = 0f
			};
		}
		return arenaFloorMaterial;
	}

	private static PhysicsMaterial2D GetArenaBoundaryMaterial()
	{
		if (arenaBoundaryMaterial == null)
		{
			arenaBoundaryMaterial = new PhysicsMaterial2D("SummerRace_ArenaBoundary")
			{
				friction = 0f,
				bounciness = 0f
			};
		}
		return arenaBoundaryMaterial;
	}

	private void CleanupOrphanBodyPrefabClones(string context)
	{
		Rigidbody2D[] array = UnityEngine.Object.FindObjectsOfType<Rigidbody2D>(includeInactive: true);
		int num = 0;
		foreach (Rigidbody2D rigidbody2D in array)
		{
			if (rigidbody2D == null)
			{
				continue;
			}
			GameObject gameObject = rigidbody2D.gameObject;
			if (gameObject.transform.parent != null)
			{
				continue;
			}
			string text = gameObject.name;
			if (text.StartsWith("SummerRaceBody_", StringComparison.Ordinal) && text.EndsWith("(Clone)", StringComparison.Ordinal) && !(gameObject.GetComponent<SummerRaceCharacterBase>() != null) && !(gameObject.GetComponent<SummerRaceEnemy>() != null) && !(gameObject.GetComponent<SummerRacePlayerController>() != null))
			{
				if (Application.isPlaying)
				{
					UnityEngine.Object.Destroy(gameObject);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(gameObject);
				}
				num++;
			}
		}
		if (num > 0)
		{
			Log("Cleanup orphan body prefab clone(s): context=" + context + " count=" + num);
		}
	}

	private void EnsureSideViewCamera(bool forceApply = false)
	{
		if (autoFrameCamera && (forceApply || !respectLuaMainCameraControl || !IsLuaUiContextReady()))
		{
			Camera main = Camera.main;
			if (!(main == null))
			{
				main.orthographic = true;
				main.orthographicSize = ResolveCameraMinOrthoSize();
				Vector3 position = main.transform.position;
				position.x = 0f;
				position.y = sideLaneY + cameraYOffsetFromLane;
				position.z = -10f;
				main.transform.position = position;
			}
		}
	}

	private void ResetBattleCameraState()
	{
		Camera main = Camera.main;
		SummerRaceCameraFramingConfig config = BuildCameraFramingConfig();
		SummerRaceCameraFrameTarget summerRaceCameraFrameTarget = SummerRaceCameraFramingSolver.ResolveTarget(state: new SummerRaceCameraFrameState(config.ArenaCenterX, config.ArenaCenterY, config.OverviewOrthoSize, 0f, 0f, 0f), config: config, playerX: config.ArenaCenterX, enemyMinX: config.ArenaCenterX, enemyMaxX: config.ArenaCenterX, hasEnemy: false, battleActive: false);
		cameraFrameState = new SummerRaceCameraFrameState(summerRaceCameraFrameTarget.CenterX, summerRaceCameraFrameTarget.CenterY, summerRaceCameraFrameTarget.OrthoSize, 0f, 0f, 0f);
		if (main != null)
		{
			main.orthographic = true;
			main.orthographicSize = summerRaceCameraFrameTarget.OrthoSize;
			Vector3 position = main.transform.position;
			position.x = summerRaceCameraFrameTarget.CenterX;
			position.y = summerRaceCameraFrameTarget.CenterY;
			position.z = -10f;
			main.transform.position = position;
		}
		cameraShakeState = SummerRaceCameraShakeState.None;
		cameraLastAppliedShakeOffset = Vector3.zero;
	}

	private void TickBattleCamera(float deltaTime)
	{
		if (!autoFrameCamera || !bootstrappedForPlay)
		{
			return;
		}
		Camera main = Camera.main;
		if (!(main == null))
		{
			if (cameraLastAppliedShakeOffset != Vector3.zero)
			{
				main.transform.position -= cameraLastAppliedShakeOffset;
				cameraLastAppliedShakeOffset = Vector3.zero;
			}
			if (!isPaused)
			{
				SummerRaceCameraFramingConfig config = BuildCameraFramingConfig();
				SummerRaceCameraFrameState state = new SummerRaceCameraFrameState(main.transform.position.x, main.transform.position.y, Mathf.Clamp(main.orthographicSize, config.MinBattleOrthoSize, config.OverviewOrthoSize), cameraFrameState.VelocityX, cameraFrameState.VelocityY, cameraFrameState.OrthoVelocity);
				bool hasEnemy = TryResolveActiveEnemyCameraBounds(out var minX, out var maxX, out var minY, out var maxY);
				ResolvePlayerCameraBounds(config, out var minX2, out var maxX2, out var minY2, out var maxY2);
				SummerRaceCameraFrameTarget target = SummerRaceCameraFramingSolver.ResolveTarget(config, state, minX2, maxX2, minY2, maxY2, minX, maxX, minY, maxY, hasEnemy, phase == FightPhase.Battle && !isPaused);
				cameraFrameState = SummerRaceCameraFramingSolver.IntegrateFrame(config, state, target, Mathf.Max(0f, deltaTime), cameraSmoothTime).State;
				main.orthographic = true;
				main.orthographicSize = cameraFrameState.OrthoSize;
				Vector3 position = main.transform.position;
				position.x = cameraFrameState.CenterX;
				position.y = cameraFrameState.CenterY;
				position.z = -10f;
				main.transform.position = position;
				SummerRaceCameraShakeSample summerRaceCameraShakeSample = SummerRaceCameraFramingSolver.IntegrateShake(cameraShakeState, Mathf.Max(0f, deltaTime));
				cameraShakeState = summerRaceCameraShakeSample.State;
				cameraLastAppliedShakeOffset = new Vector3(0f, summerRaceCameraShakeSample.VerticalOffset, 0f);
				main.transform.position += cameraLastAppliedShakeOffset;
			}
		}
	}

	private SummerRaceCameraFramingConfig BuildCameraFramingConfig()
	{
		SummerRaceCameraFramingConfig result = new SummerRaceCameraFramingConfig
		{
			ArenaCenterX = 0f,
			ArenaCenterY = ResolveCameraArenaCenterY(),
			MinBattleOrthoSize = ResolveCameraMinOrthoSize(),
			OverviewOrthoSize = ResolveCameraOverviewOrthoSize(),
			HorizontalSafeZoneRatio = cameraSafeZoneRatio,
			VehiclePadding = cameraVehiclePadding,
			VehicleCenterYOffset = cameraVehicleCenterYOffset,
			CameraAspect = ResolveCameraAspect(),
			PushStepPerSecond = cameraPushSpeed,
			PullStepPerSecond = cameraPullSpeed
		};
		if (cameraClampToBgBounds && TryResolveCameraBgBounds(out var bounds))
		{
			result.ClampCenterXToWorldBounds = true;
			result.ClampBottomEdgeToWorldBounds = true;
			result.ClampTopEdgeToWorldBounds = true;
			result.WorldMinX = bounds.min.x;
			result.WorldMaxX = bounds.max.x;
			result.WorldMinY = bounds.min.y;
			result.WorldMaxY = bounds.max.y;
			result.BottomSafePadding = cameraBottomSafePadding;
			result.TopSafePadding = cameraTopSafePadding;
		}
		return result;
	}

	private float ResolveCameraArenaCenterY()
	{
		return sideLaneY + cameraYOffsetFromLane;
	}

	private float ResolveCameraAspect()
	{
		Camera main = Camera.main;
		if (main != null && main.aspect > 0.01f)
		{
			return main.aspect;
		}
		return 1.7777778f;
	}

	private float ResolveCameraMinOrthoSize()
	{
		return Mathf.Clamp(ResolveAspectAdjustedCameraOrthoSize(cameraOrthoSize), 0.1f, 7.5f);
	}

	private float ResolveCameraOverviewOrthoSize()
	{
		float num = ResolveCameraMinOrthoSize();
		return Mathf.Clamp(Mathf.Max(ResolveAspectAdjustedCameraOrthoSize(Mathf.Max(cameraOverviewOrthoSize, cameraOrthoSize)), num), num, 8.5f);
	}

	private float ResolveAspectAdjustedCameraOrthoSize(float sourceOrthoSize)
	{
		float num = Mathf.Max(0.01f, sourceOrthoSize);
		float num2 = ResolveCameraAspect();
		if (num2 <= 0.01f)
		{
			return num;
		}
		return num * 1.7777778f / num2;
	}

	private bool TryResolveCameraBgBounds(out Bounds bounds)
	{
		bounds = default(Bounds);
		GameObject gameObject = GameObject.Find(cameraBgRootName);
		if (gameObject == null)
		{
			return false;
		}
		SpriteRenderer[] componentsInChildren = gameObject.GetComponentsInChildren<SpriteRenderer>(includeInactive: false);
		bool flag = false;
		foreach (SpriteRenderer spriteRenderer in componentsInChildren)
		{
			if (!(spriteRenderer == null) && spriteRenderer.enabled && !(spriteRenderer.sprite == null) && spriteRenderer.gameObject.activeInHierarchy)
			{
				if (!flag)
				{
					bounds = spriteRenderer.bounds;
					flag = true;
				}
				else
				{
					bounds.Encapsulate(spriteRenderer.bounds);
				}
			}
		}
		if (flag)
		{
			return bounds.size.x > 0.01f;
		}
		return false;
	}

	private void ResolvePlayerCameraBounds(SummerRaceCameraFramingConfig config, out float minX, out float maxX, out float minY, out float maxY)
	{
		if (player == null)
		{
			minX = config.ArenaCenterX;
			maxX = config.ArenaCenterX;
			minY = config.ArenaCenterY;
			maxY = config.ArenaCenterY;
		}
		else
		{
			ResolveCharacterCameraBounds(player.transform, out minX, out maxX, out minY, out maxY);
		}
	}

	private bool TryResolveActiveEnemyCameraBounds(out float minX, out float maxX, out float minY, out float maxY)
	{
		minX = 0f;
		maxX = 0f;
		minY = 0f;
		maxY = 0f;
		bool flag = false;
		for (int num = aliveEnemyRefs.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num);
			}
			else if (summerRaceEnemy.IsCombatAlive || summerRaceEnemy.IsNormalDefeatPending)
			{
				ResolveCharacterCameraBounds(summerRaceEnemy.transform, out var minX2, out var maxX2, out var minY2, out var maxY2);
				if (!flag)
				{
					minX = minX2;
					maxX = maxX2;
					minY = minY2;
					maxY = maxY2;
					flag = true;
				}
				else
				{
					minX = Mathf.Min(minX, minX2);
					maxX = Mathf.Max(maxX, maxX2);
					minY = Mathf.Min(minY, minY2);
					maxY = Mathf.Max(maxY, maxY2);
				}
			}
		}
		return flag;
	}

	private static void ResolveCharacterCameraBounds(Transform character, out float minX, out float maxX, out float minY, out float maxY)
	{
		if (character == null)
		{
			minX = 0f;
			maxX = 0f;
			minY = 0f;
			maxY = 0f;
			return;
		}
		Collider2D[] componentsInChildren = character.GetComponentsInChildren<Collider2D>(includeInactive: true);
		bool flag = false;
		Bounds bounds = default(Bounds);
		foreach (Collider2D collider2D in componentsInChildren)
		{
			if (!(collider2D == null) && collider2D.enabled && !collider2D.isTrigger)
			{
				if (!flag)
				{
					bounds = collider2D.bounds;
					flag = true;
				}
				else
				{
					bounds.Encapsulate(collider2D.bounds);
				}
			}
		}
		if (flag)
		{
			minX = bounds.min.x;
			maxX = bounds.max.x;
			minY = bounds.min.y;
			maxY = bounds.max.y;
		}
		else
		{
			Vector3 position = character.position;
			minX = position.x;
			maxX = position.x;
			minY = position.y;
			maxY = position.y;
		}
	}

	public void NotifyVehicleCollisionForCameraShake(float relativeSpeed)
	{
		if (!(relativeSpeed < cameraCollisionShakeMinSpeed))
		{
			StartBattleCameraShake(cameraCollisionShakeAmplitude, cameraCollisionShakeDuration);
		}
	}

	private void NotifyNormalDefeatExplosionForCameraShake()
	{
		StartBattleCameraShake(cameraDefeatShakeAmplitude, cameraDefeatShakeDuration);
	}

	private void StartBattleCameraShake(float amplitude, float duration)
	{
		if (autoFrameCamera && !(amplitude <= 0f) && !(duration <= 0f))
		{
			cameraShakeState = SummerRaceCameraFramingSolver.StartShake(cameraShakeState, amplitude, duration);
		}
	}

	internal static bool IsLuaUiContextReady()
	{
		return true;
	}

	private static void CollectSimulatedRigidbodies(Transform root, List<Rigidbody2D> output)
	{
		if (root == null || output == null)
		{
			return;
		}
		Rigidbody2D[] componentsInChildren = root.GetComponentsInChildren<Rigidbody2D>(includeInactive: true);
		foreach (Rigidbody2D rigidbody2D in componentsInChildren)
		{
			if (!(rigidbody2D == null) && rigidbody2D.simulated && !output.Contains(rigidbody2D))
			{
				output.Add(rigidbody2D);
			}
		}
	}

	private void ApplyCountdownPhysicsLock(bool locked)
	{
		if (countdownPhysicsLocked == locked)
		{
			return;
		}
		if (locked)
		{
			countdownFrozenRigidbodies.Clear();
			if (player != null)
			{
				CollectSimulatedRigidbodies(player.transform, countdownFrozenRigidbodies);
			}
			for (int i = 0; i < aliveEnemyRefs.Count; i++)
			{
				SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[i];
				if (!(summerRaceEnemy == null))
				{
					CollectSimulatedRigidbodies(summerRaceEnemy.transform, countdownFrozenRigidbodies);
				}
			}
			for (int j = 0; j < countdownFrozenRigidbodies.Count; j++)
			{
				Rigidbody2D rigidbody2D = countdownFrozenRigidbodies[j];
				if (!(rigidbody2D == null))
				{
					rigidbody2D.simulated = false;
				}
			}
		}
		else
		{
			for (int k = 0; k < countdownFrozenRigidbodies.Count; k++)
			{
				Rigidbody2D rigidbody2D2 = countdownFrozenRigidbodies[k];
				if (!(rigidbody2D2 == null))
				{
					rigidbody2D2.simulated = true;
				}
			}
			countdownFrozenRigidbodies.Clear();
		}
		countdownPhysicsLocked = locked;
	}

	private void ApplyPausePhysicsLock(bool locked)
	{
		if (pausePhysicsLocked == locked)
		{
			return;
		}
		ApplyCombatRuntimePauseLock(locked);
		if (locked)
		{
			pausedFrozenRigidbodies.Clear();
			if (player != null)
			{
				CollectSimulatedRigidbodies(player.transform, pausedFrozenRigidbodies);
			}
			for (int i = 0; i < aliveEnemyRefs.Count; i++)
			{
				SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[i];
				if (!(summerRaceEnemy == null))
				{
					CollectSimulatedRigidbodies(summerRaceEnemy.transform, pausedFrozenRigidbodies);
				}
			}
			VehicleSimpleProjectile[] array = UnityEngine.Object.FindObjectsOfType<VehicleSimpleProjectile>(includeInactive: true);
			foreach (VehicleSimpleProjectile vehicleSimpleProjectile in array)
			{
				if (!(vehicleSimpleProjectile == null) && !(vehicleSimpleProjectile.transform == null))
				{
					CollectSimulatedRigidbodies(vehicleSimpleProjectile.transform, pausedFrozenRigidbodies);
				}
			}
			for (int k = 0; k < pausedFrozenRigidbodies.Count; k++)
			{
				Rigidbody2D rigidbody2D = pausedFrozenRigidbodies[k];
				if (!(rigidbody2D == null))
				{
					rigidbody2D.simulated = false;
				}
			}
		}
		else
		{
			for (int l = 0; l < pausedFrozenRigidbodies.Count; l++)
			{
				Rigidbody2D rigidbody2D2 = pausedFrozenRigidbodies[l];
				if (!(rigidbody2D2 == null))
				{
					rigidbody2D2.simulated = true;
				}
			}
			pausedFrozenRigidbodies.Clear();
		}
		pausePhysicsLocked = locked;
	}

	private void ApplyCombatRuntimePauseLock(bool locked)
	{
		if (player != null)
		{
			player.SetCombatRuntimePaused(locked);
		}
		for (int num = aliveEnemyRefs.Count - 1; num >= 0; num--)
		{
			SummerRaceEnemy summerRaceEnemy = aliveEnemyRefs[num];
			if (summerRaceEnemy == null)
			{
				aliveEnemyRefs.RemoveAt(num);
			}
			else
			{
				summerRaceEnemy.SetCombatRuntimePaused(locked);
			}
		}
	}

	private void SetBattleResultRuntimeLocked(bool locked)
	{
		if (battleResultRuntimeLocked != locked)
		{
			battleResultRuntimeLocked = locked;
			ApplyCombatRuntimePauseLock(locked);
			if (locked)
			{
				SummerRaceCombatPresentationAudioSink.StopAllActivePlaybacks();
			}
		}
	}

	private void EndFight(bool isWin, string message, string reason = "")
	{
		CancelTimeoutResultSequence();
		CleanupPendingNormalDefeatState();
		CleanupSpecialDefeatState();
		ApplyCountdownPhysicsLock(locked: false);
		ApplyPausePhysicsLock(locked: false);
		CancelBattleResultBannerSequence();
		SummerRaceCombatPresentationAudioSink.StopAllActivePlaybacks();
		phase = FightPhase.Result;
		resultWin = isWin;
		resultText = message;
		resultReason = reason ?? string.Empty;
		timeoutWinDefeatPending = false;
		isPaused = false;
		if (fightMode == FightMode.Challenge)
		{
			if (!isWin)
			{
				int num = ResolveChallengeWaveNumber();
				RecordRoundSettlement(num, "lose", ResolveCurrentWaveElapsed());
				RecordChallengeRoundSettlement(num, "lose", ResolveCurrentWaveElapsed(), ResolveChallengeWaveEarnedScore(num));
			}
			challengeScore = ResolveChallengeScore();
			challengeLastScore = challengeScore;
			challengeLastWave = ResolveChallengeWaveNumber();
			SummerRaceChallengeProgressSnapshot summerRaceChallengeProgressSnapshot = SummerRaceChallengeProgressStore.SaveRun(challengeLastScore, challengeLastWave);
			challengeBestScore = summerRaceChallengeProgressSnapshot.BestScore;
			challengeBestWave = summerRaceChallengeProgressSnapshot.BestWave;
			SummerRaceChallengeAnalytics.ReportGameOver(isWin, message, challengeLastScore, challengeLastWave, challengeBestScore, challengeBestWave);
			resultText = message + " | Score " + challengeLastScore + " | Wave " + challengeLastWave + " | Best " + challengeBestScore + " @ " + challengeBestWave;
		}
		else if (!isWin)
		{
			RecordRoundSettlement(ResolveSettlementWaveNumber(), "lose", ResolveCurrentWaveElapsed());
		}
		Log("Fight end: mode=" + fightMode.ToString() + " win=" + isWin + " msg=" + message + " wave=" + (currentWaveIndex + 1) + " destroyed=" + destroyedEnemies + " spawned=" + spawnedEnemies);
		RecordAliveEnemySettlementRecords(isWin);
		suppressRuntimeSnapshotForLoseSettlement = !isWin;
		for (int i = 0; i < aliveEnemyRefs.Count; i++)
		{
			if (aliveEnemyRefs[i] != null)
			{
				UnityEngine.Object.Destroy(aliveEnemyRefs[i].gameObject);
			}
		}
		aliveEnemyRefs.Clear();
		enemySpawnMetaMap.Clear();
		CleanupOrphanBodyPrefabClones("EndFight");
		if (player != null)
		{
			player.SetMovementLocked(locked: true);
		}
		PublishRuntimeSnapshot(force: true);
		PublishBattleSettlement();
	}

	private void PublishResolvedStage()
	{
		EnsureBattleRuntimeBridge();
		battleRuntimeBridge.PublishStageResolved(ResolveRuntimeModeKey(), activeActivityStage, ResolveReportedStageId());
	}

	private void PublishRuntimeSnapshot(bool force)
	{
		if (bootstrappedForPlay && Application.isPlaying && !suppressRuntimeSnapshotForLoseSettlement && (force || !(Time.unscaledTime < nextRuntimeSnapshotPushAt)))
		{
			EnsureBattleRuntimeBridge();
			nextRuntimeSnapshotPushAt = Time.unscaledTime + 0.1f;
			battleRuntime.UpdateSnapshot(SummerRaceBattleRuntimeFrameBuilder.Build(new SummerRaceBattleRuntimeFrameSource(player, aliveEnemyRefs, ResolveRuntimeModeKey(), ResolveHudWave(), ResolveHudWaveTotal(), ResolveHudTimerSeconds(), ResolveCurrentCountdownRemaining(), ResolveCurrentWaveElapsed(), (fightMode == FightMode.Challenge) ? challengeScore : 0, currentWaveTotal, ResolveHudPhaseState(), IsBattleActive, isPaused, ResolveReportedStageId(), runtimeEnemyIntroText, runtimeEnemyOverclockBubbleText, runtimeEnemyOverclockBubbleToken, enemyHeadOut, ResolveEnemyHudSlotsForSnapshot())));
			battleRuntimeBridge.PublishSnapshot(force);
		}
	}

	private void PublishPlayerLabelPose()
	{
		if (bootstrappedForPlay && Application.isPlaying && !(player == null) && ShouldPublishPlayerLabelPose())
		{
			Vector3 vector = player.ResolvePlayerBattleAdminLabelWorldPosition();
			SummerRaceLuaBridge.PushPlayerLabelPose(new SummerRacePlayerLabelPose
			{
				playerLabelWorldX = vector.x,
				playerLabelWorldY = vector.y,
				playerLabelWorldZ = vector.z,
				playerLabelScreenOffsetY = player.ResolvePlayerBattleAdminLabelScreenOffsetY()
			});
		}
	}

	private bool ShouldPublishPlayerLabelPose()
	{
		if (phase == FightPhase.Countdown)
		{
			return true;
		}
		if (phase == FightPhase.Battle)
		{
			return ResolveCurrentWaveElapsed() <= 5f;
		}
		return false;
	}

	public void NotifyEnemyOverclockActivated(SummerRaceEnemy enemy)
	{
		if (!(enemy == null) && phase != FightPhase.Result)
		{
			string overclockBubbleText = enemy.OverclockBubbleText;
			if (!string.IsNullOrWhiteSpace(overclockBubbleText))
			{
				runtimeEnemyOverclockBubbleText = overclockBubbleText.Trim();
				runtimeEnemyOverclockBubbleToken++;
				PublishRuntimeSnapshot(force: true);
			}
		}
	}

	private void SetEnemyHeadOut(bool value, bool publishImmediately = true)
	{
		if (enemyHeadOut != value)
		{
			enemyHeadOut = value;
			if (publishImmediately)
			{
				PublishRuntimeSnapshot(force: true);
			}
		}
	}

	private void ApplyStageRuntimeTunings()
	{
		if (!(player == null) && activeActivityStage != null)
		{
			float damageToEnergyRatio = activeActivityStage.DamageToEnergyRatio;
			if (float.IsNaN(damageToEnergyRatio) || float.IsInfinity(damageToEnergyRatio) || damageToEnergyRatio < 0f)
			{
				throw new InvalidOperationException("[SummerRace] Invalid stage DamageToEnergyRatio: " + damageToEnergyRatio + " (expected >= 0).");
			}
			player.SetDamageToEnergyRatio(damageToEnergyRatio);
			float energyRegenPerSecond = activeActivityStage.EnergyRegenPerSecond;
			if (float.IsNaN(energyRegenPerSecond) || float.IsInfinity(energyRegenPerSecond) || energyRegenPerSecond < 0f)
			{
				throw new InvalidOperationException("[SummerRace] Invalid stage EnergyRegenPerSecond: " + energyRegenPerSecond + " (expected >= 0).");
			}
			player.SetEnergyRegenPerSecond(energyRegenPerSecond);
			float maxEnergy = activeActivityStage.MaxEnergy;
			if (float.IsNaN(maxEnergy) || float.IsInfinity(maxEnergy) || maxEnergy <= 0f)
			{
				throw new InvalidOperationException("[SummerRace] Invalid stage MaxEnergy: " + maxEnergy + " (expected > 0).");
			}
			player.SetMaxEnergy(maxEnergy);
			ApplyEnemyEnergyRuntimeTuningsToAliveEnemies(energyRegenPerSecond, maxEnergy);
		}
	}

	private void ApplyEnemyEnergyRuntimeTunings(SummerRaceEnemy enemy)
	{
		if (!(enemy == null) && activeActivityStage != null)
		{
			float energyRegenPerSecond = activeActivityStage.EnergyRegenPerSecond;
			if (float.IsNaN(energyRegenPerSecond) || float.IsInfinity(energyRegenPerSecond) || energyRegenPerSecond < 0f)
			{
				throw new InvalidOperationException("[SummerRace] Invalid stage EnergyRegenPerSecond: " + energyRegenPerSecond + " (expected >= 0).");
			}
			float maxEnergy = activeActivityStage.MaxEnergy;
			if (float.IsNaN(maxEnergy) || float.IsInfinity(maxEnergy) || maxEnergy <= 0f)
			{
				throw new InvalidOperationException("[SummerRace] Invalid stage MaxEnergy: " + maxEnergy + " (expected > 0).");
			}
			enemy.SetEnergyRegenPerSecond(energyRegenPerSecond);
			enemy.SetMaxEnergy(maxEnergy);
		}
	}

	private static void ApplyEnemyEnergyRuntimeTuningsToAliveEnemies(float regenPerSecond, float maxEnergy)
	{
		for (int i = 0; i < SummerRaceEnemyRegistry.Count; i++)
		{
			SummerRaceEnemy summerRaceEnemy = SummerRaceEnemyRegistry.Get(i);
			if (!(summerRaceEnemy == null))
			{
				summerRaceEnemy.SetEnergyRegenPerSecond(regenPerSecond);
				summerRaceEnemy.SetMaxEnergy(maxEnergy);
			}
		}
	}

	private void PublishBattleSettlement()
	{
		EnsureBattleRuntimeBridge();
		battleRuntime.SetSettlement(new SummerRaceBattleSettlement
		{
			isWin = resultWin,
			mode = ResolveRuntimeModeKey(),
			stageId = ResolveReportedStageId(),
			score = ((fightMode == FightMode.Challenge) ? challengeLastScore : 0),
			destroyedEnemies = destroyedEnemies,
			battleElapsed = battleElapsed,
			resultText = resultText,
			resultReason = resultReason,
			roundRecords = BuildRoundSettlementArray(),
			survivalEnemyRecords = ((fightMode == FightMode.SurvivalPractice) ? BuildSurvivalEnemySettlementArray() : Array.Empty<SummerRaceSurvivalEnemySettlement>()),
			challengeReachedWave = ((fightMode == FightMode.Challenge) ? challengeLastWave : 0),
			challengeRoundRecords = ((fightMode == FightMode.Challenge) ? BuildChallengeRoundSettlementArray() : Array.Empty<SummerRaceChallengeRoundSettlement>())
		});
		battleRuntimeBridge.PublishSettlement();
	}

	private string ResolveRuntimeModeKey()
	{
		return fightMode switch
		{
			FightMode.Championship => "championship", 
			FightMode.SurvivalPractice => "survival_practice", 
			FightMode.OneVsTwoPractice => "one_vs_two_practice", 
			FightMode.Challenge => "challenge", 
			_ => throw new InvalidOperationException("Unsupported fight mode: " + fightMode), 
		};
	}

	private SummerRaceBuildArchetype? ResolvePreferredEnemyArchetype()
	{
		if (!balanceEnemyArchetype)
		{
			return null;
		}
		SummerRaceBuildArchetype value = SummerRaceBuildArchetype.Balanced;
		int num = int.MaxValue;
		bool flag = false;
		for (int i = 1; i <= 5; i++)
		{
			SummerRaceBuildArchetype summerRaceBuildArchetype = (SummerRaceBuildArchetype)i;
			int num2 = (enemyArchetypeSpawnCounts.TryGetValue(summerRaceBuildArchetype, out var value2) ? value2 : 0);
			if (!flag || num2 < num)
			{
				value = summerRaceBuildArchetype;
				num = num2;
				flag = true;
			}
		}
		if (!flag)
		{
			return null;
		}
		return value;
	}

	private void TrackSpawnedEnemyBlueprint(SummerRaceBuildBlueprint blueprint)
	{
		spawnedEnemyBlueprints.Add(blueprint);
		if (blueprint.Archetype != SummerRaceBuildArchetype.Unknown)
		{
			int num = (enemyArchetypeSpawnCounts.TryGetValue(blueprint.Archetype, out var value) ? value : 0);
			enemyArchetypeSpawnCounts[blueprint.Archetype] = num + 1;
		}
		if (!enableEnemyBuildDiversity)
		{
			return;
		}
		int num2 = Mathf.Max(2, enemyBuildMemorySize);
		string text = (string.IsNullOrEmpty(blueprint.Signature) ? SummerRaceBuildScoring.BuildSignature(blueprint) : blueprint.Signature);
		if (!string.IsNullOrEmpty(text))
		{
			if (!recentEnemyBuildSignatureSet.Contains(text))
			{
				recentEnemyBuildSignatureSet.Add(text);
				recentEnemyBuildSignatureQueue.Enqueue(text);
			}
			while (recentEnemyBuildSignatureQueue.Count > num2)
			{
				string item = recentEnemyBuildSignatureQueue.Dequeue();
				recentEnemyBuildSignatureSet.Remove(item);
			}
		}
	}

	static SummerRaceFightManager()
	{
		//IL_000d: Field data (rva=0x490) could not be found in any section!
		//IL_000d: Field data (rva=0x490) could not be found in any section!
		int[] array = new int[20];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		ChallengeWaveScoreTable = array;
	}
}
