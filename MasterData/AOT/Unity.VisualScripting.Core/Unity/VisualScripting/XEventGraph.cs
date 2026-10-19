using System;

namespace Unity.VisualScripting;

public static class XEventGraph
{
	public static void TriggerEventHandler<TArgs>(this GraphReference reference, Func<EventHook, bool> predicate, TArgs args, Func<IGraphParentElement, bool> recurse, bool force)
	{
		Ensure.That("reference").IsNotNull(reference);
		foreach (IGraphElement element in reference.graph.elements)
		{
			if (element is IGraphEventHandler<TArgs> graphEventHandler && (predicate == null || predicate(graphEventHandler.GetHook(reference))) && (force || graphEventHandler.IsListening(reference)))
			{
				graphEventHandler.Trigger(reference, args);
			}
			if (element is IGraphParentElement graphParentElement && recurse(graphParentElement))
			{
				reference.ChildReference(graphParentElement, ensureValid: false, 0)?.TriggerEventHandler(predicate, args, recurse, force);
			}
		}
	}

	public static void TriggerEventHandler<TArgs>(this GraphStack stack, Func<EventHook, bool> predicate, TArgs args, Func<IGraphParentElement, bool> recurse, bool force)
	{
		Ensure.That("stack").IsNotNull(stack);
		GraphReference graphReference = null;
		foreach (IGraphElement element in stack.graph.elements)
		{
			if (element is IGraphEventHandler<TArgs> graphEventHandler)
			{
				if (graphReference == null)
				{
					graphReference = stack.ToReference();
				}
				if ((predicate == null || predicate(graphEventHandler.GetHook(graphReference))) && (force || graphEventHandler.IsListening(graphReference)))
				{
					graphEventHandler.Trigger(graphReference, args);
				}
			}
			if (element is IGraphParentElement graphParentElement && recurse(graphParentElement) && stack.TryEnterParentElementUnsafe(graphParentElement))
			{
				stack.TriggerEventHandler(predicate, args, recurse, force);
				stack.ExitParentElement();
			}
		}
	}
}
