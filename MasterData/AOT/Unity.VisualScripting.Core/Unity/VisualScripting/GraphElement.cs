using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Unity.VisualScripting;

public abstract class GraphElement<TGraph> : IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable where TGraph : class, IGraph
{
	[Serialize]
	public Guid guid { get; set; } = Guid.NewGuid();

	[DoNotSerialize]
	public virtual int dependencyOrder => 0;

	[DoNotSerialize]
	public TGraph graph { get; set; }

	[DoNotSerialize]
	IGraph IGraphElement.graph
	{
		get
		{
			return graph;
		}
		set
		{
			Ensure.That("value").IsOfType<TGraph>(value);
			graph = (TGraph)value;
		}
	}

	[DoNotSerialize]
	IGraph IGraphItem.graph => graph;

	public virtual IEnumerable<ISerializationDependency> deserializationDependencies => Enumerable.Empty<ISerializationDependency>();

	public virtual void Instantiate(GraphReference instance)
	{
		if (this is IGraphElementWithData element)
		{
			instance.data.CreateElementData(element);
		}
		if (this is IGraphNesterElement graphNesterElement && graphNesterElement.nest.graph != null)
		{
			GraphInstances.Instantiate(instance.ChildReference(graphNesterElement, ensureValid: true));
		}
	}

	public virtual void Uninstantiate(GraphReference instance)
	{
		if (this is IGraphNesterElement graphNesterElement && graphNesterElement.nest.graph != null)
		{
			GraphInstances.Uninstantiate(instance.ChildReference(graphNesterElement, ensureValid: true));
		}
		if (this is IGraphElementWithData element)
		{
			instance.data.FreeElementData(element);
		}
	}

	public virtual void BeforeAdd()
	{
	}

	public virtual void AfterAdd()
	{
		HashSet<GraphReference> hashSet = GraphInstances.OfPooled(graph);
		foreach (GraphReference item in hashSet)
		{
			Instantiate(item);
		}
		hashSet.Free();
	}

	public virtual void BeforeRemove()
	{
		HashSet<GraphReference> hashSet = GraphInstances.OfPooled(graph);
		foreach (GraphReference item in hashSet)
		{
			Uninstantiate(item);
		}
		hashSet.Free();
		Dispose();
	}

	public virtual void AfterRemove()
	{
	}

	public virtual void Dispose()
	{
	}

	protected void InstantiateNest()
	{
		IGraphNesterElement parentElement = (IGraphNesterElement)this;
		if (graph == null)
		{
			return;
		}
		HashSet<GraphReference> hashSet = GraphInstances.OfPooled(graph);
		foreach (GraphReference item in hashSet)
		{
			GraphInstances.Instantiate(item.ChildReference(parentElement, ensureValid: true));
		}
		hashSet.Free();
	}

	protected void UninstantiateNest()
	{
		HashSet<GraphReference> hashSet = GraphInstances.ChildrenOfPooled((IGraphNesterElement)this);
		foreach (GraphReference item in hashSet)
		{
			GraphInstances.Uninstantiate(item);
		}
		hashSet.Free();
	}

	public virtual bool HandleDependencies()
	{
		return true;
	}

	public virtual IEnumerable<object> GetAotStubs(HashSet<object> visited)
	{
		return Enumerable.Empty<object>();
	}

	public virtual void Prewarm()
	{
	}

	protected void CopyFrom(GraphElement<TGraph> source)
	{
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append(GetType().Name);
		stringBuilder.Append("#");
		stringBuilder.Append(guid.ToString().Substring(0, 5));
		stringBuilder.Append("...");
		return stringBuilder.ToString();
	}

	public virtual AnalyticsIdentifier GetAnalyticsIdentifier()
	{
		throw new NotImplementedException();
	}
}
