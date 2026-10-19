using System.ComponentModel;
using System.Diagnostics;
using System.Dynamic;

namespace System.Runtime.CompilerServices;

[DebuggerStepThrough]
[EditorBrowsable(EditorBrowsableState.Never)]
public static class RuntimeOps
{
	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static bool ExpandoTryGetValue(ExpandoObject expando, object indexClass, int index, string name, bool ignoreCase, out object value)
	{
		return expando.TryGetValue(indexClass, index, name, ignoreCase, out value);
	}

	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static object ExpandoTrySetValue(ExpandoObject expando, object indexClass, int index, object value, string name, bool ignoreCase)
	{
		expando.TrySetValue(indexClass, index, value, name, ignoreCase, add: false);
		return value;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static bool ExpandoTryDeleteValue(ExpandoObject expando, object indexClass, int index, string name, bool ignoreCase)
	{
		return expando.TryDeleteValue(indexClass, index, name, ignoreCase, ExpandoObject.Uninitialized);
	}

	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static bool ExpandoCheckVersion(ExpandoObject expando, object version)
	{
		return expando.Class == version;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static void ExpandoPromoteClass(ExpandoObject expando, object oldClass, object newClass)
	{
		expando.PromoteClass(oldClass, newClass);
	}
}
