using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using UnityEngine.Localization.SmartFormat.Core.Extensions;

namespace UnityEngine.Localization.SmartFormat.Extensions;

[Serializable]
public class ReflectionSource : ISource
{
	private static readonly object[] k_Empty = new object[0];

	private Dictionary<(Type, string), (FieldInfo field, MethodInfo method)> m_TypeCache;

	private Dictionary<(Type, string), (FieldInfo field, MethodInfo method)> TypeCache
	{
		get
		{
			if (m_TypeCache == null)
			{
				m_TypeCache = new Dictionary<(Type, string), (FieldInfo, MethodInfo)>();
			}
			return m_TypeCache;
		}
	}

	public ReflectionSource(SmartFormatter formatter)
	{
		formatter.Parser.AddAlphanumericSelectors();
		formatter.Parser.AddAdditionalSelectorChars("_");
		formatter.Parser.AddOperators(".");
	}

	public bool TryEvaluateSelector(ISelectorInfo selectorInfo)
	{
		object currentValue = selectorInfo.CurrentValue;
		string selector = selectorInfo.SelectorText;
		if (currentValue == null)
		{
			return false;
		}
		Type type = currentValue.GetType();
		if (TypeCache.TryGetValue((type, selector), out (FieldInfo, MethodInfo) value))
		{
			if (value.Item1 != null)
			{
				selectorInfo.Result = value.Item1.GetValue(currentValue);
				return true;
			}
			if (value.Item2 != null)
			{
				selectorInfo.Result = value.Item2.Invoke(currentValue, k_Empty);
				return true;
			}
			return false;
		}
		foreach (MemberInfo item in from m in type.GetMembers(BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public)
			where string.Equals(m.Name, selector, selectorInfo.FormatDetails.Settings.GetCaseSensitivityComparison())
			select m)
		{
			switch (item.MemberType)
			{
			case MemberTypes.Field:
			{
				FieldInfo fieldInfo = (FieldInfo)item;
				selectorInfo.Result = fieldInfo.GetValue(currentValue);
				TypeCache[(type, selector)] = (fieldInfo, null);
				return true;
			}
			case MemberTypes.Method:
			case MemberTypes.Property:
			{
				MethodInfo methodInfo;
				if (item.MemberType == MemberTypes.Property)
				{
					PropertyInfo propertyInfo = (PropertyInfo)item;
					if (!propertyInfo.CanRead)
					{
						break;
					}
					methodInfo = propertyInfo.GetGetMethod();
				}
				else
				{
					methodInfo = (MethodInfo)item;
				}
				if (!(methodInfo == null) && methodInfo.GetParameters().Length == 0 && !(methodInfo.ReturnType == typeof(void)))
				{
					TypeCache[(type, selector)] = (null, methodInfo);
					selectorInfo.Result = methodInfo.Invoke(currentValue, k_Empty);
					return true;
				}
				break;
			}
			}
		}
		TypeCache[(type, selector)] = (null, null);
		return false;
	}
}
