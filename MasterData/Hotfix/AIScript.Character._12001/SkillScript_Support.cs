#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12001;

public class SkillScript_Support : SkillAdvancedBase
{
	private readonly string attack_tag = "120_B2";

	private readonly string event_fly = "120_ShootEvent";

	private const string bullet_fly = "Bullet_12001_B2_Skill_Projectile";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.AimAtTarget(SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		string actionTag = attack_tag;
		System.Action onComboFinish = onFinishOrInterrupt;
		System.Action onInterrupt = onFinishOrInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string evt)
	{
		if (!evt.Equals(event_fly))
		{
			return;
		}
		LogicEntity logicEntity = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor;
		if (logicEntity == null)
		{
			logicEntity = _actor;
		}
		AdventureActor adventureActor = logicEntity as AdventureActor;
		if (adventureActor != null)
		{
			if (!adventureActor.isSneak && !adventureActor.isPenetrate && adventureActor.actorHealthInfo.isAlive)
			{
				AdventureActor actor = _actor;
				FP range = 1;
				LogicEntity target = adventureActor;
				ILRuntimeAPI.Shoot("Bullet_12001_B2_Skill_Projectile", actor, range, default, default, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			}
			else
			{
				NovaLogger.Debug($"===> Error Target null : {adventureActor.isSneak},{adventureActor.isPenetrate},{!adventureActor.actorHealthInfo.isAlive}");
			}
		}
		_actor.CancelAiming();
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}
}
