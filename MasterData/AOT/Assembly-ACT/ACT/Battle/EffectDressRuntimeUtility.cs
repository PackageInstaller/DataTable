using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.Game.Data;
using Bamboo.ECS;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public static class EffectDressRuntimeUtility
{
	private interface IEffectDressRuntimeOwner
	{
		bool IsValid { get; }

		int RoleId { get; }

		Transform Root { get; }

		MonoEntity MonoEntity { get; }

		Entity Entity { get; }

		int CurrentEffectDressId { get; }

		bool UseSystemEffect { get; }
	}

	private readonly struct EntityEffectDressOwner(Entity owner) : IEffectDressRuntimeOwner
	{
		private readonly Entity _owner = owner;

		public bool IsValid => CanUseEntity(_owner);

		public Transform Root => _owner.GetRootTransform();

		public MonoEntity MonoEntity => _owner.GetMono();

		public Entity Entity => _owner;

		public bool UseSystemEffect => true;

		public int RoleId
		{
			get
			{
				if (!_owner.TryGetCompCharacter(out CompCharacter component))
				{
					return 0;
				}
				return component.characterSource?.Id() ?? 0;
			}
		}

		public int CurrentEffectDressId
		{
			get
			{
				if (!_owner.TryGetCompCharacter(out CompCharacter component) || !(component.characterSource is Character character))
				{
					return 0;
				}
				return character.EffectDressId;
			}
		}
	}

	private readonly struct ModelEffectDressOwner(int roleId, int currentEffectDressId, GameObject modelPrefab, MonoEntity monoEntity) : IEffectDressRuntimeOwner
	{
		private readonly int _roleId = roleId;

		private readonly int _currentEffectDressId = currentEffectDressId;

		private readonly GameObject _modelPrefab = modelPrefab;

		private readonly MonoEntity _monoEntity = monoEntity;

		public bool IsValid
		{
			get
			{
				if (_modelPrefab != null)
				{
					return _monoEntity != null;
				}
				return false;
			}
		}

		public int RoleId => _roleId;

		public Transform Root
		{
			get
			{
				if (!(_modelPrefab != null))
				{
					return null;
				}
				return _modelPrefab.transform;
			}
		}

		public MonoEntity MonoEntity => _monoEntity;

		public Entity Entity => default;

		public int CurrentEffectDressId => _currentEffectDressId;

		public bool UseSystemEffect => false;
	}

	private const float ModelFootprintMoveDistance = 2f;

	private const float ModelFootprintMoveDuration = 0.5f;

	private static Transform ResolveAttachPoint(IEffectDressRuntimeOwner owner, EffectDressConfigItem config)
	{
		if (string.IsNullOrEmpty(config.attachPoint))
		{
			if (config.runtimeType != EffectDressRuntimeType.PersistentFollow && config.runtimeType != EffectDressRuntimeType.PersistentTrail)
			{
				return null;
			}
			return owner.Root;
		}
		if (owner.MonoEntity != null && owner.MonoEntity.TryGetAttachPoint(config.attachPoint, out var attackPoint))
		{
			return attackPoint;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"EffectDress {config.dressId} attachPoint {config.attachPoint} missing on role {owner.RoleId}");
		}
		return null;
	}

	private static void SetLayerRecursive(GameObject go, int layer)
	{
		if ((bool)go)
		{
			go.layer = layer;
			Transform transform = go.transform;
			for (int i = 0; i < transform.childCount; i++)
			{
				SetLayerRecursive(transform.GetChild(i).gameObject, layer);
			}
		}
	}

	private static void ApplySystemModelTrailVelocity(GameObject go, EffectDressConfigItem config)
	{
		if ((bool)go && config != null && config.overrideSystemModelTrailVelocity)
		{
			ParticleSystemSimulationSpace space = (config.useWorldSpaceTrailVelocity ? ParticleSystemSimulationSpace.World : ParticleSystemSimulationSpace.Local);
			ParticleSystem[] componentsInChildren = go.GetComponentsInChildren<ParticleSystem>(includeInactive: true);
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				ParticleSystem.VelocityOverLifetimeModule velocityOverLifetime = componentsInChildren[i].velocityOverLifetime;
				velocityOverLifetime.enabled = true;
				velocityOverLifetime.space = space;
				velocityOverLifetime.x = new ParticleSystem.MinMaxCurve(config.systemModelTrailVelocity.x);
				velocityOverLifetime.y = new ParticleSystem.MinMaxCurve(config.systemModelTrailVelocity.y);
				velocityOverLifetime.z = new ParticleSystem.MinMaxCurve(config.systemModelTrailVelocity.z);
			}
		}
	}

	private static bool IsEffectValid(YooAssetReference effect)
	{
		if (effect != null)
		{
			return !string.IsNullOrEmpty(effect.GUID);
		}
		return false;
	}

	private static bool CanUseEntity(Entity entity)
	{
		if (entity.IsValid && entity.HasCompBehave() && entity.HasCompCharacter())
		{
			return entity.HasCompEffect();
		}
		return false;
	}

	private static EffectDressRuntime CreateRuntime(IEffectDressRuntimeOwner owner, EffectDressRuntimeState state, EffectDressConfigItem config, int version)
	{
		switch (config.runtimeType)
		{
		case EffectDressRuntimeType.PersistentFollow:
			if (!owner.UseSystemEffect)
			{
				return CreateAttachedRuntime(owner, state, config, version, applyCharacterUISceneLayer: true);
			}
			return CreatePersistentFollow(owner, config, version);
		case EffectDressRuntimeType.PersistentTrail:
			return CreateAttachedRuntime(owner, state, config, version, !owner.UseSystemEffect);
		case EffectDressRuntimeType.MotionFootprint:
			return CreateMotionRuntime(config, version);
		default:
			return null;
		}
	}

	private static EffectDressRuntime CreatePersistentFollow(IEffectDressRuntimeOwner owner, EffectDressConfigItem config, int version)
	{
		if (!IsEffectValid(config.effect))
		{
			return null;
		}
		SystemEffect.EffectParams effectParams = new SystemEffect.EffectParams
		{
			target = FindTargetResult.EntityOnly(owner.Entity),
			patternAssetID = config.effect,
			timescale = ((!config.useOwnerTimeScale) ? TimeScale.NoScale : TimeScale.Owner),
			type = EffectDataType.Point,
			point1 = new EffectPoint
			{
				type = ((!string.IsNullOrEmpty(config.attachPoint)) ? EffectPoint.EffectPointType.AttachPoint : EffectPoint.EffectPointType.Character),
				attachPoint = config.attachPoint,
				activeWithAttachPoint = config.activeWithAttachPoint,
				offset = config.localPosition,
				rotateOffset = config.localEulerAngles,
				continueouslyFollow = true
			},
			isAttach = true,
			isChangeWithEntity = true
		};
		EffectRuntimeItem effectRuntimeItem = GameManager.effectSystem.FireEffect(effectParams);
		return new EffectDressRuntime
		{
			dressId = config.dressId,
			dressType = config.dressType,
			runtimeType = config.runtimeType,
			version = version,
			config = config,
			effectRuntimeItem = effectRuntimeItem
		};
	}

	private static EffectDressRuntime CreateAttachedRuntime(IEffectDressRuntimeOwner owner, EffectDressRuntimeState state, EffectDressConfigItem config, int version, bool applyCharacterUISceneLayer)
	{
		if (!IsEffectValid(config.effect))
		{
			return null;
		}
		Transform transform = ResolveAttachPoint(owner, config);
		if (transform == null)
		{
			return null;
		}
		EffectDressRuntime runtime = new EffectDressRuntime
		{
			dressId = config.dressId,
			dressType = config.dressType,
			runtimeType = config.runtimeType,
			version = version,
			config = config,
			attachPoint = transform,
			effect = config.effect,
			attachPointName = config.attachPoint
		};
		InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(config.effect.GUID);
		if (instanceHandle == null)
		{
			return null;
		}
		runtime.instanceHandle = instanceHandle;
		instanceHandle.Completed += (InstanceHandle completed) =>
		{
			if (!owner.IsValid || !IsRuntimeCurrent(state, runtime, config.dressId) || !completed.IsValid || completed.Result == null)
			{
				if (completed.IsValid)
				{
					PrecacheManager.Instance.ReleaseInstanceHandle(completed);
				}
			}
			else
			{
				runtime.instance = completed.Result;
				Transform transform2 = runtime.instance.transform;
				transform2.SetParent(runtime.attachPoint, worldPositionStays: false);
				transform2.localPosition = config.localPosition;
				transform2.localRotation = Quaternion.Euler(config.localEulerAngles);
				transform2.localScale = ((config.localScale == Vector3.zero) ? Vector3.one : config.localScale);
				if (applyCharacterUISceneLayer)
				{
					SetLayerRecursive(runtime.instance, 22);
				}
				if (!owner.UseSystemEffect && config.runtimeType == EffectDressRuntimeType.PersistentTrail)
				{
					ApplySystemModelTrailVelocity(runtime.instance, config);
				}
			}
		};
		return runtime;
	}

	private static EffectDressRuntime CreateMotionRuntime(EffectDressConfigItem config, int version)
	{
		if (!IsEffectValid(config.effect) || string.IsNullOrEmpty(config.cueKey))
		{
			return null;
		}
		return new EffectDressRuntime
		{
			dressId = config.dressId,
			dressType = config.dressType,
			runtimeType = config.runtimeType,
			version = version,
			config = config,
			cueKey = config.cueKey,
			effect = config.effect,
			attachPointName = config.attachPoint,
			motionSpawnMode = config.motionSpawnMode,
			systemAnimatorStateHash = ((!string.IsNullOrEmpty(config.systemAnimatorStateName)) ? Animator.StringToHash(config.systemAnimatorStateName) : 0),
			systemCueLayerIndex = config.systemCueLayerIndex,
			systemCueNormalizedTimes = BuildSystemCueNormalizedTimes(config)
		};
	}

	private static float[] BuildSystemCueNormalizedTimes(EffectDressConfigItem config)
	{
		if (config.systemCueNormalizedTimes == null || config.systemCueNormalizedTimes.Length == 0)
		{
			return null;
		}
		float[] array = new float[config.systemCueNormalizedTimes.Length];
		for (int i = 0; i < config.systemCueNormalizedTimes.Length; i++)
		{
			array[i] = Mathf.Clamp01(config.systemCueNormalizedTimes[i]);
		}
		Array.Sort(array);
		return array;
	}

	public static void SyncDressFromCharacter(Entity owner)
	{
		if (CanUseEntity(owner) && owner.TryGetCompEffect(out CompEffect component))
		{
			SyncDress(new EntityEffectDressOwner(owner), component.EffectDressState);
		}
	}

	public static void SyncDressForModel(int roleId, int currentEffectDressId, GameObject modelPrefab, MonoEntity monoEntity, EffectDressRuntimeState state)
	{
		SyncDress(new ModelEffectDressOwner(roleId, currentEffectDressId, modelPrefab, monoEntity), state);
	}

	public static void SyncActiveEntityByRoleId(int roleId)
	{
		if (roleId == 0 || GameManager.entities == null)
		{
			return;
		}
		GameManager.entities.ForEachEntities((Entity entity) =>
		{
			if (CanUseEntity(entity) && entity.TryGetCompCharacter(out CompCharacter component))
			{
				ICharacterSource characterSource = component.characterSource;
				if (characterSource != null && characterSource.Id() == roleId)
				{
					SyncDressFromCharacter(entity);
				}
			}
		});
	}

	public static void SyncAllActiveCharacterEntities()
	{
		if (GameManager.entities == null)
		{
			return;
		}
		GameManager.entities.ForEachEntities((Entity entity) =>
		{
			if (CanUseEntity(entity) && entity.HasCompCharacter())
			{
				SyncDressFromCharacter(entity);
			}
		});
	}

	public static void ClearDress(Entity owner, int dressId)
	{
		if (CanUseEntity(owner) && owner.TryGetCompEffect(out CompEffect component))
		{
			ClearDress(component.EffectDressState, dressId);
		}
	}

	public static void ClearDressType(Entity owner, int dressType)
	{
		if (CanUseEntity(owner) && owner.TryGetCompEffect(out CompEffect component) && component.EffectDressState.activeDressIdByDressType.TryGetValue(dressType, out var value))
		{
			ClearDress(component.EffectDressState, value);
		}
	}

	public static void ClearAll(Entity owner)
	{
		if (owner.IsValid && owner.TryGetCompEffect(out CompEffect component))
		{
			ClearAll(component.EffectDressState);
		}
	}

	public static void ClearAll(EffectDressRuntimeState state)
	{
		if (state == null)
		{
			return;
		}
		state.runtimeVersion++;
		List<int> list = ListPool<int>.Get();
		try
		{
			foreach (int key in state.activeRuntimes.Keys)
			{
				list.Add(key);
			}
			for (int i = 0; i < list.Count; i++)
			{
				if (state.activeRuntimes.TryGetValue(list[i], out var value))
				{
					ClearRuntime(value);
				}
			}
			state.activeRuntimes.Clear();
			state.activeDressIdByDressType.Clear();
		}
		finally
		{
			ListPool<int>.Release(list);
		}
	}

	public static void FireMotionCue(Entity owner, string cueKey)
	{
		if (!CanUseEntity(owner) || string.IsNullOrEmpty(cueKey) || !owner.TryGetCompEffect(out CompEffect component))
		{
			return;
		}
		foreach (EffectDressRuntime value in component.EffectDressState.activeRuntimes.Values)
		{
			if (value.runtimeType == EffectDressRuntimeType.MotionFootprint && string.Equals(value.cueKey, cueKey, StringComparison.Ordinal))
			{
				FireMotionCueRuntime(owner, value);
			}
		}
	}

	public static void FireMotionCueForModel(GameObject modelPrefab, MonoEntity monoEntity, EffectDressRuntimeState state, string cueKey)
	{
		if (modelPrefab == null || monoEntity == null || state == null || string.IsNullOrEmpty(cueKey))
		{
			return;
		}
		foreach (EffectDressRuntime value in state.activeRuntimes.Values)
		{
			if (value.runtimeType == EffectDressRuntimeType.MotionFootprint && string.Equals(value.cueKey, cueKey, StringComparison.Ordinal))
			{
				FireModelMotionCueRuntime(modelPrefab, monoEntity, state, value);
			}
		}
	}

	public static void ClearAllRuntime(EffectDressRuntimeState state)
	{
		List<int> list = ListPool<int>.Get();
		try
		{
			foreach (int key in state.activeRuntimes.Keys)
			{
				list.Add(key);
			}
			for (int i = 0; i < list.Count; i++)
			{
				if (state.activeRuntimes.TryGetValue(list[i], out var value))
				{
					ClearRuntime(value);
				}
			}
			state.activeRuntimes.Clear();
		}
		finally
		{
			ListPool<int>.Release(list);
		}
	}

	private static void FireMotionCueRuntime(Entity owner, EffectDressRuntime runtime)
	{
		EffectDressConfigItem config = runtime.config;
		if (config != null && IsEffectValid(config.effect))
		{
			ResolveMotionCueTransform(owner, config, out var position, out var rotation);
			GameManager.effectSystem.FireEffect(config.effect, position, rotation);
		}
	}

	private static void FireModelMotionCueRuntime(GameObject modelPrefab, MonoEntity monoEntity, EffectDressRuntimeState state, EffectDressRuntime runtime)
	{
		EffectDressConfigItem config = runtime.config;
		if (config == null || !IsEffectValid(config.effect) || !IsRuntimeCurrent(state, runtime, config.dressId))
		{
			return;
		}
		ResolveModelMotionCueTransform(modelPrefab, monoEntity, config, out var position, out var rotation);
		InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(config.effect.GUID);
		if (instanceHandle == null)
		{
			return;
		}
		AddMotionInstanceHandle(runtime, instanceHandle);
		instanceHandle.Completed += (InstanceHandle completed) =>
		{
			if (modelPrefab == null || monoEntity == null || !IsRuntimeCurrent(state, runtime, config.dressId) || !completed.IsValid || completed.Result == null)
			{
				RemoveMotionInstanceHandle(runtime, completed);
				if (completed.IsValid)
				{
					PrecacheManager.Instance.ReleaseInstanceHandle(completed);
				}
			}
			else
			{
				GameObject result = completed.Result;
				Transform transform = result.transform;
				transform.SetParent(modelPrefab.transform, worldPositionStays: true);
				transform.position = position;
				transform.rotation = rotation;
				transform.localScale = ((config.localScale == Vector3.zero) ? Vector3.one : config.localScale);
				(result.GetComponent<EffectDressFootprintMover>() ?? result.AddComponent<EffectDressFootprintMover>()).Play(completed, Vector3.back, 2f, 0.5f, () =>
				{
					RemoveMotionInstanceHandle(runtime, completed);
				});
			}
		};
	}

	private static void ResolveMotionCueTransform(Entity owner, EffectDressConfigItem config, out Vector3 position, out Quaternion rotation)
	{
		Transform rootTransform = owner.GetRootTransform();
		bool flag = owner.TryGetCompTransform(out CompTransform component);
		ResolveMotionCueTransform(ownerGroundPosition: flag ? component.physicsPosition : Vector3.zero, root: rootTransform, monoEntity: owner.GetMono(), hasOwnerGroundPosition: flag, config: config, position: out position, rotation: out rotation);
	}

	private static void ResolveModelMotionCueTransform(GameObject modelPrefab, MonoEntity monoEntity, EffectDressConfigItem config, out Vector3 position, out Quaternion rotation)
	{
		Transform transform = ((modelPrefab != null) ? modelPrefab.transform : null);
		ResolveMotionCueTransform(transform, monoEntity, (transform != null) ? transform.position : Vector3.zero, transform != null, config, out position, out rotation);
	}

	private static void ResolveMotionCueTransform(Transform root, MonoEntity monoEntity, Vector3 ownerGroundPosition, bool hasOwnerGroundPosition, EffectDressConfigItem config, out Vector3 position, out Quaternion rotation)
	{
		position = ((root != null) ? root.position : Vector3.zero);
		rotation = ((root != null) ? root.rotation : Quaternion.identity);
		if (monoEntity != null && !string.IsNullOrEmpty(config.attachPoint) && monoEntity.TryGetAttachPoint(config.attachPoint, out var attackPoint))
		{
			position = attackPoint.position;
			rotation = attackPoint.rotation;
		}
		if ((config.motionSpawnMode == EffectDressMotionSpawnMode.OwnerGround) & hasOwnerGroundPosition)
		{
			position = ownerGroundPosition;
		}
		if (config.motionSpawnMode == EffectDressMotionSpawnMode.GroundAtAttachPoint || config.motionSpawnMode == EffectDressMotionSpawnMode.OwnerGround)
		{
			float maxDistance = ((config.groundCheckLength > 0f) ? config.groundCheckLength : 20f);
			if (Physics.Raycast(position + Vector3.up * 0.2f, Vector3.down, out var hitInfo, maxDistance, BattleConsts.enviromentMask))
			{
				position = hitInfo.point;
				Vector3 forward = Vector3.ProjectOnPlane(rotation * Vector3.forward, hitInfo.normal);
				if (forward.sqrMagnitude > 0.0001f)
				{
					rotation = Quaternion.LookRotation(forward, hitInfo.normal);
				}
			}
		}
		position += rotation * config.localPosition;
		rotation *= Quaternion.Euler(config.localEulerAngles);
	}

	private static void ClearRuntime(EffectDressRuntime runtime)
	{
		if (runtime.effectRuntimeItem != null)
		{
			runtime.effectRuntimeItem.SetToBeRemove();
			GameManager.effectSystem.CleanEffect(runtime.effectRuntimeItem);
			if (runtime.effectRuntimeItem.instanceHandle != null && runtime.effectRuntimeItem.instanceHandle.IsValid)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(runtime.effectRuntimeItem.instanceHandle);
			}
		}
		if (runtime.instanceHandle != null && runtime.instanceHandle.IsValid)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(runtime.instanceHandle);
		}
		RecyclePooledMotionInstanceHandles(runtime);
		runtime.Reset();
	}

	private static void AddMotionInstanceHandle(EffectDressRuntime runtime, InstanceHandle handle)
	{
		if (runtime.motionInstanceHandles == null)
		{
			runtime.motionInstanceHandles = new List<InstanceHandle>();
		}
		runtime.motionInstanceHandles.Add(handle);
	}

	private static void RemoveMotionInstanceHandle(EffectDressRuntime runtime, InstanceHandle handle)
	{
		runtime.motionInstanceHandles?.Remove(handle);
	}

	public static void RecycleModelMotionCueInstances(EffectDressRuntimeState state)
	{
		if (state?.activeRuntimes == null)
		{
			return;
		}
		foreach (EffectDressRuntime value in state.activeRuntimes.Values)
		{
			RecyclePooledMotionInstanceHandles(value);
		}
	}

	private static void RecyclePooledMotionInstanceHandles(EffectDressRuntime runtime)
	{
		List<InstanceHandle> motionInstanceHandles = runtime.motionInstanceHandles;
		if (motionInstanceHandles == null)
		{
			return;
		}
		for (int num = motionInstanceHandles.Count - 1; num >= 0; num--)
		{
			InstanceHandle instanceHandle = motionInstanceHandles[num];
			if (instanceHandle != null && instanceHandle.IsValid)
			{
				EffectDressFootprintMover effectDressFootprintMover = ((instanceHandle.Result != null) ? instanceHandle.Result.GetComponent<EffectDressFootprintMover>() : null);
				if (effectDressFootprintMover != null)
				{
					effectDressFootprintMover.Recycle();
				}
				else
				{
					PrecacheManager.Instance.ReleaseInstanceHandle(instanceHandle);
				}
			}
		}
		motionInstanceHandles.Clear();
	}

	private static bool IsRuntimeCurrent(EffectDressRuntimeState state, EffectDressRuntime runtime, int dressId)
	{
		if (state.activeRuntimes.TryGetValue(dressId, out var value))
		{
			return value == runtime;
		}
		return runtime.version == state.runtimeVersion;
	}

	private static void SyncDress(IEffectDressRuntimeOwner owner, EffectDressRuntimeState state)
	{
		if (state == null || !owner.IsValid)
		{
			return;
		}
		List<int> list = ListPool<int>.Get();
		List<int> list2 = ListPool<int>.Get();
		try
		{
			int currentEffectDressId = owner.CurrentEffectDressId;
			if (currentEffectDressId != 0)
			{
				list.Add(currentEffectDressId);
			}
			foreach (int key in state.activeRuntimes.Keys)
			{
				list2.Add(key);
			}
			for (int i = 0; i < list2.Count; i++)
			{
				int num = list2[i];
				if (!list.Contains(num))
				{
					ClearDress(state, num);
				}
			}
			for (int j = 0; j < list.Count; j++)
			{
				int num2 = list[j];
				if (!state.activeRuntimes.ContainsKey(num2))
				{
					ApplyDressFromMeta(owner, state, num2);
				}
			}
		}
		finally
		{
			ListPool<int>.Release(list);
			ListPool<int>.Release(list2);
		}
	}

	private static void ClearDress(EffectDressRuntimeState state, int dressId)
	{
		if (state != null && state.activeRuntimes.TryGetValue(dressId, out var value))
		{
			state.runtimeVersion++;
			ClearRuntime(value);
			state.activeRuntimes.Remove(dressId);
			if (state.activeDressIdByDressType.TryGetValue(value.dressType, out var value2) && value2 == dressId)
			{
				state.activeDressIdByDressType.Remove(value.dressType);
			}
		}
	}

	private static void ApplyDressFromMeta(IEffectDressRuntimeOwner owner, EffectDressRuntimeState state, int dressId)
	{
		if (dressId != 0 && state != null)
		{
			state.runtimeVersion++;
			ConfigEffectDress configEffectDress = GameLoader.meta?.configEffectDress;
			if (!(configEffectDress == null) && configEffectDress.TryGetDress(dressId, out var config) && owner.IsValid && !state.activeRuntimes.ContainsKey(dressId) && (config.roleId == 0 || owner.RoleId == 0 || config.roleId == owner.RoleId))
			{
				ApplyDress(owner, state, dressId, config);
			}
		}
	}

	private static void ApplyDress(IEffectDressRuntimeOwner owner, EffectDressRuntimeState state, int dressId, EffectDressConfigItem config)
	{
		if (config != null && dressId != 0 && config.dressId == dressId)
		{
			if (state.activeDressIdByDressType.TryGetValue(config.dressType, out var value) && value != config.dressId)
			{
				ClearDress(state, value);
			}
			ClearDress(state, config.dressId);
			EffectDressRuntime effectDressRuntime = CreateRuntime(owner, state, config, state.runtimeVersion);
			if (effectDressRuntime != null)
			{
				state.activeRuntimes[config.dressId] = effectDressRuntime;
				state.activeDressIdByDressType[config.dressType] = config.dressId;
			}
		}
	}
}
