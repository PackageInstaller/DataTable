using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq.Expressions;

namespace System.Dynamic.Utils;

internal static class ContractUtils
{
	[ExcludeFromCodeCoverage]
	public static Exception Unreachable => new InvalidOperationException("Code supposed to be unreachable");

	public static void Requires(bool precondition, string paramName)
	{
		if (!precondition)
		{
			throw Error.InvalidArgumentValue(paramName);
		}
	}

	public static void RequiresNotNull(object value, string paramName)
	{
		if (value == null)
		{
			throw new ArgumentNullException(paramName);
		}
	}

	public static void RequiresNotNull(object value, string paramName, int index)
	{
		if (value == null)
		{
			throw new ArgumentNullException(GetParamName(paramName, index));
		}
	}

	public static void RequiresNotEmpty<T>(ICollection<T> collection, string paramName)
	{
		RequiresNotNull(collection, paramName);
		if (collection.Count == 0)
		{
			throw Error.NonEmptyCollectionRequired(paramName);
		}
	}

	public static void RequiresNotNullItems<T>(IList<T> array, string arrayName)
	{
		RequiresNotNull(array, arrayName);
		int i = 0;
		for (int count = array.Count; i < count; i++)
		{
			if (array[i] == null)
			{
				throw new ArgumentNullException(GetParamName(arrayName, i));
			}
		}
	}

	private static string GetParamName(string paramName, int index)
	{
		if (index < 0)
		{
			return paramName;
		}
		return $"{paramName}[{index}]";
	}

	public static void RequiresArrayRange<T>(IList<T> array, int offset, int count, string offsetName, string countName)
	{
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException(countName);
		}
		if (offset < 0 || array.Count - offset < count)
		{
			throw new ArgumentOutOfRangeException(offsetName);
		}
	}
}
