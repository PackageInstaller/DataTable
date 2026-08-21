using System;
using System.Diagnostics;
using UnityEngine;

namespace ParadoxNotion.Design;

public static class UndoUtility
{
	public static string lastOperationName { get; private set; }

	[Conditional("UNITY_EDITOR")]
	public static void RecordObject(UnityEngine.Object target, string name)
	{
	}

	[Conditional("UNITY_EDITOR")]
	public static void RecordObjectComplete(UnityEngine.Object target, string name)
	{
	}

	[Conditional("UNITY_EDITOR")]
	public static void SetDirty(UnityEngine.Object target)
	{
	}

	[Conditional("UNITY_EDITOR")]
	public static void RecordObject(UnityEngine.Object target, string name, Action operation)
	{
		operation();
	}

	[Conditional("UNITY_EDITOR")]
	public static void RecordObjectComplete(UnityEngine.Object target, string name, Action operation)
	{
		operation();
	}

	public static string GetLastOperationNameOr(string operation)
	{
		if (!string.IsNullOrEmpty(lastOperationName))
		{
			return lastOperationName;
		}
		return operation;
	}

	public static void CheckUndo(UnityEngine.Object target, string name)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Invalid comparison between Unknown and I4
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Invalid comparison between Unknown and I4
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Invalid comparison between Unknown and I4
		Event current = Event.current;
		if ((int)current.type == 0 || (int)current.type == 4 || (int)current.type == 10 || (int)current.type == 14)
		{
			lastOperationName = name;
		}
	}

	public static void CheckDirty(UnityEngine.Object target)
	{
		_ = GUI.changed;
	}
}
