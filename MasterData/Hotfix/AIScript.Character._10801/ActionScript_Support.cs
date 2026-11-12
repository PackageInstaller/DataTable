using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10801;

public class ActionScript_Support : ActorActionBase
{
	private readonly FP waitTime_AfterUltraSkill = 0;

	private CoroutineNode _waitCor;

	protected override void OnCastUltimate()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnUltraSkillFinish);
	}

	private void OnUltraSkillFinish(bool _)
	{
		if (_waitCor != null)
		{
			_actor.StopLogicCoroutine(_waitCor);
		}
		_waitCor = _actor.StartLogicCoroutine(WaitAssistAIFinish());
	}

	private IEnumerator WaitAssistAIFinish()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitTime_AfterUltraSkill));
		(_actor as PlayerAdventureActor).isAssistAIFinish = true;
		_waitCor = null;
	}

	protected override void OnActionDisable()
	{
		if (_waitCor != null)
		{
			_actor.StopLogicCoroutine(_waitCor);
		}
		_waitCor = null;
	}
}
