using System;
using System.Collections.Generic;
using UnityEngine.Scripting;

namespace UnityEngine;

internal class AttributeHelperEngine
{
	public static DisallowMultipleComponent[] _disallowMultipleComponentArray = new DisallowMultipleComponent[1];

	public static ExecuteInEditMode[] _executeInEditModeArray = new ExecuteInEditMode[1];

	public static RequireComponent[] _requireComponentArray = new RequireComponent[1];

	[RequiredByNativeCode]
	private static Type GetParentTypeDisallowingMultipleInclusion(Type type)
	{
		Type result = null;
		while ((object)type != null && (object)type != typeof(MonoBehaviour))
		{
			if (Attribute.IsDefined(type, typeof(DisallowMultipleComponent)))
			{
				result = type;
			}
			type = type.BaseType;
		}
		return result;
	}

	[RequiredByNativeCode]
	private static Type[] GetRequiredComponents(Type klass)
	{
		List<Type> list = null;
		while ((object)klass != null && (object)klass != typeof(MonoBehaviour))
		{
			RequireComponent[] array = (RequireComponent[])klass.GetCustomAttributes(typeof(RequireComponent), inherit: false);
			Type baseType = klass.BaseType;
			RequireComponent[] array2 = array;
			foreach (RequireComponent requireComponent in array2)
			{
				if (list == null && array.Length == 1 && (object)baseType == typeof(MonoBehaviour))
				{
					return new Type[3] { requireComponent.m_Type0, requireComponent.m_Type1, requireComponent.m_Type2 };
				}
				if (list == null)
				{
					list = new List<Type>();
				}
				if ((object)requireComponent.m_Type0 != null)
				{
					list.Add(requireComponent.m_Type0);
				}
				if ((object)requireComponent.m_Type1 != null)
				{
					list.Add(requireComponent.m_Type1);
				}
				if ((object)requireComponent.m_Type2 != null)
				{
					list.Add(requireComponent.m_Type2);
				}
			}
			klass = baseType;
		}
		return list?.ToArray();
	}

	private static int GetExecuteMode(Type klass)
	{
		object[] customAttributes = klass.GetCustomAttributes(typeof(ExecuteAlways), inherit: false);
		if (customAttributes.Length != 0)
		{
			return 2;
		}
		object[] customAttributes2 = klass.GetCustomAttributes(typeof(ExecuteInEditMode), inherit: false);
		if (customAttributes2.Length != 0)
		{
			return 1;
		}
		return 0;
	}

	[RequiredByNativeCode]
	private static int CheckIsEditorScript(Type klass)
	{
		while ((object)klass != null && (object)klass != typeof(MonoBehaviour))
		{
			int executeMode = GetExecuteMode(klass);
			if (executeMode > 0)
			{
				return executeMode;
			}
			klass = klass.BaseType;
		}
		return 0;
	}

	[RequiredByNativeCode]
	private static int GetDefaultExecutionOrderFor(Type klass)
	{
		return GetCustomAttributeOfType<DefaultExecutionOrder>(klass)?.order ?? 0;
	}

	private static T GetCustomAttributeOfType<T>(Type klass) where T : Attribute
	{
		Type typeFromHandle = typeof(T);
		object[] customAttributes = klass.GetCustomAttributes(typeFromHandle, inherit: true);
		if (customAttributes != null && customAttributes.Length != 0)
		{
			return (T)customAttributes[0];
		}
		return null;
	}
}
