using System;
using System.Diagnostics;

namespace Ase;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
public class ParamsDisplayIndexAttribute : Attribute
{
	public int Index;

	public ParamsDisplayIndexAttribute(int index)
	{
		Index = index;
	}
}
