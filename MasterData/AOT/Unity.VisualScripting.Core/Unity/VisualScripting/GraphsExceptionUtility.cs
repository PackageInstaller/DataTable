using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting;

public static class GraphsExceptionUtility
{
	private const string handledKey = "Bolt.Core.Handled";

	public static Exception GetException(this IGraphElementWithDebugData element, GraphPointer pointer)
	{
		if (!pointer.hasDebugData)
		{
			return null;
		}
		return pointer.GetElementDebugData<IGraphElementDebugData>(element).runtimeException;
	}

	public static void SetException(this IGraphElementWithDebugData element, GraphPointer pointer, Exception ex)
	{
		if (pointer.hasDebugData)
		{
			pointer.GetElementDebugData<IGraphElementDebugData>(element).runtimeException = ex;
		}
	}

	public static void HandleException(this IGraphElementWithDebugData element, GraphPointer pointer, Exception ex)
	{
		Ensure.That("ex").IsNotNull(ex);
		if (pointer == null)
		{
			Debug.LogError("Caught exception with null graph pointer (flow was likely disposed):\n" + ex);
			return;
		}
		GraphReference graphReference = pointer.AsReference();
		if (!ex.HandledIn(graphReference))
		{
			element.SetException(pointer, ex);
		}
		while (graphReference.isChild)
		{
			IGraphParentElement parentElement = graphReference.parentElement;
			graphReference = graphReference.ParentReference(ensureValid: true);
			if (parentElement is IGraphElementWithDebugData element2 && !ex.HandledIn(graphReference))
			{
				element2.SetException(graphReference, ex);
			}
		}
	}

	private static bool HandledIn(this Exception ex, GraphReference reference)
	{
		Ensure.That("ex").IsNotNull(ex);
		if (!ex.Data.Contains("Bolt.Core.Handled"))
		{
			ex.Data.Add("Bolt.Core.Handled", new HashSet<GraphReference>());
		}
		HashSet<GraphReference> hashSet = (HashSet<GraphReference>)ex.Data["Bolt.Core.Handled"];
		if (hashSet.Contains(reference))
		{
			return true;
		}
		hashSet.Add(reference);
		return false;
	}
}
