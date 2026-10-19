using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using Unity.VisualScripting.FullSerializer;
using Unity.VisualScripting.FullSerializer.Internal;

namespace Unity.VisualScripting;

public sealed class EnumerableCloner : Cloner<IEnumerable>
{
	private readonly Dictionary<Type, IOptimizedInvoker> addMethods = new Dictionary<Type, IOptimizedInvoker>();

	public override bool Handles(Type type)
	{
		if (typeof(IEnumerable).IsAssignableFrom(type) && !typeof(IList).IsAssignableFrom(type))
		{
			return GetAddMethod(type) != null;
		}
		return false;
	}

	public override void FillClone(Type type, ref IEnumerable clone, IEnumerable original, CloningContext context)
	{
		IOptimizedInvoker addMethod = GetAddMethod(type);
		if (addMethod == null)
		{
			throw new InvalidOperationException($"Cannot instantiate enumerable type '{type}' because it does not provide an add method.");
		}
		foreach (object item in original)
		{
			addMethod.Invoke(item, Cloning.Clone(context, item));
		}
	}

	private IOptimizedInvoker GetAddMethod(Type type)
	{
		if (!addMethods.ContainsKey(type))
		{
			MethodInfo methodInfo = fsReflectionUtility.GetInterface(type, typeof(ICollection<>))?.GetDeclaredMethod("Add") ?? type.GetFlattenedMethod("Add") ?? type.GetFlattenedMethod("Push") ?? type.GetFlattenedMethod("Enqueue");
			addMethods.Add(type, ((object)methodInfo != null) ? methodInfo.Prewarm() : null);
		}
		return addMethods[type];
	}
}
