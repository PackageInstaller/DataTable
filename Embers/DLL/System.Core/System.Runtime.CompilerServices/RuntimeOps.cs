using System.ComponentModel;
using System.Diagnostics;
using System.Dynamic;
using System.Reflection;

namespace System.Runtime.CompilerServices;

[DebuggerStepThrough]
[EditorBrowsable(EditorBrowsableState.Never)]
public static class RuntimeOps
{
	[DefaultMember("Item")]
	internal sealed class MergedRuntimeVariables : IRuntimeVariables
	{
		private readonly IRuntimeVariables _first;

		private readonly IRuntimeVariables _second;

		private readonly int[] _indexes;

		internal MergedRuntimeVariables(IRuntimeVariables first, IRuntimeVariables second, int[] indexes)
		{
			_first = first;
			_second = second;
			_indexes = indexes;
		}
	}

	internal sealed class RuntimeVariables : IRuntimeVariables
	{
		private readonly IStrongBox[] _boxes;

		internal RuntimeVariables(IStrongBox[] boxes)
		{
			_boxes = boxes;
		}
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static bool ExpandoTryGetValue(ExpandoObject expando, object indexClass, int index, string name, bool ignoreCase, out object value)
	{
		return expando.TryGetValue(indexClass, index, name, ignoreCase, out value);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static object ExpandoTrySetValue(ExpandoObject expando, object indexClass, int index, object value, string name, bool ignoreCase)
	{
		expando.TrySetValue(indexClass, index, value, name, ignoreCase, add: false);
		return value;
	}

	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static bool ExpandoTryDeleteValue(ExpandoObject expando, object indexClass, int index, string name, bool ignoreCase)
	{
		return expando.TryDeleteValue(indexClass, index, name, ignoreCase, ExpandoObject.Uninitialized);
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("do not use this method", true)]
	public static bool ExpandoCheckVersion(ExpandoObject expando, object version)
	{
		return expando.Class == version;
	}

	[Obsolete("do not use this method", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public static void ExpandoPromoteClass(ExpandoObject expando, object oldClass, object newClass)
	{
		expando.PromoteClass(oldClass, newClass);
	}
}
