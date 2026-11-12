using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50561CanDao;

public class Action_miniboss : AIBase
{
	private static readonly int skillId_throw = 5056112;

	private static readonly int skillCD_throw = 11;

	private static readonly int skillId_idle = 9999999;

	private static readonly int skillCD_idle = 1;

	private static readonly int skillId_born = 5056101;

	private static readonly int skillId_catch = 5056103;

	private static FP attackDistance = 99;

	private SkillPool _skillPool;

	private CoroutineNode _checkQualifiedSkillCoroutine;

	private LogicEntity target;

	private TraceTarget _traceTarget;

	public void OnStart()
	{
		if (_skillPool == null)
		{
			_skillPool = new SkillPool();
			List<SkillVariable> list = new List<SkillVariable>();
			SkillVariable item = new SkillVariable(skillId_throw, skillCD_throw, 1, 99, 5, immBondage: false, _actor.LogicTime);
			list.Add(item);
			item = new SkillVariable(skillId_idle, skillCD_idle, 0, 99, 5, immBondage: false, _actor.LogicTime);
			list.Add(item);
			_skillPool.Init(_actor, list, 0.1);
		}
		_checkQualifiedSkillCoroutine = _actor.StartLogicCoroutine(CheckQualifiedSkill());
	}

	public void OnStop()
	{
		_traceTarget?.Clear();
		if (_checkQualifiedSkillCoroutine != null)
		{
			_actor.StopLogicCoroutine(_checkQualifiedSkillCoroutine);
			_checkQualifiedSkillCoroutine = null;
		}
	}

	public void OnDisable()
	{
		_skillPool = null;
		if (_traceTarget != null)
		{
			_traceTarget.Clear();
			_traceTarget = null;
		}
	}

	private IEnumerator CheckQualifiedSkill()
	{
		while (true)
		{
			Action_miniboss action_miniboss = this;
			LogicEntity logicEntity = (_actor.monsterTarget = _actor.actorSearchTargetInfo.GetMonsterAttackTarget());
			action_miniboss.target = logicEntity;
			if ((target == null || !(target as AdventureActor).actorHealthInfo.isAlive) && _actor is MonsterAdventureActor)
			{
				break;
			}
			if (_actor.logicVariable.GetLogicTagToggle("getBullet"))
			{
				bool logicTagToggle = _actor.logicVariable.GetLogicTagToggle("born");
				int skillId = skillId_catch;
				if (logicTagToggle)
				{
					skillId = skillId_born;
				}
				else
				{
					_skillPool.GetSkill(skillId_throw)?.ClearExpireTime();
				}
				bool skillFinish = false;
				ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
				{
					skillFinish = true;
				});
				while (!skillFinish)
				{
					yield return null;
				}
				continue;
			}
			SkillVariable qualifiedSkill = _skillPool.CheckQualifiedSkill(_actor.LogicTime);
			if (qualifiedSkill == null)
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_skillPool.checkInterval));
				continue;
			}
			bool flag = true;
			bool logicTagToggle2 = _actor.logicVariable.GetLogicTagToggle("haveBullet");
			if (qualifiedSkill.id == skillId_throw)
			{
				if (logicTagToggle2)
				{
					if (ILRuntimeAPI.CalcDistanceBetweenTwoActor(_actor, target as AdventureActor) > attackDistance)
					{
						flag = false;
					}
				}
				else
				{
					flag = false;
				}
			}
			if (flag)
			{
				if (_traceTarget == null)
				{
					_traceTarget = new TraceTarget();
				}
				bool traceFinish = false;
				bool skillFinish2 = false;
				_traceTarget.BeginTrace(_actor, target, qualifiedSkill.releaseDistance, -1, qualifiedSkill.trackTime, () =>
				{
					qualifiedSkill.ResetExpireTime(_actor.LogicTime);
					ILRuntimeAPI.CreateSkill(qualifiedSkill.id, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
					{
						skillFinish2 = true;
					});
					traceFinish = true;
				}, (bool isdie, bool isInterrupt, bool _, bool _) =>
				{
					if (!isdie)
					{
						qualifiedSkill.ResetExpireTime(_actor.LogicTime);
					}
					traceFinish = true;
					skillFinish2 = true;
				});
				while (!traceFinish)
				{
					yield return null;
				}
				while (!skillFinish2)
				{
					yield return null;
				}
			}
			else
			{
				yield return null;
			}
		}
		_actor.Idle();
	}
}
