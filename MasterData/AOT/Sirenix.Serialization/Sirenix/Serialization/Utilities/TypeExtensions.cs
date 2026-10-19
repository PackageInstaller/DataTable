using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace Sirenix.Serialization.Utilities;

internal static class TypeExtensions
{
	private static readonly Func<float, float, bool> FloatEqualityComparerFunc = FloatEqualityComparer;

	private static readonly Func<double, double, bool> DoubleEqualityComparerFunc = DoubleEqualityComparer;

	private static readonly Func<Quaternion, Quaternion, bool> QuaternionEqualityComparerFunc = QuaternionEqualityComparer;

	private static readonly object GenericConstraintsSatisfaction_LOCK = new object();

	private static readonly Dictionary<Type, Type> GenericConstraintsSatisfactionInferredParameters = new Dictionary<Type, Type>();

	private static readonly Dictionary<Type, Type> GenericConstraintsSatisfactionResolvedMap = new Dictionary<Type, Type>();

	private static readonly HashSet<Type> GenericConstraintsSatisfactionProcessedParams = new HashSet<Type>();

	private static readonly HashSet<Type> GenericConstraintsSatisfactionTypesToCheck = new HashSet<Type>();

	private static readonly List<Type> GenericConstraintsSatisfactionTypesToCheck_ToAdd = new List<Type>();

	private static readonly Type GenericListInterface = typeof(IList<>);

	private static readonly Type GenericCollectionInterface = typeof(ICollection<>);

	private static readonly object WeaklyTypedTypeCastDelegates_LOCK = new object();

	private static readonly object StronglyTypedTypeCastDelegates_LOCK = new object();

	private static readonly DoubleLookupDictionary<Type, Type, Func<object, object>> WeaklyTypedTypeCastDelegates = new DoubleLookupDictionary<Type, Type, Func<object, object>>();

	private static readonly DoubleLookupDictionary<Type, Type, Delegate> StronglyTypedTypeCastDelegates = new DoubleLookupDictionary<Type, Type, Delegate>();

	private static readonly Type[] TwoLengthTypeArray_Cached = new Type[2];

	private static readonly Stack<Type> GenericArgumentsContainsTypes_ArgsToCheckCached = new Stack<Type>();

	private static HashSet<string> ReservedCSharpKeywords = new HashSet<string>
	{
		"abstract", "as", "base", "bool", "break", "byte", "case", "catch", "char", "checked",
		"class", "const", "continue", "decimal", "default", "delegate", "do", "double", "else", "enum",
		"event", "explicit", "extern", "false", "finally", "fixed", "float", "for", "foreach", "goto",
		"if", "implicit", "in", "int", "interface", "internal", "is", "lock", "long", "namespace",
		"new", "null", "object", "operator", "out", "override", "params", "private", "protected", "public",
		"readonly", "ref", "return", "sbyte", "sealed", "short", "sizeof", "stackalloc", "static", "string",
		"struct", "switch", "this", "throw", "true", "try", "typeof", "uint", "ulong", "unchecked",
		"unsafe", "ushort", "using", "static", "void", "volatile", "while", "in", "get", "set",
		"var"
	};

	public static readonly Dictionary<string, string> TypeNameAlternatives = new Dictionary<string, string>
	{
		{ "Single", "float" },
		{ "Double", "double" },
		{ "SByte", "sbyte" },
		{ "Int16", "short" },
		{ "Int32", "int" },
		{ "Int64", "long" },
		{ "Byte", "byte" },
		{ "UInt16", "ushort" },
		{ "UInt32", "uint" },
		{ "UInt64", "ulong" },
		{ "Decimal", "decimal" },
		{ "String", "string" },
		{ "Char", "char" },
		{ "Boolean", "bool" },
		{ "Single[]", "float[]" },
		{ "Double[]", "double[]" },
		{ "SByte[]", "sbyte[]" },
		{ "Int16[]", "short[]" },
		{ "Int32[]", "int[]" },
		{ "Int64[]", "long[]" },
		{ "Byte[]", "byte[]" },
		{ "UInt16[]", "ushort[]" },
		{ "UInt32[]", "uint[]" },
		{ "UInt64[]", "ulong[]" },
		{ "Decimal[]", "decimal[]" },
		{ "String[]", "string[]" },
		{ "Char[]", "char[]" },
		{ "Boolean[]", "bool[]" }
	};

	private static readonly object CachedNiceNames_LOCK = new object();

	private static readonly Dictionary<Type, string> CachedNiceNames = new Dictionary<Type, string>();

	private static readonly Type VoidPointerType = typeof(void).MakePointerType();

	private static readonly Dictionary<Type, HashSet<Type>> PrimitiveImplicitCasts = new Dictionary<Type, HashSet<Type>>
	{
		{
			typeof(long),
			new HashSet<Type>
			{
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(int),
			new HashSet<Type>
			{
				typeof(long),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(short),
			new HashSet<Type>
			{
				typeof(int),
				typeof(long),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(sbyte),
			new HashSet<Type>
			{
				typeof(short),
				typeof(int),
				typeof(long),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(ulong),
			new HashSet<Type>
			{
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(uint),
			new HashSet<Type>
			{
				typeof(long),
				typeof(ulong),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(ushort),
			new HashSet<Type>
			{
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(byte),
			new HashSet<Type>
			{
				typeof(short),
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(char),
			new HashSet<Type>
			{
				typeof(ushort),
				typeof(int),
				typeof(uint),
				typeof(long),
				typeof(ulong),
				typeof(float),
				typeof(double),
				typeof(decimal)
			}
		},
		{
			typeof(bool),
			new HashSet<Type>()
		},
		{
			typeof(decimal),
			new HashSet<Type>()
		},
		{
			typeof(float),
			new HashSet<Type> { typeof(double) }
		},
		{
			typeof(double),
			new HashSet<Type>()
		},
		{
			typeof(IntPtr),
			new HashSet<Type>()
		},
		{
			typeof(UIntPtr),
			new HashSet<Type>()
		},
		{
			VoidPointerType,
			new HashSet<Type>()
		}
	};

	private static readonly HashSet<Type> ExplicitCastIntegrals = new HashSet<Type>
	{
		typeof(long),
		typeof(int),
		typeof(short),
		typeof(sbyte),
		typeof(ulong),
		typeof(uint),
		typeof(ushort),
		typeof(byte),
		typeof(char),
		typeof(decimal),
		typeof(float),
		typeof(double),
		typeof(IntPtr),
		typeof(UIntPtr)
	};

	private static string GetCachedNiceName(Type type)
	{
		string value;
		lock (CachedNiceNames_LOCK)
		{
			if (!CachedNiceNames.TryGetValue(type, out value))
			{
				value = CreateNiceName(type);
				CachedNiceNames.Add(type, value);
			}
		}
		return value;
	}

	private static string CreateNiceName(Type type)
	{
		if (type.IsArray)
		{
			int arrayRank = type.GetArrayRank();
			return type.GetElementType().GetNiceName() + ((arrayRank == 1) ? "[]" : "[,]");
		}
		if (type.InheritsFrom(typeof(Nullable<>)))
		{
			return type.GetGenericArguments()[0].GetNiceName() + "?";
		}
		if (type.IsByRef)
		{
			return "ref " + type.GetElementType().GetNiceName();
		}
		if (type.IsGenericParameter || !type.IsGenericType)
		{
			return type.TypeNameGauntlet();
		}
		StringBuilder stringBuilder = new StringBuilder();
		string name = type.Name;
		int num = name.IndexOf("`");
		if (num != -1)
		{
			stringBuilder.Append(name.Substring(0, num));
		}
		else
		{
			stringBuilder.Append(name);
		}
		stringBuilder.Append('<');
		Type[] genericArguments = type.GetGenericArguments();
		for (int i = 0; i < genericArguments.Length; i++)
		{
			Type type2 = genericArguments[i];
			if (i != 0)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append(type2.GetNiceName());
		}
		stringBuilder.Append('>');
		return stringBuilder.ToString();
	}

	internal static bool HasCastDefined(this Type from, Type to, bool requireImplicitCast)
	{
		if (from.IsEnum)
		{
			return Enum.GetUnderlyingType(from).IsCastableTo(to);
		}
		if (to.IsEnum)
		{
			return Enum.GetUnderlyingType(to).IsCastableTo(from);
		}
		if ((from.IsPrimitive || from == VoidPointerType) && (to.IsPrimitive || to == VoidPointerType))
		{
			if (requireImplicitCast)
			{
				return PrimitiveImplicitCasts[from].Contains(to);
			}
			if (from == typeof(IntPtr))
			{
				if (to == typeof(UIntPtr))
				{
					return false;
				}
				if (to == VoidPointerType)
				{
					return true;
				}
			}
			else if (from == typeof(UIntPtr))
			{
				if (to == typeof(IntPtr))
				{
					return false;
				}
				if (to == VoidPointerType)
				{
					return true;
				}
			}
			if (ExplicitCastIntegrals.Contains(from))
			{
				return ExplicitCastIntegrals.Contains(to);
			}
			return false;
		}
		return from.GetCastMethod(to, requireImplicitCast) != null;
	}

	public static bool IsValidIdentifier(string identifier)
	{
		if (identifier == null || identifier.Length == 0)
		{
			return false;
		}
		int num = identifier.IndexOf('.');
		if (num >= 0)
		{
			string[] array = identifier.Split(new char[1] { '.' });
			for (int i = 0; i < array.Length; i++)
			{
				if (!IsValidIdentifier(array[i]))
				{
					return false;
				}
			}
			return true;
		}
		if (ReservedCSharpKeywords.Contains(identifier))
		{
			return false;
		}
		if (!IsValidIdentifierStartCharacter(identifier[0]))
		{
			return false;
		}
		for (int j = 1; j < identifier.Length; j++)
		{
			if (!IsValidIdentifierPartCharacter(identifier[j]))
			{
				return false;
			}
		}
		return true;
	}

	private static bool IsValidIdentifierStartCharacter(char c)
	{
		if ((c < 'a' || c > 'z') && (c < 'A' || c > 'Z') && c != '_' && c != '@')
		{
			return char.IsLetter(c);
		}
		return true;
	}

	private static bool IsValidIdentifierPartCharacter(char c)
	{
		if ((c < 'a' || c > 'z') && (c < 'A' || c > 'Z'))
		{
			switch (c)
			{
			default:
				return char.IsLetter(c);
			case '0':
			case '1':
			case '2':
			case '3':
			case '4':
			case '5':
			case '6':
			case '7':
			case '8':
			case '9':
			case '_':
				break;
			}
		}
		return true;
	}

	public static bool IsCastableTo(this Type from, Type to, bool requireImplicitCast = false)
	{
		if (from == null)
		{
			throw new ArgumentNullException("from");
		}
		if (to == null)
		{
			throw new ArgumentNullException("to");
		}
		if (from == to)
		{
			return true;
		}
		if (!to.IsAssignableFrom(from))
		{
			return from.HasCastDefined(to, requireImplicitCast);
		}
		return true;
	}

	public static Func<object, object> GetCastMethodDelegate(this Type from, Type to, bool requireImplicitCast = false)
	{
		Func<object, object> value;
		lock (WeaklyTypedTypeCastDelegates_LOCK)
		{
			if (!WeaklyTypedTypeCastDelegates.TryGetInnerValue(from, to, out value))
			{
				MethodInfo method = from.GetCastMethod(to, requireImplicitCast);
				if (method != null)
				{
					value = (object obj) => method.Invoke(null, new object[1] { obj });
				}
				WeaklyTypedTypeCastDelegates.AddInner(from, to, value);
			}
		}
		return value;
	}

	public static Func<TFrom, TTo> GetCastMethodDelegate<TFrom, TTo>(bool requireImplicitCast = false)
	{
		Delegate value;
		lock (StronglyTypedTypeCastDelegates_LOCK)
		{
			if (!StronglyTypedTypeCastDelegates.TryGetInnerValue(typeof(TFrom), typeof(TTo), out value))
			{
				MethodInfo castMethod = typeof(TFrom).GetCastMethod(typeof(TTo), requireImplicitCast);
				if (castMethod != null)
				{
					value = Delegate.CreateDelegate(typeof(Func<TFrom, TTo>), castMethod);
				}
				StronglyTypedTypeCastDelegates.AddInner(typeof(TFrom), typeof(TTo), value);
			}
		}
		return (Func<TFrom, TTo>)value;
	}

	public static MethodInfo GetCastMethod(this Type from, Type to, bool requireImplicitCast = false)
	{
		IEnumerable<MethodInfo> allMembers = from.GetAllMembers<MethodInfo>(BindingFlags.Static | BindingFlags.Public);
		foreach (MethodInfo item in allMembers)
		{
			if ((item.Name == "op_Implicit" || (!requireImplicitCast && item.Name == "op_Explicit")) && item.GetParameters()[0].ParameterType.IsAssignableFrom(from) && to.IsAssignableFrom(item.ReturnType))
			{
				return item;
			}
		}
		IEnumerable<MethodInfo> allMembers2 = to.GetAllMembers<MethodInfo>(BindingFlags.Static | BindingFlags.Public);
		foreach (MethodInfo item2 in allMembers2)
		{
			if ((item2.Name == "op_Implicit" || (!requireImplicitCast && item2.Name == "op_Explicit")) && item2.GetParameters()[0].ParameterType.IsAssignableFrom(from) && to.IsAssignableFrom(item2.ReturnType))
			{
				return item2;
			}
		}
		return null;
	}

	private static bool FloatEqualityComparer(float a, float b)
	{
		if (float.IsNaN(a) && float.IsNaN(b))
		{
			return true;
		}
		return a == b;
	}

	private static bool DoubleEqualityComparer(double a, double b)
	{
		if (double.IsNaN(a) && double.IsNaN(b))
		{
			return true;
		}
		return a == b;
	}

	private static bool QuaternionEqualityComparer(Quaternion a, Quaternion b)
	{
		if (a.x == b.x && a.y == b.y && a.z == b.z)
		{
			return a.w == b.w;
		}
		return false;
	}

	public static Func<T, T, bool> GetEqualityComparerDelegate<T>()
	{
		if (typeof(T) == typeof(float))
		{
			return (Func<T, T, bool>)(object)FloatEqualityComparerFunc;
		}
		if (typeof(T) == typeof(double))
		{
			return (Func<T, T, bool>)(object)DoubleEqualityComparerFunc;
		}
		if (typeof(T) == typeof(Quaternion))
		{
			return (Func<T, T, bool>)(object)QuaternionEqualityComparerFunc;
		}
		Func<T, T, bool> func = null;
		if (typeof(IEquatable<T>).IsAssignableFrom(typeof(T)))
		{
			func = ((!typeof(T).IsValueType) ? ((Func<T, T, bool>)((T a, T b) =>
			{
				if ((object)a == (object)b)
				{
					return true;
				}
				return a != null && ((IEquatable<T>)(object)a).Equals(b);
			})) : ((Func<T, T, bool>)((T a, T b) => ((IEquatable<T>)(object)a).Equals(b))));
		}
		else
		{
			Type type = typeof(T);
			while (type != null && type != typeof(object))
			{
				MethodInfo operatorMethod = type.GetOperatorMethod(Operator.Equality, type, type);
				if (operatorMethod != null)
				{
					func = (Func<T, T, bool>)Delegate.CreateDelegate(typeof(Func<T, T, bool>), operatorMethod, throwOnBindFailure: true);
					break;
				}
				type = type.BaseType;
			}
		}
		if (func == null)
		{
			EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
			func = equalityComparer.Equals;
		}
		return func;
	}

	public static T GetAttribute<T>(this Type type, bool inherit) where T : Attribute
	{
		object[] customAttributes = type.GetCustomAttributes(typeof(T), inherit);
		if (customAttributes.Length == 0)
		{
			return null;
		}
		return (T)customAttributes[0];
	}

	public static bool ImplementsOrInherits(this Type type, Type to)
	{
		return to.IsAssignableFrom(type);
	}

	public static bool ImplementsOpenGenericType(this Type candidateType, Type openGenericType)
	{
		if (openGenericType.IsInterface)
		{
			return candidateType.ImplementsOpenGenericInterface(openGenericType);
		}
		return candidateType.ImplementsOpenGenericClass(openGenericType);
	}

	public static bool ImplementsOpenGenericInterface(this Type candidateType, Type openGenericInterfaceType)
	{
		if (candidateType == openGenericInterfaceType)
		{
			return true;
		}
		if (candidateType.IsGenericType && candidateType.GetGenericTypeDefinition() == openGenericInterfaceType)
		{
			return true;
		}
		Type[] interfaces = candidateType.GetInterfaces();
		for (int i = 0; i < interfaces.Length; i++)
		{
			if (interfaces[i].ImplementsOpenGenericInterface(openGenericInterfaceType))
			{
				return true;
			}
		}
		return false;
	}

	public static bool ImplementsOpenGenericClass(this Type candidateType, Type openGenericType)
	{
		if (candidateType.IsGenericType && candidateType.GetGenericTypeDefinition() == openGenericType)
		{
			return true;
		}
		Type baseType = candidateType.BaseType;
		if (baseType != null && baseType.ImplementsOpenGenericClass(openGenericType))
		{
			return true;
		}
		return false;
	}

	public static Type[] GetArgumentsOfInheritedOpenGenericType(this Type candidateType, Type openGenericType)
	{
		if (openGenericType.IsInterface)
		{
			return candidateType.GetArgumentsOfInheritedOpenGenericInterface(openGenericType);
		}
		return candidateType.GetArgumentsOfInheritedOpenGenericClass(openGenericType);
	}

	public static Type[] GetArgumentsOfInheritedOpenGenericClass(this Type candidateType, Type openGenericType)
	{
		if (candidateType.IsGenericType && candidateType.GetGenericTypeDefinition() == openGenericType)
		{
			return candidateType.GetGenericArguments();
		}
		Type baseType = candidateType.BaseType;
		if (baseType != null)
		{
			return baseType.GetArgumentsOfInheritedOpenGenericClass(openGenericType);
		}
		return null;
	}

	public static Type[] GetArgumentsOfInheritedOpenGenericInterface(this Type candidateType, Type openGenericInterfaceType)
	{
		if ((openGenericInterfaceType == GenericListInterface || openGenericInterfaceType == GenericCollectionInterface) && candidateType.IsArray)
		{
			return new Type[1] { candidateType.GetElementType() };
		}
		if (candidateType == openGenericInterfaceType)
		{
			return candidateType.GetGenericArguments();
		}
		if (candidateType.IsGenericType && candidateType.GetGenericTypeDefinition() == openGenericInterfaceType)
		{
			return candidateType.GetGenericArguments();
		}
		Type[] interfaces = candidateType.GetInterfaces();
		foreach (Type type in interfaces)
		{
			if (type.IsGenericType)
			{
				Type[] argumentsOfInheritedOpenGenericInterface = type.GetArgumentsOfInheritedOpenGenericInterface(openGenericInterfaceType);
				if (argumentsOfInheritedOpenGenericInterface != null)
				{
					return argumentsOfInheritedOpenGenericInterface;
				}
			}
		}
		return null;
	}

	public static MethodInfo GetOperatorMethod(this Type type, Operator op, Type leftOperand, Type rightOperand)
	{
		string text;
		switch (op)
		{
		case Operator.Equality:
			text = "op_Equality";
			break;
		case Operator.Inequality:
			text = "op_Inequality";
			break;
		case Operator.Addition:
			text = "op_Addition";
			break;
		case Operator.Subtraction:
			text = "op_Subtraction";
			break;
		case Operator.Multiply:
			text = "op_Multiply";
			break;
		case Operator.Division:
			text = "op_Division";
			break;
		case Operator.LessThan:
			text = "op_LessThan";
			break;
		case Operator.GreaterThan:
			text = "op_GreaterThan";
			break;
		case Operator.LessThanOrEqual:
			text = "op_LessThanOrEqual";
			break;
		case Operator.GreaterThanOrEqual:
			text = "op_GreaterThanOrEqual";
			break;
		case Operator.Modulus:
			text = "op_Modulus";
			break;
		case Operator.RightShift:
			text = "op_RightShift";
			break;
		case Operator.LeftShift:
			text = "op_LeftShift";
			break;
		case Operator.BitwiseAnd:
			text = "op_BitwiseAnd";
			break;
		case Operator.BitwiseOr:
			text = "op_BitwiseOr";
			break;
		case Operator.ExclusiveOr:
			text = "op_ExclusiveOr";
			break;
		case Operator.BitwiseComplement:
			text = "op_OnesComplement";
			break;
		case Operator.LogicalNot:
			text = "op_LogicalNot";
			break;
		case Operator.LogicalAnd:
		case Operator.LogicalOr:
			return null;
		default:
			throw new NotImplementedException();
		}
		Type[] twoLengthTypeArray_Cached = TwoLengthTypeArray_Cached;
		lock (twoLengthTypeArray_Cached)
		{
			twoLengthTypeArray_Cached[0] = leftOperand;
			twoLengthTypeArray_Cached[1] = rightOperand;
			try
			{
				MethodInfo method = type.GetMethod(text, BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic, null, twoLengthTypeArray_Cached, null);
				if (method != null && method.ReturnType != typeof(bool))
				{
					return null;
				}
				return method;
			}
			catch (AmbiguousMatchException)
			{
				MethodInfo[] methods = type.GetMethods(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
				foreach (MethodInfo methodInfo in methods)
				{
					if (!(methodInfo.Name != text) && !(methodInfo.ReturnType != typeof(bool)))
					{
						ParameterInfo[] parameters = methodInfo.GetParameters();
						if (parameters.Length == 2 && parameters[0].ParameterType.IsAssignableFrom(leftOperand) && parameters[1].ParameterType.IsAssignableFrom(rightOperand))
						{
							return methodInfo;
						}
					}
				}
				return null;
			}
		}
	}

	public static MethodInfo GetOperatorMethod(this Type type, Operator op)
	{
		string methodName;
		switch (op)
		{
		case Operator.Equality:
			methodName = "op_Equality";
			break;
		case Operator.Inequality:
			methodName = "op_Inequality";
			break;
		case Operator.Addition:
			methodName = "op_Addition";
			break;
		case Operator.Subtraction:
			methodName = "op_Subtraction";
			break;
		case Operator.Multiply:
			methodName = "op_Multiply";
			break;
		case Operator.Division:
			methodName = "op_Division";
			break;
		case Operator.LessThan:
			methodName = "op_LessThan";
			break;
		case Operator.GreaterThan:
			methodName = "op_GreaterThan";
			break;
		case Operator.LessThanOrEqual:
			methodName = "op_LessThanOrEqual";
			break;
		case Operator.GreaterThanOrEqual:
			methodName = "op_GreaterThanOrEqual";
			break;
		case Operator.Modulus:
			methodName = "op_Modulus";
			break;
		case Operator.RightShift:
			methodName = "op_RightShift";
			break;
		case Operator.LeftShift:
			methodName = "op_LeftShift";
			break;
		case Operator.BitwiseAnd:
			methodName = "op_BitwiseAnd";
			break;
		case Operator.BitwiseOr:
			methodName = "op_BitwiseOr";
			break;
		case Operator.ExclusiveOr:
			methodName = "op_ExclusiveOr";
			break;
		case Operator.BitwiseComplement:
			methodName = "op_OnesComplement";
			break;
		case Operator.LogicalNot:
			methodName = "op_LogicalNot";
			break;
		case Operator.LogicalAnd:
		case Operator.LogicalOr:
			return null;
		default:
			throw new NotImplementedException();
		}
		return type.GetAllMembers<MethodInfo>(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic).FirstOrDefault((MethodInfo m) => m.Name == methodName);
	}

	public static MethodInfo[] GetOperatorMethods(this Type type, Operator op)
	{
		string methodName;
		switch (op)
		{
		case Operator.Equality:
			methodName = "op_Equality";
			break;
		case Operator.Inequality:
			methodName = "op_Inequality";
			break;
		case Operator.Addition:
			methodName = "op_Addition";
			break;
		case Operator.Subtraction:
			methodName = "op_Subtraction";
			break;
		case Operator.Multiply:
			methodName = "op_Multiply";
			break;
		case Operator.Division:
			methodName = "op_Division";
			break;
		case Operator.LessThan:
			methodName = "op_LessThan";
			break;
		case Operator.GreaterThan:
			methodName = "op_GreaterThan";
			break;
		case Operator.LessThanOrEqual:
			methodName = "op_LessThanOrEqual";
			break;
		case Operator.GreaterThanOrEqual:
			methodName = "op_GreaterThanOrEqual";
			break;
		case Operator.Modulus:
			methodName = "op_Modulus";
			break;
		case Operator.RightShift:
			methodName = "op_RightShift";
			break;
		case Operator.LeftShift:
			methodName = "op_LeftShift";
			break;
		case Operator.BitwiseAnd:
			methodName = "op_BitwiseAnd";
			break;
		case Operator.BitwiseOr:
			methodName = "op_BitwiseOr";
			break;
		case Operator.ExclusiveOr:
			methodName = "op_ExclusiveOr";
			break;
		case Operator.BitwiseComplement:
			methodName = "op_OnesComplement";
			break;
		case Operator.LogicalNot:
			methodName = "op_LogicalNot";
			break;
		case Operator.LogicalAnd:
		case Operator.LogicalOr:
			return null;
		default:
			throw new NotImplementedException();
		}
		return (from x in type.GetAllMembers<MethodInfo>(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic)
			where x.Name == methodName
			select x).ToArray();
	}

	public static IEnumerable<MemberInfo> GetAllMembers(this Type type, BindingFlags flags = BindingFlags.Default)
	{
		Type currentType = type;
		if ((flags & BindingFlags.DeclaredOnly) == BindingFlags.DeclaredOnly)
		{
			MemberInfo[] members = currentType.GetMembers(flags);
			for (int i = 0; i < members.Length; i++)
			{
				yield return members[i];
			}
			yield break;
		}
		flags |= BindingFlags.DeclaredOnly;
		do
		{
			MemberInfo[] members = currentType.GetMembers(flags);
			for (int i = 0; i < members.Length; i++)
			{
				yield return members[i];
			}
			currentType = currentType.BaseType;
		}
		while (currentType != null);
	}

	public static IEnumerable<MemberInfo> GetAllMembers(this Type type, string name, BindingFlags flags = BindingFlags.Default)
	{
		foreach (MemberInfo allMember in type.GetAllMembers(flags))
		{
			if (!(allMember.Name != name))
			{
				yield return allMember;
			}
		}
	}

	public static IEnumerable<T> GetAllMembers<T>(this Type type, BindingFlags flags = BindingFlags.Default) where T : MemberInfo
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (type == typeof(object))
		{
			yield break;
		}
		Type currentType = type;
		if ((flags & BindingFlags.DeclaredOnly) == BindingFlags.DeclaredOnly)
		{
			MemberInfo[] members = currentType.GetMembers(flags);
			foreach (MemberInfo memberInfo in members)
			{
				T val = memberInfo as T;
				if (val != null)
				{
					yield return val;
				}
			}
			yield break;
		}
		flags |= BindingFlags.DeclaredOnly;
		do
		{
			MemberInfo[] members = currentType.GetMembers(flags);
			foreach (MemberInfo memberInfo2 in members)
			{
				T val2 = memberInfo2 as T;
				if (val2 != null)
				{
					yield return val2;
				}
			}
			currentType = currentType.BaseType;
		}
		while (currentType != null);
	}

	public static Type GetGenericBaseType(this Type type, Type baseType)
	{
		int depthCount;
		return type.GetGenericBaseType(baseType, out depthCount);
	}

	public static Type GetGenericBaseType(this Type type, Type baseType, out int depthCount)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (baseType == null)
		{
			throw new ArgumentNullException("baseType");
		}
		if (!baseType.IsGenericType)
		{
			throw new ArgumentException("Type " + baseType.Name + " is not a generic type.");
		}
		if (!type.InheritsFrom(baseType))
		{
			throw new ArgumentException("Type " + type.Name + " does not inherit from " + baseType.Name + ".");
		}
		Type type2 = type;
		depthCount = 0;
		while (type2 != null && (!type2.IsGenericType || type2.GetGenericTypeDefinition() != baseType))
		{
			depthCount++;
			type2 = type2.BaseType;
		}
		if (type2 == null)
		{
			throw new ArgumentException(type.Name + " is assignable from " + baseType.Name + ", but base type was not found?");
		}
		return type2;
	}

	public static IEnumerable<Type> GetBaseTypes(this Type type, bool includeSelf = false)
	{
		IEnumerable<Type> enumerable = type.GetBaseClasses(includeSelf).Concat(type.GetInterfaces());
		if (includeSelf && type.IsInterface)
		{
			enumerable.Concat(new Type[1] { type });
		}
		return enumerable;
	}

	public static IEnumerable<Type> GetBaseClasses(this Type type, bool includeSelf = false)
	{
		if (!(type == null) && !(type.BaseType == null))
		{
			if (includeSelf)
			{
				yield return type;
			}
			Type current = type.BaseType;
			while (current != null)
			{
				yield return current;
				current = current.BaseType;
			}
		}
	}

	private static string TypeNameGauntlet(this Type type)
	{
		string text = type.Name;
		string value = string.Empty;
		if (TypeNameAlternatives.TryGetValue(text, out value))
		{
			text = value;
		}
		return text;
	}

	public static string GetNiceName(this Type type)
	{
		if (type.IsNested && !type.IsGenericParameter)
		{
			return type.DeclaringType.GetNiceName() + "." + GetCachedNiceName(type);
		}
		return GetCachedNiceName(type);
	}

	public static string GetNiceFullName(this Type type)
	{
		if (type.IsNested && !type.IsGenericParameter)
		{
			return type.DeclaringType.GetNiceFullName() + "." + GetCachedNiceName(type);
		}
		string text = GetCachedNiceName(type);
		if (type.Namespace != null)
		{
			text = type.Namespace + "." + text;
		}
		return text;
	}

	public static string GetCompilableNiceName(this Type type)
	{
		return type.GetNiceName().Replace('<', '_').Replace('>', '_')
			.TrimEnd(new char[1] { '_' });
	}

	public static string GetCompilableNiceFullName(this Type type)
	{
		return type.GetNiceFullName().Replace('<', '_').Replace('>', '_')
			.TrimEnd(new char[1] { '_' });
	}

	public static T GetCustomAttribute<T>(this Type type, bool inherit) where T : Attribute
	{
		object[] customAttributes = type.GetCustomAttributes(typeof(T), inherit);
		if (customAttributes.Length == 0)
		{
			return null;
		}
		return customAttributes[0] as T;
	}

	public static T GetCustomAttribute<T>(this Type type) where T : Attribute
	{
		return type.GetCustomAttribute<T>(inherit: false);
	}

	public static IEnumerable<T> GetCustomAttributes<T>(this Type type) where T : Attribute
	{
		return type.GetCustomAttributes<T>(inherit: false);
	}

	public static IEnumerable<T> GetCustomAttributes<T>(this Type type, bool inherit) where T : Attribute
	{
		object[] attrs = type.GetCustomAttributes(typeof(T), inherit);
		for (int i = 0; i < attrs.Length; i++)
		{
			yield return attrs[i] as T;
		}
	}

	public static bool IsDefined<T>(this Type type) where T : Attribute
	{
		return type.IsDefined(typeof(T), inherit: false);
	}

	public static bool IsDefined<T>(this Type type, bool inherit) where T : Attribute
	{
		return type.IsDefined(typeof(T), inherit);
	}

	public static bool InheritsFrom<TBase>(this Type type)
	{
		return type.InheritsFrom(typeof(TBase));
	}

	public static bool InheritsFrom(this Type type, Type baseType)
	{
		if (baseType.IsAssignableFrom(type))
		{
			return true;
		}
		if (type.IsInterface && !baseType.IsInterface)
		{
			return false;
		}
		if (baseType.IsInterface)
		{
			return type.GetInterfaces().Contains(baseType);
		}
		Type type2 = type;
		while (type2 != null)
		{
			if (type2 == baseType)
			{
				return true;
			}
			if (baseType.IsGenericTypeDefinition && type2.IsGenericType && type2.GetGenericTypeDefinition() == baseType)
			{
				return true;
			}
			type2 = type2.BaseType;
		}
		return false;
	}

	public static int GetInheritanceDistance(this Type type, Type baseType)
	{
		Type type2;
		Type type3;
		if (type.IsAssignableFrom(baseType))
		{
			type2 = type;
			type3 = baseType;
		}
		else
		{
			if (!baseType.IsAssignableFrom(type))
			{
				throw new ArgumentException("Cannot assign types '" + type.GetNiceName() + "' and '" + baseType.GetNiceName() + "' to each other.");
			}
			type2 = baseType;
			type3 = type;
		}
		Type type4 = type3;
		int num = 0;
		if (type2.IsInterface)
		{
			while (type4 != null && type4 != typeof(object))
			{
				num++;
				type4 = type4.BaseType;
				Type[] interfaces = type4.GetInterfaces();
				for (int i = 0; i < interfaces.Length; i++)
				{
					if (interfaces[i] == type2)
					{
						type4 = null;
						break;
					}
				}
			}
		}
		else
		{
			while (type4 != type2 && type4 != null && type4 != typeof(object))
			{
				num++;
				type4 = type4.BaseType;
			}
		}
		return num;
	}

	public static bool HasParamaters(this MethodInfo methodInfo, IList<Type> paramTypes, bool inherit = true)
	{
		ParameterInfo[] parameters = methodInfo.GetParameters();
		if (parameters.Length == paramTypes.Count)
		{
			for (int i = 0; i < parameters.Length; i++)
			{
				if (inherit && !paramTypes[i].InheritsFrom(parameters[i].ParameterType))
				{
					return false;
				}
				if (parameters[i].ParameterType != paramTypes[i])
				{
					return false;
				}
			}
			return true;
		}
		return false;
	}

	public static Type GetReturnType(this MemberInfo memberInfo)
	{
		FieldInfo fieldInfo = memberInfo as FieldInfo;
		if (fieldInfo != null)
		{
			return fieldInfo.FieldType;
		}
		PropertyInfo propertyInfo = memberInfo as PropertyInfo;
		if (propertyInfo != null)
		{
			return propertyInfo.PropertyType;
		}
		MethodInfo methodInfo = memberInfo as MethodInfo;
		if (methodInfo != null)
		{
			return methodInfo.ReturnType;
		}
		EventInfo eventInfo = memberInfo as EventInfo;
		if (eventInfo != null)
		{
			return eventInfo.EventHandlerType;
		}
		return null;
	}

	public static object GetMemberValue(this MemberInfo member, object obj)
	{
		if (member is FieldInfo)
		{
			return (member as FieldInfo).GetValue(obj);
		}
		if (member is PropertyInfo)
		{
			return (member as PropertyInfo).GetGetMethod(nonPublic: true).Invoke(obj, null);
		}
		throw new ArgumentException("Can't get the value of a " + member.GetType().Name);
	}

	public static void SetMemberValue(this MemberInfo member, object obj, object value)
	{
		if (member is FieldInfo)
		{
			(member as FieldInfo).SetValue(obj, value);
			return;
		}
		if (member is PropertyInfo)
		{
			MethodInfo setMethod = (member as PropertyInfo).GetSetMethod(nonPublic: true);
			if (setMethod != null)
			{
				setMethod.Invoke(obj, new object[1] { value });
				return;
			}
			throw new ArgumentException("Property " + member.Name + " has no setter");
		}
		throw new ArgumentException("Can't set the value of a " + member.GetType().Name);
	}

	public static bool TryInferGenericParameters(this Type genericTypeDefinition, out Type[] inferredParams, params Type[] knownParameters)
	{
		if (genericTypeDefinition == null)
		{
			throw new ArgumentNullException("genericTypeDefinition");
		}
		if (knownParameters == null)
		{
			throw new ArgumentNullException("knownParameters");
		}
		if (!genericTypeDefinition.IsGenericType)
		{
			throw new ArgumentException("The genericTypeDefinition parameter must be a generic type.");
		}
		lock (GenericConstraintsSatisfaction_LOCK)
		{
			Dictionary<Type, Type> genericConstraintsSatisfactionInferredParameters = GenericConstraintsSatisfactionInferredParameters;
			genericConstraintsSatisfactionInferredParameters.Clear();
			HashSet<Type> genericConstraintsSatisfactionTypesToCheck = GenericConstraintsSatisfactionTypesToCheck;
			genericConstraintsSatisfactionTypesToCheck.Clear();
			List<Type> genericConstraintsSatisfactionTypesToCheck_ToAdd = GenericConstraintsSatisfactionTypesToCheck_ToAdd;
			genericConstraintsSatisfactionTypesToCheck_ToAdd.Clear();
			for (int i = 0; i < knownParameters.Length; i++)
			{
				genericConstraintsSatisfactionTypesToCheck.Add(knownParameters[i]);
			}
			Type[] genericArguments = genericTypeDefinition.GetGenericArguments();
			if (!genericTypeDefinition.IsGenericTypeDefinition)
			{
				Type[] array = genericArguments;
				genericTypeDefinition = genericTypeDefinition.GetGenericTypeDefinition();
				genericArguments = genericTypeDefinition.GetGenericArguments();
				int num = 0;
				for (int j = 0; j < array.Length; j++)
				{
					if (!array[j].IsGenericParameter && (!array[j].IsGenericType || array[j].IsFullyConstructedGenericType()))
					{
						genericConstraintsSatisfactionInferredParameters[genericArguments[j]] = array[j];
					}
					else
					{
						num++;
					}
				}
				if (num == knownParameters.Length)
				{
					int num2 = 0;
					for (int k = 0; k < array.Length; k++)
					{
						if (array[k].IsGenericParameter)
						{
							array[k] = knownParameters[num2++];
						}
					}
					if (genericTypeDefinition.AreGenericConstraintsSatisfiedBy(array))
					{
						inferredParams = array;
						return true;
					}
				}
			}
			if (genericArguments.Length == knownParameters.Length && genericTypeDefinition.AreGenericConstraintsSatisfiedBy(knownParameters))
			{
				inferredParams = knownParameters;
				return true;
			}
			Type[] array2 = genericArguments;
			foreach (Type type in array2)
			{
				Type[] genericParameterConstraints = type.GetGenericParameterConstraints();
				Type[] array3 = genericParameterConstraints;
				foreach (Type type2 in array3)
				{
					foreach (Type item in genericConstraintsSatisfactionTypesToCheck)
					{
						if (!type2.IsGenericType)
						{
							continue;
						}
						Type genericTypeDefinition2 = type2.GetGenericTypeDefinition();
						Type[] genericArguments2 = type2.GetGenericArguments();
						Type[] array4;
						if (item.IsGenericType && genericTypeDefinition2 == item.GetGenericTypeDefinition())
						{
							array4 = item.GetGenericArguments();
						}
						else if (genericTypeDefinition2.IsInterface && item.ImplementsOpenGenericInterface(genericTypeDefinition2))
						{
							array4 = item.GetArgumentsOfInheritedOpenGenericInterface(genericTypeDefinition2);
						}
						else
						{
							if (!genericTypeDefinition2.IsClass || !item.ImplementsOpenGenericClass(genericTypeDefinition2))
							{
								continue;
							}
							array4 = item.GetArgumentsOfInheritedOpenGenericClass(genericTypeDefinition2);
						}
						genericConstraintsSatisfactionInferredParameters[type] = item;
						genericConstraintsSatisfactionTypesToCheck_ToAdd.Add(item);
						for (int n = 0; n < genericArguments2.Length; n++)
						{
							if (genericArguments2[n].IsGenericParameter)
							{
								genericConstraintsSatisfactionInferredParameters[genericArguments2[n]] = array4[n];
								genericConstraintsSatisfactionTypesToCheck_ToAdd.Add(array4[n]);
							}
						}
					}
					foreach (Type item2 in genericConstraintsSatisfactionTypesToCheck_ToAdd)
					{
						genericConstraintsSatisfactionTypesToCheck.Add(item2);
					}
					genericConstraintsSatisfactionTypesToCheck_ToAdd.Clear();
				}
			}
			if (genericConstraintsSatisfactionInferredParameters.Count == genericArguments.Length)
			{
				inferredParams = new Type[genericConstraintsSatisfactionInferredParameters.Count];
				for (int num3 = 0; num3 < genericArguments.Length; num3++)
				{
					inferredParams[num3] = genericConstraintsSatisfactionInferredParameters[genericArguments[num3]];
				}
				if (genericTypeDefinition.AreGenericConstraintsSatisfiedBy(inferredParams))
				{
					return true;
				}
			}
			inferredParams = null;
			return false;
		}
	}

	public static bool AreGenericConstraintsSatisfiedBy(this Type genericType, params Type[] parameters)
	{
		if (genericType == null)
		{
			throw new ArgumentNullException("genericType");
		}
		if (parameters == null)
		{
			throw new ArgumentNullException("parameters");
		}
		if (!genericType.IsGenericType)
		{
			throw new ArgumentException("The genericTypeDefinition parameter must be a generic type.");
		}
		return AreGenericConstraintsSatisfiedBy(genericType.GetGenericArguments(), parameters);
	}

	public static bool AreGenericConstraintsSatisfiedBy(this MethodBase genericMethod, params Type[] parameters)
	{
		if (genericMethod == null)
		{
			throw new ArgumentNullException("genericMethod");
		}
		if (parameters == null)
		{
			throw new ArgumentNullException("parameters");
		}
		if (!genericMethod.IsGenericMethod)
		{
			throw new ArgumentException("The genericMethod parameter must be a generic method.");
		}
		return AreGenericConstraintsSatisfiedBy(genericMethod.GetGenericArguments(), parameters);
	}

	public static bool AreGenericConstraintsSatisfiedBy(Type[] definitions, Type[] parameters)
	{
		if (definitions.Length != parameters.Length)
		{
			return false;
		}
		lock (GenericConstraintsSatisfaction_LOCK)
		{
			Dictionary<Type, Type> genericConstraintsSatisfactionResolvedMap = GenericConstraintsSatisfactionResolvedMap;
			genericConstraintsSatisfactionResolvedMap.Clear();
			for (int i = 0; i < definitions.Length; i++)
			{
				Type genericParameterDefinition = definitions[i];
				Type parameterType = parameters[i];
				if (!genericParameterDefinition.GenericParameterIsFulfilledBy(parameterType, genericConstraintsSatisfactionResolvedMap))
				{
					return false;
				}
			}
			return true;
		}
	}

	public static bool GenericParameterIsFulfilledBy(this Type genericParameterDefinition, Type parameterType)
	{
		lock (GenericConstraintsSatisfaction_LOCK)
		{
			GenericConstraintsSatisfactionResolvedMap.Clear();
			return genericParameterDefinition.GenericParameterIsFulfilledBy(parameterType, GenericConstraintsSatisfactionResolvedMap);
		}
	}

	private static bool GenericParameterIsFulfilledBy(this Type genericParameterDefinition, Type parameterType, Dictionary<Type, Type> resolvedMap, HashSet<Type> processedParams = null)
	{
		if (genericParameterDefinition == null)
		{
			throw new ArgumentNullException("genericParameterDefinition");
		}
		if (parameterType == null)
		{
			throw new ArgumentNullException("parameterType");
		}
		if (resolvedMap == null)
		{
			throw new ArgumentNullException("resolvedMap");
		}
		if (!genericParameterDefinition.IsGenericParameter && genericParameterDefinition == parameterType)
		{
			return true;
		}
		if (!genericParameterDefinition.IsGenericParameter)
		{
			return false;
		}
		if (processedParams == null)
		{
			processedParams = GenericConstraintsSatisfactionProcessedParams;
			processedParams.Clear();
		}
		processedParams.Add(genericParameterDefinition);
		GenericParameterAttributes genericParameterAttributes = genericParameterDefinition.GenericParameterAttributes;
		if (genericParameterAttributes != GenericParameterAttributes.None)
		{
			if ((genericParameterAttributes & GenericParameterAttributes.NotNullableValueTypeConstraint) == GenericParameterAttributes.NotNullableValueTypeConstraint)
			{
				if (!parameterType.IsValueType || (parameterType.IsGenericType && parameterType.GetGenericTypeDefinition() == typeof(Nullable<>)))
				{
					return false;
				}
			}
			else if ((genericParameterAttributes & GenericParameterAttributes.ReferenceTypeConstraint) == GenericParameterAttributes.ReferenceTypeConstraint && parameterType.IsValueType)
			{
				return false;
			}
			if ((genericParameterAttributes & GenericParameterAttributes.DefaultConstructorConstraint) == GenericParameterAttributes.DefaultConstructorConstraint && (parameterType.IsAbstract || (!parameterType.IsValueType && parameterType.GetConstructor(Type.EmptyTypes) == null)))
			{
				return false;
			}
		}
		if (resolvedMap.ContainsKey(genericParameterDefinition) && !parameterType.IsAssignableFrom(resolvedMap[genericParameterDefinition]))
		{
			return false;
		}
		Type[] genericParameterConstraints = genericParameterDefinition.GetGenericParameterConstraints();
		for (int i = 0; i < genericParameterConstraints.Length; i++)
		{
			Type type = genericParameterConstraints[i];
			if (type.IsGenericParameter && resolvedMap.ContainsKey(type))
			{
				type = resolvedMap[type];
			}
			if (type.IsGenericParameter)
			{
				if (!type.GenericParameterIsFulfilledBy(parameterType, resolvedMap, processedParams))
				{
					return false;
				}
				continue;
			}
			if (type.IsClass || type.IsInterface || type.IsValueType)
			{
				if (type.IsGenericType)
				{
					Type genericTypeDefinition = type.GetGenericTypeDefinition();
					Type[] genericArguments = type.GetGenericArguments();
					Type[] array;
					if (parameterType.IsGenericType && genericTypeDefinition == parameterType.GetGenericTypeDefinition())
					{
						array = parameterType.GetGenericArguments();
					}
					else if (genericTypeDefinition.IsClass)
					{
						if (!parameterType.ImplementsOpenGenericClass(genericTypeDefinition))
						{
							return false;
						}
						array = parameterType.GetArgumentsOfInheritedOpenGenericClass(genericTypeDefinition);
					}
					else
					{
						if (!parameterType.ImplementsOpenGenericInterface(genericTypeDefinition))
						{
							return false;
						}
						array = parameterType.GetArgumentsOfInheritedOpenGenericInterface(genericTypeDefinition);
					}
					for (int j = 0; j < genericArguments.Length; j++)
					{
						Type type2 = genericArguments[j];
						Type type3 = array[j];
						if (type2.IsGenericParameter && resolvedMap.ContainsKey(type2))
						{
							type2 = resolvedMap[type2];
						}
						if (type2.IsGenericParameter)
						{
							if (!processedParams.Contains(type2) && !type2.GenericParameterIsFulfilledBy(type3, resolvedMap, processedParams))
							{
								return false;
							}
						}
						else if (type2 != type3 && !type2.IsAssignableFrom(type3))
						{
							return false;
						}
					}
				}
				else if (!type.IsAssignableFrom(parameterType))
				{
					return false;
				}
				continue;
			}
			throw new Exception("Unknown parameter constraint type! " + type.GetNiceName());
		}
		resolvedMap[genericParameterDefinition] = parameterType;
		return true;
	}

	public static string GetGenericConstraintsString(this Type type, bool useFullTypeNames = false)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (!type.IsGenericTypeDefinition)
		{
			throw new ArgumentException("Type '" + type.GetNiceName() + "' is not a generic type definition!");
		}
		Type[] genericArguments = type.GetGenericArguments();
		string[] array = new string[genericArguments.Length];
		for (int i = 0; i < genericArguments.Length; i++)
		{
			array[i] = genericArguments[i].GetGenericParameterConstraintsString(useFullTypeNames);
		}
		return string.Join(" ", array);
	}

	public static string GetGenericParameterConstraintsString(this Type type, bool useFullTypeNames = false)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (!type.IsGenericParameter)
		{
			throw new ArgumentException("Type '" + type.GetNiceName() + "' is not a generic parameter!");
		}
		StringBuilder stringBuilder = new StringBuilder();
		bool flag = false;
		GenericParameterAttributes genericParameterAttributes = type.GenericParameterAttributes;
		if ((genericParameterAttributes & GenericParameterAttributes.NotNullableValueTypeConstraint) == GenericParameterAttributes.NotNullableValueTypeConstraint)
		{
			stringBuilder.Append("where ").Append(type.Name).Append(" : struct");
			flag = true;
		}
		else if ((genericParameterAttributes & GenericParameterAttributes.ReferenceTypeConstraint) == GenericParameterAttributes.ReferenceTypeConstraint)
		{
			stringBuilder.Append("where ").Append(type.Name).Append(" : class");
			flag = true;
		}
		if ((genericParameterAttributes & GenericParameterAttributes.DefaultConstructorConstraint) == GenericParameterAttributes.DefaultConstructorConstraint)
		{
			if (flag)
			{
				stringBuilder.Append(", new()");
			}
			else
			{
				stringBuilder.Append("where ").Append(type.Name).Append(" : new()");
				flag = true;
			}
		}
		Type[] genericParameterConstraints = type.GetGenericParameterConstraints();
		if (genericParameterConstraints.Length != 0)
		{
			foreach (Type type2 in genericParameterConstraints)
			{
				if (flag)
				{
					stringBuilder.Append(", ");
					if (useFullTypeNames)
					{
						stringBuilder.Append(type2.GetNiceFullName());
					}
					else
					{
						stringBuilder.Append(type2.GetNiceName());
					}
					continue;
				}
				stringBuilder.Append("where ").Append(type.Name).Append(" : ");
				if (useFullTypeNames)
				{
					stringBuilder.Append(type2.GetNiceFullName());
				}
				else
				{
					stringBuilder.Append(type2.GetNiceName());
				}
				flag = true;
			}
		}
		return stringBuilder.ToString();
	}

	public static bool GenericArgumentsContainsTypes(this Type type, params Type[] types)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (!type.IsGenericType)
		{
			return false;
		}
		bool[] array = new bool[types.Length];
		Type[] genericArguments = type.GetGenericArguments();
		Stack<Type> genericArgumentsContainsTypes_ArgsToCheckCached = GenericArgumentsContainsTypes_ArgsToCheckCached;
		lock (genericArgumentsContainsTypes_ArgsToCheckCached)
		{
			genericArgumentsContainsTypes_ArgsToCheckCached.Clear();
			for (int i = 0; i < genericArguments.Length; i++)
			{
				genericArgumentsContainsTypes_ArgsToCheckCached.Push(genericArguments[i]);
			}
			while (genericArgumentsContainsTypes_ArgsToCheckCached.Count > 0)
			{
				Type type2 = genericArgumentsContainsTypes_ArgsToCheckCached.Pop();
				for (int j = 0; j < types.Length; j++)
				{
					Type type3 = types[j];
					if (type3 == type2)
					{
						array[j] = true;
					}
					else if (type3.IsGenericTypeDefinition && type2.IsGenericType && !type2.IsGenericTypeDefinition && type2.GetGenericTypeDefinition() == type3)
					{
						array[j] = true;
					}
				}
				bool flag = true;
				for (int k = 0; k < array.Length; k++)
				{
					if (!array[k])
					{
						flag = false;
						break;
					}
				}
				if (flag)
				{
					return true;
				}
				if (type2.IsGenericType)
				{
					Type[] genericArguments2 = type2.GetGenericArguments();
					foreach (Type item in genericArguments2)
					{
						genericArgumentsContainsTypes_ArgsToCheckCached.Push(item);
					}
				}
			}
		}
		return false;
	}

	public static bool IsFullyConstructedGenericType(this Type type)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (type.IsGenericTypeDefinition)
		{
			return false;
		}
		if (type.HasElementType)
		{
			Type elementType = type.GetElementType();
			if (elementType.IsGenericParameter || !elementType.IsFullyConstructedGenericType())
			{
				return false;
			}
		}
		Type[] genericArguments = type.GetGenericArguments();
		foreach (Type type2 in genericArguments)
		{
			if (type2.IsGenericParameter)
			{
				return false;
			}
			if (!type2.IsFullyConstructedGenericType())
			{
				return false;
			}
		}
		return !type.IsGenericTypeDefinition;
	}

	public static bool IsNullableType(this Type type)
	{
		if (!type.IsPrimitive && !type.IsValueType)
		{
			return !type.IsEnum;
		}
		return false;
	}

	public static ulong GetEnumBitmask(object value, Type enumType)
	{
		if (!enumType.IsEnum)
		{
			throw new ArgumentException("enumType");
		}
		try
		{
			return Convert.ToUInt64(value, CultureInfo.InvariantCulture);
		}
		catch (OverflowException)
		{
			return (ulong)Convert.ToInt64(value, CultureInfo.InvariantCulture);
		}
	}

	public static Type[] SafeGetTypes(this Assembly assembly)
	{
		try
		{
			return assembly.GetTypes();
		}
		catch
		{
			return Type.EmptyTypes;
		}
	}

	public static bool SafeIsDefined(this Assembly assembly, Type attribute, bool inherit)
	{
		try
		{
			return assembly.IsDefined(attribute, inherit);
		}
		catch
		{
			return false;
		}
	}

	public static object[] SafeGetCustomAttributes(this Assembly assembly, Type type, bool inherit)
	{
		try
		{
			return assembly.GetCustomAttributes(type, inherit);
		}
		catch
		{
			return new object[0];
		}
	}
}
