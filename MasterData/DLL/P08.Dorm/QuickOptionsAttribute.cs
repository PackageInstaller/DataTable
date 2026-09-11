using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = true)]
public class QuickOptionsAttribute : PropertyAttribute
{
	public string[] op;

	public QuickOptionsAttribute(params string[] options)
	{
		op = options;
	}

	public static string[] GetSelectOptions(QuickOptionsAttribute attribute)
	{
		IEnumerable<string> enumerable = attribute?.op;
		return (enumerable ?? Enumerable.Empty<string>()).Concat(new string[1] { "Custom" }).ToArray();
	}
}
