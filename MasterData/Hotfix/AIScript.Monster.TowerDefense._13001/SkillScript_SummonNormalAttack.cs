using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._13001;

public class SkillScript_SummonNormalAttack : SkillSimpleBase
{
	private int key_1 = 1;

	private string key_Base = "Attack1";

	private string key_P4 = "Attack2";

	private int perkId_4 = 1300104;

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		targetEntity = null;
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
			_actor.InterruptAttack(force: true);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (_actor.monsterTarget != null)
		{
			_actor.LookAt(_actor.monsterTarget.tsTransform.Position, 0);
		}
		string actionKey = (GetPerk(perkId_4) ? key_P4 : key_Base);
		BeginAttack(key_1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}
}
