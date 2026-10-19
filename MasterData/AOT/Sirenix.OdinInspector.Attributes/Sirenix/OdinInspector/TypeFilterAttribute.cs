using System;
using System.ComponentModel;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public class TypeFilterAttribute : Attribute
{
	public string FilterGetter;

	public string DropdownTitle;

	public bool DrawValueNormally;

	[EditorBrowsable(EditorBrowsableState.Never)]
	[Obsolete("Use the FilterGetter member instead.", false)]
	public string MemberName
	{
		get
		{
			return FilterGetter;
		}
		set
		{
			FilterGetter = value;
		}
	}

	public TypeFilterAttribute(string filterGetter)
	{
		FilterGetter = filterGetter;
	}
}
