using System;
using System.Collections.Generic;
using NodeCanvas.Framework.Internal;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer.Internal;
using UnityEngine;

public static class fsSerializationContext
{
	public static GraphSerializationData graphData;

	public static IfsGraphLookupType mLookupType;

	public static List<UnityEngine.Object> mUnityReferences;

	public static Type GetVarType(int typeCode)
	{
		mLookupType.Types.TryGetValue(typeCode, out var value);
		return value;
	}

	public static int GetTypeCode(Type t)
	{
		if (mLookupType == null)
		{
			mLookupType = GameObject.Find("IfsGraphLookupType").GetComponent<IfsGraphLookupType>();
		}
		foreach (KeyValuePair<int, Type> type in mLookupType.Types)
		{
			if (type.Value == t)
			{
				return type.Key;
			}
		}
		Debug.LogError(t.FullName + " is not exsit!!!!!!!!, add it!");
		int curIndex = mLookupType.CurIndex;
		mLookupType.Types[curIndex] = t;
		mLookupType.CurIndex++;
		return curIndex;
	}

	public static bool RequestCycleSupport(Type storageType)
	{
		if (storageType == typeof(string))
		{
			return false;
		}
		if (!storageType.Resolve().IsClass)
		{
			return storageType.Resolve().IsInterface;
		}
		return true;
	}

	public static void Clear()
	{
		mUnityReferences = null;
		graphData = null;
	}
}
