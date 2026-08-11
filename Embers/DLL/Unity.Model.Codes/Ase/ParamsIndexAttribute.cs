using System;
using System.Diagnostics;

namespace Ase;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = false)]
public class ParamsIndexAttribute : Attribute
{
	public int Index;

	public ParamsIndexAttribute(int index)
	{
		Index = index;
	}
}
