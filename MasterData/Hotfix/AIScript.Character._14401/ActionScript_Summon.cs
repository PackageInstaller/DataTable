using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14401;

public class ActionScript_Summon : AIBase
{
	private CoroutineNode _delayUseSkillCor;

	private CoroutineNode _delayDestoryCor;

	public void OnEnable()
	{
	}

	public void OnStart()
	{
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("DelayUseSkillTime_Summon");
		if (logicTagValue > 0)
		{
			_delayUseSkillCor = _actor.StartLogicCoroutine(DelayUseSkill(logicTagValue));
		}
		else
		{
			ILRuntimeAPI.CreateSkill(14410010, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: true, SkillCountdownTiming.Start, OnSkillFinish);
		}
	}

	private IEnumerator DelayUseSkill(FP delayTime)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(delayTime));
		ILRuntimeAPI.CreateSkill(14410010, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: true, SkillCountdownTiming.Start, OnSkillFinish);
	}

	private void OnSkillFinish(bool success)
	{
		if (Config.delayDestoryTime_Summon > 0)
		{
			_delayDestoryCor = _actor.StartLogicCoroutine(DelayDestory());
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	private IEnumerator DelayDestory()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config.delayDestoryTime_Summon));
		_actor.DestroySelf();
	}

	public void OnStop()
	{
		if (_delayUseSkillCor != null)
		{
			_actor.StopLogicCoroutine(_delayUseSkillCor);
		}
		_delayUseSkillCor = null;
		if (_delayDestoryCor != null)
		{
			_actor.StopLogicCoroutine(_delayDestoryCor);
		}
		_delayDestoryCor = null;
	}

	public void OnDisable()
	{
	}
}
