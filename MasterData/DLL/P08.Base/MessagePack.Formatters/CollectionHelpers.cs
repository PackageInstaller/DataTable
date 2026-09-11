using System;
using System.Linq.Expressions;
using System.Reflection;

namespace MessagePack.Formatters;

internal static class CollectionHelpers<TCollection, TEqualityComparer> where TCollection : new()
{
	private static Func<int, TEqualityComparer, TCollection> collectionCreator;

	static CollectionHelpers()
	{
		ConstructorInfo constructor = typeof(TCollection).GetConstructor(new Type[2]
		{
			typeof(int),
			typeof(TEqualityComparer)
		});
		if (constructor != null)
		{
			ParameterExpression parameterExpression = Expression.Parameter(typeof(int), "count");
			ParameterExpression parameterExpression2 = Expression.Parameter(typeof(TEqualityComparer), "equalityComparer");
			collectionCreator = Expression.Lambda<Func<int, TEqualityComparer, TCollection>>(Expression.New(constructor, parameterExpression, parameterExpression2), new ParameterExpression[2] { parameterExpression, parameterExpression2 }).Compile();
		}
	}

	internal static TCollection CreateHashCollection(int count, TEqualityComparer equalityComparer)
	{
		if (collectionCreator == null)
		{
			return new TCollection();
		}
		return collectionCreator(count, equalityComparer);
	}
}
