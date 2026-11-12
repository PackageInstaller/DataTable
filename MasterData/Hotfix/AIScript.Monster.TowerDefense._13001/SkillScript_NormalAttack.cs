using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[1];

	private ComboInputBuffer.ActionKey[] actionKeyP3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private const string evt_Shoot_P1 = "130_Shoot";

	private List<string> bullet_P1 = new List<string> { "Bullet_130_AttackSpecial_1", "Bullet_130_AttackSpecial_2", "Bullet_130_AttackSpecial_3", "Bullet_130_AttackSpecial_4" };

	private TSVector shootOffset_P1 = new TSVector(0, 1.5, 1);

	private int perkId_1 = 1300101;

	private int buffId_1 = 801300010;

	private int perkId_3 = 1300103;

	private int buffId_3 = 801300020;

	private LogicEntity targetEntity;

	private AimTarget aimTarget = new AimTarget();

	private List<LogicEntity> entities = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		aimTarget.Cancel();
		targetEntity = null;
		entities.Clear();
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
		ComboInputBuffer.ActionKey[] keys = ((GetPerk(perkId_3) && _actor.buffComponent.CheckBuffByBuffID(buffId_3)) ? actionKeyP3 : actionKey);
		Action<string> action = onCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (!evt.Equals("130_Shoot") || !GetPerk(perkId_1))
		{
			return;
		}
		LogicEntity attackTarget = _actor.attackTarget;
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset_P1.x + _actor.tsTransform.Forward * shootOffset_P1.z;
		List<string> list = bullet_P1;
		if (attackTarget != null)
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(buffId_1);
			for (int i = 0; i < buffNumByID; i++)
			{
				ILRuntimeAPI.Shoot(list.get_Item(i), _actor, default, position, shootOffset_P1.y, attackTarget.tsTransform.Position, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
			}
		}
	}

	private void OnBuffRemove(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff adventureActorRemoveBuff && GetPerk(perkId_3) && adventureActorRemoveBuff.sender is AdventureActor adventureActor && adventureActor == _actor && adventureActorRemoveBuff.eventInfo.buffId == buffId_3)
		{
			_actor.CancelAttack();
		}
	}
}
