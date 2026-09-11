using System;
using UnityEngine.Scripting;
using UnityEngine.Scripting.APIUpdating;

namespace UnityEngine._Scripting.APIUpdating;

internal class APIUpdaterRuntimeHelpers
{
	[RequiredByNativeCode]
	internal static bool GetMovedFromAttributeDataForType(Type sourceType, out string assembly, out string nsp, out string klass)
	{
		klass = null;
		nsp = null;
		assembly = null;
		object[] customAttributes = sourceType.GetCustomAttributes(typeof(MovedFromAttribute), inherit: false);
		if (customAttributes.Length != 1)
		{
			return false;
		}
		MovedFromAttribute movedFromAttribute = (MovedFromAttribute)customAttributes[0];
		klass = movedFromAttribute.data.className;
		nsp = movedFromAttribute.data.nameSpace;
		assembly = movedFromAttribute.data.assembly;
		return true;
	}

	[RequiredByNativeCode]
	internal static bool GetObsoleteTypeRedirection(Type sourceType, out string assemblyName, out string nsp, out string className)
	{
		object[] customAttributes = sourceType.GetCustomAttributes(typeof(ObsoleteAttribute), inherit: false);
		assemblyName = null;
		nsp = null;
		className = null;
		if (customAttributes.Length != 1)
		{
			return false;
		}
		ObsoleteAttribute obsoleteAttribute = (ObsoleteAttribute)customAttributes[0];
		string message = obsoleteAttribute.Message;
		if (string.IsNullOrEmpty(message))
		{
			return false;
		}
		string text = "(UnityUpgradable) -> ";
		int num = message.IndexOf(text);
		if (num >= 0)
		{
			string text2 = message.Substring(num + text.Length).Trim();
			if (text2.Length == 0)
			{
				return false;
			}
			int num2 = 0;
			if (text2[0] == '[')
			{
				num2 = text2.IndexOf(']');
				if (num2 == -1)
				{
					return false;
				}
				assemblyName = text2.Substring(1, num2 - 1);
				text2 = text2.Substring(num2 + 1).Trim();
			}
			else
			{
				assemblyName = sourceType.Assembly.GetName().Name;
			}
			num2 = text2.LastIndexOf('.');
			if (num2 > -1)
			{
				className = text2.Substring(num2 + 1);
				text2 = text2.Substring(0, num2);
			}
			else
			{
				className = text2;
				text2 = "";
			}
			if (text2.Length > 0)
			{
				nsp = text2;
			}
			else
			{
				nsp = sourceType.Namespace;
			}
			return true;
		}
		return false;
	}
}
