using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

[Serializable]
public abstract class Decorator<TDecorator, TDecoratorAttribute, TDecoratedType> where TDecorator : Decorator<TDecorator, TDecoratorAttribute, TDecoratedType> where TDecoratorAttribute : DecoratorAttribute
{
	private static Dictionary<Type, Type> singleDecoratorTypes;

	private static Dictionary<Type, List<Type>> multiDecoratorTypes;

	private static Dictionary<TDecoratedType, List<object>> multiDecorators = new Dictionary<TDecoratedType, List<object>>();

	private static Dictionary<TDecoratedType, TDecorator> singleDecorators = new Dictionary<TDecoratedType, TDecorator>();

	public static TDecorator activeDecorator;

	public static TDecoratedType activeDecorated;

	[SerializeField]
	public TDecoratedType decorated;

	public static TDecoratorType GetMultiDecorator<TDecoratorType>(TDecoratedType decorated, params object[] parameters) where TDecoratorType : Decorator<TDecorator, TDecoratorAttribute, TDecoratedType>
	{
		if (decorated == null)
		{
			return null;
		}
		TDecoratorType decoratorFromDecorated = GetDecoratorFromDecorated<TDecoratorType>(decorated, parameters);
		if (decoratorFromDecorated.decorated == null)
		{
			decoratorFromDecorated.decorated = decorated;
		}
		return decoratorFromDecorated;
	}

	public static TDecorator GetSingleDecorator(TDecoratedType decorated, params object[] parameters)
	{
		if (decorated == null)
		{
			return null;
		}
		TDecorator decoratorFromDecorated = GetDecoratorFromDecorated(decorated, parameters);
		if (decoratorFromDecorated.decorated == null)
		{
			decoratorFromDecorated.decorated = decorated;
		}
		return decoratorFromDecorated;
	}

	public static T GetSingleDecorator<T>(TDecoratedType decorated, params object[] parameters) where T : TDecorator
	{
		return GetSingleDecorator(decorated) as T;
	}

	private static Type GetDecoratorType(Type decoratedType)
	{
		if (decoratedType == null)
		{
			return null;
		}
		if (singleDecoratorTypes == null)
		{
			CacheSingleDecorators();
		}
		Type value = null;
		if (singleDecoratorTypes.TryGetValue(decoratedType, out value))
		{
			return value;
		}
		return GetDecoratorType(decoratedType.BaseType);
	}

	private static Type GetDecoratorType(Type decoratedType, Type decoratorType)
	{
		if (decoratedType == null)
		{
			return null;
		}
		if (multiDecoratorTypes == null)
		{
			CacheMultiDecorators();
		}
		if (!multiDecoratorTypes.ContainsKey(decoratedType) || !multiDecoratorTypes[decoratedType].Any((Type d) => d == decoratorType))
		{
			CacheMultiDecorators();
		}
		Type type = null;
		type = multiDecoratorTypes[decoratedType].First((Type type2) => type2 == decoratorType);
		if (type != null)
		{
			return type;
		}
		return GetDecoratorType(decoratedType.BaseType, decoratorType);
	}

	private static TDecoratorType GetDecoratorFromDecorated<TDecoratorType>(TDecoratedType decorated, params object[] parameters) where TDecoratorType : Decorator<TDecorator, TDecoratorAttribute, TDecoratedType>
	{
		if (!multiDecorators.ContainsKey(decorated) || !multiDecorators[decorated].Any((object d) => d.GetType() == typeof(TDecoratorType)))
		{
			Type type = decorated.GetType();
			if (!multiDecorators.ContainsKey(decorated))
			{
				multiDecorators.Add(decorated, new List<object>());
			}
			TDecoratorType val = (TDecoratorType)Activator.CreateInstance(GetDecoratorType(type, typeof(TDecoratorType)), parameters);
			val.decorated = decorated;
			multiDecorators[decorated].Add(val);
			return val;
		}
		for (int num = 0; num < multiDecorators[decorated].Count; num++)
		{
			if (multiDecorators[decorated][num] as TDecoratorType != null)
			{
				return multiDecorators[decorated][num] as TDecoratorType;
			}
		}
		return (TDecoratorType)multiDecorators[decorated][0];
	}

	private static TDecorator GetDecoratorFromDecorated(TDecoratedType decorated, params object[] parameters)
	{
		if (!singleDecorators.ContainsKey(decorated))
		{
			TDecorator val = (TDecorator)Activator.CreateInstance(GetDecoratorType(decorated.GetType()), parameters);
			val.decorated = decorated;
			singleDecorators.Add(decorated, val);
			return val;
		}
		return singleDecorators[decorated];
	}

	private static void CacheSingleDecorators()
	{
		singleDecoratorTypes = new Dictionary<Type, Type>();
		Type[] array = typeof(TDecorator).Get().Derived();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].IsAbstract)
			{
				continue;
			}
			object[] customAttributes = array[i].GetCustomAttributes(typeof(TDecoratorAttribute), inherit: false);
			if (customAttributes != null && customAttributes.Length != 0)
			{
				TDecoratorAttribute val = customAttributes[0] as TDecoratorAttribute;
				if (singleDecoratorTypes.ContainsKey(val.type))
				{
					singleDecoratorTypes[val.type] = array[i];
				}
				else
				{
					singleDecoratorTypes.Add(val.type, array[i]);
				}
			}
		}
	}

	private static void CacheMultiDecorators()
	{
		multiDecoratorTypes = new Dictionary<Type, List<Type>>();
		Type[] array = typeof(TDecorator).Get().Derived();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i].IsAbstract)
			{
				continue;
			}
			object[] customAttributes = array[i].GetCustomAttributes(typeof(TDecoratorAttribute), inherit: false);
			if (customAttributes != null && customAttributes.Length != 0)
			{
				TDecoratorAttribute val = customAttributes[0] as TDecoratorAttribute;
				if (multiDecoratorTypes.ContainsKey(val.type))
				{
					multiDecoratorTypes[val.type].Add(array[i]);
					continue;
				}
				multiDecoratorTypes.Add(val.type, new List<Type> { array[i] });
			}
		}
	}
}
