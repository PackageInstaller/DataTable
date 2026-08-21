using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngineInternal;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Resources/Resources.bindings.h")]
[NativeHeader("Runtime/Misc/ResourceManagerUtility.h")]
public sealed class Resources
{
	internal static T[] ConvertObjects<T>(Object[] rawObjects) where T : Object
	{
		if (rawObjects == null)
		{
			return null;
		}
		T[] array = new T[rawObjects.Length];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = (T)rawObjects[i];
		}
		return array;
	}

	public static Object[] FindObjectsOfTypeAll(Type type)
	{
		return ResourcesAPI.ActiveAPI.FindObjectsOfTypeAll(type);
	}

	public static T[] FindObjectsOfTypeAll<T>() where T : Object
	{
		return ConvertObjects<T>(FindObjectsOfTypeAll(typeof(T)));
	}

	public static Object Load(string path)
	{
		return Load(path, typeof(Object));
	}

	public static T Load<T>(string path) where T : Object
	{
		return (T)Load(path, typeof(T));
	}

	public static Object Load(string path, Type systemTypeInstance)
	{
		return ResourcesAPI.ActiveAPI.Load(path, systemTypeInstance);
	}

	public static ResourceRequest LoadAsync(string path)
	{
		return LoadAsync(path, typeof(Object));
	}

	public static ResourceRequest LoadAsync<T>(string path) where T : Object
	{
		return LoadAsync(path, typeof(T));
	}

	public static ResourceRequest LoadAsync(string path, Type type)
	{
		return ResourcesAPI.ActiveAPI.LoadAsync(path, type);
	}

	public static Object[] LoadAll(string path, Type systemTypeInstance)
	{
		return ResourcesAPI.ActiveAPI.LoadAll(path, systemTypeInstance);
	}

	public static Object[] LoadAll(string path)
	{
		return LoadAll(path, typeof(Object));
	}

	public static T[] LoadAll<T>(string path) where T : Object
	{
		return ConvertObjects<T>(LoadAll(path, typeof(T)));
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetScriptingBuiltinResource", ThrowsException = true)]
	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	public static extern Object GetBuiltinResource([NotNull("ArgumentNullException")] Type type, string path);

	public static T GetBuiltinResource<T>(string path) where T : Object
	{
		return (T)GetBuiltinResource(typeof(T), path);
	}

	public static void UnloadAsset(Object assetToUnload)
	{
		ResourcesAPI.ActiveAPI.UnloadAsset(assetToUnload);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Scripting::UnloadAssetFromScripting")]
	private static extern void UnloadAssetImplResourceManager(Object assetToUnload);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Resources_Bindings::UnloadUnusedAssets")]
	public static extern AsyncOperation UnloadUnusedAssets();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Resources_Bindings::InstanceIDToObject")]
	public static extern Object InstanceIDToObject(int instanceID);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Resources_Bindings::InstanceIDToObjectList")]
	private static extern void InstanceIDToObjectList(IntPtr instanceIDs, int instanceCount, List<Object> objects);

	public unsafe static void InstanceIDToObjectList(NativeArray<int> instanceIDs, List<Object> objects)
	{
		if (!instanceIDs.IsCreated)
		{
			throw new ArgumentException("NativeArray is uninitialized", "instanceIDs");
		}
		if (objects == null)
		{
			throw new ArgumentNullException("objects");
		}
		if (instanceIDs.Length == 0)
		{
			objects.Clear();
		}
		else
		{
			InstanceIDToObjectList((IntPtr)instanceIDs.GetUnsafeReadOnlyPtr(), instanceIDs.Length, objects);
		}
	}
}
