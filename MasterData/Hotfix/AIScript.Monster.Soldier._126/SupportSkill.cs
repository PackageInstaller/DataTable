using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Soldier._126;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private const string fireEvent = "Fire";

	public static List<string> bulletPaths = new List<string> { "Bullet_Soldier_126_Support_ButterflyFire_Debuff_1", "Bullet_Soldier_126_Support_ButterflyFire_Debuff_2", "Bullet_Soldier_126_Support_ButterflyFire_Debuff_3", "Bullet_Soldier_126_Support_ButterflyFire_Debuff_4", "Bullet_Soldier_126_Support_ButterflyFire_Debuff_5" };

	public const int targetCount = 3;

	public static readonly FP searchRadius = 12;

	public static readonly FP bulletHeight = 1.5;

	public static readonly int hitTag_bullet = CommonHelper.StringToHash("Bullet_Soldier_126_Support");

	public const int buffId_p2 = 250104701;

	public const int targetCount_p3 = 5;

	public static readonly FP extraBulletDelay = 0.2;

	public const string fireDispatchEvent = "126SupportFire";

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
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
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void OnCustomEvent(string evt)
	{
		if (evt.Equals("Fire"))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventName = "126SupportFire";
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
