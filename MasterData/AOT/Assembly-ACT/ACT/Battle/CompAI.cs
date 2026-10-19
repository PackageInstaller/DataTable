using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.BluePrint;
using ACT.Core;
using ACT.MultiPlayer;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class CompAI : EcsComponent
{
	public CompAIState compAIState;

	public int groupAI = -1;

	public int groupUid = -1;

	public Vector3 pos;

	public Vector3 hatredSize;

	public Vector3 hatredOffset;

	public bool useRayCastCheckBlock;

	public bool useDirectMonsterPointRange;

	public bool useEntityPositionForHatredRange;

	public bool useEntityPositionForLoseBattleRange;

	public Vector3 loseBattleSize;

	public Vector3 loseBattleOffset;

	public bool loseBattleCanCheckBlock;

	public List<Vector3> patrolPoints = new List<Vector3>();

	public List<Vector3> infoPos = new List<Vector3>();

	public List<string> infoPosNames = new List<string>();

	public Vector3 jumpInbornPos;

	public bool needDither;

	public bool isInSamePlatform = true;

	public bool canAttack = true;

	public bool dontChangeAttackTokenAndCanAttack;

	public float lastSetAttackTokenTime = float.MinValue;

	public bool hasAttackToken = true;

	public bool battleState;

	public bool hasDoAttack;

	public float lastAttackTime = float.MaxValue;

	public AIBodyIntent currentBodyIntent;

	public string currentBehaviourName = string.Empty;

	public AIBodyMovePolicy currentMovePolicy;

	public float bodyCommitmentStartTime = float.MinValue;

	public float lastMoveCommitTime = float.MinValue;

	public float lastMoveFailTime = float.MinValue;

	public string lastMoveFailKey = string.Empty;

	public AIAttackRequest pendingAttackRequest;

	public AIAttackRequest lastCommittedAttackRequest;

	private const float CombatMoveMinCommitInterval = 0.2f;

	private const float CombatMoveFailCooldown = 0.5f;

	private const float CombatMoveMinDestinationDeltaSqr = 0.09f;

	public float hatredTargetDisX = float.MaxValue;

	public float hatredTargetDisY = float.MaxValue;

	public bool outScreen;

	public int behaviorDepth;

	private AssetLoadHandle _assetHandle;

	public ActBehaviorTree ActBehaviorTree { get; private set; }

	public ExternalBehaviorTree ExternalBehaviorTree { get; private set; }

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		UnregisterGroupAI();
		compAIState = CompAIState.Born;
		isInSamePlatform = true;
		behaviorDepth = 0;
		pos = default;
		hatredSize = default;
		hatredOffset = default;
		useRayCastCheckBlock = false;
		useDirectMonsterPointRange = false;
		useEntityPositionForHatredRange = false;
		useEntityPositionForLoseBattleRange = false;
		loseBattleSize = default;
		loseBattleOffset = default;
		loseBattleCanCheckBlock = false;
		patrolPoints.Clear();
		infoPos.Clear();
		infoPosNames.Clear();
		jumpInbornPos = Vector3.zero;
		needDither = false;
		dontChangeAttackTokenAndCanAttack = false;
		lastSetAttackTokenTime = float.MinValue;
		canAttack = true;
		hasAttackToken = true;
		battleState = false;
		lastAttackTime = float.MaxValue;
		ClearBodyCommitment();
		ClearAttackRequest();
		ClearCommittedAttackRequest();
		lastMoveCommitTime = float.MinValue;
		lastMoveFailTime = float.MinValue;
		lastMoveFailKey = string.Empty;
		hatredTargetDisX = float.MaxValue;
		hatredTargetDisY = float.MaxValue;
		outScreen = false;
		ActBehaviorTree = null;
		if (_assetHandle.IsValid)
		{
			AssetStationManager.BattleStation.Release(_assetHandle);
		}
	}

	public void Init(SpawnMonsterParams smp)
	{
		if (smp != null)
		{
			pos = smp.pos;
			hatredSize = smp.hatredSize;
			hatredOffset = smp.hatredOffset;
			useRayCastCheckBlock = smp.useRayCastCheckBlock;
			useDirectMonsterPointRange = smp.useDirectMonsterPointRange;
			useEntityPositionForHatredRange = smp.useEntityPositionForHatredRange;
			useEntityPositionForLoseBattleRange = smp.useEntityPositionForLoseBattleRange;
			loseBattleSize = smp.loseBattleSize;
			loseBattleOffset = smp.loseBattleOffset;
			loseBattleCanCheckBlock = smp.loseBattleCanCheckBlock;
			patrolPoints.AddRange(smp.patrolPoints);
			infoPos.AddRange(smp.infoPos);
			infoPosNames.AddRange(smp.infoPosName);
			jumpInbornPos = smp.jumpInbornPos;
			needDither = smp.needDither;
		}
		isInSamePlatform = true;
		behaviorDepth = 0;
		lastAttackTime = float.MaxValue;
		ClearBodyCommitment();
		ClearAttackRequest();
		ClearCommittedAttackRequest();
		lastMoveCommitTime = float.MinValue;
		lastMoveFailTime = float.MinValue;
		lastMoveFailKey = string.Empty;
	}

	public void SubmitAttackRequest(AIBehaviourData behaviour, string requestSource, int priority = 0)
	{
		if (behaviour != null && !string.IsNullOrEmpty(behaviour.name) && (!pendingAttackRequest.isValid || pendingAttackRequest.priority <= priority))
		{
			pendingAttackRequest = new AIAttackRequest(behaviour, requestSource, priority);
		}
	}

	public bool TryCommitAttackRequest(out AIAttackRequest request)
	{
		request = default;
		if (!pendingAttackRequest.isValid)
		{
			return false;
		}
		request = pendingAttackRequest;
		lastCommittedAttackRequest = request;
		CommitAttackBody(request.behaviourName, request.movePolicy);
		ClearAttackRequest();
		return true;
	}

	public bool HasPendingAttackRequest()
	{
		return pendingAttackRequest.isValid;
	}

	public bool TryGetPendingAttackRequest(out AIAttackRequest request)
	{
		request = pendingAttackRequest;
		return request.isValid;
	}

	public void ClearAttackRequest()
	{
		pendingAttackRequest = default;
	}

	public void ClearCommittedAttackRequest()
	{
		lastCommittedAttackRequest = default;
	}

	public void CommitAttackBody(string behaviourName, AIBodyMovePolicy movePolicy)
	{
		currentBodyIntent = AIBodyIntent.Attack;
		currentBehaviourName = behaviourName ?? string.Empty;
		currentMovePolicy = movePolicy;
		bodyCommitmentStartTime = Time.time;
	}

	public void ReleaseAttackBody(string behaviourName)
	{
		if (currentBodyIntent == AIBodyIntent.Attack && (string.IsNullOrEmpty(currentBehaviourName) || string.IsNullOrEmpty(behaviourName) || !(currentBehaviourName != behaviourName)))
		{
			ClearBodyCommitment();
		}
	}

	public void ClearBodyCommitment()
	{
		currentBodyIntent = AIBodyIntent.None;
		currentBehaviourName = string.Empty;
		currentMovePolicy = AIBodyMovePolicy.NoMove;
		bodyCommitmentStartTime = float.MinValue;
	}

	public bool CanCommitLocomotion()
	{
		if (currentBodyIntent == AIBodyIntent.None)
		{
			return true;
		}
		AIBodyMovePolicy aIBodyMovePolicy = currentMovePolicy;
		return aIBodyMovePolicy == AIBodyMovePolicy.ApproachAllowed || aIBodyMovePolicy == AIBodyMovePolicy.RepositionAllowed || aIBodyMovePolicy == AIBodyMovePolicy.FreeMove;
	}

	public bool CanStartCombatMove(string moveKey)
	{
		if (!CanCommitLocomotion())
		{
			RecordMoveFail(moveKey);
			return false;
		}
		return !IsMoveFailCoolingDown(moveKey);
	}

	public bool TryCommitCombatMoveDestination(CompNav compNav, Vector3 candidate, string moveKey)
	{
		return IsCombatMoveCommitAccepted(TryCommitCombatMove(compNav, candidate, moveKey));
	}

	public AICombatMoveCommitResult TryCommitCombatMove(CompNav compNav, Vector3 candidate, string moveKey, bool validatePath = true)
	{
		AICombatMoveRequest request = new AICombatMoveRequest(compNav, candidate, moveKey, validatePath, 0);
		return TryCommitCombatMove(request);
	}

	public AICombatMoveCommitResult TryCommitCombatMove(AICombatMoveRequest request)
	{
		string moveKey = request.moveKey;
		CompNav compNav = request.compNav;
		Vector3 candidate = request.candidate;
		if (!request.isValid)
		{
			RecordMoveFail(moveKey);
			return AICombatMoveCommitResult.InvalidNav;
		}
		if (!CanCommitLocomotion())
		{
			RecordMoveFail(moveKey);
			return AICombatMoveCommitResult.BlockedByBodyCommitment;
		}
		if (IsMoveFailCoolingDown(moveKey))
		{
			return AICombatMoveCommitResult.FailCooldown;
		}
		float time = Time.time;
		if (Vector3.Scale(candidate - compNav.destination, new Vector3(1f, 1f, 0f)).sqrMagnitude < 0.09f)
		{
			return AICombatMoveCommitResult.ReusedCurrentDestination;
		}
		if (time - lastMoveCommitTime < 0.2f)
		{
			return AICombatMoveCommitResult.CommitCooldown;
		}
		compNav.destination = candidate;
		lastMoveCommitTime = time;
		return AICombatMoveCommitResult.Committed;
	}

	public void RecordMoveFail(string moveKey)
	{
		lastMoveFailKey = moveKey ?? string.Empty;
		lastMoveFailTime = Time.time;
	}

	public static AIBodyMovePolicy ResolveMovePolicy(AIBehaviourData behaviour)
	{
		return behaviour?.movePolicy ?? AIBodyMovePolicy.NoMove;
	}

	private static bool IsCombatMoveCommitAccepted(AICombatMoveCommitResult result)
	{
		if (result != AICombatMoveCommitResult.Committed && result != AICombatMoveCommitResult.ReusedCurrentDestination)
		{
			return result == AICombatMoveCommitResult.CommitCooldown;
		}
		return true;
	}

	private bool CanReachCombatMoveDestination(CompNav compNav, Vector3 candidate)
	{
		if (compNav.isAir)
		{
			return true;
		}
		if (!owner.IsValid)
		{
			return false;
		}
		return ACTNavMeshAgent.CanNavigateBetween(owner.GetCompTransform().physicsPosition, candidate, compNav.areaMask, compNav.moveCapability);
	}

	private bool IsMoveFailCoolingDown(string moveKey)
	{
		if (!string.IsNullOrEmpty(lastMoveFailKey) && lastMoveFailKey == (moveKey ?? string.Empty))
		{
			return Time.time - lastMoveFailTime < 0.5f;
		}
		return false;
	}

	public void SetCanAttack(bool res)
	{
		if (dontChangeAttackTokenAndCanAttack)
		{
			canAttack = true;
		}
		else
		{
			canAttack = res;
		}
	}

	public bool GetCanAttack()
	{
		return canAttack;
	}

	public bool HasGroupAIControl(Entity entity)
	{
		if (entity.IsValid && entity.TryGetCompAI(out CompAI component))
		{
			return component.NeedGroupAIControl();
		}
		return false;
	}

	private bool IsEliteOrBoss()
	{
		EntityType entityType = owner.GetEntityType();
		if (entityType == EntityType.Elite || entityType == EntityType.Boss)
		{
			return true;
		}
		int tableId = owner.GetTableId();
		if (tableId == 0 || !RuntimeConfigs.data.entityDatas.TryGetValue(tableId, out var value))
		{
			return false;
		}
		int type = value.type;
		return type == 3 || type == 6;
	}

	public bool NeedGroupAIControl()
	{
		if (groupAI < 0 || groupUid < 0)
		{
			return false;
		}
		if (!owner.IsValid)
		{
			return false;
		}
		if (IsEliteOrBoss())
		{
			return false;
		}
		if (owner.GetEntityType() != EntityType.Monster)
		{
			return false;
		}
		ConfigCharacter config = owner.GetConfig();
		if (config == null)
		{
			return false;
		}
		MonsterAttackType monsterAttackType = config.MonsterAttackType;
		if (monsterAttackType != MonsterAttackType.support && monsterAttackType != MonsterAttackType.airAttack)
		{
			return monsterAttackType != MonsterAttackType.airNoob;
		}
		return false;
	}

	public bool HasAttackToken()
	{
		return hasAttackToken;
	}

	public void SetAttackToken(bool res)
	{
		if (IsEliteOrBoss())
		{
			hasAttackToken = true;
			if (res)
			{
				lastAttackTime = (lastSetAttackTokenTime = Time.time);
			}
		}
		else
		{
			hasAttackToken = res;
			if (res)
			{
				lastAttackTime = (lastSetAttackTokenTime = Time.time);
			}
		}
	}

	public Entity GetPlayerCanBeLoseBattle()
	{
		CompHatred compHatred = owner.GetCompHatred();
		if (compHatred.hatredLevel != 0)
		{
			return compHatred.GetHatred();
		}
		if (!TryGetLoseBattleBounds(out var bound, out var _, out var _))
		{
			return default;
		}
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		if (localPlayer != null && localPlayer.battleEntity.IsValid && localPlayer.battleEntity.IsLogicAvailable())
		{
			CompTransform compTransform = localPlayer.battleEntity.GetCompTransform();
			CompPhysics? compPhysics = localPlayer.battleEntity.GetCompPhysics();
			Vector3 physicsPosition = compTransform.physicsPosition;
			physicsPosition.y = localPlayer.battleEntity.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT).y;
			if (compPhysics.isGrounded)
			{
				physicsPosition.y = Mathf.Max(physicsPosition.y, compTransform.physicsPosition.y + 0.05f);
			}
			Vector3 attachPointPosition = owner.GetMono().GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
			Vector3 vector = physicsPosition - attachPointPosition;
			Vector3 normalized = vector.normalized;
			Vector3 point = Quaternion.FromToRotation(owner.GetCompPhysics().pathTangent, Vector3.right) * vector + attachPointPosition;
			if (compPhysics.isGrounded)
			{
				point.y = Mathf.Max(point.y, compTransform.physicsPosition.y);
			}
			if (localPlayer.battleEntity.GetCompEffect().bInUltraTimeline)
			{
				point = compTransform.physicsPosition;
			}
			if (bound.Contains(point))
			{
				if (useRayCastCheckBlock)
				{
					compHatred.SetHatred(localPlayer.battleEntity);
					return localPlayer.battleEntity;
				}
				RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
				int num = Physics.RaycastNonAlloc(attachPointPosition, normalized, cacheHits, vector.magnitude, BattleConsts.enviromentMask);
				PhysicsUtility.Release(cacheHits);
				if (num == 0)
				{
					compHatred.SetHatred(localPlayer.battleEntity);
					return localPlayer.battleEntity;
				}
			}
		}
		return default;
	}

	public bool TryIsLocalPlayerInsideLoseBattleRange(out bool inside)
	{
		inside = false;
		if (!owner.IsValid || !TryGetLoseBattleBounds(out var bound, out var _, out var _))
		{
			return false;
		}
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		if (localPlayer == null || !localPlayer.battleEntity.IsValid || !localPlayer.battleEntity.IsLogicAvailable())
		{
			return false;
		}
		Entity battleEntity = localPlayer.battleEntity;
		MonoEntity mono = battleEntity.GetMono();
		MonoEntity mono2 = owner.GetMono();
		if (mono == null || mono2 == null)
		{
			return false;
		}
		CompTransform compTransform = battleEntity.GetCompTransform();
		CompPhysics? compPhysics = battleEntity.GetCompPhysics();
		Vector3 physicsPosition = compTransform.physicsPosition;
		physicsPosition.y = mono.GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT).y;
		if (compPhysics.isGrounded)
		{
			physicsPosition.y = Mathf.Max(physicsPosition.y, compTransform.physicsPosition.y + 0.05f);
		}
		Vector3 attachPointPosition = mono2.GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
		Vector3 vector = physicsPosition - attachPointPosition;
		Vector3 vector2 = Quaternion.FromToRotation(owner.GetCompPhysics().pathTangent, Vector3.right) * vector + attachPointPosition;
		if (compPhysics.isGrounded)
		{
			vector2.y = Mathf.Max(vector2.y, compTransform.physicsPosition.y);
		}
		vector2 = compTransform.physicsPosition;
		inside = bound.Contains(vector2);
		return true;
	}

	private bool TryGetLoseBattleBounds(out Bounds bound, out Vector3 center, out Vector3 pathSize)
	{
		bound = default;
		center = default;
		pathSize = default;
		if (!owner.IsValid)
		{
			return false;
		}
		EntityType entityType = owner.GetEntityType();
		CompAI compAI = owner.GetCompAI();
		CompTransform compTransform = owner.GetCompTransform();
		CompPhysics? compPhysics = owner.GetCompPhysics();
		Vector3 physicsPosition = pos;
		if (entityType == EntityType.Boss)
		{
			physicsPosition = compAI.pos;
		}
		if (useEntityPositionForLoseBattleRange)
		{
			physicsPosition = compTransform.physicsPosition;
		}
		Vector3 zero = Vector3.zero;
		Vector3 vector = compAI.loseBattleSize;
		if (vector == Vector3.zero)
		{
			MonsterAttackType monsterAttackType = owner.GetConfig().MonsterAttackType;
			Common common = GameLoader.meta.enemyInfo.enemyInfoDict[monsterAttackType];
			vector.x = common.enemyCommonLoseBattleSizeX;
			vector.y = common.enemyCommonLoseBattleSizeY;
		}
		else
		{
			zero = compAI.loseBattleOffset;
		}
		if (entityType == EntityType.Boss)
		{
			vector.x = Mathf.Max(GameLoader.meta.enemyInfo.bossLoseBattleSize.x, vector.x);
		}
		if (entityType == EntityType.Boss && GameLoader.meta.enemyInfo.bossLoseBattleSize.y < 15f)
		{
			vector.y = Mathf.Max(GameLoader.meta.enemyInfo.bossLoseBattleSize.y, vector.y);
		}
		bool flag = compAI.loseBattleOffset != Vector3.zero;
		float num = ((compPhysics.motion == MotionType.Air) ? 0f : (vector.y * 0.5f));
		center = physicsPosition + new Vector3(zero.x, zero.y + (flag ? vector.y : num), zero.z);
		ref Vector3 reference = ref pathSize;
		float x = vector.x;
		float y = vector.y * 1.2f;
		float z;
		if (entityType == EntityType.Boss)
		{
			z = 100f;
		}
		else
		{
			z = ((vector.z <= 4f) ? BattleConsts.HATRED_RANGE_Z_SIZE : vector.z);
		}
		reference = new Vector3(x, y, z);
		bound = new Bounds(center, pathSize);
		if (useDirectMonsterPointRange)
		{
			Vector3 vector2 = (useEntityPositionForLoseBattleRange ? compTransform.physicsPosition : pos);
			center = vector2 + loseBattleOffset;
			pathSize = loseBattleSize;
			bound = new Bounds(center, pathSize);
		}
		return true;
	}

	public Entity GetPlayerCanBeHatred()
	{
		MonoECS instance = MonoECS.instance;
		CompAI compAI = owner.GetCompAI();
		Vector3 physicsPosition = pos;
		physicsPosition.z = compAI.pos.z;
		if (useEntityPositionForHatredRange)
		{
			physicsPosition = owner.GetCompTransform().physicsPosition;
		}
		bool flag = false;
		Vector3 zero = Vector3.zero;
		ConfigCharacter config = owner.GetConfig();
		Vector3 vector = compAI.hatredSize;
		if (vector == Vector3.zero)
		{
			vector.x = GameLoader.meta.enemyInfo.enemyInfoDict[config.MonsterAttackType].enemyCommonFrontInBattleSizeX + GameLoader.meta.enemyInfo.enemyInfoDict[config.MonsterAttackType].enemyCommonBackInBattleSizeX;
			vector.y = GameLoader.meta.enemyInfo.enemyInfoDict[config.MonsterAttackType].enemyCommonInBattleSizeY;
			zero.y = vector.y * -0.5f;
			zero.x = vector.x / 2f - GameLoader.meta.enemyInfo.enemyInfoDict[config.MonsterAttackType].enemyCommonBackInBattleSizeX;
			zero.x = (owner.IsFaceLeft() ? (0f - zero.x) : zero.x);
		}
		else
		{
			flag = compAI.useRayCastCheckBlock;
			zero = compAI.hatredOffset;
			zero.x = (owner.IsFaceLeft() ? (0f - zero.x) : zero.x);
		}
		bool flag2 = compAI.hatredOffset != Vector3.zero;
		Vector3 center = physicsPosition + new Vector3(zero.x, zero.y + (flag2 ? vector.y : (vector.y * 0.5f)), zero.z);
		Vector3 size = new Vector3(vector.x, vector.y, (vector.z <= 4f) ? BattleConsts.HATRED_RANGE_Z_SIZE : vector.z);
		Bounds bounds = new Bounds(center, size);
		if (useDirectMonsterPointRange)
		{
			center = (useEntityPositionForHatredRange ? owner.GetCompTransform().physicsPosition : pos) + hatredOffset;
			size = hatredSize;
			bounds = new Bounds(center, size);
		}
		MPPlayer localPlayer = instance.localPlayer;
		if (localPlayer != null && localPlayer.battleEntity.IsValid && localPlayer.battleEntity.IsLogicAvailable())
		{
			MonoEntity mono = localPlayer.battleEntity.GetMono();
			Vector3 physicsPosition2 = localPlayer.battleEntity.GetCompTransform().physicsPosition;
			physicsPosition2.y = mono.GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT).y;
			Vector3 attachPointPosition = mono.GetAttachPointPosition(BattleConsts.AIM_ATTACH_POINT);
			Vector3 vector2 = physicsPosition2 - attachPointPosition;
			Vector3 normalized = vector2.normalized;
			Vector3 point = Quaternion.FromToRotation(owner.GetCompPhysics().pathTangent, Vector3.right) * vector2 + attachPointPosition;
			if (bounds.Contains(point))
			{
				if (flag)
				{
					return localPlayer.battleEntity;
				}
				RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
				int num = Physics.RaycastNonAlloc(attachPointPosition, normalized, cacheHits, vector2.magnitude, BattleConsts.enviromentMask);
				PhysicsUtility.Release(cacheHits);
				if (num == 0)
				{
					return localPlayer.battleEntity;
				}
			}
		}
		return default;
	}

	public async UniTask<bool> LoadAsync(YooAssetReference assetRef, SpawnMonsterParams spm = null)
	{
		if (_assetHandle.IsValid)
		{
			return false;
		}
		return await LoadAsync(AssetStationManager.BattleStation.LoadAsync<ExternalBehaviorTree>(assetRef), spm);
	}

	public async UniTask<bool> LoadAsync(string path, SpawnMonsterParams spm = null)
	{
		if (_assetHandle.IsValid)
		{
			return false;
		}
		return await LoadAsync(AssetStationManager.BattleStation.LoadAsync<ExternalBehaviorTree>(path), spm);
	}

	private async UniTask<bool> LoadAsync(AssetLoadHandle handle, SpawnMonsterParams spm)
	{
		_assetHandle = handle;
		await UniTask.WaitUntil(() => !handle.IsValid || handle.IsDone);
		if (owner.IsValid)
		{
			ExternalBehaviorTree externalBehaviorTree = _assetHandle.As<ExternalBehaviorTree>();
			if ((object)externalBehaviorTree != null)
			{
				Bind(externalBehaviorTree, spm);
				return true;
			}
		}
		return false;
	}

	public void Bind(ExternalBehaviorTree btree, SpawnMonsterParams spm = null)
	{
		GameObject root = owner.GetRoot();
		if ((object)root != null && root.TryGetComponent<ActBehaviorTree>(out var component))
		{
			ActBehaviorTree = component;
			ActBehaviorTree actBehaviorTree = component;
			ExternalBehaviorTree externalBehavior = (ExternalBehaviorTree = btree);
			actBehaviorTree.ExternalBehavior = externalBehavior;
			component.OnSpawn(owner, spm);
			CheckIfAINavAvailable();
		}
	}

	public void CheckIfAINavAvailable()
	{
		if (owner.TryGetCompBehave(out CompBehave component))
		{
			ActBehaviorTree actBehaviorTree = ActBehaviorTree;
			if ((object)actBehaviorTree != null)
			{
				actBehaviorTree.running = component.IsAINavAvailable();
			}
		}
	}

	public void RegisterGroupAI(SpawnMonsterParams smp)
	{
		groupUid = smp.groupUid;
		groupAI = smp.groupAi;
		Singleton<GroupAIManager>.instance.RegisterGroupAI(owner, smp.groupUid, smp.groupAi);
	}

	public void UnregisterGroupAI()
	{
		if (groupUid != -1)
		{
			Singleton<GroupAIManager>.instance.UnRegisterGroupAI(owner, groupUid);
			groupAI = -1;
			groupUid = -1;
		}
	}
}
