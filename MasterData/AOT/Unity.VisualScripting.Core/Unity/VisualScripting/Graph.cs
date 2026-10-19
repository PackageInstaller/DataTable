using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

public abstract class Graph : IGraph, IDisposable, IPrewarmable, IAotStubbable, ISerializationDepender, ISerializationCallbackReceiver
{
	[SerializeAs("elements")]
	private List<IGraphElement> _elements = new List<IGraphElement>();

	private bool prewarmed;

	[DoNotSerialize]
	public MergedGraphElementCollection elements { get; }

	[Serialize]
	public string title { get; set; }

	[InspectorTextArea(minLines = 1f, maxLines = 10f)]
	[Serialize]
	public string summary { get; set; }

	[Serialize]
	public Vector2 pan { get; set; }

	[Serialize]
	public float zoom { get; set; } = 1f;

	public IEnumerable<ISerializationDependency> deserializationDependencies => _elements.SelectMany((IGraphElement e) => e.deserializationDependencies);

	protected Graph()
	{
		elements = new MergedGraphElementCollection();
	}

	public override string ToString()
	{
		return StringUtility.FallbackWhitespace(title, base.ToString());
	}

	public abstract IGraphData CreateData();

	public virtual IGraphDebugData CreateDebugData()
	{
		return new GraphDebugData(this);
	}

	public virtual void Instantiate(GraphReference instance)
	{
		foreach (IGraphElement element in elements)
		{
			element.Instantiate(instance);
		}
	}

	public virtual void Uninstantiate(GraphReference instance)
	{
		foreach (IGraphElement element in elements)
		{
			element.Uninstantiate(instance);
		}
	}

	public virtual void OnBeforeSerialize()
	{
		_elements.Clear();
		_elements.AddRange(elements);
	}

	public void OnAfterDeserialize()
	{
		Serialization.AwaitDependencies(this);
	}

	public virtual void OnAfterDependenciesDeserialized()
	{
		elements.Clear();
		List<IGraphElement> list = ListPool<IGraphElement>.New();
		foreach (IGraphElement element in _elements)
		{
			list.Add(element);
		}
		list.Sort((IGraphElement a, IGraphElement b) => a.dependencyOrder.CompareTo(b.dependencyOrder));
		foreach (IGraphElement item in list)
		{
			try
			{
				if (item.HandleDependencies())
				{
					elements.Add(item);
				}
			}
			catch (Exception arg)
			{
				Debug.LogWarning($"Failed to add element to graph during deserialization: {item}\n{arg}");
			}
		}
		ListPool<IGraphElement>.Free(list);
	}

	public IEnumerable<object> GetAotStubs(HashSet<object> visited)
	{
		return elements.Where((IGraphElement element) => !visited.Contains(element)).Select((IGraphElement element) =>
		{
			visited.Add(element);
			return element;
		}).SelectMany((IGraphElement element) => element.GetAotStubs(visited));
	}

	public void Prewarm()
	{
		if (prewarmed)
		{
			return;
		}
		foreach (IGraphElement element in elements)
		{
			element.Prewarm();
		}
		prewarmed = true;
	}

	public virtual void Dispose()
	{
		foreach (IGraphElement element in elements)
		{
			element.Dispose();
		}
	}
}
