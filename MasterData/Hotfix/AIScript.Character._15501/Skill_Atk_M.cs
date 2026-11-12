using System.Collections;

namespace AIScript.Character._15501;

public class Skill_Atk_M : SkillSimpleBase
{
	protected virtual string keyBase { get; }

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnUpdate()
	{
		if (_actor.monsterTarget != null)
		{
			_actor.AimAtTarget(_actor.monsterTarget);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = keyBase;
		if (_actor.monsterTarget != null)
		{
			_actor.AimAtTarget(_actor.monsterTarget);
		}
		BeginAttack(1, actionKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill.Clear();
	}
}
