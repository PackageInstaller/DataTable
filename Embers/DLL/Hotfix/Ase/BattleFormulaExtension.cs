using System;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public static class BattleFormulaExtension
{
	public static float GetAttackerProperty(this BuffDataDamage dataDamage, string propertyKey, PropertyType propertyType = PropertyType.Cur)
	{
		if (dataDamage == null)
		{
			return 0f;
		}
		BulletParentPropertyData bulletParentPropertyData = dataDamage.bulletAttackData?.BulletParentPropertyData;
		if (bulletParentPropertyData == null)
		{
			return 0f;
		}
		if (bulletParentPropertyData.AttackerProperty != null)
		{
			if (BattleFormulaUtility.CheckSpecialProperty(propertyKey))
			{
				return BattleFormulaUtility.GetSpecialPropertyAddition(bulletParentPropertyData.AttackerProperty, propertyKey, propertyType);
			}
			Ase.ECS.PropertyData value = null;
			if (bulletParentPropertyData.AttackerProperty.TryGetValue(propertyKey, out value))
			{
				switch (propertyType)
				{
				case PropertyType.Min:
					return value.MinValue;
				case PropertyType.Max:
					return value.MaxValue;
				case PropertyType.Init:
					return value.InitValue;
				case PropertyType.Cur:
					return value.CurValue;
				}
			}
		}
		return 0f;
	}

	public static float GetAttackLight(this BuffDataDamage dataDamage, string propertyKey)
	{
		if (dataDamage == null)
		{
			return 0f;
		}
		BulletParentPropertyData bulletParentPropertyData = dataDamage.bulletAttackData?.BulletParentPropertyData;
		if (bulletParentPropertyData == null)
		{
			return 0f;
		}
		if (bulletParentPropertyData.AttackerPropertyLight != null)
		{
			float value = 0f;
			bulletParentPropertyData.AttackerPropertyLight.TryGetValue(propertyKey, out value);
			return value;
		}
		return 0f;
	}

	public static float Round2(this float value)
	{
		return Mathf.Round(value * 100f) / 100f;
	}

	public static float FloorRound(this float value, int digits = 4)
	{
		LockstepData.Instance?.WriteAuthorityEntityId("FloorRond float ------------> " + value);
		float num = Mathf.Pow(10f, digits);
		return Mathf.Floor(value * num) / num;
	}

	public static double FollorRound(this double value, int digits = 4)
	{
		LockstepData.Instance?.WriteAuthorityEntityId("FloorRond double ------------> " + value);
		double num = Math.Pow(10.0, digits);
		return Math.Floor(value * num) / num;
	}

	public static double FollorRoundToDouble(this float value, int digits = 4)
	{
		LockstepData.Instance?.WriteAuthorityEntityId("FollorRondToDouble float ------------> " + value);
		double num = Math.Pow(10.0, digits);
		return Math.Floor((double)value * num) / num;
	}

	public static Vector2 Round2(this Vector2 value)
	{
		value.x = Mathf.Round(value.x * 100f) / 100f;
		value.y = Mathf.Round(value.y * 100f) / 100f;
		return value;
	}

	public static Vector3 Round2(this Vector3 value)
	{
		value.x = Mathf.Round(value.x * 100f) / 100f;
		value.y = Mathf.Round(value.y * 100f) / 100f;
		value.z = Mathf.Round(value.z * 100f) / 100f;
		return value;
	}

	public static Vector3 FloorRound(this Vector3 value, int digits = 4)
	{
		value.x = value.x.FloorRound();
		value.y = value.y.FloorRound();
		value.z = value.z.FloorRound();
		return value;
	}

	public static int CeilToInt(this float value, int decimals = 4)
	{
		LockstepData.Instance?.WriteAuthorityEntityId("CeilToInt float ------------> " + value);
		float num = Mathf.Pow(10f, decimals);
		return Mathf.CeilToInt(Mathf.Floor(value * num) / num);
	}

	public static int CeilToInt(this double value, int decimals = 4)
	{
		LockstepData.Instance?.WriteAuthorityEntityId("CeilToInt double ------------> " + value);
		double num = Math.Pow(10.0, decimals);
		return (int)Math.Ceiling(Math.Floor(value * num) / num);
	}

	public static bool FloatEquals(this float a, float b, float epsilon = 1E-06f)
	{
		return Mathf.Abs(a - b) < epsilon;
	}
}
