using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Scripting/ScriptingRuntime.h")]
[VisibleToOtherModules]
internal class ScriptingRuntime
{
	[MethodImpl((MethodImplOptions)4096)]
	public static extern string[] GetAllUserAssemblies();
}
