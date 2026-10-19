using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinBloodThunder : BaseAbilityMixin
{
	private ConfigMixinBloodThunder m_Config;

	private Vector3 m_SpawnPos;

	private float m_RoundTimer;

	private bool m_HasResolvedPos;

	private bool m_HasSpawnedEffect;

	private bool m_HasAttacked;

	private bool m_HasFinished;

	private const float DamageWaitingTime = 2.5f;

	private const float TwinkleTime = 1f;

	private const float RayDistance = 30f;

	public AbilityMixinBloodThunder(ConfigMixinBloodThunder config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void RebindForPool(ConfigMixin config, Ability ab, byte newIndex)
	{
		base.RebindForPool(config, ab, newIndex);
		m_Config = (ConfigMixinBloodThunder)config;
	}

	internal override void ResetForPool()
	{
		m_Config = null;
		m_SpawnPos = default;
		m_RoundTimer = 0f;
		m_HasResolvedPos = false;
		m_HasSpawnedEffect = false;
		m_HasAttacked = false;
		m_HasFinished = false;
		base.ResetForPool();
	}

	internal override void OnAdd()
	{
		m_RoundTimer = 0f;
		m_HasResolvedPos = false;
		m_HasSpawnedEffect = false;
		m_HasAttacked = false;
		m_HasFinished = false;
		TryResolveSpawnPosAndSpawnEffect();
	}

	internal override void FixedUpdate()
	{
		if (m_HasFinished || m_Config == null)
		{
			return;
		}
		if (!m_HasResolvedPos)
		{
			TryResolveSpawnPosAndSpawnEffect();
			if (!m_HasResolvedPos)
			{
				return;
			}
		}
		float fixedDeltaTime = owner.GetCompTime().fixedDeltaTime;
		m_RoundTimer += fixedDeltaTime;
		if (!m_HasAttacked && m_RoundTimer >= 2.5f)
		{
			DoAttackAtPosition(m_SpawnPos);
			m_HasAttacked = true;
		}
		float num = 3.5f;
		if (m_RoundTimer >= num)
		{
			m_HasFinished = true;
			RemoveSelf();
		}
	}

	internal override void OnRemove()
	{
		m_HasFinished = true;
	}

	internal override void OnSilentRemove()
	{
		m_HasFinished = true;
	}

	private void TryResolveSpawnPosAndSpawnEffect()
	{
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!(mainEntity == null) && mainEntity.IsValid)
		{
			CompTransform compTransform = mainEntity.GetCompTransform();
			Vector3 footPos = compTransform.physicsPosition;
			if (PhysicsUtility.CapsuleCast(compTransform.colliderPosition, compTransform.size, Vector3.down, 30f, out var hit))
			{
				footPos = hit.point;
			}
			m_SpawnPos = GetFinalPositionByRaycast(footPos);
			m_HasResolvedPos = true;
			if (!m_HasSpawnedEffect)
			{
				SpawnEffect(m_SpawnPos);
				m_HasSpawnedEffect = true;
			}
		}
	}

	private Vector3 GetFinalPositionByRaycast(Vector3 footPos)
	{
		float num = 30f;
		float num2 = 1f;
		float z = footPos.z;
		Vector3 vector = new Vector3(footPos.x, footPos.y, z);
		Vector3 center = vector + Vector3.up * num;
		Collider collider = null;
		if (BloodThunderCeiling.TryGetBloodThunderCeilingHit(footPos, 30f, out var ceilingHit))
		{
			center = ceilingHit.point;
			num = ceilingHit.distance;
			collider = ceilingHit.collider;
		}
		Vector3 halfExtents = new Vector3(num2, 0.1f, num2);
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		int num3 = Physics.BoxCastNonAlloc(center, halfExtents, Vector3.down, cacheHits, Quaternion.identity, num, BattleConsts.enviromentMask);
		float num4 = float.MaxValue;
		Vector3 result = vector;
		for (int i = 0; i < num3; i++)
		{
			RaycastHit raycastHit = cacheHits[i];
			if (!(raycastHit.collider == collider) && !(raycastHit.distance >= num4))
			{
				num4 = raycastHit.distance;
				result = raycastHit.point;
			}
		}
		PhysicsUtility.Release(cacheHits);
		result.z = z;
		return result;
	}

	private void SpawnEffect(Vector3 pos)
	{
		if (m_Config.bloodThunderEffectsID != null && m_Config.bloodThunderEffectsID.Length != 0)
		{
			int num = Random.Range(0, m_Config.bloodThunderEffectsID.Length);
			YooAssetReference yooAssetReference = m_Config.bloodThunderEffectsID[num];
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
					target = FindTargetResult.EntityOnly(owner),
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
		if (!owner.IsValid)
		{
			return;
		}
		Entity entity = owner;
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		FindTargetAtPosition(position, list);
		WhereTargets whereTargets = new WhereTargets
		{
			canBeAttack = m_Config.whereTargets.canBeAttack,
			FilterEntityType = m_Config.whereTargets.FilterEntityType,
			alliance = GameUtility.GetAlliance(m_Config.allianceCondition, entity.GetAlliance())
		};
		whereTargets.FindTargets(list, entity);
		foreach (FindTargetResult item in list)
		{
			SystemAbility.DoActions(caster, entity, item, null, ability, m_Config.configActions);
		}
		ListPool<FindTargetResult>.Release(list);
	}

	private void FindTargetAtPosition(Vector3 position, List<FindTargetResult> results)
	{
		BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get(results.Count);
		float num = 1f;
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		Vector3 center = position + Vector3.up * 30f / 2f;
		Vector3 vector = new Vector3(num * 2f, 30f, num * 2f);
		int num2 = Physics.OverlapBoxNonAlloc(center, vector / 2f, cacheColliders, Quaternion.Euler(Vector3.up), BattleConsts.hitMask);
		if (num2 > 0)
		{
			for (int i = 0; i < num2; i++)
			{
				BaseFindTargetsByArea.AddTargetByCollider(position, cacheColliders[i], bSet);
			}
		}
		bSet.Compress();
		foreach (FindTargetResult item in bSet)
		{
			results.Add(item);
		}
		PhysicsUtility.Release(cacheColliders);
		BSetPool<FindTargetResult>.Default.Recycle(bSet);
	}

	private void RemoveSelf()
	{
		if (owner.IsValid)
		{
			owner.GetCompAbility()?.RemoveAbility(ability.config.name);
		}
	}
}
