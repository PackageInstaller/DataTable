using System;
using TrueSync;

namespace AIScript.Monster.Soldier._30911;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "SupportSkill";

	private const int buffId_Lv2 = 250105902;

	private const string actionKey_3 = "SupportSkill_Potential2";

	private const string Event_EndLoop = "EndLoop";

	private CoroutineNode corMain;

	private int PotentialLv = 1;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (PotentialLv >= 2)
		{
			_actor.buffComponent?.RemoveBuffByBuffId(250105902);
		}
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		string actionTag = ((PotentialLv >= 3) ? "SupportSkill_Potential2" : "SupportSkill");
		if (PotentialLv >= 2)
		{
			_actor.buffComponent?.AddBuff(250105902, _actor);
		}
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action<string> action = onCustomEvent;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (string.Equals(evt, "EndLoop"))
		{
			_actor.CancelAttack();
		}
	}
}
