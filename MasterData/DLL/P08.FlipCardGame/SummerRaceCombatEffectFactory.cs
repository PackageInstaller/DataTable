using System;
using System.Collections.Generic;
using UnityEngine;

public static class SummerRaceCombatEffectFactory
{
	public static CombatImpactPayload CreateWeaponImpactPayload(SummerRaceWeaponSpec spec, CombatTriggerType trigger)
	{
		if (spec == null)
		{
			throw new ArgumentNullException("spec");
		}
		ResolveWeaponImpactTargeting(spec.Kind, spec.IsMelee, spec.AttackRadius, out var selector, out var radius);
		List<CombatEffectSpec> list = new List<CombatEffectSpec>(6);
		AppendWeaponEffects(list, spec.Kind, trigger, selector, radius, spec.Damage, spec.StunDuration, spec.SlowMultiplier, spec.SlowDuration, spec.BurnDps, spec.BurnDuration, spec.DisableEnemyWeapons, spec.DisableDuration, spec.Knockback);
		return new CombatImpactPayload
		{
			trigger = trigger,
			effects = list.ToArray(),
			boomerangFlight = spec.BoomerangFlight
		};
	}

	public static CombatImpactPayload CreateWeaponImpactPayload(WeaponModuleDefinition def, CombatTriggerType trigger)
	{
		if (def == null)
		{
			throw new ArgumentNullException("def");
		}
		ResolveWeaponImpactTargeting(ToRuntimeWeaponKind(def.WeaponType), def.IsMelee, def.MeleeRadius, out var selector, out var radius);
		List<CombatEffectSpec> list = new List<CombatEffectSpec>(6);
		AppendWeaponEffects(list, ToRuntimeWeaponKind(def.WeaponType), trigger, selector, radius, def.Damage, def.StunDuration, def.SlowMultiplier, def.SlowDuration, def.BurnDps, def.BurnDuration, def.DisableEnemyWeapons, def.DisableDuration, def.Knockback);
		return new CombatImpactPayload
		{
			trigger = trigger,
			effects = list.ToArray(),
			boomerangFlight = def.BoomerangFlight
		};
	}

	public static CombatEffectSpec[] CreateEquipEffects(SummerRaceEquipSpec spec)
	{
		if (spec == null)
		{
			throw new ArgumentNullException("spec");
		}
		List<CombatEffectSpec> list = new List<CombatEffectSpec>(2);
		switch (spec.Kind)
		{
		case EquipKind.Thruster:
			list.Add(CreateSpec(CombatTriggerType.EquipActivated, CombatEffectKind.SelfDash, CombatTargetSelector.Self, Mathf.Max(0f, spec.Strength), Mathf.Max(0.1f, spec.Duration), 0f));
			break;
		case EquipKind.ShieldGenerator:
			list.Add(CreateSpec(CombatTriggerType.EquipActivated, CombatEffectKind.Shield, CombatTargetSelector.Self, 0f, Mathf.Max(0.1f, spec.Duration), 0f));
			break;
		case EquipKind.BoxingGlove:
			list.Add(CreateSpec(CombatTriggerType.EquipActivated, CombatEffectKind.Knockback, CombatTargetSelector.FrontSingle, Mathf.Max(0f, spec.Strength), 0f, Mathf.Max(0.4f, spec.Radius + 0.4f)));
			list.Add(CreateSpec(CombatTriggerType.EquipActivated, CombatEffectKind.Stun, CombatTargetSelector.FrontSingle, 0f, 0.25f, Mathf.Max(0.4f, spec.Radius + 0.4f)));
			break;
		case EquipKind.ElectricNet:
		{
			float num = Mathf.Max(0.1f, spec.Duration);
			list.Add(CreateSpec(CombatTriggerType.EquipActivated, CombatEffectKind.Disarm, CombatTargetSelector.FrontRadius, 0f, num, Mathf.Max(0.4f, spec.Radius)));
			list.Add(CreateSpec(CombatTriggerType.EquipActivated, CombatEffectKind.Stun, CombatTargetSelector.FrontRadius, 0f, Mathf.Min(0.9f, num), Mathf.Max(0.4f, spec.Radius)));
			break;
		}
		case EquipKind.Hook:
		{
			float magnitude = Mathf.Max(24f, Mathf.Max(0f, spec.Strength) * 2.6f);
			list.Add(CreateSpec(CombatTriggerType.EquipActivated, CombatEffectKind.PullTarget, CombatTargetSelector.FrontSingle, magnitude, 0f, Mathf.Max(0.6f, spec.Radius + 2f)));
			break;
		}
		}
		return list.ToArray();
	}

	public static CombatEffectSpec[] CreateEquipEffects(UtilityModuleDefinition def)
	{
		if (def == null || def.summerRaceEquipDef == null)
		{
			throw new ArgumentNullException("def");
		}
		return CreateEquipEffects(new SummerRaceEquipSpec
		{
			Kind = SummerRaceConfigLoader.ToRuntimeEquipKind(def.EquipType),
			Label = def.DisplayName,
			Cost = def.CostValue,
			EnergyCost = def.EnergyCost,
			Cooldown = def.Cooldown,
			Duration = def.Duration,
			Strength = def.Strength,
			Radius = def.Radius,
			LoadWeight = def.MassValue
		});
	}

	public static CombatImpactPayload CreateDamageImpactPayload(int damage, CombatTriggerType trigger)
	{
		int num = Mathf.Max(0, damage);
		CombatImpactPayload combatImpactPayload = new CombatImpactPayload();
		combatImpactPayload.trigger = trigger;
		combatImpactPayload.effects = ((num <= 0) ? Array.Empty<CombatEffectSpec>() : new CombatEffectSpec[1] { CreateSpec(trigger, CombatEffectKind.Damage, CombatTargetSelector.HitTarget, num, 0f, 0f) });
		return combatImpactPayload;
	}

	private static void AppendWeaponEffects(List<CombatEffectSpec> effects, WeaponKind weaponKind, CombatTriggerType trigger, CombatTargetSelector selector, float radius, int damage, float stunDuration, float slowMultiplier, float slowDuration, int burnDps, float burnDuration, bool disableWeapons, float disableDuration, float knockback)
	{
		if (weaponKind == WeaponKind.Shovel)
		{
			if (knockback > 0f)
			{
				effects.Add(CreateSpec(trigger, CombatEffectKind.Knockback, selector, knockback, 0f, radius));
			}
			return;
		}
		if (damage > 0)
		{
			effects.Add(CreateSpec(trigger, CombatEffectKind.Damage, selector, damage, 0f, radius));
		}
		if (stunDuration > 0f)
		{
			effects.Add(CreateSpec(trigger, CombatEffectKind.Stun, selector, 0f, stunDuration, radius));
		}
		if (slowDuration > 0f && slowMultiplier > 0f && slowMultiplier < 1f)
		{
			effects.Add(CreateSpec(trigger, CombatEffectKind.Slow, selector, slowMultiplier, slowDuration, radius));
		}
		if (burnDps > 0 && burnDuration > 0f)
		{
			effects.Add(CreateSpec(trigger, CombatEffectKind.Burn, selector, burnDps, burnDuration, radius));
		}
		if (disableWeapons && disableDuration > 0f)
		{
			effects.Add(CreateSpec(trigger, CombatEffectKind.Disarm, selector, 0f, disableDuration, radius));
		}
		if (knockback > 0f)
		{
			effects.Add(CreateSpec(trigger, CombatEffectKind.Knockback, selector, knockback, 0f, radius));
		}
	}

	private static void ResolveWeaponImpactTargeting(WeaponKind kind, bool isMelee, float authoredImpactRadius, out CombatTargetSelector selector, out float radius)
	{
		selector = CombatTargetSelector.HitTarget;
		radius = 0f;
		if (!isMelee && kind == WeaponKind.RocketLauncher)
		{
			radius = Mathf.Max(0f, authoredImpactRadius);
			if (radius <= 0f)
			{
				throw new InvalidOperationException("[SummerRaceCombatEffectFactory] RocketLauncher requires authored impact radius > 0.");
			}
			selector = CombatTargetSelector.FrontRadius;
		}
	}

	private static WeaponKind ToRuntimeWeaponKind(SummerRaceWeaponTypeConfig weaponType)
	{
		return weaponType switch
		{
			SummerRaceWeaponTypeConfig.RocketLauncher => WeaponKind.RocketLauncher, 
			SummerRaceWeaponTypeConfig.MachineGun => WeaponKind.MachineGun, 
			SummerRaceWeaponTypeConfig.Boomerang => WeaponKind.Boomerang, 
			SummerRaceWeaponTypeConfig.ScatterShell => WeaponKind.ScatterShell, 
			SummerRaceWeaponTypeConfig.LaserCannon => WeaponKind.LaserCannon, 
			SummerRaceWeaponTypeConfig.Drill => WeaponKind.Drill, 
			SummerRaceWeaponTypeConfig.RotatingSaw => WeaponKind.RotatingSaw, 
			SummerRaceWeaponTypeConfig.Shovel => WeaponKind.Shovel, 
			_ => throw new ArgumentOutOfRangeException("weaponType", weaponType, "Unsupported SummerRace weapon type config."), 
		};
	}

	private static CombatEffectSpec CreateSpec(CombatTriggerType trigger, CombatEffectKind kind, CombatTargetSelector selector, float magnitude, float duration, float radius)
	{
		return new CombatEffectSpec
		{
			trigger = trigger,
			effectKind = kind,
			targetSelector = selector,
			magnitude = magnitude,
			duration = duration,
			radius = radius,
			maxTargets = ((selector != CombatTargetSelector.FrontRadius) ? 1 : int.MaxValue),
			enabled = true
		};
	}
}
