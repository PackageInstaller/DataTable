using System;
using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public static class StoryUtility
{
	private const string UsersNameKey = "<玩家名>";

	private const string UsersPortraitKey = "<主角立绘>";

	private const string UsersPortraitPrefix = "PlayerCharacter_";

	public static int GetCharacterIndex()
	{
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		if (service != null && service.GetRoleData() != null)
		{
			return service.GetRoleData().PlayerInfo.CharacterIndex;
		}
		return 1;
	}

	public static string GetName()
	{
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		if (service != null && service.GetRoleData() != null)
		{
			return service.GetRoleData().PlayerInfo.Name;
		}
		return "没有名字的家伙";
	}

	public static string ReplaceUsersName(string text)
	{
		string empty = string.Empty;
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		empty = ((service == null || service.GetRoleData() == null) ? "没有名字的家伙" : service.GetRoleData().PlayerInfo.Name);
		return text.Replace("<玩家名>", empty);
	}

	public static string TryReplaceUsersName(string text, out bool result)
	{
		result = text.Contains("<玩家名>");
		if (!result)
		{
			return text;
		}
		string empty = string.Empty;
		IRoleService service = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		empty = ((service == null || service.GetRoleData() == null) ? "没有名字的家伙" : service.GetRoleData().PlayerInfo.Name);
		return text.Replace("<玩家名>", empty);
	}

	public static string GetCharacterPortrait(string portraitName)
	{
		if (portraitName != "<主角立绘>")
		{
			return portraitName;
		}
		return "PlayerCharacter_" + GetCharacterIndex();
	}

	public static string GetStreamerMode()
	{
		if (!StreamerMode.GetStreamerMode())
		{
			return "weihexie";
		}
		return "hexie";
	}

	public static List<T> ToList<T>(this IEnumerable<T> array)
	{
		List<T> list = new List<T>();
		foreach (T item in array)
		{
			list.Add(item);
		}
		return list;
	}

	public static List<T> ToList<T>(this T[] array)
	{
		if (array == null)
		{
			return null;
		}
		List<T> list = new List<T>();
		foreach (T item in array)
		{
			list.Add(item);
		}
		return list;
	}

	public static List<T> Where<T>(this IEnumerable<T> array, Func<T, bool> predicate)
	{
		if (array == null)
		{
			return null;
		}
		List<T> list = new List<T>();
		foreach (T item in array)
		{
			if (predicate(item))
			{
				list.Add(item);
			}
		}
		return list;
	}

	public static List<T> Where<T>(this T[] array, Func<T, bool> predicate)
	{
		if (array == null)
		{
			return null;
		}
		List<T> list = new List<T>();
		foreach (T val in array)
		{
			if (predicate(val))
			{
				list.Add(val);
			}
		}
		return list;
	}

	private static IEnumerator<T> GenericLerp<T>(T start, T end, float moveTime, Func<T, T, float, T> lerpFunction)
	{
		float t = 0f;
		while (t < 1f)
		{
			t += Time.deltaTime * DialogueGlobals.Speed / Mathf.Max(0.001f, moveTime);
			yield return lerpFunction(start, end, t);
		}
		yield return end;
	}

	public static IEnumerator<float> FloatLerp(float oriFloat, float targetFloat, float moveTime)
	{
		return GenericLerp(oriFloat, targetFloat, moveTime, Mathf.Lerp);
	}

	public static IEnumerator<Vector2> Vector2Lerp(Vector2 oriV2, Vector2 targetV2, float moveTime)
	{
		return GenericLerp(oriV2, targetV2, moveTime, Vector2.Lerp);
	}

	public static IEnumerator<Vector3> Vector3Lerp(Vector3 oriV3, Vector3 targetV3, float moveTime)
	{
		return GenericLerp(oriV3, targetV3, moveTime, Vector3.Lerp);
	}

	public static IEnumerator<Color> ColorLerp(Color oriCol, Color targetCol, float moveTime)
	{
		return GenericLerp(oriCol, targetCol, moveTime, Color.Lerp);
	}
}
