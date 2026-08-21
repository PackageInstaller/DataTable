using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting;
using UnityEngineInternal;

namespace UnityEngine;

[UsedByNativeCode]
[ExcludeFromPreset]
[NativeHeader("Runtime/Export/Scripting/GameObject.bindings.h")]
public sealed class GameObject : Object
{
	public extern Transform transform
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GameObjectBindings::GetTransform", HasExplicitThis = true)]
		get;
	}

	public extern int layer
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[Obsolete("GameObject.active is obsolete. Use GameObject.SetActive(), GameObject.activeSelf or GameObject.activeInHierarchy.")]
	public extern bool active
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "IsActive")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "SetSelfActive")]
		set;
	}

	public extern bool activeSelf
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "IsSelfActive")]
		get;
	}

	public extern bool activeInHierarchy
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "IsActive")]
		get;
	}

	public extern bool isStatic
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "GetIsStaticDeprecated")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "SetIsStaticDeprecated")]
		set;
	}

	internal extern bool isStaticBatchable
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod(Name = "IsStaticBatchable")]
		get;
	}

	public extern string tag
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GameObjectBindings::GetTag", HasExplicitThis = true)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction("GameObjectBindings::SetTag", HasExplicitThis = true)]
		set;
	}

	public Scene scene
	{
		[FreeFunction("GameObjectBindings::GetScene", HasExplicitThis = true)]
		get
		{
			get_scene_Injected(out var ret);
			return ret;
		}
	}

	public extern ulong sceneCullingMask
	{
		[MethodImpl((MethodImplOptions)4096)]
		[FreeFunction(Name = "GameObjectBindings::GetSceneCullingMask", HasExplicitThis = true)]
		get;
	}

	public GameObject gameObject => this;

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GameObjectBindings::CreatePrimitive")]
	public static extern GameObject CreatePrimitive(PrimitiveType type);

	public unsafe T GetComponent<T>()
	{
		CastHelper<T> castHelper = default(CastHelper<T>);
		GetComponentFastPath(typeof(T), new IntPtr(&castHelper.onePointerFurtherThanT));
		return castHelper.t;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	[FreeFunction(Name = "GameObjectBindings::GetComponentFromType", HasExplicitThis = true, ThrowsException = true)]
	public extern Component GetComponent(Type type);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeWritableSelf]
	[FreeFunction(Name = "GameObjectBindings::GetComponentFastPath", HasExplicitThis = true, ThrowsException = true)]
	internal extern void GetComponentFastPath(Type type, IntPtr oneFurtherThanResultValue);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Scripting::GetScriptingWrapperOfComponentOfGameObject", HasExplicitThis = true)]
	internal extern Component GetComponentByName(string type);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Scripting::GetScriptingWrapperOfComponentOfGameObjectWithCase", HasExplicitThis = true)]
	internal extern Component GetComponentByNameWithCase(string type, bool caseSensitive);

	public Component GetComponent(string type)
	{
		return GetComponentByName(type);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	[FreeFunction(Name = "GameObjectBindings::GetComponentInChildren", HasExplicitThis = true, ThrowsException = true)]
	public extern Component GetComponentInChildren(Type type, bool includeInactive);

	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	public Component GetComponentInChildren(Type type)
	{
		return GetComponentInChildren(type, includeInactive: false);
	}

	[ExcludeFromDocs]
	public T GetComponentInChildren<T>()
	{
		bool includeInactive = false;
		return GetComponentInChildren<T>(includeInactive);
	}

	public T GetComponentInChildren<T>([DefaultValue("false")] bool includeInactive)
	{
		return (T)(object)GetComponentInChildren(typeof(T), includeInactive);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	[FreeFunction(Name = "GameObjectBindings::GetComponentInParent", HasExplicitThis = true, ThrowsException = true)]
	public extern Component GetComponentInParent(Type type, bool includeInactive);

	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	public Component GetComponentInParent(Type type)
	{
		return GetComponentInParent(type, includeInactive: false);
	}

	[ExcludeFromDocs]
	public T GetComponentInParent<T>()
	{
		bool includeInactive = false;
		return GetComponentInParent<T>(includeInactive);
	}

	public T GetComponentInParent<T>([DefaultValue("false")] bool includeInactive)
	{
		return (T)(object)GetComponentInParent(typeof(T), includeInactive);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GameObjectBindings::GetComponentsInternal", HasExplicitThis = true, ThrowsException = true)]
	private extern Array GetComponentsInternal(Type type, bool useSearchTypeAsArrayReturnType, bool recursive, bool includeInactive, bool reverse, object resultList);

	public Component[] GetComponents(Type type)
	{
		return (Component[])GetComponentsInternal(type, useSearchTypeAsArrayReturnType: false, recursive: false, includeInactive: true, reverse: false, null);
	}

	public T[] GetComponents<T>()
	{
		return (T[])GetComponentsInternal(typeof(T), useSearchTypeAsArrayReturnType: true, recursive: false, includeInactive: true, reverse: false, null);
	}

	public void GetComponents(Type type, List<Component> results)
	{
		GetComponentsInternal(type, useSearchTypeAsArrayReturnType: false, recursive: false, includeInactive: true, reverse: false, results);
	}

	public void GetComponents<T>(List<T> results)
	{
		GetComponentsInternal(typeof(T), useSearchTypeAsArrayReturnType: true, recursive: false, includeInactive: true, reverse: false, results);
	}

	[ExcludeFromDocs]
	public Component[] GetComponentsInChildren(Type type)
	{
		bool includeInactive = false;
		return GetComponentsInChildren(type, includeInactive);
	}

	public Component[] GetComponentsInChildren(Type type, [DefaultValue("false")] bool includeInactive)
	{
		return (Component[])GetComponentsInternal(type, useSearchTypeAsArrayReturnType: false, recursive: true, includeInactive, reverse: false, null);
	}

	public T[] GetComponentsInChildren<T>(bool includeInactive)
	{
		return (T[])GetComponentsInternal(typeof(T), useSearchTypeAsArrayReturnType: true, recursive: true, includeInactive, reverse: false, null);
	}

	public void GetComponentsInChildren<T>(bool includeInactive, List<T> results)
	{
		GetComponentsInternal(typeof(T), useSearchTypeAsArrayReturnType: true, recursive: true, includeInactive, reverse: false, results);
	}

	public T[] GetComponentsInChildren<T>()
	{
		return GetComponentsInChildren<T>(includeInactive: false);
	}

	public void GetComponentsInChildren<T>(List<T> results)
	{
		GetComponentsInChildren(includeInactive: false, results);
	}

	[ExcludeFromDocs]
	public Component[] GetComponentsInParent(Type type)
	{
		bool includeInactive = false;
		return GetComponentsInParent(type, includeInactive);
	}

	public Component[] GetComponentsInParent(Type type, [DefaultValue("false")] bool includeInactive)
	{
		return (Component[])GetComponentsInternal(type, useSearchTypeAsArrayReturnType: false, recursive: true, includeInactive, reverse: true, null);
	}

	public void GetComponentsInParent<T>(bool includeInactive, List<T> results)
	{
		GetComponentsInternal(typeof(T), useSearchTypeAsArrayReturnType: true, recursive: true, includeInactive, reverse: true, results);
	}

	public T[] GetComponentsInParent<T>(bool includeInactive)
	{
		return (T[])GetComponentsInternal(typeof(T), useSearchTypeAsArrayReturnType: true, recursive: true, includeInactive, reverse: true, null);
	}

	public T[] GetComponentsInParent<T>()
	{
		return GetComponentsInParent<T>(includeInactive: false);
	}

	public unsafe bool TryGetComponent<T>(out T component)
	{
		CastHelper<T> castHelper = default(CastHelper<T>);
		TryGetComponentFastPath(typeof(T), new IntPtr(&castHelper.onePointerFurtherThanT));
		component = castHelper.t;
		return castHelper.t != null;
	}

	public bool TryGetComponent(Type type, out Component component)
	{
		component = TryGetComponentInternal(type);
		return component != null;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	[FreeFunction(Name = "GameObjectBindings::TryGetComponentFromType", HasExplicitThis = true, ThrowsException = true)]
	internal extern Component TryGetComponentInternal(Type type);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GameObjectBindings::TryGetComponentFastPath", HasExplicitThis = true, ThrowsException = true)]
	[NativeWritableSelf]
	internal extern void TryGetComponentFastPath(Type type, IntPtr oneFurtherThanResultValue);

	public static GameObject FindWithTag(string tag)
	{
		return FindGameObjectWithTag(tag);
	}

	public void SendMessageUpwards(string methodName, SendMessageOptions options)
	{
		SendMessageUpwards(methodName, null, options);
	}

	public void SendMessage(string methodName, SendMessageOptions options)
	{
		SendMessage(methodName, null, options);
	}

	public void BroadcastMessage(string methodName, SendMessageOptions options)
	{
		BroadcastMessage(methodName, null, options);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MonoAddComponent", HasExplicitThis = true)]
	internal extern Component AddComponentInternal(string className);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "MonoAddComponentWithType", HasExplicitThis = true)]
	private extern Component Internal_AddComponentWithType(Type componentType);

	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	public Component AddComponent(Type componentType)
	{
		return Internal_AddComponentWithType(componentType);
	}

	public T AddComponent<T>() where T : Component
	{
		return AddComponent(typeof(T)) as T;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern int GetComponentCount();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeName("QueryComponentAtIndex<Unity::Component>")]
	internal extern Component QueryComponentAtIndex(int index);

	public Component GetComponentAtIndex(int index)
	{
		if (index < 0 || index >= GetComponentCount())
		{
			throw new ArgumentOutOfRangeException("index", "Valid range is 0 to GetComponentCount() - 1.");
		}
		return QueryComponentAtIndex(index);
	}

	public T GetComponentAtIndex<T>(int index) where T : Component
	{
		T val = (T)GetComponentAtIndex(index);
		if (val == null)
		{
			throw new InvalidCastException();
		}
		return val;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public extern int GetComponentIndex(Component component);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "SetSelfActive")]
	public extern void SetActive(bool value);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "SetActiveRecursivelyDeprecated")]
	[Obsolete("gameObject.SetActiveRecursively() is obsolete. Use GameObject.SetActive(), which is now inherited by children.")]
	public extern void SetActiveRecursively(bool state);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GameObjectBindings::CompareTag", HasExplicitThis = true)]
	public extern bool CompareTag(string tag);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GameObjectBindings::FindGameObjectWithTag", ThrowsException = true)]
	public static extern GameObject FindGameObjectWithTag(string tag);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GameObjectBindings::FindGameObjectsWithTag", ThrowsException = true)]
	public static extern GameObject[] FindGameObjectsWithTag(string tag);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Scripting::SendScriptingMessageUpwards", HasExplicitThis = true)]
	public extern void SendMessageUpwards(string methodName, [DefaultValue("null")] object value, [DefaultValue("SendMessageOptions.RequireReceiver")] SendMessageOptions options);

	[ExcludeFromDocs]
	public void SendMessageUpwards(string methodName, object value)
	{
		SendMessageOptions options = SendMessageOptions.RequireReceiver;
		SendMessageUpwards(methodName, value, options);
	}

	[ExcludeFromDocs]
	public void SendMessageUpwards(string methodName)
	{
		SendMessageOptions options = SendMessageOptions.RequireReceiver;
		object value = null;
		SendMessageUpwards(methodName, value, options);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Scripting::SendScriptingMessage", HasExplicitThis = true)]
	public extern void SendMessage(string methodName, [DefaultValue("null")] object value, [DefaultValue("SendMessageOptions.RequireReceiver")] SendMessageOptions options);

	[ExcludeFromDocs]
	public void SendMessage(string methodName, object value)
	{
		SendMessageOptions options = SendMessageOptions.RequireReceiver;
		SendMessage(methodName, value, options);
	}

	[ExcludeFromDocs]
	public void SendMessage(string methodName)
	{
		SendMessageOptions options = SendMessageOptions.RequireReceiver;
		object value = null;
		SendMessage(methodName, value, options);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "Scripting::BroadcastScriptingMessage", HasExplicitThis = true)]
	public extern void BroadcastMessage(string methodName, [DefaultValue("null")] object parameter, [DefaultValue("SendMessageOptions.RequireReceiver")] SendMessageOptions options);

	[ExcludeFromDocs]
	public void BroadcastMessage(string methodName, object parameter)
	{
		SendMessageOptions options = SendMessageOptions.RequireReceiver;
		BroadcastMessage(methodName, parameter, options);
	}

	[ExcludeFromDocs]
	public void BroadcastMessage(string methodName)
	{
		SendMessageOptions options = SendMessageOptions.RequireReceiver;
		object parameter = null;
		BroadcastMessage(methodName, parameter, options);
	}

	public GameObject(string name)
	{
		Internal_CreateGameObject(this, name);
	}

	public GameObject()
	{
		Internal_CreateGameObject(this, null);
	}

	public GameObject(string name, params Type[] components)
	{
		Internal_CreateGameObject(this, name);
		foreach (Type componentType in components)
		{
			AddComponent(componentType);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GameObjectBindings::Internal_CreateGameObject")]
	private static extern void Internal_CreateGameObject([Writable] GameObject self, string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GameObjectBindings::Find")]
	public static extern GameObject Find(string name);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(Name = "GameObjectBindings::SetGameObjectsActiveByInstanceID")]
	private static extern void SetGameObjectsActive(IntPtr instanceIds, int instanceCount, bool active);

	public unsafe static void SetGameObjectsActive(NativeArray<int> instanceIDs, bool active)
	{
		if (!instanceIDs.IsCreated)
		{
			throw new ArgumentException("NativeArray is uninitialized", "instanceIDs");
		}
		if (instanceIDs.Length != 0)
		{
			SetGameObjectsActive((IntPtr)instanceIDs.GetUnsafeReadOnlyPtr(), instanceIDs.Length, active);
		}
	}

	public unsafe static void SetGameObjectsActive(ReadOnlySpan<int> instanceIDs, bool active)
	{
		if (instanceIDs.Length != 0)
		{
			fixed (int* ptr = instanceIDs)
			{
				SetGameObjectsActive((IntPtr)ptr, instanceIDs.Length, active);
			}
		}
	}

	[FreeFunction("GameObjectBindings::InstantiateGameObjectsByInstanceID")]
	private static void InstantiateGameObjects(int sourceInstanceID, IntPtr newInstanceIDs, IntPtr newTransformInstanceIDs, int count, Scene destinationScene)
	{
		InstantiateGameObjects_Injected(sourceInstanceID, newInstanceIDs, newTransformInstanceIDs, count, ref destinationScene);
	}

	public unsafe static void InstantiateGameObjects(int sourceInstanceID, int count, NativeArray<int> newInstanceIDs, NativeArray<int> newTransformInstanceIDs, Scene destinationScene = default(Scene))
	{
		if (!newInstanceIDs.IsCreated)
		{
			throw new ArgumentException("NativeArray is uninitialized", "newInstanceIDs");
		}
		if (!newTransformInstanceIDs.IsCreated)
		{
			throw new ArgumentException("NativeArray is uninitialized", "newTransformInstanceIDs");
		}
		if (count != 0)
		{
			if (count != newInstanceIDs.Length || count != newTransformInstanceIDs.Length)
			{
				throw new ArgumentException("Size mismatch! Both arrays must already be the size of count.");
			}
			InstantiateGameObjects(sourceInstanceID, (IntPtr)newInstanceIDs.GetUnsafeReadOnlyPtr(), (IntPtr)newTransformInstanceIDs.GetUnsafeReadOnlyPtr(), newInstanceIDs.Length, destinationScene);
		}
	}

	[FreeFunction(Name = "GameObjectBindings::GetSceneByInstanceID")]
	public static Scene GetScene(int instanceID)
	{
		GetScene_Injected(instanceID, out var ret);
		return ret;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void InstantiateGameObjects_Injected(int sourceInstanceID, IntPtr newInstanceIDs, IntPtr newTransformInstanceIDs, int count, ref Scene destinationScene);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetScene_Injected(int instanceID, out Scene ret);

	[MethodImpl((MethodImplOptions)4096)]
	[SpecialName]
	private extern void get_scene_Injected(out Scene ret);
}
