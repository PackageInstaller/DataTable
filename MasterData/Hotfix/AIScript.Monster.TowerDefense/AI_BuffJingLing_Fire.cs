using System.Collections;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class AI_BuffJingLing_Fire : TowerMonsterBaseAI
{
	private FP fireHeatDelta = 0.5;

	private FP heatTickInterval = 0.1;

	private Dictionary<long, CoroutineNode> _areaHeatCoroutines = new Dictionary<long, CoroutineNode>();

	private Dictionary<long, TowerDefenseCharacterActor> _heatedCharacters = new Dictionary<long, TowerDefenseCharacterActor>();

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> list = new List<PoolBranchesInfo>();
		PoolBranchesInfo poolBranchesInfo = new PoolBranchesInfo
		{
			index = 1
		};
		List<PoolBranchInfo> list2 = new List<PoolBranchInfo>();
		AdventureActor actor = _actor;
		FP cd = 999;
		FP initCd = 0;
		OperateDelegate operateIEnumerator = FireBuffSkillCast;
		list2.Add(new PoolBranchInfo(actor, 1001, 99, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
		StopAllHeatCoroutines();
	}

	private void OnAreaEffectEnterExit(IEvent evt)
	{
		if (evt is AdventureAreaEnterExitEvent adventureAreaEnterExitEvent && adventureAreaEnterExitEvent.owner == _actor && adventureAreaEnterExitEvent.sender is AreaEffectEntity && adventureAreaEnterExitEvent.triggerCollider != null && adventureAreaEnterExitEvent.triggerCollider.Entity is TowerDefenseCharacterActor towerDefenseCharacterActor)
		{
			if (adventureAreaEnterExitEvent.iEnter)
			{
				StartHeatCoroutine(towerDefenseCharacterActor);
			}
			else
			{
				StopHeatCoroutine(towerDefenseCharacterActor.Id);
			}
		}
	}

	private void StartHeatCoroutine(TowerDefenseCharacterActor character)
	{
		if (!(character == null))
		{
			StopHeatCoroutine(character.Id);
			character.buffComponent.AddBuff(TowerDefenseConfig.buffId_Fire_Strong, _actor);
			_heatedCharacters.set_Item(character.Id, character);
			_areaHeatCoroutines.set_Item(character.Id, _actor.StartLogicCoroutine(DoHeatTick(character)));
		}
	}

	private IEnumerator DoHeatTick(TowerDefenseCharacterActor character)
	{
		while (character != null && character.IsActive && !character.isDead)
		{
			character.UpdateFire(fireHeatDelta);
			yield return WaitTime(heatTickInterval);
		}
	}

	private void StopHeatCoroutine(long actorId)
	{
		if (_areaHeatCoroutines.TryGetValue(actorId, out var value))
		{
			_actor.StopLogicCoroutine(value);
			_areaHeatCoroutines.Remove(actorId);
		}
		if (_heatedCharacters.TryGetValue(actorId, out var value2))
		{
			value2?.buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_Fire_Strong);
			_heatedCharacters.Remove(actorId);
		}
	}

	private void StopAllHeatCoroutines()
	{
		foreach (CoroutineNode value in _areaHeatCoroutines.Values)
		{
			_actor.StopLogicCoroutine(value);
		}
		_areaHeatCoroutines.Clear();
		foreach (TowerDefenseCharacterActor value2 in _heatedCharacters.Values)
		{
			value2?.buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_Fire_Strong);
		}
		_heatedCharacters.Clear();
	}

	private IEnumerator FireBuffSkillCast()
	{
		PauseMove();
		CastSkill(8070401);
		yield return WaitSkillFinish();
		ResumeMove();
	}

	protected override IEnumerator DoAction(int index)
	{
		yield break;
	}
}
