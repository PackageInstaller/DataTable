using System;
using UnityEngine;

public static class SummerRaceWeaponPresentationProfileResolver
{
	public static SummerRaceWeaponPresentationProfile Resolve(WeaponModuleDefinition weaponDefinition)
	{
		if (weaponDefinition == null)
		{
			throw new ArgumentNullException("weaponDefinition");
		}
		Color projectileColor = NormalizeOpaqueColor(weaponDefinition.ProjectileColor);
		Vector2 projectileSize = ResolveProjectileVisualSizeOrThrow(weaponDefinition);
		float colliderRadius = ResolveProjectileColliderRadiusOrThrow(weaponDefinition, projectileSize);
		WeaponKind weaponKind = SummerRaceConfigLoader.ToRuntimeWeaponKind(weaponDefinition.WeaponType);
		return weaponKind switch
		{
			WeaponKind.MachineGun => CreateProfile(projectileColor, projectileSize, colliderRadius, 28f, enableTrail: true, 0.05f, 0.1f, 0.03f, faceAlongVelocity: true, 0f, new Vector2(0.52f, 0.18f), 0.06f, 0.28f, 0.08f, 0.08f, 0.34f, 0.1f), 
			WeaponKind.ScatterShell => CreateProfile(projectileColor, projectileSize, colliderRadius, 24f, enableTrail: true, 0.07f, 0.11f, 0.05f, faceAlongVelocity: true, 0f, new Vector2(0.7f, 0.26f), 0.08f, 0.42f, 0.1f, 0.12f, 0.5f, 0.14f), 
			WeaponKind.RocketLauncher => CreateProfile(projectileColor, projectileSize, colliderRadius, 16f, enableTrail: true, 0.18f, 0.17f, 0.06f, faceAlongVelocity: true, 0f, new Vector2(0.92f, 0.34f), 0.1f, 0.7f, 0.14f, 0.18f, 0.86f, 0.18f), 
			WeaponKind.Boomerang => CreateProfile(projectileColor, projectileSize, colliderRadius, 10f, enableTrail: true, 0.1f, 0.12f, 0.04f, faceAlongVelocity: false, 720f, new Vector2(0.42f, 0.18f), 0.06f, 0.3f, 0.08f, 0.1f, 0.44f, 0.12f), 
			WeaponKind.LaserCannon => CreateProfile(projectileColor, projectileSize, colliderRadius, 36f, enableTrail: true, 0.12f, 0.14f, 0.05f, faceAlongVelocity: true, 0f, new Vector2(0.76f, 0.2f), 0.08f, 0.4f, 0.1f, 0.14f, 0.62f, 0.14f), 
			WeaponKind.Drill => CreateProfile(projectileColor, projectileSize, colliderRadius, 22f, enableTrail: false, 0f, 0f, 0f, faceAlongVelocity: true, 260f, new Vector2(0.34f, 0.18f), 0.06f, 0.3f, 0.08f, 0.1f, 0.4f, 0.1f), 
			WeaponKind.RotatingSaw => CreateProfile(projectileColor, projectileSize, colliderRadius, 12f, enableTrail: false, 0f, 0f, 0f, faceAlongVelocity: false, 900f, new Vector2(0.42f, 0.22f), 0.06f, 0.34f, 0.08f, 0.12f, 0.46f, 0.12f), 
			WeaponKind.Shovel => CreateProfile(projectileColor, projectileSize, colliderRadius, 18f, enableTrail: false, 0f, 0f, 0f, faceAlongVelocity: true, 90f, new Vector2(0.44f, 0.24f), 0.07f, 0.42f, 0.1f, 0.16f, 0.58f, 0.12f), 
			_ => throw new InvalidOperationException("[SummerRaceWeaponPresentationProfileResolver] Unsupported weapon kind: " + weaponKind), 
		};
	}

	private static Vector2 ResolveProjectileVisualSizeOrThrow(WeaponModuleDefinition weaponDefinition)
	{
		Vector2 projectileVisualSize = weaponDefinition.ProjectileVisualSize;
		if (projectileVisualSize.x <= 0f || projectileVisualSize.y <= 0f)
		{
			string name = weaponDefinition.name;
			Vector2 vector = projectileVisualSize;
			throw new InvalidOperationException("[SummerRaceWeaponPresentationProfileResolver] Invalid projectileVisualSize on weapon=" + name + " size=" + vector.ToString());
		}
		return projectileVisualSize;
	}

	private static float ResolveProjectileColliderRadiusOrThrow(WeaponModuleDefinition weaponDefinition, Vector2 projectileSize)
	{
		float projectileColliderRadius = weaponDefinition.ProjectileColliderRadius;
		if (projectileColliderRadius <= 0f)
		{
			throw new InvalidOperationException("[SummerRaceWeaponPresentationProfileResolver] Invalid projectileColliderRadius on weapon=" + weaponDefinition.name + " radius=" + projectileColliderRadius);
		}
		float num = 0.5f * Mathf.Sqrt(projectileSize.x * projectileSize.y);
		float num2 = ((num > 0.0001f) ? (projectileColliderRadius / num) : 1f);
		if (num2 < 0.45f || num2 > 2.2f)
		{
			throw new InvalidOperationException("[SummerRaceWeaponPresentationProfileResolver] projectileColliderRadius is inconsistent with projectileVisualSize on weapon=" + weaponDefinition.name + " radius=" + projectileColliderRadius.ToString("F4") + " visualSize=(" + projectileSize.x.ToString("F4") + "," + projectileSize.y.ToString("F4") + ") ratio=" + num2.ToString("F3"));
		}
		return projectileColliderRadius;
	}

	private static SummerRaceWeaponPresentationProfile CreateProfile(Color projectileColor, Vector2 projectileSize, float colliderRadius, float rotationLerp, bool enableTrail, float trailTime, float trailStartWidth, float trailEndWidth, bool faceAlongVelocity, float continuousSpinDegreesPerSecond, Vector2 muzzleFlashSize, float muzzleFlashLifetime, float impactFlashScale, float impactFlashLifetime, float impactRingStartScale, float impactRingEndScale, float impactRingLifetime)
	{
		Color trailColor = MultiplyAlpha(Lighten(projectileColor, 0.35f), 0.85f);
		Color muzzleFlashColor = MultiplyAlpha(Lighten(projectileColor, 0.55f), 0.92f);
		Color impactFlashColor = MultiplyAlpha(Lighten(projectileColor, 0.45f), 0.88f);
		Color impactRingColor = MultiplyAlpha(Lighten(projectileColor, 0.15f), 0.7f);
		return new SummerRaceWeaponPresentationProfile(projectileSize, colliderRadius, rotationLerp, enableTrail, trailTime, trailStartWidth, trailEndWidth, faceAlongVelocity, continuousSpinDegreesPerSecond, projectileColor, trailColor, muzzleFlashColor, muzzleFlashSize, muzzleFlashLifetime, impactFlashColor, impactFlashScale, impactFlashLifetime, impactRingColor, impactRingStartScale, impactRingEndScale, impactRingLifetime);
	}

	private static Color NormalizeOpaqueColor(Color color)
	{
		if (color.a <= 0f)
		{
			color.a = 1f;
		}
		return color;
	}

	private static Color Lighten(Color color, float amount)
	{
		return Color.Lerp(color, Color.white, Mathf.Clamp01(amount));
	}

	private static Color MultiplyAlpha(Color color, float alpha)
	{
		color.a *= Mathf.Clamp01(alpha);
		return color;
	}
}
