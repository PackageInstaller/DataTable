using System;
using UnityEngine;

public static class SummerRaceBuildScoring
{
	public static SummerRaceWeaponAnalyticsEstimate EstimateWeaponOutput(SummerRaceWeaponDefSO weaponDef)
	{
		if (weaponDef == null)
		{
			throw new ArgumentNullException("weaponDef");
		}
		int num = Mathf.Max(1, weaponDef.modularBurstCount);
		float num2 = ResolveRuntimeWeaponCycleDuration(weaponDef, num);
		float num3 = Mathf.Max(0, weaponDef.damage) * Mathf.Max(1, weaponDef.projectileCount) * num;
		if (weaponDef.isMelee)
		{
			num3 *= 0.9f;
		}
		float num4 = Mathf.Max(0f, weaponDef.recoilBackImpulse) + Mathf.Max(0f, weaponDef.recoilUpImpulse) * 0.6f + Mathf.Max(0f, weaponDef.recoilSideImpulse) * 0.35f;
		return new SummerRaceWeaponAnalyticsEstimate(num3 / num2, num4 * (float)num);
	}

	public static float ResolveRuntimeWeaponCycleDuration(SummerRaceWeaponDefSO weaponDef)
	{
		if (weaponDef == null)
		{
			throw new ArgumentNullException("weaponDef");
		}
		return ResolveRuntimeWeaponCycleDuration(weaponDef, Mathf.Max(1, weaponDef.modularBurstCount));
	}

	private static float ResolveRuntimeWeaponCycleDuration(SummerRaceWeaponDefSO weaponDef, int burstCount)
	{
		float num = Mathf.Max(0.02f, weaponDef.modularFireInterval);
		if (burstCount <= 1)
		{
			return num;
		}
		float b = (float)(burstCount - 1) * Mathf.Max(0.02f, weaponDef.burstInterval);
		return Mathf.Max(num, b);
	}

	public static SummerRaceBuildRating Evaluate(SummerRaceBuildProfile profile)
	{
		float num = Mathf.InverseLerp(18f, 80f, profile.TotalMass);
		float num2 = Mathf.InverseLerp(2.5f, 7.5f, profile.CruiseSpeed);
		float num3 = Mathf.InverseLerp(4f, 12f, profile.TractionGain);
		float value = (profile.FrontWheelRadius + profile.BackWheelRadius) * 0.5f;
		float num4 = Mathf.InverseLerp(0.18f, 0.36f, value);
		float num5 = Mathf.InverseLerp(0.4f, 8.5f, profile.EstimatedDps);
		float num6 = Mathf.InverseLerp(0.2f, 6f, profile.RecoilLoad);
		float num7 = ((profile.CostCap > 0) ? Mathf.Clamp01((float)profile.CostUsed / (float)profile.CostCap) : 0.4f);
		float num8 = Mathf.InverseLerp(0f, 0.35f, Mathf.Max(0f, profile.CenterOfMassLocal.y));
		float num9 = Mathf.Clamp01(Mathf.Abs(profile.FrontRearMassBias));
		float num10 = Mathf.InverseLerp(0f, 0.12f, Mathf.Abs(profile.FrontWheelRadius - profile.BackWheelRadius));
		float num11 = Mathf.InverseLerp(0.45f, 1.2f, profile.WheelBase);
		SummerRaceBuildRating result = new SummerRaceBuildRating
		{
			Mobility = 100f * Mathf.Clamp01(0.42f * num2 + 0.3f * num3 + 0.16f * num4 + 0.12f * (1f - num)),
			Stability = 100f * Mathf.Clamp01(0.3f * num + 0.22f * (1f - num8) + 0.2f * (1f - num9) + 0.14f * num11 + 0.14f * (1f - num10)),
			Firepower = 100f * Mathf.Clamp01(0.56f * num5 + 0.22f * num6 + 0.22f * num7)
		};
		result.Overall = Mathf.Clamp01(result.Mobility / 100f * 0.35f + result.Stability / 100f * 0.35f + result.Firepower / 100f * 0.3f) * 100f;
		return result;
	}

	public static SummerRaceBuildArchetype Classify(SummerRaceBuildProfile profile, SummerRaceBuildRating rating)
	{
		if (rating.Overall <= 0.01f)
		{
			return SummerRaceBuildArchetype.Unknown;
		}
		float mobility = rating.Mobility;
		float stability = rating.Stability;
		float firepower = rating.Firepower;
		if (firepower >= mobility + 12f && firepower >= stability + 10f)
		{
			return SummerRaceBuildArchetype.Artillery;
		}
		if (mobility >= stability + 10f && mobility >= firepower + 8f)
		{
			return SummerRaceBuildArchetype.Skirmisher;
		}
		if (stability >= mobility + 8f && stability >= firepower + 6f)
		{
			if (profile.TotalMass >= 42f || profile.FrontRearMassBias > 0.18f)
			{
				return SummerRaceBuildArchetype.Bruiser;
			}
			if (Mathf.Abs(profile.FrontRearMassBias) >= 0.3f || Mathf.Abs(profile.FrontWheelRadius - profile.BackWheelRadius) >= 0.09f)
			{
				return SummerRaceBuildArchetype.Disruptor;
			}
			return SummerRaceBuildArchetype.Balanced;
		}
		if (Mathf.Abs(profile.FrontRearMassBias) >= 0.26f || Mathf.Abs(profile.FrontWheelRadius - profile.BackWheelRadius) >= 0.08f)
		{
			return SummerRaceBuildArchetype.Disruptor;
		}
		return SummerRaceBuildArchetype.Balanced;
	}

	public static string GetArchetypeLabel(SummerRaceBuildArchetype archetype)
	{
		return archetype switch
		{
			SummerRaceBuildArchetype.Balanced => "重型", 
			SummerRaceBuildArchetype.Skirmisher => "突击", 
			SummerRaceBuildArchetype.Bruiser => "重型", 
			SummerRaceBuildArchetype.Artillery => "", 
			SummerRaceBuildArchetype.Disruptor => "", 
			_ => "", 
		};
	}

	public static string BuildSignature(SummerRaceBuildProfile profile)
	{
		string text = profile.BodyType.ToString();
		string text2 = BuildEnumArraySignature(profile.Weapons);
		string text3 = BuildEnumArraySignature(profile.Equips);
		int num = Mathf.RoundToInt(profile.FrontWheelRadius * 100f);
		int num2 = Mathf.RoundToInt(profile.BackWheelRadius * 100f);
		return text + "|" + text2 + "|" + text3 + "|W" + num + "_" + num2;
	}

	public static string BuildSignature(SummerRaceBuildBlueprint blueprint)
	{
		string text = blueprint.BodyType.ToString();
		string text2 = BuildEnumArraySignature(blueprint.Weapons);
		string text3 = BuildEnumArraySignature(blueprint.Equips);
		return text + "|" + text2 + "|" + text3;
	}

	public static string Describe(SummerRaceBuildProfile profile, SummerRaceBuildRating rating)
	{
		string text = ((rating.Mobility >= 70f) ? "HighMobility" : ((rating.Mobility <= 35f) ? "LowMobility" : "BalancedMobility"));
		string text2 = ((rating.Stability >= 70f) ? "HighStability" : ((rating.Stability <= 35f) ? "HighRisk" : "BalancedStability"));
		string text3 = ((rating.Firepower >= 70f) ? "HighFirepower" : ((rating.Firepower <= 35f) ? "LowFirepower" : "BalancedFirepower"));
		if (profile.FrontRearMassBias > 0.22f)
		{
			return text + " / " + text2 + " / " + text3 + " / FrontHeavy";
		}
		if (profile.FrontRearMassBias < -0.22f)
		{
			return text + " / " + text2 + " / " + text3 + " / RearHeavy";
		}
		return text + " / " + text2 + " / " + text3;
	}

	private static string BuildEnumArraySignature<TEnum>(TEnum[] arr) where TEnum : struct
	{
		if (arr == null || arr.Length == 0)
		{
			return "-";
		}
		string[] array = new string[arr.Length];
		for (int i = 0; i < arr.Length; i++)
		{
			array[i] = arr[i].ToString();
		}
		return string.Join("+", array);
	}
}
