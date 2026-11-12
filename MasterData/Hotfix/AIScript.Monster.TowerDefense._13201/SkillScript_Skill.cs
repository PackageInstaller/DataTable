using System;
using System.Collections;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13201;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string comboTag_S2 = "132_Main_Skill_S2";

	private string comboTag_S2_P03 = "132_Main_Skill_S3_P01";

	private string comboTag_S2_P04 = "132_Main_Skill_S2_1";

	private string comboTag_S3 = "132_Main_Skill_S1";

	private int loopSegCount_S2 = 1;

	private const int perkId_1 = 1320101;

	private const int perkId_2 = 1320102;

	private const int perkId_3 = 1320103;

	private const int perkId_4 = 1320104;

	private FP baseSkillTime = 12;

	private LogicEntity targetEntity;

	private CoroutineNode corMain;

	private int loopCount;

	public override FP BaseSkillTime => baseSkillTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		targetEntity = _actor.attackTarget;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	public void OnUpdate()
	{
		if (!GetPerk(1320102))
		{
			if (_actor.attackTarget != null)
			{
				targetEntity = _actor.attackTarget;
			}
			if (targetEntity != null)
			{
				_actor.LookAt(targetEntity.tsTransform.Position, 0);
			}
		}
	}

	private IEnumerator DoMainLogic()
	{
		if (GetPerk(1320102))
		{
			if (_actor.attackTarget != null)
			{
				targetEntity = _actor.attackTarget;
			}
			if (targetEntity != null)
			{
				_actor.LookAt(targetEntity.tsTransform.Position, 0);
			}
		}
		string comboTag = comboTag_S2;
		if (GetPerk(1320104))
		{
			comboTag = comboTag_S2_P04;
		}
		yield return StartCoroutine(DoLoopCombo(comboTag));
		Action onInterrupt;
		if (GetPerk(1320103))
		{
			comboTag = comboTag_S2_P03;
			SkillScript_Skill skillScript_Skill = this;
			string actionTag = comboTag;
			onInterrupt = SkillInterrupt;
			RequestComboAttack req = skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt);
			while (!req.isComboFinish)
			{
				yield return null;
			}
		}
		SkillScript_Skill skillScript_Skill2 = this;
		string actionTag2 = comboTag_S3;
		onInterrupt = SkillFinish;
		Action onInterrupt2 = SkillInterrupt;
		skillScript_Skill2.BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onInterrupt2);
	}

	private IEnumerator DoLoopCombo(string comboTag)
	{
		loopCount = 0;
		SkillScript_Skill skillScript_Skill = this;
		Action onComboLoop = OnComboLoop;
		Action onInterrupt = SkillInterrupt;
		skillScript_Skill.BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
		if (loopSegCount_S2 > 0)
		{
			while (loopCount < loopSegCount_S2)
			{
				yield return null;
			}
		}
		_actor.CancelAttack();
	}

	private void OnComboLoop()
	{
		loopCount++;
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
