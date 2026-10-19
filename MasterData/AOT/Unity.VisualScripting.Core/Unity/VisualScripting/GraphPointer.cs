using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Unity.VisualScripting;

public abstract class GraphPointer
{
	protected readonly List<IGraphParent> parentStack = new List<IGraphParent>();

	protected readonly List<IGraphParentElement> parentElementStack = new List<IGraphParentElement>();

	protected readonly List<IGraph> graphStack = new List<IGraph>();

	protected readonly List<IGraphData> dataStack = new List<IGraphData>();

	protected readonly List<IGraphDebugData> debugDataStack = new List<IGraphDebugData>();

	internal static Action<IGraphRoot> releaseDebugDataBinding;

	public IGraphRoot root { get; protected set; }

	public UnityEngine.Object rootObject => root as UnityEngine.Object;

	public IMachine machine => root as IMachine;

	public IMacro macro => root as IMacro;

	public MonoBehaviour component => root as MonoBehaviour;

	public GameObject gameObject { get; private set; }

	public GameObject self => gameObject;

	public ScriptableObject scriptableObject => root as ScriptableObject;

	public Scene? scene
	{
		get
		{
			if (gameObject == null)
			{
				return null;
			}
			Scene value = gameObject.scene;
			if (!value.IsValid())
			{
				return null;
			}
			return value;
		}
	}

	public UnityEngine.Object serializedObject
	{
		get
		{
			for (int num = depth; num > 0; num--)
			{
				IGraphParent graphParent = parentStack[num - 1];
				if (graphParent.isSerializationRoot)
				{
					return graphParent.serializedObject;
				}
			}
			throw new GraphPointerException("Could not find serialized object.", this);
		}
	}

	public IEnumerable<Guid> parentElementGuids => parentElementStack.Select((IGraphParentElement parentElement) => parentElement.guid);

	public int depth => parentStack.Count;

	public bool isRoot => depth == 1;

	public bool isChild => depth > 1;

	public IGraphParent parent => parentStack[parentStack.Count - 1];

	public IGraphParentElement parentElement
	{
		get
		{
			EnsureChild();
			return parentElementStack[parentElementStack.Count - 1];
		}
	}

	public IGraph rootGraph => graphStack[0];

	public IGraph graph => graphStack[graphStack.Count - 1];

	protected IGraphData _data
	{
		get
		{
			return dataStack[dataStack.Count - 1];
		}
		set
		{
			dataStack[dataStack.Count - 1] = value;
		}
	}

	public IGraphData data
	{
		get
		{
			EnsureDataAvailable();
			return _data;
		}
	}

	protected IGraphData _parentData => dataStack[dataStack.Count - 2];

	public bool hasData => _data != null;

	public static Func<IGraphRoot, IGraphDebugData> fetchRootDebugDataBinding { get; set; }

	public bool hasDebugData => _debugData != null;

	protected IGraphDebugData _debugData
	{
		get
		{
			return debugDataStack[debugDataStack.Count - 1];
		}
		set
		{
			debugDataStack[debugDataStack.Count - 1] = value;
		}
	}

	public IGraphDebugData debugData
	{
		get
		{
			EnsureDebugDataAvailable();
			return _debugData;
		}
	}

	public bool isValid
	{
		get
		{
			try
			{
				if (rootObject == null)
				{
					return false;
				}
				if (rootGraph != root.childGraph)
				{
					return false;
				}
				if (serializedObject == null)
				{
					return false;
				}
				for (int i = 1; i < depth; i++)
				{
					IGraphParentElement graphParentElement = parentElementStack[i - 1];
					IGraph graph = graphStack[i - 1];
					IGraph graph2 = graphStack[i];
					if (!graph.elements.Contains(graphParentElement))
					{
						return false;
					}
					if (graphParentElement.childGraph != graph2)
					{
						return false;
					}
				}
				return true;
			}
			catch (Exception ex)
			{
				Debug.LogWarning("Failed to check graph pointer validity: \n" + ex);
				return false;
			}
		}
	}

	protected static bool IsValidRoot(IGraphRoot root)
	{
		if (root?.childGraph != null)
		{
			return root as UnityEngine.Object != null;
		}
		return false;
	}

	protected static bool IsValidRoot(UnityEngine.Object rootObject)
	{
		if (rootObject != null)
		{
			return (rootObject as IGraphRoot)?.childGraph != null;
		}
		return false;
	}

	internal GraphPointer()
	{
	}

	protected void Initialize(IGraphRoot root)
	{
		if (!IsValidRoot(root))
		{
			throw new ArgumentException("Graph pointer root must be a valid Unity object with a non-null child graph.", "root");
		}
		if ((!(root is IMachine) || !(root is MonoBehaviour)) && (!(root is IMacro) || !(root is ScriptableObject)))
		{
			throw new ArgumentException("Graph pointer root must be either a machine or a macro.", "root");
		}
		this.root = root;
		parentStack.Add(root);
		graphStack.Add(root.childGraph);
		dataStack.Add(machine?.graphData);
		debugDataStack.Add(fetchRootDebugDataBinding?.Invoke(root));
		if (machine != null)
		{
			if (machine.threadSafeGameObject != null)
			{
				gameObject = machine.threadSafeGameObject;
				return;
			}
			if (!UnityThread.allowsAPI)
			{
				throw new GraphPointerException("Could not fetch graph pointer root game object.", this);
			}
			gameObject = component.gameObject;
		}
		else
		{
			gameObject = null;
		}
	}

	protected void Initialize(IGraphRoot root, IEnumerable<IGraphParentElement> parentElements, bool ensureValid)
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

	protected void Initialize(UnityEngine.Object rootObject, IEnumerable<Guid> parentElementGuids, bool ensureValid)
	{
		Initialize(rootObject as IGraphRoot);
		Ensure.That("parentElementGuids").IsNotNull(parentElementGuids);
		foreach (Guid parentElementGuid in parentElementGuids)
		{
			if (!TryEnterParentElement(parentElementGuid, out var error))
			{
				if (ensureValid)
				{
					throw new GraphPointerException(error, this);
				}
				break;
			}
		}
	}

	public abstract GraphReference AsReference();

	public virtual void CopyFrom(GraphPointer other)
	{
		root = other.root;
		gameObject = other.gameObject;
		parentStack.Clear();
		parentElementStack.Clear();
		graphStack.Clear();
		dataStack.Clear();
		debugDataStack.Clear();
		foreach (IGraphParent item in other.parentStack)
		{
			parentStack.Add(item);
		}
		foreach (IGraphParentElement item2 in other.parentElementStack)
		{
			parentElementStack.Add(item2);
		}
		foreach (IGraph item3 in other.graphStack)
		{
			graphStack.Add(item3);
		}
		foreach (IGraphData item4 in other.dataStack)
		{
			dataStack.Add(item4);
		}
		foreach (IGraphDebugData item5 in other.debugDataStack)
		{
			debugDataStack.Add(item5);
		}
	}

	public void EnsureDepthValid(int depth)
	{
		Ensure.That("depth").IsGte(depth, 1);
		if (depth > this.depth)
		{
			throw new GraphPointerException($"Trying to fetch a graph pointer level above depth: {depth} > {this.depth}", this);
		}
	}

	public void EnsureChild()
	{
		if (!isChild)
		{
			throw new GraphPointerException("Graph pointer does not point to a child graph.", this);
		}
	}

	public bool IsWithin<T>() where T : IGraphParent
	{
		return parent is T;
	}

	public void EnsureWithin<T>() where T : IGraphParent
	{
		if (!IsWithin<T>())
		{
			throw new GraphPointerException($"Graph pointer must be within a {typeof(T)} for this operation.", this);
		}
	}

	public T GetParent<T>() where T : IGraphParent
	{
		EnsureWithin<T>();
		return (T)parent;
	}

	public void EnsureDataAvailable()
	{
		if (!hasData)
		{
			throw new GraphPointerException("Graph data is not available.", this);
		}
	}

	public T GetGraphData<T>() where T : IGraphData
	{
		IGraphData graphData = data;
		if (graphData is T)
		{
			return (T)graphData;
		}
		throw new GraphPointerException($"Graph data type mismatch. Found {graphData.GetType()}, expected {typeof(T)}.", this);
	}

	public T GetElementData<T>(IGraphElementWithData element) where T : IGraphElementData
	{
		if (_data.TryGetElementData(element, out var graphElementData))
		{
			if (graphElementData is T)
			{
				return (T)graphElementData;
			}
			throw new GraphPointerException($"Graph element data type mismatch. Found {graphElementData.GetType()}, expected {typeof(T)}.", this);
		}
		throw new GraphPointerException($"Missing graph element data for {element}.", this);
	}

	public void EnsureDebugDataAvailable()
	{
		if (!hasDebugData)
		{
			throw new GraphPointerException("Graph debug data is not available.", this);
		}
	}

	public T GetGraphDebugData<T>() where T : IGraphDebugData
	{
		IGraphDebugData graphDebugData = debugData;
		if (graphDebugData is T)
		{
			return (T)graphDebugData;
		}
		throw new GraphPointerException($"Graph debug data type mismatch. Found {graphDebugData.GetType()}, expected {typeof(T)}.", this);
	}

	public T GetElementDebugData<T>(IGraphElementWithDebugData element)
	{
		IGraphElementDebugData orCreateElementData = debugData.GetOrCreateElementData(element);
		if (orCreateElementData is T)
		{
			return (T)orCreateElementData;
		}
		throw new GraphPointerException($"Graph element runtime debug data type mismatch. Found {orCreateElementData.GetType()}, expected {typeof(T)}.", this);
	}

	protected bool TryEnterParentElement(Guid parentElementGuid, out string error, int? maxRecursionDepth = null)
	{
		if (!graph.elements.TryGetValue(parentElementGuid, out var value))
		{
			error = "Trying to enter a graph parent element with a GUID that is not within the current graph.";
			return false;
		}
		if (!(value is IGraphParentElement))
		{
			error = "Provided element GUID does not point to a graph parent element.";
			return false;
		}
		IGraphParentElement graphParentElement = (IGraphParentElement)value;
		return TryEnterParentElement(graphParentElement, out error, maxRecursionDepth);
	}

	protected bool TryEnterParentElement(IGraphParentElement parentElement, out string error, int? maxRecursionDepth = null, bool skipContainsCheck = false)
	{
		if (!skipContainsCheck && !graph.elements.Contains(parentElement))
		{
			error = "Trying to enter a graph parent element that is not within the current graph.";
			return false;
		}
		IGraph childGraph = parentElement.childGraph;
		if (childGraph == null)
		{
			error = "Trying to enter a graph parent element without a child graph.";
			return false;
		}
		if (Recursion.safeMode)
		{
			int num = 0;
			int num2 = maxRecursionDepth ?? Recursion.defaultMaxDepth;
			foreach (IGraph item in graphStack)
			{
				if (item == childGraph)
				{
					num++;
				}
			}
			if (num > num2)
			{
				error = string.Format("Max recursion depth of {0} has been exceeded. Are you nesting a graph within itself?\nIf not, consider increasing '{1}.{2}'.", num2, "Recursion", "defaultMaxDepth");
				return false;
			}
		}
		EnterValidParentElement(parentElement);
		error = null;
		return true;
	}

	protected void EnterParentElement(IGraphParentElement parentElement)
	{
		if (!TryEnterParentElement(parentElement, out var error))
		{
			throw new GraphPointerException(error, this);
		}
	}

	protected void EnterParentElement(Guid parentElementGuid)
	{
		if (!TryEnterParentElement(parentElementGuid, out var error))
		{
			throw new GraphPointerException(error, this);
		}
	}

	private void EnterValidParentElement(IGraphParentElement parentElement)
	{
		IGraph childGraph = parentElement.childGraph;
		parentStack.Add(parentElement);
		parentElementStack.Add(parentElement);
		graphStack.Add(childGraph);
		IGraphData item = null;
		_data?.TryGetChildGraphData(parentElement, out item);
		dataStack.Add(item);
		IGraphDebugData item2 = _debugData?.GetOrCreateChildGraphData(parentElement);
		debugDataStack.Add(item2);
	}

	protected void ExitParentElement()
	{
		if (!isChild)
		{
			throw new GraphPointerException("Trying to exit the root graph.", this);
		}
		parentStack.RemoveAt(parentStack.Count - 1);
		parentElementStack.RemoveAt(parentElementStack.Count - 1);
		graphStack.RemoveAt(graphStack.Count - 1);
		dataStack.RemoveAt(dataStack.Count - 1);
		debugDataStack.RemoveAt(debugDataStack.Count - 1);
	}

	public void EnsureValid()
	{
		if (!isValid)
		{
			throw new GraphPointerException("Graph pointer is invalid.", this);
		}
	}

	public bool InstanceEquals(GraphPointer other)
	{
		if (this == other)
		{
			return true;
		}
		if (!UnityObjectUtility.TrulyEqual(rootObject, other.rootObject))
		{
			return false;
		}
		if (!DefinitionEquals(other))
		{
			return false;
		}
		int num = depth;
		for (int i = 0; i < num; i++)
		{
			IGraphData graphData = dataStack[i];
			IGraphData graphData2 = other.dataStack[i];
			if (graphData != graphData2)
			{
				return false;
			}
		}
		return true;
	}

	public bool DefinitionEquals(GraphPointer other)
	{
		if (other == null)
		{
			return false;
		}
		if (rootGraph != other.rootGraph)
		{
			return false;
		}
		int num = depth;
		if (num != other.depth)
		{
			return false;
		}
		for (int i = 1; i < num; i++)
		{
			IGraphParentElement graphParentElement = parentElementStack[i - 1];
			IGraphParentElement graphParentElement2 = other.parentElementStack[i - 1];
			if (graphParentElement != graphParentElement2)
			{
				return false;
			}
		}
		return true;
	}

	public int ComputeHashCode()
	{
		int num = 17;
		num = num * 23 + (rootObject.AsUnityNull()?.GetHashCode() ?? 0);
		num = num * 23 + (rootGraph?.GetHashCode() ?? 0);
		int num2 = depth;
		for (int i = 1; i < num2; i++)
		{
			num = num * 23 + parentElementStack[i - 1].guid.GetHashCode();
		}
		return num;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("[ ");
		stringBuilder.Append(rootObject.ToSafeString());
		for (int i = 1; i < depth; i++)
		{
			stringBuilder.Append(" > ");
			int num = i - 1;
			if (num >= parentElementStack.Count)
			{
				stringBuilder.Append("?");
				break;
			}
			IGraphParentElement value = parentElementStack[num];
			stringBuilder.Append(value);
		}
		stringBuilder.Append(" ]");
		return stringBuilder.ToString();
	}
}
