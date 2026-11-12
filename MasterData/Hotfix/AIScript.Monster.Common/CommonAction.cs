#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Common;

public class CommonAction : AIBase
{
	protected SkillPool _skillPool;

	protected TraceTarget _traceTarget;

	protected CoroutineNode _checkQualifiedSkillCoroutine;

	public virtual void OnDisable()
	{
		NovaLogger.Debug("Action OnDisable");
		_skillPool = null;
		if (_traceTarget != null)
		{
			_traceTarget.Clear();
			_traceTarget = null;
		}
		if (_checkQualifiedSkillCoroutine != null)
		{
			_actor.StopLogicCoroutine(_checkQualifiedSkillCoroutine);
			_checkQualifiedSkillCoroutine = null;
		}
	}

	public virtual void OnStart()
	{
		NovaLogger.Debug("Action OnStart");
		if (_skillPool == null)
		{
			_skillPool = new SkillPool();
			InitSkill();
			_checkQualifiedSkillCoroutine = _actor.StartLogicCoroutine(CheckQualifiedSkill());
		}
		else
		{
			_actor.StartLogicCoroutine(WaitAndCheckQualifiedSkill(0.5f));
		}
	}

	protected virtual void InitSkill()
	{
		List<SkillVariable> list = new List<SkillVariable>();
		SkillVariable item = new SkillVariable(1000100, 1, 0, 2, 5, immBondage: false, _actor.LogicTime);
		list.Add(item);
		item = new SkillVariable(9999999, 1, 0, 2, 2, immBondage: false, _actor.LogicTime);
		list.Add(item);
		_skillPool.Init(_actor, list, 0.1);
	}

	private IEnumerator WaitAndCheckQualifiedSkill(FP seconds)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(seconds));
		_checkQualifiedSkillCoroutine = _actor.StartLogicCoroutine(CheckQualifiedSkill());
	}

	private IEnumerator CheckQualifiedSkill()
	{
		while (true)
		{
			string text = _actor.logicVariable?.GetLogicTagStringValue("Target");
			LogicEntity logicEntity = null;
			if (text != "none")
			{
				CommonUtils.TryParseStringParamToInt(text, out var intValue);
				logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(intValue);
				if (logicEntity == null)
				{
					logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByID(intValue);
				}
			}
			if (logicEntity == null)
			{
				break;
			}
			SkillVariable qualifiedSkill = _skillPool.CheckQualifiedSkill(_actor.LogicTime);
			if (qualifiedSkill == null)
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_skillPool.checkInterval));
				continue;
			}
			if (_traceTarget == null)
			{
				_traceTarget = new TraceTarget();
			}
			bool traceFinish = false;
			bool skillFinish = false;
			_traceTarget.BeginTrace(_actor, logicEntity, qualifiedSkill.releaseDistance, -1, qualifiedSkill.trackTime, () =>
			{
				qualifiedSkill.ResetExpireTime(_actor.LogicTime);
				NovaLogger.Debug($"sunyuan 释放技能 : {qualifiedSkill.id},time:{_actor.LogicTime}");
				ILRuntimeAPI.CreateSkill(qualifiedSkill.id, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
				{
					skillFinish = true;
				});
				traceFinish = true;
			}, (bool isdie, bool isInterrupt, bool _, bool _) =>
			{
				if (!isdie)
				{
					qualifiedSkill.ResetExpireTime(_actor.LogicTime);
				}
				traceFinish = true;
				skillFinish = true;
			});
			while (!traceFinish)
			{
				yield return null;
			}
			while (!skillFinish)
			{
				yield return null;
			}
		}
		_actor.Idle();
	}

	public virtual void OnStop()
	{
		NovaLogger.Debug("Action OnStop");
		_traceTarget?.Clear();
		if (_checkQualifiedSkillCoroutine != null)
		{
			_actor.StopLogicCoroutine(_checkQualifiedSkillCoroutine);
			_checkQualifiedSkillCoroutine = null;
		}
	}
}
