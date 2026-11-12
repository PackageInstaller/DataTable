using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11201;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill_Main";

	private string key_P3 = "Skill_HuiXuanZhan";

	private string key_P4 = "Skill_ZaDi";

	private string key_P1 = "Skill_Main_WindBlade";

	private string key_P1_3 = "Skill_HuiXuanZhan_WindBlade";

	private string key_P1_4 = "Skill_ZaDi_WindBlade";

	private const int perkId_1 = 1120101;

	private const int perkId_3 = 1120103;

	private const int perkId_4 = 1120104;

	private CoroutineNode corMain;

	private AimTarget aimTarget = new AimTarget();

	private LogicEntity targetEntity;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		aimTarget.Cancel();
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null && targetEntity != _actor.attackTarget)
		{
			targetEntity = _actor.attackTarget;
			aimTarget.Cancel();
			aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
		}
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		bool p1 = GetPerk(1120101);
		bool p3 = GetPerk(1120103);
		bool p4 = GetPerk(1120104);
		string _key = (GetPerk(1120101) ? key_P1 : key);
		if (p3 | p4)
		{
			RequestComboAttack req = BeginAttack(_key, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, null, null, null, fadeOutAnim: true);
			while (!req.isRecoveryBegin)
			{
				yield return null;
			}
			if (p3)
			{
				_key = (p1 ? key_P1_3 : key_P3);
			}
			if (p4)
			{
				_key = (p1 ? key_P1_4 : key_P4);
			}
			SkillScript_Skill skillScript_Skill = this;
			string actionTag = _key;
			Action onComboFinish = SkillFinish;
			Action onInterrupt = SkillInterrupt;
			skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: true);
		}
		else
		{
			SkillScript_Skill skillScript_Skill2 = this;
			string actionTag2 = _key;
			Action onInterrupt = SkillFinish;
			Action onComboFinish = SkillInterrupt;
			skillScript_Skill2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish, null, null, fadeOutAnim: true);
		}
	}
}
