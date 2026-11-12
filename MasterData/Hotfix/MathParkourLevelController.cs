using System;
using System.Collections;
using System.Collections.Generic;
using System.Security.Cryptography;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class MathParkourLevelController : MonoBehaviour
{
	private int actId;

	private int levelId;

	private TSRandom _random;

	private MathParkourLevel levelConfigData;

	private MathParkourConfig mathParkourConfigData;

	private Dictionary<int, List<MathParkourAreaConfig>> areaConfigDataDict;

	[Header("区块生成")]
	[SerializeField]
	private List<MathParkourChunk> chunkPrefabs = new List<MathParkourChunk>();

	[SerializeField]
	private Transform chunkParent;

	[SerializeField]
	private Transform characterTransform;

	[SerializeField]
	private MathParkourPlayerController playerController;

	[Header("角色位置锚点")]
	[SerializeField]
	private Transform playerInitialPosition;

	[SerializeField]
	private Transform bossPosition;

	[SerializeField]
	[Min(1f)]
	private int maxChunkCount = 5;

	[SerializeField]
	[Min(0f)]
	private float chunkMoveSpeed = 5f;

	[SerializeField]
	[Min(0f)]
	private float initialChunkForwardOffset;

	[SerializeField]
	[Min(0f)]
	private float unloadBehindCharacterDistance = 10f;

	private readonly List<MathParkourChunk> activeChunks = new List<MathParkourChunk>();

	private readonly List<MathParkourCombatEntity> activeCombatTargetBuffer = new List<MathParkourCombatEntity>();

	private readonly RaycastHit[] wallCastHits = new RaycastHit[16];

	private readonly Collider[] wallOverlapHits = new Collider[16];

	private readonly RaycastHit[] combatEntityCastHits = new RaycastHit[16];

	private int nextAreaIndex;

	private long nextEntityId;

	private bool isRunning;

	private bool shouldChunkMove;

	private bool isLevelEnded;

	private bool isGameplayPaused;

	private bool isPlayerBlockedByFrontWall;

	private MathParkourCombatEntity combatTarget;

	private int pendingTravelerDefeatAnimations;

	private MathParkourCombatEntity travelerRescueAnimationTarget;

	private readonly Dictionary<Transform, int> travelerOriginalLayers = new Dictionary<Transform, int>();

	private int playerHpAtCombatStart;

	private float qteSpeed;

	private float monsterDamageFactor = 1f;

	private const float ActorCRangeInLanes = 2f;

	private List<int> BuffList = new List<int>();

	private readonly Dictionary<int, Coroutine> buffCoroutines = new Dictionary<int, Coroutine>();

	private readonly Dictionary<int, MathParkourTimedFx> persistentBuffFx = new Dictionary<int, MathParkourTimedFx>();

	private readonly Dictionary<int, List<GameObject>> buffRuntimeEffectObjects = new Dictionary<int, List<GameObject>>();

	private readonly HashSet<int> pendingBoomBuffIds = new HashSet<int>();

	private readonly List<GameObject> runtimeEffectObjects = new List<GameObject>();

	[Header("Buff 表现")]
	[SerializeField]
	private Transform buffFxRoot;

	[SerializeField]
	private MathParkourTimedFx areaFxPrefab;

	[SerializeField]
	private MathParkourTimedFx boomFxPrefab;

	[SerializeField]
	private MathParkourProjectile actorAProjectilePrefab;

	[SerializeField]
	private MathParkourProjectile[] actorBProjectilePrefabs = new MathParkourProjectile[2];

	[SerializeField]
	private float projectileSpawnZOffset = 2f;

	[SerializeField]
	private MathParkourIceStrike actorCIceStrikePrefab;

	public int Seed { get; private set; }

	public bool IsGameplayAvailable
	{
		get
		{
			if (!isLevelEnded)
			{
				return !isGameplayPaused;
			}
			return false;
		}
	}

	public bool IsGameplayPaused => isGameplayPaused;

	public bool IsChunkMoving => isRunning;

	public Transform CharacterTransform => characterTransform;

	public MathParkourPlayerController PlayerController => playerController;

	public void Awake()
	{
		StartLevel();
	}

	public void EnterLevel()
	{
		playerController.SetPlayerScaleZero();
		playerController.gameObject.SetActive(value: true);
		MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_EnterLevel");
	}

	public void StartLevelGame()
	{
		playerController.PlayInAnimator();
	}

	private void OnDestroy()
	{
		travelerRescueAnimationTarget = null;
		StopTravelerHighlight();
		ClearBuffRuntime();
		StopChunkFlow();
	}

	public void GoNextLevel()
	{
		MonoSingleton<ClientManager>.Instance.OpenLoadingView(() =>
		{
			StartLevel();
			MonoSingleton<ClientManager>.Instance.CloseLoadingView(() =>
			{
				EnterLevel();
			});
		}, 0f, 0.1f);
	}

	public void StartLevel()
	{
		string[] mathParkourData = MiniGameHelper.GetMathParkourData();
		if (mathParkourData != null)
		{
			if (mathParkourData[2] == "0")
			{
				Init(StringParamHelper.ParseStringParamToInt(mathParkourData[0]), StringParamHelper.ParseStringParamToInt(mathParkourData[1]));
			}
			else
			{
				Init(StringParamHelper.ParseStringParamToInt(mathParkourData[0]), StringParamHelper.ParseStringParamToInt(mathParkourData[1]), StringParamHelper.ParseStringParamToInt(mathParkourData[2]));
			}
		}
		playerController.gameObject.SetActive(value: false);
	}

	public void Init(int actId, int levelId)
	{
		Init(actId, levelId, GenerateSeed());
	}

	public void Init(int actId, int levelId, int seed)
	{
		travelerRescueAnimationTarget = null;
		StopTravelerHighlight();
		ClearBuffRuntime();
		StopChunkFlow();
		this.actId = actId;
		this.levelId = levelId;
		Seed = seed;
		Debug.Log($"[MathParkour] 初始化随机种子：{Seed}。", this);
		_random = TSRandom.New(Seed);
		CacheConfigData();
		if (playerController != null)
		{
			playerController.SetLevelController(this);
		}
		playerController.Init(5, 1.7f, 0.01f);
		InitPlayerHp();
		StartChunkFlow();
		InitTempData();
		if (playerController != null)
		{
			playerController.SetToInitialPosition(playerInitialPosition);
		}
	}

	public void Restart()
	{
		MonoSingleton<ClientManager>.Instance.OpenLoadingView(() =>
		{
			playerController.gameObject.SetActive(value: false);
			Init(actId, levelId, Seed);
			MonoSingleton<ClientManager>.Instance.CloseLoadingView(() =>
			{
				EnterLevel();
			});
		}, 0f, 0.1f);
	}

	public int NextRandom(int minInclusive, int maxExclusive)
	{
		if (_random == null)
		{
			Debug.LogError("[MathParkour] 随机数生成器尚未初始化，请先调用 Init。");
			return minInclusive;
		}
		if (minInclusive >= maxExclusive)
		{
			Debug.LogError($"[MathParkour] 无效随机区间：[{minInclusive}, {maxExclusive})。");
			return minInclusive;
		}
		return _random.Next(minInclusive, maxExclusive);
	}

	public void SetQteSpeed(float qteSpeed)
	{
		this.qteSpeed = qteSpeed;
	}

	private int GenerateSeed()
	{
		byte[] array = new byte[4];
		using (RandomNumberGenerator randomNumberGenerator = RandomNumberGenerator.Create())
		{
			randomNumberGenerator.GetBytes(array);
		}
		return BitConverter.ToInt32(array, 0);
	}

	private void CacheConfigData()
	{
		levelConfigData = Singleton<HotfixDataController>.Instance.GetMathParkourLevel(levelId);
		mathParkourConfigData = Singleton<HotfixDataController>.Instance.GetMathParkourConfig(levelConfigData.ConfigId);
		areaConfigDataDict = new Dictionary<int, List<MathParkourAreaConfig>>();
		foreach (KeyValuePair<int, MathParkourAreaConfig> mathParkourAreaConfigDatum in Singleton<HotfixDataController>.Instance.MathParkourAreaConfigData)
		{
			if (mathParkourAreaConfigDatum.Value.ActId == actId)
			{
				if (areaConfigDataDict.TryGetValue(mathParkourAreaConfigDatum.Value.AreaId, out var value))
				{
					value.Add(mathParkourAreaConfigDatum.Value);
					continue;
				}
				value = new List<MathParkourAreaConfig> { mathParkourAreaConfigDatum.Value };
				areaConfigDataDict.set_Item(mathParkourAreaConfigDatum.Value.AreaId, value);
			}
		}
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, List<MathParkourAreaConfig>> item in areaConfigDataDict)
		{
			if (!levelConfigData.AreaList.Contains(item.Key))
			{
				list.Add(item.Key);
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			areaConfigDataDict.Remove(list.get_Item(i));
		}
	}

	private void InitTempData()
	{
		monsterDamageFactor = 1f;
		qteSpeed = 0f;
	}

	private void InitPlayerHp()
	{
		if (playerController == null)
		{
			Debug.LogError("[MathParkour] 未配置 Player Controller，无法初始化角色生命值。", this);
			return;
		}
		mathParkourConfigData = Singleton<HotfixDataController>.Instance.GetMathParkourConfig(levelConfigData.ConfigId);
		if (mathParkourConfigData == null)
		{
			Debug.LogError($"[MathParkour] 找不到关卡 {levelId} 引用的 MathParkourConfig：{levelConfigData.ConfigId}。", this);
		}
		else
		{
			playerController.InitHp(mathParkourConfigData.Hp);
		}
	}

	public void StartChunkFlow()
	{
		StopChunkFlow();
		if (!HasValidChunkPrefab())
		{
			Debug.LogError("[MathParkour] 未配置可用的 Chunk Prefab。", this);
			return;
		}
		if (characterTransform == null)
		{
			Debug.LogError("[MathParkour] 未配置 Character Transform。", this);
			return;
		}
		if (levelConfigData == null || levelConfigData.AreaList.Count == 0)
		{
			Debug.LogError("[MathParkour] 当前关卡不存在可生成的区域配置。", this);
			return;
		}
		nextAreaIndex = 0;
		nextEntityId = 2L;
		isRunning = false;
		shouldChunkMove = false;
		isLevelEnded = false;
		isGameplayPaused = false;
		isPlayerBlockedByFrontWall = false;
		combatTarget = null;
		playerHpAtCombatStart = 0;
		pendingTravelerDefeatAnimations = 0;
		travelerRescueAnimationTarget = null;
		playerController?.SetGameplayPaused(paused: true);
		FillChunks();
	}

	public void StartChunkMovement()
	{
		if (!isLevelEnded)
		{
			if (activeChunks.Count == 0)
			{
				Debug.LogError("[MathParkour] 当前没有已初始化的区块，无法开始移动。", this);
				return;
			}
			shouldChunkMove = true;
			RefreshChunkMovement();
		}
	}

	public IEnumerator WaitForGameplaySeconds(float duration)
	{
		float elapsed = 0f;
		while (elapsed < duration)
		{
			yield return null;
			if (!isGameplayPaused)
			{
				elapsed += Time.deltaTime;
			}
		}
	}

	public void PauseChunkMovement()
	{
		shouldChunkMove = false;
		RefreshChunkMovement();
	}

	private void RefreshChunkMovement()
	{
		isRunning = shouldChunkMove && !isLevelEnded && !isGameplayPaused && combatTarget == null && pendingTravelerDefeatAnimations == 0 && pendingBoomBuffIds.Count == 0 && !isPlayerBlockedByFrontWall;
	}

	public void SetPlayerBlockedByFrontWall(bool blocked)
	{
		if (!isLevelEnded && !isGameplayPaused && isPlayerBlockedByFrontWall != blocked)
		{
			isPlayerBlockedByFrontWall = blocked;
			RefreshChunkMovement();
		}
	}

	public void StartGame()
	{
		playerController?.SetGameplayPaused(paused: false);
		StartChunkMovement();
	}

	public void PauseGameplay()
	{
		if (!isLevelEnded && !isGameplayPaused)
		{
			isGameplayPaused = true;
			playerController?.SetGameplayPaused(paused: true);
			travelerRescueAnimationTarget?.SetKillAnimationPaused(paused: true);
			RefreshChunkMovement();
		}
	}

	public void ResumeGameplay()
	{
		if (isGameplayPaused)
		{
			isGameplayPaused = false;
			playerController?.SetGameplayPaused(paused: false);
			travelerRescueAnimationTarget?.SetKillAnimationPaused(paused: false);
			RefreshChunkMovement();
		}
	}

	public MathParkourPlayerController GetPlayerController()
	{
		return playerController;
	}

	public bool TryStartCollisionCombat(Collider other)
	{
		if (isLevelEnded || isGameplayPaused || other == null || playerController == null || mathParkourConfigData == null)
		{
			return false;
		}
		MathParkourCombatEntity componentInParent = other.GetComponentInParent<MathParkourCombatEntity>();
		if (componentInParent == null || componentInParent.IsDefeated)
		{
			return false;
		}
		bool flag = IsBossCombatTarget(componentInParent);
		if (!flag && componentInParent.LaneIndex != playerController.CurrentLaneIndex)
		{
			return false;
		}
		bool flag2 = combatTarget != null && combatTarget != componentInParent && CanSwitchCollisionCombatTarget(componentInParent);
		if (!flag && IsSideCollision(other) && !flag2)
		{
			return false;
		}
		if (combatTarget != null && combatTarget != componentInParent)
		{
			if (!CanSwitchCollisionCombatTarget(componentInParent))
			{
				return false;
			}
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_atk_stop");
			combatTarget = null;
		}
		if (combatTarget == componentInParent)
		{
			return true;
		}
		if (TryConsumeShield(componentInParent))
		{
			return true;
		}
		combatTarget = componentInParent;
		if (!flag)
		{
			playerController.ResetHpDecreaseRemainder();
			componentInParent.ResetHpDecreaseRemainder();
		}
		MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_atk");
		playerHpAtCombatStart = playerController.Hp;
		RefreshChunkMovement();
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(componentInParent.ConfigId);
		if (mathParkourObject != null && mathParkourObject.ObjType == 7)
		{
			ClearAllBuffs();
			playerController.MoveToBossPositionAndCancelDrag(bossPosition);
			MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BossEncountered");
		}
		return true;
	}

	public bool TryStartCollisionCombatAtMovementProbe(BoxCollider movementProbe)
	{
		if (movementProbe == null || isLevelEnded || isGameplayPaused)
		{
			return false;
		}
		Bounds bounds = movementProbe.bounds;
		int num = Physics.OverlapBoxNonAlloc(bounds.center, bounds.extents, wallOverlapHits, movementProbe.transform.rotation, -5, QueryTriggerInteraction.Collide);
		for (int i = 0; i < num; i++)
		{
			Collider collider = wallOverlapHits[i];
			if (!(collider == null) && !collider.transform.IsChildOf(movementProbe.transform.root) && TryStartCollisionCombat(collider))
			{
				return true;
			}
		}
		return false;
	}

	private bool CanSwitchCollisionCombatTarget(MathParkourCombatEntity target)
	{
		if (target != null && combatTarget != null && !IsBossCombatTarget(combatTarget) && target.OwnerChunk == combatTarget.OwnerChunk)
		{
			return target.RowIndex == combatTarget.RowIndex;
		}
		return false;
	}

	public void TryEndCollisionCombat(Collider other)
	{
		if (isLevelEnded || isGameplayPaused || combatTarget == null || other == null)
		{
			return;
		}
		MathParkourCombatEntity componentInParent = other.GetComponentInParent<MathParkourCombatEntity>();
		if (!(componentInParent == null) && !(componentInParent != combatTarget))
		{
			MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(componentInParent.ConfigId);
			if (mathParkourObject == null || mathParkourObject.ObjType != 7)
			{
				MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_atk_stop");
				combatTarget = null;
				RefreshChunkMovement();
			}
		}
	}

	public void TryCollectBuffItem(Collider other)
	{
		if (!isLevelEnded && !isGameplayPaused && !(other == null))
		{
			MathParkourEffectItemEntity componentInParent = other.GetComponentInParent<MathParkourEffectItemEntity>();
			if (!(componentInParent == null) && !componentInParent.IsCollected)
			{
				componentInParent.Collect();
				AddEffect(componentInParent);
			}
		}
	}

	private void AddEffect(MathParkourEffectItemEntity buffItemEntity)
	{
		if (buffItemEntity == null)
		{
			return;
		}
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(buffItemEntity.ConfigId);
		if (mathParkourObject != null)
		{
			if (mathParkourObject.ObjType == 6)
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BuffItemCollected", StringParamHelper.ParseStringParamToInt(mathParkourObject.Param1));
			}
			else
			{
				GiveEffect(buffItemEntity);
			}
		}
	}

	private void GiveEffect(MathParkourEffectItemEntity buffItemEntity)
	{
		if (buffItemEntity == null)
		{
			return;
		}
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(buffItemEntity.ConfigId);
		if (mathParkourObject != null)
		{
			HotfixEnum.MathParkourObjectType objType = (HotfixEnum.MathParkourObjectType)mathParkourObject.ObjType;
			if (objType == HotfixEnum.MathParkourObjectType.AccelerationConveyor || objType == HotfixEnum.MathParkourObjectType.DecelerationConveyor || objType == HotfixEnum.MathParkourObjectType.SpecialConveyor)
			{
				ApplyConveyorHpEffect(mathParkourObject);
			}
		}
	}

	private void ApplyConveyorHpEffect(MathParkourObject objectConfig)
	{
		if (objectConfig == null || playerController == null)
		{
			return;
		}
		int num = 0;
		if (objectConfig.Param2 != string.Empty)
		{
			num = StringParamHelper.ParseStringParamToInt(objectConfig.Param2);
		}
		switch (objectConfig.Param1)
		{
		case "1":
			playerController.SetHp(playerController.GetHp() + num);
			break;
		case "2":
			playerController.SetHp(playerController.GetHp() - num);
			break;
		case "3":
			playerController.SetHp(playerController.GetHp() * num);
			break;
		case "4":
			if (num == 0)
			{
				Debug.LogError($"[MathParkour] 对象 {objectConfig.Id} 的除法效果参数不能为 0。", this);
				return;
			}
			playerController.SetHp(playerController.GetHp() / num);
			break;
		case "5":
			playerController.SetHp(ReverseInteger(playerController.GetHp()));
			break;
		}
		TryEndLevelIfPlayerDead();
	}

	public void AddObjEffect(int nType, int value)
	{
		switch (nType)
		{
		case 1:
			playerController.SetHp(playerController.GetHp() + value);
			break;
		case 2:
			playerController.SetHp(playerController.GetHp() - value);
			break;
		case 3:
			playerController.SetHp(playerController.GetHp() * value);
			break;
		case 4:
			if (value == 0)
			{
				Debug.LogError("[MathParkour] GM 除法效果参数不能为 0。", this);
				return;
			}
			playerController.SetHp(playerController.GetHp() / value);
			break;
		case 5:
			playerController.SetHp(ReverseInteger(playerController.GetHp()));
			break;
		}
		TryEndLevelIfPlayerDead();
	}

	public float GetGeneratedWallSafeMoveDistance(BoxCollider movementProbe, Vector3 direction, float distance, LayerMask wallLayerMask, float padding, bool ignoreOverlappingFrontWall)
	{
		if (movementProbe == null || wallLayerMask.value == 0 || distance <= 0f)
		{
			return 0f;
		}
		Bounds bounds = movementProbe.bounds;
		int num = Physics.BoxCastNonAlloc(bounds.center, bounds.extents, direction, wallCastHits, movementProbe.transform.rotation, distance + padding, wallLayerMask, QueryTriggerInteraction.Ignore);
		float num2 = distance;
		for (int i = 0; i < num; i++)
		{
			Collider collider = wallCastHits[i].collider;
			if (collider == null)
			{
				continue;
			}
			MathParkourChunk componentInParent = collider.GetComponentInParent<MathParkourChunk>();
			if (componentInParent == null || !activeChunks.Contains(componentInParent))
			{
				continue;
			}
			if (TryGetWallSeparationDirection(collider, movementProbe, out var separationDirection))
			{
				bool flag = Vector3.Dot(separationDirection, movementProbe.transform.forward) < 0f - padding;
				bool flag2 = Vector3.Dot(direction, separationDirection) > padding;
				if (!((ignoreOverlappingFrontWall & flag) | flag2))
				{
					num2 = 0f;
				}
			}
			else
			{
				num2 = Mathf.Min(num2, Mathf.Max(0f, wallCastHits[i].distance - padding));
			}
		}
		return num2;
	}

	private static bool IsWallOverlappingInFront(Collider wallCollider, BoxCollider movementProbe, float padding)
	{
		if (!TryGetWallSeparationDirection(wallCollider, movementProbe, out var separationDirection))
		{
			return false;
		}
		return Vector3.Dot(separationDirection, movementProbe.transform.forward) < 0f - padding;
	}

	private static bool TryGetWallSeparationDirection(Collider wallCollider, BoxCollider movementProbe, out Vector3 separationDirection)
	{
		float distance;
		return Physics.ComputePenetration(movementProbe, movementProbe.transform.position, movementProbe.transform.rotation, wallCollider, wallCollider.transform.position, wallCollider.transform.rotation, out separationDirection, out distance);
	}

	public bool IsGeneratedCombatEntityBlocking(BoxCollider movementProbe, Vector3 direction, float distance, float padding)
	{
		if (movementProbe == null || distance <= 0f)
		{
			return false;
		}
		Bounds bounds = movementProbe.bounds;
		int num = Physics.BoxCastNonAlloc(bounds.center, bounds.extents, direction, combatEntityCastHits, movementProbe.transform.rotation, distance + padding, -5, QueryTriggerInteraction.Collide);
		for (int i = 0; i < num; i++)
		{
			Collider collider = combatEntityCastHits[i].collider;
			if (!(collider == null) && !collider.transform.IsChildOf(movementProbe.transform.root))
			{
				MathParkourCombatEntity componentInParent = collider.GetComponentInParent<MathParkourCombatEntity>();
				if (!IsParallelCombatTarget(componentInParent) && componentInParent != null && !componentInParent.IsDefeated && IsActiveChunk(componentInParent.OwnerChunk))
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool IsParallelCombatTarget(MathParkourCombatEntity target)
	{
		if (target == null || combatTarget == null || IsBossCombatTarget(combatTarget))
		{
			return false;
		}
		if (target.OwnerChunk == combatTarget.OwnerChunk)
		{
			return target.RowIndex == combatTarget.RowIndex;
		}
		return false;
	}

	private bool IsBossCombatTarget(MathParkourCombatEntity target)
	{
		if (target == null)
		{
			return false;
		}
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(target.ConfigId);
		if (mathParkourObject != null)
		{
			return mathParkourObject.ObjType == 7;
		}
		return false;
	}

	private bool IsSideCollision(Collider other)
	{
		if (other == null || characterTransform == null)
		{
			return false;
		}
		Vector3 vector = transform.InverseTransformPoint(characterTransform.position);
		Vector3 vector2 = transform.InverseTransformPoint(other.bounds.center) - vector;
		return Mathf.Abs(vector2.x) > Mathf.Abs(vector2.z);
	}

	private bool IsActiveChunk(MathParkourChunk chunk)
	{
		if (chunk != null)
		{
			return activeChunks.Contains(chunk);
		}
		return false;
	}

	public bool IsGeneratedFrontWallOverlapping(BoxCollider movementProbe, LayerMask wallLayerMask, float padding)
	{
		if (movementProbe == null || wallLayerMask.value == 0)
		{
			return false;
		}
		Bounds bounds = movementProbe.bounds;
		int num = Physics.OverlapBoxNonAlloc(bounds.center, bounds.extents + Vector3.one * padding, wallOverlapHits, movementProbe.transform.rotation, wallLayerMask, QueryTriggerInteraction.Ignore);
		for (int i = 0; i < num; i++)
		{
			Collider collider = wallOverlapHits[i];
			if (!(collider == null))
			{
				MathParkourChunk componentInParent = collider.GetComponentInParent<MathParkourChunk>();
				if (!(componentInParent == null) && activeChunks.Contains(componentInParent) && IsWallOverlappingInFront(collider, movementProbe, padding))
				{
					return true;
				}
			}
		}
		float maxDistance = chunkMoveSpeed * Time.deltaTime + padding;
		int num2 = Physics.BoxCastNonAlloc(bounds.center, bounds.extents, movementProbe.transform.forward, wallCastHits, movementProbe.transform.rotation, maxDistance, wallLayerMask, QueryTriggerInteraction.Ignore);
		for (int j = 0; j < num2; j++)
		{
			RaycastHit raycastHit = wallCastHits[j];
			Collider collider2 = raycastHit.collider;
			if (!(collider2 == null))
			{
				MathParkourChunk componentInParent2 = collider2.GetComponentInParent<MathParkourChunk>();
				if (!(componentInParent2 == null) && activeChunks.Contains(componentInParent2) && Vector3.Dot(collider2.ClosestPoint(bounds.center) - bounds.center, movementProbe.transform.forward) > padding)
				{
					return true;
				}
			}
		}
		return false;
	}

	public void StopChunkFlow()
	{
		isRunning = false;
		for (int num = activeChunks.Count - 1; num >= 0; num--)
		{
			RecycleChunk(activeChunks.get_Item(num));
		}
		activeChunks.Clear();
		nextAreaIndex = 0;
	}

	private void Update()
	{
		if (!isGameplayPaused && isRunning)
		{
			playerController?.UpdateFrontWallBlockState();
			if (isRunning)
			{
				MoveChunks();
				UnloadChunksBehindCharacter();
				FillChunks();
			}
		}
	}

	private void FixedUpdate()
	{
		if (!isGameplayPaused)
		{
			UpdateCollisionCombat();
		}
	}

	private void MoveChunks()
	{
		Vector3 vector = Vector3.back * (chunkMoveSpeed * Time.deltaTime);
		for (int i = 0; i < activeChunks.Count; i++)
		{
			MathParkourChunk mathParkourChunk = activeChunks.get_Item(i);
			if (mathParkourChunk != null)
			{
				mathParkourChunk.transform.localPosition += vector;
			}
		}
		Physics.SyncTransforms();
	}

	private void UnloadChunksBehindCharacter()
	{
		float characterLocalZ = GetCharacterLocalZ();
		for (int num = activeChunks.Count - 1; num >= 0; num--)
		{
			MathParkourChunk mathParkourChunk = activeChunks.get_Item(num);
			if (mathParkourChunk == null)
			{
				activeChunks.RemoveAt(num);
			}
			else if (mathParkourChunk.transform.localPosition.z + mathParkourChunk.ChunkLength < characterLocalZ - unloadBehindCharacterDistance)
			{
				activeChunks.RemoveAt(num);
				RecycleChunk(mathParkourChunk);
			}
		}
	}

	private void FillChunks()
	{
		while (activeChunks.Count < maxChunkCount && nextAreaIndex < levelConfigData.AreaList.Count)
		{
			int num = levelConfigData.AreaList.get_Item(nextAreaIndex++);
			if (!areaConfigDataDict.TryGetValue(num, out var value))
			{
				Debug.LogError($"[MathParkour] 找不到区域 {num} 的配置，已跳过。", this);
				continue;
			}
			MathParkourChunk randomChunkPrefab = GetRandomChunkPrefab();
			if (randomChunkPrefab == null)
			{
				Debug.LogError("[MathParkour] 未找到可用的 Chunk Prefab，已停止区块流。", this);
				isRunning = false;
				break;
			}
			Transform parent = ((chunkParent != null) ? chunkParent : transform);
			MathParkourChunk mathParkourChunk = UnityEngine.Object.Instantiate(randomChunkPrefab, parent, worldPositionStays: false);
			mathParkourChunk.name = $"MathParkourChunk_{num}_{nextAreaIndex - 1}";
			mathParkourChunk.transform.localPosition = new Vector3(0f, 0f, GetNextChunkStartLocalZ());
			mathParkourChunk.transform.localRotation = Quaternion.identity;
			mathParkourChunk.Init(value, _random, nextEntityId);
			nextEntityId = mathParkourChunk.NextEntityId;
			activeChunks.Add(mathParkourChunk);
		}
	}

	private float GetNextChunkStartLocalZ()
	{
		if (activeChunks.Count == 0)
		{
			return initialChunkForwardOffset;
		}
		MathParkourChunk mathParkourChunk = activeChunks.get_Item(activeChunks.Count - 1);
		if (!(mathParkourChunk != null))
		{
			return initialChunkForwardOffset;
		}
		return mathParkourChunk.transform.localPosition.z + mathParkourChunk.ChunkLength;
	}

	private bool HasValidChunkPrefab()
	{
		for (int i = 0; i < chunkPrefabs.Count; i++)
		{
			if (chunkPrefabs.get_Item(i) != null)
			{
				return true;
			}
		}
		return false;
	}

	private MathParkourChunk GetRandomChunkPrefab()
	{
		int num = 0;
		for (int i = 0; i < chunkPrefabs.Count; i++)
		{
			if (chunkPrefabs.get_Item(i) != null)
			{
				num++;
			}
		}
		if (num == 0)
		{
			return null;
		}
		int num2 = _random.Next(0, num);
		for (int j = 0; j < chunkPrefabs.Count; j++)
		{
			MathParkourChunk mathParkourChunk = chunkPrefabs.get_Item(j);
			if (!(mathParkourChunk == null) && num2-- == 0)
			{
				return mathParkourChunk;
			}
		}
		return null;
	}

	private float GetCharacterLocalZ()
	{
		return ((chunkParent != null) ? chunkParent : transform).InverseTransformPoint(characterTransform.position).z;
	}

	private void RecycleChunk(MathParkourChunk chunk)
	{
		if (!(chunk == null))
		{
			chunk.Recycle();
			UnityEngine.Object.Destroy(chunk.gameObject);
		}
	}

	private void UpdateCollisionCombat()
	{
		if (combatTarget == null)
		{
			return;
		}
		MathParkourCombatEntity mathParkourCombatEntity = combatTarget;
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(mathParkourCombatEntity.ConfigId);
		bool flag = mathParkourObject != null && mathParkourObject.ObjType == 7;
		if (playerController == null || playerController.Hp <= 0)
		{
			long entityId = mathParkourCombatEntity.EntityId;
			int configId = mathParkourCombatEntity.ConfigId;
			if ((combatTarget != null) & flag)
			{
				combatTarget.PlayKillAnim();
			}
			combatTarget = null;
			EndLevel(flag, entityId, configId);
			return;
		}
		if (!flag && mathParkourCombatEntity.IsDefeated)
		{
			if (mathParkourCombatEntity.TryMarkDefeatHandled())
			{
				HandleCombatTargetDefeated(mathParkourCombatEntity, MathParkourDamageSource.Collision);
			}
			return;
		}
		float num = 0f;
		if (flag)
		{
			num = GetHpDecreaseRateByBoss();
		}
		else
		{
			num = GetHpDecreaseRate(mathParkourCombatEntity.InitialHp, playerHpAtCombatStart);
			num = Mathf.Max(num, 1f);
		}
		float num2 = num * Time.fixedDeltaTime;
		if (!flag)
		{
			float num3 = ApplyDamageToTarget(mathParkourCombatEntity, num2 * monsterDamageFactor, MathParkourDamageSource.Collision).ActualDamage;
			if (HasBuffType(HotfixEnum.MathParkourBuffType.Drill))
			{
				num3 *= 0.5f;
			}
			playerController.ReduceHp(num3);
			ApplySawSplashDamage(mathParkourCombatEntity, num2);
		}
		else
		{
			int hp = playerController.Hp;
			playerController.ReduceHp(num2);
			int num4 = hp - playerController.Hp;
			AddScore(Mathf.RoundToInt((float)num4 * mathParkourConfigData.QteScoreFactor));
			if (num2 > 0f)
			{
				mathParkourCombatEntity.PlayAnimatorAnim("hit", null, skipIfAlreadyPlaying: true);
				mathParkourCombatEntity.PlayHitParticleFx();
			}
		}
		if (playerController.Hp <= 0)
		{
			long entityId2 = mathParkourCombatEntity.EntityId;
			int configId2 = mathParkourCombatEntity.ConfigId;
			if ((combatTarget != null) & flag)
			{
				combatTarget.PlayKillAnim();
			}
			combatTarget = null;
			EndLevel(flag, entityId2, configId2);
		}
		else if (!flag)
		{
			_ = mathParkourCombatEntity.IsDefeated;
		}
	}

	public MathParkourDamageResult ApplyDamageToTarget(MathParkourCombatEntity target, float damage, MathParkourDamageSource source)
	{
		if (target == null || !target.gameObject.activeInHierarchy || damage <= 0f)
		{
			return new MathParkourDamageResult(0, isDefeated: false, isFirstDefeat: false);
		}
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(target.ConfigId);
		if (mathParkourObject == null || mathParkourObject.ObjType == 7)
		{
			return new MathParkourDamageResult(0, isDefeated: false, isFirstDefeat: false);
		}
		MathParkourDamageResult mathParkourDamageResult = target.ApplyDamage(damage);
		if (mathParkourDamageResult.ActualDamage > 0)
		{
			AddScore(Mathf.RoundToInt((float)mathParkourDamageResult.ActualDamage * mathParkourConfigData.ScoreFactor));
		}
		bool flag = mathParkourDamageResult.IsDefeated && target.TryMarkDefeatHandled();
		if (flag)
		{
			HandleCombatTargetDefeated(target, source);
		}
		return new MathParkourDamageResult(mathParkourDamageResult.ActualDamage, mathParkourDamageResult.IsDefeated, flag);
	}

	private void HandleCombatTargetDefeated(MathParkourCombatEntity defeatedTarget, MathParkourDamageSource source)
	{
		if (defeatedTarget == null || !defeatedTarget.IsDefeatHandled)
		{
			return;
		}
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(defeatedTarget.ConfigId);
		if (mathParkourObject != null && StringParamHelper.TryParseStringParamToInt(mathParkourObject.Param2, out var intValue))
		{
			AddScore(intValue);
		}
		if (combatTarget == defeatedTarget)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_atk_stop");
			combatTarget = null;
		}
		if (mathParkourObject != null && mathParkourObject.ObjType == 2)
		{
			pendingTravelerDefeatAnimations++;
			RefreshChunkMovement();
			PlayTravelerRescueHighlight(defeatedTarget);
			travelerRescueAnimationTarget = defeatedTarget;
			defeatedTarget.PlayKillAnim(() =>
			{
				StopTravelerHighlight();
				travelerRescueAnimationTarget = null;
				OnTravelerDefeatAnimationComplete();
			});
			if (isGameplayPaused)
			{
				defeatedTarget.SetKillAnimationPaused(paused: true);
			}
		}
		else
		{
			defeatedTarget.PlayKillAnim();
			RefreshChunkMovement();
		}
	}

	private void OnTravelerDefeatAnimationComplete()
	{
		pendingTravelerDefeatAnimations = Mathf.Max(0, pendingTravelerDefeatAnimations - 1);
		RefreshChunkMovement();
	}

	private void PlayTravelerRescueHighlight(MathParkourCombatEntity traveler)
	{
		StopTravelerHighlight();
		MathParkourModuleController instance = ModuleController<MathParkourModuleController>.Instance;
		if (!(traveler == null) && !(instance == null))
		{
			List<Transform> list = new List<Transform>();
			traveler.CollectHighlightVisualRoots(list);
			for (int i = 0; i < list.Count; i++)
			{
				CacheAndSetLayerRecursively(list.get_Item(i), 26);
			}
			instance.EnableTravelerRescueCameraInternal();
			if (StringParamHelper.TryParseStringParamToInt(Singleton<HotfixDataController>.Instance.GetMathParkourObject(traveler.ConfigId)?.Param4, out var intValue) && StringParamHelper.TryParseStringParamToInt(Singleton<HotfixDataController>.Instance.GetMathParkourObject(traveler.ConfigId)?.Param5, out var intValue2))
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_CastAssistSkill", intValue, intValue2);
			}
			else
			{
				Debug.LogWarning($"[MathParkour] 旅人 {traveler.ConfigId} 未配置有效的助战技能 dataID。", traveler);
			}
		}
	}

	private void StopTravelerHighlight()
	{
		foreach (KeyValuePair<Transform, int> travelerOriginalLayer in travelerOriginalLayers)
		{
			if (travelerOriginalLayer.Key != null)
			{
				travelerOriginalLayer.Key.gameObject.layer = travelerOriginalLayer.Value;
			}
		}
		ModuleController<MathParkourModuleController>.Instance?.DisableTravelerRescueCameraInternal();
		travelerOriginalLayers.Clear();
	}

	private void CacheAndSetLayerRecursively(Transform current, int layer)
	{
		if (!travelerOriginalLayers.ContainsKey(current))
		{
			travelerOriginalLayers.set_Item(current, current.gameObject.layer);
			current.gameObject.layer = layer;
			for (int i = 0; i < current.childCount; i++)
			{
				CacheAndSetLayerRecursively(current.GetChild(i), layer);
			}
		}
	}

	public void AddScore(int score)
	{
		if (score != 0)
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_AddScore", score);
		}
	}

	private void PlayFx(MathParkourTimedFx prefab, Vector3 position, Quaternion rotation, bool playerRoot = false)
	{
		if (!(prefab == null))
		{
			Transform parent;
			if (playerRoot)
			{
				parent = PlayerController.transform;
			}
			else
			{
				parent = ((buffFxRoot != null) ? buffFxRoot : transform);
			}
			MathParkourTimedFx mathParkourTimedFx = UnityEngine.Object.Instantiate(prefab, position, rotation, parent);
			if (playerRoot)
			{
				mathParkourTimedFx.transform.localPosition = Vector3.zero;
				mathParkourTimedFx.transform.localRotation = Quaternion.identity;
			}
			RegisterRuntimeEffect(mathParkourTimedFx.gameObject);
			mathParkourTimedFx.gameObject.SetActive(value: true);
			mathParkourTimedFx.Play(this);
		}
	}

	private List<MathParkourCombatEntity> GetActiveCombatTargets()
	{
		activeCombatTargetBuffer.Clear();
		for (int i = 0; i < activeChunks.Count; i++)
		{
			MathParkourChunk mathParkourChunk = activeChunks.get_Item(i);
			if (mathParkourChunk == null)
			{
				continue;
			}
			IReadOnlyList<MathParkourCombatEntity> combatEntities = mathParkourChunk.CombatEntities;
			for (int j = 0; j < combatEntities.Count; j++)
			{
				MathParkourCombatEntity mathParkourCombatEntity = combatEntities.get_Item(j);
				if (IsDamageableTarget(mathParkourCombatEntity))
				{
					activeCombatTargetBuffer.Add(mathParkourCombatEntity);
				}
			}
		}
		return activeCombatTargetBuffer;
	}

	public void ApplyDamageInRange(Vector3 center, float rangeRadius, float damage, MathParkourDamageSource source)
	{
		if (rangeRadius < 0f || damage <= 0f)
		{
			return;
		}
		float num = rangeRadius * rangeRadius;
		List<MathParkourCombatEntity> activeCombatTargets = GetActiveCombatTargets();
		for (int i = 0; i < activeCombatTargets.Count; i++)
		{
			Vector3 vector = activeCombatTargets.get_Item(i).transform.position - center;
			vector.y = 0f;
			if (vector.sqrMagnitude <= num)
			{
				ApplyDamageToTarget(activeCombatTargets.get_Item(i), damage, source);
			}
		}
	}

	private bool IsDamageableTarget(MathParkourCombatEntity target)
	{
		if (target == null || !target.gameObject.activeInHierarchy || target.IsDefeated)
		{
			return false;
		}
		MathParkourObject mathParkourObject = Singleton<HotfixDataController>.Instance.GetMathParkourObject(target.ConfigId);
		if (mathParkourObject != null)
		{
			return mathParkourObject.ObjType != 7;
		}
		return false;
	}

	public void PlayBuffFx(MathParkourTimedFx prefab, Vector3 position, Quaternion rotation, bool playerRoot = false)
	{
		PlayFx(prefab, position, rotation, playerRoot);
	}

	public void RegisterRuntimeEffect(GameObject effectObject)
	{
		RegisterRuntimeEffectObject(effectObject);
	}

	private float GetHpDecreaseRate(int enemyInitialHp, int playerHpAtCombatStart)
	{
		int baseSpeed = mathParkourConfigData.BaseSpeed;
		if ((float)baseSpeed <= 0f || enemyInitialHp <= 0)
		{
			return 0f;
		}
		float threshold = mathParkourConfigData.Threshold;
		float num = (((float)playerHpAtCombatStart >= (float)enemyInitialHp * threshold) ? mathParkourConfigData.Factor : (-1f));
		if (num > 0f)
		{
			return (float)(playerHpAtCombatStart / enemyInitialHp) * num * (float)baseSpeed;
		}
		return baseSpeed;
	}

	private float GetHpDecreaseRateByBoss()
	{
		return qteSpeed;
	}

	public void TryEndLevelIfPlayerDead()
	{
		if (!isLevelEnded && playerController != null && playerController.Hp <= 0)
		{
			EndLevel(isVictory: false, 0L, 0);
		}
	}

	private void EndLevel(bool isVictory, long defeatedEntityId, int defeatedConfigId)
	{
		if (!isLevelEnded)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_atk_stop");
			isLevelEnded = true;
			isRunning = false;
			combatTarget = null;
			ClearAllBuffs();
			string text = (isVictory ? "victory" : "defeat");
			if (!isVictory)
			{
				MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_char_die");
			}
			MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BlockInput", a1: true);
			playerController?.PlayAnimatorAnim(text, () =>
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BlockInput", a1: false);
				MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_LevelEnd", isVictory);
			});
		}
	}

	private void ClearAllBuffs()
	{
		List<int> list = new List<int>(BuffList);
		for (int i = 0; i < list.Count; i++)
		{
			MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BuffConsumed", list.get_Item(i));
		}
		ClearBuffRuntime();
	}

	private int ReverseInteger(int number)
	{
		int num = 0;
		while (number > 0)
		{
			num = num * 10 + number % 10;
			number /= 10;
		}
		return num;
	}

	public void SetMonsterDamageFactor(float factor)
	{
		monsterDamageFactor = factor;
	}

	public void AddBuff(int buffId)
	{
		MathParkourBuffItem mathParkourBuffItem = Singleton<HotfixDataController>.Instance.GetMathParkourBuffItem(buffId);
		if (mathParkourBuffItem == null)
		{
			return;
		}
		if (BuffList.Contains(buffId))
		{
			RestartBuffEffect(buffId);
			return;
		}
		int buffIdByType = GetBuffIdByType((HotfixEnum.MathParkourBuffType)mathParkourBuffItem.ObjType);
		if (buffIdByType >= 0)
		{
			RemoveBuff(buffIdByType);
		}
		BuffList.Add(buffId);
		AddBuffEffect(buffId, mathParkourBuffItem);
	}

	public void RemoveBuff(int buffId)
	{
		if (BuffList.Contains(buffId))
		{
			MathParkourBuffItem mathParkourBuffItem = Singleton<HotfixDataController>.Instance.GetMathParkourBuffItem(buffId);
			bool flag = pendingBoomBuffIds.Contains(buffId);
			BuffList.Remove(buffId);
			if (!flag && buffCoroutines.TryGetValue(buffId, out var value))
			{
				StopCoroutine(value);
				buffCoroutines.Remove(buffId);
			}
			StopPersistentBuffFx(buffId);
			if (mathParkourBuffItem == null || mathParkourBuffItem.ObjType != 8)
			{
				StopBuffRuntimeEffects(buffId);
			}
			RemoveBuffEffect(buffId);
		}
	}

	private void AddBuffEffect(int buffId)
	{
		AddBuffEffect(buffId, Singleton<HotfixDataController>.Instance.GetMathParkourBuffItem(buffId));
	}

	private void AddBuffEffect(int buffId, MathParkourBuffItem buffItemConfig)
	{
		if (buffItemConfig == null)
		{
			return;
		}
		switch (buffItemConfig.ObjType)
		{
		case 1:
		{
			if (StringParamHelper.TryParseStringParamToInt(buffItemConfig.Param1, out var intValue))
			{
				playerController.SetHp(playerController.GetHp() + intValue);
				TryEndLevelIfPlayerDead();
			}
			break;
		}
		case 2:
			playerController.PlayDrillFx();
			SetMonsterDamageFactor(2f);
			break;
		case 3:
			playerController.PlaySawFx();
			break;
		case 4:
			playerController.PlayShieldFx();
			break;
		case 5:
			StartBuffCoroutine(buffId, ActorACoroutine(buffId));
			break;
		case 6:
			StartBuffCoroutine(buffId, ActorBCoroutine(buffId));
			break;
		case 7:
			StartBuffCoroutine(buffId, ActorCCoroutine(buffId));
			break;
		case 8:
			break;
		}
	}

	private void RemoveBuffEffect(int buffId)
	{
		MathParkourBuffItem mathParkourBuffItem = Singleton<HotfixDataController>.Instance.GetMathParkourBuffItem(buffId);
		if (mathParkourBuffItem != null)
		{
			switch (mathParkourBuffItem.ObjType)
			{
			case 2:
				playerController.StopDrillFx();
				SetMonsterDamageFactor(1f);
				break;
			case 3:
				playerController.StopSawFx();
				break;
			case 4:
				playerController.StopShieldFx();
				break;
			case 1:
			case 5:
			case 6:
			case 7:
			case 8:
				break;
			}
		}
	}

	private void StartBuffCoroutine(int buffId, IEnumerator routine)
	{
		buffCoroutines.set_Item(buffId, StartCoroutine(routine));
	}

	private void RestartBuffEffect(int buffId)
	{
		if (buffCoroutines.TryGetValue(buffId, out var value))
		{
			StopCoroutine(value);
			buffCoroutines.Remove(buffId);
		}
		StopPersistentBuffFx(buffId);
		StopBuffRuntimeEffects(buffId);
		RemoveBuffEffect(buffId);
		AddBuffEffect(buffId);
	}

	private bool HasBuffType(HotfixEnum.MathParkourBuffType buffType)
	{
		for (int i = 0; i < BuffList.Count; i++)
		{
			MathParkourBuffItem mathParkourBuffItem = Singleton<HotfixDataController>.Instance.GetMathParkourBuffItem(BuffList.get_Item(i));
			if (mathParkourBuffItem != null && mathParkourBuffItem.ObjType == (int)buffType)
			{
				return true;
			}
		}
		return false;
	}

	private int GetBuffIdByType(HotfixEnum.MathParkourBuffType buffType)
	{
		for (int i = 0; i < BuffList.Count; i++)
		{
			int num = BuffList.get_Item(i);
			MathParkourBuffItem mathParkourBuffItem = Singleton<HotfixDataController>.Instance.GetMathParkourBuffItem(num);
			if (mathParkourBuffItem != null && mathParkourBuffItem.ObjType == (int)buffType)
			{
				return num;
			}
		}
		return -1;
	}

	private void ApplySawSplashDamage(MathParkourCombatEntity primaryTarget, float damage)
	{
		if (!HasBuffType(HotfixEnum.MathParkourBuffType.Saw) || primaryTarget == null || damage <= 0f)
		{
			return;
		}
		List<MathParkourCombatEntity> activeCombatTargets = GetActiveCombatTargets();
		for (int i = 0; i < activeCombatTargets.Count; i++)
		{
			MathParkourCombatEntity mathParkourCombatEntity = activeCombatTargets.get_Item(i);
			if (mathParkourCombatEntity != primaryTarget && mathParkourCombatEntity.OwnerChunk == primaryTarget.OwnerChunk && Mathf.Abs(mathParkourCombatEntity.LaneIndex - primaryTarget.LaneIndex) == 1 && mathParkourCombatEntity.RowIndex == primaryTarget.RowIndex)
			{
				ApplyDamageToTarget(mathParkourCombatEntity, damage, MathParkourDamageSource.Saw);
			}
		}
	}

	private bool TryConsumeShield(MathParkourCombatEntity target)
	{
		if (!HasBuffType(HotfixEnum.MathParkourBuffType.Shield))
		{
			return false;
		}
		if (!ApplyDamageToTarget(target, target.Hp, MathParkourDamageSource.Shield).IsFirstDefeat)
		{
			return false;
		}
		for (int i = 0; i < BuffList.Count; i++)
		{
			int num = BuffList.get_Item(i);
			MathParkourBuffItem mathParkourBuffItem = Singleton<HotfixDataController>.Instance.GetMathParkourBuffItem(num);
			if (mathParkourBuffItem != null && mathParkourBuffItem.ObjType == 4)
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BuffConsumed", num);
				break;
			}
		}
		return true;
	}

	private IEnumerator ActorACoroutine(int buffId)
	{
		float interval = 0.5f;
		while (!isLevelEnded && HasBuffType(HotfixEnum.MathParkourBuffType.ActorA))
		{
			yield return WaitForGameplayResumed();
			if (isLevelEnded || !HasBuffType(HotfixEnum.MathParkourBuffType.ActorA))
			{
				break;
			}
			if (actorAProjectilePrefab != null && CharacterTransform != null)
			{
				Transform parent = ((buffFxRoot != null) ? buffFxRoot : transform);
				Vector3 position = CharacterTransform.position;
				position.x += (float)NextRandom(-50, 51) * 0.01f;
				if (IsChunkMoving)
				{
					position.z += projectileSpawnZOffset;
				}
				MathParkourProjectile mathParkourProjectile = UnityEngine.Object.Instantiate(actorAProjectilePrefab, position, CharacterTransform.rotation, parent);
				RegisterRuntimeEffectObject(buffId, mathParkourProjectile.gameObject);
				mathParkourProjectile.gameObject.SetActive(value: true);
				mathParkourProjectile.Init(this, buffId, Mathf.Max(1, Mathf.FloorToInt((float)PlayerController.GetHp() * 0.5f)));
			}
			yield return WaitForGameplaySeconds(interval);
		}
	}

	private IEnumerator ActorBCoroutine(int buffId)
	{
		int totalStrikeCount = 8;
		float strikeInterval = 1f;
		for (int strikeIndex = 0; strikeIndex < totalStrikeCount; strikeIndex++)
		{
			if (isLevelEnded)
			{
				break;
			}
			if (!HasBuffType(HotfixEnum.MathParkourBuffType.ActorB))
			{
				break;
			}
			yield return WaitForGameplayResumed();
			if (isLevelEnded || !HasBuffType(HotfixEnum.MathParkourBuffType.ActorB))
			{
				break;
			}
			if (strikeIndex == totalStrikeCount - 1)
			{
				FireActorBFinalSwordQi(buffId);
			}
			else
			{
				MathParkourCombatEntity mathParkourCombatEntity = FindNearestTargetAhead(-1);
				if (mathParkourCombatEntity != null)
				{
					FireActorBSwordQi(buffId, mathParkourCombatEntity.transform.position, 2f);
				}
			}
			if (strikeIndex < totalStrikeCount - 1)
			{
				yield return WaitForGameplaySeconds(strikeInterval);
			}
		}
	}

	private void FireActorBSwordQi(int buffId, Vector3 targetPosition, float damageMultiplier)
	{
		if (CharacterTransform == null || PlayerController == null)
		{
			return;
		}
		MathParkourProjectile randomActorBProjectilePrefab = GetRandomActorBProjectilePrefab();
		if (!(randomActorBProjectilePrefab == null))
		{
			Vector3 vector = targetPosition - CharacterTransform.position;
			vector.y = 0f;
			if (vector.sqrMagnitude <= Mathf.Epsilon)
			{
				vector = CharacterTransform.forward;
			}
			Transform parent = ((buffFxRoot != null) ? buffFxRoot : transform);
			Quaternion rotation = Quaternion.LookRotation(vector.normalized, Vector3.up);
			Vector3 position = CharacterTransform.position;
			if (IsChunkMoving)
			{
				position.z += projectileSpawnZOffset;
			}
			MathParkourProjectile mathParkourProjectile = UnityEngine.Object.Instantiate(randomActorBProjectilePrefab, position, rotation, parent);
			RegisterRuntimeEffectObject(buffId, mathParkourProjectile.gameObject);
			mathParkourProjectile.gameObject.SetActive(value: true);
			mathParkourProjectile.Init(this, buffId, (float)PlayerController.GetHp() * 0.25f * damageMultiplier, MathParkourDamageSource.ActorBSwordQi);
		}
	}

	private void FireActorBFinalSwordQi(int buffId)
	{
		if (!(CharacterTransform == null))
		{
			for (int i = 0; i < 8; i++)
			{
				Vector3 vector = Quaternion.AngleAxis(360f * (float)i / 8f, Vector3.up) * CharacterTransform.forward;
				FireActorBSwordQi(buffId, CharacterTransform.position + vector, 4f);
			}
		}
	}

	private MathParkourProjectile GetRandomActorBProjectilePrefab()
	{
		int num = 0;
		for (int i = 0; i < actorBProjectilePrefabs.Length; i++)
		{
			if (actorBProjectilePrefabs[i] != null)
			{
				num++;
			}
		}
		if (num == 0)
		{
			return null;
		}
		int num2 = NextRandom(0, num);
		for (int j = 0; j < actorBProjectilePrefabs.Length; j++)
		{
			MathParkourProjectile mathParkourProjectile = actorBProjectilePrefabs[j];
			if (!(mathParkourProjectile == null) && num2-- == 0)
			{
				return mathParkourProjectile;
			}
		}
		return null;
	}

	private IEnumerator ActorCCoroutine(int buffId)
	{
		MathParkourTimedFx areaFx = null;
		if (areaFxPrefab != null && PlayerController != null)
		{
			areaFx = UnityEngine.Object.Instantiate(areaFxPrefab, CharacterTransform.position, Quaternion.identity, PlayerController.transform);
			areaFx.transform.localPosition = Vector3.zero;
			areaFx.transform.localRotation = Quaternion.identity;
			RegisterRuntimeEffectObject(buffId, areaFx.gameObject);
			areaFx.gameObject.SetActive(value: true);
		}
		for (int tick = 1; tick <= 20; tick++)
		{
			if (isLevelEnded)
			{
				break;
			}
			if (!HasBuffType(HotfixEnum.MathParkourBuffType.ActorC))
			{
				break;
			}
			if (isGameplayPaused && !isLevelEnded)
			{
				yield return WaitForGameplayResumed();
			}
			if (isLevelEnded || !HasBuffType(HotfixEnum.MathParkourBuffType.ActorC))
			{
				break;
			}
			if (tick == 20 && actorCIceStrikePrefab != null)
			{
				if (areaFx != null)
				{
					areaFx.gameObject.SetActive(value: false);
				}
				Transform parent = ((buffFxRoot != null) ? buffFxRoot : transform);
				MathParkourIceStrike mathParkourIceStrike = UnityEngine.Object.Instantiate(actorCIceStrikePrefab, CharacterTransform.position, Quaternion.identity, parent);
				RegisterRuntimeEffectObject(buffId, mathParkourIceStrike.gameObject);
				mathParkourIceStrike.Init(this, buffId, 3.4f, PlayerController.GetHp());
				continue;
			}
			float damage = (float)PlayerController.GetHp() * 0.1f;
			float num = 4.0800004f * 4.0800004f;
			Vector3 position = CharacterTransform.position;
			List<MathParkourCombatEntity> activeCombatTargets = GetActiveCombatTargets();
			for (int i = 0; i < activeCombatTargets.Count; i++)
			{
				MathParkourCombatEntity mathParkourCombatEntity = activeCombatTargets.get_Item(i);
				Vector3 vector = mathParkourCombatEntity.transform.position - position;
				vector.y = 0f;
				if (vector.sqrMagnitude <= num)
				{
					ApplyDamageToTarget(mathParkourCombatEntity, damage, MathParkourDamageSource.ActorCPeriodic);
				}
			}
			yield return WaitForGameplaySeconds(0.25f);
		}
	}

	private IEnumerator WaitForGameplayResumed()
	{
		while (isGameplayPaused && !isLevelEnded)
		{
			yield return null;
		}
	}

	public int UseBoom(int buffId, float killDelay = 0.45f, float damageDelay = 0.36f)
	{
		if (!BuffList.Contains(buffId) || pendingBoomBuffIds.Contains(buffId))
		{
			return 0;
		}
		MathParkourBuffItem mathParkourBuffItem = Singleton<HotfixDataController>.Instance.GetMathParkourBuffItem(buffId);
		if (mathParkourBuffItem == null || mathParkourBuffItem.ObjType != 8)
		{
			return 0;
		}
		pendingBoomBuffIds.Add(buffId);
		PlayBuffFxAtPrefabPosition(buffId, boomFxPrefab);
		float b = ((boomFxPrefab != null) ? boomFxPrefab.LifeTime : 0f);
		RefreshChunkMovement();
		playerController?.SetMovementTemporarilyLocked(locked: true);
		float num = Mathf.Max(Mathf.Max(0f, killDelay), b);
		StartBuffCoroutine(buffId, UseBoomCoroutine(buffId, Mathf.Min(Mathf.Max(0f, damageDelay), num), num));
		return 0;
	}

	private IEnumerator UseBoomCoroutine(int buffId, float damageDelay, float completeDelay)
	{
		if (damageDelay > 0f)
		{
			yield return WaitForGameplaySeconds(damageDelay);
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_boom");
		}
		if (!BuffList.Contains(buffId))
		{
			pendingBoomBuffIds.Remove(buffId);
			buffCoroutines.Remove(buffId);
			playerController?.SetMovementTemporarilyLocked(locked: false);
			RefreshChunkMovement();
			yield break;
		}
		List<MathParkourCombatEntity> activeCombatTargets = GetActiveCombatTargets();
		float z = CharacterTransform.position.z;
		float num = 10f * 1.7f;
		for (int i = 0; i < activeCombatTargets.Count; i++)
		{
			if (activeCombatTargets.get_Item(i).transform.position.z > z && activeCombatTargets.get_Item(i).transform.position.z - z <= num)
			{
				ApplyDamageToTarget(activeCombatTargets.get_Item(i), activeCombatTargets.get_Item(i).Hp, MathParkourDamageSource.Boom);
			}
		}
		float num2 = completeDelay - damageDelay;
		if (num2 > 0f)
		{
			yield return WaitForGameplaySeconds(num2);
		}
		pendingBoomBuffIds.Remove(buffId);
		buffCoroutines.Remove(buffId);
		playerController?.SetMovementTemporarilyLocked(locked: false);
		RefreshChunkMovement();
		MonoSingleton<LuaManager>.Instance?.FireEvent("MathParkour_BuffConsumed", buffId);
	}

	private MathParkourCombatEntity FindNearestTargetAhead(int laneIndex)
	{
		float num = 1f;
		float z = CharacterTransform.position.z;
		MathParkourCombatEntity result = null;
		float num2 = float.MaxValue;
		List<MathParkourCombatEntity> activeCombatTargets = GetActiveCombatTargets();
		for (int i = 0; i < activeCombatTargets.Count; i++)
		{
			MathParkourCombatEntity mathParkourCombatEntity = activeCombatTargets.get_Item(i);
			if (laneIndex < 0 || mathParkourCombatEntity.LaneIndex == laneIndex)
			{
				float num3 = mathParkourCombatEntity.transform.position.z - z;
				if (num3 >= num && num3 < num2)
				{
					result = mathParkourCombatEntity;
					num2 = num3;
				}
			}
		}
		return result;
	}

	private void StopPersistentBuffFx(int buffId)
	{
		if (persistentBuffFx.TryGetValue(buffId, out var value))
		{
			if (value != null)
			{
				UnityEngine.Object.Destroy(value.gameObject);
			}
			persistentBuffFx.Remove(buffId);
		}
	}

	private void RegisterRuntimeEffectObject(GameObject effectObject)
	{
		if (effectObject != null)
		{
			runtimeEffectObjects.Add(effectObject);
		}
	}

	private void RegisterRuntimeEffectObject(int buffId, GameObject effectObject)
	{
		RegisterRuntimeEffectObject(effectObject);
		if (!(effectObject == null))
		{
			if (!buffRuntimeEffectObjects.TryGetValue(buffId, out var value))
			{
				value = new List<GameObject>();
				buffRuntimeEffectObjects.Add(buffId, value);
			}
			value.Add(effectObject);
		}
	}

	public void PlayBuffFx(int buffId, MathParkourTimedFx prefab, Vector3 position, Quaternion rotation, bool playerRoot = false)
	{
		if (!(prefab == null))
		{
			Transform parent;
			if (playerRoot)
			{
				parent = PlayerController.transform;
			}
			else
			{
				parent = ((buffFxRoot != null) ? buffFxRoot : transform);
			}
			MathParkourTimedFx mathParkourTimedFx = UnityEngine.Object.Instantiate(prefab, position, rotation, parent);
			if (playerRoot)
			{
				mathParkourTimedFx.transform.localPosition = Vector3.zero;
				mathParkourTimedFx.transform.localRotation = Quaternion.identity;
			}
			RegisterRuntimeEffectObject(buffId, mathParkourTimedFx.gameObject);
			mathParkourTimedFx.gameObject.SetActive(value: true);
			mathParkourTimedFx.Play(this);
		}
	}

	private void PlayBuffFxAtPrefabPosition(int buffId, MathParkourTimedFx prefab)
	{
		if (!(prefab == null))
		{
			MathParkourTimedFx mathParkourTimedFx = UnityEngine.Object.Instantiate(prefab, prefab.transform.position, prefab.transform.rotation, buffFxRoot);
			RegisterRuntimeEffectObject(buffId, mathParkourTimedFx.gameObject);
			mathParkourTimedFx.gameObject.SetActive(value: true);
			mathParkourTimedFx.Play(this);
		}
	}

	private void StopBuffRuntimeEffects(int buffId)
	{
		if (!buffRuntimeEffectObjects.TryGetValue(buffId, out var value))
		{
			return;
		}
		for (int i = 0; i < value.Count; i++)
		{
			GameObject gameObject = value.get_Item(i);
			if (gameObject != null)
			{
				UnityEngine.Object.Destroy(gameObject);
				runtimeEffectObjects.Remove(gameObject);
			}
		}
		buffRuntimeEffectObjects.Remove(buffId);
	}

	private void ClearBuffRuntime()
	{
		foreach (Coroutine value in buffCoroutines.Values)
		{
			if (value != null)
			{
				StopCoroutine(value);
			}
		}
		buffCoroutines.Clear();
		foreach (MathParkourTimedFx value2 in persistentBuffFx.Values)
		{
			if (value2 != null)
			{
				UnityEngine.Object.Destroy(value2.gameObject);
			}
		}
		persistentBuffFx.Clear();
		for (int i = 0; i < runtimeEffectObjects.Count; i++)
		{
			if (runtimeEffectObjects.get_Item(i) != null)
			{
				UnityEngine.Object.Destroy(runtimeEffectObjects.get_Item(i));
			}
		}
		runtimeEffectObjects.Clear();
		buffRuntimeEffectObjects.Clear();
		pendingBoomBuffIds.Clear();
		playerController?.SetMovementTemporarilyLocked(locked: false);
		BuffList.Clear();
		SetMonsterDamageFactor(1f);
		playerController?.StopDrillFx();
		playerController?.StopSawFx();
		playerController?.StopShieldFx();
	}
}
