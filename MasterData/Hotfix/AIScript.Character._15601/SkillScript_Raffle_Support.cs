using System;
using AdventureBehaviour;

namespace AIScript.Character._15601;

public class SkillScript_Raffle_Support : SkillAdvancedBase
{
	private Config_Support.RaffleCombinationType _raffleCombinationType;

	private PlayFX _playFX;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
		_raffleCombinationType = (Config_Support.RaffleCombinationType)_actor.logicVariable.GetLogicTagValue("RaffleCombinationType").AsInt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Sup_Raffle", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "RaffleResult") && Config_Support.raffleResultFxDic.TryGetValue(_raffleCombinationType, out var value) && !string.IsNullOrEmpty(value))
		{
			if (_playFX == null)
			{
				_playFX = new PlayFX();
			}
			else
			{
				_playFX.Clear();
			}
			_playFX.Play(_actor, null, value, default, _actor.tsTransform.Position, default);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
