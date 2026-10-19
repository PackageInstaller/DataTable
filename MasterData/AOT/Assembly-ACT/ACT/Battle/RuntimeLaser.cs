using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class RuntimeLaser
{
	public AllianceCondition alliance;

	public FilterEntityType filterEntityType = GameUtility.defaultFilterEntityType;

	private FilterCantBeAttackType filterCantBeAttackType;

	public bool canBeAttack;

	public ConfigAction[] onTriggerEnter;

	public ConfigAction[] onTriggerStay;

	public ConfigAction[] onTriggerExit;

	public Vector2 size;

	public Entity owner;

	public Ability ability;

	public Vector3 posOffset;

	public Vector3 directionOffset;

	public float maxLength;

	public float runtimeLength;

	public float radius;

	public LayerMask colliderLayer;

	public EffectRuntimeItem _effect;

	private List<FindTargetResult> _findTargetResults;

	private HashSet<FindTargetResult> _hashSet;

	public void OnInit()
	{
		_findTargetResults = ListPool<FindTargetResult>.Get();
		_hashSet = HashSetPool<FindTargetResult>.Get();
	}

	public void OnUnInit()
	{
		if (_findTargetResults != null)
		{
			foreach (FindTargetResult findTargetResult in _findTargetResults)
			{
				if (findTargetResult.IsValid)
				{
					SystemAbility.DoActions(owner, owner, findTargetResult, null, ability, onTriggerExit);
				}
			}
			_findTargetResults.Clear();
		}
		if (_hashSet != null)
		{
			HashSetPool<FindTargetResult>.Release(_hashSet);
			_hashSet = null;
		}
		if (_findTargetResults != null)
		{
			ListPool<FindTargetResult>.Release(_findTargetResults);
			_findTargetResults = null;
		}
		_effect.SetToBeRemove();
	}

	public void FixedUpdate()
	{
		List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
		FindTarget(owner, list);
		WhereTargets whereTargets = new WhereTargets
		{
			canBeAttack = canBeAttack,
			FilterEntityType = filterEntityType,
			alliance = GameUtility.GetAlliance(alliance, owner.GetCompAlliance().alliance)
		};
		whereTargets.FindTargets(list, (ability != null) ? ability.owner : owner);
		_hashSet.Clear();
		foreach (FindTargetResult findTargetResult in _findTargetResults)
		{
			_hashSet.Add(findTargetResult);
		}
		_findTargetResults.Clear();
		foreach (FindTargetResult item in list)
		{
			if (_hashSet.Remove(item))
			{
				SystemAbility.DoActions(owner, owner, item, null, ability, onTriggerStay);
			}
			else
			{
				SystemAbility.DoActions(owner, owner, item, null, ability, onTriggerEnter);
			}
			_findTargetResults.Add(item);
		}
		foreach (FindTargetResult item2 in _hashSet)
		{
			if (item2.IsValid)
			{
				SystemAbility.DoActions(owner, owner, item2, null, ability, onTriggerExit);
			}
		}
		ListPool<FindTargetResult>.Release(list);
	}

	private void FindTarget(Entity owner, List<FindTargetResult> results)
	{
		BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get(results.Count);
		float num = maxLength;
		Transform rootTransform = owner.GetRootTransform();
		Quaternion quaternion = rootTransform.rotation * Quaternion.Euler(0f, -90f, 0f) * Quaternion.Euler(directionOffset);
		Vector3 vector = rootTransform.position + quaternion * posOffset;
		Vector3 vector2 = quaternion * Vector3.forward;
		if (Physics.BoxCast(vector, size / 2f, vector2, out var hitInfo, quaternion, num, BattleConsts.enviromentMask))
		{
			num = (runtimeLength = hitInfo.distance);
		}
		Vector3 center = vector + vector2 * num / 2f;
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		Vector3 vector3 = new Vector3(size.x, size.y, num + 0.25f);
		int num2 = Physics.OverlapBoxNonAlloc(center, vector3 / 2f, cacheColliders, quaternion, BattleConsts.hitMask);
		if (num2 > 0)
		{
			for (int i = 0; i < num2; i++)
			{
				BaseFindTargetsByArea.AddTargetByCollider(rootTransform.position, cacheColliders[i], bSet);
			}
		}
		Alliance checkAlliance = GameUtility.GetAlliance(alliance, owner.GetCompAlliance().alliance);
		bSet.Compress();
		foreach (FindTargetResult item in bSet)
		{
			if (CheckFindTargetResult(item, checkAlliance))
			{
				results.Add(item);
			}
		}
		PhysicsUtility.Release(cacheColliders);
		BSetPool<FindTargetResult>.Default.Recycle(bSet);
	}

	private bool CheckFindTargetResult(FindTargetResult result, Alliance checkAlliance)
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
		if ((entity.GetCompAlliance().alliance & checkAlliance) == 0 || !filterEntityType.HasEntityType(entity.GetEntityType()))
		{
			return false;
		}
		return true;
	}

	public void Update()
	{
		if (_effect?.scripts == null)
		{
			return;
		}
		MonoEffect[] scripts = _effect.scripts;
		for (int i = 0; i < scripts.Length; i++)
		{
			if (scripts[i] is MonoRayEffect monoRayEffect)
			{
				monoRayEffect.maxLength = runtimeLength;
				monoRayEffect.radius = radius;
				monoRayEffect.colliderLayer = colliderLayer;
			}
		}
	}
}
