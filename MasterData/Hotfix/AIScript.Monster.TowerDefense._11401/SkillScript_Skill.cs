using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11401;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill_Shoot_New";

	private FP loopTime = 0.66;

	private FP ExtraShootTime = 1;

	private int perkId_1 = 1140101;

	private string key_P01 = "Skill_ExtraShoot_New";

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		targetEntity = null;
		aimTarget.Cancel();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		aimTarget.Cancel();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public void OnUpdate()
	{
		if (targetEntity != null)
		{
			_actor.LookAt(targetEntity.tsTransform.Position, 0);
		}
	}

	private IEnumerator DoMainLogic()
	{
		targetEntity = _actor.attackTarget;
		if (targetEntity != null)
		{
			_actor.LookAt(targetEntity.tsTransform.Position, 0);
		}
		SkillScript_Skill skillScript_Skill = this;
		string actionTag = key;
		Action onInterrupt = SkillInterrupt;
		RequestComboAttack req = skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt);
		if (GetPerk(perkId_1))
		{
			yield return _actor.WaitTime(ExtraShootTime);
			SkillScript_Skill skillScript_Skill2 = this;
			string actionTag2 = key_P01;
			onInterrupt = SkillFinish;
			Action onInterrupt2 = SkillInterrupt;
			skillScript_Skill2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onInterrupt2, null, null, fadeOutAnim: true);
		}
		else
		{
			while (!req.isComboFinish)
			{
				yield return null;
			}
			SkillFinish();
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
}
