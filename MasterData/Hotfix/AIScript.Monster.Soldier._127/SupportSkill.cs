using System;
using System.Collections;
using TrueSync;

namespace AIScript.Monster.Soldier._127;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support_1";

	private const string actionKey_3 = "Support_2";

	private int PotentialLv = 1;

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
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
	}

	private IEnumerator DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		string text = "Support_1";
		SupportSkill supportSkill = this;
		string actionTag = text;
		Action onComboFinish = OnFinish;
		RequestComboAttack req = supportSkill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish);
		while (!req.isRecoveryBegin)
		{
			yield return null;
		}
		if (PotentialLv >= 3)
		{
			text = "Support_2";
			SupportSkill supportSkill2 = this;
			string actionTag2 = text;
			onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			supportSkill2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
	}
}
