using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._11001;

public class SkillScript_SummonSkill : SkillSimpleBase
{
	private int keyIndex_1 = 1;

	private string key_1 = "Skill";

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

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
	}

	public void OnUpdate()
	{
		if (_actor.monsterTarget != null)
		{
			if (targetEntity != _actor.monsterTarget)
			{
				targetEntity = _actor.monsterTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.monsterTarget as AdventureActor);
			}
		}
		else
		{
			aimTarget.Cancel();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (_actor.monsterTarget != null)
		{
			_actor.LookAt(_actor.monsterTarget.tsTransform.Position, 0);
		}
		BeginAttack(keyIndex_1, key_1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
