using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Experimental.Rendering;

[RequiredByNativeCode]
[NativeHeader("Runtime/Camera/ScriptableRuntimeReflectionSystem.h")]
public static class ScriptableRuntimeReflectionSystemSettings
{
	private static ScriptableRuntimeReflectionSystemWrapper s_Instance = new ScriptableRuntimeReflectionSystemWrapper();

	private static IScriptableRuntimeReflectionSystem Internal_ScriptableRuntimeReflectionSystemSettings_system
	{
		[RequiredByNativeCode]
		set
		{
			if (s_Instance.implementation != value && s_Instance.implementation != null)
			{
				s_Instance.implementation.Dispose();
			}
			s_Instance.implementation = value;
		}
	}

	private static ScriptableRuntimeReflectionSystemWrapper Internal_ScriptableRuntimeReflectionSystemSettings_instance
	{
		[RequiredByNativeCode]
		get
		{
			return s_Instance;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[StaticAccessor("ScriptableRuntimeReflectionSystem", StaticAccessorType.DoubleColon)]
	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.AfterSceneLoad)]
	private static extern void ScriptingDirtyReflectionSystemInstance();
}
