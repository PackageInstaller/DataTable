using System;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._14301;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] actionKey_1 = new ComboInputBuffer.ActionKey[6];

	private ComboInputBuffer.ActionKey[] actionKey_2;

	public static readonly FP distance_SwitchAttackMode = 3.3;

	private LogicEntity targetEntity;

	private AimTarget aimTarget;

	private bool _isRangeAttack;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_isRangeAttack = _actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) > distance_SwitchAttackMode;
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		targetEntity = null;
		aimTarget.Cancel();
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
			if (targetEntity != _actor.attackTarget)
			{
				targetEntity = _actor.attackTarget;
				aimTarget.Cancel();
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
		}
		else
		{
			_actor.CancelAttack();
		}
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		ComboInputBuffer.ActionKey[] keys = (_isRangeAttack ? actionKey_2 : actionKey_1);
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
	}

	public SkillScript_NormalAttack()
	{
		//IL_0019: Field data (rva=0x5f8) could not be found in any section!
		//IL_0019: Field data (rva=0x5f8) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[4];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._1B897DDDD4C151E2A2E6E3E91B7EA0F7FC4FD5ED00EF1C9669E8566393A02586));
		actionKey_2 = array;
		aimTarget = new AimTarget();
		base._002Ector();
	}
}
