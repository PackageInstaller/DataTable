using System;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._10301;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private string key = "Attack";

	private string key_strong = "Attack_AOE";

	private string evt_AddBuff = "evt_AddBuff";

	private int perkId_1 = 1030101;

	private int buffId_1 = 801030110;

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private VisualSmooth smooth;

	private int buffId_3 = 801030120;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		smooth = _actor.GetLogicComponent<VisualSmooth>();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		aimTarget.Cancel();
		targetEntity = null;
	}

	public void OnStart()
	{
		DoMainLogic();
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
				smooth?.SyncDeterministicTransform();
			}
		}
		else
		{
			_actor.CancelAttack();
		}
	}

	private void DoMainLogic()
	{
		string text = key;
		if (_actor.buffComponent.CheckBuffByBuffID(buffId_3))
		{
			text = key_strong;
		}
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		string actionTag = text;
		Action onComboFinish = onFinish;
		Action onInterrupt = onFinish;
		Action<string> action = onCustomEvent;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_AddBuff) && GetPerk(perkId_1))
		{
			_actor.buffComponent.AddBuff(buffId_1, _actor);
		}
	}

	private void onFinish()
	{
		_skill?.Clear();
	}
}
