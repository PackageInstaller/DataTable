using System;
using UnityEngine;
using UnityEngine.SceneManagement;

public class RefCounter
{
	public int refCount;

	public static Func<string, Type, UnityEngine.Object> OnEditorLoad;

	public static Func<string, Type, UnityEngine.Object[]> OnEditorLoadAll;

	public static Func<string, LoadSceneParameters, AsyncOperation> OnEditorSceneLoad;

	public static Action<string> OnEditorSceneUnLoad;

	public void IncreaseRefCount()
	{
		refCount++;
	}

	public int DecrementRefCount()
	{
		refCount--;
		return refCount;
	}
}
