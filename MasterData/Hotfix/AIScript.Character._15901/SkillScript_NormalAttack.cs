using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15901;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private string key_Base = "Atk1";

	private string key_P3 = "Atk1_P3";

	private string evt_shoot = "Shoot";

	private string bullet_Base = "Bullet_15901_NormalAttack";

	private string bullet_P3 = "Bullet_15901_NormalAttack_Perk03";

	private AnimationSlotConfigComponent.SlotType slotType = AnimationSlotConfigComponent.SlotType.Extra_1;

	private TSVector shootOffset = new TSVector(0.2, 1.975, 1.125);

	private int perkId_3 = 515903;

	private int shootEvent = CommonHelper.StringToHash("shootEvent");

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	private void DoMainLogic()
	{
		bool logicTagToggle = _actor.logicVariable.GetLogicTagToggle("InCrystal");
		string actionTag = ((GetPerk(perkId_3) & logicTagToggle) ? key_P3 : key_Base);
		System.Action onComboFinish = onFinish;
		System.Action onInterrupt = onFinish;
		Action<string> action = onCustomEvent;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (!evt.Equals(evt_shoot))
		{
			return;
		}
		TSVector2 tSVector = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(shootOffset.x, shootOffset.z));
		TSVector2 position = new TSVector2(tSVector.x, tSVector.y);
		FP y = shootOffset.y;
		if (_actor.aimLockedTarget != null && _actor.ammoInfo.ammoCount > 0)
		{
			_actor.ammoInfo.RefreshAmmoCost(-1);
			bool logicTagToggle = _actor.logicVariable.GetLogicTagToggle("InCrystal");
			string bulletAlias = ((GetPerk(perkId_3) & logicTagToggle) ? bullet_P3 : bullet_Base);
			AdventureActor actor = _actor;
			LogicEntity aimLockedTarget = _actor.aimLockedTarget;
			ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, y, default, aimLockedTarget, AimType.Target, BulletDirectionType.BulletToTarget);
			if (_actor.ammoInfo.ammoCount <= 0)
			{
				_actor.InterruptAttack(force: true);
			}
		}
	}

	private void onFinish()
	{
		_skill?.Clear();
	}
}
