using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq.Expressions;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Threading;

namespace System.Dynamic.Utils;

internal static class ExpressionUtils
{
	public static ReadOnlyCollection<ParameterExpression> ReturnReadOnly(IParameterProvider provider, ref object collection)
	{
		if (collection is ParameterExpression parameterExpression)
		{
			Interlocked.CompareExchange(ref collection, new ReadOnlyCollection<ParameterExpression>(new ListParameterProvider(provider, parameterExpression)), parameterExpression);
		}
		return (ReadOnlyCollection<ParameterExpression>)collection;
	}

	public static ReadOnlyCollection<T> ReturnReadOnly<T>(ref IReadOnlyList<T> collection)
	{
		IReadOnlyList<T> readOnlyList = collection;
		if (readOnlyList is ReadOnlyCollection<T> result)
		{
			return result;
		}
		Interlocked.CompareExchange(ref collection, readOnlyList.ToReadOnly(), readOnlyList);
		return (ReadOnlyCollection<T>)collection;
	}

	public static ReadOnlyCollection<Expression> ReturnReadOnly(IArgumentProvider provider, ref object collection)
	{
		if (collection is Expression expression)
		{
			Interlocked.CompareExchange(ref collection, new ReadOnlyCollection<Expression>(new ListArgumentProvider(provider, expression)), expression);
		}
		return (ReadOnlyCollection<Expression>)collection;
	}

	public static T ReturnObject<T>(object collectionOrT) where T : class
	{
		if (collectionOrT is T result)
		{
			return result;
		}
		return ((ReadOnlyCollection<T>)collectionOrT)[0];
	}

	public static void ValidateArgumentTypes(MethodBase method, ExpressionType nodeKind, ref ReadOnlyCollection<Expression> arguments, string methodParamName)
	{
		ParameterInfo[] parametersForValidation = GetParametersForValidation(method, nodeKind);
		ValidateArgumentCount(method, nodeKind, arguments.Count, parametersForValidation);
		Expression[] array = null;
		int i = 0;
		for (int num = parametersForValidation.Length; i < num; i++)
		{
			Expression arguments2 = arguments[i];
			ParameterInfo pi = parametersForValidation[i];
			arguments2 = ValidateOneArgument(method, nodeKind, arguments2, pi, methodParamName, "arguments", i);
			if (array == null && arguments2 != arguments[i])
			{
				array = new Expression[arguments.Count];
				for (int j = 0; j < i; j++)
				{
					array[j] = arguments[j];
				}
			}
			if (array != null)
			{
				array[i] = arguments2;
			}
		}
		if (array != null)
		{
			arguments = new TrueReadOnlyCollection<Expression>(array);
		}
	}

	public static void ValidateArgumentCount(MethodBase method, ExpressionType nodeKind, int count, ParameterInfo[] pis)
	{
		if (pis.Length != count)
		{
			switch (nodeKind)
			{
			case ExpressionType.New:
				throw Error.IncorrectNumberOfConstructorArguments();
			case ExpressionType.Invoke:
				throw Error.IncorrectNumberOfLambdaArguments();
			case ExpressionType.Call:
			case ExpressionType.Dynamic:
				throw Error.IncorrectNumberOfMethodCallArguments(method, "method");
			default:
				throw ContractUtils.Unreachable;
			}
		}
	}

	public static Expression ValidateOneArgument(MethodBase method, ExpressionType nodeKind, Expression arguments, ParameterInfo pi, string methodParamName, string argumentParamName, int index = -1)
	{
		RequiresCanRead(arguments, argumentParamName, index);
		Type type = pi.ParameterType;
		if (type.IsByRef)
		{
			type = type.GetElementType();
		}
		TypeUtils.ValidateType(type, methodParamName, allowByRef: true, allowPointer: true);
		if (!TypeUtils.AreReferenceAssignable(type, arguments.Type) && !TryQuote(type, ref arguments))
		{
			switch (nodeKind)
			{
			case ExpressionType.New:
				throw Error.ExpressionTypeDoesNotMatchConstructorParameter(arguments.Type, type, argumentParamName, index);
			case ExpressionType.Invoke:
				throw Error.ExpressionTypeDoesNotMatchParameter(arguments.Type, type, argumentParamName, index);
			case ExpressionType.Call:
			case ExpressionType.Dynamic:
				throw Error.ExpressionTypeDoesNotMatchMethodParameter(arguments.Type, type, method, argumentParamName, index);
			default:
				throw ContractUtils.Unreachable;
			}
		}
		return arguments;
	}

	public static void RequiresCanRead(Expression expression, string paramName)
	{
		RequiresCanRead(expression, paramName, -1);
	}

	public static void RequiresCanRead(Expression expression, string paramName, int idx)
	{
		ContractUtils.RequiresNotNull(expression, paramName, idx);
		switch (expression.NodeType)
		{
		case ExpressionType.Index:
		{
			IndexExpression indexExpression = (IndexExpression)expression;
			if (indexExpression.Indexer != null && !indexExpression.Indexer.CanRead)
			{
				throw Error.ExpressionMustBeReadable(paramName, idx);
			}
			break;
		}
		case ExpressionType.MemberAccess:
		{
			PropertyInfo propertyInfo = ((MemberExpression)expression).Member as PropertyInfo;
			if (propertyInfo != null && !propertyInfo.CanRead)
			{
				throw Error.ExpressionMustBeReadable(paramName, idx);
			}
			break;
		}
		}
	}

	public static bool TryQuote(Type parameterType, ref Expression argument)
	{
		if (TypeUtils.IsSameOrSubclass(typeof(LambdaExpression), parameterType) && parameterType.IsInstanceOfType(argument))
		{
			argument = Expression.Quote(argument);
			return true;
		}
		return false;
	}

	internal static ParameterInfo[] GetParametersForValidation(MethodBase method, ExpressionType nodeKind)
	{
		ParameterInfo[] array = method.GetParametersCached();
		if (nodeKind == ExpressionType.Dynamic)
		{
			array = array.RemoveFirst();
		}
		return array;
	}

	internal static bool SameElements<T>(ICollection<T> replacement, IReadOnlyList<T> current) where T : class
	{
		if (replacement == current)
		{
			return true;
		}
		if (replacement == null)
		{
			return current.Count == 0;
		}
		return SameElementsInCollection(replacement, current);
	}

	internal static bool SameElements<T>(ref IEnumerable<T> replacement, IReadOnlyList<T> current) where T : class
	{
		if (replacement == current)
		{
			return true;
		}
		if (replacement == null)
		{
			return current.Count == 0;
		}
		ICollection<T> collection = replacement as ICollection<T>;
		if (collection == null)
		{
			collection = (ICollection<T>)(replacement = replacement.ToReadOnly());
		}
		return SameElementsInCollection(collection, current);
	}

	private static bool SameElementsInCollection<T>(ICollection<T> replacement, IReadOnlyList<T> current) where T : class
	{
		int count = current.Count;
		if (replacement.Count != count)
		{
			return false;
		}
		if (count != 0)
		{
			int num = 0;
			foreach (T item in replacement)
			{
				if (item != current[num])
				{
					return false;
				}
				num++;
			}
		}
		return true;
	}

	public static void ValidateArgumentCount(this LambdaExpression lambda)
	{
		if (((IParameterProvider)lambda).ParameterCount >= 65535)
		{
			throw Error.InvalidProgram();
		}
	}
}
