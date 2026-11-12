using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Action_Summon_ActionStop_Phase_1 : MonsterActionBase
{
	private static readonly int Skill_Attack01 = 7000131;

	private CoroutineNode corKill;

	private int hpLockCount;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		hpLockCount = 1;
		_actor.LockHpAbs((int)_actor.actorHealthInfo.hpMax - hpLockCount);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		StopCoroutine(ref corKill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

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
		FP cd = 2;
		FP initCd = 0;
		OperateDelegate operateIEnumerator = Attack01;
		list2.Add(new PoolBranchInfo(actor, 1001, 1, cd, initCd, active: true, default, default, default, null, null, operateIEnumerator));
		poolBranchesInfo.braches = list2;
		list.Add(poolBranchesInfo);
		List<PoolBranchesInfo> poolBranches = list;
		InitPoolBranches(1, poolBranches);
	}

	private IEnumerator Attack01()
	{
		CastSkill(Skill_Attack01);
		yield return WaitSkillFinish();
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id)
		{
			hpLockCount++;
			if (hpLockCount < _actor.actorHealthInfo.hpMax + 1)
			{
				_actor.UnlockHp();
				_actor.LockHpAbs((int)_actor.actorHealthInfo.hpMax - hpLockCount);
			}
		}
	}
}
