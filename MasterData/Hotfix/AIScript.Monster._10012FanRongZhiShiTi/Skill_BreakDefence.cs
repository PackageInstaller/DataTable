using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._10012FanRongZhiShiTi;

public class Skill_BreakDefence : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey startKey = ComboInputBuffer.ActionKey.H;

	private readonly ComboInputBuffer.ActionKey endKey = ComboInputBuffer.ActionKey._1;

	private readonly FP waitTime = 4;

	private readonly string BeginSuperArmor = "BeginSuperArmor";

	private readonly string EndSuperArmor = "EndSuperArmor";

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableImmuneControl();
		_actor.StopImmuneControlCueEffect();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		_actor.buffComponent.RemoveBuffByBuffId(1001224);
		_actor.DisableImmuneControl();
	}

	private IEnumerator DoMainLogic()
	{
		Skill_BreakDefence skill_BreakDefence = this;
		ComboInputBuffer.ActionKey key = startKey;
		Action onComboFinish = OnFinish;
		RequestComboAttack req = skill_BreakDefence.BeginAttack(key, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish);
		while (!req.isAnticipationEnd)
		{
			yield return null;
		}
		_actor.buffComponent.AddBuff(1001224, _actor);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitTime));
		_actor.buffComponent.RemoveBuffByBuffId(1001224);
		Skill_BreakDefence skill_BreakDefence2 = this;
		ComboInputBuffer.ActionKey key2 = endKey;
		onComboFinish = OnFinish;
		Action onInterrupt = OnFinish;
		skill_BreakDefence2.BeginAttack(key2, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	protected void onCustomEvent(string eventName)
	{
		if (eventName.Equals(BeginSuperArmor))
		{
			_actor.buffComponent.AddBuff(9900311, _actor);
		}
		else if (eventName.Equals(EndSuperArmor))
		{
			_actor.buffComponent.RemoveBuffByBuffId(9900311);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}
}
