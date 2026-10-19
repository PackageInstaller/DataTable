using System.Runtime.InteropServices;

namespace System.Diagnostics;

[ComVisible(true)]
public sealed class Debugger
{
	public static readonly string DefaultCategory = "";

	public static void NotifyOfCrossThreadDependency()
	{
	}
}
