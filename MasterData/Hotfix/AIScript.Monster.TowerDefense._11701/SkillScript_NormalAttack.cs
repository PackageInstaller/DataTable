using System;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._11701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKey = new ComboInputBuffer.ActionKey[3]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1,
		ComboInputBuffer.ActionKey._2
	};

	private const string _evt1 = "1";

	private const int _damageId1 = 80117011;

	private const string _fxAlias1 = "fx_11701_bullet_atk_2";

	private const string _evt2 = "2";

	private const int _damageId2 = 80117012;

	private const string _fxAlias2 = "fx_11701_bullet_atk_1";

	private const string _evt3 = "3";

	private const int _damageId3 = 80117013;

	private const string _fxAlias3 = "fx_11701_bullet_atk_3";

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
		ComboInputBuffer.ActionKey[] keys = actionKey;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		AdventureActor adventureActor = _actor.aimLockedTarget as AdventureActor;
		if (adventureActor == null)
		{
			OnInterrupt();
			return;
		}
		int hitDamageId;
		string attackFxPath;
		switch (evt)
		{
		default:
			return;
		case "1":
			hitDamageId = 80117011;
			attackFxPath = "fx_11701_bullet_atk_2";
			break;
		case "2":
			hitDamageId = 80117012;
			attackFxPath = "fx_11701_bullet_atk_1";
			break;
		case "3":
			hitDamageId = 80117013;
			attackFxPath = "fx_11701_bullet_atk_3";
			break;
		}
		ILRuntimeAPI.HitActor(_actor, adventureActor, hitDamageId, null, attackFxPath, attackFxPlayOnTarget: true);
	}
}
