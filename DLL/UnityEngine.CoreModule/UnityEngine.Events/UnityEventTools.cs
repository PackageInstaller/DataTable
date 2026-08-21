using System;

namespace UnityEngine.Events;

internal class UnityEventTools
{
	internal static string TidyAssemblyTypeName(string assemblyTypeName)
	{
		if (string.IsNullOrEmpty(assemblyTypeName))
		{
			return assemblyTypeName;
		}
		int num = int.MaxValue;
		int num2 = assemblyTypeName.IndexOf(", Version=");
		if (num2 != -1)
		{
			num = Math.Min(num2, num);
		}
		num2 = assemblyTypeName.IndexOf(", Culture=");
		if (num2 != -1)
		{
			num = Math.Min(num2, num);
		}
		num2 = assemblyTypeName.IndexOf(", PublicKeyToken=");
		if (num2 != -1)
		{
			num = Math.Min(num2, num);
		}
		if (num != int.MaxValue)
		{
			assemblyTypeName = assemblyTypeName.Substring(0, num);
		}
		num2 = assemblyTypeName.IndexOf(", UnityEngine.");
		if (num2 != -1 && assemblyTypeName.EndsWith("Module"))
		{
			assemblyTypeName = assemblyTypeName.Substring(0, num2) + ", UnityEngine";
		}
		return assemblyTypeName;
	}
}
