using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._162;

public class MainSkill : SkillAdvancedBase
{
	private const string comboMain = "MainSkill_1";

	private const string comboMainNext = "MainSkill_2";

	private const string eventName_Area = "Area";

	private const string eventName_End = "End";

	private const string areaEffectKey = "Area_MainSkill_Soldier";

	private const int CheckBuffId = 250105601;

	private const int buffStackThreshold_Ultra = 5;

	private const string comboMainUltra = "MainSkill_Super";

	public void OnStart()
	{
		if (_actor.buffComponent.GetBuffNumByID(250105601) >= 5)
		{
			_actor.buffComponent.RemoveBuffByBuffId(250105601);
			Action<string> onCustomEvent = OnCustomEvent_Next;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("MainSkill_Super", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
		else
		{
			Action<string> onCustomEvent = OnCustomEvent_Main;
			Action onInterrupt = OnComboMainFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack("MainSkill_1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onInterrupt, onComboFinish, onCustomEvent);
		}
	}

	private void OnComboMainFinish()
	{
		Action<string> onCustomEvent = OnCustomEvent_Next;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill_2", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent_Main(string eventName)
	{
		if (string.Equals(eventName, "Area"))
		{
			PlayAreaAtTarget();
		}
	}

	private void OnCustomEvent_Next(string eventName)
	{
		if (string.Equals(eventName, "Area"))
		{
			PlayAreaAtTarget();
		}
		else if (string.Equals(eventName, "End"))
		{
			OnFinish();
		}
	}

	private void PlayAreaAtTarget()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		TSVector2 position = ((attackTarget != null && !attackTarget.IsDead()) ? attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		ILRuntimeAPI.PlayAreaEffect(_actor, "Area_MainSkill_Soldier", position);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}
}
