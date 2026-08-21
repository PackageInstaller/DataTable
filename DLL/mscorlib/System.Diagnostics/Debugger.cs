using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Diagnostics;

[ComVisible(true)]
public sealed class Debugger
{
	public static readonly string DefaultCategory = "";

	public static bool IsAttached => IsAttached_internal();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool IsAttached_internal();

	public static void Break()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool IsLogging();

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void Log_icall(int level, ref string category, ref string message);

	public static void Log(int level, string category, string message)
	{
		Log_icall(level, ref category, ref message);
	}

	public static void NotifyOfCrossThreadDependency()
	{
	}
}
