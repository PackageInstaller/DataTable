using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using UnityEngine;

namespace Unity.VisualScripting;

public static class TypeUtility
{
	private static readonly HashSet<Type> _numericTypes = new HashSet<Type>
	{
		typeof(byte),
		typeof(sbyte),
		typeof(short),
		typeof(ushort),
		typeof(int),
		typeof(uint),
		typeof(long),
		typeof(ulong),
		typeof(float),
		typeof(double),
		typeof(decimal)
	};

	private static readonly HashSet<Type> _numericConstructTypes = new HashSet<Type>
	{
		typeof(Vector2),
		typeof(Vector3),
		typeof(Vector4),
		typeof(Quaternion),
		typeof(Matrix4x4),
		typeof(Rect)
	};

	private static readonly HashSet<Type> typesWithShortStrings = new HashSet<Type>
	{
		typeof(string),
		typeof(Vector2),
		typeof(Vector3),
		typeof(Vector4)
	};

	private static readonly Dictionary<Type, object> defaultPrimitives = new Dictionary<Type, object>
	{
		{
			typeof(int),
			0
		},
		{
			typeof(uint),
			0u
		},
		{
			typeof(long),
			0L
		},
		{
			typeof(ulong),
			0uL
		},
		{
			typeof(short),
			(short)0
		},
		{
			typeof(ushort),
			(ushort)0
		},
		{
			typeof(byte),
			(byte)0
		},
		{
			typeof(sbyte),
			(sbyte)0
		},
		{
			typeof(float),
			0f
		},
		{
			typeof(double),
			0.0
		},
		{
			typeof(decimal),
			0m
		},
		{
			typeof(Vector2),
			default(Vector2)
		},
		{
			typeof(Vector3),
			default(Vector3)
		},
		{
			typeof(Vector4),
			default(Vector4)
		}
	};

	public static bool IsBasic(this Type type)
	{
		Ensure.That("type").IsNotNull(type);
		if (type == typeof(string) || type == typeof(decimal))
		{
			return true;
		}
		if (type.IsEnum)
		{
			return true;
		}
		if (type.IsPrimitive)
		{
			if (type == typeof(IntPtr) || type == typeof(UIntPtr))
			{
				return false;
			}
			return true;
		}
		return false;
	}

	public static bool IsNumeric(this Type type)
	{
		Ensure.That("type").IsNotNull(type);
		return _numericTypes.Contains(type);
	}

	public static bool IsNumericConstruct(this Type type)
	{
		Ensure.That("type").IsNotNull(type);
		return _numericConstructTypes.Contains(type);
	}

	public static Namespace Namespace(this Type type)
	{
		return Unity.VisualScripting.Namespace.FromFullName(type.Namespace);
	}

	public static Func<object> Instantiator(this Type type, bool nonPublic = true)
	{
		Func<object[], object> instantiator = type.Instantiator(nonPublic, Empty<Type>.array);
		if (instantiator != null)
		{
			return () => instantiator(Empty<object>.array);
		}
		return null;
	}

	public static Func<object[], object> Instantiator(this Type type, bool nonPublic = true, params Type[] parameterTypes)
	{
		if (typeof(UnityEngine.Object).IsAssignableFrom(type))
		{
			return null;
		}
		if ((type.IsValueType || type.IsBasic()) && parameterTypes.Length == 0)
		{
			return (object[] args) => type.PseudoDefault();
		}
		ConstructorInfo constructor = type.GetConstructorAccepting(parameterTypes, nonPublic);
		if (constructor != null)
		{
			return (object[] args) => constructor.Invoke(args);
		}
		return null;
	}

	public static object TryInstantiate(this Type type, bool nonPublic = true, params object[] args)
	{
		Ensure.That("type").IsNotNull(type);
		return type.Instantiator(nonPublic, args.Select((object arg) => arg.GetType()).ToArray())?.Invoke(args);
	}

	public static object Instantiate(this Type type, bool nonPublic = true, params object[] args)
	{
		Ensure.That("type").IsNotNull(type);
		Type[] array = args.Select((object arg) => arg.GetType()).ToArray();
		return (type.Instantiator(nonPublic, array) ?? throw new ArgumentException(string.Format("Type {0} cannot be{1} instantiated with the provided parameter types: {2}", type, nonPublic ? "" : " publicly", array.ToCommaSeparatedString())))(args);
	}

	public static object Default(this Type type)
	{
		Ensure.That("type").IsNotNull(type);
		if (type.IsReferenceType())
		{
			return null;
		}
		if (!defaultPrimitives.TryGetValue(type, out var value))
		{
			return Activator.CreateInstance(type);
		}
		return value;
	}

	public static object PseudoDefault(this Type type)
	{
		if (type == typeof(Color))
		{
			return Color.white;
		}
		if (type == typeof(string))
		{
			return string.Empty;
		}
		if (type.IsEnum)
		{
			Array values = Enum.GetValues(type);
			if (values.Length == 0)
			{
				Debug.LogWarning($"Empty enum: {type}\nThis may cause problems with serialization.");
				return Activator.CreateInstance(type);
			}
			DefaultValueAttribute attribute = type.GetAttribute<DefaultValueAttribute>();
			if (attribute != null)
			{
				return attribute.Value;
			}
			return values.GetValue(0);
		}
		return type.Default();
	}

	public static bool IsStatic(this Type type)
	{
		if (type.IsAbstract)
		{
			return type.IsSealed;
		}
		return false;
	}

	public static bool IsAbstract(this Type type)
	{
		if (type.IsAbstract)
		{
			return !type.IsSealed;
		}
		return false;
	}

	public static bool IsConcrete(this Type type)
	{
		if (!type.IsAbstract && !type.IsInterface)
		{
			return !type.ContainsGenericParameters;
		}
		return false;
	}

	public static IEnumerable<Type> GetInterfaces(this Type type, bool includeInherited)
	{
		if (includeInherited || type.BaseType == null)
		{
			return type.GetInterfaces();
		}
		return type.GetInterfaces().Except(type.BaseType.GetInterfaces());
	}

	public static IEnumerable<Type> BaseTypeAndInterfaces(this Type type, bool inheritedInterfaces = true)
	{
		IEnumerable<Type> first = Enumerable.Empty<Type>();
		if (type.BaseType != null)
		{
			first = first.Concat(type.BaseType.Yield());
		}
		return first.Concat(type.GetInterfaces(inheritedInterfaces));
	}

	public static IEnumerable<Type> Hierarchy(this Type type)
	{
		Type baseType = type.BaseType;
		while (baseType != null)
		{
			yield return baseType;
			foreach (Type @interface in baseType.GetInterfaces(includeInherited: false))
			{
				yield return @interface;
			}
			baseType = baseType.BaseType;
		}
	}

	public static IEnumerable<Type> AndBaseTypeAndInterfaces(this Type type)
	{
		return type.Yield().Concat(type.BaseTypeAndInterfaces());
	}

	public static IEnumerable<Type> AndInterfaces(this Type type)
	{
		return type.Yield().Concat(type.GetInterfaces());
	}

	public static IEnumerable<Type> AndHierarchy(this Type type)
	{
		return type.Yield().Concat(type.Hierarchy());
	}

	public static Type GetListElementType(Type listType, bool allowNonGeneric)
	{
		if (listType == null)
		{
			throw new ArgumentNullException("listType");
		}
		if (listType.IsArray)
		{
			return listType.GetElementType();
		}
		if (typeof(IList).IsAssignableFrom(listType))
		{
			Type type = listType.AndInterfaces().FirstOrDefault((Type i) => i.IsGenericType && i.GetGenericTypeDefinition() == typeof(IList<>));
			if (type == null)
			{
				if (allowNonGeneric)
				{
					return typeof(object);
				}
				return null;
			}
			return type.GetGenericArguments()[0];
		}
		return null;
	}

	public static Type GetEnumerableElementType(Type enumerableType, bool allowNonGeneric)
	{
		if (enumerableType == null)
		{
			throw new ArgumentNullException("enumerableType");
		}
		if (typeof(IEnumerable).IsAssignableFrom(enumerableType))
		{
			Type type = enumerableType.AndInterfaces().FirstOrDefault((Type i) => i.IsGenericType && i.GetGenericTypeDefinition() == typeof(IEnumerable<>));
			if (type == null)
			{
				if (allowNonGeneric)
				{
					return typeof(object);
				}
				return null;
			}
			return type.GetGenericArguments()[0];
		}
		return null;
	}

	public static Type GetDictionaryItemType(Type dictionaryType, bool allowNonGeneric, int genericArgumentIndex)
	{
		if (dictionaryType == null)
		{
			throw new ArgumentNullException("dictionaryType");
		}
		if (typeof(IDictionary).IsAssignableFrom(dictionaryType))
		{
			Type type = dictionaryType.AndInterfaces().FirstOrDefault((Type i) => i.IsGenericType && i.GetGenericTypeDefinition() == typeof(IDictionary<, >));
			if (type == null)
			{
				if (allowNonGeneric)
				{
					return typeof(object);
				}
				return null;
			}
			return type.GetGenericArguments()[genericArgumentIndex];
		}
		return null;
	}

	public static Type GetDictionaryKeyType(Type dictionaryType, bool allowNonGeneric)
	{
		return GetDictionaryItemType(dictionaryType, allowNonGeneric, 0);
	}

	public static Type GetDictionaryValueType(Type dictionaryType, bool allowNonGeneric)
	{
		return GetDictionaryItemType(dictionaryType, allowNonGeneric, 1);
	}

	public static bool IsNullable(this Type type)
	{
		if (!type.IsReferenceType())
		{
			return Nullable.GetUnderlyingType(type) != null;
		}
		return true;
	}

	public static bool IsReferenceType(this Type type)
	{
		return !type.IsValueType;
	}

	public static bool IsStruct(this Type type)
	{
		if (type.IsValueType && !type.IsPrimitive)
		{
			return !type.IsEnum;
		}
		return false;
	}

	public static bool IsAssignableFrom(this Type type, object value)
	{
		if (value == null)
		{
			return type.IsNullable();
		}
		return type.IsInstanceOfType(value);
	}

	public static bool CanMakeGenericTypeVia(this Type openConstructedType, Type closedConstructedType)
	{
		Ensure.That("openConstructedType").IsNotNull(openConstructedType);
		Ensure.That("closedConstructedType").IsNotNull(closedConstructedType);
		if (openConstructedType == closedConstructedType)
		{
			return true;
		}
		if (openConstructedType.IsGenericParameter)
		{
			GenericParameterAttributes genericParameterAttributes = openConstructedType.GenericParameterAttributes;
			if (genericParameterAttributes != GenericParameterAttributes.None)
			{
				if (genericParameterAttributes.HasFlag(GenericParameterAttributes.NotNullableValueTypeConstraint) && !closedConstructedType.IsValueType)
				{
					return false;
				}
				if (genericParameterAttributes.HasFlag(GenericParameterAttributes.ReferenceTypeConstraint) && closedConstructedType.IsValueType)
				{
					return false;
				}
				if (genericParameterAttributes.HasFlag(GenericParameterAttributes.DefaultConstructorConstraint) && closedConstructedType.GetConstructor(Type.EmptyTypes) == null)
				{
					return false;
				}
			}
			Type[] genericParameterConstraints = openConstructedType.GetGenericParameterConstraints();
			for (int i = 0; i < genericParameterConstraints.Length; i++)
			{
				if (!genericParameterConstraints[i].IsAssignableFrom(closedConstructedType))
				{
					return false;
				}
			}
			return true;
		}
		if (openConstructedType.ContainsGenericParameters)
		{
			if (openConstructedType.IsGenericType)
			{
				Type genericTypeDefinition = openConstructedType.GetGenericTypeDefinition();
				foreach (Type item in closedConstructedType.AndBaseTypeAndInterfaces())
				{
					if (!item.IsGenericType || !(item.GetGenericTypeDefinition() == genericTypeDefinition))
					{
						continue;
					}
					Type[] genericArguments = item.GetGenericArguments();
					Type[] genericArguments2 = openConstructedType.GetGenericArguments();
					for (int j = 0; j < genericArguments2.Length; j++)
					{
						if (!genericArguments2[j].CanMakeGenericTypeVia(genericArguments[j]))
						{
							return false;
						}
					}
					return true;
				}
				return false;
			}
			if (openConstructedType.IsArray)
			{
				if (!closedConstructedType.IsArray || closedConstructedType.GetArrayRank() != openConstructedType.GetArrayRank())
				{
					return false;
				}
				Type elementType = openConstructedType.GetElementType();
				Type elementType2 = closedConstructedType.GetElementType();
				return elementType.CanMakeGenericTypeVia(elementType2);
			}
			if (openConstructedType.IsByRef)
			{
				if (!closedConstructedType.IsByRef)
				{
					return false;
				}
				Type elementType3 = openConstructedType.GetElementType();
				Type elementType4 = closedConstructedType.GetElementType();
				return elementType3.CanMakeGenericTypeVia(elementType4);
			}
			throw new NotImplementedException();
		}
		return openConstructedType.IsAssignableFrom(closedConstructedType);
	}

	public static Type MakeGenericTypeVia(this Type openConstructedType, Type closedConstructedType, Dictionary<Type, Type> resolvedGenericParameters, bool safe = true)
	{
		Ensure.That("openConstructedType").IsNotNull(openConstructedType);
		Ensure.That("closedConstructedType").IsNotNull(closedConstructedType);
		Ensure.That("resolvedGenericParameters").IsNotNull(resolvedGenericParameters);
		if (safe && !openConstructedType.CanMakeGenericTypeVia(closedConstructedType))
		{
			throw new GenericClosingException(openConstructedType, closedConstructedType);
		}
		if (openConstructedType == closedConstructedType)
		{
			return openConstructedType;
		}
		if (openConstructedType.IsGenericParameter)
		{
			if (!closedConstructedType.ContainsGenericParameters)
			{
				if (resolvedGenericParameters.ContainsKey(openConstructedType))
				{
					if (resolvedGenericParameters[openConstructedType] != closedConstructedType)
					{
						throw new InvalidOperationException("Nested generic parameters resolve to different values.");
					}
				}
				else
				{
					resolvedGenericParameters.Add(openConstructedType, closedConstructedType);
				}
			}
			return closedConstructedType;
		}
		if (openConstructedType.ContainsGenericParameters)
		{
			if (openConstructedType.IsGenericType)
			{
				Type genericTypeDefinition = openConstructedType.GetGenericTypeDefinition();
				Type[] genericArguments = openConstructedType.GetGenericArguments();
				foreach (Type item in closedConstructedType.AndBaseTypeAndInterfaces())
				{
					if (item.IsGenericType && item.GetGenericTypeDefinition() == genericTypeDefinition)
					{
						Type[] genericArguments2 = item.GetGenericArguments();
						Type[] array = new Type[genericArguments.Length];
						for (int i = 0; i < genericArguments.Length; i++)
						{
							array[i] = genericArguments[i].MakeGenericTypeVia(genericArguments2[i], resolvedGenericParameters, safe: false);
						}
						return genericTypeDefinition.MakeGenericType(array);
					}
				}
				throw new GenericClosingException(openConstructedType, closedConstructedType);
			}
			if (openConstructedType.IsArray)
			{
				int arrayRank = openConstructedType.GetArrayRank();
				if (!closedConstructedType.IsArray || closedConstructedType.GetArrayRank() != arrayRank)
				{
					throw new GenericClosingException(openConstructedType, closedConstructedType);
				}
				Type elementType = openConstructedType.GetElementType();
				Type elementType2 = closedConstructedType.GetElementType();
				return elementType.MakeGenericTypeVia(elementType2, resolvedGenericParameters, safe: false).MakeArrayType(arrayRank);
			}
			if (openConstructedType.IsByRef)
			{
				if (!closedConstructedType.IsByRef)
				{
					throw new GenericClosingException(openConstructedType, closedConstructedType);
				}
				Type elementType3 = openConstructedType.GetElementType();
				Type elementType4 = closedConstructedType.GetElementType();
				return elementType3.MakeGenericTypeVia(elementType4, resolvedGenericParameters, safe: false).MakeByRefType();
			}
			throw new NotImplementedException();
		}
		return openConstructedType;
	}

	public static string ToShortString(this object o, int maxLength = 20)
	{
		Type type = o?.GetType();
		if (type == null || o.IsUnityNull())
		{
			return "Null";
		}
		if (type == typeof(float))
		{
			return ((float)o).ToString("0.##");
		}
		if (type == typeof(double))
		{
			return ((double)o).ToString("0.##");
		}
		if (type == typeof(decimal))
		{
			return ((decimal)o).ToString("0.##");
		}
		if (type.IsBasic() || typesWithShortStrings.Contains(type))
		{
			return o.ToString().Truncate(maxLength);
		}
		if (typeof(UnityEngine.Object).IsAssignableFrom(type))
		{
			return ((UnityEngine.Object)o).name.Truncate(maxLength);
		}
		return null;
	}

	public static IEnumerable<Type> GetTypesSafely(this Assembly assembly)
	{
		Type[] array;
		try
		{
			array = assembly.GetTypes();
		}
		catch (ReflectionTypeLoadException ex) when (ex.Types.Any((Type t) => t != null))
		{
			array = ex.Types.Where((Type t) => t != null).ToArray();
		}
		catch (Exception arg)
		{
			Debug.LogWarning($"Failed to load types in assembly '{assembly}'.\n{arg}");
			yield break;
		}
		Type[] array2 = array;
		foreach (Type type in array2)
		{
			if (!(type == typeof(void)))
			{
				yield return type;
			}
		}
	}
}
