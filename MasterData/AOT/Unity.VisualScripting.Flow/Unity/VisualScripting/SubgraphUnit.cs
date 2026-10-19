using System;
using System.ComponentModel;

namespace Unity.VisualScripting;

[UnitTitle("Subgraph")]
[RenamedFrom("Bolt.SuperUnit")]
[UnitCategory("Nesting")]
[RenamedFrom("Unity.VisualScripting.SuperUnit")]
[TypeIcon(typeof(FlowGraph))]
[DisplayName("Subgraph Node")]
public sealed class SubgraphUnit : NesterUnit<FlowGraph, ScriptGraphAsset>, IGraphEventListener, IGraphElementWithData, IGraphElement, IGraphItem, INotifiedCollectionItem, IDisposable, IPrewarmable, IAotStubbable, IIdentifiable, IAnalyticsIdentifiable
{
	public sealed class Data : IGraphElementData
	{
		public bool isListening;
	}

	public IGraphElementData CreateData()
	{
		return new Data();
	}

	public SubgraphUnit()
	{
	}

	public SubgraphUnit(ScriptGraphAsset macro)
		: base(macro)
	{
	}

	public static SubgraphUnit WithInputOutput()
	{
		SubgraphUnit subgraphUnit = new SubgraphUnit();
		subgraphUnit.nest.source = GraphSource.Embed;
		subgraphUnit.nest.embed = FlowGraph.WithInputOutput();
		return subgraphUnit;
	}

	public static SubgraphUnit WithStartUpdate()
	{
		SubgraphUnit subgraphUnit = new SubgraphUnit();
		subgraphUnit.nest.source = GraphSource.Embed;
		subgraphUnit.nest.embed = FlowGraph.WithStartUpdate();
		return subgraphUnit;
	}

	public override FlowGraph DefaultGraph()
	{
		return FlowGraph.WithInputOutput();
	}

	protected override void Definition()
	{
		isControlRoot = true;
		foreach (IUnitPortDefinition validPortDefinition in nest.graph.validPortDefinitions)
		{
			if (validPortDefinition is ControlInputDefinition)
			{
				ControlInputDefinition controlInputDefinition = (ControlInputDefinition)validPortDefinition;
				string key = controlInputDefinition.key;
				ControlInput(key, (Flow flow) =>
				{
					foreach (IUnit unit in nest.graph.units)
					{
						if (unit is GraphInput)
						{
							GraphInput graphInput = (GraphInput)unit;
							flow.stack.EnterParentElement(this);
							return graphInput.controlOutputs[key];
						}
					}
					return (ControlOutput)null;
				});
			}
			else if (validPortDefinition is ValueInputDefinition)
			{
				ValueInputDefinition valueInputDefinition = (ValueInputDefinition)validPortDefinition;
				string key2 = valueInputDefinition.key;
				Type type = valueInputDefinition.type;
				bool hasDefaultValue = valueInputDefinition.hasDefaultValue;
				object defaultValue = valueInputDefinition.defaultValue;
				ValueInput valueInput = ValueInput(type, key2);
				if (hasDefaultValue)
				{
					valueInput.SetDefaultValue(defaultValue);
				}
			}
			else if (validPortDefinition is ControlOutputDefinition)
			{
				string key3 = ((ControlOutputDefinition)validPortDefinition).key;
				ControlOutput(key3);
			}
			else
			{
				if (!(validPortDefinition is ValueOutputDefinition))
				{
					continue;
				}
				ValueOutputDefinition valueOutputDefinition = (ValueOutputDefinition)validPortDefinition;
				string key4 = valueOutputDefinition.key;
				Type type2 = valueOutputDefinition.type;
				ValueOutput(type2, key4, (Flow flow) =>
				{
					flow.stack.EnterParentElement(this);
					foreach (IUnit unit2 in nest.graph.units)
					{
						if (unit2 is GraphOutput)
						{
							GraphOutput graphOutput = (GraphOutput)unit2;
							object value = flow.GetValue(graphOutput.valueInputs[key4]);
							flow.stack.ExitParentElement();
							return value;
						}
					}
					flow.stack.ExitParentElement();
					throw new InvalidOperationException("Missing output node when to get value.");
				});
			}
		}
	}

	public void StartListening(GraphStack stack)
	{
		if (stack.TryEnterParentElement(this))
		{
			nest.graph.StartListening(stack);
			stack.ExitParentElement();
		}
		stack.GetElementData<Data>(this).isListening = true;
	}

	public void StopListening(GraphStack stack)
	{
		stack.GetElementData<Data>(this).isListening = false;
		if (stack.TryEnterParentElement(this))
		{
			nest.graph.StopListening(stack);
			stack.ExitParentElement();
		}
	}

	public bool IsListening(GraphPointer pointer)
	{
		return pointer.GetElementData<Data>(this).isListening;
	}

	public override void AfterAdd()
	{
		base.AfterAdd();
		nest.beforeGraphChange += StopWatchingPortDefinitions;
		nest.afterGraphChange += StartWatchingPortDefinitions;
		StartWatchingPortDefinitions();
	}

	public override void BeforeRemove()
	{
		base.BeforeRemove();
		StopWatchingPortDefinitions();
		nest.beforeGraphChange -= StopWatchingPortDefinitions;
		nest.afterGraphChange -= StartWatchingPortDefinitions;
	}

	private void StopWatchingPortDefinitions()
	{
		if (nest.graph != null)
		{
			nest.graph.onPortDefinitionsChanged -= Define;
		}
	}

	private void StartWatchingPortDefinitions()
	{
		if (nest.graph != null)
		{
			nest.graph.onPortDefinitionsChanged += Define;
		}
	}
}
