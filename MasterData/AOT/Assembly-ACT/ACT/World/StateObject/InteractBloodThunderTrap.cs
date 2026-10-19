using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.Collections;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractBloodThunderTrap : StateObjectBase
{
	private class FieldState
	{
		public int currentRoundIndex;

		public float roundTimer;

		public float intervalTimer;

		public bool isFirstEnter;

		public float firstEnterTimer;

		public List<Vector3> pendingSpawnPositions = new List<Vector3>();

		public bool hasAttacked;

		public bool hasSpawnedEffects;

		public bool isWaitingForInterval;

		public float currentIntervalTime;

		public void Reset()
		{
			currentRoundIndex = 0;
			roundTimer = 0f;
			intervalTimer = 0f;
			isFirstEnter = true;
			firstEnterTimer = 0f;
			pendingSpawnPositions.Clear();
			hasAttacked = false;
			hasSpawnedEffects = false;
			isWaitingForInterval = false;
			currentIntervalTime = 0f;
		}
	}

	private class AlwaysRandomRoundState
	{
		public int roundIndex;

		public float roundTimer;

		public float intervalTimer;

		public List<Vector3> pendingSpawnPositions = new List<Vector3>();

		public bool hasAttacked;

		public bool hasSpawnedEffects;

		public bool isWaitingForInterval;

		public float currentIntervalTime;

		public void Reset()
		{
			roundIndex = 0;
			roundTimer = 0f;
			intervalTimer = 0f;
			pendingSpawnPositions.Clear();
			hasAttacked = false;
			hasSpawnedEffects = false;
			isWaitingForInterval = false;
			currentIntervalTime = 0f;
		}
	}

	private BloodThunderTrapData _data;

	private CancellationTokenSource _tokenSource;

	private Entity _attackEntity;

	private IDisposable _syncAttackablePositionDisposable;

	private bool _init;

	private const float RayDistance = 30f;

	private const float _intervalDis = 1f;

	private const int _iteration = 10;

	private const int NeutralId = 6;

	private GameObject _root;

	private bool _isCharacterInside;

	private FieldState _fieldState;

	private AlwaysRandomRoundState _alwaysRandomState;

	private Bounds _fieldBounds;

	private const float _twinkleTime = 1f;

	[SerializeField]
	[Header("如果需要不同的预警时间，请新做一个wrap并且新做一个特效修改其粒子startLifeTime")]
	private float _damageWaitingTime;

	[SerializeField]
	private YooAssetReference[] _bloodThunderEffectsID;

	[SerializeField]
	private ConfigLaserObject _config;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is BloodThunderTrapData data)
		{
			_data = data;
			_tokenSource = new CancellationTokenSource();
			CoSpawnAttackEntity();
			InitTriggerAreas();
			base.InitStateObject(stateId);
			_init = true;
		}
	}

	private void InitTriggerAreas()
	{
		if (_data.Field != null)
		{
			_fieldBounds = GetFieldBounds();
			_fieldState = new FieldState();
			GameObject gameObject = new GameObject();
			gameObject.transform.SetParent(transform, worldPositionStays: false);
			_root = gameObject;
			gameObject.AddComponent<TemporaryArea>().Init(new MixedBox[1] { _data.Field }, OnEnterField, OnExitField);
			InitAlwaysRandomStates();
		}
	}

	private void InitAlwaysRandomStates()
	{
		if (_data.RandomTrapRounds != null && _data.RandomTrapRounds.Length != 0)
		{
			_alwaysRandomState = new AlwaysRandomRoundState();
		}
	}

	private void OnEnterField()
	{
		if (_fieldState != null && !_isCharacterInside)
		{
			_isCharacterInside = true;
			_fieldState.Reset();
		}
	}

	private void OnExitField()
	{
		if (_fieldState != null && _isCharacterInside)
		{
			_isCharacterInside = false;
		}
	}

	private void CoSpawnAttackEntity()
	{
		_attackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity eb = _attackEntity;
		MonoECS.instance.SpawnAttackInteractObject(eb, 6, _data.trapType, _data.defenceTowerType, _data.initPos, Alliance.Netural, Vector3.one, _data.initRotate);
		if (_tokenSource.IsCancellationRequested)
		{
			return;
		}
		eb.GetCompStateObject().StateWorldAssetData = _data;
		_syncAttackablePositionDisposable = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			if (_attackEntity.IsValid)
			{
				eb.GetRootTransform().position = transform.position;
			}
		});
	}

	private void FixedUpdate()
	{
		if (currentStateId == 0 && _data != null && _init)
		{
			float fixedDeltaTime = _attackEntity.GetCompTime().fixedDeltaTime;
			if (_alwaysRandomState != null && (!_data.ControlRandomTrapRounds || !_isCharacterInside))
			{
				UpdateAlwaysRandomLogic(_alwaysRandomState, fixedDeltaTime);
			}
			if (_fieldState != null && _isCharacterInside)
			{
				UpdateInFieldLogic(_fieldState, fixedDeltaTime);
			}
		}
	}

	private void UpdateInFieldLogic(FieldState state, float dt)
	{
		if (_data.Rounds == null || _data.Rounds.Length == 0)
		{
			return;
		}
		TrapRound trapRound = _data.Rounds[state.currentRoundIndex];
		if (state.isFirstEnter)
		{
			state.firstEnterTimer += dt;
			if (state.firstEnterTimer < _data.FirstIntervalTime)
			{
				return;
			}
			state.isFirstEnter = false;
		}
		if (state.isWaitingForInterval)
		{
			state.intervalTimer += dt;
			if (state.intervalTimer >= state.currentIntervalTime)
			{
				MoveToNextRound(state);
			}
			return;
		}
		if (state.pendingSpawnPositions.Count == 0)
		{
			state.currentIntervalTime = trapRound.GetRandomIntervalTime();
			CalculateInFieldSpawnPositions(state, trapRound);
		}
		if (!state.hasSpawnedEffects && state.pendingSpawnPositions.Count > 0)
		{
			foreach (Vector3 pendingSpawnPosition in state.pendingSpawnPositions)
			{
				SpawnEffect(pendingSpawnPosition);
			}
			state.hasSpawnedEffects = true;
		}
		state.roundTimer += dt;
		if (!state.hasAttacked && state.roundTimer >= _damageWaitingTime && state.pendingSpawnPositions.Count > 0)
		{
			foreach (Vector3 pendingSpawnPosition2 in state.pendingSpawnPositions)
			{
				DoAttackAtPosition(pendingSpawnPosition2);
			}
			state.hasAttacked = true;
		}
		float num = _damageWaitingTime + 1f;
		if (state.roundTimer >= num)
		{
			state.isWaitingForInterval = true;
			state.intervalTimer = 0f;
		}
	}

	private void CalculateInFieldSpawnPositions(FieldState state, TrapRound round)
	{
		state.pendingSpawnPositions.Clear();
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (mainEntity == null)
		{
			return;
		}
		Vector3 physicsPosition = mainEntity.GetCompTransform().physicsPosition;
		int randomCount = round.GetRandomCount();
		if (round is TrackTrapRound trackTrapRound)
		{
			CalculateTrackSpawnPositions(state, physicsPosition, trackTrapRound.CharacterDisMin, trackTrapRound.CharacterDisMax, randomCount);
		}
		else
		{
			if (!(round is RandomTrapRound))
			{
				return;
			}
			for (int i = 0; i < randomCount; i++)
			{
				Vector3 randomPositionInBounds = GetRandomPositionInBounds();
				for (int j = 0; j < 10; j++)
				{
					if (!IsPositionTooClose(randomPositionInBounds, state.pendingSpawnPositions, 1f) && !IsPositionConflictWithAlwaysRandom(randomPositionInBounds, 1f))
					{
						break;
					}
					randomPositionInBounds = GetRandomPositionInBounds();
				}
				state.pendingSpawnPositions.Add(randomPositionInBounds);
			}
		}
	}

	private void CalculateTrackSpawnPositions(FieldState state, Vector3 characterPos, float disMin, float disMax, int totalCount)
	{
		float num = _fieldBounds.min.x + _config.Radius;
		float num2 = _fieldBounds.max.x - _config.Radius;
		float num3 = characterPos.x - disMax;
		float num4 = characterPos.x - disMin;
		float num5 = characterPos.x + disMin;
		float num6 = characterPos.x + disMax;
		bool flag = num4 > num && num3 < num2;
		bool flag2 = num6 > num && num5 < num2;
		int num7 = 0;
		int num8 = 0;
		if (flag & flag2)
		{
			num7 = UnityEngine.Random.Range(0, totalCount + 1);
			num8 = totalCount - num7;
		}
		else if (flag)
		{
			num7 = totalCount;
		}
		else if (flag2)
		{
			num8 = totalCount;
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"交互物{entity},角色位置{characterPos},boundsMinX{num}, boundsMaxX{num2}, leftRangeMin{num3}, leftRangeMax{num4}, rightRangeMin{num5}, rightRangeMax{num6}, 弱追踪落雷的左右生成区域都不在bounds的范围内？？？此时不生成落雷");
		}
		if ((num7 > 0) & flag)
		{
			float num9 = Mathf.Max(num3, num);
			float num10 = Mathf.Min(num4, num2);
			if (num10 > num9)
			{
				for (int i = 0; i < num7; i++)
				{
					Vector3? vector = TryGetTrackSpawnPositionInRange(state, num9, num10);
					if (vector.HasValue)
					{
						state.pendingSpawnPositions.Add(vector.Value);
					}
				}
			}
		}
		if (!((num8 > 0) & flag2))
		{
			return;
		}
		float num11 = Mathf.Max(num5, num);
		float num12 = Mathf.Min(num6, num2);
		if (!(num12 > num11))
		{
			return;
		}
		for (int j = 0; j < num8; j++)
		{
			Vector3? vector2 = TryGetTrackSpawnPositionInRange(state, num11, num12);
			if (vector2.HasValue)
			{
				state.pendingSpawnPositions.Add(vector2.Value);
			}
		}
	}

	private Vector3? TryGetTrackSpawnPositionInRange(FieldState state, float xMin, float xMax)
	{
		for (int i = 0; i < 10; i++)
		{
			float x = UnityEngine.Random.Range(xMin, xMax);
			float bulletConstZ = _data.BulletConstZ;
			float randomY = GetRandomY();
			Vector3 randomPos = new Vector3(x, randomY, bulletConstZ);
			Vector3 finalPositionByRaycast = GetFinalPositionByRaycast(randomPos);
			if (!IsPositionTooClose(finalPositionByRaycast, state.pendingSpawnPositions, 1f) && !IsPositionConflictWithAlwaysRandom(finalPositionByRaycast, 1f))
			{
				return finalPositionByRaycast;
			}
		}
		return null;
	}

	private bool IsPositionConflictWithAlwaysRandom(Vector3 pos, float minDistance)
	{
		if (_alwaysRandomState != null && IsPositionTooClose(pos, _alwaysRandomState.pendingSpawnPositions, minDistance))
		{
			return true;
		}
		return false;
	}

	private bool IsPositionConflictWithAllThunders(Vector3 pos, float minDistance)
	{
		if (_fieldState != null && IsPositionTooClose(pos, _fieldState.pendingSpawnPositions, minDistance))
		{
			return true;
		}
		return false;
	}

	private void MoveToNextAlwaysRandomRound(AlwaysRandomRoundState state)
	{
		state.roundIndex++;
		if (state.roundIndex >= _data.RandomTrapRounds.Length)
		{
			state.roundIndex = 0;
		}
		state.roundTimer = 0f;
		state.intervalTimer = 0f;
		state.hasAttacked = false;
		state.hasSpawnedEffects = false;
		state.isWaitingForInterval = false;
		state.currentIntervalTime = 0f;
		state.pendingSpawnPositions.Clear();
	}

	private void MoveToNextRound(FieldState state)
	{
		state.currentRoundIndex++;
		if (state.currentRoundIndex >= _data.Rounds.Length)
		{
			state.currentRoundIndex = 0;
		}
		state.roundTimer = 0f;
		state.intervalTimer = 0f;
		state.hasAttacked = false;
		state.hasSpawnedEffects = false;
		state.isWaitingForInterval = false;
		state.pendingSpawnPositions.Clear();
	}

	private void UpdateAlwaysRandomLogic(AlwaysRandomRoundState state, float dt)
	{
		if (_data.RandomTrapRounds == null || _data.RandomTrapRounds.Length == 0)
		{
			return;
		}
		if (state.roundIndex >= _data.RandomTrapRounds.Length)
		{
			state.roundIndex = 0;
		}
		RandomTrapRound randomTrapRound = _data.RandomTrapRounds[state.roundIndex];
		if (state.isWaitingForInterval)
		{
			state.intervalTimer += dt;
			if (state.intervalTimer >= state.currentIntervalTime)
			{
				MoveToNextAlwaysRandomRound(state);
			}
			return;
		}
		if (state.pendingSpawnPositions.Count == 0)
		{
			state.currentIntervalTime = randomTrapRound.GetRandomIntervalTime();
			CalculateAlwaysRandomSpawnPositions(state, randomTrapRound);
		}
		if (!state.hasSpawnedEffects && state.pendingSpawnPositions.Count > 0)
		{
			foreach (Vector3 pendingSpawnPosition in state.pendingSpawnPositions)
			{
				SpawnEffect(pendingSpawnPosition);
			}
			state.hasSpawnedEffects = true;
		}
		state.roundTimer += dt;
		if (!state.hasAttacked && state.roundTimer >= _damageWaitingTime && state.pendingSpawnPositions.Count > 0)
		{
			foreach (Vector3 pendingSpawnPosition2 in state.pendingSpawnPositions)
			{
				DoAttackAtPosition(pendingSpawnPosition2);
			}
			state.hasAttacked = true;
		}
		float num = _damageWaitingTime + 1f;
		if (state.roundTimer >= num)
		{
			state.isWaitingForInterval = true;
			state.intervalTimer = 0f;
		}
	}

	private void CalculateAlwaysRandomSpawnPositions(AlwaysRandomRoundState state, RandomTrapRound round)
	{
		state.pendingSpawnPositions.Clear();
		int randomCount = round.GetRandomCount();
		for (int i = 0; i < randomCount; i++)
		{
			Vector3 randomPositionInBounds = GetRandomPositionInBounds();
			for (int j = 0; j < 10; j++)
			{
				if (!IsPositionTooClose(randomPositionInBounds, state.pendingSpawnPositions, 1f) && !IsPositionConflictWithAllThunders(randomPositionInBounds, 1f))
				{
					break;
				}
				randomPositionInBounds = GetRandomPositionInBounds();
			}
			state.pendingSpawnPositions.Add(randomPositionInBounds);
		}
	}

	private Bounds GetFieldBounds()
	{
		MixedBox field = _data.Field;
		Vector3 center = transform.TransformPoint(field.localPos + field.center);
		Vector3 size = Vector3.Scale(field.size, field.localScale);
		return new Bounds(center, size);
	}

	private float GetRandomY()
	{
		return _fieldBounds.min.y + UnityEngine.Random.Range(_data.YMin, _data.YMax);
	}

	private Vector3 GetRandomPositionInBounds()
	{
		float minInclusive = _fieldBounds.min.x + _config.Radius;
		float maxInclusive = _fieldBounds.max.x - _config.Radius;
		float x = UnityEngine.Random.Range(minInclusive, maxInclusive);
		float bulletConstZ = _data.BulletConstZ;
		float randomY = GetRandomY();
		Vector3 randomPos = new Vector3(x, randomY, bulletConstZ);
		return GetFinalPositionByRaycast(randomPos);
	}

	private Vector3 GetFinalPositionByRaycast(Vector3 randomPos)
	{
		Vector3 center = randomPos + Vector3.up * 30f;
		Vector3 down = Vector3.down;
		float maxDistance = 30f;
		Collider collider = null;
		if (BloodThunderCeiling.TryGetBloodThunderCeilingHit(randomPos, 30f, out var ceilingHit))
		{
			center = ceilingHit.point;
			maxDistance = ceilingHit.distance;
			collider = ceilingHit.collider;
		}
		Vector3 halfExtents = new Vector3(_config.Radius, 0.1f, _config.Radius);
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		int num = Physics.BoxCastNonAlloc(center, halfExtents, down, cacheHits, Quaternion.identity, maxDistance, BattleConsts.enviromentMask);
		float num2 = float.MaxValue;
		Vector3 result = randomPos;
		for (int i = 0; i < num; i++)
		{
			RaycastHit raycastHit = cacheHits[i];
			if (!(raycastHit.collider == collider) && !(raycastHit.distance >= num2))
			{
				num2 = raycastHit.distance;
				result = raycastHit.point;
			}
		}
		PhysicsUtility.Release(cacheHits);
		if (num2 < float.MaxValue)
		{
			result.z = _data.BulletConstZ;
			return result;
		}
		return randomPos;
	}

	private bool IsPositionTooClose(Vector3 pos, List<Vector3> existingPositions, float minDistance)
	{
		foreach (Vector3 existingPosition in existingPositions)
		{
			if (Mathf.Abs(pos.x - existingPosition.x) < minDistance)
			{
				return true;
			}
		}
		return false;
	}

	private void SpawnEffect(Vector3 pos)
	{
		if (_bloodThunderEffectsID != null && _bloodThunderEffectsID.Length != 0)
		{
			int num = UnityEngine.Random.Range(0, _bloodThunderEffectsID.Length);
			YooAssetReference yooAssetReference = _bloodThunderEffectsID[num];
			if (yooAssetReference.RuntimeKeyIsValid())
			{
				EffectPoint point = new EffectPoint
				{
					type = EffectPoint.EffectPointType.ConstPoint,
					constPointPos = null,
					continueouslyFollow = false,
					rotateFollowLogicDir = false,
					offset = default,
					rotateOffset = default,
					useOwnerRot = false,
					oriRotX = 0f,
					oriRotY = 0f,
					oriRotZ = 0f,
					aimTarget = false
				};
				SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
				{
					target = FindTargetResult.EntityOnly(_attackEntity),
					patternAssetID = yooAssetReference,
					constPointPos = pos,
					removeWhenMotionExit = false,
					timescale = TimeScale.Owner,
					type = EffectDataType.Point,
					point1 = point,
					point2 = default,
					removeWhenStop = false,
					changeScale = false,
					effectRangeEnum = EffectRangeEnum.none,
					transformScaleMulBase = default,
					modelType = EffectModelType.Small,
					isChangeWithEntity = false,
					initRotation = default,
					isAttach = false,
					motioState = MotionState.None,
					xMirror = false,
					warningEffectTime = 0f,
					exclusivePriority = false,
					priority = 0
				};
				GameManager.effectSystem.FireEffect(effectParams);
			}
		}
	}

	private void DoAttackAtPosition(Vector3 position)
	{
		if (_config == null || !_attackEntity.IsValid)
		{
			return;
		}
		Entity attackEntity = _attackEntity;
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		FindTargetAtPosition(attackEntity, position, list);
		WhereTargets whereTargets = new WhereTargets
		{
			canBeAttack = _config.CanBeAttack,
			FilterEntityType = _config.FilterEntityType,
			alliance = GameUtility.GetAlliance(_config.Alliance, attackEntity.GetAlliance())
		};
		whereTargets.FindTargets(list, attackEntity);
		foreach (FindTargetResult item in list)
		{
			SystemAbility.DoActions(attackEntity, attackEntity, item, null, null, _config.OnTriggerEnter);
		}
		ListPool<FindTargetResult>.Release(list);
	}

	private void FindTargetAtPosition(Entity owner, Vector3 position, List<FindTargetResult> results)
	{
		BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get(results.Count);
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		Vector3 center = position + Vector3.up * 30f / 2f;
		Vector3 vector = new Vector3(_config.Radius * 2f, 30f, _config.Radius * 2f);
		int num = Physics.OverlapBoxNonAlloc(center, vector / 2f, cacheColliders, Quaternion.Euler(Vector3.up), BattleConsts.hitMask);
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				BaseFindTargetsByArea.AddTargetByCollider(position, cacheColliders[i], bSet);
			}
		}
		bSet.Compress();
		foreach (FindTargetResult item in bSet)
		{
			if (CheckTarget(item, owner))
			{
				results.Add(item);
			}
		}
		PhysicsUtility.Release(cacheColliders);
		BSetPool<FindTargetResult>.Default.Recycle(bSet);
	}

	private bool CheckTarget(FindTargetResult result, Entity owner)
	{
		if (result.damageable != null)
		{
			return true;
		}
		Entity entity = result.entity;
		if (!entity.IsValid)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("collider的MonoEntity中的entity为空，无法判断 entity 的类别和阵营");
			}
			return false;
		}
		if (!entity.IsLogicAvailable())
		{
			return false;
		}
		if ((entity.GetAlliance() & GameUtility.GetAlliance(_config.Alliance, owner.GetAlliance())) == 0)
		{
			return false;
		}
		if (!_config.FilterEntityType.HasEntityType(entity.GetEntityType()))
		{
			return false;
		}
		return true;
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == -1;
		}
		return true;
	}

	protected override void HandleInitState(int stateId)
	{
		base.HandleInitState(stateId);
		if (stateId == 0 || stateId == -1)
		{
			_fieldState?.Reset();
			_alwaysRandomState?.Reset();
		}
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!_attackEntity.IsValid)
		{
			return;
		}
		if (_attackEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(_attackEntity);
			return;
		}
		await UniTask.WaitUntil(() => _attackEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(_attackEntity);
	}

	public override void ReleaseStateObject()
	{
		OnDestroy();
		ReleaseAttackEntity().Forget();
		base.ReleaseStateObject();
	}

	private void OnDestroy()
	{
		_tokenSource?.Cancel();
		_tokenSource?.Dispose();
		_tokenSource = null;
		_syncAttackablePositionDisposable?.Dispose();
		if (_root != null)
		{
			UnityEngine.Object.Destroy(_root);
		}
		_fieldState = null;
		_alwaysRandomState = null;
	}
}
