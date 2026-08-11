using UnityEngine;

namespace Ase.ECS;

public static class HitVolumeLog
{
	public static bool isLog = false;

	public static bool isLogCollider = false;

	public static bool isLogBulletHitPoint = false;

	public static Color entityLogColor = Color.yellow;

	public static Color bulletLogColor = Color.yellow;

	public static Color bulletMorphColor = Color.red;

	public static Color bulletAlertLogColor = Color.green;

	public static Color bulletHitPointColor = Color.green;

	public static float entityLogDuration = 0.05f;

	public static float bulletLogDuration = 0.05f;

	public static float bulletHitPointLogDuration = 0.2f;

	public static void Log(HitVolume hitVolume)
	{
	}

	public static void Log(HitVolume hitVolume, Color color, float duration, float scale = 1f)
	{
		_ = isLog;
	}

	public static void EntityLog(HitVolume hitVolume)
	{
		_ = isLog;
	}

	public static void BulletNormalLog(HitVolume hitVolume)
	{
		_ = isLog;
	}

	public static void BulletMorphLog(HitVolume hitVolume)
	{
		_ = isLog;
	}

	public static void BulletAlretLog(HitVolume hitVolume)
	{
		_ = isLog;
	}

	public static void BulletHitPointLog(Vector3 point)
	{
		_ = isLogBulletHitPoint;
	}
}
