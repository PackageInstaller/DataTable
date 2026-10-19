using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

public sealed class Flow : IPoolable, IDisposable
{
	private struct RecursionNode : IEquatable<RecursionNode>
	{
		public IUnitPort port { get; }

		public IGraphParent context { get; }

		public RecursionNode(IUnitPort port, GraphPointer pointer)
		{
			this.port = port;
			context = pointer.parent;
		}

		public bool Equals(RecursionNode other)
		{
			if (other.port == port)
			{
				return other.context == context;
			}
			return false;
		}

		public override bool Equals(object obj)
		{
			if (obj is RecursionNode other)
			{
				return Equals(other);
			}
			return false;
		}

		public override int GetHashCode()
		{
			return HashUtility.GetHashCode(port, context);
		}
	}

	private Recursion<RecursionNode> recursion;

	private readonly Dictionary<IUnitValuePort, object> locals = new Dictionary<IUnitValuePort, object>();

	public readonly VariableDeclarations variables = new VariableDeclarations();

	private readonly Stack<int> loops = new Stack<int>();

	private readonly HashSet<GraphStack> preservedStacks = new HashSet<GraphStack>();

	private ICollection<Flow> activeCoroutinesRegistry;

	private bool coroutineStopRequested;

	private IEnumerator coroutineEnumerator;

	private bool disposed;

	public int loopIdentifier = -1;

	public GraphStack stack { get; private set; }

	public MonoBehaviour coroutineRunner { get; private set; }

	public bool isCoroutine { get; private set; }

	public bool isPrediction { get; private set; }

	public bool enableDebug
	{
		get
		{
			if (isPrediction)
			{
				return false;
			}
			if (!stack.hasDebugData)
			{
				return false;
			}
			return true;
		}
	}

	public static Func<GraphPointer, bool> isInspectedBinding { get; set; }

	public bool isInspected => isInspectedBinding?.Invoke(stack) ?? false;

	public int currentLoop
	{
		get
		{
			if (loops.Count > 0)
			{
				return loops.Peek();
			}
			return -1;
		}
	}

	private Flow()
	{
	}

	public static Flow New(GraphReference reference)
	{
		Ensure.That("reference").IsNotNull(reference);
		Flow flow = GenericPool<Flow>.New(() => new Flow());
		flow.stack = reference.ToStackPooled();
		return flow;
	}

	void IPoolable.New()
	{
		disposed = false;
		recursion = Recursion<RecursionNode>.New();
	}

	public void Dispose()
	{
		if (disposed)
		{
			throw new ObjectDisposedException(ToString());
		}
		GenericPool<Flow>.Free(this);
	}

	void IPoolable.Free()
	{
		stack?.Dispose();
		recursion?.Dispose();
		locals.Clear();
		loops.Clear();
		variables.Clear();
		foreach (GraphStack preservedStack in preservedStacks)
		{
			preservedStack.Dispose();
		}
		preservedStacks.Clear();
		loopIdentifier = -1;
		stack = null;
		recursion = null;
		isCoroutine = false;
		coroutineEnumerator = null;
		coroutineRunner = null;
		activeCoroutinesRegistry?.Remove(this);
		activeCoroutinesRegistry = null;
		coroutineStopRequested = false;
		isPrediction = false;
		disposed = true;
	}

	public GraphStack PreserveStack()
	{
		GraphStack graphStack = stack.Clone();
		preservedStacks.Add(graphStack);
		return graphStack;
	}

	public void RestoreStack(GraphStack stack)
	{
		this.stack.CopyFrom(stack);
	}

	public void DisposePreservedStack(GraphStack stack)
	{
		stack.Dispose();
		preservedStacks.Remove(stack);
	}

	public bool LoopIsNotBroken(int loop)
	{
		return currentLoop == loop;
	}

	public int EnterLoop()
	{
		int num = ++loopIdentifier;
		loops.Push(num);
		return num;
	}

	public void BreakLoop()
	{
		if (currentLoop < 0)
		{
			throw new InvalidOperationException("No active loop to break.");
		}
		loops.Pop();
	}

	public void ExitLoop(int loop)
	{
		if (loop == currentLoop)
		{
			loops.Pop();
		}
	}

	public void Run(ControlOutput port)
	{
		Invoke(port);
		Dispose();
	}

	public void StartCoroutine(ControlOutput port, ICollection<Flow> registry = null)
	{
		isCoroutine = true;
		coroutineRunner = stack.component;
		if (coroutineRunner == null)
		{
			coroutineRunner = CoroutineRunner.instance;
		}
		activeCoroutinesRegistry = registry;
		activeCoroutinesRegistry?.Add(this);
		coroutineEnumerator = Coroutine(port);
		coroutineRunner.StartCoroutine(coroutineEnumerator);
	}

	public void StopCoroutine(bool disposeInstantly)
	{
		if (!isCoroutine)
		{
			throw new NotSupportedException("Stop may only be called on coroutines.");
		}
		if (disposeInstantly)
		{
			StopCoroutineImmediate();
		}
		else
		{
			coroutineStopRequested = true;
		}
	}

	internal void StopCoroutineImmediate()
	{
		if ((bool)coroutineRunner && coroutineEnumerator != null)
		{
			coroutineRunner.StopCoroutine(coroutineEnumerator);
			((IDisposable)coroutineEnumerator).Dispose();
		}
	}

	private IEnumerator Coroutine(ControlOutput startPort)
	{
		try
		{
			foreach (object item in InvokeCoroutine(startPort))
			{
				if (coroutineStopRequested)
				{
					yield break;
				}
				yield return item;
				if (coroutineStopRequested)
				{
					yield break;
				}
			}
		}
		finally
		{
			Flow flow = this;
			if (!flow.disposed)
			{
				flow.Dispose();
			}
		}
	}

	public void Invoke(ControlOutput output)
	{
		Ensure.That("output").IsNotNull(output);
		ControlConnection connection = output.connection;
		if (connection == null)
		{
			return;
		}
		ControlInput destination = connection.destination;
		RecursionNode recursionNode = new RecursionNode(output, stack);
		BeforeInvoke(output, recursionNode);
		try
		{
			ControlOutput controlOutput = InvokeDelegate(destination);
			if (controlOutput != null)
			{
				Invoke(controlOutput);
			}
		}
		finally
		{
			AfterInvoke(output, recursionNode);
		}
	}

	private IEnumerable InvokeCoroutine(ControlOutput output)
	{
		ControlConnection connection = output.connection;
		if (connection == null)
		{
			yield break;
		}
		ControlInput destination = connection.destination;
		RecursionNode recursionNode = new RecursionNode(output, stack);
		BeforeInvoke(output, recursionNode);
		if (destination.supportsCoroutine)
		{
			foreach (object item in InvokeCoroutineDelegate(destination))
			{
				if (item is ControlOutput)
				{
					foreach (object item2 in InvokeCoroutine((ControlOutput)item))
					{
						yield return item2;
					}
				}
				else
				{
					yield return item;
				}
			}
		}
		else
		{
			ControlOutput controlOutput = InvokeDelegate(destination);
			if (controlOutput != null)
			{
				foreach (object item3 in InvokeCoroutine(controlOutput))
				{
					yield return item3;
				}
			}
		}
		AfterInvoke(output, recursionNode);
	}

	private RecursionNode BeforeInvoke(ControlOutput output, RecursionNode recursionNode)
	{
		try
		{
			recursion?.Enter(recursionNode);
		}
		catch (StackOverflowException ex)
		{
			output.unit.HandleException(stack, ex);
			throw;
		}
		ControlConnection connection = output.connection;
		ControlInput destination = connection.destination;
		if (enableDebug)
		{
			IUnitConnectionDebugData elementDebugData = stack.GetElementDebugData<IUnitConnectionDebugData>(connection);
			IUnitDebugData elementDebugData2 = stack.GetElementDebugData<IUnitDebugData>(destination.unit);
			elementDebugData.lastInvokeFrame = EditorTimeBinding.frame;
			elementDebugData.lastInvokeTime = EditorTimeBinding.time;
			elementDebugData2.lastInvokeFrame = EditorTimeBinding.frame;
			elementDebugData2.lastInvokeTime = EditorTimeBinding.time;
		}
		return recursionNode;
	}

	private void AfterInvoke(ControlOutput output, RecursionNode recursionNode)
	{
		recursion?.Exit(recursionNode);
	}

	private ControlOutput InvokeDelegate(ControlInput input)
	{
		try
		{
			if (input.requiresCoroutine)
			{
				throw new InvalidOperationException($"Port '{input.key}' on '{input.unit}' can only be triggered in a coroutine.");
			}
			return input.action(this);
		}
		catch (Exception ex)
		{
			input.unit.HandleException(stack, ex);
			throw;
		}
	}

	private IEnumerable InvokeCoroutineDelegate(ControlInput input)
	{
		IEnumerator instructions = input.coroutineAction(this);
		while (true)
		{
			object current;
			try
			{
				if (!instructions.MoveNext())
				{
					break;
				}
				current = instructions.Current;
			}
			catch (Exception ex)
			{
				input.unit.HandleException(stack, ex);
				throw;
			}
			yield return current;
		}
	}

	public bool IsLocal(IUnitValuePort port)
	{
		Ensure.That("port").IsNotNull(port);
		return locals.ContainsKey(port);
	}

	public void SetValue(IUnitValuePort port, object value)
	{
		Ensure.That("port").IsNotNull(port);
		Ensure.That("value").IsOfType(value, port.type);
		if (locals.ContainsKey(port))
		{
			locals[port] = value;
		}
		else
		{
			locals.Add(port, value);
		}
	}

	public object GetValue(ValueInput input)
	{
		if (locals.TryGetValue(input, out var value))
		{
			return value;
		}
		ValueConnection connection = input.connection;
		if (connection != null)
		{
			if (enableDebug)
			{
				IUnitConnectionDebugData elementDebugData = stack.GetElementDebugData<IUnitConnectionDebugData>(connection);
				elementDebugData.lastInvokeFrame = EditorTimeBinding.frame;
				elementDebugData.lastInvokeTime = EditorTimeBinding.time;
			}
			ValueOutput source = connection.source;
			object value2 = GetValue(source);
			if (enableDebug)
			{
				ValueConnection.DebugData elementDebugData2 = stack.GetElementDebugData<ValueConnection.DebugData>(connection);
				elementDebugData2.lastValue = value2;
				elementDebugData2.assignedLastValue = true;
			}
			return value2;
		}
		if (TryGetDefaultValue(input, out var defaultValue))
		{
			return defaultValue;
		}
		throw new MissingValuePortInputException(input.key);
	}

	private object GetValue(ValueOutput output)
	{
		if (locals.TryGetValue(output, out var value))
		{
			return value;
		}
		if (!output.supportsFetch)
		{
			throw new InvalidOperationException($"The value of '{output.key}' on '{output.unit}' cannot be fetched dynamically, it must be assigned.");
		}
		RecursionNode o = new RecursionNode(output, stack);
		try
		{
			recursion?.Enter(o);
		}
		catch (StackOverflowException ex)
		{
			output.unit.HandleException(stack, ex);
			throw;
		}
		try
		{
			if (enableDebug)
			{
				IUnitDebugData elementDebugData = stack.GetElementDebugData<IUnitDebugData>(output.unit);
				elementDebugData.lastInvokeFrame = EditorTimeBinding.frame;
				elementDebugData.lastInvokeTime = EditorTimeBinding.time;
			}
			return GetValueDelegate(output);
		}
		finally
		{
			recursion?.Exit(o);
		}
	}

	public object GetValue(ValueInput input, Type type)
	{
		return ConversionUtility.Convert(GetValue(input), type);
	}

	public T GetValue<T>(ValueInput input)
	{
		return (T)GetValue(input, typeof(T));
	}

	public object GetConvertedValue(ValueInput input)
	{
		return GetValue(input, input.type);
	}

	private object GetDefaultValue(ValueInput input)
	{
		if (!TryGetDefaultValue(input, out var defaultValue))
		{
			throw new InvalidOperationException("Value input port does not have a default value.");
		}
		return defaultValue;
	}

	public bool TryGetDefaultValue(ValueInput input, out object defaultValue)
	{
		if (!input.unit.defaultValues.TryGetValue(input.key, out defaultValue))
		{
			return false;
		}
		if (input.nullMeansSelf && defaultValue == null)
		{
			defaultValue = stack.self;
		}
		return true;
	}

	private object GetValueDelegate(ValueOutput output)
	{
		try
		{
			return output.getValue(this);
		}
		catch (Exception ex)
		{
			output.unit.HandleException(stack, ex);
			throw;
		}
	}

	public static object FetchValue(ValueInput input, GraphReference reference)
	{
		Flow flow = New(reference);
		object value = flow.GetValue(input);
		flow.Dispose();
		return value;
	}

	public static object FetchValue(ValueInput input, Type type, GraphReference reference)
	{
		return ConversionUtility.Convert(FetchValue(input, reference), type);
	}

	public static T FetchValue<T>(ValueInput input, GraphReference reference)
	{
		return (T)FetchValue(input, typeof(T), reference);
	}

	public static bool CanPredict(IUnitValuePort port, GraphReference reference)
	{
		Ensure.That("port").IsNotNull(port);
		Flow flow = New(reference);
		flow.isPrediction = true;
		bool result;
		if (port is ValueInput)
		{
			result = flow.CanPredict((ValueInput)port);
		}
		else
		{
			if (!(port is ValueOutput))
			{
				throw new NotSupportedException();
			}
			result = flow.CanPredict((ValueOutput)port);
		}
		flow.Dispose();
		return result;
	}

	private bool CanPredict(ValueInput input)
	{
		if (!input.hasValidConnection)
		{
			if (!TryGetDefaultValue(input, out var defaultValue))
			{
				return false;
			}
			if (typeof(Component).IsAssignableFrom(input.type))
			{
				defaultValue = defaultValue?.ConvertTo(input.type);
			}
			if (!input.allowsNull && defaultValue == null)
			{
				return false;
			}
			return true;
		}
		ValueOutput output = input.validConnectedPorts.Single();
		if (!CanPredict(output))
		{
			return false;
		}
		object obj = GetValue(output);
		if (!ConversionUtility.CanConvert(obj, input.type, guaranteed: false))
		{
			return false;
		}
		if (typeof(Component).IsAssignableFrom(input.type))
		{
			obj = obj?.ConvertTo(input.type);
		}
		if (!input.allowsNull && obj == null)
		{
			return false;
		}
		return true;
	}

	private bool CanPredict(ValueOutput output)
	{
		if (!output.supportsPrediction)
		{
			return false;
		}
		RecursionNode o = new RecursionNode(output, stack);
		Recursion<RecursionNode> recursion = this.recursion;
		if (recursion != null && !recursion.TryEnter(o))
		{
			return false;
		}
		foreach (IUnitRelation item in output.unit.relations.WithDestination(output))
		{
			if (item.source is ValueInput)
			{
				ValueInput input = (ValueInput)item.source;
				if (!CanPredict(input))
				{
					this.recursion?.Exit(o);
					return false;
				}
			}
		}
		bool result = CanPredictDelegate(output);
		Recursion<RecursionNode> recursion2 = this.recursion;
		if (recursion2 != null)
		{
			recursion2.Exit(o);
			return result;
		}
		return result;
	}

	private bool CanPredictDelegate(ValueOutput output)
	{
		try
		{
			return output.canPredictValue(this);
		}
		catch (Exception arg)
		{
			Debug.LogWarning($"Prediction check failed for '{output.key}' on '{output.unit}':\n{arg}");
			return false;
		}
	}

	public static object Predict(IUnitValuePort port, GraphReference reference)
	{
		Ensure.That("port").IsNotNull(port);
		Flow flow = New(reference);
		flow.isPrediction = true;
		object value;
		if (port is ValueInput)
		{
			value = flow.GetValue((ValueInput)port);
		}
		else
		{
			if (!(port is ValueOutput))
			{
				throw new NotSupportedException();
			}
			value = flow.GetValue((ValueOutput)port);
		}
		flow.Dispose();
		return value;
	}

	public static object Predict(IUnitValuePort port, GraphReference reference, Type type)
	{
		return ConversionUtility.Convert(Predict(port, reference), type);
	}

	public static T Predict<T>(IUnitValuePort port, GraphReference pointer)
	{
		return (T)Predict(port, pointer, typeof(T));
	}
}
