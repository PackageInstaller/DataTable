using UnityEngine.Scripting;

namespace UnityEngine;

internal class ScriptingUtility
{
	private struct TestClass
	{
		public int value;
	}

	[RequiredByNativeCode]
	private static bool IsManagedCodeWorking()
	{
		TestClass testClass = new TestClass
		{
			value = 42
		};
		return testClass.value == 42;
	}
}
