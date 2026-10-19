using System.Collections.Generic;
using System.Text;
using UnityEngine;

namespace Cinemachine.Utility;

public class CinemachineDebug
{
	public delegate void OnGUIDelegate();

	private static HashSet<Object> mClients;

	public static OnGUIDelegate OnGUIHandlers;

	private static List<StringBuilder> mAvailableStringBuilders;

	public static void ReleaseScreenPos(Object client)
	{
		if (mClients != null && mClients.Contains(client))
		{
			mClients.Remove(client);
		}
	}

	public static Rect GetScreenPos(Object client, string text, GUIStyle style)
	{
		if (mClients == null)
		{
			mClients = new HashSet<Object>();
		}
		if (!mClients.Contains(client))
		{
			mClients.Add(client);
		}
		Vector2 zero = Vector2.zero;
		Vector2 size = style.CalcSize(new GUIContent(text));
		if (mClients != null)
		{
			using HashSet<Object>.Enumerator enumerator = mClients.GetEnumerator();
			while (enumerator.MoveNext() && !(enumerator.Current == client))
			{
				zero.y += size.y;
			}
		}
		return new Rect(zero, size);
	}

	public static StringBuilder SBFromPool()
	{
		if (mAvailableStringBuilders == null || mAvailableStringBuilders.Count == 0)
		{
			return new StringBuilder();
		}
		StringBuilder stringBuilder = mAvailableStringBuilders[mAvailableStringBuilders.Count - 1];
		mAvailableStringBuilders.RemoveAt(mAvailableStringBuilders.Count - 1);
		stringBuilder.Length = 0;
		return stringBuilder;
	}

	public static void ReturnToPool(StringBuilder sb)
	{
		if (mAvailableStringBuilders == null)
		{
			mAvailableStringBuilders = new List<StringBuilder>();
		}
		mAvailableStringBuilders.Add(sb);
	}
}
