using UnityEngine.Scripting;

namespace UnityEngine;

internal static class ClassLibraryInitializer
{
	[RequiredByNativeCode]
	private static void Init()
	{
		UnityLogWriter.Init();
	}
}
