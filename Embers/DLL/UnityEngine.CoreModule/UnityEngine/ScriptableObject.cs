using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[NativeClass(null)]
[ExtensionOfNativeClass]
[RequiredByNativeCode]
[NativeHeader("Runtime/Mono/MonoBehaviour.h")]
public class ScriptableObject : Object
{
	public ScriptableObject()
	{
		CreateScriptableObject(this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeConditional("ENABLE_MONO")]
	[Obsolete("Use EditorUtility.SetDirty instead")]
	public extern void SetDirty();

	public static ScriptableObject CreateInstance(string className)
	{
		return CreateScriptableObjectInstanceFromName(className);
	}

	public static ScriptableObject CreateInstance(Type type)
	{
		return CreateScriptableObjectInstanceFromType(type, applyDefaultsAndReset: true);
	}

	public static T CreateInstance<T>() where T : ScriptableObject
	{
		return (T)CreateInstance(typeof(T));
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	internal static ScriptableObject CreateInstance(Type type, Action<ScriptableObject> initialize)
	{
		if (!typeof(ScriptableObject).IsAssignableFrom(type))
		{
			throw new ArgumentException("Type must inherit ScriptableObject.", "type");
		}
		ScriptableObject scriptableObject = CreateScriptableObjectInstanceFromType(type, applyDefaultsAndReset: false);
		try
		{
			initialize(scriptableObject);
		}
		finally
		{
			ResetAndApplyDefaultInstances(scriptableObject);
		}
		return scriptableObject;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(IsThreadSafe = true)]
	private static extern void CreateScriptableObject([Writable] ScriptableObject self);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Scripting::CreateScriptableObject")]
	private static extern ScriptableObject CreateScriptableObjectInstanceFromName(string className);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Scripting::CreateScriptableObjectWithType")]
	internal static extern ScriptableObject CreateScriptableObjectInstanceFromType(Type type, bool applyDefaultsAndReset);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("Scripting::ResetAndApplyDefaultInstances")]
	internal static extern void ResetAndApplyDefaultInstances([NotNull("NullExceptionObject")] Object obj);
}
