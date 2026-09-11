using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.SceneManagement;
using UnityEngine.Scripting;
using UnityEngineInternal;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode(GenerateProxy = true)]
[NativeHeader("Runtime/GameCode/CloneObject.h")]
[NativeHeader("Runtime/SceneManager/SceneManager.h")]
[NativeHeader("Runtime/Export/Scripting/UnityEngineObject.bindings.h")]
public class Object
{
	private IntPtr m_CachedPtr;

	internal static int OffsetOfInstanceIDInCPlusPlusObject = -1;

	private const string objectIsNullMessage = "The Object you want to instantiate is null.";

	private const string cloneDestroyedMessage = "Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.";

	public string name
	{
		get
		{
			return GetName(this);
		}
		set
		{
			SetName(this, value);
		}
	}

	public extern HideFlags hideFlags
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	public unsafe int GetInstanceID()
	{
		if (m_CachedPtr == IntPtr.Zero)
		{
			return 0;
		}
		if (OffsetOfInstanceIDInCPlusPlusObject == -1)
		{
			OffsetOfInstanceIDInCPlusPlusObject = GetOffsetOfInstanceIDInCPlusPlusObject();
		}
		return *(int*)(void*)new IntPtr(m_CachedPtr.ToInt64() + OffsetOfInstanceIDInCPlusPlusObject);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public override bool Equals(object other)
	{
		Object obj = other as Object;
		if (obj == null && other != null && !(other is Object))
		{
			return false;
		}
		return CompareBaseObjects(this, obj);
	}

	public static implicit operator bool(Object exists)
	{
		return !CompareBaseObjects(exists, null);
	}

	private static bool CompareBaseObjects(Object lhs, Object rhs)
	{
		bool flag = (object)lhs == null;
		bool flag2 = (object)rhs == null;
		if (flag2 & flag)
		{
			return true;
		}
		if (flag2)
		{
			return !IsNativeObjectAlive(lhs);
		}
		if (flag)
		{
			return !IsNativeObjectAlive(rhs);
		}
		return (object)lhs == rhs;
	}

	private void EnsureRunningOnMainThread()
	{
		if (!CurrentThreadIsMainThread())
		{
			throw new InvalidOperationException("EnsureRunningOnMainThread can only be called from the main thread");
		}
	}

	private static bool IsNativeObjectAlive(Object o)
	{
		return o.GetCachedPtr() != IntPtr.Zero;
	}

	private IntPtr GetCachedPtr()
	{
		return m_CachedPtr;
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original) where T : Object
	{
		return InstantiateAsync(original, new InstantiateParameters
		{
			worldSpace = true
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, Transform parent) where T : Object
	{
		return InstantiateAsync(original, new InstantiateParameters
		{
			worldSpace = true,
			parent = parent
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, Vector3 position, Quaternion rotation) where T : Object
	{
		return InstantiateAsync(original, position, rotation, new InstantiateParameters
		{
			worldSpace = true
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, Transform parent, Vector3 position, Quaternion rotation) where T : Object
	{
		return InstantiateAsync(original, position, rotation, new InstantiateParameters
		{
			worldSpace = true,
			parent = parent
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count) where T : Object
	{
		return InstantiateAsync(original, count, new InstantiateParameters
		{
			worldSpace = true
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count, Transform parent) where T : Object
	{
		return InstantiateAsync(original, count, new InstantiateParameters
		{
			worldSpace = true,
			parent = parent
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count, Vector3 position, Quaternion rotation) where T : Object
	{
		return InstantiateAsync(original, count, position, rotation, new InstantiateParameters
		{
			worldSpace = true
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count, ReadOnlySpan<Vector3> positions, ReadOnlySpan<Quaternion> rotations) where T : Object
	{
		return InstantiateAsync(original, count, positions, rotations, new InstantiateParameters
		{
			worldSpace = true
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count, Transform parent, Vector3 position, Quaternion rotation) where T : Object
	{
		return InstantiateAsync(original, count, position, rotation, new InstantiateParameters
		{
			worldSpace = true,
			parent = parent
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count, Transform parent, ReadOnlySpan<Vector3> positions, ReadOnlySpan<Quaternion> rotations) where T : Object
	{
		return InstantiateAsync(original, count, positions, rotations, new InstantiateParameters
		{
			worldSpace = true,
			parent = parent
		});
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, InstantiateParameters parameters) where T : Object
	{
		return InstantiateAsync(original, 1, parameters);
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count, InstantiateParameters parameters) where T : Object
	{
		return InstantiateAsync(original, count, ReadOnlySpan<Vector3>.Empty, ReadOnlySpan<Quaternion>.Empty, parameters);
	}

	public static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, Vector3 position, Quaternion rotation, InstantiateParameters parameters) where T : Object
	{
		return InstantiateAsync(original, 1, position, rotation, parameters);
	}

	public unsafe static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count, Vector3 position, Quaternion rotation, InstantiateParameters parameters) where T : Object
	{
		return InstantiateAsync(original, count, new ReadOnlySpan<Vector3>(&position, 1), new ReadOnlySpan<Quaternion>(&rotation, 1), parameters);
	}

	[MethodImpl((MethodImplOptions)768)]
	public unsafe static AsyncInstantiateOperation<T> InstantiateAsync<T>(T original, int count, ReadOnlySpan<Vector3> positions, ReadOnlySpan<Quaternion> rotations, InstantiateParameters parameters) where T : Object
	{
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		if (count <= 0)
		{
			throw new ArgumentException("Cannot call instantiate multiple with count less or equal to zero");
		}
		fixed (Vector3* ptr = positions)
		{
			fixed (Quaternion* ptr2 = rotations)
			{
				AsyncInstantiateOperation op = Internal_InstantiateAsyncWithParams(original, count, parameters, (IntPtr)ptr, positions.Length, (IntPtr)ptr2, rotations.Length);
				return new AsyncInstantiateOperation<T>(op);
			}
		}
	}

	[TypeInferenceRule(TypeInferenceRules.TypeOfFirstArgument)]
	public static Object Instantiate(Object original, Vector3 position, Quaternion rotation)
	{
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		if (original is ScriptableObject)
		{
			throw new ArgumentException("Cannot instantiate a ScriptableObject with a position and rotation");
		}
		Object obj = Internal_InstantiateSingle(original, position, rotation);
		if (obj == null)
		{
			throw new UnityException("Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.");
		}
		return obj;
	}

	[TypeInferenceRule(TypeInferenceRules.TypeOfFirstArgument)]
	public static Object Instantiate(Object original, Vector3 position, Quaternion rotation, Transform parent)
	{
		if (parent == null)
		{
			return Instantiate(original, position, rotation);
		}
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		Object obj = Internal_InstantiateSingleWithParent(original, parent, position, rotation);
		if (obj == null)
		{
			throw new UnityException("Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.");
		}
		return obj;
	}

	[TypeInferenceRule(TypeInferenceRules.TypeOfFirstArgument)]
	public static Object Instantiate(Object original)
	{
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		Object obj = Internal_CloneSingle(original);
		if (obj == null)
		{
			throw new UnityException("Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.");
		}
		return obj;
	}

	[TypeInferenceRule(TypeInferenceRules.TypeOfFirstArgument)]
	public static Object Instantiate(Object original, Scene scene)
	{
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		Object obj = Internal_CloneSingleWithScene(original, scene);
		if (obj == null)
		{
			throw new UnityException("Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.");
		}
		return obj;
	}

	public static T Instantiate<T>(T original, InstantiateParameters parameters) where T : Object
	{
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		T val = (T)Internal_CloneSingleWithParams(original, parameters);
		if (val == null)
		{
			throw new UnityException("Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.");
		}
		return val;
	}

	public static T Instantiate<T>(T original, Vector3 position, Quaternion rotation, InstantiateParameters parameters) where T : Object
	{
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		T val = (T)Internal_InstantiateSingleWithParams(original, position, rotation, parameters);
		if (val == null)
		{
			throw new UnityException("Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.");
		}
		return val;
	}

	[TypeInferenceRule(TypeInferenceRules.TypeOfFirstArgument)]
	public static Object Instantiate(Object original, Transform parent)
	{
		return Instantiate(original, parent, instantiateInWorldSpace: false);
	}

	[TypeInferenceRule(TypeInferenceRules.TypeOfFirstArgument)]
	public static Object Instantiate(Object original, Transform parent, bool instantiateInWorldSpace)
	{
		if (parent == null)
		{
			return Instantiate(original);
		}
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		Object obj = Internal_CloneSingleWithParent(original, parent, instantiateInWorldSpace);
		if (obj == null)
		{
			throw new UnityException("Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.");
		}
		return obj;
	}

	public static T Instantiate<T>(T original) where T : Object
	{
		CheckNullArgument(original, "The Object you want to instantiate is null.");
		T val = (T)Internal_CloneSingle(original);
		if (val == null)
		{
			throw new UnityException("Instantiate failed because the clone was destroyed during creation. This can happen if DestroyImmediate is called in MonoBehaviour.Awake.");
		}
		return val;
	}

	public static T Instantiate<T>(T original, Vector3 position, Quaternion rotation) where T : Object
	{
		return (T)Instantiate((Object)original, position, rotation);
	}

	public static T Instantiate<T>(T original, Vector3 position, Quaternion rotation, Transform parent) where T : Object
	{
		return (T)Instantiate((Object)original, position, rotation, parent);
	}

	public static T Instantiate<T>(T original, Transform parent) where T : Object
	{
		return Instantiate(original, parent, worldPositionStays: false);
	}

	public static T Instantiate<T>(T original, Transform parent, bool worldPositionStays) where T : Object
	{
		return (T)Instantiate((Object)original, parent, worldPositionStays);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "Scripting::DestroyObjectFromScripting", IsFreeFunction = true, ThrowsException = true)]
	public static extern void Destroy(Object obj, [DefaultValue("0.0F")] float t);

	[ExcludeFromDocs]
	public static void Destroy(Object obj)
	{
		float t = 0f;
		Destroy(obj, t);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "Scripting::DestroyObjectFromScriptingImmediate", IsFreeFunction = true, ThrowsException = true)]
	public static extern void DestroyImmediate(Object obj, [DefaultValue("false")] bool allowDestroyingAssets);

	[ExcludeFromDocs]
	public static void DestroyImmediate(Object obj)
	{
		bool allowDestroyingAssets = false;
		DestroyImmediate(obj, allowDestroyingAssets);
	}

	public static Object[] FindObjectsOfType(Type type)
	{
		return FindObjectsOfType(type, includeInactive: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::FindObjectsOfType")]
	[TypeInferenceRule(TypeInferenceRules.ArrayOfTypeReferencedByFirstArgument)]
	public static extern Object[] FindObjectsOfType(Type type, bool includeInactive);

	public static Object[] FindObjectsByType(Type type, FindObjectsSortMode sortMode)
	{
		return FindObjectsByType(type, FindObjectsInactive.Exclude, sortMode);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::FindObjectsByType")]
	[TypeInferenceRule(TypeInferenceRules.ArrayOfTypeReferencedByFirstArgument)]
	public static extern Object[] FindObjectsByType(Type type, FindObjectsInactive findObjectsInactive, FindObjectsSortMode sortMode);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("GetSceneManager().DontDestroyOnLoad", ThrowsException = true)]
	public static extern void DontDestroyOnLoad([NotNull("NullExceptionObject")] Object target);

	[Obsolete("use Object.Destroy instead.")]
	public static void DestroyObject(Object obj, [DefaultValue("0.0F")] float t)
	{
		Destroy(obj, t);
	}

	[ExcludeFromDocs]
	[Obsolete("use Object.Destroy instead.")]
	public static void DestroyObject(Object obj)
	{
		float t = 0f;
		Destroy(obj, t);
	}

	[Obsolete("warning use Object.FindObjectsByType instead.")]
	public static Object[] FindSceneObjectsOfType(Type type)
	{
		return FindObjectsOfType(type);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::FindObjectsOfTypeIncludingAssets")]
	[Obsolete("use Resources.FindObjectsOfTypeAll instead.")]
	public static extern Object[] FindObjectsOfTypeIncludingAssets(Type type);

	public static T[] FindObjectsOfType<T>() where T : Object
	{
		return Resources.ConvertObjects<T>(FindObjectsOfType(typeof(T), includeInactive: false));
	}

	public static T[] FindObjectsByType<T>(FindObjectsSortMode sortMode) where T : Object
	{
		return Resources.ConvertObjects<T>(FindObjectsByType(typeof(T), FindObjectsInactive.Exclude, sortMode));
	}

	public static T[] FindObjectsOfType<T>(bool includeInactive) where T : Object
	{
		return Resources.ConvertObjects<T>(FindObjectsOfType(typeof(T), includeInactive));
	}

	public static T[] FindObjectsByType<T>(FindObjectsInactive findObjectsInactive, FindObjectsSortMode sortMode) where T : Object
	{
		return Resources.ConvertObjects<T>(FindObjectsByType(typeof(T), findObjectsInactive, sortMode));
	}

	public static T FindObjectOfType<T>() where T : Object
	{
		return (T)FindObjectOfType(typeof(T), includeInactive: false);
	}

	public static T FindObjectOfType<T>(bool includeInactive) where T : Object
	{
		return (T)FindObjectOfType(typeof(T), includeInactive);
	}

	public static T FindFirstObjectByType<T>() where T : Object
	{
		return (T)FindFirstObjectByType(typeof(T), FindObjectsInactive.Exclude);
	}

	public static T FindAnyObjectByType<T>() where T : Object
	{
		return (T)FindAnyObjectByType(typeof(T), FindObjectsInactive.Exclude);
	}

	public static T FindFirstObjectByType<T>(FindObjectsInactive findObjectsInactive) where T : Object
	{
		return (T)FindFirstObjectByType(typeof(T), findObjectsInactive);
	}

	public static T FindAnyObjectByType<T>(FindObjectsInactive findObjectsInactive) where T : Object
	{
		return (T)FindAnyObjectByType(typeof(T), findObjectsInactive);
	}

	[Obsolete("Please use Resources.FindObjectsOfTypeAll instead")]
	public static Object[] FindObjectsOfTypeAll(Type type)
	{
		return Resources.FindObjectsOfTypeAll(type);
	}

	private static void CheckNullArgument(object arg, string message)
	{
		if (arg == null)
		{
			throw new ArgumentException(message);
		}
	}

	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	public static Object FindObjectOfType(Type type)
	{
		Object[] array = FindObjectsOfType(type, includeInactive: false);
		if (array.Length != 0)
		{
			return array[0];
		}
		return null;
	}

	public static Object FindFirstObjectByType(Type type)
	{
		Object[] array = FindObjectsByType(type, FindObjectsInactive.Exclude, FindObjectsSortMode.InstanceID);
		return (array.Length != 0) ? array[0] : null;
	}

	public static Object FindAnyObjectByType(Type type)
	{
		Object[] array = FindObjectsByType(type, FindObjectsInactive.Exclude, FindObjectsSortMode.None);
		return (array.Length != 0) ? array[0] : null;
	}

	[TypeInferenceRule(TypeInferenceRules.TypeReferencedByFirstArgument)]
	public static Object FindObjectOfType(Type type, bool includeInactive)
	{
		Object[] array = FindObjectsOfType(type, includeInactive);
		if (array.Length != 0)
		{
			return array[0];
		}
		return null;
	}

	public static Object FindFirstObjectByType(Type type, FindObjectsInactive findObjectsInactive)
	{
		Object[] array = FindObjectsByType(type, findObjectsInactive, FindObjectsSortMode.InstanceID);
		return (array.Length != 0) ? array[0] : null;
	}

	public static Object FindAnyObjectByType(Type type, FindObjectsInactive findObjectsInactive)
	{
		Object[] array = FindObjectsByType(type, findObjectsInactive, FindObjectsSortMode.None);
		return (array.Length != 0) ? array[0] : null;
	}

	public override string ToString()
	{
		return ToString(this);
	}

	public static bool operator ==(Object x, Object y)
	{
		return CompareBaseObjects(x, y);
	}

	public static bool operator !=(Object x, Object y)
	{
		return !CompareBaseObjects(x, y);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "Object::GetOffsetOfInstanceIdMember", IsFreeFunction = true, IsThreadSafe = true)]
	private static extern int GetOffsetOfInstanceIDInCPlusPlusObject();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "CurrentThreadIsMainThread", IsFreeFunction = true, IsThreadSafe = true)]
	private static extern bool CurrentThreadIsMainThread();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "CloneObject", IsFreeFunction = true, ThrowsException = true)]
	private static extern Object Internal_CloneSingle([NotNull("NullExceptionObject")] Object data);

	[FreeFunction("CloneObjectToScene")]
	private static Object Internal_CloneSingleWithScene([NotNull("ArgumentNullException")] Object data, Scene scene)
	{
		return Internal_CloneSingleWithScene_Injected(data, ref scene);
	}

	[FreeFunction("CloneObjectWithParams")]
	private static Object Internal_CloneSingleWithParams([NotNull("ArgumentNullException")] Object data, InstantiateParameters parameters)
	{
		return Internal_CloneSingleWithParams_Injected(data, ref parameters);
	}

	[FreeFunction("InstantiateObjectWithParams")]
	private static Object Internal_InstantiateSingleWithParams([NotNull("ArgumentNullException")] Object data, Vector3 position, Quaternion rotation, InstantiateParameters parameters)
	{
		return Internal_InstantiateSingleWithParams_Injected(data, ref position, ref rotation, ref parameters);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("CloneObject")]
	private static extern Object Internal_CloneSingleWithParent([NotNull("NullExceptionObject")] Object data, [NotNull("NullExceptionObject")] Transform parent, bool worldPositionStays);

	[FreeFunction("InstantiateAsyncObjects")]
	private static AsyncInstantiateOperation Internal_InstantiateAsyncWithParams([NotNull("NullExceptionObject")] Object original, int count, InstantiateParameters parameters, IntPtr positions, int positionsCount, IntPtr rotations, int rotationsCount)
	{
		return Internal_InstantiateAsyncWithParams_Injected(original, count, ref parameters, positions, positionsCount, rotations, rotationsCount);
	}

	[FreeFunction("InstantiateObject")]
	private static Object Internal_InstantiateSingle([NotNull("NullExceptionObject")] Object data, Vector3 pos, Quaternion rot)
	{
		return Internal_InstantiateSingle_Injected(data, ref pos, ref rot);
	}

	[FreeFunction("InstantiateObject")]
	private static Object Internal_InstantiateSingleWithParent([NotNull("NullExceptionObject")] Object data, [NotNull("NullExceptionObject")] Transform parent, Vector3 pos, Quaternion rot)
	{
		return Internal_InstantiateSingleWithParent_Injected(data, parent, ref pos, ref rot);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::ToString")]
	private static extern string ToString(Object obj);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::GetName")]
	private static extern string GetName([NotNull("NullExceptionObject")] Object obj);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::IsPersistent")]
	internal static extern bool IsPersistent([NotNull("NullExceptionObject")] Object obj);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::SetName")]
	private static extern void SetName([NotNull("NullExceptionObject")] Object obj, string name);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "UnityEngineObjectBindings::DoesObjectWithInstanceIDExist", IsFreeFunction = true, IsThreadSafe = true)]
	internal static extern bool DoesObjectWithInstanceIDExist(int instanceID);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::FindObjectFromInstanceID")]
	[VisibleToOtherModules]
	internal static extern Object FindObjectFromInstanceID(int instanceID);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::ForceLoadFromInstanceID")]
	[VisibleToOtherModules]
	internal static extern Object ForceLoadFromInstanceID(int instanceID);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("UnityEngineObjectBindings::MarkObjectDirty", HasExplicitThis = true)]
	internal extern void MarkDirty();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Object Internal_CloneSingleWithScene_Injected(Object data, ref Scene scene);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Object Internal_CloneSingleWithParams_Injected(Object data, ref InstantiateParameters parameters);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Object Internal_InstantiateSingleWithParams_Injected(Object data, ref Vector3 position, ref Quaternion rotation, ref InstantiateParameters parameters);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern AsyncInstantiateOperation Internal_InstantiateAsyncWithParams_Injected(Object original, int count, ref InstantiateParameters parameters, IntPtr positions, int positionsCount, IntPtr rotations, int rotationsCount);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Object Internal_InstantiateSingle_Injected(Object data, ref Vector3 pos, ref Quaternion rot);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Object Internal_InstantiateSingleWithParent_Injected(Object data, Transform parent, ref Vector3 pos, ref Quaternion rot);
}
