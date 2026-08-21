using UnityEngine;

public static class QWorldHelper
{
	private static int mCharacterMask = -1;

	public static int CharacterMask
	{
		get
		{
			if (mCharacterMask == -1)
			{
				mCharacterMask = LayerMask.GetMask("Character");
			}
			return mCharacterMask;
		}
	}

	public static void Teleport(int ptId, bool needReset = false)
	{
		QWorldScene.Scene.teleportManager.StartTeleport(ptId, needReset);
	}

	public static void TeleportToNearest(Vector3 positon, bool needReset = false)
	{
		QWorldScene.Scene.teleportManager.TeleportToNearest(positon);
	}

	public static void TeleportToCachePos(Vector3 position, Quaternion rotation, bool needReset = false, bool ignoreCamera = false)
	{
		QWorldScene.Scene.teleportManager.TeleportToCachePos(position, rotation, needReset, ignoreCamera);
	}

	public static QWCharacterAgent GetPlayer()
	{
		return (NScene.GetCurrentScene() as QWorldScene).Agent;
	}

	public static string GetStoryWordContent(int id)
	{
		return LuaHelper.CallFunction("QWorldLuaBridge", id)[0].ToString();
	}

	public static float GetRadiusFromThreePoint(Vector2 p1, Vector2 p2, Vector2 p3)
	{
		float num = Vector2.Distance(p1, p2);
		float num2 = Vector2.Distance(p1, p3);
		float num3 = Vector2.Distance(p2, p3);
		float num4 = (num + num2 + num3) / 2f;
		float num5 = Mathf.Sqrt(num4 * (num4 - num) * (num4 - num2) * (num4 - num3));
		return num * num2 * num3 / 4f * num5;
	}
}
