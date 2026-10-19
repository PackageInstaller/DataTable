using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Interface, AllowMultiple = true, Inherited = true)]
public class TypeInfoBoxAttribute : Attribute
{
	public string Message;

	public TypeInfoBoxAttribute(string message)
	{
		Message = message;
	}
}
