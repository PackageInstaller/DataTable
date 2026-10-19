using System;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public sealed class GraphStack : GraphPointer, IPoolable, IDisposable
{
	private GraphStack()
	{
	}

	private void InitializeNoAlloc(IGraphRoot root, List<IGraphParentElement> parentElements, bool ensureValid)
	{
		Initialize(root);
		Ensure.That("parentElements").IsNotNull(parentElements);
		foreach (IGraphParentElement parentElement in parentElements)
		{
			if (!TryEnterParentElement(parentElement, out var error))
			{
				if (ensureValid)
				{
					throw new GraphPointerException(error, this);
				}
				break;
			}
		}
	}

	internal static GraphStack New(IGraphRoot root, List<IGraphParentElement> parentElements)
	{
		GraphStack graphStack = GenericPool<GraphStack>.New(() => new GraphStack());
		graphStack.InitializeNoAlloc(root, parentElements, ensureValid: true);
		return graphStack;
	}

	internal static GraphStack New(GraphPointer model)
	{
		GraphStack graphStack = GenericPool<GraphStack>.New(() => new GraphStack());
		graphStack.CopyFrom(model);
		return graphStack;
	}

	public GraphStack Clone()
	{
		return New(this);
	}

	public void Dispose()
	{
		GenericPool<GraphStack>.Free(this);
	}

	void IPoolable.New()
	{
	}

	void IPoolable.Free()
	{
		root = null;
		parentStack.Clear();
		parentElementStack.Clear();
		graphStack.Clear();
		dataStack.Clear();
		debugDataStack.Clear();
	}

	public override GraphReference AsReference()
	{
		return ToReference();
	}

	public GraphReference ToReference()
	{
		return GraphReference.Intern(this);
	}

	internal void ClearReference()
	{
		GraphReference.ClearIntern(this);
	}

	public new void EnterParentElement(IGraphParentElement parentElement)
	{
		base.EnterParentElement(parentElement);
	}

	public bool TryEnterParentElement(IGraphParentElement parentElement)
	{
		string error;
		return TryEnterParentElement(parentElement, out error);
	}

	public bool TryEnterParentElementUnsafe(IGraphParentElement parentElement)
	{
		string error;
		return TryEnterParentElement(parentElement, out error, null, skipContainsCheck: true);
	}

	public new void ExitParentElement()
	{
		base.ExitParentElement();
	}
}
