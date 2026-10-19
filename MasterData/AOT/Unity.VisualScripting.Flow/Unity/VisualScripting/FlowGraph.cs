using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using UnityEngine;

namespace Unity.VisualScripting;

[SerializationVersion("A", new Type[] { })]
[DisplayName("Script Graph")]
public sealed class FlowGraph : Graph, IGraphWithVariables, IGraph, IDisposable, IPrewarmable, IAotStubbable, ISerializationDepender, ISerializationCallbackReceiver, IGraphEventListener
{
	private const string DefinitionRemoveWarningTitle = "Remove Port Definition";

	private const string DefinitionRemoveWarningMessage = "Removing this definition will break any existing connection to this port. Are you sure you want to continue?";

	[Serialize]
	public VariableDeclarations variables { get; private set; }

	[DoNotSerialize]
	public GraphElementCollection<IUnit> units { get; private set; }

	[DoNotSerialize]
	public GraphConnectionCollection<ControlConnection, ControlOutput, ControlInput> controlConnections { get; private set; }

	[DoNotSerialize]
	public GraphConnectionCollection<ValueConnection, ValueOutput, ValueInput> valueConnections { get; private set; }

	[DoNotSerialize]
	public GraphConnectionCollection<InvalidConnection, IUnitOutputPort, IUnitInputPort> invalidConnections { get; private set; }

	[DoNotSerialize]
	public GraphElementCollection<GraphGroup> groups { get; private set; }

	[DoNotSerialize]
	public GraphElementCollection<StickyNote> sticky { get; private set; }

	[WarnBeforeRemoving("Remove Port Definition", "Removing this definition will break any existing connection to this port. Are you sure you want to continue?")]
	[InspectorLabel("Trigger Inputs")]
	[Serialize]
	[InspectorWide(true)]
	public UnitPortDefinitionCollection<ControlInputDefinition> controlInputDefinitions { get; private set; }

	[Serialize]
	[InspectorWide(true)]
	[WarnBeforeRemoving("Remove Port Definition", "Removing this definition will break any existing connection to this port. Are you sure you want to continue?")]
	[InspectorLabel("Trigger Outputs")]
	public UnitPortDefinitionCollection<ControlOutputDefinition> controlOutputDefinitions { get; private set; }

	[WarnBeforeRemoving("Remove Port Definition", "Removing this definition will break any existing connection to this port. Are you sure you want to continue?")]
	[InspectorLabel("Data Inputs")]
	[Serialize]
	[InspectorWide(true)]
	public UnitPortDefinitionCollection<ValueInputDefinition> valueInputDefinitions { get; private set; }

	[WarnBeforeRemoving("Remove Port Definition", "Removing this definition will break any existing connection to this port. Are you sure you want to continue?")]
	[InspectorWide(true)]
	[InspectorLabel("Data Outputs")]
	[Serialize]
	public UnitPortDefinitionCollection<ValueOutputDefinition> valueOutputDefinitions { get; private set; }

	public IEnumerable<IUnitPortDefinition> validPortDefinitions => (from upd in LinqUtility.Concat<IUnitPortDefinition>(new IEnumerable[4] { controlInputDefinitions, controlOutputDefinitions, valueInputDefinitions, valueOutputDefinitions })
		where upd.isValid
		select upd).DistinctBy((IUnitPortDefinition upd) => upd.key);

	public event Action onPortDefinitionsChanged;

	public FlowGraph()
	{
		units = new GraphElementCollection<IUnit>(this);
		controlConnections = new GraphConnectionCollection<ControlConnection, ControlOutput, ControlInput>(this);
		valueConnections = new GraphConnectionCollection<ValueConnection, ValueOutput, ValueInput>(this);
		invalidConnections = new GraphConnectionCollection<InvalidConnection, IUnitOutputPort, IUnitInputPort>(this);
		groups = new GraphElementCollection<GraphGroup>(this);
		sticky = new GraphElementCollection<StickyNote>(this);
		elements.Include(units);
		elements.Include(controlConnections);
		elements.Include(valueConnections);
		elements.Include(invalidConnections);
		elements.Include(groups);
		elements.Include(sticky);
		controlInputDefinitions = new UnitPortDefinitionCollection<ControlInputDefinition>();
		controlOutputDefinitions = new UnitPortDefinitionCollection<ControlOutputDefinition>();
		valueInputDefinitions = new UnitPortDefinitionCollection<ValueInputDefinition>();
		valueOutputDefinitions = new UnitPortDefinitionCollection<ValueOutputDefinition>();
		variables = new VariableDeclarations();
	}

	public override IGraphData CreateData()
	{
		return new FlowGraphData(this);
	}

	public void StartListening(GraphStack stack)
	{
		stack.GetGraphData<FlowGraphData>().isListening = true;
		foreach (IUnit unit in units)
		{
			(unit as IGraphEventListener)?.StartListening(stack);
		}
	}

	public void StopListening(GraphStack stack)
	{
		foreach (IUnit unit in units)
		{
			(unit as IGraphEventListener)?.StopListening(stack);
		}
		stack.GetGraphData<FlowGraphData>().isListening = false;
	}

	public bool IsListening(GraphPointer pointer)
	{
		return pointer.GetGraphData<FlowGraphData>().isListening;
	}

	public IEnumerable<string> GetDynamicVariableNames(VariableKind kind, GraphReference reference)
	{
		return from name in (from v in units.OfType<IUnifiedVariableUnit>()
				where v.kind == kind && Flow.CanPredict(v.name, reference)
				select Flow.Predict<string>(v.name, reference) into name
				where !StringUtility.IsNullOrWhiteSpace(name)
				select name).Distinct()
			orderby name
			select name;
	}

	public void PortDefinitionsChanged()
	{
		onPortDefinitionsChanged?.Invoke();
	}

	public static FlowGraph WithInputOutput()
	{
		return new FlowGraph
		{
			units = 
			{
				(IUnit)new GraphInput
				{
					position = new Vector2(-250f, -30f)
				},
				(IUnit)new GraphOutput
				{
					position = new Vector2(105f, -30f)
				}
			}
		};
	}

	public static FlowGraph WithStartUpdate()
	{
		return new FlowGraph
		{
			units = 
			{
				(IUnit)new Start
				{
					position = new Vector2(-204f, -144f)
				},
				(IUnit)new Update
				{
					position = new Vector2(-204f, 60f)
				}
			}
		};
	}
}
