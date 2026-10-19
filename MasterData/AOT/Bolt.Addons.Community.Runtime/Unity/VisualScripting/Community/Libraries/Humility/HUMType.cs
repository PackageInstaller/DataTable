using System;
using System.Collections.Generic;
using System.Reflection;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMType
{
	public static class Data
	{
		public struct Is(Type type)
		{
			public Type type = type;
		}

		public struct As(Type type)
		{
			public Type type = type;
		}

		public struct Has(Type type)
		{
			public Type type = type;
		}

		public struct With(Types types)
		{
			public Types types = types;
		}

		public struct Generic(Is isData)
		{
			public Is isData = isData;
		}

		public struct Get(Type type)
		{
			public Type type = type;
		}

		public struct All(Get get)
		{
			public Get get = get;
		}

		public struct Types(Get get)
		{
			public Get get = get;
		}

		public struct Derived
		{
			public Get get;

			public All all;

			public Derived(Get get, List<Type> types)
			{
				this.get = get;
				all = default;
			}

			public Derived(All all, List<Type> types)
			{
				this.all = all;
				get = default;
			}
		}

		public struct Of(All all)
		{
			public All all = all;
		}
	}

	internal static bool HasFieldOrMethodOfType<T>(this Type type, bool fields = true, bool methods = true)
	{
		FieldInfo[] fields2 = type.GetFields();
		MethodInfo[] methods2 = type.GetMethods();
		for (int i = 0; i < fields2.Length; i++)
		{
			if (fields2[i].FieldType == typeof(T))
			{
				return true;
			}
		}
		for (int j = 0; j < methods2.Length; j++)
		{
			if (methods2[j].ReturnType == typeof(T))
			{
				return true;
			}
		}
		return false;
	}

	public static Data.Get Get(this Type type)
	{
		return new Data.Get(type);
	}

	public static Data.As As(this Type type)
	{
		return new Data.As(type);
	}

	public static Data.Is Is(this Type type)
	{
		return new Data.Is(type);
	}

	public static bool Inherits(this Type type, Type inheritsFrom)
	{
		return inheritsFrom.IsAssignableFrom(type);
	}

	public static bool Inherits<TInheritsFrom>(this Type type)
	{
		return typeof(TInheritsFrom).IsAssignableFrom(type);
	}

	public static bool Inherits<TType, TInheritsFrom>()
	{
		return typeof(TInheritsFrom).IsAssignableFrom(typeof(TType));
	}

	public static bool Overridable(this MethodInfo method)
	{
		if ((method.IsVirtual || method.IsAbstract) && !method.IsSpecialName)
		{
			return true;
		}
		return false;
	}

	public static object Default(this Type type)
	{
		if (type.IsValueType)
		{
			return Activator.CreateInstance(type);
		}
		return null;
	}

	public static object New(this Type type, params object[] args)
	{
		return Activator.CreateInstance(type, args);
	}
}
