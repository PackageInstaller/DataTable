using UnityEngine;

public readonly struct SummerRaceWeaponPresentationProfile(Vector2 projectileSize, float colliderRadius, float rotationLerp, bool enableTrail, float trailTime, float trailStartWidth, float trailEndWidth, bool faceAlongVelocity, float continuousSpinDegreesPerSecond, Color projectileColor, Color trailColor, Color muzzleFlashColor, Vector2 muzzleFlashSize, float muzzleFlashLifetime, Color impactFlashColor, float impactFlashScale, float impactFlashLifetime, Color impactRingColor, float impactRingStartScale, float impactRingEndScale, float impactRingLifetime)
{
	public readonly Vector2 ProjectileSize = projectileSize;

	public readonly float ColliderRadius = colliderRadius;

	public readonly float RotationLerp = rotationLerp;

	public readonly bool EnableTrail = enableTrail;

	public readonly float TrailTime = trailTime;

	public readonly float TrailStartWidth = trailStartWidth;

	public readonly float TrailEndWidth = trailEndWidth;

	public readonly bool FaceAlongVelocity = faceAlongVelocity;

	public readonly float ContinuousSpinDegreesPerSecond = continuousSpinDegreesPerSecond;

	public readonly Color ProjectileColor = projectileColor;

	public readonly Color TrailColor = trailColor;

	public readonly Color MuzzleFlashColor = muzzleFlashColor;

	public readonly Vector2 MuzzleFlashSize = muzzleFlashSize;

	public readonly float MuzzleFlashLifetime = muzzleFlashLifetime;

	public readonly Color ImpactFlashColor = impactFlashColor;

	public readonly float ImpactFlashScale = impactFlashScale;

	public readonly float ImpactFlashLifetime = impactFlashLifetime;

	public readonly Color ImpactRingColor = impactRingColor;

	public readonly float ImpactRingStartScale = impactRingStartScale;

	public readonly float ImpactRingEndScale = impactRingEndScale;

	public readonly float ImpactRingLifetime = impactRingLifetime;
}
