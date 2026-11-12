using System.Collections;
using System.Runtime.CompilerServices;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._11001;

public class SkillScript_SummonNormalAttack : SkillSimpleBase
{
	private int key_1 = 1;

	private ComboInputBuffer.ActionKey[] actionKey;

	private LogicEntity targetEntity;

	private AimTarget aimTarget;

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
		BeginAttack(key_1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}

	public SkillScript_SummonNormalAttack()
	{
		//IL_0014: Field data (rva=0x5e8) could not be found in any section!
		//IL_0014: Field data (rva=0x5e8) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[4];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._141253DC2E6542A74C1A4C854A9F711F8B1711068AEE2BE41671FCFC99CF4D98));
		actionKey = array;
		aimTarget = new AimTarget();
		base._002Ector();
	}
}
