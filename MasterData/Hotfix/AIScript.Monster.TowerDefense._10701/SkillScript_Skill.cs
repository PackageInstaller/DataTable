using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._10701;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string ackey = "B1_Skill";

	protected const string shootShieldEvent = "ThrowShield";

	private CoroutineNode corMain;

	private List<LogicEntity> targets = new List<LogicEntity>();

	private TSVector2 dir;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		targets.Clear();
		_actor.CancelAiming();
		Parallel.norPlus_t = _actor.LogicTime;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		CommonUtils.SearchNearTargetsByCircleInTD(_actor, _actor.tsTransform.Position, Action.searchRange, targets, isConfront: true);
		if (targets.Count < 1)
		{
			SkillFinish();
			return;
		}
		_actor.AimAtTarget(targets.get_Item(0));
		string actionTag = ackey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		if (GetPerk(1070103))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_107_BuffArea", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		}
	}

	private void onCustomEvent(string eventName)
	{
		if (!string.Equals("ThrowShield", eventName))
		{
			return;
		}
		int num = 1;
		if (GetPerk(1070104))
		{
			num = ((5 <= targets.Count) ? 5 : targets.Count);
		}
		for (int i = 0; i < num; i++)
		{
			dir = targets.get_Item(i).tsTransform.Position - _actor.tsTransform.Position;
			TSVector2 position = _actor.tsTransform.Position;
			AdventureActor actor = _actor;
			FP range = 0;
			FP positionY = 1.8;
			LogicEntity target = targets.get_Item(i);
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("Bullet_107_Shield_ToMonster", actor, range, position, positionY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			if (adventureBulletBase != null)
			{
				Parallel.bulletIds.Add(adventureBulletBase.Id);
			}
		}
		_actor.CancelAiming();
	}
}
