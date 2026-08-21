using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Interface, AllowMultiple = true, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class TypeInfoBoxAttribute : Attribute
{
	public string Message;

	public TypeInfoBoxAttribute(string message)
	{
		Message = message;
	}
}
