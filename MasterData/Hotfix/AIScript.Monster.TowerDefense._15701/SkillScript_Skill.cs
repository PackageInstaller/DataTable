using System;
using System.Collections;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.TowerDefense._15701;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key = "Skill_Main";

	private string evt_CastAreaEffect = "154MainShot";

	private const AnimationSlotConfigComponent.SlotType shootSlot_Skill = AnimationSlotConfigComponent.SlotType.Extra_1;

	private const string fxKey_Bullet_Skill = "157_Skll_Main_FlyBullt_Fx";

	private static readonly FP moveTime_BulletFx_Skill = 0.35;

	private static readonly FP offset_NoTarget_Skill = 5;

	private const string areaEffectKey_Skill = "AreaEffect_157_SkillMain_ShotBoom";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
		if (GetPerk(1570102))
		{
			_actor.buffComponent.AddBuff(801570030, _actor);
		}
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		if (_actor.attackTarget != null)
		{
			_actor.LookAt(_actor.attackTarget.tsTransform.Position, 0);
		}
		string actionTag = key;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals(evt_CastAreaEffect))
		{
			Transform slotNode = _actor.slotConfig.GetSlotNode(AnimationSlotConfigComponent.SlotType.Extra_1);
			Vector3 vector = ((slotNode != null) ? slotNode.transform.position : _actor.transform.position);
			TSVector2 pos = ((_actor.attackTarget != null) ? (_actor.tsTransform.Position + (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized * (TSVector2.Distance(_actor.tsTransform.Position, _actor.attackTarget.tsTransform.Position) - _actor.attackTarget.GetRadius())) : (_actor.tsTransform.Position + _actor.tsTransform.Forward * offset_NoTarget_Skill));
			Vector3 vector2 = new Vector3(pos.x.AsFloat(), _actor.tsTransform.PositionY.AsFloat(), pos.y.AsFloat());
			float speed = Vector3.Distance(vector, vector2) / moveTime_BulletFx_Skill.AsFloat();
			_actor.PlayMovableFx("157_Skll_Main_FlyBullt_Fx", vector, vector2, speed);
			StartCoroutine(CorPlayAreaEffectAfterDelay(moveTime_BulletFx_Skill, pos));
		}
	}

	private IEnumerator CorPlayAreaEffectAfterDelay(FP delay, TSVector2 pos)
	{
		yield return delay;
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_157_SkillMain_ShotBoom", pos);
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		SkillFinish();
	}
}
