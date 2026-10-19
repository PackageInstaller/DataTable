using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

[SerializationVersion("A", new Type[] { })]
public abstract class Unit : GraphElement<FlowGraph>, IUnit, IGraphElementWithDebugData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public class DebugData : IUnitDebugData, IGraphElementDebugData
	{
		public int lastInvokeFrame { get; set; }

		public float lastInvokeTime { get; set; }

		public Exception runtimeException { get; set; }
	}

	[DoNotSerialize]
	public virtual bool canDefine => true;

	[DoNotSerialize]
	public bool failedToDefine => definitionException != null;

	[DoNotSerialize]
	public bool isDefined { get; private set; }

	[DoNotSerialize]
	public IUnitPortCollection<ControlInput> controlInputs { get; }

	[DoNotSerialize]
	public IUnitPortCollection<ControlOutput> controlOutputs { get; }

	[DoNotSerialize]
	public IUnitPortCollection<ValueInput> valueInputs { get; }

	[DoNotSerialize]
	public IUnitPortCollection<ValueOutput> valueOutputs { get; }

	[DoNotSerialize]
	public IUnitPortCollection<InvalidInput> invalidInputs { get; }

	[DoNotSerialize]
	public IUnitPortCollection<InvalidOutput> invalidOutputs { get; }

	[DoNotSerialize]
	public IEnumerable<IUnitInputPort> inputs => LinqUtility.Concat<IUnitInputPort>(new IEnumerable[3] { controlInputs, valueInputs, invalidInputs });

	[DoNotSerialize]
	public IEnumerable<IUnitOutputPort> outputs => LinqUtility.Concat<IUnitOutputPort>(new IEnumerable[3] { controlOutputs, valueOutputs, invalidOutputs });

	[DoNotSerialize]
	public IEnumerable<IUnitInputPort> validInputs => LinqUtility.Concat<IUnitInputPort>(new IEnumerable[2] { controlInputs, valueInputs });

	[DoNotSerialize]
	public IEnumerable<IUnitOutputPort> validOutputs => LinqUtility.Concat<IUnitOutputPort>(new IEnumerable[2] { controlOutputs, valueOutputs });

	[DoNotSerialize]
	public IEnumerable<IUnitPort> ports => LinqUtility.Concat<IUnitPort>(new IEnumerable[2] { inputs, outputs });

	[DoNotSerialize]
	public IEnumerable<IUnitPort> invalidPorts => LinqUtility.Concat<IUnitPort>(new IEnumerable[2] { invalidInputs, invalidOutputs });

	[DoNotSerialize]
	public IEnumerable<IUnitPort> validPorts => LinqUtility.Concat<IUnitPort>(new IEnumerable[2] { validInputs, validOutputs });

	[Serialize]
	public Dictionary<string, object> defaultValues { get; private set; }

	[DoNotSerialize]
	public IConnectionCollection<IUnitRelation, IUnitPort, IUnitPort> relations { get; private set; }

	[DoNotSerialize]
	public IEnumerable<IUnitConnection> connections => ports.SelectMany((IUnitPort p) => p.connections);

	[DoNotSerialize]
	public virtual bool isControlRoot { get; protected set; }

	[Serialize]
	public Vector2 position { get; set; }

	[DoNotSerialize]
	public Exception definitionException { get; protected set; }

	public event Action onPortsChanged;

	protected Unit()
	{
		controlInputs = new UnitPortCollection<ControlInput>(this);
		controlOutputs = new UnitPortCollection<ControlOutput>(this);
		valueInputs = new UnitPortCollection<ValueInput>(this);
		valueOutputs = new UnitPortCollection<ValueOutput>(this);
		invalidInputs = new UnitPortCollection<InvalidInput>(this);
		invalidOutputs = new UnitPortCollection<InvalidOutput>(this);
		relations = new ConnectionCollection<IUnitRelation, IUnitPort, IUnitPort>();
		defaultValues = new Dictionary<string, object>();
	}

	public virtual IGraphElementDebugData CreateDebugData()
	{
		return new DebugData();
	}

	public override void AfterAdd()
	{
		Define();
		base.AfterAdd();
	}

	public override void BeforeRemove()
	{
		base.BeforeRemove();
		Disconnect();
	}

	public override void Instantiate(GraphReference instance)
	{
		base.Instantiate(instance);
		if (this is IGraphEventListener listener && XGraphEventListener.IsHierarchyListening(instance))
		{
			listener.StartListening(instance);
		}
	}

	public override void Uninstantiate(GraphReference instance)
	{
		if (this is IGraphEventListener listener)
		{
			listener.StopListening(instance);
		}
		base.Uninstantiate(instance);
	}

	protected void CopyFrom(Unit source)
	{
		CopyFrom((GraphElement<FlowGraph>)source);
		defaultValues = source.defaultValues;
	}

	protected abstract void Definition();

	protected virtual void AfterDefine()
	{
	}

	protected virtual void BeforeUndefine()
	{
	}

	private void Undefine()
	{
		if (isDefined)
		{
			BeforeUndefine();
		}
		Disconnect();
		defaultValues.Clear();
		controlInputs.Clear();
		controlOutputs.Clear();
		valueInputs.Clear();
		valueOutputs.Clear();
		invalidInputs.Clear();
		invalidOutputs.Clear();
		relations.Clear();
		isDefined = false;
	}

	public void EnsureDefined()
	{
		if (!isDefined)
		{
			Define();
		}
	}

	public void Define()
	{
		UnitPreservation unitPreservation = UnitPreservation.Preserve(this);
		Undefine();
		if (canDefine)
		{
			try
			{
				Definition();
				isDefined = true;
				definitionException = null;
				AfterDefine();
			}
			catch (Exception arg)
			{
				Undefine();
				definitionException = arg;
				Debug.LogWarning($"Failed to define {this}:\n{arg}");
			}
		}
		unitPreservation.RestoreTo(this);
	}

	public void RemoveUnconnectedInvalidPorts()
	{
		InvalidInput[] array = invalidInputs.Where((InvalidInput p) => !p.hasAnyConnection).ToArray();
		foreach (InvalidInput item in array)
		{
			invalidInputs.Remove(item);
		}
		InvalidOutput[] array2 = invalidOutputs.Where((InvalidOutput p) => !p.hasAnyConnection).ToArray();
		foreach (InvalidOutput item2 in array2)
		{
			invalidOutputs.Remove(item2);
		}
	}

	public void PortsChanged()
	{
		onPortsChanged?.Invoke();
	}

	public void Disconnect()
	{
		while (ports.Any((IUnitPort p) => p.hasAnyConnection))
		{
			ports.First((IUnitPort p) => p.hasAnyConnection).Disconnect();
		}
	}

	protected void EnsureUniqueInput(string key)
	{
		if (controlInputs.Contains(key) || valueInputs.Contains(key) || invalidInputs.Contains(key))
		{
			throw new ArgumentException($"Duplicate input for '{key}' in {GetType()}.");
		}
	}

	protected void EnsureUniqueOutput(string key)
	{
		if (controlOutputs.Contains(key) || valueOutputs.Contains(key) || invalidOutputs.Contains(key))
		{
			throw new ArgumentException($"Duplicate output for '{key}' in {GetType()}.");
		}
	}

	protected ControlInput ControlInput(string key, Func<Flow, ControlOutput> action)
	{
		EnsureUniqueInput(key);
		ControlInput controlInput = new ControlInput(key, action);
		controlInputs.Add(controlInput);
		return controlInput;
	}

	protected ControlInput ControlInputCoroutine(string key, Func<Flow, IEnumerator> coroutineAction)
	{
		EnsureUniqueInput(key);
		ControlInput controlInput = new ControlInput(key, coroutineAction);
		controlInputs.Add(controlInput);
		return controlInput;
	}

	protected ControlInput ControlInputCoroutine(string key, Func<Flow, ControlOutput> action, Func<Flow, IEnumerator> coroutineAction)
	{
		EnsureUniqueInput(key);
		ControlInput controlInput = new ControlInput(key, action, coroutineAction);
		controlInputs.Add(controlInput);
		return controlInput;
	}

	protected ControlOutput ControlOutput(string key)
	{
		EnsureUniqueOutput(key);
		ControlOutput controlOutput = new ControlOutput(key);
		controlOutputs.Add(controlOutput);
		return controlOutput;
	}

	protected ValueInput ValueInput(Type type, string key)
	{
		EnsureUniqueInput(key);
		ValueInput valueInput = new ValueInput(key, type);
		valueInputs.Add(valueInput);
		return valueInput;
	}

	protected ValueInput ValueInput<T>(string key)
	{
		return ValueInput(typeof(T), key);
	}

	protected ValueInput ValueInput<T>(string key, T @default)
	{
		ValueInput valueInput = ValueInput<T>(key);
		valueInput.SetDefaultValue(@default);
		return valueInput;
	}

	protected ValueOutput ValueOutput(Type type, string key)
	{
		EnsureUniqueOutput(key);
		ValueOutput valueOutput = new ValueOutput(key, type);
		valueOutputs.Add(valueOutput);
		return valueOutput;
	}

	protected ValueOutput ValueOutput(Type type, string key, Func<Flow, object> getValue)
	{
		EnsureUniqueOutput(key);
		ValueOutput valueOutput = new ValueOutput(key, type, getValue);
		valueOutputs.Add(valueOutput);
		return valueOutput;
	}

	protected ValueOutput ValueOutput<T>(string key)
	{
		return ValueOutput(typeof(T), key);
	}

	protected ValueOutput ValueOutput<T>(string key, Func<Flow, T> getValue)
	{
		return ValueOutput(typeof(T), key, (Flow recursion) => getValue(recursion));
	}

	private void Relation(IUnitPort source, IUnitPort destination)
	{
		relations.Add(new UnitRelation(source, destination));
	}

	protected void Requirement(ValueInput source, ControlInput destination)
	{
		Relation(source, destination);
	}

	protected void Requirement(ValueInput source, ValueOutput destination)
	{
		Relation(source, destination);
	}

	protected void Assignment(ControlInput source, ValueOutput destination)
	{
		Relation(source, destination);
	}

	protected void Succession(ControlInput source, ControlOutput destination)
	{
		Relation(source, destination);
	}

	public override AnalyticsIdentifier GetAnalyticsIdentifier()
	{
		AnalyticsIdentifier analyticsIdentifier = new AnalyticsIdentifier
		{
			Identifier = GetType().FullName,
			Namespace = GetType().Namespace
		};
		analyticsIdentifier.Hashcode = analyticsIdentifier.Identifier.GetHashCode();
		return analyticsIdentifier;
	}

	FlowGraph IUnit.get_graph()
	{
		return graph;
	}
}
