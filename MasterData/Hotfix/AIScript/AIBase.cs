using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript;

public abstract class AIBase
{
	protected GameObject _owner;

	protected AdventureSkill _skill;

	protected AdventureActor _actor;

	protected FP _attackRange;

	protected bool _canNormSkillDistance;

	public void OnInit(GameObject owner)
	{
		_owner = owner;
		if (_actor == null && owner != null)
		{
			_actor = owner.GetComponent<AdventureActor>();
		}
		if (_skill == null && owner != null)
		{
			_skill = owner.GetComponent<AdventureSkill>();
		}
		if (_actor == null && _skill != null)
		{
			_actor = _skill.actor;
		}
	}

	protected void StartCoroutine(ref CoroutineNode coroutineNode, IEnumerator enumerator)
	{
		if (!(_actor == null))
		{
			if (coroutineNode != null)
			{
				_actor.StopLogicCoroutine(coroutineNode);
			}
			coroutineNode = _actor.StartLogicCoroutine(enumerator, runImmediately: true);
		}
	}

	protected CoroutineNode StartCoroutine(IEnumerator enumerator)
	{
		if (!(_actor == null))
		{
			return _actor.StartLogicCoroutine(enumerator, runImmediately: true);
		}
		return null;
	}

	protected void StopCoroutine(ref CoroutineNode coroutineNode)
	{
		if (!(_actor == null))
		{
			if (coroutineNode != null)
			{
				_actor.StopLogicCoroutine(coroutineNode);
			}
			coroutineNode = null;
		}
	}

	protected void StopCoroutine(CoroutineNode coroutineNode)
	{
		if (!(_actor == null) && coroutineNode != null)
		{
			_actor.StopLogicCoroutine(coroutineNode);
		}
	}

	protected bool GetPerk(int perkId, FP cd = default(FP))
	{
		int dataID = _actor.dataID;
		if (_actor is MonsterAdventureActor { monsterSummonInfo: not null } monsterAdventureActor && monsterAdventureActor.monsterSummonInfo.SummonActor != null)
		{
			dataID = monsterAdventureActor.monsterSummonInfo.SummonActor.dataID;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(dataID, perkId, out var _))
		{
			return CheckPerkCd(perkId, cd);
		}
		return false;
	}

	protected virtual bool CheckPerkCd(long perkId, FP Cd)
	{
		return true;
	}

	protected bool CheckTalentLevel(int level)
	{
		return ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, level);
	}

	protected bool CheckProbability(FP _value)
	{
		return TSRandom.Range(0, 100) < _value;
	}
}
