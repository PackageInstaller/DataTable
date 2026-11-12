using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13401;

public class ActionScript_Support : ActionScript
{
	private CoroutineNode _perkLogicCor_P25;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	public override void OnStart()
	{
		base.OnStart();
	}

	protected override void OnCastSkill()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish) && CommonUtils.HavePersonalPerk(_actor.dataID, 513425, out var _))
		{
			if (_perkLogicCor_P25 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P25);
			}
			_perkLogicCor_P25 = _actor.StartLogicCoroutine(PerkLogic_25());
		}
	}

	private IEnumerator PerkLogic_25()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.addBuffDelay_P25));
		_actor.buffComponent.AddBuff(13425011, _actor);
	}

	private void OnSkillFinish(bool success)
	{
		if (success)
		{
			((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		}
	}

	public override void OnStop()
	{
		base.OnStop();
		if (_perkLogicCor_P25 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P25);
		}
		_perkLogicCor_P25 = null;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
