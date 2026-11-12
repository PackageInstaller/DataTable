using System;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._99901;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private readonly string key_Base = "999_Skill";

	private string evt_shoot = "999_Skill_Shoot";

	private string bullet_1 = "Bullet1";

	private string bullet_2 = "Bullet2";

	private string linkFx = "Link";

	private AnimationSlotConfigComponent.SlotType slot_Link1 = AnimationSlotConfigComponent.SlotType.Extra_1;

	private AnimationSlotConfigComponent.SlotType slot_Link2 = AnimationSlotConfigComponent.SlotType.Extra_2;

	private TSVector2 offset_Bullet1 = new TSVector2(-1.5, 0.8);

	private TSVector2 offset_Bullet2 = new TSVector2(1.5, 0.8);

	private readonly FP bulletHeight = 1.8;

	private PlayFX _linkFx1;

	private PlayFX _linkFx2;

	private long _bulletId1;

	private long _bulletId2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		StopLink(ref _linkFx1);
		StopLink(ref _linkFx2);
		_bulletId1 = 0L;
		_bulletId2 = 0L;
	}

	public void OnStart()
	{
		string actionTag = key_Base;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_shoot))
		{
			AdventureBulletBase adventureBulletBase = ShootBullet(bullet_1, offset_Bullet1);
			AdventureBulletBase adventureBulletBase2 = ShootBullet(bullet_2, offset_Bullet2);
			_bulletId1 = ((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
			_bulletId2 = ((adventureBulletBase2 != null) ? adventureBulletBase2.Id : 0);
			PlayLink(ref _linkFx1, adventureBulletBase, slot_Link1);
			PlayLink(ref _linkFx2, adventureBulletBase2, slot_Link2);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent)
		{
			if (_bulletId1 != 0L && adventureBulletFinishEvent.id == _bulletId1)
			{
				StopLink(ref _linkFx1);
				_bulletId1 = 0L;
			}
			else if (_bulletId2 != 0L && adventureBulletFinishEvent.id == _bulletId2)
			{
				StopLink(ref _linkFx2);
				_bulletId2 = 0L;
			}
		}
	}

	private AdventureBulletBase ShootBullet(string bulletAlias, TSVector2 localOffset)
	{
		TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(localOffset);
		LogicEntity attackTarget = _actor.attackTarget;
		if (attackTarget != null)
		{
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = bulletHeight;
			LogicEntity target = attackTarget;
			return ILRuntimeAPI.Shoot(bulletAlias, actor, range, position, positionY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		return ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, 0, _actor.tsTransform.Forward, position, bulletHeight);
	}

	private void PlayLink(ref PlayFX linkFx, AdventureBulletBase bullet, AnimationSlotConfigComponent.SlotType slotType)
	{
		if (!(bullet == null))
		{
			Transform transform = ((_actor.slotConfig != null) ? _actor.slotConfig.GetSlotNode(slotType) : null);
			GameObject source = ((transform != null) ? transform.gameObject : _actor.gameObject);
			ILRuntimeAPI.PlayLinFx(ref linkFx, _actor, this.linkFx, 1f, useCustSource: true, source, default, 0, bullet.gameObject, default, bulletHeight, 1f, actorScale: false, breakWhenLostSourceOrTarget: true);
		}
	}

	private void StopLink(ref PlayFX linkFx)
	{
		linkFx?.Stop();
		linkFx?.Clear();
		linkFx = null;
	}
}
