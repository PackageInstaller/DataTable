namespace Unity.VisualScripting;

public static class XGraphEventListener
{
	public static void StartListening(this IGraphEventListener listener, GraphReference reference)
	{
		using GraphStack stack = reference.ToStackPooled();
		listener.StartListening(stack);
	}

	public static void StopListening(this IGraphEventListener listener, GraphReference reference)
	{
		using GraphStack stack = reference.ToStackPooled();
		listener.StopListening(stack);
	}

	public static bool IsHierarchyListening(GraphReference reference)
	{
		using GraphStack graphStack = reference.ToStackPooled();
		while (graphStack.isChild)
		{
			IGraphParent parent = graphStack.parent;
			graphStack.ExitParentElement();
			if (parent is IGraphEventListener graphEventListener && !graphEventListener.IsListening(graphStack))
			{
				return false;
			}
		}
		if (graphStack.graph is IGraphEventListener graphEventListener2 && !graphEventListener2.IsListening(graphStack))
		{
			return false;
		}
		return true;
	}
}
