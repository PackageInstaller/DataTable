using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.Soldier._157;

public class MainSkill : SkillAdvancedBase
{
	private const string comboTag = "MainSkill";

	private const string eventName_Fire = "154MainShot";

	private const AnimationSlotConfigComponent.SlotType shootSlot = AnimationSlotConfigComponent.SlotType.Extra_1;

	private const string fxKey_Bullet = "157_Skll_Main_FlyBullt_Fx";

	private static readonly FP moveTime_BulletFx = 0.35;

	private static readonly FP offset_NoTarget = 5;

	private const string areaEffectKey = "Area_MainSkill_ShotBoom_Soldier";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("MainSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "154MainShot"))
		{
			DoShoot();
		}
	}

	private void DoShoot()
	{
		Transform transform = ((_actor.slotConfig != null) ? _actor.slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Extra_1) : null);
		Vector3 vector = ((transform != null) ? transform.transform.position : _actor.transform.position);
		TSVector2 pos = ((_actor.attackTarget != null) ? (_actor.tsTransform.Position + (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized * (TSVector2.Distance(_actor.tsTransform.Position, _actor.attackTarget.tsTransform.Position) - _actor.attackTarget.GetRadius())) : (_actor.tsTransform.Position + _actor.tsTransform.Forward * offset_NoTarget));
		Vector3 vector2 = new Vector3(pos.x.AsFloat(), _actor.tsTransform.PositionY.AsFloat(), pos.y.AsFloat());
		float speed = Vector3.Distance(vector, vector2) / moveTime_BulletFx.AsFloat();
		_actor.PlayMovableFx("157_Skll_Main_FlyBullt_Fx", vector, vector2, speed);
		StartCoroutine(CorPlayAreaEffectAfterDelay(moveTime_BulletFx, pos));
	}

	private IEnumerator CorPlayAreaEffectAfterDelay(FP delay, TSVector2 pos)
	{
		yield return delay;
		ILRuntimeAPI.PlayAreaEffect(_actor, "Area_MainSkill_ShotBoom_Soldier", pos);
	}
}
